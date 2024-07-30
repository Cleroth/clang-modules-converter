; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

define <vscale x 1 x half> @select_nxv1f16(i1 zeroext %c, <vscale x 1 x half> %a, <vscale x 1 x half> %b) {
; CHECK-LABEL: select_nxv1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 1 x half> %a, <vscale x 1 x half> %b
  ret <vscale x 1 x half> %v
}

define <vscale x 1 x half> @selectcc_nxv1f16(half %a, half %b, <vscale x 1 x half> %c, <vscale x 1 x half> %d) {
; CHECK-LABEL: selectcc_nxv1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq half %a, %b
  %v = select i1 %cmp, <vscale x 1 x half> %c, <vscale x 1 x half> %d
  ret <vscale x 1 x half> %v
}

define <vscale x 2 x half> @select_nxv2f16(i1 zeroext %c, <vscale x 2 x half> %a, <vscale x 2 x half> %b) {
; CHECK-LABEL: select_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 2 x half> %a, <vscale x 2 x half> %b
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @selectcc_nxv2f16(half %a, half %b, <vscale x 2 x half> %c, <vscale x 2 x half> %d) {
; CHECK-LABEL: selectcc_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq half %a, %b
  %v = select i1 %cmp, <vscale x 2 x half> %c, <vscale x 2 x half> %d
  ret <vscale x 2 x half> %v
}

define <vscale x 4 x half> @select_nxv4f16(i1 zeroext %c, <vscale x 4 x half> %a, <vscale x 4 x half> %b) {
; CHECK-LABEL: select_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 4 x half> %a, <vscale x 4 x half> %b
  ret <vscale x 4 x half> %v
}

define <vscale x 4 x half> @selectcc_nxv4f16(half %a, half %b, <vscale x 4 x half> %c, <vscale x 4 x half> %d) {
; CHECK-LABEL: selectcc_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq half %a, %b
  %v = select i1 %cmp, <vscale x 4 x half> %c, <vscale x 4 x half> %d
  ret <vscale x 4 x half> %v
}

define <vscale x 8 x half> @select_nxv8f16(i1 zeroext %c, <vscale x 8 x half> %a, <vscale x 8 x half> %b) {
; CHECK-LABEL: select_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vmsne.vi v0, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 8 x half> %a, <vscale x 8 x half> %b
  ret <vscale x 8 x half> %v
}

define <vscale x 8 x half> @selectcc_nxv8f16(half %a, half %b, <vscale x 8 x half> %c, <vscale x 8 x half> %d) {
; CHECK-LABEL: selectcc_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vmsne.vi v0, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq half %a, %b
  %v = select i1 %cmp, <vscale x 8 x half> %c, <vscale x 8 x half> %d
  ret <vscale x 8 x half> %v
}

define <vscale x 16 x half> @select_nxv16f16(i1 zeroext %c, <vscale x 16 x half> %a, <vscale x 16 x half> %b) {
; CHECK-LABEL: select_nxv16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v16, a0
; CHECK-NEXT:    vmsne.vi v0, v16, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 16 x half> %a, <vscale x 16 x half> %b
  ret <vscale x 16 x half> %v
}

define <vscale x 16 x half> @selectcc_nxv16f16(half %a, half %b, <vscale x 16 x half> %c, <vscale x 16 x half> %d) {
; CHECK-LABEL: selectcc_nxv16f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v16, a0
; CHECK-NEXT:    vmsne.vi v0, v16, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq half %a, %b
  %v = select i1 %cmp, <vscale x 16 x half> %c, <vscale x 16 x half> %d
  ret <vscale x 16 x half> %v
}

define <vscale x 32 x half> @select_nxv32f16(i1 zeroext %c, <vscale x 32 x half> %a, <vscale x 32 x half> %b) {
; CHECK-LABEL: select_nxv32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m4, ta, ma
; CHECK-NEXT:    vmv.v.x v24, a0
; CHECK-NEXT:    vmsne.vi v0, v24, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 32 x half> %a, <vscale x 32 x half> %b
  ret <vscale x 32 x half> %v
}

define <vscale x 32 x half> @selectcc_nxv32f16(half %a, half %b, <vscale x 32 x half> %c, <vscale x 32 x half> %d) {
; CHECK-LABEL: selectcc_nxv32f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.h a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, m4, ta, ma
; CHECK-NEXT:    vmv.v.x v24, a0
; CHECK-NEXT:    vmsne.vi v0, v24, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq half %a, %b
  %v = select i1 %cmp, <vscale x 32 x half> %c, <vscale x 32 x half> %d
  ret <vscale x 32 x half> %v
}

define <vscale x 1 x float> @select_nxv1f32(i1 zeroext %c, <vscale x 1 x float> %a, <vscale x 1 x float> %b) {
; CHECK-LABEL: select_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 1 x float> %a, <vscale x 1 x float> %b
  ret <vscale x 1 x float> %v
}

define <vscale x 1 x float> @selectcc_nxv1f32(float %a, float %b, <vscale x 1 x float> %c, <vscale x 1 x float> %d) {
; CHECK-LABEL: selectcc_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.s a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq float %a, %b
  %v = select i1 %cmp, <vscale x 1 x float> %c, <vscale x 1 x float> %d
  ret <vscale x 1 x float> %v
}

define <vscale x 2 x float> @select_nxv2f32(i1 zeroext %c, <vscale x 2 x float> %a, <vscale x 2 x float> %b) {
; CHECK-LABEL: select_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 2 x float> %a, <vscale x 2 x float> %b
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @selectcc_nxv2f32(float %a, float %b, <vscale x 2 x float> %c, <vscale x 2 x float> %d) {
; CHECK-LABEL: selectcc_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.s a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq float %a, %b
  %v = select i1 %cmp, <vscale x 2 x float> %c, <vscale x 2 x float> %d
  ret <vscale x 2 x float> %v
}

define <vscale x 4 x float> @select_nxv4f32(i1 zeroext %c, <vscale x 4 x float> %a, <vscale x 4 x float> %b) {
; CHECK-LABEL: select_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vmsne.vi v0, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 4 x float> %a, <vscale x 4 x float> %b
  ret <vscale x 4 x float> %v
}

define <vscale x 4 x float> @selectcc_nxv4f32(float %a, float %b, <vscale x 4 x float> %c, <vscale x 4 x float> %d) {
; CHECK-LABEL: selectcc_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.s a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vmsne.vi v0, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq float %a, %b
  %v = select i1 %cmp, <vscale x 4 x float> %c, <vscale x 4 x float> %d
  ret <vscale x 4 x float> %v
}

define <vscale x 8 x float> @select_nxv8f32(i1 zeroext %c, <vscale x 8 x float> %a, <vscale x 8 x float> %b) {
; CHECK-LABEL: select_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v16, a0
; CHECK-NEXT:    vmsne.vi v0, v16, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 8 x float> %a, <vscale x 8 x float> %b
  ret <vscale x 8 x float> %v
}

define <vscale x 8 x float> @selectcc_nxv8f32(float %a, float %b, <vscale x 8 x float> %c, <vscale x 8 x float> %d) {
; CHECK-LABEL: selectcc_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.s a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v16, a0
; CHECK-NEXT:    vmsne.vi v0, v16, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq float %a, %b
  %v = select i1 %cmp, <vscale x 8 x float> %c, <vscale x 8 x float> %d
  ret <vscale x 8 x float> %v
}

define <vscale x 16 x float> @select_nxv16f32(i1 zeroext %c, <vscale x 16 x float> %a, <vscale x 16 x float> %b) {
; CHECK-LABEL: select_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v24, a0
; CHECK-NEXT:    vmsne.vi v0, v24, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 16 x float> %a, <vscale x 16 x float> %b
  ret <vscale x 16 x float> %v
}

define <vscale x 16 x float> @selectcc_nxv16f32(float %a, float %b, <vscale x 16 x float> %c, <vscale x 16 x float> %d) {
; CHECK-LABEL: selectcc_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.s a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, m2, ta, ma
; CHECK-NEXT:    vmv.v.x v24, a0
; CHECK-NEXT:    vmsne.vi v0, v24, 0
; CHECK-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq float %a, %b
  %v = select i1 %cmp, <vscale x 16 x float> %c, <vscale x 16 x float> %d
  ret <vscale x 16 x float> %v
}

define <vscale x 1 x double> @select_nxv1f64(i1 zeroext %c, <vscale x 1 x double> %a, <vscale x 1 x double> %b) {
; CHECK-LABEL: select_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 1 x double> %a, <vscale x 1 x double> %b
  ret <vscale x 1 x double> %v
}

define <vscale x 1 x double> @selectcc_nxv1f64(double %a, double %b, <vscale x 1 x double> %c, <vscale x 1 x double> %d) {
; CHECK-LABEL: selectcc_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.d a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq double %a, %b
  %v = select i1 %cmp, <vscale x 1 x double> %c, <vscale x 1 x double> %d
  ret <vscale x 1 x double> %v
}

define <vscale x 2 x double> @select_nxv2f64(i1 zeroext %c, <vscale x 2 x double> %a, <vscale x 2 x double> %b) {
; CHECK-LABEL: select_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vmsne.vi v0, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 2 x double> %a, <vscale x 2 x double> %b
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @selectcc_nxv2f64(double %a, double %b, <vscale x 2 x double> %c, <vscale x 2 x double> %d) {
; CHECK-LABEL: selectcc_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.d a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vmsne.vi v0, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e64, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq double %a, %b
  %v = select i1 %cmp, <vscale x 2 x double> %c, <vscale x 2 x double> %d
  ret <vscale x 2 x double> %v
}

define <vscale x 4 x double> @select_nxv4f64(i1 zeroext %c, <vscale x 4 x double> %a, <vscale x 4 x double> %b) {
; CHECK-LABEL: select_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v16, a0
; CHECK-NEXT:    vmsne.vi v0, v16, 0
; CHECK-NEXT:    vsetvli zero, zero, e64, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 4 x double> %a, <vscale x 4 x double> %b
  ret <vscale x 4 x double> %v
}

define <vscale x 4 x double> @selectcc_nxv4f64(double %a, double %b, <vscale x 4 x double> %c, <vscale x 4 x double> %d) {
; CHECK-LABEL: selectcc_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.d a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v16, a0
; CHECK-NEXT:    vmsne.vi v0, v16, 0
; CHECK-NEXT:    vsetvli zero, zero, e64, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq double %a, %b
  %v = select i1 %cmp, <vscale x 4 x double> %c, <vscale x 4 x double> %d
  ret <vscale x 4 x double> %v
}

define <vscale x 8 x double> @select_nxv8f64(i1 zeroext %c, <vscale x 8 x double> %a, <vscale x 8 x double> %b) {
; CHECK-LABEL: select_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v24, a0
; CHECK-NEXT:    vmsne.vi v0, v24, 0
; CHECK-NEXT:    vsetvli zero, zero, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <vscale x 8 x double> %a, <vscale x 8 x double> %b
  ret <vscale x 8 x double> %v
}

define <vscale x 8 x double> @selectcc_nxv8f64(double %a, double %b, <vscale x 8 x double> %c, <vscale x 8 x double> %d) {
; CHECK-LABEL: selectcc_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    feq.d a0, fa0, fa1
; CHECK-NEXT:    vsetvli a1, zero, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v24, a0
; CHECK-NEXT:    vmsne.vi v0, v24, 0
; CHECK-NEXT:    vsetvli zero, zero, e64, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq double %a, %b
  %v = select i1 %cmp, <vscale x 8 x double> %c, <vscale x 8 x double> %d
  ret <vscale x 8 x double> %v
}
