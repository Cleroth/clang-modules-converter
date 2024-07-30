; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes=loop-unroll -unroll-threshold=1 | FileCheck %s
; RUN: opt < %s -S -passes='require<opt-remark-emit>,loop(loop-unroll-full)' -unroll-threshold=1 | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

; Body fully unrolls into a single instruction after unroll and simplify
define i32 @test(i8 %a) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ZEXT_9:%.*]] = zext i8 [[A:%.*]] to i32
; CHECK-NEXT:    ret i32 [[ZEXT_9]]
;
entry:
  br label %for.body

for.body:
  %phi = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %zext = zext i8 %a to i32
  %inc = add nuw nsw i64 %phi, 1
  %cmp = icmp ult i64 %inc, 10
  br i1 %cmp, label %for.body, label %for.exit

for.exit:
  ret i32 %zext
}

; Generalized version of previous to show benefit of using SCEV's ability
; to prove invariance not Loop::isLoopInvaraint.
define i32 @test2(i8 %a) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ZEXT_9:%.*]] = zext i8 [[A:%.*]] to i32
; CHECK-NEXT:    [[AND_9:%.*]] = and i32 [[ZEXT_9]], 31
; CHECK-NEXT:    [[SHL_9:%.*]] = shl i32 [[AND_9]], 15
; CHECK-NEXT:    ret i32 [[SHL_9]]
;
entry:
  br label %for.body

for.body:
  %phi = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %zext = zext i8 %a to i32
  %and = and i32 %zext, 31
  %shl = shl i32 %and, 15
  %inc = add nuw nsw i64 %phi, 1
  %cmp = icmp ult i64 %inc, 10
  br i1 %cmp, label %for.body, label %for.exit

for.exit:
  ret i32 %shl
}

; Show that this works for instructions which might fault as well
define i32 @test3(i8 %a) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[ZEXT_9:%.*]] = zext i8 [[A:%.*]] to i32
; CHECK-NEXT:    [[DIV_9:%.*]] = udiv i32 [[ZEXT_9]], 31
; CHECK-NEXT:    ret i32 [[DIV_9]]
;
entry:
  br label %for.body

for.body:
  %phi = phi i64 [ 0, %entry ], [ %inc, %for.body ]
  %zext = zext i8 %a to i32
  %div = udiv i32 %zext, 31
  %inc = add nuw nsw i64 %phi, 1
  %cmp = icmp ult i64 %inc, 10
  br i1 %cmp, label %for.body, label %for.exit

for.exit:
  ret i32 %div
}
