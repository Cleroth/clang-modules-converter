; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -passes=slp-vectorizer -slp-vectorize-non-power-of-2 -mtriple=x86_64-apple-macosx -S %s | FileCheck --check-prefixes=CHECK,NON-POW2 %s
; RUN: opt -passes=slp-vectorizer -slp-vectorize-non-power-of-2=false -mtriple=x86_64-apple-macosx -S %s | FileCheck --check-prefixes=CHECK,POW2-ONLY %s

%struct.zot = type { i32, i32, i32 }

define i1 @reorder_results(ptr %arg, i1 %arg1, ptr %arg2, i64 %arg3, ptr %arg4) {
; CHECK-LABEL: define i1 @reorder_results(
; CHECK-SAME: ptr [[ARG:%.*]], i1 [[ARG1:%.*]], ptr [[ARG2:%.*]], i64 [[ARG3:%.*]], ptr [[ARG4:%.*]]) {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[LOAD:%.*]] = load ptr, ptr [[ARG4]], align 8
; CHECK-NEXT:    [[LOAD4:%.*]] = load i32, ptr [[LOAD]], align 4
; CHECK-NEXT:    [[GETELEMENTPTR:%.*]] = getelementptr i8, ptr [[LOAD]], i64 4
; CHECK-NEXT:    [[LOAD5:%.*]] = load i32, ptr [[GETELEMENTPTR]], align 4
; CHECK-NEXT:    [[GETELEMENTPTR6:%.*]] = getelementptr i8, ptr [[LOAD]], i64 8
; CHECK-NEXT:    [[LOAD7:%.*]] = load i32, ptr [[GETELEMENTPTR6]], align 4
; CHECK-NEXT:    br i1 [[ARG1]], label [[BB12:%.*]], label [[BB9:%.*]]
; CHECK:       bb8:
; CHECK-NEXT:    ret i1 false
; CHECK:       bb9:
; CHECK-NEXT:    [[FREEZE:%.*]] = freeze ptr [[ARG]]
; CHECK-NEXT:    store i32 [[LOAD4]], ptr [[FREEZE]], align 4
; CHECK-NEXT:    [[GETELEMENTPTR10:%.*]] = getelementptr i8, ptr [[FREEZE]], i64 4
; CHECK-NEXT:    store i32 [[LOAD7]], ptr [[GETELEMENTPTR10]], align 4
; CHECK-NEXT:    [[GETELEMENTPTR11:%.*]] = getelementptr i8, ptr [[FREEZE]], i64 8
; CHECK-NEXT:    store i32 [[LOAD5]], ptr [[GETELEMENTPTR11]], align 4
; CHECK-NEXT:    br label [[BB8:%.*]]
; CHECK:       bb12:
; CHECK-NEXT:    [[GETELEMENTPTR13:%.*]] = getelementptr [[STRUCT_ZOT:%.*]], ptr [[ARG2]], i64 [[ARG3]]
; CHECK-NEXT:    store i32 [[LOAD4]], ptr [[GETELEMENTPTR13]], align 4
; CHECK-NEXT:    [[GETELEMENTPTR14:%.*]] = getelementptr i8, ptr [[GETELEMENTPTR13]], i64 4
; CHECK-NEXT:    store i32 [[LOAD7]], ptr [[GETELEMENTPTR14]], align 4
; CHECK-NEXT:    [[GETELEMENTPTR15:%.*]] = getelementptr i8, ptr [[GETELEMENTPTR13]], i64 8
; CHECK-NEXT:    store i32 [[LOAD5]], ptr [[GETELEMENTPTR15]], align 4
; CHECK-NEXT:    br label [[BB8]]
;
bb:
  %load = load ptr, ptr %arg4, align 8
  %load4 = load i32, ptr %load, align 4
  %getelementptr = getelementptr i8, ptr %load, i64 4
  %load5 = load i32, ptr %getelementptr, align 4
  %getelementptr6 = getelementptr i8, ptr %load, i64 8
  %load7 = load i32, ptr %getelementptr6, align 4
  br i1 %arg1, label %bb12, label %bb9

bb8:                                              ; preds = %bb12, %bb9
  ret i1 false

bb9:                                              ; preds = %bb
  %freeze = freeze ptr %arg
  store i32 %load4, ptr %freeze, align 4
  %getelementptr10 = getelementptr i8, ptr %freeze, i64 4
  store i32 %load7, ptr %getelementptr10, align 4
  %getelementptr11 = getelementptr i8, ptr %freeze, i64 8
  store i32 %load5, ptr %getelementptr11, align 4
  br label %bb8

bb12:                                             ; preds = %bb
  %getelementptr13 = getelementptr %struct.zot, ptr %arg2, i64 %arg3
  store i32 %load4, ptr %getelementptr13, align 4
  %getelementptr14 = getelementptr i8, ptr %getelementptr13, i64 4
  store i32 %load7, ptr %getelementptr14, align 4
  %getelementptr15 = getelementptr i8, ptr %getelementptr13, i64 8
  store i32 %load5, ptr %getelementptr15, align 4
  br label %bb8
}

define void @extract_mask(ptr %object, double %conv503, double %conv520) {
; CHECK-LABEL: define void @extract_mask(
; CHECK-SAME: ptr [[OBJECT:%.*]], double [[CONV503:%.*]], double [[CONV520:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[OBJECT]], align 8
; CHECK-NEXT:    [[BBOX483:%.*]] = getelementptr float, ptr [[TMP0]]
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x float>, ptr [[BBOX483]], align 8
; CHECK-NEXT:    [[TMP2:%.*]] = fpext <2 x float> [[TMP1]] to <2 x double>
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <2 x double> [[TMP2]], <2 x double> poison, <2 x i32> <i32 1, i32 0>
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <2 x double> [[TMP3]], double [[CONV503]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = fcmp ogt <2 x double> [[TMP4]], <double 0.000000e+00, double -2.000000e+10>
; CHECK-NEXT:    [[TMP6:%.*]] = select <2 x i1> [[TMP5]], <2 x double> [[TMP3]], <2 x double> <double 0.000000e+00, double -2.000000e+10>
; CHECK-NEXT:    [[TMP7:%.*]] = fsub <2 x double> zeroinitializer, [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = fptrunc <2 x double> [[TMP7]] to <2 x float>
; CHECK-NEXT:    [[TMP9:%.*]] = extractelement <2 x float> [[TMP8]], i32 0
; CHECK-NEXT:    [[TMP10:%.*]] = extractelement <2 x float> [[TMP8]], i32 1
; CHECK-NEXT:    [[MUL646:%.*]] = fmul float [[TMP9]], [[TMP10]]
; CHECK-NEXT:    [[CMP663:%.*]] = fcmp olt float [[MUL646]], 0.000000e+00
; CHECK-NEXT:    br i1 [[CMP663]], label [[IF_THEN665:%.*]], label [[IF_END668:%.*]]
; CHECK:       if.then665:
; CHECK-NEXT:    [[ARRAYIDX656:%.*]] = getelementptr float, ptr [[OBJECT]], i64 10
; CHECK-NEXT:    [[BBOX651:%.*]] = getelementptr float, ptr [[OBJECT]]
; CHECK-NEXT:    [[CONV613:%.*]] = fptrunc double [[CONV503]] to float
; CHECK-NEXT:    store float [[CONV613]], ptr [[BBOX651]], align 8
; CHECK-NEXT:    [[BBOX_SROA_6_0_BBOX666_SROA_IDX:%.*]] = getelementptr float, ptr [[OBJECT]], i64 1
; CHECK-NEXT:    [[TMP11:%.*]] = insertelement <2 x double> [[TMP6]], double [[CONV520]], i32 1
; CHECK-NEXT:    [[TMP12:%.*]] = fptrunc <2 x double> [[TMP11]] to <2 x float>
; CHECK-NEXT:    store <2 x float> [[TMP12]], ptr [[BBOX_SROA_6_0_BBOX666_SROA_IDX]], align 4
; CHECK-NEXT:    store <2 x float> [[TMP8]], ptr [[ARRAYIDX656]], align 8
; CHECK-NEXT:    br label [[IF_END668]]
; CHECK:       if.end668:
; CHECK-NEXT:    ret void
;
entry:
  %0 = load ptr, ptr %object, align 8
  %bbox483 = getelementptr float, ptr %0
  %1 = load float, ptr %bbox483, align 8
  %conv486 = fpext float %1 to double
  %cmp487 = fcmp ogt double %conv486, -2.000000e+10
  %conv486.2 = select i1 %cmp487, double %conv486, double -2.000000e+10
  %arrayidx502 = getelementptr float, ptr %0, i64 1
  %2 = load float, ptr %arrayidx502, align 4
  %conv5033 = fpext float %2 to double
  %cmp504 = fcmp ogt double %conv503, 0.000000e+00
  %cond514 = select i1 %cmp504, double %conv5033, double 0.000000e+00
  %sub626 = fsub double 0.000000e+00, %conv486.2
  %conv627 = fptrunc double %sub626 to float
  %sub632 = fsub double 0.000000e+00, %cond514
  %conv633 = fptrunc double %sub632 to float
  %mul646 = fmul float %conv633, %conv627
  %cmp663 = fcmp olt float %mul646, 0.000000e+00
  br i1 %cmp663, label %if.then665, label %if.end668

if.then665:                                       ; preds = %entry
  %arrayidx656 = getelementptr float, ptr %object, i64 10
  %lengths652 = getelementptr float, ptr %object, i64 11
  %bbox651 = getelementptr float, ptr %object
  %conv621 = fptrunc double %conv520 to float
  %conv617 = fptrunc double %cond514 to float
  %conv613 = fptrunc double %conv503 to float
  store float %conv613, ptr %bbox651, align 8
  %bbox.sroa.6.0.bbox666.sroa_idx = getelementptr float, ptr %object, i64 1
  store float %conv617, ptr %bbox.sroa.6.0.bbox666.sroa_idx, align 4
  %bbox.sroa.8.0.bbox666.sroa_idx = getelementptr float, ptr %object, i64 2
  store float %conv621, ptr %bbox.sroa.8.0.bbox666.sroa_idx, align 8
  store float %conv627, ptr %lengths652, align 4
  store float %conv633, ptr %arrayidx656, align 8
  br label %if.end668

if.end668:                                        ; preds = %if.then665, %entry
  ret void
}

define void @gather_2(ptr %mat1, float %0, float %1) {
; NON-POW2-LABEL: define void @gather_2(
; NON-POW2-SAME: ptr [[MAT1:%.*]], float [[TMP0:%.*]], float [[TMP1:%.*]]) {
; NON-POW2-NEXT:  entry:
; NON-POW2-NEXT:    [[TMP2:%.*]] = insertelement <3 x float> poison, float [[TMP0]], i32 0
; NON-POW2-NEXT:    [[TMP4:%.*]] = shufflevector <3 x float> [[TMP2]], <3 x float> poison, <3 x i32> zeroinitializer
; NON-POW2-NEXT:    [[TMP5:%.*]] = insertelement <3 x float> <float 0.000000e+00, float poison, float poison>, float [[TMP1]], i32 1
; NON-POW2-NEXT:    [[TMP6:%.*]] = shufflevector <3 x float> [[TMP5]], <3 x float> poison, <3 x i32> <i32 0, i32 1, i32 1>
; NON-POW2-NEXT:    [[TMP7:%.*]] = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> [[TMP4]], <3 x float> [[TMP6]], <3 x float> zeroinitializer)
; NON-POW2-NEXT:    [[ARRAYIDX163:%.*]] = getelementptr [4 x [4 x float]], ptr [[MAT1]], i64 0, i64 1
; NON-POW2-NEXT:    [[TMP8:%.*]] = fmul <3 x float> [[TMP7]], zeroinitializer
; NON-POW2-NEXT:    store <3 x float> [[TMP8]], ptr [[ARRAYIDX163]], align 4
; NON-POW2-NEXT:    ret void
;
; POW2-ONLY-LABEL: define void @gather_2(
; POW2-ONLY-SAME: ptr [[MAT1:%.*]], float [[TMP0:%.*]], float [[TMP1:%.*]]) {
; POW2-ONLY-NEXT:  entry:
; POW2-ONLY-NEXT:    [[TMP2:%.*]] = insertelement <2 x float> poison, float [[TMP0]], i32 0
; POW2-ONLY-NEXT:    [[TMP3:%.*]] = shufflevector <2 x float> [[TMP2]], <2 x float> poison, <2 x i32> zeroinitializer
; POW2-ONLY-NEXT:    [[TMP4:%.*]] = insertelement <2 x float> <float 0.000000e+00, float poison>, float [[TMP1]], i32 1
; POW2-ONLY-NEXT:    [[TMP5:%.*]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[TMP3]], <2 x float> [[TMP4]], <2 x float> zeroinitializer)
; POW2-ONLY-NEXT:    [[TMP6:%.*]] = call float @llvm.fmuladd.f32(float [[TMP0]], float [[TMP1]], float 0.000000e+00)
; POW2-ONLY-NEXT:    [[TMP7:%.*]] = fmul float [[TMP6]], 0.000000e+00
; POW2-ONLY-NEXT:    [[ARRAYIDX163:%.*]] = getelementptr [4 x [4 x float]], ptr [[MAT1]], i64 0, i64 1
; POW2-ONLY-NEXT:    [[ARRAYIDX5_I_I_I280:%.*]] = getelementptr [4 x [4 x float]], ptr [[MAT1]], i64 0, i64 1, i64 2
; POW2-ONLY-NEXT:    [[TMP8:%.*]] = fmul <2 x float> [[TMP5]], zeroinitializer
; POW2-ONLY-NEXT:    store <2 x float> [[TMP8]], ptr [[ARRAYIDX163]], align 4
; POW2-ONLY-NEXT:    store float [[TMP7]], ptr [[ARRAYIDX5_I_I_I280]], align 4
; POW2-ONLY-NEXT:    ret void
;
entry:
  %2 = call float @llvm.fmuladd.f32(float %0, float 0.000000e+00, float 0.000000e+00)
  %3 = call float @llvm.fmuladd.f32(float %1, float %0, float 0.000000e+00)
  %4 = call float @llvm.fmuladd.f32(float %0, float %1, float 0.000000e+00)
  %5 = fmul float %2, 0.000000e+00
  %6 = fmul float %3, 0.000000e+00
  %7 = fmul float %4, 0.000000e+00
  %arrayidx163 = getelementptr [4 x [4 x float]], ptr %mat1, i64 0, i64 1
  %arrayidx2.i.i.i278 = getelementptr [4 x [4 x float]], ptr %mat1, i64 0, i64 1, i64 1
  %arrayidx5.i.i.i280 = getelementptr [4 x [4 x float]], ptr %mat1, i64 0, i64 1, i64 2
  store float %5, ptr %arrayidx163, align 4
  store float %6, ptr %arrayidx2.i.i.i278, align 4
  store float %7, ptr %arrayidx5.i.i.i280, align 4
  ret void
}

define i32 @reorder_indices_1(float %0) {
; NON-POW2-LABEL: define i32 @reorder_indices_1(
; NON-POW2-SAME: float [[TMP0:%.*]]) {
; NON-POW2-NEXT:  entry:
; NON-POW2-NEXT:    [[NOR1:%.*]] = alloca [0 x [3 x float]], i32 0, align 4
; NON-POW2-NEXT:    [[TMP1:%.*]] = load <3 x float>, ptr [[NOR1]], align 4
; NON-POW2-NEXT:    [[TMP2:%.*]] = shufflevector <3 x float> [[TMP1]], <3 x float> poison, <3 x i32> <i32 1, i32 2, i32 0>
; NON-POW2-NEXT:    [[TMP3:%.*]] = fneg <3 x float> [[TMP2]]
; NON-POW2-NEXT:    [[TMP4:%.*]] = insertelement <3 x float> poison, float [[TMP0]], i32 0
; NON-POW2-NEXT:    [[TMP5:%.*]] = shufflevector <3 x float> [[TMP4]], <3 x float> poison, <3 x i32> zeroinitializer
; NON-POW2-NEXT:    [[TMP6:%.*]] = fmul <3 x float> [[TMP3]], [[TMP5]]
; NON-POW2-NEXT:    [[TMP7:%.*]] = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> [[TMP1]], <3 x float> zeroinitializer, <3 x float> [[TMP6]])
; NON-POW2-NEXT:    [[TMP8:%.*]] = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> [[TMP5]], <3 x float> [[TMP7]], <3 x float> zeroinitializer)
; NON-POW2-NEXT:    [[TMP9:%.*]] = fmul <3 x float> [[TMP8]], zeroinitializer
; NON-POW2-NEXT:    store <3 x float> [[TMP9]], ptr [[NOR1]], align 4
; NON-POW2-NEXT:    ret i32 0
;
; POW2-ONLY-LABEL: define i32 @reorder_indices_1(
; POW2-ONLY-SAME: float [[TMP0:%.*]]) {
; POW2-ONLY-NEXT:  entry:
; POW2-ONLY-NEXT:    [[NOR1:%.*]] = alloca [0 x [3 x float]], i32 0, align 4
; POW2-ONLY-NEXT:    [[ARRAYIDX2_I265:%.*]] = getelementptr float, ptr [[NOR1]], i64 2
; POW2-ONLY-NEXT:    [[TMP1:%.*]] = load float, ptr [[ARRAYIDX2_I265]], align 4
; POW2-ONLY-NEXT:    [[TMP2:%.*]] = load <2 x float>, ptr [[NOR1]], align 4
; POW2-ONLY-NEXT:    [[TMP3:%.*]] = extractelement <2 x float> [[TMP2]], i32 0
; POW2-ONLY-NEXT:    [[TMP4:%.*]] = fneg float [[TMP3]]
; POW2-ONLY-NEXT:    [[NEG11_I:%.*]] = fmul float [[TMP4]], [[TMP0]]
; POW2-ONLY-NEXT:    [[TMP5:%.*]] = call float @llvm.fmuladd.f32(float [[TMP1]], float 0.000000e+00, float [[NEG11_I]])
; POW2-ONLY-NEXT:    [[TMP6:%.*]] = shufflevector <2 x float> [[TMP2]], <2 x float> poison, <2 x i32> <i32 1, i32 poison>
; POW2-ONLY-NEXT:    [[TMP7:%.*]] = insertelement <2 x float> [[TMP6]], float [[TMP1]], i32 1
; POW2-ONLY-NEXT:    [[TMP8:%.*]] = fneg <2 x float> [[TMP7]]
; POW2-ONLY-NEXT:    [[TMP9:%.*]] = insertelement <2 x float> poison, float [[TMP0]], i32 0
; POW2-ONLY-NEXT:    [[TMP10:%.*]] = shufflevector <2 x float> [[TMP9]], <2 x float> poison, <2 x i32> zeroinitializer
; POW2-ONLY-NEXT:    [[TMP11:%.*]] = fmul <2 x float> [[TMP8]], [[TMP10]]
; POW2-ONLY-NEXT:    [[TMP12:%.*]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[TMP2]], <2 x float> zeroinitializer, <2 x float> [[TMP11]])
; POW2-ONLY-NEXT:    [[TMP13:%.*]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[TMP10]], <2 x float> [[TMP12]], <2 x float> zeroinitializer)
; POW2-ONLY-NEXT:    [[TMP14:%.*]] = call float @llvm.fmuladd.f32(float [[TMP0]], float [[TMP5]], float 0.000000e+00)
; POW2-ONLY-NEXT:    [[TMP15:%.*]] = fmul <2 x float> [[TMP13]], zeroinitializer
; POW2-ONLY-NEXT:    [[MUL6_I_I_I:%.*]] = fmul float [[TMP14]], 0.000000e+00
; POW2-ONLY-NEXT:    store <2 x float> [[TMP15]], ptr [[NOR1]], align 4
; POW2-ONLY-NEXT:    store float [[MUL6_I_I_I]], ptr [[ARRAYIDX2_I265]], align 4
; POW2-ONLY-NEXT:    ret i32 0
;
entry:
  %nor1 = alloca [0 x [3 x float]], i32 0, align 4
  %arrayidx.i = getelementptr float, ptr %nor1, i64 1
  %1 = load float, ptr %arrayidx.i, align 4
  %arrayidx2.i265 = getelementptr float, ptr %nor1, i64 2
  %2 = load float, ptr %arrayidx2.i265, align 4
  %3 = fneg float %2
  %neg.i267 = fmul float %3, %0
  %4 = call float @llvm.fmuladd.f32(float %1, float 0.000000e+00, float %neg.i267)
  %5 = load float, ptr %nor1, align 4
  %6 = fneg float %5
  %neg11.i = fmul float %6, %0
  %7 = call float @llvm.fmuladd.f32(float %2, float 0.000000e+00, float %neg11.i)
  %8 = fneg float %1
  %neg18.i = fmul float %8, %0
  %9 = call float @llvm.fmuladd.f32(float %5, float 0.000000e+00, float %neg18.i)
  %10 = call float @llvm.fmuladd.f32(float %0, float %9, float 0.000000e+00)
  %11 = call float @llvm.fmuladd.f32(float %0, float %4, float 0.000000e+00)
  %12 = call float @llvm.fmuladd.f32(float %0, float %7, float 0.000000e+00)
  %mul.i.i.i = fmul float %10, 0.000000e+00
  %mul3.i.i.i = fmul float %11, 0.000000e+00
  %mul6.i.i.i = fmul float %12, 0.000000e+00
  store float %mul.i.i.i, ptr %nor1, align 4
  store float %mul3.i.i.i, ptr %arrayidx.i, align 4
  store float %mul6.i.i.i, ptr %arrayidx2.i265, align 4
  ret i32 0
}

define void @reorder_indices_2(ptr %spoint) {
; NON-POW2-LABEL: define void @reorder_indices_2(
; NON-POW2-SAME: ptr [[SPOINT:%.*]]) {
; NON-POW2-NEXT:  entry:
; NON-POW2-NEXT:    [[DSCO:%.*]] = getelementptr float, ptr [[SPOINT]], i64 0
; NON-POW2-NEXT:    [[TMP0:%.*]] = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> zeroinitializer, <3 x float> zeroinitializer, <3 x float> zeroinitializer)
; NON-POW2-NEXT:    [[TMP1:%.*]] = fmul <3 x float> [[TMP0]], zeroinitializer
; NON-POW2-NEXT:    store <3 x float> [[TMP1]], ptr [[DSCO]], align 4
; NON-POW2-NEXT:    ret void
;
; POW2-ONLY-LABEL: define void @reorder_indices_2(
; POW2-ONLY-SAME: ptr [[SPOINT:%.*]]) {
; POW2-ONLY-NEXT:  entry:
; POW2-ONLY-NEXT:    [[TMP0:%.*]] = extractelement <3 x float> zeroinitializer, i64 0
; POW2-ONLY-NEXT:    [[TMP1:%.*]] = tail call float @llvm.fmuladd.f32(float [[TMP0]], float 0.000000e+00, float 0.000000e+00)
; POW2-ONLY-NEXT:    [[MUL4_I461:%.*]] = fmul float [[TMP1]], 0.000000e+00
; POW2-ONLY-NEXT:    [[DSCO:%.*]] = getelementptr float, ptr [[SPOINT]], i64 0
; POW2-ONLY-NEXT:    [[TMP2:%.*]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> zeroinitializer, <2 x float> zeroinitializer, <2 x float> zeroinitializer)
; POW2-ONLY-NEXT:    [[TMP3:%.*]] = fmul <2 x float> [[TMP2]], zeroinitializer
; POW2-ONLY-NEXT:    store <2 x float> [[TMP3]], ptr [[DSCO]], align 4
; POW2-ONLY-NEXT:    [[ARRAYIDX5_I476:%.*]] = getelementptr float, ptr [[SPOINT]], i64 2
; POW2-ONLY-NEXT:    store float [[MUL4_I461]], ptr [[ARRAYIDX5_I476]], align 4
; POW2-ONLY-NEXT:    ret void
;
entry:
  %0 = extractelement <3 x float> zeroinitializer, i64 1
  %1 = extractelement <3 x float> zeroinitializer, i64 2
  %2 = extractelement <3 x float> zeroinitializer, i64 0
  %3 = tail call float @llvm.fmuladd.f32(float %0, float 0.000000e+00, float 0.000000e+00)
  %4 = tail call float @llvm.fmuladd.f32(float %1, float 0.000000e+00, float 0.000000e+00)
  %5 = tail call float @llvm.fmuladd.f32(float %2, float 0.000000e+00, float 0.000000e+00)
  %mul.i457 = fmul float %3, 0.000000e+00
  %mul2.i459 = fmul float %4, 0.000000e+00
  %mul4.i461 = fmul float %5, 0.000000e+00
  %dsco = getelementptr float, ptr %spoint, i64 0
  store float %mul.i457, ptr %dsco, align 4
  %arrayidx3.i474 = getelementptr float, ptr %spoint, i64 1
  store float %mul2.i459, ptr %arrayidx3.i474, align 4
  %arrayidx5.i476 = getelementptr float, ptr %spoint, i64 2
  store float %mul4.i461, ptr %arrayidx5.i476, align 4
  ret void
}

define void @reorder_indices_2x_load(ptr %png_ptr, ptr %info_ptr) {
; CHECK-LABEL: define void @reorder_indices_2x_load(
; CHECK-SAME: ptr [[PNG_PTR:%.*]], ptr [[INFO_PTR:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[BIT_DEPTH:%.*]] = getelementptr i8, ptr [[INFO_PTR]], i64 0
; CHECK-NEXT:    [[TMP0:%.*]] = load i8, ptr [[BIT_DEPTH]], align 4
; CHECK-NEXT:    [[COLOR_TYPE:%.*]] = getelementptr i8, ptr [[INFO_PTR]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load i8, ptr [[COLOR_TYPE]], align 1
; CHECK-NEXT:    [[BIT_DEPTH37_I:%.*]] = getelementptr i8, ptr [[PNG_PTR]], i64 11
; CHECK-NEXT:    store i8 [[TMP0]], ptr [[BIT_DEPTH37_I]], align 1
; CHECK-NEXT:    [[COLOR_TYPE39_I:%.*]] = getelementptr i8, ptr [[PNG_PTR]], i64 10
; CHECK-NEXT:    store i8 [[TMP1]], ptr [[COLOR_TYPE39_I]], align 2
; CHECK-NEXT:    [[USR_BIT_DEPTH_I:%.*]] = getelementptr i8, ptr [[PNG_PTR]], i64 12
; CHECK-NEXT:    store i8 [[TMP0]], ptr [[USR_BIT_DEPTH_I]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %bit_depth = getelementptr i8, ptr %info_ptr, i64 0
  %0 = load i8, ptr %bit_depth, align 4
  %color_type = getelementptr i8, ptr %info_ptr, i64 1
  %1 = load i8, ptr %color_type, align 1
  %bit_depth37.i = getelementptr i8, ptr %png_ptr, i64 11
  store i8 %0, ptr %bit_depth37.i, align 1
  %color_type39.i = getelementptr i8, ptr %png_ptr, i64 10
  store i8 %1, ptr %color_type39.i, align 2
  %usr_bit_depth.i = getelementptr i8, ptr %png_ptr, i64 12
  store i8 %0, ptr %usr_bit_depth.i, align 8
  ret void
}

define void @reuse_shuffle_indidces_1(ptr %col, float %0, float %1) {
; NON-POW2-LABEL: define void @reuse_shuffle_indidces_1(
; NON-POW2-SAME: ptr [[COL:%.*]], float [[TMP0:%.*]], float [[TMP1:%.*]]) {
; NON-POW2-NEXT:  entry:
; NON-POW2-NEXT:    [[TMP2:%.*]] = insertelement <3 x float> poison, float [[TMP1]], i32 0
; NON-POW2-NEXT:    [[TMP3:%.*]] = insertelement <3 x float> [[TMP2]], float [[TMP0]], i32 1
; NON-POW2-NEXT:    [[TMP4:%.*]] = shufflevector <3 x float> [[TMP3]], <3 x float> poison, <3 x i32> <i32 0, i32 1, i32 1>
; NON-POW2-NEXT:    [[TMP5:%.*]] = fmul <3 x float> [[TMP4]], zeroinitializer
; NON-POW2-NEXT:    [[TMP6:%.*]] = fadd <3 x float> [[TMP5]], zeroinitializer
; NON-POW2-NEXT:    store <3 x float> [[TMP6]], ptr [[COL]], align 4
; NON-POW2-NEXT:    ret void
;
; POW2-ONLY-LABEL: define void @reuse_shuffle_indidces_1(
; POW2-ONLY-SAME: ptr [[COL:%.*]], float [[TMP0:%.*]], float [[TMP1:%.*]]) {
; POW2-ONLY-NEXT:  entry:
; POW2-ONLY-NEXT:    [[TMP2:%.*]] = insertelement <2 x float> poison, float [[TMP1]], i32 0
; POW2-ONLY-NEXT:    [[TMP3:%.*]] = insertelement <2 x float> [[TMP2]], float [[TMP0]], i32 1
; POW2-ONLY-NEXT:    [[TMP4:%.*]] = fmul <2 x float> [[TMP3]], zeroinitializer
; POW2-ONLY-NEXT:    [[TMP5:%.*]] = fadd <2 x float> [[TMP4]], zeroinitializer
; POW2-ONLY-NEXT:    store <2 x float> [[TMP5]], ptr [[COL]], align 4
; POW2-ONLY-NEXT:    [[ARRAYIDX33:%.*]] = getelementptr float, ptr [[COL]], i64 2
; POW2-ONLY-NEXT:    [[MUL38:%.*]] = fmul float [[TMP0]], 0.000000e+00
; POW2-ONLY-NEXT:    [[TMP6:%.*]] = fadd float [[MUL38]], 0.000000e+00
; POW2-ONLY-NEXT:    store float [[TMP6]], ptr [[ARRAYIDX33]], align 4
; POW2-ONLY-NEXT:    ret void
;
entry:
  %mul24 = fmul float %1, 0.000000e+00
  %2 = fadd float %mul24, 0.000000e+00
  store float %2, ptr %col, align 4
  %arrayidx26 = getelementptr float, ptr %col, i64 1
  %mul31 = fmul float %0, 0.000000e+00
  %3 = fadd float %mul31, 0.000000e+00
  store float %3, ptr %arrayidx26, align 4
  %arrayidx33 = getelementptr float, ptr %col, i64 2
  %mul38 = fmul float %0, 0.000000e+00
  %4 = fadd float %mul38, 0.000000e+00
  store float %4, ptr %arrayidx33, align 4
  ret void
}

define void @reuse_shuffle_indices_2(ptr %inertia, double %0) {
; CHECK-LABEL: define void @reuse_shuffle_indices_2(
; CHECK-SAME: ptr [[INERTIA:%.*]], double [[TMP0:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP1:%.*]] = insertelement <2 x double> poison, double [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x double> [[TMP1]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP3:%.*]] = fptrunc <2 x double> [[TMP2]] to <2 x float>
; CHECK-NEXT:    [[TMP4:%.*]] = fmul <2 x float> [[TMP3]], zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x float> [[TMP4]], <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 1, i32 poison>
; CHECK-NEXT:    [[TMP6:%.*]] = fadd <4 x float> [[TMP5]], <float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float undef>
; CHECK-NEXT:    [[TMP7:%.*]] = fmul <4 x float> [[TMP6]], <float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float undef>
; CHECK-NEXT:    [[TMP8:%.*]] = fadd <4 x float> [[TMP7]], <float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float undef>
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <4 x float> [[TMP8]], <4 x float> poison, <3 x i32> <i32 0, i32 1, i32 2>
; CHECK-NEXT:    store <3 x float> [[TMP9]], ptr [[INERTIA]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %1 = insertelement <2 x double> poison, double %0, i32 0
  %2 = shufflevector <2 x double> %1, <2 x double> poison, <2 x i32> zeroinitializer
  %3 = fptrunc <2 x double> %2 to <2 x float>
  %4 = fmul <2 x float> %3, zeroinitializer
  %5 = shufflevector <2 x float> %4, <2 x float> poison, <4 x i32> <i32 0, i32 1, i32 1, i32 poison>
  %6 = fadd <4 x float> %5, <float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float undef>
  %7 = fmul <4 x float> %6, <float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float undef>
  %8 = fadd <4 x float> %7, <float 0.000000e+00, float 0.000000e+00, float 0.000000e+00, float undef>
  %9 = shufflevector <4 x float> %8, <4 x float> poison, <3 x i32> <i32 0, i32 1, i32 2>
  store <3 x float> %9, ptr %inertia, align 4
  ret void
}

define void @reuse_shuffle_indices_cost_crash_2(ptr %bezt, float %0) {
; NON-POW2-LABEL: define void @reuse_shuffle_indices_cost_crash_2(
; NON-POW2-SAME: ptr [[BEZT:%.*]], float [[TMP0:%.*]]) {
; NON-POW2-NEXT:  entry:
; NON-POW2-NEXT:    [[FNEG:%.*]] = fmul float [[TMP0]], 0.000000e+00
; NON-POW2-NEXT:    [[TMP1:%.*]] = insertelement <3 x float> poison, float [[FNEG]], i32 0
; NON-POW2-NEXT:    [[TMP2:%.*]] = shufflevector <3 x float> [[TMP1]], <3 x float> poison, <3 x i32> zeroinitializer
; NON-POW2-NEXT:    [[TMP3:%.*]] = insertelement <3 x float> <float poison, float poison, float 0.000000e+00>, float [[TMP0]], i32 0
; NON-POW2-NEXT:    [[TMP4:%.*]] = shufflevector <3 x float> [[TMP3]], <3 x float> poison, <3 x i32> <i32 0, i32 0, i32 2>
; NON-POW2-NEXT:    [[TMP5:%.*]] = call <3 x float> @llvm.fmuladd.v3f32(<3 x float> [[TMP2]], <3 x float> [[TMP4]], <3 x float> zeroinitializer)
; NON-POW2-NEXT:    store <3 x float> [[TMP5]], ptr [[BEZT]], align 4
; NON-POW2-NEXT:    ret void
;
; POW2-ONLY-LABEL: define void @reuse_shuffle_indices_cost_crash_2(
; POW2-ONLY-SAME: ptr [[BEZT:%.*]], float [[TMP0:%.*]]) {
; POW2-ONLY-NEXT:  entry:
; POW2-ONLY-NEXT:    [[FNEG:%.*]] = fmul float [[TMP0]], 0.000000e+00
; POW2-ONLY-NEXT:    [[TMP1:%.*]] = insertelement <2 x float> poison, float [[TMP0]], i32 0
; POW2-ONLY-NEXT:    [[TMP2:%.*]] = shufflevector <2 x float> [[TMP1]], <2 x float> poison, <2 x i32> zeroinitializer
; POW2-ONLY-NEXT:    [[TMP3:%.*]] = insertelement <2 x float> poison, float [[FNEG]], i32 0
; POW2-ONLY-NEXT:    [[TMP4:%.*]] = shufflevector <2 x float> [[TMP3]], <2 x float> poison, <2 x i32> zeroinitializer
; POW2-ONLY-NEXT:    [[TMP5:%.*]] = call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[TMP2]], <2 x float> [[TMP4]], <2 x float> zeroinitializer)
; POW2-ONLY-NEXT:    store <2 x float> [[TMP5]], ptr [[BEZT]], align 4
; POW2-ONLY-NEXT:    [[TMP6:%.*]] = tail call float @llvm.fmuladd.f32(float [[FNEG]], float 0.000000e+00, float 0.000000e+00)
; POW2-ONLY-NEXT:    [[ARRAYIDX8_I831:%.*]] = getelementptr float, ptr [[BEZT]], i64 2
; POW2-ONLY-NEXT:    store float [[TMP6]], ptr [[ARRAYIDX8_I831]], align 4
; POW2-ONLY-NEXT:    ret void
;
entry:
  %fneg = fmul float %0, 0.000000e+00
  %1 = tail call float @llvm.fmuladd.f32(float %0, float %fneg, float 0.000000e+00)
  store float %1, ptr %bezt, align 4
  %2 = tail call float @llvm.fmuladd.f32(float %0, float %fneg, float 0.000000e+00)
  %arrayidx5.i = getelementptr float, ptr %bezt, i64 1
  store float %2, ptr %arrayidx5.i, align 4
  %3 = tail call float @llvm.fmuladd.f32(float %fneg, float 0.000000e+00, float 0.000000e+00)
  %arrayidx8.i831 = getelementptr float, ptr %bezt, i64 2
  store float %3, ptr %arrayidx8.i831, align 4
  ret void
}

define void @reuse_shuffle_indices_cost_crash_3(ptr %m, double %conv, double %conv2) {
; CHECK-LABEL: define void @reuse_shuffle_indices_cost_crash_3(
; CHECK-SAME: ptr [[M:%.*]], double [[CONV:%.*]], double [[CONV2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB19:%.*]] = fsub double 0.000000e+00, [[CONV2]]
; CHECK-NEXT:    [[CONV20:%.*]] = fptrunc double [[SUB19]] to float
; CHECK-NEXT:    store float [[CONV20]], ptr [[M]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = fadd double [[CONV]], 0.000000e+00
; CHECK-NEXT:    [[CONV239:%.*]] = fptrunc double [[ADD]] to float
; CHECK-NEXT:    [[ARRAYIDX25:%.*]] = getelementptr [4 x float], ptr [[M]], i64 0, i64 1
; CHECK-NEXT:    store float [[CONV239]], ptr [[ARRAYIDX25]], align 4
; CHECK-NEXT:    [[ADD26:%.*]] = fsub double [[CONV]], [[CONV]]
; CHECK-NEXT:    [[CONV27:%.*]] = fptrunc double [[ADD26]] to float
; CHECK-NEXT:    [[ARRAYIDX29:%.*]] = getelementptr [4 x float], ptr [[M]], i64 0, i64 2
; CHECK-NEXT:    store float [[CONV27]], ptr [[ARRAYIDX29]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %sub19 = fsub double 0.000000e+00, %conv2
  %conv20 = fptrunc double %sub19 to float
  store float %conv20, ptr %m, align 4
  %add = fadd double %conv, 0.000000e+00
  %conv239 = fptrunc double %add to float
  %arrayidx25 = getelementptr [4 x float], ptr %m, i64 0, i64 1
  store float %conv239, ptr %arrayidx25, align 4
  %add26 = fsub double %conv, %conv
  %conv27 = fptrunc double %add26 to float
  %arrayidx29 = getelementptr [4 x float], ptr %m, i64 0, i64 2
  store float %conv27, ptr %arrayidx29, align 4
  ret void
}

define void @reuse_shuffle_indices_cost_crash_4(double %conv7.i) {
; CHECK-LABEL: define void @reuse_shuffle_indices_cost_crash_4(
; CHECK-SAME: double [[CONV7_I:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[DATA_I111:%.*]] = alloca [0 x [0 x [0 x [3 x float]]]], i32 0, align 4
; CHECK-NEXT:    [[ARRAYIDX_2_I:%.*]] = getelementptr [3 x float], ptr [[DATA_I111]], i64 0, i64 2
; CHECK-NEXT:    [[MUL17_I_US:%.*]] = fmul double [[CONV7_I]], 0.000000e+00
; CHECK-NEXT:    [[MUL_2_I_I_US:%.*]] = fmul double [[MUL17_I_US]], 0.000000e+00
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <2 x double> poison, double [[CONV7_I]], i32 0
; CHECK-NEXT:    [[TMP1:%.*]] = shufflevector <2 x double> [[TMP0]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[TMP2:%.*]] = fadd <2 x double> [[TMP1]], zeroinitializer
; CHECK-NEXT:    [[ADD_2_I_I_US:%.*]] = fadd double [[MUL_2_I_I_US]], 0.000000e+00
; CHECK-NEXT:    [[TMP3:%.*]] = fmul <2 x double> [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[TMP4:%.*]] = fadd <2 x double> [[TMP3]], zeroinitializer
; CHECK-NEXT:    [[TMP5:%.*]] = fptrunc <2 x double> [[TMP4]] to <2 x float>
; CHECK-NEXT:    store <2 x float> [[TMP5]], ptr [[DATA_I111]], align 4
; CHECK-NEXT:    [[CONV_2_I46_US:%.*]] = fptrunc double [[ADD_2_I_I_US]] to float
; CHECK-NEXT:    store float [[CONV_2_I46_US]], ptr [[ARRAYIDX_2_I]], align 4
; CHECK-NEXT:    [[CALL2_I_US:%.*]] = load volatile ptr, ptr [[DATA_I111]], align 8
; CHECK-NEXT:    ret void
;
entry:
  %data.i111 = alloca [0 x [0 x [0 x [3 x float]]]], i32 0, align 4
  %arrayidx.1.i = getelementptr [3 x float], ptr %data.i111, i64 0, i64 1
  %arrayidx.2.i = getelementptr [3 x float], ptr %data.i111, i64 0, i64 2
  %mul17.i.us = fmul double %conv7.i, 0.000000e+00
  %mul.2.i.i.us = fmul double %mul17.i.us, 0.000000e+00
  %add.i.i82.i.us = fadd double %conv7.i, 0.000000e+00
  %add.1.i.i84.i.us = fadd double %conv7.i, 0.000000e+00
  %mul.i.i91.i.us = fmul double %add.i.i82.i.us, %conv7.i
  %mul.1.i.i92.i.us = fmul double %add.1.i.i84.i.us, %conv7.i
  %add.i96.i.us = fadd double %mul.i.i91.i.us, 0.000000e+00
  %add.1.i.i.us = fadd double %mul.1.i.i92.i.us, 0.000000e+00
  %add.2.i.i.us = fadd double %mul.2.i.i.us, 0.000000e+00
  %conv.i42.us = fptrunc double %add.i96.i.us to float
  store float %conv.i42.us, ptr %data.i111, align 4
  %conv.1.i44.us = fptrunc double %add.1.i.i.us to float
  store float %conv.1.i44.us, ptr %arrayidx.1.i, align 4
  %conv.2.i46.us = fptrunc double %add.2.i.i.us to float
  store float %conv.2.i46.us, ptr %arrayidx.2.i, align 4
  %call2.i.us = load volatile ptr, ptr %data.i111, align 8
  ret void
}

define void @common_mask(ptr %m, double %conv, double %conv2) {
; CHECK-LABEL: define void @common_mask(
; CHECK-SAME: ptr [[M:%.*]], double [[CONV:%.*]], double [[CONV2:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SUB19:%.*]] = fsub double [[CONV]], [[CONV]]
; CHECK-NEXT:    [[CONV20:%.*]] = fptrunc double [[SUB19]] to float
; CHECK-NEXT:    store float [[CONV20]], ptr [[M]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = fadd double [[CONV2]], 0.000000e+00
; CHECK-NEXT:    [[CONV239:%.*]] = fptrunc double [[ADD]] to float
; CHECK-NEXT:    [[ARRAYIDX25:%.*]] = getelementptr [4 x float], ptr [[M]], i64 0, i64 1
; CHECK-NEXT:    store float [[CONV239]], ptr [[ARRAYIDX25]], align 4
; CHECK-NEXT:    [[ADD26:%.*]] = fsub double 0.000000e+00, [[CONV]]
; CHECK-NEXT:    [[CONV27:%.*]] = fptrunc double [[ADD26]] to float
; CHECK-NEXT:    [[ARRAYIDX29:%.*]] = getelementptr [4 x float], ptr [[M]], i64 0, i64 2
; CHECK-NEXT:    store float [[CONV27]], ptr [[ARRAYIDX29]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %sub19 = fsub double %conv, %conv
  %conv20 = fptrunc double %sub19 to float
  store float %conv20, ptr %m, align 4
  %add = fadd double %conv2, 0.000000e+00
  %conv239 = fptrunc double %add to float
  %arrayidx25 = getelementptr [4 x float], ptr %m, i64 0, i64 1
  store float %conv239, ptr %arrayidx25, align 4
  %add26 = fsub double 0.000000e+00, %conv
  %conv27 = fptrunc double %add26 to float
  %arrayidx29 = getelementptr [4 x float], ptr %m, i64 0, i64 2
  store float %conv27, ptr %arrayidx29, align 4
  ret void
}

define void @vec3_extract(<3 x i16> %pixel.sroa.0.4.vec.insert606, ptr %call3.i536) {
; NON-POW2-LABEL: define void @vec3_extract(
; NON-POW2-SAME: <3 x i16> [[PIXEL_SROA_0_4_VEC_INSERT606:%.*]], ptr [[CALL3_I536:%.*]]) {
; NON-POW2-NEXT:  entry:
; NON-POW2-NEXT:    store <3 x i16> [[PIXEL_SROA_0_4_VEC_INSERT606]], ptr [[CALL3_I536]], align 2
; NON-POW2-NEXT:    ret void
;
; POW2-ONLY-LABEL: define void @vec3_extract(
; POW2-ONLY-SAME: <3 x i16> [[PIXEL_SROA_0_4_VEC_INSERT606:%.*]], ptr [[CALL3_I536:%.*]]) {
; POW2-ONLY-NEXT:  entry:
; POW2-ONLY-NEXT:    [[PIXEL_SROA_0_4_VEC_EXTRACT:%.*]] = extractelement <3 x i16> [[PIXEL_SROA_0_4_VEC_INSERT606]], i64 2
; POW2-ONLY-NEXT:    [[RED668:%.*]] = getelementptr i16, ptr [[CALL3_I536]], i64 2
; POW2-ONLY-NEXT:    store i16 [[PIXEL_SROA_0_4_VEC_EXTRACT]], ptr [[RED668]], align 2
; POW2-ONLY-NEXT:    [[TMP0:%.*]] = shufflevector <3 x i16> [[PIXEL_SROA_0_4_VEC_INSERT606]], <3 x i16> poison, <2 x i32> <i32 0, i32 1>
; POW2-ONLY-NEXT:    store <2 x i16> [[TMP0]], ptr [[CALL3_I536]], align 2
; POW2-ONLY-NEXT:    ret void
;
entry:
  %pixel.sroa.0.4.vec.extract = extractelement <3 x i16> %pixel.sroa.0.4.vec.insert606, i64 2
  %red668 = getelementptr i16, ptr %call3.i536, i64 2
  store i16 %pixel.sroa.0.4.vec.extract, ptr %red668, align 2
  %pixel.sroa.0.2.vec.extract = extractelement <3 x i16> %pixel.sroa.0.4.vec.insert606, i64 1
  %green670 = getelementptr i16, ptr %call3.i536, i64 1
  store i16 %pixel.sroa.0.2.vec.extract, ptr %green670, align 2
  %pixel.sroa.0.0.vec.extract = extractelement <3 x i16> %pixel.sroa.0.4.vec.insert606, i64 0
  store i16 %pixel.sroa.0.0.vec.extract, ptr %call3.i536, align 2
  ret void
}

declare float @llvm.fmuladd.f32(float, float, float)
