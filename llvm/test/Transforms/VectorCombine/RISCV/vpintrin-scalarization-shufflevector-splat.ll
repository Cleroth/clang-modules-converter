; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -S -mtriple=riscv64 -mattr=+v %s -passes=vector-combine | FileCheck %s --check-prefix=CHECK

declare <4 x i64> @llvm.vp.add.v4i64(<4 x i64>, <4 x i64>, <4 x i1>, i32)

define <4 x i64> @add_v4i64_allonesmask(<4 x i64> %x) {
; CHECK-LABEL: define <4 x i64> @add_v4i64_allonesmask(
; CHECK-SAME: <4 x i64> [[X:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <4 x i64> [[X]], <4 x i64> zeroinitializer, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = call <4 x i64> @llvm.vp.add.v4i64(<4 x i64> [[TMP1]], <4 x i64> zeroinitializer, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, i32 0)
; CHECK-NEXT:    ret <4 x i64> [[TMP2]]
;
  %1 = shufflevector <4 x i64> %x, <4 x i64> zeroinitializer, <4 x i32> zeroinitializer
  %2 = call <4 x i64> @llvm.vp.add.v4i64(<4 x i64> %1, <4 x i64> zeroinitializer, <4 x i1> <i1 true, i1 true, i1 true, i1 true>, i32 0)
  ret <4 x i64> %2
}
