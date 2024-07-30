; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch32 -mattr=+d < %s | FileCheck %s

declare void @llvm.loongarch.cacop.w(i32, i32, i32)

define void @cacop_w(i32 %a) nounwind {
; CHECK-LABEL: cacop_w:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cacop 1, $a0, 4
; CHECK-NEXT:    ret
  call void @llvm.loongarch.cacop.w(i32 1, i32 %a, i32 4)
  ret void
}
