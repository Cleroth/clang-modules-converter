; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt < %s -passes=argpromotion -S | FileCheck %s

target datalayout = "e-m:w-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

define internal void @add(ptr %this, ptr sret(i32) %r) {
; CHECK-LABEL: define {{[^@]+}}@add
; CHECK-SAME: (i32 [[THIS_0_VAL:%.*]], i32 [[THIS_4_VAL:%.*]], ptr noalias [[R:%.*]]) {
; CHECK-NEXT:    [[AB:%.*]] = add i32 [[THIS_0_VAL]], [[THIS_4_VAL]]
; CHECK-NEXT:    store i32 [[AB]], ptr [[R]], align 4
; CHECK-NEXT:    ret void
;
  %ap = getelementptr {i32, i32}, ptr %this, i32 0, i32 0
  %bp = getelementptr {i32, i32}, ptr %this, i32 0, i32 1
  %a = load i32, ptr %ap
  %b = load i32, ptr %bp
  %ab = add i32 %a, %b
  store i32 %ab, ptr %r
  ret void
}

define void @f() {
; CHECK-LABEL: define {{[^@]+}}@f() {
; CHECK-NEXT:    [[R:%.*]] = alloca i32, align 4
; CHECK-NEXT:    [[PAIR:%.*]] = alloca { i32, i32 }, align 8
; CHECK-NEXT:    [[PAIR_VAL:%.*]] = load i32, ptr [[PAIR]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr i8, ptr [[PAIR]], i64 4
; CHECK-NEXT:    [[PAIR_VAL1:%.*]] = load i32, ptr [[TMP1]], align 4
; CHECK-NEXT:    call void @add(i32 [[PAIR_VAL]], i32 [[PAIR_VAL1]], ptr noalias [[R]])
; CHECK-NEXT:    ret void
;
  %r = alloca i32
  %pair = alloca {i32, i32}

  call void @add(ptr %pair, ptr sret(i32) %r)
  ret void
}
