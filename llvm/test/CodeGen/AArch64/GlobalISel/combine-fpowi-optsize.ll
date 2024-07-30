; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-unknown-unknown | FileCheck %s
; RUN: llc < %s -mtriple=aarch64-unknown-unknown -global-isel | FileCheck %s

define double @pow_optsize(double %x) nounwind optsize {
; CHECK-LABEL: pow_optsize:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov w0, #15 // =0xf
; CHECK-NEXT:    b __powidf2
entry:
  %0 = call double @llvm.powi.f64.i32(double %x, i32 15)
  ret double %0
}

define double @pow_optsize_expand(double %x) nounwind optsize {
; CHECK-LABEL: pow_optsize_expand:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    fmul d0, d0, d0
; CHECK-NEXT:    ret
entry:
  %0 = call double @llvm.powi.f64.i32(double %x, i32 16)
  ret double %0
}
