; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=slp-vectorizer -S < %s -mtriple=x86_64-unknown-linux-gnu -mcpu=skylake -slp-threshold=-4 | FileCheck %s --check-prefix=CHECK
; RUN: opt -passes=slp-vectorizer -S < %s -mtriple=x86_64-unknown-linux-gnu -mcpu=skylake -slp-threshold=-4 -slp-min-tree-size=5 | FileCheck %s --check-prefix=FORCE_REDUCTION

define void @Test(i32) {
; CHECK-LABEL: @Test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[TMP1:%.*]] = phi <2 x i32> [ [[TMP9:%.*]], [[LOOP]] ], [ zeroinitializer, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <2 x i32> [[TMP1]], <2 x i32> poison, <8 x i32> <i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
; CHECK-NEXT:    [[TMP3:%.*]] = add <8 x i32> [[TMP2]], <i32 0, i32 55, i32 285, i32 1240, i32 1496, i32 8555, i32 12529, i32 13685>
; CHECK-NEXT:    [[TMP4:%.*]] = call i32 @llvm.vector.reduce.and.v8i32(<8 x i32> [[TMP3]])
; CHECK-NEXT:    [[OP_RDX:%.*]] = and i32 [[TMP0:%.*]], [[TMP4]]
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <2 x i32> <i32 poison, i32 14910>, i32 [[OP_RDX]], i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <2 x i32> [[TMP1]], <2 x i32> poison, <2 x i32> <i32 1, i32 1>
; CHECK-NEXT:    [[TMP7:%.*]] = and <2 x i32> [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = add <2 x i32> [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[TMP9]] = shufflevector <2 x i32> [[TMP7]], <2 x i32> [[TMP8]], <2 x i32> <i32 0, i32 3>
; CHECK-NEXT:    br label [[LOOP]]
;
; FORCE_REDUCTION-LABEL: @Test(
; FORCE_REDUCTION-NEXT:  entry:
; FORCE_REDUCTION-NEXT:    br label [[LOOP:%.*]]
; FORCE_REDUCTION:       loop:
; FORCE_REDUCTION-NEXT:    [[TMP1:%.*]] = phi <2 x i32> [ [[TMP9:%.*]], [[LOOP]] ], [ zeroinitializer, [[ENTRY:%.*]] ]
; FORCE_REDUCTION-NEXT:    [[TMP2:%.*]] = shufflevector <2 x i32> [[TMP1]], <2 x i32> poison, <8 x i32> <i32 0, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
; FORCE_REDUCTION-NEXT:    [[TMP3:%.*]] = add <8 x i32> [[TMP2]], <i32 0, i32 55, i32 285, i32 1240, i32 1496, i32 8555, i32 12529, i32 13685>
; FORCE_REDUCTION-NEXT:    [[TMP4:%.*]] = call i32 @llvm.vector.reduce.and.v8i32(<8 x i32> [[TMP3]])
; FORCE_REDUCTION-NEXT:    [[OP_RDX:%.*]] = and i32 [[TMP0:%.*]], [[TMP4]]
; FORCE_REDUCTION-NEXT:    [[TMP5:%.*]] = insertelement <2 x i32> <i32 poison, i32 14910>, i32 [[OP_RDX]], i32 0
; FORCE_REDUCTION-NEXT:    [[TMP6:%.*]] = shufflevector <2 x i32> [[TMP1]], <2 x i32> poison, <2 x i32> <i32 1, i32 1>
; FORCE_REDUCTION-NEXT:    [[TMP7:%.*]] = and <2 x i32> [[TMP5]], [[TMP6]]
; FORCE_REDUCTION-NEXT:    [[TMP8:%.*]] = add <2 x i32> [[TMP5]], [[TMP6]]
; FORCE_REDUCTION-NEXT:    [[TMP9]] = shufflevector <2 x i32> [[TMP7]], <2 x i32> [[TMP8]], <2 x i32> <i32 0, i32 3>
; FORCE_REDUCTION-NEXT:    br label [[LOOP]]
;
entry:
  br label %loop

loop:
  %local_4_39.us = phi i32 [ %val_42, %loop ], [ 0, %entry ]
  %local_8_43.us = phi i32 [ %val_43, %loop ], [ 0, %entry ]
  %val_0 = add i32 %local_4_39.us, 0
  %val_1 = and i32 %local_8_43.us, %val_0
  %val_2 = and i32 %val_1, %0
  %val_3 = and i32 %val_2, %0
  %val_4 = and i32 %val_3, %0
  %val_5 = and i32 %val_4, %0
  %val_6 = add i32 %local_8_43.us, 55
  %val_7 = and i32 %val_5, %val_6
  %val_8 = and i32 %val_7, %0
  %val_9 = and i32 %val_8, %0
  %val_10 = and i32 %val_9, %0
  %val_11 = add i32 %local_8_43.us, 285
  %val_12 = and i32 %val_10, %val_11
  %val_13 = and i32 %val_12, %0
  %val_14 = and i32 %val_13, %0
  %val_15 = and i32 %val_14, %0
  %val_16 = and i32 %val_15, %0
  %val_17 = and i32 %val_16, %0
  %val_18 = add i32 %local_8_43.us, 1240
  %val_19 = and i32 %val_17, %val_18
  %val_20 = add i32 %local_8_43.us, 1496
  %val_21 = and i32 %val_19, %val_20
  %val_22 = and i32 %val_21, %0
  %val_23 = and i32 %val_22, %0
  %val_24 = and i32 %val_23, %0
  %val_25 = and i32 %val_24, %0
  %val_26 = and i32 %val_25, %0
  %val_27 = and i32 %val_26, %0
  %val_28 = and i32 %val_27, %0
  %val_29 = and i32 %val_28, %0
  %val_30 = and i32 %val_29, %0
  %val_31 = and i32 %val_30, %0
  %val_32 = and i32 %val_31, %0
  %val_33 = and i32 %val_32, %0
  %val_34 = add i32 %local_8_43.us, 8555
  %val_35 = and i32 %val_33, %val_34
  %val_36 = and i32 %val_35, %0
  %val_37 = and i32 %val_36, %0
  %val_38 = and i32 %val_37, %0
  %val_39 = add i32 %local_8_43.us, 12529
  %val_40 = and i32 %val_38, %val_39
  %val_41 = add i32 %local_8_43.us, 13685
  %val_42 = and i32 %val_40, %val_41
  %val_43 = add i32 %local_8_43.us, 14910
  br label %loop
}
