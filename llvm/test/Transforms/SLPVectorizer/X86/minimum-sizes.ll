; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -slp-threshold=-6 -passes=slp-vectorizer,instcombine -mattr=+sse2     -S | FileCheck %s --check-prefix=SSE
; RUN: opt < %s -slp-threshold=-6 -passes=slp-vectorizer,instcombine -mattr=+avx      -S | FileCheck %s --check-prefix=AVX
; RUN: opt < %s -slp-threshold=-6 -passes=slp-vectorizer,instcombine -mattr=+avx2     -S | FileCheck %s --check-prefix=AVX
; RUN: opt < %s -slp-threshold=-6 -passes=slp-vectorizer,instcombine -mattr=+avx512f  -S | FileCheck %s --check-prefix=AVX
; RUN: opt < %s -slp-threshold=-6 -passes=slp-vectorizer,instcombine -mattr=+avx512vl -S | FileCheck %s --check-prefix=AVX

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; These tests ensure that we do not regress due to PR31243. Note that we set
; the SLP threshold to force vectorization even when not profitable.

; When computing minimum sizes, if we can prove the sign bit is zero, we can
; zero-extend the roots back to their original sizes.
;
define i8 @PR31243_zext(i8 %v0, i8 %v1, i8 %v2, i8 %v3, ptr %ptr) {
; SSE-LABEL: @PR31243_zext(
; SSE-NEXT:  entry:
; SSE-NEXT:    [[TMP0:%.*]] = insertelement <2 x i8> poison, i8 [[V0:%.*]], i64 0
; SSE-NEXT:    [[TMP1:%.*]] = insertelement <2 x i8> [[TMP0]], i8 [[V1:%.*]], i64 1
; SSE-NEXT:    [[TMP2:%.*]] = or <2 x i8> [[TMP1]], <i8 1, i8 1>
; SSE-NEXT:    [[TMP3:%.*]] = extractelement <2 x i8> [[TMP2]], i64 0
; SSE-NEXT:    [[TMP4:%.*]] = zext i8 [[TMP3]] to i64
; SSE-NEXT:    [[T4:%.*]] = getelementptr inbounds i8, ptr [[PTR:%.*]], i64 [[TMP4]]
; SSE-NEXT:    [[TMP5:%.*]] = extractelement <2 x i8> [[TMP2]], i64 1
; SSE-NEXT:    [[TMP6:%.*]] = zext i8 [[TMP5]] to i64
; SSE-NEXT:    [[T5:%.*]] = getelementptr inbounds i8, ptr [[PTR]], i64 [[TMP6]]
; SSE-NEXT:    [[T6:%.*]] = load i8, ptr [[T4]], align 1
; SSE-NEXT:    [[T7:%.*]] = load i8, ptr [[T5]], align 1
; SSE-NEXT:    [[T8:%.*]] = add i8 [[T6]], [[T7]]
; SSE-NEXT:    ret i8 [[T8]]
;
; AVX-LABEL: @PR31243_zext(
; AVX-NEXT:  entry:
; AVX-NEXT:    [[TMP0:%.*]] = insertelement <2 x i8> poison, i8 [[V0:%.*]], i64 0
; AVX-NEXT:    [[TMP1:%.*]] = insertelement <2 x i8> [[TMP0]], i8 [[V1:%.*]], i64 1
; AVX-NEXT:    [[TMP2:%.*]] = or <2 x i8> [[TMP1]], <i8 1, i8 1>
; AVX-NEXT:    [[TMP3:%.*]] = extractelement <2 x i8> [[TMP2]], i64 0
; AVX-NEXT:    [[TMP4:%.*]] = zext i8 [[TMP3]] to i64
; AVX-NEXT:    [[T4:%.*]] = getelementptr inbounds i8, ptr [[PTR:%.*]], i64 [[TMP4]]
; AVX-NEXT:    [[TMP5:%.*]] = extractelement <2 x i8> [[TMP2]], i64 1
; AVX-NEXT:    [[TMP6:%.*]] = zext i8 [[TMP5]] to i64
; AVX-NEXT:    [[T5:%.*]] = getelementptr inbounds i8, ptr [[PTR]], i64 [[TMP6]]
; AVX-NEXT:    [[T6:%.*]] = load i8, ptr [[T4]], align 1
; AVX-NEXT:    [[T7:%.*]] = load i8, ptr [[T5]], align 1
; AVX-NEXT:    [[T8:%.*]] = add i8 [[T6]], [[T7]]
; AVX-NEXT:    ret i8 [[T8]]
;
entry:
  %t0 = zext i8 %v0 to i32
  %t1 = zext i8 %v1 to i32
  %t2 = or i32 %t0, 1
  %t3 = or i32 %t1, 1
  %t4 = getelementptr inbounds i8, ptr %ptr, i32 %t2
  %t5 = getelementptr inbounds i8, ptr %ptr, i32 %t3
  %t6 = load i8, ptr %t4
  %t7 = load i8, ptr %t5
  %t8 = add i8 %t6, %t7
  ret i8 %t8
}

; When computing minimum sizes, if we cannot prove the sign bit is zero, we
; have to include one extra bit for signedness since we will sign-extend the
; roots.
;
; FIXME: This test is suboptimal since the compuation can be performed in i8.
;        In general, we need to add an extra bit to the maximum bit width only
;        if we can't prove that the upper bit of the original type is equal to
;        the upper bit of the proposed smaller type. If these two bits are the
;        same (either zero or one) we know that sign-extending from the smaller
;        type will result in the same value. Since we don't yet perform this
;        optimization, we make the proposed smaller type (i8) larger (i16) to
;        ensure correctness.
;
define i8 @PR31243_sext(i8 %v0, i8 %v1, i8 %v2, i8 %v3, ptr %ptr) {
; SSE-LABEL: @PR31243_sext(
; SSE-NEXT:  entry:
; SSE-NEXT:    [[TMP0:%.*]] = insertelement <2 x i8> poison, i8 [[V0:%.*]], i64 0
; SSE-NEXT:    [[TMP1:%.*]] = insertelement <2 x i8> [[TMP0]], i8 [[V1:%.*]], i64 1
; SSE-NEXT:    [[TMP2:%.*]] = or <2 x i8> [[TMP1]], <i8 1, i8 1>
; SSE-NEXT:    [[TMP3:%.*]] = extractelement <2 x i8> [[TMP2]], i64 0
; SSE-NEXT:    [[TMP4:%.*]] = sext i8 [[TMP3]] to i64
; SSE-NEXT:    [[T4:%.*]] = getelementptr inbounds i8, ptr [[PTR:%.*]], i64 [[TMP4]]
; SSE-NEXT:    [[TMP5:%.*]] = extractelement <2 x i8> [[TMP2]], i64 1
; SSE-NEXT:    [[TMP6:%.*]] = sext i8 [[TMP5]] to i64
; SSE-NEXT:    [[T5:%.*]] = getelementptr inbounds i8, ptr [[PTR]], i64 [[TMP6]]
; SSE-NEXT:    [[T6:%.*]] = load i8, ptr [[T4]], align 1
; SSE-NEXT:    [[T7:%.*]] = load i8, ptr [[T5]], align 1
; SSE-NEXT:    [[T8:%.*]] = add i8 [[T6]], [[T7]]
; SSE-NEXT:    ret i8 [[T8]]
;
; AVX-LABEL: @PR31243_sext(
; AVX-NEXT:  entry:
; AVX-NEXT:    [[TMP0:%.*]] = insertelement <2 x i8> poison, i8 [[V0:%.*]], i64 0
; AVX-NEXT:    [[TMP1:%.*]] = insertelement <2 x i8> [[TMP0]], i8 [[V1:%.*]], i64 1
; AVX-NEXT:    [[TMP2:%.*]] = or <2 x i8> [[TMP1]], <i8 1, i8 1>
; AVX-NEXT:    [[TMP3:%.*]] = extractelement <2 x i8> [[TMP2]], i64 0
; AVX-NEXT:    [[TMP4:%.*]] = sext i8 [[TMP3]] to i64
; AVX-NEXT:    [[T4:%.*]] = getelementptr inbounds i8, ptr [[PTR:%.*]], i64 [[TMP4]]
; AVX-NEXT:    [[TMP5:%.*]] = extractelement <2 x i8> [[TMP2]], i64 1
; AVX-NEXT:    [[TMP6:%.*]] = sext i8 [[TMP5]] to i64
; AVX-NEXT:    [[T5:%.*]] = getelementptr inbounds i8, ptr [[PTR]], i64 [[TMP6]]
; AVX-NEXT:    [[T6:%.*]] = load i8, ptr [[T4]], align 1
; AVX-NEXT:    [[T7:%.*]] = load i8, ptr [[T5]], align 1
; AVX-NEXT:    [[T8:%.*]] = add i8 [[T6]], [[T7]]
; AVX-NEXT:    ret i8 [[T8]]
;
entry:
  %t0 = sext i8 %v0 to i32
  %t1 = sext i8 %v1 to i32
  %t2 = or i32 %t0, 1
  %t3 = or i32 %t1, 1
  %t4 = getelementptr inbounds i8, ptr %ptr, i32 %t2
  %t5 = getelementptr inbounds i8, ptr %ptr, i32 %t3
  %t6 = load i8, ptr %t4
  %t7 = load i8, ptr %t5
  %t8 = add i8 %t6, %t7
  ret i8 %t8
}
