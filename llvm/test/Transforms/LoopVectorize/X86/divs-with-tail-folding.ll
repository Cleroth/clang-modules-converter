; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -p loop-vectorize -mtriple x86_64 -prefer-predicate-over-epilogue=predicate-dont-vectorize -mcpu=skylake-avx512 -S %s | FileCheck %s

define void @sdiv_feeding_gep(ptr %dst, i32 %x, i64 %M, i64 %conv6, i64 %N) {
; CHECK-LABEL: define void @sdiv_feeding_gep(
; CHECK-SAME: ptr [[DST:%.*]], i32 [[X:%.*]], i64 [[M:%.*]], i64 [[CONV6:%.*]], i64 [[N:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[CONV61:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_SCEVCHECK:.*]]
; CHECK:       [[VECTOR_SCEVCHECK]]:
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[N]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt i32 [[TMP1]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ugt i64 [[TMP0]], 4294967295
; CHECK-NEXT:    [[TMP4:%.*]] = or i1 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    br i1 [[TMP4]], label %[[SCALAR_PH]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 [[N]], 3
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TRIP_COUNT_MINUS_1:%.*]] = sub i64 [[N]], 1
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT1:%.*]] = insertelement <4 x i64> poison, i64 [[TRIP_COUNT_MINUS_1]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT2:%.*]] = shufflevector <4 x i64> [[BROADCAST_SPLATINSERT1]], <4 x i64> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i64> poison, i64 [[INDEX]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i64> [[BROADCAST_SPLATINSERT]], <4 x i64> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[VEC_IV:%.*]] = add <4 x i64> [[BROADCAST_SPLAT]], <i64 0, i64 1, i64 2, i64 3>
; CHECK-NEXT:    [[TMP6:%.*]] = icmp ule <4 x i64> [[VEC_IV]], [[BROADCAST_SPLAT2]]
; CHECK-NEXT:    [[TMP17:%.*]] = sdiv i64 [[M]], [[CONV6]]
; CHECK-NEXT:    [[TMP19:%.*]] = trunc i64 [[TMP17]] to i32
; CHECK-NEXT:    [[TMP20:%.*]] = mul i64 [[TMP17]], [[CONV61]]
; CHECK-NEXT:    [[TMP21:%.*]] = sub i64 [[TMP5]], [[TMP20]]
; CHECK-NEXT:    [[TMP22:%.*]] = trunc i64 [[TMP21]] to i32
; CHECK-NEXT:    [[TMP23:%.*]] = mul i32 [[X]], [[TMP19]]
; CHECK-NEXT:    [[TMP24:%.*]] = add i32 [[TMP23]], [[TMP22]]
; CHECK-NEXT:    [[TMP25:%.*]] = sext i32 [[TMP24]] to i64
; CHECK-NEXT:    [[TMP26:%.*]] = getelementptr double, ptr [[DST]], i64 [[TMP25]]
; CHECK-NEXT:    [[TMP27:%.*]] = getelementptr double, ptr [[TMP26]], i32 0
; CHECK-NEXT:    call void @llvm.masked.store.v4f64.p0(<4 x double> zeroinitializer, ptr [[TMP27]], i32 8, <4 x i1> [[TMP6]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[TMP28:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP28]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br i1 true, label %[[EXIT:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ], [ 0, %[[VECTOR_SCEVCHECK]] ]
; CHECK-NEXT:    br label %[[LOOP:.*]]
; CHECK:       [[LOOP]]:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], %[[LOOP]] ]
; CHECK-NEXT:    [[DIV18:%.*]] = sdiv i64 [[M]], [[CONV6]]
; CHECK-NEXT:    [[CONV20:%.*]] = trunc i64 [[DIV18]] to i32
; CHECK-NEXT:    [[MUL30:%.*]] = mul i64 [[DIV18]], [[CONV61]]
; CHECK-NEXT:    [[SUB31:%.*]] = sub i64 [[IV]], [[MUL30]]
; CHECK-NEXT:    [[CONV34:%.*]] = trunc i64 [[SUB31]] to i32
; CHECK-NEXT:    [[MUL35:%.*]] = mul i32 [[X]], [[CONV20]]
; CHECK-NEXT:    [[ADD36:%.*]] = add i32 [[MUL35]], [[CONV34]]
; CHECK-NEXT:    [[IDXPROM:%.*]] = sext i32 [[ADD36]] to i64
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr double, ptr [[DST]], i64 [[IDXPROM]]
; CHECK-NEXT:    store double 0.000000e+00, ptr [[GEP]], align 8
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp eq i64 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EC]], label %[[EXIT]], label %[[LOOP]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  %conv61 = zext i32 %x to i64
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %div18 = sdiv i64 %M, %conv6
  %conv20 = trunc i64 %div18 to i32
  %mul30 = mul i64 %div18, %conv61
  %sub31 = sub i64 %iv, %mul30
  %conv34 = trunc i64 %sub31 to i32
  %mul35 = mul i32 %x, %conv20
  %add36 = add i32 %mul35, %conv34
  %idxprom = sext i32 %add36 to i64
  %gep = getelementptr double, ptr %dst, i64 %idxprom
  store double 0.000000e+00, ptr %gep, align 8
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, %N
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @sdiv_feeding_gep_predicated(ptr %dst, i32 %x, i64 %M, i64 %conv6, i64 %N) {
; CHECK-LABEL: define void @sdiv_feeding_gep_predicated(
; CHECK-SAME: ptr [[DST:%.*]], i32 [[X:%.*]], i64 [[M:%.*]], i64 [[CONV6:%.*]], i64 [[N:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[CONV61:%.*]] = zext i32 [[X]] to i64
; CHECK-NEXT:    br i1 false, label %[[SCALAR_PH:.*]], label %[[VECTOR_SCEVCHECK:.*]]
; CHECK:       [[VECTOR_SCEVCHECK]]:
; CHECK-NEXT:    [[TMP0:%.*]] = add i64 [[N]], -1
; CHECK-NEXT:    [[TMP1:%.*]] = trunc i64 [[TMP0]] to i32
; CHECK-NEXT:    [[TMP2:%.*]] = icmp slt i32 [[TMP1]], 0
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ugt i64 [[TMP0]], 4294967295
; CHECK-NEXT:    [[TMP4:%.*]] = or i1 [[TMP2]], [[TMP3]]
; CHECK-NEXT:    br i1 [[TMP4]], label %[[SCALAR_PH]], label %[[VECTOR_PH:.*]]
; CHECK:       [[VECTOR_PH]]:
; CHECK-NEXT:    [[N_RND_UP:%.*]] = add i64 [[N]], 3
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i64 [[N_RND_UP]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i64 [[N_RND_UP]], [[N_MOD_VF]]
; CHECK-NEXT:    [[TRIP_COUNT_MINUS_1:%.*]] = sub i64 [[N]], 1
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT:%.*]] = insertelement <4 x i64> poison, i64 [[TRIP_COUNT_MINUS_1]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT:%.*]] = shufflevector <4 x i64> [[BROADCAST_SPLATINSERT]], <4 x i64> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT1:%.*]] = insertelement <4 x i64> poison, i64 [[M]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT2:%.*]] = shufflevector <4 x i64> [[BROADCAST_SPLATINSERT1]], <4 x i64> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    br label %[[VECTOR_BODY:.*]]
; CHECK:       [[VECTOR_BODY]]:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i64 [ 0, %[[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], %[[PRED_SDIV_CONTINUE8:.*]] ]
; CHECK-NEXT:    [[VEC_IND:%.*]] = phi <4 x i64> [ <i64 0, i64 1, i64 2, i64 3>, %[[VECTOR_PH]] ], [ [[VEC_IND_NEXT:%.*]], %[[PRED_SDIV_CONTINUE8]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = add i64 [[INDEX]], 0
; CHECK-NEXT:    [[TMP6:%.*]] = icmp ule <4 x i64> [[VEC_IND]], [[BROADCAST_SPLAT]]
; CHECK-NEXT:    [[TMP7:%.*]] = icmp ule <4 x i64> [[VEC_IND]], [[BROADCAST_SPLAT2]]
; CHECK-NEXT:    [[TMP8:%.*]] = select <4 x i1> [[TMP6]], <4 x i1> [[TMP7]], <4 x i1> zeroinitializer
; CHECK-NEXT:    [[TMP9:%.*]] = extractelement <4 x i1> [[TMP8]], i32 0
; CHECK-NEXT:    br i1 [[TMP9]], label %[[PRED_SDIV_IF:.*]], label %[[PRED_SDIV_CONTINUE:.*]]
; CHECK:       [[PRED_SDIV_IF]]:
; CHECK-NEXT:    [[TMP10:%.*]] = sdiv i64 [[M]], [[CONV6]]
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE]]
; CHECK:       [[PRED_SDIV_CONTINUE]]:
; CHECK-NEXT:    [[TMP11:%.*]] = phi i64 [ poison, %[[VECTOR_BODY]] ], [ [[TMP10]], %[[PRED_SDIV_IF]] ]
; CHECK-NEXT:    [[TMP12:%.*]] = extractelement <4 x i1> [[TMP8]], i32 1
; CHECK-NEXT:    br i1 [[TMP12]], label %[[PRED_SDIV_IF3:.*]], label %[[PRED_SDIV_CONTINUE4:.*]]
; CHECK:       [[PRED_SDIV_IF3]]:
; CHECK-NEXT:    [[TMP13:%.*]] = sdiv i64 [[M]], [[CONV6]]
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE4]]
; CHECK:       [[PRED_SDIV_CONTINUE4]]:
; CHECK-NEXT:    [[TMP14:%.*]] = phi i64 [ poison, %[[PRED_SDIV_CONTINUE]] ], [ [[TMP13]], %[[PRED_SDIV_IF3]] ]
; CHECK-NEXT:    [[TMP15:%.*]] = extractelement <4 x i1> [[TMP8]], i32 2
; CHECK-NEXT:    br i1 [[TMP15]], label %[[PRED_SDIV_IF5:.*]], label %[[PRED_SDIV_CONTINUE6:.*]]
; CHECK:       [[PRED_SDIV_IF5]]:
; CHECK-NEXT:    [[TMP16:%.*]] = sdiv i64 [[M]], [[CONV6]]
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE6]]
; CHECK:       [[PRED_SDIV_CONTINUE6]]:
; CHECK-NEXT:    [[TMP17:%.*]] = phi i64 [ poison, %[[PRED_SDIV_CONTINUE4]] ], [ [[TMP16]], %[[PRED_SDIV_IF5]] ]
; CHECK-NEXT:    [[TMP18:%.*]] = extractelement <4 x i1> [[TMP8]], i32 3
; CHECK-NEXT:    br i1 [[TMP18]], label %[[PRED_SDIV_IF7:.*]], label %[[PRED_SDIV_CONTINUE8]]
; CHECK:       [[PRED_SDIV_IF7]]:
; CHECK-NEXT:    [[TMP19:%.*]] = sdiv i64 [[M]], [[CONV6]]
; CHECK-NEXT:    br label %[[PRED_SDIV_CONTINUE8]]
; CHECK:       [[PRED_SDIV_CONTINUE8]]:
; CHECK-NEXT:    [[TMP20:%.*]] = phi i64 [ poison, %[[PRED_SDIV_CONTINUE6]] ], [ [[TMP19]], %[[PRED_SDIV_IF7]] ]
; CHECK-NEXT:    [[TMP21:%.*]] = trunc i64 [[TMP11]] to i32
; CHECK-NEXT:    [[TMP22:%.*]] = mul i64 [[TMP11]], [[CONV61]]
; CHECK-NEXT:    [[TMP23:%.*]] = sub i64 [[TMP5]], [[TMP22]]
; CHECK-NEXT:    [[TMP24:%.*]] = trunc i64 [[TMP23]] to i32
; CHECK-NEXT:    [[TMP25:%.*]] = mul i32 [[X]], [[TMP21]]
; CHECK-NEXT:    [[TMP26:%.*]] = add i32 [[TMP25]], [[TMP24]]
; CHECK-NEXT:    [[TMP27:%.*]] = sext i32 [[TMP26]] to i64
; CHECK-NEXT:    [[TMP28:%.*]] = getelementptr double, ptr [[DST]], i64 [[TMP27]]
; CHECK-NEXT:    [[TMP29:%.*]] = getelementptr double, ptr [[TMP28]], i32 0
; CHECK-NEXT:    call void @llvm.masked.store.v4f64.p0(<4 x double> zeroinitializer, ptr [[TMP29]], i32 8, <4 x i1> [[TMP8]])
; CHECK-NEXT:    [[INDEX_NEXT]] = add i64 [[INDEX]], 4
; CHECK-NEXT:    [[VEC_IND_NEXT]] = add <4 x i64> [[VEC_IND]], <i64 4, i64 4, i64 4, i64 4>
; CHECK-NEXT:    [[TMP30:%.*]] = icmp eq i64 [[INDEX_NEXT]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP30]], label %[[MIDDLE_BLOCK:.*]], label %[[VECTOR_BODY]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       [[MIDDLE_BLOCK]]:
; CHECK-NEXT:    br i1 true, label %[[EXIT:.*]], label %[[SCALAR_PH]]
; CHECK:       [[SCALAR_PH]]:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i64 [ [[N_VEC]], %[[MIDDLE_BLOCK]] ], [ 0, %[[ENTRY]] ], [ 0, %[[VECTOR_SCEVCHECK]] ]
; CHECK-NEXT:    br label %[[LOOP:.*]]
; CHECK:       [[LOOP]]:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[BC_RESUME_VAL]], %[[SCALAR_PH]] ], [ [[IV_NEXT:%.*]], %[[LOOP_LATCH:.*]] ]
; CHECK-NEXT:    [[C:%.*]] = icmp ule i64 [[IV]], [[M]]
; CHECK-NEXT:    br i1 [[C]], label %[[THEN:.*]], label %[[LOOP_LATCH]]
; CHECK:       [[THEN]]:
; CHECK-NEXT:    [[DIV18:%.*]] = sdiv i64 [[M]], [[CONV6]]
; CHECK-NEXT:    [[CONV20:%.*]] = trunc i64 [[DIV18]] to i32
; CHECK-NEXT:    [[MUL30:%.*]] = mul i64 [[DIV18]], [[CONV61]]
; CHECK-NEXT:    [[SUB31:%.*]] = sub i64 [[IV]], [[MUL30]]
; CHECK-NEXT:    [[CONV34:%.*]] = trunc i64 [[SUB31]] to i32
; CHECK-NEXT:    [[MUL35:%.*]] = mul i32 [[X]], [[CONV20]]
; CHECK-NEXT:    [[ADD36:%.*]] = add i32 [[MUL35]], [[CONV34]]
; CHECK-NEXT:    [[IDXPROM:%.*]] = sext i32 [[ADD36]] to i64
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr double, ptr [[DST]], i64 [[IDXPROM]]
; CHECK-NEXT:    store double 0.000000e+00, ptr [[GEP]], align 8
; CHECK-NEXT:    br label %[[LOOP_LATCH]]
; CHECK:       [[LOOP_LATCH]]:
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp eq i64 [[IV_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EC]], label %[[EXIT]], label %[[LOOP]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  %conv61 = zext i32 %x to i64
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop.latch ]
  %c = icmp ule i64 %iv, %M
  br i1 %c, label %then, label %loop.latch

then:
  %div18 = sdiv i64 %M, %conv6
  %conv20 = trunc i64 %div18 to i32
  %mul30 = mul i64 %div18, %conv61
  %sub31 = sub i64 %iv, %mul30
  %conv34 = trunc i64 %sub31 to i32
  %mul35 = mul i32 %x, %conv20
  %add36 = add i32 %mul35, %conv34
  %idxprom = sext i32 %add36 to i64
  %gep = getelementptr double, ptr %dst, i64 %idxprom
  store double 0.000000e+00, ptr %gep, align 8
  br label %loop.latch

loop.latch:
  %iv.next = add i64 %iv, 1
  %ec = icmp eq i64 %iv.next, %N
  br i1 %ec, label %exit, label %loop

exit:
  ret void
}

define void @udiv_urem_feeding_gep(i64 %x, ptr %dst, i64 %N) {
; CHECK-LABEL: define void @udiv_urem_feeding_gep(
; CHECK-SAME: i64 [[X:%.*]], ptr [[DST:%.*]], i64 [[N:%.*]]) #[[ATTR0]] {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[MUL_1_I:%.*]] = mul i64 [[X]], [[X]]
; CHECK-NEXT:    [[MUL_2_I:%.*]] = mul i64 [[MUL_1_I]], [[X]]
; CHECK-NEXT:    br label %[[LOOP:.*]]
; CHECK:       [[LOOP]]:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ 0, %[[ENTRY]] ], [ [[IV_NEXT:%.*]], %[[LOOP]] ]
; CHECK-NEXT:    [[DIV_I:%.*]] = udiv i64 [[IV]], [[MUL_2_I]]
; CHECK-NEXT:    [[REM_I:%.*]] = urem i64 [[IV]], [[MUL_2_I]]
; CHECK-NEXT:    [[DIV_1_I:%.*]] = udiv i64 [[REM_I]], [[MUL_1_I]]
; CHECK-NEXT:    [[REM_1_I:%.*]] = urem i64 [[REM_I]], [[MUL_1_I]]
; CHECK-NEXT:    [[DIV_2_I:%.*]] = udiv i64 [[REM_1_I]], [[X]]
; CHECK-NEXT:    [[REM_2_I:%.*]] = urem i64 [[REM_1_I]], [[X]]
; CHECK-NEXT:    [[MUL_I:%.*]] = mul i64 [[X]], [[DIV_I]]
; CHECK-NEXT:    [[ADD_I:%.*]] = add i64 [[MUL_I]], [[DIV_1_I]]
; CHECK-NEXT:    [[MUL_1_I9:%.*]] = mul i64 [[ADD_I]], [[X]]
; CHECK-NEXT:    [[ADD_1_I:%.*]] = add i64 [[MUL_1_I9]], [[DIV_2_I]]
; CHECK-NEXT:    [[MUL_2_I11:%.*]] = mul i64 [[ADD_1_I]], [[X]]
; CHECK-NEXT:    [[ADD_2_I:%.*]] = add i64 [[MUL_2_I11]], [[REM_2_I]]
; CHECK-NEXT:    [[SEXT_I:%.*]] = shl i64 [[ADD_2_I]], 32
; CHECK-NEXT:    [[CONV6_I:%.*]] = ashr i64 [[SEXT_I]], 32
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i64, ptr [[DST]], i64 [[CONV6_I]]
; CHECK-NEXT:    store i64 [[DIV_I]], ptr [[GEP]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], 1
; CHECK-NEXT:    [[EXITCOND_NOT:%.*]] = icmp eq i64 [[IV]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND_NOT]], label %[[EXIT:.*]], label %[[LOOP]]
; CHECK:       [[EXIT]]:
; CHECK-NEXT:    ret void
;
entry:
  %mul.1.i = mul i64 %x, %x
  %mul.2.i = mul i64 %mul.1.i, %x
  br label %loop

loop:
  %iv = phi i64 [ 0, %entry ], [ %iv.next, %loop ]
  %div.i = udiv i64 %iv, %mul.2.i
  %rem.i = urem i64 %iv, %mul.2.i
  %div.1.i = udiv i64 %rem.i, %mul.1.i
  %rem.1.i = urem i64 %rem.i, %mul.1.i
  %div.2.i = udiv i64 %rem.1.i, %x
  %rem.2.i = urem i64 %rem.1.i, %x
  %mul.i = mul i64 %x, %div.i
  %add.i = add i64 %mul.i, %div.1.i
  %mul.1.i9 = mul i64 %add.i, %x
  %add.1.i = add i64 %mul.1.i9, %div.2.i
  %mul.2.i11 = mul i64 %add.1.i, %x
  %add.2.i = add i64 %mul.2.i11, %rem.2.i
  %sext.i = shl i64 %add.2.i, 32
  %conv6.i = ashr i64 %sext.i, 32
  %gep = getelementptr i64, ptr %dst, i64 %conv6.i
  store i64 %div.i, ptr %gep, align 4
  %iv.next = add i64 %iv, 1
  %exitcond.not = icmp eq i64 %iv, %N
  br i1 %exitcond.not, label %exit, label %loop

exit:
  ret void
}
;.
; CHECK: [[LOOP0]] = distinct !{[[LOOP0]], [[META1:![0-9]+]], [[META2:![0-9]+]]}
; CHECK: [[META1]] = !{!"llvm.loop.isvectorized", i32 1}
; CHECK: [[META2]] = !{!"llvm.loop.unroll.runtime.disable"}
; CHECK: [[LOOP3]] = distinct !{[[LOOP3]], [[META1]]}
; CHECK: [[LOOP4]] = distinct !{[[LOOP4]], [[META1]], [[META2]]}
; CHECK: [[LOOP5]] = distinct !{[[LOOP5]], [[META1]]}
;.
