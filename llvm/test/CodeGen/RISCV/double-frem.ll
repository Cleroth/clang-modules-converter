; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IFD %s
; RUN: llc -mtriple=riscv64 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IFD %s
; RUN: llc -mtriple=riscv32 -mattr=+zdinx -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IZFINXZDINX %s
; RUN: llc -mtriple=riscv64 -mattr=+zdinx -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IZFINXZDINX %s

define double @frem_f64(double %a, double %b) nounwind {
; RV32IFD-LABEL: frem_f64:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    tail fmod
;
; RV64IFD-LABEL: frem_f64:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    tail fmod
;
; RV32IZFINXZDINX-LABEL: frem_f64:
; RV32IZFINXZDINX:       # %bb.0:
; RV32IZFINXZDINX-NEXT:    addi sp, sp, -16
; RV32IZFINXZDINX-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IZFINXZDINX-NEXT:    call fmod
; RV32IZFINXZDINX-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IZFINXZDINX-NEXT:    addi sp, sp, 16
; RV32IZFINXZDINX-NEXT:    ret
;
; RV64IZFINXZDINX-LABEL: frem_f64:
; RV64IZFINXZDINX:       # %bb.0:
; RV64IZFINXZDINX-NEXT:    tail fmod
  %1 = frem double %a, %b
  ret double %1
}
