; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=indvars < %s | FileCheck %s

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128-ni:1-p2:32:8:8:32-ni:2"
target triple = "x86_64-unknown-linux-gnu"

; Make sure we don't branch by poison here.
define void @test(i32 %start) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[START:%.*]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = zext i32 [[START]] to i64
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    br label [[LOOP]]
; CHECK:       loop:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ [[TMP1]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nsw i64 [[INDVARS_IV]], -1
; CHECK-NEXT:    [[INDVARS:%.*]] = trunc i64 [[INDVARS_IV_NEXT]] to i32
; CHECK-NEXT:    [[LOOP_EXIT_COND:%.*]] = icmp slt i32 [[TMP0]], 11
; CHECK-NEXT:    br i1 [[LOOP_EXIT_COND]], label [[EXIT:%.*]], label [[STUCK_PREHEADER:%.*]]
; CHECK:       stuck.preheader:
; CHECK-NEXT:    br label [[STUCK:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    [[IV_NEXT_LCSSA:%.*]] = phi i32 [ [[INDVARS]], [[LOOP]] ]
; CHECK-NEXT:    ret void
; CHECK:       stuck:
; CHECK-NEXT:    br i1 false, label [[BACKEDGE]], label [[STUCK]]
;
entry:
  br label %loop

backedge:                                         ; preds = %stuck
  br label %loop

loop:                                             ; preds = %backedge, %entry
  %iv = phi i32 [ %start, %entry ], [ %iv.next, %backedge ]
  %iv.zext = zext i32 %iv to i64
  %gep = getelementptr inbounds i64, ptr undef, i64 %iv.zext
  %iv.next = add i32 %iv, -1
  %loop.exit.cond = icmp slt i32 %iv.next, 11
  br i1 %loop.exit.cond, label %exit, label %stuck

exit:                                             ; preds = %loop
  %iv.next.lcssa = phi i32 [ %iv.next, %loop ]
  ret void

stuck:                                            ; preds = %stuck, %loop
  br i1 false, label %backedge, label %stuck
}
