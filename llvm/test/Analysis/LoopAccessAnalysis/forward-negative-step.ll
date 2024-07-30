; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes='print<access-info>' -disable-output  < %s 2>&1 | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"

; void vectorizable_Read_Write(int *A) {
;  for (unsigned i = 1022; i >= 0; i--)
;    A[i+1] = A[i] + 1;
; }

define void @vectorizable_Read_Write(ptr nocapture %A) {
; CHECK-LABEL: 'vectorizable_Read_Write'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Memory dependences are safe
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        Forward:
; CHECK-NEXT:            %l = load i32, ptr %gep.A, align 4 ->
; CHECK-NEXT:            store i32 %add, ptr %gep.A.plus.1, align 4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  %A.plus.1 = getelementptr i32, ptr %A, i64 1
  br label %loop

loop:
  %iv = phi i64 [ 1022, %entry ], [ %iv.next, %loop ]
  %gep.A = getelementptr inbounds i32, ptr %A, i64 %iv
  %l = load i32, ptr %gep.A, align 4
  %add = add nsw i32 %l, 1
  %gep.A.plus.1 = getelementptr i32, ptr %A.plus.1, i64 %iv
  store i32 %add, ptr %gep.A.plus.1, align 4
  %iv.next = add nsw i64 %iv, -1
  %cmp.not = icmp eq i64 %iv, 0
  br i1 %cmp.not, label %exit, label %loop

exit:
  ret void
}

define void @neg_step_ForwardButPreventsForwarding(ptr nocapture %A, ptr noalias %B) {
; CHECK-LABEL: 'neg_step_ForwardButPreventsForwarding'
; CHECK-NEXT:    loop:
; CHECK-NEXT:      Report: unsafe dependent memory operations in loop. Use #pragma clang loop distribute(enable) to allow loop distribution to attempt to isolate the offending operations into a separate loop
; CHECK-NEXT:  Forward loop carried data dependence that prevents store-to-load forwarding.
; CHECK-NEXT:      Dependences:
; CHECK-NEXT:        ForwardButPreventsForwarding:
; CHECK-NEXT:            store i32 0, ptr %gep.A, align 4 ->
; CHECK-NEXT:            %l = load i32, ptr %gep.A.plus.1, align 4
; CHECK-EMPTY:
; CHECK-NEXT:      Run-time memory checks:
; CHECK-NEXT:      Grouped accesses:
; CHECK-EMPTY:
; CHECK-NEXT:      Non vectorizable stores to invariant address were not found in loop.
; CHECK-NEXT:      SCEV assumptions:
; CHECK-EMPTY:
; CHECK-NEXT:      Expressions re-written:
;
entry:
  %A.plus.1 = getelementptr i32, ptr %A, i64 1
  br label %loop

loop:
  %iv = phi i64 [ 1022, %entry ], [ %iv.next, %loop ]
  %gep.A = getelementptr inbounds i32, ptr %A, i64 %iv
  store i32 0, ptr %gep.A, align 4
  %gep.A.plus.1 = getelementptr i32, ptr %A.plus.1, i64 %iv
  %l = load i32, ptr %gep.A.plus.1, align 4
  store i32 %l, ptr %B
  %iv.next = add nsw i64 %iv, -1
  %cmp.not = icmp eq i64 %iv, 0
  br i1 %cmp.not, label %exit, label %loop

exit:
  ret void
}
