; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=loop-vectorize -enable-vplan-native-path -S %s | FileCheck %s

declare i1 @cond()

; Make sure we do not vectorize (or crash) on outer loops with uncomputable
; trip-counts.

define void @test() {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR1_HEADER:%.*]]
; CHECK:       for1.header:
; CHECK-NEXT:    br label [[FOR2_HEADER:%.*]]
; CHECK:       for2.header:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ 0, [[FOR1_HEADER]] ], [ [[INDVARS_IV_NEXT:%.*]], [[FOR2_HEADER]] ]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], 0
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR1_LATCH:%.*]], label [[FOR2_HEADER]]
; CHECK:       for1.latch:
; CHECK-NEXT:    [[C:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[C]], label [[EXIT:%.*]], label [[FOR1_HEADER]], !llvm.loop !0
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %for1.header

for1.header:                                  ; preds = %for.cond.cleanup3, %for.cond1.preheader.lr.ph
  br label %for2.header

for2.header:                                       ; preds = %for.body10, %for.body10.preheader
  %indvars.iv = phi i64 [ 0, %for1.header ], [ %indvars.iv.next, %for2.header ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 0
  br i1 %exitcond, label %for1.latch, label %for2.header

for1.latch:                                ; preds = %for.cond.cleanup9
  %c = call i1 @cond()
  br i1 %c, label %exit, label %for1.header, !llvm.loop !0

exit:                                 ; preds = %for.cond.cleanup3, %entry
  ret void
}

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.vectorize.enable", i1 true}
