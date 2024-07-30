; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s -mtriple unknown -data-layout=e          | FileCheck %s --check-prefixes=CHECK,CHECKI32,CHECKSQRT
; RUN: opt -passes=instcombine -S < %s -mtriple unknown -data-layout=e -disable-builtin sqrt  | FileCheck %s --check-prefixes=CHECK,CHECKI32,CHECKNOSQRT
; RUN: opt -passes=instcombine -S < %s -mtriple msp430                        | FileCheck %s --check-prefixes=CHECK,CHECKI16,CHECKSQRT
; RUN: opt -passes=instcombine -S < %s -mtriple msp430 -disable-builtin sqrt  | FileCheck %s --check-prefixes=CHECK,CHECKI16,CHECKNOSQRT

declare double @llvm.pow.f64(double, double)
declare float @llvm.pow.f32(float, float)
declare <2 x double> @llvm.pow.v2f64(<2 x double>, <2 x double>)
declare <2 x float> @llvm.pow.v2f32(<2 x float>, <2 x float>)
declare <4 x float> @llvm.pow.v4f32(<4 x float>, <4 x float>)
declare double @pow(double, double)

; pow(x, 3.0)
define double @test_simplify_3(double %x) {
; CHECKI32-LABEL: @test_simplify_3(
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i32(double [[X:%.*]], i32 3)
; CHECKI32-NEXT:    ret double [[TMP1]]
;
; CHECKI16-LABEL: @test_simplify_3(
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i16(double [[X:%.*]], i16 3)
; CHECKI16-NEXT:    ret double [[TMP1]]
;
  %1 = call fast double @llvm.pow.f64(double %x, double 3.000000e+00)
  ret double %1
}

; powf(x, 4.0)
define float @test_simplify_4f(float %x) {
; CHECKI32-LABEL: @test_simplify_4f(
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast float @llvm.powi.f32.i32(float [[X:%.*]], i32 4)
; CHECKI32-NEXT:    ret float [[TMP1]]
;
; CHECKI16-LABEL: @test_simplify_4f(
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast float @llvm.powi.f32.i16(float [[X:%.*]], i16 4)
; CHECKI16-NEXT:    ret float [[TMP1]]
;
  %1 = call fast float @llvm.pow.f32(float %x, float 4.000000e+00)
  ret float %1
}

; pow(x, 4.0)
define double @test_simplify_4(double %x) {
; CHECKI32-LABEL: @test_simplify_4(
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i32(double [[X:%.*]], i32 4)
; CHECKI32-NEXT:    ret double [[TMP1]]
;
; CHECKI16-LABEL: @test_simplify_4(
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i16(double [[X:%.*]], i16 4)
; CHECKI16-NEXT:    ret double [[TMP1]]
;
  %1 = call fast double @llvm.pow.f64(double %x, double 4.000000e+00)
  ret double %1
}

; powf(x, <15.0, 15.0>)
define <2 x float> @test_simplify_15(<2 x float> %x) {
; CHECKI32-LABEL: @test_simplify_15(
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast <2 x float> @llvm.powi.v2f32.i32(<2 x float> [[X:%.*]], i32 15)
; CHECKI32-NEXT:    ret <2 x float> [[TMP1]]
;
; CHECKI16-LABEL: @test_simplify_15(
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast <2 x float> @llvm.powi.v2f32.i16(<2 x float> [[X:%.*]], i16 15)
; CHECKI16-NEXT:    ret <2 x float> [[TMP1]]
;
  %1 = call fast <2 x float> @llvm.pow.v2f32(<2 x float> %x, <2 x float> <float 1.500000e+01, float 1.500000e+01>)
  ret <2 x float> %1
}

; pow(x, -7.0)
define <2 x double> @test_simplify_neg_7(<2 x double> %x) {
; CHECKI32-LABEL: @test_simplify_neg_7(
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @llvm.powi.v2f64.i32(<2 x double> [[X:%.*]], i32 -7)
; CHECKI32-NEXT:    ret <2 x double> [[TMP1]]
;
; CHECKI16-LABEL: @test_simplify_neg_7(
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @llvm.powi.v2f64.i16(<2 x double> [[X:%.*]], i16 -7)
; CHECKI16-NEXT:    ret <2 x double> [[TMP1]]
;
  %1 = call fast <2 x double> @llvm.pow.v2f64(<2 x double> %x, <2 x double> <double -7.000000e+00, double -7.000000e+00>)
  ret <2 x double> %1
}

; powf(x, -19.0)
define float @test_simplify_neg_19(float %x) {
; CHECKI32-LABEL: @test_simplify_neg_19(
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast float @llvm.powi.f32.i32(float [[X:%.*]], i32 -19)
; CHECKI32-NEXT:    ret float [[TMP1]]
;
; CHECKI16-LABEL: @test_simplify_neg_19(
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast float @llvm.powi.f32.i16(float [[X:%.*]], i16 -19)
; CHECKI16-NEXT:    ret float [[TMP1]]
;
  %1 = call fast float @llvm.pow.f32(float %x, float -1.900000e+01)
  ret float %1
}

; pow(x, 11.23)
define double @test_simplify_11_23(double %x) {
; CHECK-LABEL: @test_simplify_11_23(
; CHECK-NEXT:    [[TMP1:%.*]] = call fast double @llvm.pow.f64(double [[X:%.*]], double 1.123000e+01)
; CHECK-NEXT:    ret double [[TMP1]]
;
  %1 = call fast double @llvm.pow.f64(double %x, double 1.123000e+01)
  ret double %1
}

; powf(x, 32.0)
define float @test_simplify_32(float %x) {
; CHECKI32-LABEL: @test_simplify_32(
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast float @llvm.powi.f32.i32(float [[X:%.*]], i32 32)
; CHECKI32-NEXT:    ret float [[TMP1]]
;
; CHECKI16-LABEL: @test_simplify_32(
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast float @llvm.powi.f32.i16(float [[X:%.*]], i16 32)
; CHECKI16-NEXT:    ret float [[TMP1]]
;
  %1 = call fast float @llvm.pow.f32(float %x, float 3.200000e+01)
  ret float %1
}

; pow(x, 33.0)
define double @test_simplify_33(double %x) {
; CHECKI32-LABEL: @test_simplify_33(
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i32(double [[X:%.*]], i32 33)
; CHECKI32-NEXT:    ret double [[TMP1]]
;
; CHECKI16-LABEL: @test_simplify_33(
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i16(double [[X:%.*]], i16 33)
; CHECKI16-NEXT:    ret double [[TMP1]]
;
  %1 = call fast double @llvm.pow.f64(double %x, double 3.300000e+01)
  ret double %1
}

; pow(x, 16.5) with double
define double @test_simplify_16_5(double %x) {
; CHECKI32-LABEL: @test_simplify_16_5(
; CHECKI32-NEXT:    [[SQRT:%.*]] = call fast double @llvm.sqrt.f64(double [[X:%.*]])
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i32(double [[X]], i32 16)
; CHECKI32-NEXT:    [[TMP2:%.*]] = fmul fast double [[TMP1]], [[SQRT]]
; CHECKI32-NEXT:    ret double [[TMP2]]
;
; CHECKI16-LABEL: @test_simplify_16_5(
; CHECKI16-NEXT:    [[SQRT:%.*]] = call fast double @llvm.sqrt.f64(double [[X:%.*]])
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i16(double [[X]], i16 16)
; CHECKI16-NEXT:    [[TMP2:%.*]] = fmul fast double [[TMP1]], [[SQRT]]
; CHECKI16-NEXT:    ret double [[TMP2]]
;
  %1 = call fast double @llvm.pow.f64(double %x, double 1.650000e+01)
  ret double %1
}

; pow(x, -16.5) with double
define double @test_simplify_neg_16_5(double %x) {
; CHECKI32-LABEL: @test_simplify_neg_16_5(
; CHECKI32-NEXT:    [[SQRT:%.*]] = call fast double @llvm.sqrt.f64(double [[X:%.*]])
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i32(double [[X]], i32 -17)
; CHECKI32-NEXT:    [[TMP2:%.*]] = fmul fast double [[TMP1]], [[SQRT]]
; CHECKI32-NEXT:    ret double [[TMP2]]
;
; CHECKI16-LABEL: @test_simplify_neg_16_5(
; CHECKI16-NEXT:    [[SQRT:%.*]] = call fast double @llvm.sqrt.f64(double [[X:%.*]])
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast double @llvm.powi.f64.i16(double [[X]], i16 -17)
; CHECKI16-NEXT:    [[TMP2:%.*]] = fmul fast double [[TMP1]], [[SQRT]]
; CHECKI16-NEXT:    ret double [[TMP2]]
;
  %1 = call fast double @llvm.pow.f64(double %x, double -1.650000e+01)
  ret double %1
}

; pow(x, 0.5) with double

define double @test_simplify_0_5_libcall(double %x) {
; CHECKSQRT-LABEL: @test_simplify_0_5_libcall(
; CHECKSQRT-NEXT:    [[SQRT:%.*]] = call fast double @sqrt(double [[X:%.*]])
; CHECKSQRT-NEXT:    ret double [[SQRT]]
;
; CHECKNOSQRT-LABEL: @test_simplify_0_5_libcall(
; CHECKNOSQRT-NEXT:    [[TMP1:%.*]] = call fast double @pow(double [[X:%.*]], double 5.000000e-01)
; CHECKNOSQRT-NEXT:    ret double [[TMP1]]
;
  %1 = call fast double @pow(double %x, double 5.000000e-01)
  ret double %1
}

; pow(x, -0.5) with double

define double @test_simplify_neg_0_5_libcall(double %x) {
; CHECKSQRT-LABEL: @test_simplify_neg_0_5_libcall(
; CHECKSQRT-NEXT:    [[SQRT:%.*]] = call fast double @sqrt(double [[X:%.*]])
; CHECKSQRT-NEXT:    [[RECIPROCAL:%.*]] = fdiv fast double 1.000000e+00, [[SQRT]]
; CHECKSQRT-NEXT:    ret double [[RECIPROCAL]]
;
; CHECKNOSQRT-LABEL: @test_simplify_neg_0_5_libcall(
; CHECKNOSQRT-NEXT:    [[TMP1:%.*]] = call fast double @pow(double [[X:%.*]], double -5.000000e-01)
; CHECKNOSQRT-NEXT:    ret double [[TMP1]]
;
  %1 = call fast double @pow(double %x, double -5.000000e-01)
  ret double %1
}

; pow(x, -8.5) with float
define float @test_simplify_neg_8_5(float %x) {
; CHECKI32-LABEL: @test_simplify_neg_8_5(
; CHECKI32-NEXT:    [[SQRT:%.*]] = call fast float @llvm.sqrt.f32(float [[X:%.*]])
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast float @llvm.powi.f32.i32(float [[X]], i32 -9)
; CHECKI32-NEXT:    [[TMP2:%.*]] = fmul fast float [[TMP1]], [[SQRT]]
; CHECKI32-NEXT:    ret float [[TMP2]]
;
; CHECKI16-LABEL: @test_simplify_neg_8_5(
; CHECKI16-NEXT:    [[SQRT:%.*]] = call fast float @llvm.sqrt.f32(float [[X:%.*]])
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast float @llvm.powi.f32.i16(float [[X]], i16 -9)
; CHECKI16-NEXT:    [[TMP2:%.*]] = fmul fast float [[TMP1]], [[SQRT]]
; CHECKI16-NEXT:    ret float [[TMP2]]
;
  %1 = call fast float @llvm.pow.f32(float %x, float -0.850000e+01)
  ret float %1
}

; pow(x, 7.5) with <2 x double>
define <2 x double> @test_simplify_7_5(<2 x double> %x) {
; CHECKI32-LABEL: @test_simplify_7_5(
; CHECKI32-NEXT:    [[SQRT:%.*]] = call fast <2 x double> @llvm.sqrt.v2f64(<2 x double> [[X:%.*]])
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @llvm.powi.v2f64.i32(<2 x double> [[X]], i32 7)
; CHECKI32-NEXT:    [[TMP2:%.*]] = fmul fast <2 x double> [[TMP1]], [[SQRT]]
; CHECKI32-NEXT:    ret <2 x double> [[TMP2]]
;
; CHECKI16-LABEL: @test_simplify_7_5(
; CHECKI16-NEXT:    [[SQRT:%.*]] = call fast <2 x double> @llvm.sqrt.v2f64(<2 x double> [[X:%.*]])
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast <2 x double> @llvm.powi.v2f64.i16(<2 x double> [[X]], i16 7)
; CHECKI16-NEXT:    [[TMP2:%.*]] = fmul fast <2 x double> [[TMP1]], [[SQRT]]
; CHECKI16-NEXT:    ret <2 x double> [[TMP2]]
;
  %1 = call fast <2 x double> @llvm.pow.v2f64(<2 x double> %x, <2 x double> <double 7.500000e+00, double 7.500000e+00>)
  ret <2 x double> %1
}

; pow(x, 3.5) with <4 x float>
define <4 x float> @test_simplify_3_5(<4 x float> %x) {
; CHECKI32-LABEL: @test_simplify_3_5(
; CHECKI32-NEXT:    [[SQRT:%.*]] = call fast <4 x float> @llvm.sqrt.v4f32(<4 x float> [[X:%.*]])
; CHECKI32-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @llvm.powi.v4f32.i32(<4 x float> [[X]], i32 3)
; CHECKI32-NEXT:    [[TMP2:%.*]] = fmul fast <4 x float> [[TMP1]], [[SQRT]]
; CHECKI32-NEXT:    ret <4 x float> [[TMP2]]
;
; CHECKI16-LABEL: @test_simplify_3_5(
; CHECKI16-NEXT:    [[SQRT:%.*]] = call fast <4 x float> @llvm.sqrt.v4f32(<4 x float> [[X:%.*]])
; CHECKI16-NEXT:    [[TMP1:%.*]] = call fast <4 x float> @llvm.powi.v4f32.i16(<4 x float> [[X]], i16 3)
; CHECKI16-NEXT:    [[TMP2:%.*]] = fmul fast <4 x float> [[TMP1]], [[SQRT]]
; CHECKI16-NEXT:    ret <4 x float> [[TMP2]]
;
  %1 = call fast <4 x float> @llvm.pow.v4f32(<4 x float> %x, <4 x float> <float 3.500000e+00, float 3.500000e+00, float 3.500000e+00, float 3.500000e+00>)
  ret <4 x float> %1
}

; (float)pow((double)(float)x, 0.5)
define float @shrink_pow_libcall_half(float %x) {
; CHECK-LABEL: @shrink_pow_libcall_half(
; CHECK-NEXT:    [[SQRTF:%.*]] = call fast float @sqrtf(float [[X:%.*]])
; CHECK-NEXT:    ret float [[SQRTF]]
;
  %dx = fpext float %x to double
  %call = call fast double @pow(double %dx, double 0.5)
  %fr = fptrunc double %call to float
  ret float %fr
}

; Make sure that -0.0 exponent is always simplified.

define double @PR43233(double %x) {
; CHECK-LABEL: @PR43233(
; CHECK-NEXT:    ret double 1.000000e+00
;
  %r = call fast double @llvm.pow.f64(double %x, double -0.0)
  ret double %r
}

