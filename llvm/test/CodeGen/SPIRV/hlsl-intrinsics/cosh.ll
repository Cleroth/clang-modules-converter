; RUN: llc -O0 -mtriple=spirv-unknown-unknown %s -o - | FileCheck %s
; RUN: %if spirv-tools %{ llc -O0 -mtriple=spirv-unknown-unknown %s -o - -filetype=obj | spirv-val %}

; CHECK-DAG: %[[#op_ext_glsl:]] = OpExtInstImport "GLSL.std.450"
; CHECK-DAG: %[[#float_32:]] = OpTypeFloat 32
; CHECK-DAG: %[[#float_16:]] = OpTypeFloat 16
; CHECK-DAG: %[[#vec4_float_32:]] = OpTypeVector %[[#float_32]] 4
; CHECK-DAG: %[[#vec4_float_16:]] = OpTypeVector %[[#float_16]] 4

define noundef float @cosh_float(float noundef %a) {
entry:
; CHECK: %[[#arg0:]] = OpFunctionParameter %[[#]]
; CHECK: %[[#]] = OpExtInst %[[#float_32]] %[[#op_ext_glsl]] Cosh %[[#arg0]]
  %elt.cosh = call float @llvm.cosh.f32(float %a)
  ret float %elt.cosh
}

define noundef half @cosh_half(half noundef %a) {
entry:
; CHECK: %[[#arg0:]] = OpFunctionParameter %[[#]]
; CHECK: %[[#]] = OpExtInst %[[#float_16]] %[[#op_ext_glsl]] Cosh %[[#arg0]]
  %elt.cosh = call half @llvm.cosh.f16(half %a)
  ret half %elt.cosh
}

define noundef <4 x float> @cosh_float4(<4 x float> noundef %a) {
entry:
  ; CHECK: %[[#arg0:]] = OpFunctionParameter %[[#]]
  ; CHECK: %[[#]] = OpExtInst %[[#vec4_float_32]] %[[#op_ext_glsl]] Cosh %[[#arg0]]
  %elt.cosh = call <4 x float> @llvm.cosh.v4f32(<4 x float> %a)
  ret <4 x float> %elt.cosh
}

define noundef <4 x half> @cosh_half4(<4 x half> noundef %a) {
entry:
  ; CHECK: %[[#arg0:]] = OpFunctionParameter %[[#]]
  ; CHECK: %[[#]] = OpExtInst %[[#vec4_float_16]] %[[#op_ext_glsl]] Cosh %[[#arg0]]
  %elt.cosh = call <4 x half> @llvm.cosh.v4f16(<4 x half> %a)
  ret <4 x half> %elt.cosh
}

declare half @llvm.cosh.f16(half)
declare float @llvm.cosh.f32(float)
declare <4 x half> @llvm.cosh.v4f16(<4 x half>)
declare <4 x float> @llvm.cosh.v4f32(<4 x float>)
