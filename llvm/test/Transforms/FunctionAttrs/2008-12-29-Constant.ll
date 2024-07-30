; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-attributes
; RUN: opt < %s -passes=function-attrs -S | FileCheck %s

@s = external constant i8

define i8 @f() {
; CHECK: Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
; CHECK-LABEL: @f(
; CHECK-NEXT:    [[TMP:%.*]] = load i8, ptr @s, align 1
; CHECK-NEXT:    ret i8 [[TMP]]
;
  %tmp = load i8, ptr @s
  ret i8 %tmp
}
