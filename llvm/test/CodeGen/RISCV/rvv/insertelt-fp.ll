; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x half> @insertelt_nxv1f16_0(<vscale x 1 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv1f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x half> %v, half %elt, i32 0
  ret <vscale x 1 x half> %r
}

define <vscale x 1 x half> @insertelt_nxv1f16_imm(<vscale x 1 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv1f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf4, tu, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x half> %v, half %elt, i32 3
  ret <vscale x 1 x half> %r
}

define <vscale x 1 x half> @insertelt_nxv1f16_idx(<vscale x 1 x half> %v, half %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv1f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x half> %v, half %elt, i32 %idx
  ret <vscale x 1 x half> %r
}

define <vscale x 2 x half> @insertelt_nxv2f16_0(<vscale x 2 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv2f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x half> %v, half %elt, i32 0
  ret <vscale x 2 x half> %r
}

define <vscale x 2 x half> @insertelt_nxv2f16_imm(<vscale x 2 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv2f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, tu, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x half> %v, half %elt, i32 3
  ret <vscale x 2 x half> %r
}

define <vscale x 2 x half> @insertelt_nxv2f16_idx(<vscale x 2 x half> %v, half %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv2f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x half> %v, half %elt, i32 %idx
  ret <vscale x 2 x half> %r
}

define <vscale x 4 x half> @insertelt_nxv4f16_0(<vscale x 4 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv4f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x half> %v, half %elt, i32 0
  ret <vscale x 4 x half> %r
}

define <vscale x 4 x half> @insertelt_nxv4f16_imm(<vscale x 4 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv4f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x half> %v, half %elt, i32 3
  ret <vscale x 4 x half> %r
}

define <vscale x 4 x half> @insertelt_nxv4f16_idx(<vscale x 4 x half> %v, half %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv4f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli a2, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x half> %v, half %elt, i32 %idx
  ret <vscale x 4 x half> %r
}

define <vscale x 8 x half> @insertelt_nxv8f16_0(<vscale x 8 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv8f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x half> %v, half %elt, i32 0
  ret <vscale x 8 x half> %r
}

define <vscale x 8 x half> @insertelt_nxv8f16_imm(<vscale x 8 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv8f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x half> %v, half %elt, i32 3
  ret <vscale x 8 x half> %r
}

define <vscale x 8 x half> @insertelt_nxv8f16_idx(<vscale x 8 x half> %v, half %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv8f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v10, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x half> %v, half %elt, i32 %idx
  ret <vscale x 8 x half> %r
}

define <vscale x 16 x half> @insertelt_nxv16f16_0(<vscale x 16 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv16f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x half> %v, half %elt, i32 0
  ret <vscale x 16 x half> %r
}

define <vscale x 16 x half> @insertelt_nxv16f16_imm(<vscale x 16 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv16f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    vslideup.vi v8, v12, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x half> %v, half %elt, i32 3
  ret <vscale x 16 x half> %r
}

define <vscale x 16 x half> @insertelt_nxv16f16_idx(<vscale x 16 x half> %v, half %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv16f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e16, m4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v12, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x half> %v, half %elt, i32 %idx
  ret <vscale x 16 x half> %r
}

define <vscale x 32 x half> @insertelt_nxv32f16_0(<vscale x 32 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv32f16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 32 x half> %v, half %elt, i32 0
  ret <vscale x 32 x half> %r
}

define <vscale x 32 x half> @insertelt_nxv32f16_imm(<vscale x 32 x half> %v, half %elt) {
; CHECK-LABEL: insertelt_nxv32f16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v16, fa0
; CHECK-NEXT:    vslideup.vi v8, v16, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 32 x half> %v, half %elt, i32 3
  ret <vscale x 32 x half> %r
}

define <vscale x 32 x half> @insertelt_nxv32f16_idx(<vscale x 32 x half> %v, half %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv32f16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v16, fa0
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e16, m8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v16, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 32 x half> %v, half %elt, i32 %idx
  ret <vscale x 32 x half> %r
}

define <vscale x 1 x float> @insertelt_nxv1f32_0(<vscale x 1 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv1f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x float> %v, float %elt, i32 0
  ret <vscale x 1 x float> %r
}

define <vscale x 1 x float> @insertelt_nxv1f32_imm(<vscale x 1 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv1f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, mf2, tu, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x float> %v, float %elt, i32 3
  ret <vscale x 1 x float> %r
}

define <vscale x 1 x float> @insertelt_nxv1f32_idx(<vscale x 1 x float> %v, float %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv1f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli a2, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x float> %v, float %elt, i32 %idx
  ret <vscale x 1 x float> %r
}

define <vscale x 2 x float> @insertelt_nxv2f32_0(<vscale x 2 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv2f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x float> %v, float %elt, i32 0
  ret <vscale x 2 x float> %r
}

define <vscale x 2 x float> @insertelt_nxv2f32_imm(<vscale x 2 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv2f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x float> %v, float %elt, i32 3
  ret <vscale x 2 x float> %r
}

define <vscale x 2 x float> @insertelt_nxv2f32_idx(<vscale x 2 x float> %v, float %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv2f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli a2, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x float> %v, float %elt, i32 %idx
  ret <vscale x 2 x float> %r
}

define <vscale x 4 x float> @insertelt_nxv4f32_0(<vscale x 4 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv4f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x float> %v, float %elt, i32 0
  ret <vscale x 4 x float> %r
}

define <vscale x 4 x float> @insertelt_nxv4f32_imm(<vscale x 4 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv4f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x float> %v, float %elt, i32 3
  ret <vscale x 4 x float> %r
}

define <vscale x 4 x float> @insertelt_nxv4f32_idx(<vscale x 4 x float> %v, float %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv4f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v10, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x float> %v, float %elt, i32 %idx
  ret <vscale x 4 x float> %r
}

define <vscale x 8 x float> @insertelt_nxv8f32_0(<vscale x 8 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv8f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x float> %v, float %elt, i32 0
  ret <vscale x 8 x float> %r
}

define <vscale x 8 x float> @insertelt_nxv8f32_imm(<vscale x 8 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv8f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    vslideup.vi v8, v12, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x float> %v, float %elt, i32 3
  ret <vscale x 8 x float> %r
}

define <vscale x 8 x float> @insertelt_nxv8f32_idx(<vscale x 8 x float> %v, float %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv8f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v12, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x float> %v, float %elt, i32 %idx
  ret <vscale x 8 x float> %r
}

define <vscale x 16 x float> @insertelt_nxv16f32_0(<vscale x 16 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv16f32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x float> %v, float %elt, i32 0
  ret <vscale x 16 x float> %r
}

define <vscale x 16 x float> @insertelt_nxv16f32_imm(<vscale x 16 x float> %v, float %elt) {
; CHECK-LABEL: insertelt_nxv16f32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v16, fa0
; CHECK-NEXT:    vslideup.vi v8, v16, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x float> %v, float %elt, i32 3
  ret <vscale x 16 x float> %r
}

define <vscale x 16 x float> @insertelt_nxv16f32_idx(<vscale x 16 x float> %v, float %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv16f32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v16, fa0
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e32, m8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v16, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 16 x float> %v, float %elt, i32 %idx
  ret <vscale x 16 x float> %r
}

define <vscale x 1 x double> @insertelt_nxv1f64_0(<vscale x 1 x double> %v, double %elt) {
; CHECK-LABEL: insertelt_nxv1f64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x double> %v, double %elt, i32 0
  ret <vscale x 1 x double> %r
}

define <vscale x 1 x double> @insertelt_nxv1f64_imm(<vscale x 1 x double> %v, double %elt) {
; CHECK-LABEL: insertelt_nxv1f64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vslideup.vi v8, v9, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x double> %v, double %elt, i32 3
  ret <vscale x 1 x double> %r
}

define <vscale x 1 x double> @insertelt_nxv1f64_idx(<vscale x 1 x double> %v, double %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv1f64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli a2, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v9, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 1 x double> %v, double %elt, i32 %idx
  ret <vscale x 1 x double> %r
}

define <vscale x 2 x double> @insertelt_nxv2f64_0(<vscale x 2 x double> %v, double %elt) {
; CHECK-LABEL: insertelt_nxv2f64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x double> %v, double %elt, i32 0
  ret <vscale x 2 x double> %r
}

define <vscale x 2 x double> @insertelt_nxv2f64_imm(<vscale x 2 x double> %v, double %elt) {
; CHECK-LABEL: insertelt_nxv2f64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vslideup.vi v8, v10, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x double> %v, double %elt, i32 3
  ret <vscale x 2 x double> %r
}

define <vscale x 2 x double> @insertelt_nxv2f64_idx(<vscale x 2 x double> %v, double %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv2f64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v10, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 2 x double> %v, double %elt, i32 %idx
  ret <vscale x 2 x double> %r
}

define <vscale x 4 x double> @insertelt_nxv4f64_0(<vscale x 4 x double> %v, double %elt) {
; CHECK-LABEL: insertelt_nxv4f64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x double> %v, double %elt, i32 0
  ret <vscale x 4 x double> %r
}

define <vscale x 4 x double> @insertelt_nxv4f64_imm(<vscale x 4 x double> %v, double %elt) {
; CHECK-LABEL: insertelt_nxv4f64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    vslideup.vi v8, v12, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x double> %v, double %elt, i32 3
  ret <vscale x 4 x double> %r
}

define <vscale x 4 x double> @insertelt_nxv4f64_idx(<vscale x 4 x double> %v, double %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv4f64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v12, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 4 x double> %v, double %elt, i32 %idx
  ret <vscale x 4 x double> %r
}

define <vscale x 8 x double> @insertelt_nxv8f64_0(<vscale x 8 x double> %v, double %elt) {
; CHECK-LABEL: insertelt_nxv8f64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, tu, ma
; CHECK-NEXT:    vfmv.s.f v8, fa0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x double> %v, double %elt, i32 0
  ret <vscale x 8 x double> %r
}

define <vscale x 8 x double> @insertelt_nxv8f64_imm(<vscale x 8 x double> %v, double %elt) {
; CHECK-LABEL: insertelt_nxv8f64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, tu, ma
; CHECK-NEXT:    vfmv.s.f v16, fa0
; CHECK-NEXT:    vslideup.vi v8, v16, 3
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x double> %v, double %elt, i32 3
  ret <vscale x 8 x double> %r
}

define <vscale x 8 x double> @insertelt_nxv8f64_idx(<vscale x 8 x double> %v, double %elt, i32 zeroext %idx) {
; CHECK-LABEL: insertelt_nxv8f64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v16, fa0
; CHECK-NEXT:    addi a1, a0, 1
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, tu, ma
; CHECK-NEXT:    vslideup.vx v8, v16, a0
; CHECK-NEXT:    ret
  %r = insertelement <vscale x 8 x double> %v, double %elt, i32 %idx
  ret <vscale x 8 x double> %r
}
