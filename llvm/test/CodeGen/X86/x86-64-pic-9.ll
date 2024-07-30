; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-pc-linux -relocation-model=pic | FileCheck %s

define ptr @g() nounwind {
; CHECK-LABEL: g:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    leaq f(%rip), %rax
; CHECK-NEXT:    retq
entry:
	ret ptr @f
}

define internal void @f() nounwind {
; CHECK-LABEL: f:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    retq
entry:
	ret void
}
