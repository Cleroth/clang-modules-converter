; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;; Splats of legal integer vector types

define <vscale x 16 x i8> @sve_splat_16xi8(i8 %val) {
; CHECK-LABEL: sve_splat_16xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, w0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 16 x i8> undef, i8 %val, i32 0
  %splat = shufflevector <vscale x 16 x i8> %ins, <vscale x 16 x i8> undef, <vscale x 16 x i32> zeroinitializer
  ret <vscale x 16 x i8> %splat
}

define <vscale x 8 x i16> @sve_splat_8xi16(i16 %val) {
; CHECK-LABEL: sve_splat_8xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, w0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 8 x i16> undef, i16 %val, i32 0
  %splat = shufflevector <vscale x 8 x i16> %ins, <vscale x 8 x i16> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x i16> %splat
}

define <vscale x 4 x i32> @sve_splat_4xi32(i32 %val) {
; CHECK-LABEL: sve_splat_4xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, w0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 4 x i32> undef, i32 %val, i32 0
  %splat = shufflevector <vscale x 4 x i32> %ins, <vscale x 4 x i32> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i32> %splat
}

define <vscale x 2 x i64> @sve_splat_2xi64(i64 %val) {
; CHECK-LABEL: sve_splat_2xi64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, x0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i64> undef, i64 %val, i32 0
  %splat = shufflevector <vscale x 2 x i64> %ins, <vscale x 2 x i64> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i64> %splat
}

define <vscale x 16 x i8> @sve_splat_16xi8_imm() {
; CHECK-LABEL: sve_splat_16xi8_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.b, #1 // =0x1
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 16 x i8> undef, i8 1, i32 0
  %splat = shufflevector <vscale x 16 x i8> %ins, <vscale x 16 x i8> undef, <vscale x 16 x i32> zeroinitializer
  ret <vscale x 16 x i8> %splat
}

define <vscale x 8 x i16> @sve_splat_8xi16_dup_imm() {
; CHECK-LABEL: sve_splat_8xi16_dup_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #1 // =0x1
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 8 x i16> undef, i16 1, i32 0
  %splat = shufflevector <vscale x 8 x i16> %ins, <vscale x 8 x i16> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x i16> %splat
}

define <vscale x 8 x i16> @sve_splat_8xi16_dupm_imm() {
; CHECK-LABEL: sve_splat_8xi16_dupm_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #16256 // =0x3f80
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 8 x i16> undef, i16 16256, i32 0 ; 0x3f80
  %splat = shufflevector <vscale x 8 x i16> %ins, <vscale x 8 x i16> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x i16> %splat
}

define <vscale x 4 x i32> @sve_splat_4xi32_dup_imm() {
; CHECK-LABEL: sve_splat_4xi32_dup_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, #1 // =0x1
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 4 x i32> undef, i32 1, i32 0
  %splat = shufflevector <vscale x 4 x i32> %ins, <vscale x 4 x i32> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i32> %splat
}

define <vscale x 4 x i32> @sve_splat_4xi32_dupm_imm() {
; CHECK-LABEL: sve_splat_4xi32_dupm_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, #0xff0000
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 4 x i32> undef, i32 16711680, i32 0 ; 0xff0000
  %splat = shufflevector <vscale x 4 x i32> %ins, <vscale x 4 x i32> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i32> %splat
}

define <vscale x 2 x i64> @sve_splat_2xi64_dup_imm() {
; CHECK-LABEL: sve_splat_2xi64_dup_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, #1 // =0x1
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i64> undef, i64 1, i32 0
  %splat = shufflevector <vscale x 2 x i64> %ins, <vscale x 2 x i64> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i64> %splat
}

define <vscale x 2 x i64> @sve_splat_2xi64_dupm_imm() {
; CHECK-LABEL: sve_splat_2xi64_dupm_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, #0xffff00000000
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i64> undef, i64 281470681743360, i32 0 ; 0xffff00000000
  %splat = shufflevector <vscale x 2 x i64> %ins, <vscale x 2 x i64> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i64> %splat
}

;; Promote splats of smaller illegal integer vector types

define <vscale x 2 x i8> @sve_splat_2xi8(i8 %val) {
; CHECK-LABEL: sve_splat_2xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    mov z0.d, x0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i8> undef, i8 %val, i32 0
  %splat = shufflevector <vscale x 2 x i8> %ins, <vscale x 2 x i8> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i8> %splat
}

define <vscale x 4 x i8> @sve_splat_4xi8(i8 %val) {
; CHECK-LABEL: sve_splat_4xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, w0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 4 x i8> undef, i8 %val, i32 0
  %splat = shufflevector <vscale x 4 x i8> %ins, <vscale x 4 x i8> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i8> %splat
}

define <vscale x 8 x i8> @sve_splat_8xi8(i8 %val) {
; CHECK-LABEL: sve_splat_8xi8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, w0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 8 x i8> undef, i8 %val, i32 0
  %splat = shufflevector <vscale x 8 x i8> %ins, <vscale x 8 x i8> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x i8> %splat
}

define <vscale x 8 x i8> @sve_splat_8xi8_imm() {
; CHECK-LABEL: sve_splat_8xi8_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #255 // =0xff
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 8 x i8> undef, i8 -1, i32 0
  %splat = shufflevector <vscale x 8 x i8> %ins, <vscale x 8 x i8> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x i8> %splat
}

define <vscale x 2 x i16> @sve_splat_2xi16(i16 %val) {
; CHECK-LABEL: sve_splat_2xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    mov z0.d, x0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i16> undef, i16 %val, i32 0
  %splat = shufflevector <vscale x 2 x i16> %ins, <vscale x 2 x i16> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i16> %splat
}

define <vscale x 4 x i16> @sve_splat_4xi16(i16 %val) {
; CHECK-LABEL: sve_splat_4xi16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, w0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 4 x i16> undef, i16 %val, i32 0
  %splat = shufflevector <vscale x 4 x i16> %ins, <vscale x 4 x i16> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i16> %splat
}

define <vscale x 4 x i16> @sve_splat_4xi16_imm() {
; CHECK-LABEL: sve_splat_4xi16_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, #65535 // =0xffff
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 4 x i16> undef, i16 -1, i32 0
  %splat = shufflevector <vscale x 4 x i16> %ins, <vscale x 4 x i16> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i16> %splat
}

define <vscale x 2 x i32> @sve_splat_2xi32(i32 %val) {
; CHECK-LABEL: sve_splat_2xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    mov z0.d, x0
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i32> undef, i32 %val, i32 0
  %splat = shufflevector <vscale x 2 x i32> %ins, <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i32> %splat
}

define <vscale x 2 x i32> @sve_splat_2xi32_imm() {
; CHECK-LABEL: sve_splat_2xi32_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, #0xffffffff
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i32> undef, i32 -1, i32 0
  %splat = shufflevector <vscale x 2 x i32> %ins, <vscale x 2 x i32> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i32> %splat
}

;; Widen/split splats of wide vector types.

define <vscale x 1 x i32> @sve_splat_1xi32(i32 %val) {
; CHECK-LABEL: sve_splat_1xi32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov z0.s, w0
; CHECK-NEXT:    ret
entry:
  %ins = insertelement <vscale x 1 x i32> undef, i32 %val, i32 0
  %splat = shufflevector <vscale x 1 x i32> %ins, <vscale x 1 x i32> undef, <vscale x 1 x i32> zeroinitializer
  ret <vscale x 1 x i32> %splat
}

define <vscale x 12 x i32> @sve_splat_12xi32(i32 %val) {
; CHECK-LABEL: sve_splat_12xi32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, w0
; CHECK-NEXT:    mov z1.d, z0.d
; CHECK-NEXT:    mov z2.d, z0.d
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 12 x i32> undef, i32 %val, i32 0
  %splat = shufflevector <vscale x 12 x i32> %ins, <vscale x 12 x i32> undef, <vscale x 12 x i32> zeroinitializer
  ret <vscale x 12 x i32> %splat
}

define <vscale x 2 x i1> @sve_splat_2xi1(i1 %val) {
; CHECK-LABEL: sve_splat_2xi1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sbfx x8, x0, #0, #1
; CHECK-NEXT:    whilelo p0.d, xzr, x8
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i1> undef, i1 %val, i32 0
  %splat = shufflevector <vscale x 2 x i1> %ins, <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i1> %splat
}

define <vscale x 4 x i1> @sve_splat_4xi1(i1 %val) {
; CHECK-LABEL: sve_splat_4xi1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sbfx x8, x0, #0, #1
; CHECK-NEXT:    whilelo p0.s, xzr, x8
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 4 x i1> undef, i1 %val, i32 0
  %splat = shufflevector <vscale x 4 x i1> %ins, <vscale x 4 x i1> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i1> %splat
}

define <vscale x 8 x i1> @sve_splat_8xi1(i1 %val) {
; CHECK-LABEL: sve_splat_8xi1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sbfx x8, x0, #0, #1
; CHECK-NEXT:    whilelo p0.h, xzr, x8
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 8 x i1> undef, i1 %val, i32 0
  %splat = shufflevector <vscale x 8 x i1> %ins, <vscale x 8 x i1> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x i1> %splat
}

define <vscale x 16 x i1> @sve_splat_16xi1(i1 %val) {
; CHECK-LABEL: sve_splat_16xi1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sbfx x8, x0, #0, #1
; CHECK-NEXT:    whilelo p0.b, xzr, x8
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 16 x i1> undef, i1 %val, i32 0
  %splat = shufflevector <vscale x 16 x i1> %ins, <vscale x 16 x i1> undef, <vscale x 16 x i32> zeroinitializer
  ret <vscale x 16 x i1> %splat
}

;; Splats of legal floating point vector types

define <vscale x 8 x bfloat> @splat_nxv8bf16(bfloat %val) #0 {
; CHECK-LABEL: splat_nxv8bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 8 x bfloat> undef, bfloat %val, i32 0
  %2 = shufflevector <vscale x 8 x bfloat> %1, <vscale x 8 x bfloat> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x bfloat> %2
}

define <vscale x 4 x bfloat> @splat_nxv4bf16(bfloat %val) #0 {
; CHECK-LABEL: splat_nxv4bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 4 x bfloat> undef, bfloat %val, i32 0
  %2 = shufflevector <vscale x 4 x bfloat> %1, <vscale x 4 x bfloat> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x bfloat> %2
}

define <vscale x 2 x bfloat> @splat_nxv2bf16(bfloat %val) #0 {
; CHECK-LABEL: splat_nxv2bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x bfloat> undef, bfloat %val, i32 0
  %2 = shufflevector <vscale x 2 x bfloat> %1, <vscale x 2 x bfloat> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x bfloat> %2
}

define <vscale x 8 x half> @splat_nxv8f16(half %val) {
; CHECK-LABEL: splat_nxv8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 8 x half> undef, half %val, i32 0
  %2 = shufflevector <vscale x 8 x half> %1, <vscale x 8 x half> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x half> %2
}

define <vscale x 4 x half> @splat_nxv4f16(half %val) {
; CHECK-LABEL: splat_nxv4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 4 x half> undef, half %val, i32 0
  %2 = shufflevector <vscale x 4 x half> %1, <vscale x 4 x half> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x half> %2
}

define <vscale x 2 x half> @splat_nxv2f16(half %val) {
; CHECK-LABEL: splat_nxv2f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $h0 killed $h0 def $z0
; CHECK-NEXT:    mov z0.h, h0
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x half> undef, half %val, i32 0
  %2 = shufflevector <vscale x 2 x half> %1, <vscale x 2 x half> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x half> %2
}

define <vscale x 4 x float> @splat_nxv4f32(float %val) {
; CHECK-LABEL: splat_nxv4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $z0
; CHECK-NEXT:    mov z0.s, s0
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 4 x float> undef, float %val, i32 0
  %2 = shufflevector <vscale x 4 x float> %1, <vscale x 4 x float> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x float> %2
}

define <vscale x 2 x float> @splat_nxv2f32(float %val) {
; CHECK-LABEL: splat_nxv2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $z0
; CHECK-NEXT:    mov z0.s, s0
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x float> undef, float %val, i32 0
  %2 = shufflevector <vscale x 2 x float> %1, <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x float> %2
}

define <vscale x 2 x double> @splat_nxv2f64(double %val) {
; CHECK-LABEL: splat_nxv2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $z0
; CHECK-NEXT:    mov z0.d, d0
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x double> undef, double %val, i32 0
  %2 = shufflevector <vscale x 2 x double> %1, <vscale x 2 x double> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x double> %2
}

define <vscale x 8 x bfloat> @splat_nxv8bf16_zero() #0 {
; CHECK-LABEL: splat_nxv8bf16_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ret
  ret <vscale x 8 x bfloat> zeroinitializer
}

define <vscale x 4 x bfloat> @splat_nxv4bf16_zero() #0 {
; CHECK-LABEL: splat_nxv4bf16_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ret
  ret <vscale x 4 x bfloat> zeroinitializer
}

define <vscale x 2 x bfloat> @splat_nxv2bf16_zero() #0 {
; CHECK-LABEL: splat_nxv2bf16_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ret
  ret <vscale x 2 x bfloat> zeroinitializer
}

define <vscale x 8 x half> @splat_nxv8f16_zero() {
; CHECK-LABEL: splat_nxv8f16_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ret
  ret <vscale x 8 x half> zeroinitializer
}

define <vscale x 4 x half> @splat_nxv4f16_zero() {
; CHECK-LABEL: splat_nxv4f16_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ret
  ret <vscale x 4 x half> zeroinitializer
}

define <vscale x 2 x half> @splat_nxv2f16_zero() {
; CHECK-LABEL: splat_nxv2f16_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.h, #0 // =0x0
; CHECK-NEXT:    ret
  ret <vscale x 2 x half> zeroinitializer
}

define <vscale x 4 x float> @splat_nxv4f32_zero() {
; CHECK-LABEL: splat_nxv4f32_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    ret
  ret <vscale x 4 x float> zeroinitializer
}

define <vscale x 2 x float> @splat_nxv2f32_zero() {
; CHECK-LABEL: splat_nxv2f32_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    ret
  ret <vscale x 2 x float> zeroinitializer
}

define <vscale x 2 x double> @splat_nxv2f64_zero() {
; CHECK-LABEL: splat_nxv2f64_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, #0 // =0x0
; CHECK-NEXT:    ret
  ret <vscale x 2 x double> zeroinitializer
}

define <vscale x 8 x half> @splat_nxv8f16_imm() {
; CHECK-LABEL: splat_nxv8f16_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov z0.h, #1.00000000
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 8 x half> undef, half 1.0, i32 0
  %2 = shufflevector <vscale x 8 x half> %1, <vscale x 8 x half> undef, <vscale x 8 x i32> zeroinitializer
  ret <vscale x 8 x half> %2
}

define <vscale x 4 x half> @splat_nxv4f16_imm() {
; CHECK-LABEL: splat_nxv4f16_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov z0.h, #1.00000000
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 4 x half> undef, half 1.0, i32 0
  %2 = shufflevector <vscale x 4 x half> %1, <vscale x 4 x half> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x half> %2
}

define <vscale x 2 x half> @splat_nxv2f16_imm() {
; CHECK-LABEL: splat_nxv2f16_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov z0.h, #1.00000000
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x half> undef, half 1.0, i32 0
  %2 = shufflevector <vscale x 2 x half> %1, <vscale x 2 x half> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x half> %2
}

define <vscale x 4 x float> @splat_nxv4f32_imm() {
; CHECK-LABEL: splat_nxv4f32_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov z0.s, #1.00000000
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 4 x float> undef, float 1.0, i32 0
  %2 = shufflevector <vscale x 4 x float> %1, <vscale x 4 x float> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x float> %2
}

define <vscale x 2 x float> @splat_nxv2f32_imm() {
; CHECK-LABEL: splat_nxv2f32_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov z0.s, #1.00000000
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x float> undef, float 1.0, i32 0
  %2 = shufflevector <vscale x 2 x float> %1, <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x float> %2
}

define <vscale x 2 x double> @splat_nxv2f64_imm() {
; CHECK-LABEL: splat_nxv2f64_imm:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov z0.d, #1.00000000
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x double> undef, double 1.0, i32 0
  %2 = shufflevector <vscale x 2 x double> %1, <vscale x 2 x double> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x double> %2
}

define <vscale x 4 x i32> @splat_nxv4i32_fold(<vscale x 4 x i32> %x) {
; CHECK-LABEL: splat_nxv4i32_fold:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    ret
  %r = sub <vscale x 4 x i32> %x, %x
  ret <vscale x 4 x i32> %r
}


define <vscale x 4 x float> @splat_nxv4f32_fold(<vscale x 4 x float> %x) {
; CHECK-LABEL: splat_nxv4f32_fold:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.s, #0 // =0x0
; CHECK-NEXT:    ret
  %r = fsub nnan <vscale x 4 x float> %x, %x
  ret <vscale x 4 x float> %r
}

define <vscale x 2 x float> @splat_nxv2f32_fmov_fold() {
; CHECK-LABEL: splat_nxv2f32_fmov_fold:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1109917696 // =0x42280000
; CHECK-NEXT:    mov z0.s, w8
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x float> undef, float 4.200000e+01, i32 0
  %2 = shufflevector <vscale x 2 x float> %1, <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x float> %2
}

define <vscale x 4 x float> @splat_nxv4f32_fmov_fold() {
; CHECK-LABEL: splat_nxv4f32_fmov_fold:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1109917696 // =0x42280000
; CHECK-NEXT:    mov z0.s, w8
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 4 x float> undef, float 4.200000e+01, i32 0
  %2 = shufflevector <vscale x 4 x float> %1, <vscale x 4 x float> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x float> %2
}

define <vscale x 2 x double> @splat_nxv2f64_fmov_fold() {
; CHECK-LABEL: splat_nxv2f64_fmov_fold:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #4631107791820423168 // =0x4045000000000000
; CHECK-NEXT:    mov z0.d, x8
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x double> undef, double 4.200000e+01, i32 0
  %2 = shufflevector <vscale x 2 x double> %1, <vscale x 2 x double> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x double> %2
}

; Splat of float constants not representable as a single immediate.

define <vscale x 2 x float> @splat_nxv2f32_imm_out_of_range() {
; CHECK-LABEL: splat_nxv2f32_imm_out_of_range:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #7864 // =0x1eb8
; CHECK-NEXT:    movk w8, #16469, lsl #16
; CHECK-NEXT:    mov z0.s, w8
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x float> undef, float 3.3299999237060546875, i32 0
  %2 = shufflevector <vscale x 2 x float> %1, <vscale x 2 x float> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x float> %2
}

define <vscale x 4 x float> @splat_nxv4f32_imm_out_of_range() {
; CHECK-LABEL: splat_nxv4f32_imm_out_of_range:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #7864 // =0x1eb8
; CHECK-NEXT:    movk w8, #16469, lsl #16
; CHECK-NEXT:    mov z0.s, w8
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 4 x float> undef, float 3.3299999237060546875, i32 0
  %2 = shufflevector <vscale x 4 x float> %1, <vscale x 4 x float> undef, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x float> %2
}

define <vscale x 2 x double> @splat_nxv2f64_imm_out_of_range() {
; CHECK-LABEL: splat_nxv2f64_imm_out_of_range:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    adrp x8, .LCPI57_0
; CHECK-NEXT:    add x8, x8, :lo12:.LCPI57_0
; CHECK-NEXT:    ld1rd { z0.d }, p0/z, [x8]
; CHECK-NEXT:    ret
  %1 = insertelement <vscale x 2 x double> undef, double 3.33, i32 0
  %2 = shufflevector <vscale x 2 x double> %1, <vscale x 2 x double> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x double> %2
}

; Splat for predicates
; This guards optimizations that rely on splats of 1 being generated as a ptrue

define <vscale x 2 x i1> @sve_splat_i1_allactive() {
; CHECK-LABEL: sve_splat_i1_allactive:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 2 x i1> undef, i1 1, i32 0
  %splat = shufflevector <vscale x 2 x i1> %ins, <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer
  ret <vscale x 2 x i1> %splat
}

; +bf16 is required for the bfloat version.
attributes #0 = { "target-features"="+sve,+bf16" }
