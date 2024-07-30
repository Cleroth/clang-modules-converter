; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -passes=loop-vectorize,dce,instcombine -tail-predication=enabled -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "thumbv8.1m.main-none-none-eabi"

define i32 @reduction_sum_single(ptr noalias nocapture %A) {
; CHECK-LABEL: @reduction_sum_single(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP2:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[INDEX]], i32 257)
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP0]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[WIDE_MASKED_LOAD]])
; CHECK-NEXT:    [[TMP2]] = add i32 [[TMP1]], [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP3:%.*]] = icmp eq i32 [[INDEX_NEXT]], 260
; CHECK-NEXT:    br i1 [[TMP3]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[DOT_CRIT_EDGE:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[DOTLR_PH:%.*]]
; CHECK:       .lr.ph:
; CHECK-NEXT:    br i1 poison, label [[DOT_CRIT_EDGE]], label [[DOTLR_PH]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       ._crit_edge:
; CHECK-NEXT:    [[SUM_0_LCSSA:%.*]] = phi i32 [ poison, [[DOTLR_PH]] ], [ [[TMP2]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[SUM_0_LCSSA]]
;
entry:
  br label %.lr.ph

.lr.ph:                                           ; preds = %entry, %.lr.ph
  %indvars.iv = phi i32 [ %indvars.iv.next, %.lr.ph ], [ 0, %entry ]
  %sum.02 = phi i32 [ %l7, %.lr.ph ], [ 0, %entry ]
  %l2 = getelementptr inbounds i32, ptr %A, i32 %indvars.iv
  %l3 = load i32, ptr %l2, align 4
  %l7 = add i32 %sum.02, %l3
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph
  %sum.0.lcssa = phi i32 [ %l7, %.lr.ph ]
  ret i32 %sum.0.lcssa
}

define i32 @reduction_sum(ptr noalias nocapture %A, ptr noalias nocapture %B) {
; CHECK-LABEL: @reduction_sum(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i32> [ <i32 0, i32 1, i32 2, i32 3>, [[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[TMP8:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[INDEX]], i32 257)
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP0]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD1:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP1]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> zeroinitializer)
; CHECK-NEXT:    [[TMP2:%.*]] = select <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> [[VEC_IND]], <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[TMP2]])
; CHECK-NEXT:    [[TMP4:%.*]] = add i32 [[TMP3]], [[VEC_PHI]]
; CHECK-NEXT:    [[TMP5:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[WIDE_MASKED_LOAD]])
; CHECK-NEXT:    [[TMP6:%.*]] = add i32 [[TMP5]], [[TMP4]]
; CHECK-NEXT:    [[TMP7:%.*]] = call i32 @llvm.vector.reduce.add.v4i32(<4 x i32> [[WIDE_MASKED_LOAD1]])
; CHECK-NEXT:    [[TMP8]] = add i32 [[TMP7]], [[TMP6]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i32> [[VEC_IND]], <i32 4, i32 4, i32 4, i32 4>
; CHECK-NEXT:    [[TMP9:%.*]] = icmp eq i32 [[INDEX_NEXT]], 260
; CHECK-NEXT:    br i1 [[TMP9]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[DOT_CRIT_EDGE:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[DOTLR_PH:%.*]]
; CHECK:       .lr.ph:
; CHECK-NEXT:    br i1 poison, label [[DOT_CRIT_EDGE]], label [[DOTLR_PH]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       ._crit_edge:
; CHECK-NEXT:    [[SUM_0_LCSSA:%.*]] = phi i32 [ poison, [[DOTLR_PH]] ], [ [[TMP8]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[SUM_0_LCSSA]]
;
entry:
  br label %.lr.ph

.lr.ph:                                           ; preds = %entry, %.lr.ph
  %indvars.iv = phi i32 [ %indvars.iv.next, %.lr.ph ], [ 0, %entry ]
  %sum.02 = phi i32 [ %l9, %.lr.ph ], [ 0, %entry ]
  %l2 = getelementptr inbounds i32, ptr %A, i32 %indvars.iv
  %l3 = load i32, ptr %l2, align 4
  %l4 = getelementptr inbounds i32, ptr %B, i32 %indvars.iv
  %l5 = load i32, ptr %l4, align 4
  %l7 = add i32 %sum.02, %indvars.iv
  %l8 = add i32 %l7, %l3
  %l9 = add i32 %l8, %l5
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph
  %sum.0.lcssa = phi i32 [ %l9, %.lr.ph ]
  ret i32 %sum.0.lcssa
}

define i32 @reduction_prod(ptr noalias nocapture %A, ptr noalias nocapture %B) {
; CHECK-LABEL: @reduction_prod(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ <i32 1, i32 1, i32 1, i32 1>, [[VECTOR_PH]] ], [ [[TMP4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[INDEX]], i32 257)
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP0]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> poison)
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD1:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP1]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> poison)
; CHECK-NEXT:    [[TMP2:%.*]] = mul <4 x i32> [[VEC_PHI]], [[WIDE_MASKED_LOAD]]
; CHECK-NEXT:    [[TMP3:%.*]] = mul <4 x i32> [[TMP2]], [[WIDE_MASKED_LOAD1]]
; CHECK-NEXT:    [[TMP4]] = select <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> [[TMP3]], <4 x i32> [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[INDEX_NEXT]], 260
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP6:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.vector.reduce.mul.v4i32(<4 x i32> [[TMP4]])
; CHECK-NEXT:    br i1 true, label [[DOT_CRIT_EDGE:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[DOTLR_PH:%.*]]
; CHECK:       .lr.ph:
; CHECK-NEXT:    br i1 poison, label [[DOT_CRIT_EDGE]], label [[DOTLR_PH]], !llvm.loop [[LOOP7:![0-9]+]]
; CHECK:       ._crit_edge:
; CHECK-NEXT:    [[PROD_0_LCSSA:%.*]] = phi i32 [ poison, [[DOTLR_PH]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[PROD_0_LCSSA]]
;
entry:
  br label %.lr.ph

.lr.ph:                                           ; preds = %entry, %.lr.ph
  %indvars.iv = phi i32 [ %indvars.iv.next, %.lr.ph ], [ 0, %entry ]
  %prod.02 = phi i32 [ %l9, %.lr.ph ], [ 1, %entry ]
  %l2 = getelementptr inbounds i32, ptr %A, i32 %indvars.iv
  %l3 = load i32, ptr %l2, align 4
  %l4 = getelementptr inbounds i32, ptr %B, i32 %indvars.iv
  %l5 = load i32, ptr %l4, align 4
  %l8 = mul i32 %prod.02, %l3
  %l9 = mul i32 %l8, %l5
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph
  %prod.0.lcssa = phi i32 [ %l9, %.lr.ph ]
  ret i32 %prod.0.lcssa
}

define i32 @reduction_and(ptr nocapture %A, ptr nocapture %B) {
; CHECK-LABEL: @reduction_and(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ <i32 -1, i32 -1, i32 -1, i32 -1>, [[VECTOR_PH]] ], [ [[TMP4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[INDEX]], i32 257)
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP0]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> poison)
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD1:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP1]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> poison)
; CHECK-NEXT:    [[TMP2:%.*]] = and <4 x i32> [[WIDE_MASKED_LOAD]], [[WIDE_MASKED_LOAD1]]
; CHECK-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> [[TMP2]], <4 x i32> <i32 -1, i32 -1, i32 -1, i32 -1>
; CHECK-NEXT:    [[TMP4]] = and <4 x i32> [[VEC_PHI]], [[TMP3]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[INDEX_NEXT]], 260
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP8:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.vector.reduce.and.v4i32(<4 x i32> [[TMP4]])
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br i1 poison, label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP9:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[RESULT_0_LCSSA:%.*]] = phi i32 [ poison, [[FOR_BODY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[RESULT_0_LCSSA]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i32 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %result.08 = phi i32 [ %and, %for.body ], [ -1, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %indvars.iv
  %l0 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %B, i32 %indvars.iv
  %l1 = load i32, ptr %arrayidx2, align 4
  %add = and i32 %result.08, %l0
  %and = and i32 %add, %l1
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %result.0.lcssa = phi i32 [ %and, %for.body ]
  ret i32 %result.0.lcssa
}

define i32 @reduction_or(ptr nocapture %A, ptr nocapture %B) {
; CHECK-LABEL: @reduction_or(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[INDEX]], i32 257)
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP0]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> poison)
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD1:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP1]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> poison)
; CHECK-NEXT:    [[TMP2:%.*]] = add nsw <4 x i32> [[WIDE_MASKED_LOAD1]], [[WIDE_MASKED_LOAD]]
; CHECK-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> [[TMP2]], <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP4]] = or <4 x i32> [[VEC_PHI]], [[TMP3]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[INDEX_NEXT]], 260
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP10:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.vector.reduce.or.v4i32(<4 x i32> [[TMP4]])
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br i1 poison, label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP11:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[RESULT_0_LCSSA:%.*]] = phi i32 [ poison, [[FOR_BODY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[RESULT_0_LCSSA]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i32 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %result.08 = phi i32 [ %or, %for.body ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %indvars.iv
  %l0 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %B, i32 %indvars.iv
  %l1 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %l1, %l0
  %or = or i32 %add, %result.08
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %result.0.lcssa = phi i32 [ %or, %for.body ]
  ret i32 %result.0.lcssa
}

define i32 @reduction_xor(ptr nocapture %A, ptr nocapture %B) {
; CHECK-LABEL: @reduction_xor(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[INDEX]], i32 257)
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP0]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> poison)
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i32, ptr [[B:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD1:%.*]] = call <4 x i32> @llvm.masked.load.v4i32.p0(ptr [[TMP1]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> poison)
; CHECK-NEXT:    [[TMP2:%.*]] = add nsw <4 x i32> [[WIDE_MASKED_LOAD1]], [[WIDE_MASKED_LOAD]]
; CHECK-NEXT:    [[TMP3:%.*]] = select <4 x i1> [[ACTIVE_LANE_MASK]], <4 x i32> [[TMP2]], <4 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP4]] = xor <4 x i32> [[VEC_PHI]], [[TMP3]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[INDEX_NEXT]], 260
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP12:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP6:%.*]] = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> [[TMP4]])
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br i1 poison, label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP13:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[RESULT_0_LCSSA:%.*]] = phi i32 [ poison, [[FOR_BODY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[RESULT_0_LCSSA]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i32 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %result.08 = phi i32 [ %xor, %for.body ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %indvars.iv
  %l0 = load i32, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds i32, ptr %B, i32 %indvars.iv
  %l1 = load i32, ptr %arrayidx2, align 4
  %add = add nsw i32 %l1, %l0
  %xor = xor i32 %add, %result.08
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %result.0.lcssa = phi i32 [ %xor, %for.body ]
  ret i32 %result.0.lcssa
}

define float @reduction_fadd(ptr nocapture %A, ptr nocapture %B) {
; CHECK-LABEL: @reduction_fadd(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x float> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[INDEX]], i32 257)
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds float, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x float> @llvm.masked.load.v4f32.p0(ptr [[TMP0]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x float> poison)
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds float, ptr [[B:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD1:%.*]] = call <4 x float> @llvm.masked.load.v4f32.p0(ptr [[TMP1]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x float> poison)
; CHECK-NEXT:    [[TMP2:%.*]] = fadd fast <4 x float> [[VEC_PHI]], [[WIDE_MASKED_LOAD]]
; CHECK-NEXT:    [[TMP3:%.*]] = fadd fast <4 x float> [[TMP2]], [[WIDE_MASKED_LOAD1]]
; CHECK-NEXT:    [[TMP4]] = select fast <4 x i1> [[ACTIVE_LANE_MASK]], <4 x float> [[TMP3]], <4 x float> [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[INDEX_NEXT]], 260
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP14:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP6:%.*]] = call fast float @llvm.vector.reduce.fadd.v4f32(float -0.000000e+00, <4 x float> [[TMP4]])
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br i1 poison, label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP15:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[RESULT_0_LCSSA:%.*]] = phi float [ poison, [[FOR_BODY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret float [[RESULT_0_LCSSA]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i32 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %result.08 = phi float [ %fadd, %for.body ], [ 0.0, %entry ]
  %arrayidx = getelementptr inbounds float, ptr %A, i32 %indvars.iv
  %l0 = load float, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds float, ptr %B, i32 %indvars.iv
  %l1 = load float, ptr %arrayidx2, align 4
  %add = fadd fast float %result.08, %l0
  %fadd = fadd fast float %add, %l1
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %result.0.lcssa = phi float [ %fadd, %for.body ]
  ret float %result.0.lcssa
}

define float @reduction_fmul(ptr nocapture %A, ptr nocapture %B) {
; CHECK-LABEL: @reduction_fmul(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x float> [ <float 0.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>, [[VECTOR_PH]] ], [ [[TMP4:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[ACTIVE_LANE_MASK:%.*]] = call <4 x i1> @llvm.get.active.lane.mask.v4i1.i32(i32 [[INDEX]], i32 257)
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds float, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD:%.*]] = call <4 x float> @llvm.masked.load.v4f32.p0(ptr [[TMP0]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x float> poison)
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds float, ptr [[B:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_MASKED_LOAD1:%.*]] = call <4 x float> @llvm.masked.load.v4f32.p0(ptr [[TMP1]], i32 4, <4 x i1> [[ACTIVE_LANE_MASK]], <4 x float> poison)
; CHECK-NEXT:    [[TMP2:%.*]] = fmul fast <4 x float> [[VEC_PHI]], [[WIDE_MASKED_LOAD]]
; CHECK-NEXT:    [[TMP3:%.*]] = fmul fast <4 x float> [[TMP2]], [[WIDE_MASKED_LOAD1]]
; CHECK-NEXT:    [[TMP4]] = select fast <4 x i1> [[ACTIVE_LANE_MASK]], <4 x float> [[TMP3]], <4 x float> [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP5:%.*]] = icmp eq i32 [[INDEX_NEXT]], 260
; CHECK-NEXT:    br i1 [[TMP5]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP16:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP6:%.*]] = call fast float @llvm.vector.reduce.fmul.v4f32(float 1.000000e+00, <4 x float> [[TMP4]])
; CHECK-NEXT:    br i1 true, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    br i1 poison, label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP17:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[RESULT_0_LCSSA:%.*]] = phi float [ poison, [[FOR_BODY]] ], [ [[TMP6]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret float [[RESULT_0_LCSSA]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i32 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %result.08 = phi float [ %fmul, %for.body ], [ 0.0, %entry ]
  %arrayidx = getelementptr inbounds float, ptr %A, i32 %indvars.iv
  %l0 = load float, ptr %arrayidx, align 4
  %arrayidx2 = getelementptr inbounds float, ptr %B, i32 %indvars.iv
  %l1 = load float, ptr %arrayidx2, align 4
  %add = fmul fast float %result.08, %l0
  %fmul = fmul fast float %add, %l1
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %result.0.lcssa = phi float [ %fmul, %for.body ]
  ret float %result.0.lcssa
}

define i32 @reduction_min(ptr nocapture %A, ptr nocapture %B) {
; CHECK-LABEL: @reduction_min(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ <i32 1000, i32 1000, i32 1000, i32 1000>, [[VECTOR_PH]] ], [ [[TMP1:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[TMP1]] = call <4 x i32> @llvm.smin.v4i32(<4 x i32> [[VEC_PHI]], <4 x i32> [[WIDE_LOAD]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[INDEX_NEXT]], 256
; CHECK-NEXT:    br i1 [[TMP2]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP18:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.vector.reduce.smin.v4i32(<4 x i32> [[TMP1]])
; CHECK-NEXT:    br i1 false, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ [[TMP3]], [[MIDDLE_BLOCK]] ], [ poison, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i32 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ], [ 256, [[SCALAR_PH]] ]
; CHECK-NEXT:    [[RESULT_08:%.*]] = phi i32 [ [[V0:%.*]], [[FOR_BODY]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[INDVARS_IV]]
; CHECK-NEXT:    [[L0:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[V0]] = call i32 @llvm.smin.i32(i32 [[RESULT_08]], i32 [[L0]])
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i32 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INDVARS_IV_NEXT]], 257
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP19:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[RESULT_0_LCSSA:%.*]] = phi i32 [ [[V0]], [[FOR_BODY]] ], [ poison, [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[RESULT_0_LCSSA]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i32 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %result.08 = phi i32 [ %v0, %for.body ], [ 1000, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %indvars.iv
  %l0 = load i32, ptr %arrayidx, align 4
  %c0 = icmp slt i32 %result.08, %l0
  %v0 = select i1 %c0, i32 %result.08, i32 %l0
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %result.0.lcssa = phi i32 [ %v0, %for.body ]
  ret i32 %result.0.lcssa
}

define i32 @reduction_max(ptr nocapture %A, ptr nocapture %B) {
; CHECK-LABEL: @reduction_max(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <4 x i32> [ <i32 1000, i32 1000, i32 1000, i32 1000>, [[VECTOR_PH]] ], [ [[TMP1:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds i32, ptr [[A:%.*]], i32 [[INDEX]]
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <4 x i32>, ptr [[TMP0]], align 4
; CHECK-NEXT:    [[TMP1]] = call <4 x i32> @llvm.umax.v4i32(<4 x i32> [[VEC_PHI]], <4 x i32> [[WIDE_LOAD]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[INDEX_NEXT]], 256
; CHECK-NEXT:    br i1 [[TMP2]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP20:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP3:%.*]] = call i32 @llvm.vector.reduce.umax.v4i32(<4 x i32> [[TMP1]])
; CHECK-NEXT:    br i1 false, label [[FOR_END:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i32 [ [[TMP3]], [[MIDDLE_BLOCK]] ], [ poison, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i32 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ], [ 256, [[SCALAR_PH]] ]
; CHECK-NEXT:    [[RESULT_08:%.*]] = phi i32 [ [[V0:%.*]], [[FOR_BODY]] ], [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, ptr [[A]], i32 [[INDVARS_IV]]
; CHECK-NEXT:    [[L0:%.*]] = load i32, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[V0]] = call i32 @llvm.umax.i32(i32 [[RESULT_08]], i32 [[L0]])
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i32 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INDVARS_IV_NEXT]], 257
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END]], label [[FOR_BODY]], !llvm.loop [[LOOP21:![0-9]+]]
; CHECK:       for.end:
; CHECK-NEXT:    [[RESULT_0_LCSSA:%.*]] = phi i32 [ [[V0]], [[FOR_BODY]] ], [ poison, [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i32 [[RESULT_0_LCSSA]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i32 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %result.08 = phi i32 [ %v0, %for.body ], [ 1000, %entry ]
  %arrayidx = getelementptr inbounds i32, ptr %A, i32 %indvars.iv
  %l0 = load i32, ptr %arrayidx, align 4
  %c0 = icmp ugt i32 %result.08, %l0
  %v0 = select i1 %c0, i32 %result.08, i32 %l0
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %result.0.lcssa = phi i32 [ %v0, %for.body ]
  ret i32 %result.0.lcssa
}

define float @reduction_fmax(ptr nocapture %A, ptr nocapture %B) {
; CHECK-LABEL: @reduction_fmax(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[INDVARS_IV:%.*]] = phi i32 [ [[INDVARS_IV_NEXT:%.*]], [[FOR_BODY]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[RESULT_08:%.*]] = phi float [ [[V0:%.*]], [[FOR_BODY]] ], [ 1.000000e+03, [[ENTRY]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds float, ptr [[A:%.*]], i32 [[INDVARS_IV]]
; CHECK-NEXT:    [[L0:%.*]] = load float, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[C0:%.*]] = fcmp ogt float [[RESULT_08]], [[L0]]
; CHECK-NEXT:    [[V0]] = select i1 [[C0]], float [[RESULT_08]], float [[L0]]
; CHECK-NEXT:    [[INDVARS_IV_NEXT]] = add i32 [[INDVARS_IV]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INDVARS_IV_NEXT]], 257
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_END:%.*]], label [[FOR_BODY]]
; CHECK:       for.end:
; CHECK-NEXT:    ret float [[V0]]
;
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i32 [ %indvars.iv.next, %for.body ], [ 0, %entry ]
  %result.08 = phi float [ %v0, %for.body ], [ 1000.0, %entry ]
  %arrayidx = getelementptr inbounds float, ptr %A, i32 %indvars.iv
  %l0 = load float, ptr %arrayidx, align 4
  %c0 = fcmp ogt float %result.08, %l0
  %v0 = select i1 %c0, float %result.08, float %l0
  %indvars.iv.next = add i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 257
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body, %entry
  %result.0.lcssa = phi float [ %v0, %for.body ]
  ret float %result.0.lcssa
}
