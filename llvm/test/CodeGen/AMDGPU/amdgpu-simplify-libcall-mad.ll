; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -S -mtriple=amdgcn-amd-amdhsa -passes=amdgpu-simplifylib %s | FileCheck %s

target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-p7:160:256:256:32-p8:128:128-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7:8:9"

declare float @_Z3madfff(float, float, float)
declare <2 x float> @_Z3madDv2_fS_S_(<2 x float>, <2 x float>, <2 x float>)
declare <3 x float> @_Z3madDv3_fS_S_(<3 x float>, <3 x float>, <3 x float>)
declare <4 x float> @_Z3madDv4_fS_S_(<4 x float>, <4 x float>, <4 x float>)
declare <8 x float> @_Z3madDv8_fS_S_(<8 x float>, <8 x float>, <8 x float>)
declare <16 x float> @_Z3madDv16_fS_S_(<16 x float>, <16 x float>, <16 x float>)
declare double @_Z3madddd(double, double, double)
declare <2 x double> @_Z3madDv2_dS_S_(<2 x double>, <2 x double>, <2 x double>)
declare <3 x double> @_Z3madDv3_dS_S_(<3 x double>, <3 x double>, <3 x double>)
declare <4 x double> @_Z3madDv4_dS_S_(<4 x double>, <4 x double>, <4 x double>)
declare <8 x double> @_Z3madDv8_dS_S_(<8 x double>, <8 x double>, <8 x double>)
declare <16 x double> @_Z3madDv16_dS_S_(<16 x double>, <16 x double>, <16 x double>)
declare half @_Z3madDhDhDh(half, half, half)
declare <2 x half> @_Z3madDv2_DhS_S_(<2 x half>, <2 x half>, <2 x half>)
declare <3 x half> @_Z3madDv3_DhS_S_(<3 x half>, <3 x half>, <3 x half>)
declare <4 x half> @_Z3madDv4_DhS_S_(<4 x half>, <4 x half>, <4 x half>)
declare <8 x half> @_Z3madDv8_DhS_S_(<8 x half>, <8 x half>, <8 x half>)
declare <16 x half> @_Z3madDv16_DhS_S_(<16 x half>, <16 x half>, <16 x half>)

define float @test_mad_f32(float %x, float %y, float %z) {
; CHECK-LABEL: define float @test_mad_f32
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call float @llvm.fmuladd.f32(float [[X]], float [[Y]], float [[Z]])
; CHECK-NEXT:    ret float [[MAD]]
;
  %mad = tail call float @_Z3madfff(float %x, float %y, float %z)
  ret float %mad
}

define <2 x float> @test_mad_v2f32(<2 x float> %x, <2 x float> %y, <2 x float> %z) {
; CHECK-LABEL: define <2 x float> @test_mad_v2f32
; CHECK-SAME: (<2 x float> [[X:%.*]], <2 x float> [[Y:%.*]], <2 x float> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <2 x float> @llvm.fmuladd.v2f32(<2 x float> [[X]], <2 x float> [[Y]], <2 x float> [[Z]])
; CHECK-NEXT:    ret <2 x float> [[MAD]]
;
  %mad = tail call <2 x float> @_Z3madDv2_fS_S_(<2 x float> %x, <2 x float> %y, <2 x float> %z)
  ret <2 x float> %mad
}

define <3 x float> @test_mad_v3f32(<3 x float> %x, <3 x float> %y, <3 x float> %z) {
; CHECK-LABEL: define <3 x float> @test_mad_v3f32
; CHECK-SAME: (<3 x float> [[X:%.*]], <3 x float> [[Y:%.*]], <3 x float> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <3 x float> @llvm.fmuladd.v3f32(<3 x float> [[X]], <3 x float> [[Y]], <3 x float> [[Z]])
; CHECK-NEXT:    ret <3 x float> [[MAD]]
;
  %mad = tail call <3 x float> @_Z3madDv3_fS_S_(<3 x float> %x, <3 x float> %y, <3 x float> %z)
  ret <3 x float> %mad
}

define <4 x float> @test_mad_v4f32(<4 x float> %x, <4 x float> %y, <4 x float> %z) {
; CHECK-LABEL: define <4 x float> @test_mad_v4f32
; CHECK-SAME: (<4 x float> [[X:%.*]], <4 x float> [[Y:%.*]], <4 x float> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <4 x float> @llvm.fmuladd.v4f32(<4 x float> [[X]], <4 x float> [[Y]], <4 x float> [[Z]])
; CHECK-NEXT:    ret <4 x float> [[MAD]]
;
  %mad = tail call <4 x float> @_Z3madDv4_fS_S_(<4 x float> %x, <4 x float> %y, <4 x float> %z)
  ret <4 x float> %mad
}

define <8 x float> @test_mad_v8f32(<8 x float> %x, <8 x float> %y, <8 x float> %z) {
; CHECK-LABEL: define <8 x float> @test_mad_v8f32
; CHECK-SAME: (<8 x float> [[X:%.*]], <8 x float> [[Y:%.*]], <8 x float> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <8 x float> @llvm.fmuladd.v8f32(<8 x float> [[X]], <8 x float> [[Y]], <8 x float> [[Z]])
; CHECK-NEXT:    ret <8 x float> [[MAD]]
;
  %mad = tail call <8 x float> @_Z3madDv8_fS_S_(<8 x float> %x, <8 x float> %y, <8 x float> %z)
  ret <8 x float> %mad
}

define <16 x float> @test_mad_v16f32(<16 x float> %x, <16 x float> %y, <16 x float> %z) {
; CHECK-LABEL: define <16 x float> @test_mad_v16f32
; CHECK-SAME: (<16 x float> [[X:%.*]], <16 x float> [[Y:%.*]], <16 x float> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <16 x float> @llvm.fmuladd.v16f32(<16 x float> [[X]], <16 x float> [[Y]], <16 x float> [[Z]])
; CHECK-NEXT:    ret <16 x float> [[MAD]]
;
  %mad = tail call <16 x float> @_Z3madDv16_fS_S_(<16 x float> %x, <16 x float> %y, <16 x float> %z)
  ret <16 x float> %mad
}

define double @test_mad_f64(double %x, double %y, double %z) {
; CHECK-LABEL: define double @test_mad_f64
; CHECK-SAME: (double [[X:%.*]], double [[Y:%.*]], double [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call double @llvm.fmuladd.f64(double [[X]], double [[Y]], double [[Z]])
; CHECK-NEXT:    ret double [[MAD]]
;
  %mad = tail call double @_Z3madddd(double %x, double %y, double %z)
  ret double %mad
}

define <2 x double> @test_mad_v2f64(<2 x double> %x, <2 x double> %y, <2 x double> %z) {
; CHECK-LABEL: define <2 x double> @test_mad_v2f64
; CHECK-SAME: (<2 x double> [[X:%.*]], <2 x double> [[Y:%.*]], <2 x double> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <2 x double> @llvm.fmuladd.v2f64(<2 x double> [[X]], <2 x double> [[Y]], <2 x double> [[Z]])
; CHECK-NEXT:    ret <2 x double> [[MAD]]
;
  %mad = tail call <2 x double> @_Z3madDv2_dS_S_(<2 x double> %x, <2 x double> %y, <2 x double> %z)
  ret <2 x double> %mad
}

define <3 x double> @test_mad_v3f64(<3 x double> %x, <3 x double> %y, <3 x double> %z) {
; CHECK-LABEL: define <3 x double> @test_mad_v3f64
; CHECK-SAME: (<3 x double> [[X:%.*]], <3 x double> [[Y:%.*]], <3 x double> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <3 x double> @llvm.fmuladd.v3f64(<3 x double> [[X]], <3 x double> [[Y]], <3 x double> [[Z]])
; CHECK-NEXT:    ret <3 x double> [[MAD]]
;
  %mad = tail call <3 x double> @_Z3madDv3_dS_S_(<3 x double> %x, <3 x double> %y, <3 x double> %z)
  ret <3 x double> %mad
}

define <4 x double> @test_mad_v4f64(<4 x double> %x, <4 x double> %y, <4 x double> %z) {
; CHECK-LABEL: define <4 x double> @test_mad_v4f64
; CHECK-SAME: (<4 x double> [[X:%.*]], <4 x double> [[Y:%.*]], <4 x double> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <4 x double> @llvm.fmuladd.v4f64(<4 x double> [[X]], <4 x double> [[Y]], <4 x double> [[Z]])
; CHECK-NEXT:    ret <4 x double> [[MAD]]
;
  %mad = tail call <4 x double> @_Z3madDv4_dS_S_(<4 x double> %x, <4 x double> %y, <4 x double> %z)
  ret <4 x double> %mad
}

define <8 x double> @test_mad_v8f64(<8 x double> %x, <8 x double> %y, <8 x double> %z) {
; CHECK-LABEL: define <8 x double> @test_mad_v8f64
; CHECK-SAME: (<8 x double> [[X:%.*]], <8 x double> [[Y:%.*]], <8 x double> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <8 x double> @llvm.fmuladd.v8f64(<8 x double> [[X]], <8 x double> [[Y]], <8 x double> [[Z]])
; CHECK-NEXT:    ret <8 x double> [[MAD]]
;
  %mad = tail call <8 x double> @_Z3madDv8_dS_S_(<8 x double> %x, <8 x double> %y, <8 x double> %z)
  ret <8 x double> %mad
}

define <16 x double> @test_mad_v16f64(<16 x double> %x, <16 x double> %y, <16 x double> %z) {
; CHECK-LABEL: define <16 x double> @test_mad_v16f64
; CHECK-SAME: (<16 x double> [[X:%.*]], <16 x double> [[Y:%.*]], <16 x double> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <16 x double> @llvm.fmuladd.v16f64(<16 x double> [[X]], <16 x double> [[Y]], <16 x double> [[Z]])
; CHECK-NEXT:    ret <16 x double> [[MAD]]
;
  %mad = tail call <16 x double> @_Z3madDv16_dS_S_(<16 x double> %x, <16 x double> %y, <16 x double> %z)
  ret <16 x double> %mad
}

define half @test_mad_f16(half %x, half %y, half %z) {
; CHECK-LABEL: define half @test_mad_f16
; CHECK-SAME: (half [[X:%.*]], half [[Y:%.*]], half [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call half @llvm.fmuladd.f16(half [[X]], half [[Y]], half [[Z]])
; CHECK-NEXT:    ret half [[MAD]]
;
  %mad = tail call half @_Z3madDhDhDh(half %x, half %y, half %z)
  ret half %mad
}

define <2 x half> @test_mad_v2f16(<2 x half> %x, <2 x half> %y, <2 x half> %z) {
; CHECK-LABEL: define <2 x half> @test_mad_v2f16
; CHECK-SAME: (<2 x half> [[X:%.*]], <2 x half> [[Y:%.*]], <2 x half> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <2 x half> @llvm.fmuladd.v2f16(<2 x half> [[X]], <2 x half> [[Y]], <2 x half> [[Z]])
; CHECK-NEXT:    ret <2 x half> [[MAD]]
;
  %mad = tail call <2 x half> @_Z3madDv2_DhS_S_(<2 x half> %x, <2 x half> %y, <2 x half> %z)
  ret <2 x half> %mad
}

define <3 x half> @test_mad_v3f16(<3 x half> %x, <3 x half> %y, <3 x half> %z) {
; CHECK-LABEL: define <3 x half> @test_mad_v3f16
; CHECK-SAME: (<3 x half> [[X:%.*]], <3 x half> [[Y:%.*]], <3 x half> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <3 x half> @llvm.fmuladd.v3f16(<3 x half> [[X]], <3 x half> [[Y]], <3 x half> [[Z]])
; CHECK-NEXT:    ret <3 x half> [[MAD]]
;
  %mad = tail call <3 x half> @_Z3madDv3_DhS_S_(<3 x half> %x, <3 x half> %y, <3 x half> %z)
  ret <3 x half> %mad
}

define <4 x half> @test_mad_v4f16(<4 x half> %x, <4 x half> %y, <4 x half> %z) {
; CHECK-LABEL: define <4 x half> @test_mad_v4f16
; CHECK-SAME: (<4 x half> [[X:%.*]], <4 x half> [[Y:%.*]], <4 x half> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <4 x half> @llvm.fmuladd.v4f16(<4 x half> [[X]], <4 x half> [[Y]], <4 x half> [[Z]])
; CHECK-NEXT:    ret <4 x half> [[MAD]]
;
  %mad = tail call <4 x half> @_Z3madDv4_DhS_S_(<4 x half> %x, <4 x half> %y, <4 x half> %z)
  ret <4 x half> %mad
}

define <8 x half> @test_mad_v8f16(<8 x half> %x, <8 x half> %y, <8 x half> %z) {
; CHECK-LABEL: define <8 x half> @test_mad_v8f16
; CHECK-SAME: (<8 x half> [[X:%.*]], <8 x half> [[Y:%.*]], <8 x half> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <8 x half> @llvm.fmuladd.v8f16(<8 x half> [[X]], <8 x half> [[Y]], <8 x half> [[Z]])
; CHECK-NEXT:    ret <8 x half> [[MAD]]
;
  %mad = tail call <8 x half> @_Z3madDv8_DhS_S_(<8 x half> %x, <8 x half> %y, <8 x half> %z)
  ret <8 x half> %mad
}

define <16 x half> @test_mad_v16f16(<16 x half> %x, <16 x half> %y, <16 x half> %z) {
; CHECK-LABEL: define <16 x half> @test_mad_v16f16
; CHECK-SAME: (<16 x half> [[X:%.*]], <16 x half> [[Y:%.*]], <16 x half> [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call <16 x half> @llvm.fmuladd.v16f16(<16 x half> [[X]], <16 x half> [[Y]], <16 x half> [[Z]])
; CHECK-NEXT:    ret <16 x half> [[MAD]]
;
  %mad = tail call <16 x half> @_Z3madDv16_DhS_S_(<16 x half> %x, <16 x half> %y, <16 x half> %z)
  ret <16 x half> %mad
}

define float @test_mad_f32_fast(float %x, float %y, float %z) {
; CHECK-LABEL: define float @test_mad_f32_fast
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call fast float @llvm.fmuladd.f32(float [[X]], float [[Y]], float [[Z]])
; CHECK-NEXT:    ret float [[MAD]]
;
  %mad = tail call fast float @_Z3madfff(float %x, float %y, float %z)
  ret float %mad
}

define float @test_mad_f32_noinline(float %x, float %y, float %z) {
; CHECK-LABEL: define float @test_mad_f32_noinline
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call fast float @_Z3madfff(float [[X]], float [[Y]], float [[Z]]) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    ret float [[MAD]]
;
  %mad = tail call fast float @_Z3madfff(float %x, float %y, float %z) #1
  ret float %mad
}

define float @test_mad_f32_fast_minsize(float %x, float %y, float %z) #0 {
; CHECK-LABEL: define float @test_mad_f32_fast_minsize
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[MAD:%.*]] = tail call fast float @llvm.fmuladd.f32(float [[X]], float [[Y]], float [[Z]])
; CHECK-NEXT:    ret float [[MAD]]
;
  %mad = tail call fast float @_Z3madfff(float %x, float %y, float %z)
  ret float %mad
}

define float @test_mad_f32_fast_strictfp(float %x, float %y, float %z) #2 {
; CHECK-LABEL: define float @test_mad_f32_fast_strictfp
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[MAD:%.*]] = tail call nnan nsz float @_Z3madfff(float [[X]], float [[Y]], float [[Z]]) #[[ATTR1]]
; CHECK-NEXT:    ret float [[MAD]]
;
  %mad = tail call nsz nnan float @_Z3madfff(float %x, float %y, float %z) #2
  ret float %mad
}

define float @test_mad_f32_fast_nobuiltin(float %x, float %y, float %z) {
; CHECK-LABEL: define float @test_mad_f32_fast_nobuiltin
; CHECK-SAME: (float [[X:%.*]], float [[Y:%.*]], float [[Z:%.*]]) {
; CHECK-NEXT:    [[MAD:%.*]] = tail call fast float @_Z3madfff(float [[X]], float [[Y]], float [[Z]]) #[[ATTR4:[0-9]+]]
; CHECK-NEXT:    ret float [[MAD]]
;
  %mad = tail call fast float @_Z3madfff(float %x, float %y, float %z) #3
  ret float %mad
}

attributes #0 = { minsize }
attributes #1 = { noinline }
attributes #2 = { strictfp }
attributes #3 = { nobuiltin }
