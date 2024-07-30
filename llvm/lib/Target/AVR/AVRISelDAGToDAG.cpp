//===-- AVRISelDAGToDAG.cpp - A dag to dag inst selector for AVR ----------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines an instruction selector for the AVR target.
//
//===----------------------------------------------------------------------===//

#include "AVR.h"
#include "AVRTargetMachine.h"
#include "MCTargetDesc/AVRMCTargetDesc.h"

#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/SelectionDAGISel.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

#define DEBUG_TYPE "avr-isel"
#define PASS_NAME "AVR DAG->DAG Instruction Selection"

using namespace llvm;

namespace {

/// Lowers LLVM IR (in DAG form) to AVR MC instructions (in DAG form).
class AVRDAGToDAGISel : public SelectionDAGISel {
public:
  AVRDAGToDAGISel() = delete;

  AVRDAGToDAGISel(AVRTargetMachine &TM, CodeGenOptLevel OptLevel)
      : SelectionDAGISel(TM, OptLevel), Subtarget(nullptr) {}

  bool runOnMachineFunction(MachineFunction &MF) override;

  bool SelectAddr(SDNode *Op, SDValue N, SDValue &Base, SDValue &Disp);

  bool selectIndexedLoad(SDNode *N);
  unsigned selectIndexedProgMemLoad(const LoadSDNode *LD, MVT VT, int Bank);

  bool SelectInlineAsmMemoryOperand(const SDValue &Op,
                                    InlineAsm::ConstraintCode ConstraintCode,
                                    std::vector<SDValue> &OutOps) override;

// Include the pieces autogenerated from the target description.
#include "AVRGenDAGISel.inc"

private:
  void Select(SDNode *N) override;
  bool trySelect(SDNode *N);

  template <unsigned NodeType> bool select(SDNode *N);
  bool selectMultiplication(SDNode *N);

  const AVRSubtarget *Subtarget;
};

class AVRDAGToDAGISelLegacy : public SelectionDAGISelLegacy {
public:
  static char ID;
  AVRDAGToDAGISelLegacy(AVRTargetMachine &TM, CodeGenOptLevel OptLevel)
      : SelectionDAGISelLegacy(
            ID, std::make_unique<AVRDAGToDAGISel>(TM, OptLevel)) {}
};

} // namespace

char AVRDAGToDAGISelLegacy::ID = 0;

INITIALIZE_PASS(AVRDAGToDAGISelLegacy, DEBUG_TYPE, PASS_NAME, false, false)

bool AVRDAGToDAGISel::runOnMachineFunction(MachineFunction &MF) {
  Subtarget = &MF.getSubtarget<AVRSubtarget>();
  return SelectionDAGISel::runOnMachineFunction(MF);
}

bool AVRDAGToDAGISel::SelectAddr(SDNode *Op, SDValue N, SDValue &Base,
                                 SDValue &Disp) {
  SDLoc dl(Op);
  auto DL = CurDAG->getDataLayout();
  MVT PtrVT = getTargetLowering()->getPointerTy(DL);

  // if the address is a frame index get the TargetFrameIndex.
  if (const FrameIndexSDNode *FIN = dyn_cast<FrameIndexSDNode>(N)) {
    Base = CurDAG->getTargetFrameIndex(FIN->getIndex(), PtrVT);
    Disp = CurDAG->getTargetConstant(0, dl, MVT::i8);

    return true;
  }

  // Match simple Reg + uimm6 operands.
  if (N.getOpcode() != ISD::ADD && N.getOpcode() != ISD::SUB &&
      !CurDAG->isBaseWithConstantOffset(N)) {
    return false;
  }

  if (const ConstantSDNode *RHS = dyn_cast<ConstantSDNode>(N.getOperand(1))) {
    int RHSC = (int)RHS->getZExtValue();

    // Convert negative offsets into positives ones.
    if (N.getOpcode() == ISD::SUB) {
      RHSC = -RHSC;
    }

    // <#Frame index + const>
    // Allow folding offsets bigger than 63 so the frame pointer can be used
    // directly instead of copying it around by adjusting and restoring it for
    // each access.
    if (N.getOperand(0).getOpcode() == ISD::FrameIndex) {
      int FI = cast<FrameIndexSDNode>(N.getOperand(0))->getIndex();

      Base = CurDAG->getTargetFrameIndex(FI, PtrVT);
      Disp = CurDAG->getTargetConstant(RHSC, dl, MVT::i16);

      return true;
    }

    // The value type of the memory instruction determines what is the maximum
    // offset allowed.
    MVT VT = cast<MemSDNode>(Op)->getMemoryVT().getSimpleVT();

    // We only accept offsets that fit in 6 bits (unsigned).
    if (isUInt<6>(RHSC) && (VT == MVT::i8 || VT == MVT::i16)) {
      Base = N.getOperand(0);
      Disp = CurDAG->getTargetConstant(RHSC, dl, MVT::i8);

      return true;
    }
  }

  return false;
}

bool AVRDAGToDAGISel::selectIndexedLoad(SDNode *N) {
  const LoadSDNode *LD = cast<LoadSDNode>(N);
  ISD::MemIndexedMode AM = LD->getAddressingMode();
  MVT VT = LD->getMemoryVT().getSimpleVT();
  auto PtrVT = getTargetLowering()->getPointerTy(CurDAG->getDataLayout());

  // We only care if this load uses a POSTINC or PREDEC mode.
  if ((LD->getExtensionType() != ISD::NON_EXTLOAD) ||
      (AM != ISD::POST_INC && AM != ISD::PRE_DEC)) {

    return false;
  }

  unsigned Opcode = 0;
  bool isPre = (AM == ISD::PRE_DEC);
  int Offs = cast<ConstantSDNode>(LD->getOffset())->getSExtValue();

  switch (VT.SimpleTy) {
  case MVT::i8: {
    if ((!isPre && Offs != 1) || (isPre && Offs != -1)) {
      return false;
    }

    Opcode = (isPre) ? AVR::LDRdPtrPd : AVR::LDRdPtrPi;
    break;
  }
  case MVT::i16: {
    if ((!isPre && Offs != 2) || (isPre && Offs != -2)) {
      return false;
    }

    Opcode = (isPre) ? AVR::LDWRdPtrPd : AVR::LDWRdPtrPi;
    break;
  }
  default:
    return false;
  }

  SDNode *ResNode =
      CurDAG->getMachineNode(Opcode, SDLoc(N), VT, PtrVT, MVT::Other,
                             LD->getBasePtr(), LD->getChain());
  ReplaceUses(N, ResNode);
  CurDAG->RemoveDeadNode(N);

  return true;
}

unsigned AVRDAGToDAGISel::selectIndexedProgMemLoad(const LoadSDNode *LD, MVT VT,
                                                   int Bank) {
  // Progmem indexed loads only work in POSTINC mode.
  if (LD->getExtensionType() != ISD::NON_EXTLOAD ||
      LD->getAddressingMode() != ISD::POST_INC)
    return 0;

  // Feature ELPM is needed for loading from extended program memory.
  assert((Bank == 0 || Subtarget->hasELPM()) &&
         "cannot load from extended program memory on this mcu");

  unsigned Opcode = 0;
  int Offs = cast<ConstantSDNode>(LD->getOffset())->getSExtValue();

  if (VT.SimpleTy == MVT::i8 && Offs == 1 && Bank == 0)
    Opcode = AVR::LPMRdZPi;

  // TODO: Implements the expansion of the following pseudo instructions.
  // LPMWRdZPi:  type == MVT::i16, offset == 2, Bank == 0.
  // ELPMBRdZPi: type == MVT::i8,  offset == 1, Bank >  0.
  // ELPMWRdZPi: type == MVT::i16, offset == 2, Bank >  0.

  return Opcode;
}

bool AVRDAGToDAGISel::SelectInlineAsmMemoryOperand(
    const SDValue &Op, InlineAsm::ConstraintCode ConstraintCode,
    std::vector<SDValue> &OutOps) {
  assert((ConstraintCode == InlineAsm::ConstraintCode::m ||
          ConstraintCode == InlineAsm::ConstraintCode::Q) &&
         "Unexpected asm memory constraint");

  MachineRegisterInfo &RI = MF->getRegInfo();
  const AVRSubtarget &STI = MF->getSubtarget<AVRSubtarget>();
  const TargetLowering &TL = *STI.getTargetLowering();
  SDLoc dl(Op);
  auto DL = CurDAG->getDataLayout();

  const RegisterSDNode *RegNode = dyn_cast<RegisterSDNode>(Op);

  // If address operand is of PTRDISPREGS class, all is OK, then.
  if (RegNode &&
      RI.getRegClass(RegNode->getReg()) == &AVR::PTRDISPREGSRegClass) {
    OutOps.push_back(Op);
    return false;
  }

  if (Op->getOpcode() == ISD::FrameIndex) {
    SDValue Base, Disp;

    if (SelectAddr(Op.getNode(), Op, Base, Disp)) {
      OutOps.push_back(Base);
      OutOps.push_back(Disp);

      return false;
    }

    return true;
  }

  // If Op is add 'register, immediate' and
  // register is either virtual register or register of PTRDISPREGSRegClass
  if (Op->getOpcode() == ISD::ADD || Op->getOpcode() == ISD::SUB) {
    SDValue CopyFromRegOp = Op->getOperand(0);
    SDValue ImmOp = Op->getOperand(1);
    ConstantSDNode *ImmNode = dyn_cast<ConstantSDNode>(ImmOp);

    unsigned Reg;
    bool CanHandleRegImmOpt = ImmNode && ImmNode->getAPIntValue().ult(64);

    if (CopyFromRegOp->getOpcode() == ISD::CopyFromReg) {
      RegisterSDNode *RegNode =
          cast<RegisterSDNode>(CopyFromRegOp->getOperand(1));
      Reg = RegNode->getReg();
      CanHandleRegImmOpt &= (Register::isVirtualRegister(Reg) ||
                             AVR::PTRDISPREGSRegClass.contains(Reg));
    } else {
      CanHandleRegImmOpt = false;
    }

    // If we detect proper case - correct virtual register class
    // if needed and go to another inlineasm operand.
    if (CanHandleRegImmOpt) {
      SDValue Base, Disp;

      if (RI.getRegClass(Reg) != &AVR::PTRDISPREGSRegClass) {
        SDLoc dl(CopyFromRegOp);

        Register VReg = RI.createVirtualRegister(&AVR::PTRDISPREGSRegClass);

        SDValue CopyToReg =
            CurDAG->getCopyToReg(CopyFromRegOp, dl, VReg, CopyFromRegOp);

        SDValue NewCopyFromRegOp =
            CurDAG->getCopyFromReg(CopyToReg, dl, VReg, TL.getPointerTy(DL));

        Base = NewCopyFromRegOp;
      } else {
        Base = CopyFromRegOp;
      }

      if (ImmNode->getValueType(0) != MVT::i8) {
        Disp = CurDAG->getTargetConstant(ImmNode->getZExtValue(), dl, MVT::i8);
      } else {
        Disp = ImmOp;
      }

      OutOps.push_back(Base);
      OutOps.push_back(Disp);

      return false;
    }
  }

  // More generic case.
  // Create chain that puts Op into pointer register
  // and return that register.
  Register VReg = RI.createVirtualRegister(&AVR::PTRDISPREGSRegClass);

  SDValue CopyToReg = CurDAG->getCopyToReg(Op, dl, VReg, Op);
  SDValue CopyFromReg =
      CurDAG->getCopyFromReg(CopyToReg, dl, VReg, TL.getPointerTy(DL));

  OutOps.push_back(CopyFromReg);

  return false;
}

template <> bool AVRDAGToDAGISel::select<ISD::FrameIndex>(SDNode *N) {
  auto DL = CurDAG->getDataLayout();

  // Convert the frameindex into a temp instruction that will hold the
  // effective address of the final stack slot.
  int FI = cast<FrameIndexSDNode>(N)->getIndex();
  SDValue TFI =
      CurDAG->getTargetFrameIndex(FI, getTargetLowering()->getPointerTy(DL));

  CurDAG->SelectNodeTo(N, AVR::FRMIDX, getTargetLowering()->getPointerTy(DL),
                       TFI, CurDAG->getTargetConstant(0, SDLoc(N), MVT::i16));
  return true;
}

template <> bool AVRDAGToDAGISel::select<ISD::STORE>(SDNode *N) {
  // Use the STD{W}SPQRr pseudo instruction when passing arguments through
  // the stack on function calls for further expansion during the PEI phase.
  const StoreSDNode *ST = cast<StoreSDNode>(N);
  SDValue BasePtr = ST->getBasePtr();

  // Early exit when the base pointer is a frame index node or a constant.
  if (isa<FrameIndexSDNode>(BasePtr) || isa<ConstantSDNode>(BasePtr) ||
      BasePtr.isUndef()) {
    return false;
  }

  const RegisterSDNode *RN = dyn_cast<RegisterSDNode>(BasePtr.getOperand(0));
  // Only stores where SP is the base pointer are valid.
  if (!RN || (RN->getReg() != AVR::SP)) {
    return false;
  }

  int CST = (int)BasePtr.getConstantOperandVal(1);
  SDValue Chain = ST->getChain();
  EVT VT = ST->getValue().getValueType();
  SDLoc DL(N);
  SDValue Offset = CurDAG->getTargetConstant(CST, DL, MVT::i16);
  SDValue Ops[] = {BasePtr.getOperand(0), Offset, ST->getValue(), Chain};
  unsigned Opc = (VT == MVT::i16) ? AVR::STDWSPQRr : AVR::STDSPQRr;

  SDNode *ResNode = CurDAG->getMachineNode(Opc, DL, MVT::Other, Ops);

  // Transfer memory operands.
  CurDAG->setNodeMemRefs(cast<MachineSDNode>(ResNode), {ST->getMemOperand()});

  ReplaceUses(SDValue(N, 0), SDValue(ResNode, 0));
  CurDAG->RemoveDeadNode(N);

  return true;
}

template <> bool AVRDAGToDAGISel::select<ISD::LOAD>(SDNode *N) {
  const LoadSDNode *LD = cast<LoadSDNode>(N);
  if (!AVR::isProgramMemoryAccess(LD)) {
    // Check if the opcode can be converted into an indexed load.
    return selectIndexedLoad(N);
  }

  if (!Subtarget->hasLPM())
    report_fatal_error("cannot load from program memory on this mcu");

  int ProgMemBank = AVR::getProgramMemoryBank(LD);
  if (ProgMemBank < 0 || ProgMemBank > 5)
    report_fatal_error("unexpected program memory bank");
  if (ProgMemBank > 0 && !Subtarget->hasELPM())
    report_fatal_error("unexpected program memory bank");

  // This is a flash memory load, move the pointer into R31R30 and emit
  // the lpm instruction.
  MVT VT = LD->getMemoryVT().getSimpleVT();
  SDValue Chain = LD->getChain();
  SDValue Ptr = LD->getBasePtr();
  SDNode *ResNode;
  SDLoc DL(N);

  Chain = CurDAG->getCopyToReg(Chain, DL, AVR::R31R30, Ptr, SDValue());
  Ptr = CurDAG->getCopyFromReg(Chain, DL, AVR::R31R30, MVT::i16,
                               Chain.getValue(1));

  // Check if the opcode can be converted into an indexed load.
  if (unsigned LPMOpc = selectIndexedProgMemLoad(LD, VT, ProgMemBank)) {
    // It is legal to fold the load into an indexed load.
    if (ProgMemBank == 0) {
      ResNode =
          CurDAG->getMachineNode(LPMOpc, DL, VT, MVT::i16, MVT::Other, Ptr);
    } else {
      // Do not combine the LDI instruction into the ELPM pseudo instruction,
      // since it may be reused by other ELPM pseudo instructions.
      SDValue NC = CurDAG->getTargetConstant(ProgMemBank, DL, MVT::i8);
      auto *NP = CurDAG->getMachineNode(AVR::LDIRdK, DL, MVT::i8, NC);
      ResNode = CurDAG->getMachineNode(LPMOpc, DL, VT, MVT::i16, MVT::Other,
                                       Ptr, SDValue(NP, 0));
    }
  } else {
    // Selecting an indexed load is not legal, fallback to a normal load.
    switch (VT.SimpleTy) {
    case MVT::i8:
      if (ProgMemBank == 0) {
        unsigned Opc = Subtarget->hasLPMX() ? AVR::LPMRdZ : AVR::LPMBRdZ;
        ResNode =
            CurDAG->getMachineNode(Opc, DL, MVT::i8, MVT::Other, Ptr);
      } else {
        // Do not combine the LDI instruction into the ELPM pseudo instruction,
        // since it may be reused by other ELPM pseudo instructions.
        SDValue NC = CurDAG->getTargetConstant(ProgMemBank, DL, MVT::i8);
        auto *NP = CurDAG->getMachineNode(AVR::LDIRdK, DL, MVT::i8, NC);
        ResNode = CurDAG->getMachineNode(AVR::ELPMBRdZ, DL, MVT::i8, MVT::Other,
                                         Ptr, SDValue(NP, 0));
      }
      break;
    case MVT::i16:
      if (ProgMemBank == 0) {
        ResNode =
            CurDAG->getMachineNode(AVR::LPMWRdZ, DL, MVT::i16, MVT::Other, Ptr);
      } else {
        // Do not combine the LDI instruction into the ELPM pseudo instruction,
        // since LDI requires the destination register in range R16~R31.
        SDValue NC = CurDAG->getTargetConstant(ProgMemBank, DL, MVT::i8);
        auto *NP = CurDAG->getMachineNode(AVR::LDIRdK, DL, MVT::i8, NC);
        ResNode = CurDAG->getMachineNode(AVR::ELPMWRdZ, DL, MVT::i16,
                                         MVT::Other, Ptr, SDValue(NP, 0));
      }
      break;
    default:
      llvm_unreachable("Unsupported VT!");
    }
  }

  // Transfer memory operands.
  CurDAG->setNodeMemRefs(cast<MachineSDNode>(ResNode), {LD->getMemOperand()});

  ReplaceUses(SDValue(N, 0), SDValue(ResNode, 0));
  ReplaceUses(SDValue(N, 1), SDValue(ResNode, 1));
  CurDAG->RemoveDeadNode(N);

  return true;
}

template <> bool AVRDAGToDAGISel::select<AVRISD::CALL>(SDNode *N) {
  SDValue InGlue;
  SDValue Chain = N->getOperand(0);
  SDValue Callee = N->getOperand(1);
  unsigned LastOpNum = N->getNumOperands() - 1;

  // Direct calls are autogenerated.
  unsigned Op = Callee.getOpcode();
  if (Op == ISD::TargetGlobalAddress || Op == ISD::TargetExternalSymbol) {
    return false;
  }

  // Skip the incoming flag if present
  if (N->getOperand(LastOpNum).getValueType() == MVT::Glue) {
    --LastOpNum;
  }

  SDLoc DL(N);
  Chain = CurDAG->getCopyToReg(Chain, DL, AVR::R31R30, Callee, InGlue);
  SmallVector<SDValue, 8> Ops;
  Ops.push_back(CurDAG->getRegister(AVR::R31R30, MVT::i16));

  // Map all operands into the new node.
  for (unsigned i = 2, e = LastOpNum + 1; i != e; ++i) {
    Ops.push_back(N->getOperand(i));
  }

  Ops.push_back(Chain);
  Ops.push_back(Chain.getValue(1));

  SDNode *ResNode = CurDAG->getMachineNode(
      Subtarget->hasEIJMPCALL() ? AVR::EICALL : AVR::ICALL, DL, MVT::Other,
      MVT::Glue, Ops);

  ReplaceUses(SDValue(N, 0), SDValue(ResNode, 0));
  ReplaceUses(SDValue(N, 1), SDValue(ResNode, 1));
  CurDAG->RemoveDeadNode(N);

  return true;
}

template <> bool AVRDAGToDAGISel::select<ISD::BRIND>(SDNode *N) {
  SDValue Chain = N->getOperand(0);
  SDValue JmpAddr = N->getOperand(1);

  SDLoc DL(N);
  // Move the destination address of the indirect branch into R31R30.
  Chain = CurDAG->getCopyToReg(Chain, DL, AVR::R31R30, JmpAddr);
  SDNode *ResNode = CurDAG->getMachineNode(AVR::IJMP, DL, MVT::Other, Chain);

  ReplaceUses(SDValue(N, 0), SDValue(ResNode, 0));
  CurDAG->RemoveDeadNode(N);

  return true;
}

bool AVRDAGToDAGISel::selectMultiplication(llvm::SDNode *N) {
  SDLoc DL(N);
  MVT Type = N->getSimpleValueType(0);

  assert(Type == MVT::i8 && "unexpected value type");

  bool isSigned = N->getOpcode() == ISD::SMUL_LOHI;
  unsigned MachineOp = isSigned ? AVR::MULSRdRr : AVR::MULRdRr;

  SDValue Lhs = N->getOperand(0);
  SDValue Rhs = N->getOperand(1);
  SDNode *Mul = CurDAG->getMachineNode(MachineOp, DL, MVT::Glue, Lhs, Rhs);
  SDValue InChain = CurDAG->getEntryNode();
  SDValue InGlue = SDValue(Mul, 0);

  // Copy the low half of the result, if it is needed.
  if (N->hasAnyUseOfValue(0)) {
    SDValue CopyFromLo =
        CurDAG->getCopyFromReg(InChain, DL, AVR::R0, Type, InGlue);

    ReplaceUses(SDValue(N, 0), CopyFromLo);

    InChain = CopyFromLo.getValue(1);
    InGlue = CopyFromLo.getValue(2);
  }

  // Copy the high half of the result, if it is needed.
  if (N->hasAnyUseOfValue(1)) {
    SDValue CopyFromHi =
        CurDAG->getCopyFromReg(InChain, DL, AVR::R1, Type, InGlue);

    ReplaceUses(SDValue(N, 1), CopyFromHi);

    InChain = CopyFromHi.getValue(1);
    InGlue = CopyFromHi.getValue(2);
  }

  CurDAG->RemoveDeadNode(N);

  // We need to clear R1. This is currently done (dirtily)
  // using a custom inserter.

  return true;
}

void AVRDAGToDAGISel::Select(SDNode *N) {
  // If we have a custom node, we already have selected!
  if (N->isMachineOpcode()) {
    LLVM_DEBUG(errs() << "== "; N->dump(CurDAG); errs() << "\n");
    N->setNodeId(-1);
    return;
  }

  // See if subclasses can handle this node.
  if (trySelect(N))
    return;

  // Select the default instruction
  SelectCode(N);
}

bool AVRDAGToDAGISel::trySelect(SDNode *N) {
  unsigned Opcode = N->getOpcode();
  SDLoc DL(N);

  switch (Opcode) {
  // Nodes we fully handle.
  case ISD::FrameIndex:
    return select<ISD::FrameIndex>(N);
  case ISD::BRIND:
    return select<ISD::BRIND>(N);
  case ISD::UMUL_LOHI:
  case ISD::SMUL_LOHI:
    return selectMultiplication(N);

  // Nodes we handle partially. Other cases are autogenerated
  case ISD::STORE:
    return select<ISD::STORE>(N);
  case ISD::LOAD:
    return select<ISD::LOAD>(N);
  case AVRISD::CALL:
    return select<AVRISD::CALL>(N);
  default:
    return false;
  }
}

FunctionPass *llvm::createAVRISelDag(AVRTargetMachine &TM,
                                     CodeGenOptLevel OptLevel) {
  return new AVRDAGToDAGISelLegacy(TM, OptLevel);
}
