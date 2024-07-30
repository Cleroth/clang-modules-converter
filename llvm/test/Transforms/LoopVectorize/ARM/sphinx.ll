; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-vectorize -mtriple=thumbv8-unknown-unknown -mcpu=cortex-a53 -S | FileCheck %s

; This test is reduced from SPECFP 2006 482.sphinx.
; We expect vectorization with <2 x double> and <2 x float> ops.
; See https://bugs.llvm.org/show_bug.cgi?id=36280 for more details.


target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"

@a = external global i32
@v = external global i32
@mm = external global ptr
@vv = external global ptr
@ll = external global ptr

define i32 @test(ptr nocapture readonly %x) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[T:%.*]] = load i32, ptr @v, align 8
; CHECK-NEXT:    [[T1:%.*]] = load i32, ptr @a, align 4
; CHECK-NEXT:    br label [[OUTERLOOP:%.*]]
; CHECK:       outerloop:
; CHECK-NEXT:    [[T2:%.*]] = phi i32 [ [[V17:%.*]], [[OUTEREND:%.*]] ], [ [[T1]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[J_0136:%.*]] = phi i32 [ [[INC144:%.*]], [[OUTEREND]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    [[SCORE_1135:%.*]] = phi i32 [ [[CALL142:%.*]], [[OUTEREND]] ], [ -939524096, [[ENTRY]] ]
; CHECK-NEXT:    [[T3:%.*]] = load ptr, ptr @mm, align 4
; CHECK-NEXT:    [[ARRAYIDX109:%.*]] = getelementptr inbounds ptr, ptr [[T3]], i32 [[T2]]
; CHECK-NEXT:    [[T4:%.*]] = load ptr, ptr [[ARRAYIDX109]], align 4
; CHECK-NEXT:    [[T5:%.*]] = load ptr, ptr @vv, align 4
; CHECK-NEXT:    [[ARRAYIDX111:%.*]] = getelementptr inbounds ptr, ptr [[T5]], i32 [[T2]]
; CHECK-NEXT:    [[T6:%.*]] = load ptr, ptr [[ARRAYIDX111]], align 4
; CHECK-NEXT:    [[T7:%.*]] = load ptr, ptr @ll, align 4
; CHECK-NEXT:    [[ARRAYIDX113:%.*]] = getelementptr inbounds float, ptr [[T7]], i32 [[T2]]
; CHECK-NEXT:    [[T8:%.*]] = load float, ptr [[ARRAYIDX113]], align 4
; CHECK-NEXT:    [[CONV114:%.*]] = fpext float [[T8]] to double
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[T]], 2
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[T]], 2
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[T]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <2 x double> zeroinitializer, double [[CONV114]], i32 0
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <2 x double> [ [[TMP0]], [[VECTOR_PH]] ], [ [[TMP13:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = add i32 [[INDEX]], 0
; CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds float, ptr [[X:%.*]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds float, ptr [[TMP2]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD:%.*]] = load <2 x float>, ptr [[TMP3]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds float, ptr [[T4]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds float, ptr [[TMP4]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD1:%.*]] = load <2 x float>, ptr [[TMP5]], align 4
; CHECK-NEXT:    [[TMP6:%.*]] = fsub fast <2 x float> [[WIDE_LOAD]], [[WIDE_LOAD1]]
; CHECK-NEXT:    [[TMP7:%.*]] = fpext <2 x float> [[TMP6]] to <2 x double>
; CHECK-NEXT:    [[TMP8:%.*]] = fmul fast <2 x double> [[TMP7]], [[TMP7]]
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds float, ptr [[T6]], i32 [[TMP1]]
; CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds float, ptr [[TMP9]], i32 0
; CHECK-NEXT:    [[WIDE_LOAD2:%.*]] = load <2 x float>, ptr [[TMP10]], align 4
; CHECK-NEXT:    [[TMP11:%.*]] = fpext <2 x float> [[WIDE_LOAD2]] to <2 x double>
; CHECK-NEXT:    [[TMP12:%.*]] = fmul fast <2 x double> [[TMP8]], [[TMP11]]
; CHECK-NEXT:    [[TMP13]] = fsub fast <2 x double> [[VEC_PHI]], [[TMP12]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP14:%.*]] = icmp eq i32 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP14]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP15:%.*]] = call fast double @llvm.vector.reduce.fadd.v2f64(double -0.000000e+00, <2 x double> [[TMP13]])
; CHECK-NEXT:    [[CMP_N:%.*]] = icmp eq i32 [[T]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N]], label [[OUTEREND]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ [[N_VEC]], [[MIDDLE_BLOCK]] ], [ 0, [[OUTERLOOP]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi double [ [[TMP15]], [[MIDDLE_BLOCK]] ], [ [[CONV114]], [[OUTERLOOP]] ]
; CHECK-NEXT:    br label [[INNERLOOP:%.*]]
; CHECK:       innerloop:
; CHECK-NEXT:    [[I_2132:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[INC129:%.*]], [[INNERLOOP]] ]
; CHECK-NEXT:    [[DVAL1_4131:%.*]] = phi double [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[SUB127:%.*]], [[INNERLOOP]] ]
; CHECK-NEXT:    [[ARRAYIDX119:%.*]] = getelementptr inbounds float, ptr [[X]], i32 [[I_2132]]
; CHECK-NEXT:    [[T9:%.*]] = load float, ptr [[ARRAYIDX119]], align 4
; CHECK-NEXT:    [[ARRAYIDX120:%.*]] = getelementptr inbounds float, ptr [[T4]], i32 [[I_2132]]
; CHECK-NEXT:    [[T10:%.*]] = load float, ptr [[ARRAYIDX120]], align 4
; CHECK-NEXT:    [[SUB121:%.*]] = fsub fast float [[T9]], [[T10]]
; CHECK-NEXT:    [[CONV122:%.*]] = fpext float [[SUB121]] to double
; CHECK-NEXT:    [[MUL123:%.*]] = fmul fast double [[CONV122]], [[CONV122]]
; CHECK-NEXT:    [[ARRAYIDX124:%.*]] = getelementptr inbounds float, ptr [[T6]], i32 [[I_2132]]
; CHECK-NEXT:    [[T11:%.*]] = load float, ptr [[ARRAYIDX124]], align 4
; CHECK-NEXT:    [[CONV125:%.*]] = fpext float [[T11]] to double
; CHECK-NEXT:    [[MUL126:%.*]] = fmul fast double [[MUL123]], [[CONV125]]
; CHECK-NEXT:    [[SUB127]] = fsub fast double [[DVAL1_4131]], [[MUL126]]
; CHECK-NEXT:    [[INC129]] = add nuw nsw i32 [[I_2132]], 1
; CHECK-NEXT:    [[EXITCOND143:%.*]] = icmp eq i32 [[INC129]], [[T]]
; CHECK-NEXT:    br i1 [[EXITCOND143]], label [[OUTEREND]], label [[INNERLOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       outerend:
; CHECK-NEXT:    [[SUB127_LCSSA:%.*]] = phi double [ [[SUB127]], [[INNERLOOP]] ], [ [[TMP15]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    [[CONV138:%.*]] = fptosi double [[SUB127_LCSSA]] to i32
; CHECK-NEXT:    [[CALL142]] = add nuw nsw i32 [[SCORE_1135]], [[CONV138]]
; CHECK-NEXT:    [[INC144]] = add nuw nsw i32 [[J_0136]], 1
; CHECK-NEXT:    [[ARRAYIDX102:%.*]] = getelementptr inbounds i32, ptr @a, i32 [[INC144]]
; CHECK-NEXT:    [[V17]] = load i32, ptr [[ARRAYIDX102]], align 4
; CHECK-NEXT:    [[CMP103:%.*]] = icmp sgt i32 [[V17]], -1
; CHECK-NEXT:    br i1 [[CMP103]], label [[OUTERLOOP]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 [[CALL142]]
;
entry:
  %t = load i32, ptr @v, align 8
  %t1 = load i32, ptr @a, align 4
  br label %outerloop

outerloop:
  %t2 = phi i32 [ %v17, %outerend ], [ %t1, %entry ]
  %j.0136 = phi i32 [ %inc144, %outerend ], [ 0, %entry ]
  %score.1135 = phi i32 [ %call142, %outerend ], [ -939524096, %entry ]
  %t3 = load ptr, ptr @mm, align 4
  %arrayidx109 = getelementptr inbounds ptr, ptr %t3, i32 %t2
  %t4 = load ptr, ptr %arrayidx109, align 4
  %t5 = load ptr, ptr @vv, align 4
  %arrayidx111 = getelementptr inbounds ptr, ptr %t5, i32 %t2
  %t6 = load ptr, ptr %arrayidx111, align 4
  %t7 = load ptr, ptr @ll, align 4
  %arrayidx113 = getelementptr inbounds float, ptr %t7, i32 %t2
  %t8 = load float, ptr %arrayidx113, align 4
  %conv114 = fpext float %t8 to double
  br label %innerloop

innerloop:
  %i.2132 = phi i32 [ 0, %outerloop ], [ %inc129, %innerloop ]
  %dval1.4131 = phi double [ %conv114, %outerloop ], [ %sub127, %innerloop ]
  %arrayidx119 = getelementptr inbounds float, ptr %x, i32 %i.2132
  %t9 = load float, ptr %arrayidx119, align 4
  %arrayidx120 = getelementptr inbounds float, ptr %t4, i32 %i.2132
  %t10 = load float, ptr %arrayidx120, align 4
  %sub121 = fsub fast float %t9, %t10
  %conv122 = fpext float %sub121 to double
  %mul123 = fmul fast double %conv122, %conv122
  %arrayidx124 = getelementptr inbounds float, ptr %t6, i32 %i.2132
  %t11 = load float, ptr %arrayidx124, align 4
  %conv125 = fpext float %t11 to double
  %mul126 = fmul fast double %mul123, %conv125
  %sub127 = fsub fast double %dval1.4131, %mul126
  %inc129 = add nuw nsw i32 %i.2132, 1
  %exitcond143 = icmp eq i32 %inc129, %t
  br i1 %exitcond143, label %outerend, label %innerloop

outerend:
  %sub127.lcssa = phi double [ %sub127, %innerloop ]
  %conv138 = fptosi double %sub127.lcssa to i32
  %call142 = add nuw nsw i32 %score.1135, %conv138
  %inc144 = add nuw nsw i32 %j.0136, 1
  %arrayidx102 = getelementptr inbounds i32, ptr @a, i32 %inc144
  %v17 = load i32, ptr %arrayidx102, align 4
  %cmp103 = icmp sgt i32 %v17, -1
  br i1 %cmp103, label %outerloop, label %exit

exit:
  ret i32 %call142
}

