; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2

; RUN: opt < %s -passes='require<profile-summary>,function(loop-mssa(simple-loop-unswitch<nontrivial>))' -S | FileCheck %s

;; Check that non-trivial loop unswitching is not applied to a cold loop in a
;; cold loop nest.

;; IR was generated from the following loop nest, profiled when called
;; with M=0 and N=0.
;; void hotFunction(bool cond, int M, int N, int * A, int *B, int *C) {
;;   for (unsigned j = 0; j < M; j++)
;;     for (unsigned i=0; i < N; i++) {
;;       A[i] = B[i] + C[i];
;;       if (cond) do_something();
;;     }
;; }

define void @_Z11hotFunctionbiiPiS_S_(i1 %cond, i32 %M, i32 %N, ptr %A, ptr %B, ptr %C) !prof !36 {
; CHECK-LABEL: define void @_Z11hotFunctionbiiPiS_S_
; CHECK-SAME: (i1 [[COND:%.*]], i32 [[M:%.*]], i32 [[N:%.*]], ptr [[A:%.*]], ptr [[B:%.*]], ptr [[C:%.*]]) !prof [[PROF16:![0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP19_NOT:%.*]] = icmp eq i32 [[M]], 0
; CHECK-NEXT:    br i1 [[CMP19_NOT]], label [[FOR_COND_CLEANUP:%.*]], label [[FOR_COND1_PREHEADER_LR_PH:%.*]], !prof [[PROF17:![0-9]+]]
; CHECK:       for.cond1.preheader.lr.ph:
; CHECK-NEXT:    [[CMP217_NOT:%.*]] = icmp eq i32 [[N]], 0
; CHECK-NEXT:    br label [[FOR_COND1_PREHEADER:%.*]]
; CHECK:       for.cond1.preheader:
; CHECK-NEXT:    [[J_020:%.*]] = phi i32 [ 0, [[FOR_COND1_PREHEADER_LR_PH]] ], [ [[INC10:%.*]], [[FOR_COND_CLEANUP3:%.*]] ]
; CHECK-NEXT:    br i1 [[CMP217_NOT]], label [[FOR_COND_CLEANUP3]], label [[FOR_BODY4_PREHEADER:%.*]]
; CHECK:       for.body4.preheader:
; CHECK-NEXT:    br label [[FOR_BODY4:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.cond.cleanup3.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP3]]
; CHECK:       for.cond.cleanup3:
; CHECK-NEXT:    [[INC10]] = add nuw i32 [[J_020]], 1
; CHECK-NEXT:    [[EXITCOND22_NOT:%.*]] = icmp eq i32 [[INC10]], [[M]]
; CHECK-NEXT:    br i1 [[EXITCOND22_NOT]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]], label [[FOR_COND1_PREHEADER]], !prof [[PROF17]]
; CHECK:       for.body4:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i64 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_INC:%.*]] ], [ 0, [[FOR_BODY4_PREHEADER]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, ptr [[C]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP1]], [[TMP0]]
; CHECK-NEXT:    [[ARRAYIDX8:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[INDVARS_IV]]
; CHECK-NEXT:    store i32 [[ADD]], ptr [[ARRAYIDX8]], align 4
; CHECK-NEXT:    br i1 [[COND]], label [[IF_THEN:%.*]], label [[FOR_INC]]
; CHECK:       if.then:
; CHECK-NEXT:    tail call void @_Z12do_somethingv()
; CHECK-NEXT:    br label [[FOR_INC]]
; CHECK:       for.inc:
; CHECK-NEXT:    [[WIDE_TRIP_COUNT:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add nuw nsw i64 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[INDVARS_IV_NEXT]], [[WIDE_TRIP_COUNT]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label [[FOR_COND_CLEANUP3_LOOPEXIT:%.*]], label [[FOR_BODY4]]
;
entry:
  %cmp19.not = icmp eq i32 %M, 0
  br i1 %cmp19.not, label %for.cond.cleanup, label %for.cond1.preheader.lr.ph, !prof !37

for.cond1.preheader.lr.ph:
  %cmp217.not = icmp eq i32 %N, 0
  br label %for.cond1.preheader

for.cond1.preheader:
  %j.020 = phi i32 [ 0, %for.cond1.preheader.lr.ph ], [ %inc10, %for.cond.cleanup3 ]
  br i1 %cmp217.not, label %for.cond.cleanup3, label %for.body4

for.cond.cleanup:
  ret void

for.cond.cleanup3:
  %inc10 = add nuw i32 %j.020, 1
  %exitcond22.not = icmp eq i32 %inc10, %M
  br i1 %exitcond22.not, label %for.cond.cleanup, label %for.cond1.preheader, !prof !37

for.body4:
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.inc ], [ 0, %for.cond1.preheader ]
  %arrayidx = getelementptr inbounds i32, ptr %B, i64 %indvars.iv
  %0 = load i32, ptr %arrayidx, align 4
  %arrayidx6 = getelementptr inbounds i32, ptr %C, i64 %indvars.iv
  %1 = load i32, ptr %arrayidx6, align 4
  %add = add nsw i32 %1, %0
  %arrayidx8 = getelementptr inbounds i32, ptr %A, i64 %indvars.iv
  store i32 %add, ptr %arrayidx8, align 4
  br i1 %cond, label %if.then, label %for.inc

if.then:
  tail call void @_Z12do_somethingv()
  br label %for.inc

for.inc:
  %wide.trip.count = zext i32 %N to i64
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %for.cond.cleanup3, label %for.body4
}

declare void @_Z12do_somethingv()

!llvm.module.flags = !{!6}

!6 = !{i32 1, !"ProfileSummary", !7}
!7 = !{!8, !9, !10, !11, !12, !13, !14, !15, !16, !17}
!8 = !{!"ProfileFormat", !"InstrProf"}
!9 = !{!"TotalCount", i64 1002}
!10 = !{!"MaxCount", i64 1000}
!11 = !{!"MaxInternalCount", i64 1000}
!12 = !{!"MaxFunctionCount", i64 1}
!13 = !{!"NumCounts", i64 6}
!14 = !{!"NumFunctions", i64 3}
!15 = !{!"IsPartialProfile", i64 0}
!16 = !{!"PartialProfileRatio", double 0.000000e+00}
!17 = !{!"DetailedSummary", !18}
!18 = !{!19, !31, !34}
!19 = !{i32 10000, i64 1000, i32 1}
!31 = !{i32 999000, i64 1000, i32 1}
!34 = !{i32 999999, i64 1, i32 3}
!36 = !{!"function_entry_count", i64 1}
!37 = !{!"branch_weights", i32 1, i32 0}
