; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+v,+zvkg \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+v,+zvkg \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK

declare <vscale x 1 x i32> @llvm.riscv.vghsh.nxv1i32.nxv1i32(
  <vscale x 1 x i32>,
  <vscale x 1 x i32>,
  <vscale x 1 x i32>,
  iXLen,
  iXLen)

define <vscale x 1 x i32> @intrinsic_vghsh_vv_nxv1i32_nxv1i32(<vscale x 1 x i32> %0, <vscale x 1 x i32> %1, <vscale x 1 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vghsh_vv_nxv1i32_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, tu, ma
; CHECK-NEXT:    vghsh.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vghsh.nxv1i32.nxv1i32(
    <vscale x 1 x i32> %0,
    <vscale x 1 x i32> %1,
    <vscale x 1 x i32> %2,
    iXLen %3,
    iXLen 2)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vghsh.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  iXLen,
  iXLen)

define <vscale x 2 x i32> @intrinsic_vghsh_vv_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32> %1, <vscale x 2 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vghsh_vv_nxv2i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, tu, ma
; CHECK-NEXT:    vghsh.vv v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vghsh.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i32> %2,
    iXLen %3,
    iXLen 2)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vghsh.nxv4i32.nxv4i32(
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  <vscale x 4 x i32>,
  iXLen,
  iXLen)

define <vscale x 4 x i32> @intrinsic_vghsh_vv_nxv4i32_nxv4i32(<vscale x 4 x i32> %0, <vscale x 4 x i32> %1, <vscale x 4 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vghsh_vv_nxv4i32_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, tu, ma
; CHECK-NEXT:    vghsh.vv v8, v10, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vghsh.nxv4i32.nxv4i32(
    <vscale x 4 x i32> %0,
    <vscale x 4 x i32> %1,
    <vscale x 4 x i32> %2,
    iXLen %3,
    iXLen 2)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vghsh.nxv8i32.nxv8i32(
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  <vscale x 8 x i32>,
  iXLen,
  iXLen)

define <vscale x 8 x i32> @intrinsic_vghsh_vv_nxv8i32_nxv8i32(<vscale x 8 x i32> %0, <vscale x 8 x i32> %1, <vscale x 8 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vghsh_vv_nxv8i32_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, tu, ma
; CHECK-NEXT:    vghsh.vv v8, v12, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vghsh.nxv8i32.nxv8i32(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i32> %1,
    <vscale x 8 x i32> %2,
    iXLen %3,
    iXLen 2)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vghsh.nxv16i32.nxv16i32(
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  <vscale x 16 x i32>,
  iXLen,
  iXLen)

define <vscale x 16 x i32> @intrinsic_vghsh_vv_nxv16i32_nxv16i32(<vscale x 16 x i32> %0, <vscale x 16 x i32> %1, <vscale x 16 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vghsh_vv_nxv16i32_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl8re32.v v24, (a0)
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, tu, ma
; CHECK-NEXT:    vghsh.vv v8, v16, v24
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vghsh.nxv16i32.nxv16i32(
    <vscale x 16 x i32> %0,
    <vscale x 16 x i32> %1,
    <vscale x 16 x i32> %2,
    iXLen %3,
    iXLen 2)

  ret <vscale x 16 x i32> %a
}
