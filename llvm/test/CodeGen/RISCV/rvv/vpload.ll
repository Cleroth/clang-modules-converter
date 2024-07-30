; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

declare <vscale x 1 x i8> @llvm.vp.load.nxv1i8.p0(ptr, <vscale x 1 x i1>, i32)

define <vscale x 1 x i8> @vpload_nxv1i8(ptr %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x i8> @llvm.vp.load.nxv1i8.p0(ptr %ptr, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i8> %load
}

define <vscale x 1 x i8> @vpload_nxv1i8_allones_mask(ptr %ptr, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1i8_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x i8> @llvm.vp.load.nxv1i8.p0(ptr %ptr, <vscale x 1 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 1 x i8> %load
}

define <vscale x 1 x i8> @vpload_nxv1i8_passthru(ptr %ptr, <vscale x 1 x i1> %m, <vscale x 1 x i8> %passthru, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1i8_passthru:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf8, tu, mu
; CHECK-NEXT:    vle8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x i8> @llvm.vp.load.nxv1i8.p0(ptr %ptr, <vscale x 1 x i1> %m, i32 %evl)
  %merge = call <vscale x 1 x i8> @llvm.vp.merge.nxv1i8(<vscale x 1 x i1> %m, <vscale x 1 x i8> %load, <vscale x 1 x i8> %passthru, i32 %evl)
  ret <vscale x 1 x i8> %merge
}

declare <vscale x 2 x i8> @llvm.vp.load.nxv2i8.p0(ptr, <vscale x 2 x i1>, i32)

define <vscale x 2 x i8> @vpload_nxv2i8(ptr %ptr, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i8> @llvm.vp.load.nxv2i8.p0(ptr %ptr, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i8> %load
}

declare <vscale x 3 x i8> @llvm.vp.load.nxv3i8.p0(ptr, <vscale x 3 x i1>, i32)

define <vscale x 3 x i8> @vpload_nxv3i8(ptr %ptr, <vscale x 3 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv3i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 3 x i8> @llvm.vp.load.nxv3i8.p0(ptr %ptr, <vscale x 3 x i1> %m, i32 %evl)
  ret <vscale x 3 x i8> %load
}

declare <vscale x 4 x i8> @llvm.vp.load.nxv4i8.p0(ptr, <vscale x 4 x i1>, i32)

define <vscale x 4 x i8> @vpload_nxv4i8(ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i8> @llvm.vp.load.nxv4i8.p0(ptr %ptr, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i8> %load
}

declare <vscale x 8 x i8> @llvm.vp.load.nxv8i8.p0(ptr, <vscale x 8 x i1>, i32)

define <vscale x 8 x i8> @vpload_nxv8i8(ptr %ptr, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x i8> @llvm.vp.load.nxv8i8.p0(ptr %ptr, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i8> %load
}

define <vscale x 8 x i8> @vpload_nxv8i8_allones_mask(ptr %ptr, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv8i8_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x i8> @llvm.vp.load.nxv8i8.p0(ptr %ptr, <vscale x 8 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 8 x i8> %load
}

declare <vscale x 1 x i16> @llvm.vp.load.nxv1i16.p0(ptr, <vscale x 1 x i1>, i32)

define <vscale x 1 x i16> @vpload_nxv1i16(ptr %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x i16> @llvm.vp.load.nxv1i16.p0(ptr %ptr, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i16> %load
}

declare <vscale x 2 x i16> @llvm.vp.load.nxv2i16.p0(ptr, <vscale x 2 x i1>, i32)

define <vscale x 2 x i16> @vpload_nxv2i16(ptr %ptr, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i16> @llvm.vp.load.nxv2i16.p0(ptr %ptr, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i16> %load
}

define <vscale x 2 x i16> @vpload_nxv2i16_allones_mask(ptr %ptr, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv2i16_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i16> @llvm.vp.load.nxv2i16.p0(ptr %ptr, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x i16> %load
}

declare <vscale x 4 x i16> @llvm.vp.load.nxv4i16.p0(ptr, <vscale x 4 x i1>, i32)

define <vscale x 4 x i16> @vpload_nxv4i16(ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i16> @llvm.vp.load.nxv4i16.p0(ptr %ptr, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i16> %load
}

declare <vscale x 8 x i16> @llvm.vp.load.nxv8i16.p0(ptr, <vscale x 8 x i1>, i32)

define <vscale x 8 x i16> @vpload_nxv8i16(ptr %ptr, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x i16> @llvm.vp.load.nxv8i16.p0(ptr %ptr, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i16> %load
}

declare <vscale x 1 x i32> @llvm.vp.load.nxv1i32.p0(ptr, <vscale x 1 x i1>, i32)

define <vscale x 1 x i32> @vpload_nxv1i32(ptr %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x i32> @llvm.vp.load.nxv1i32.p0(ptr %ptr, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i32> %load
}

declare <vscale x 2 x i32> @llvm.vp.load.nxv2i32.p0(ptr, <vscale x 2 x i1>, i32)

define <vscale x 2 x i32> @vpload_nxv2i32(ptr %ptr, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i32> @llvm.vp.load.nxv2i32.p0(ptr %ptr, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i32> %load
}

declare <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr, <vscale x 4 x i1>, i32)

define <vscale x 4 x i32> @vpload_nxv4i32(ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr %ptr, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i32> %load
}

define <vscale x 4 x i32> @vpload_nxv4i32_allones_mask(ptr %ptr, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv4i32_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i32> @llvm.vp.load.nxv4i32.p0(ptr %ptr, <vscale x 4 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 4 x i32> %load
}

declare <vscale x 8 x i32> @llvm.vp.load.nxv8i32.p0(ptr, <vscale x 8 x i1>, i32)

define <vscale x 8 x i32> @vpload_nxv8i32(ptr %ptr, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x i32> @llvm.vp.load.nxv8i32.p0(ptr %ptr, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i32> %load
}

declare <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0(ptr, <vscale x 1 x i1>, i32)

define <vscale x 1 x i64> @vpload_nxv1i64(ptr %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0(ptr %ptr, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x i64> %load
}

define <vscale x 1 x i64> @vpload_nxv1i64_allones_mask(ptr %ptr, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1i64_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x i64> @llvm.vp.load.nxv1i64.p0(ptr %ptr, <vscale x 1 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 1 x i64> %load
}

declare <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr, <vscale x 2 x i1>, i32)

define <vscale x 2 x i64> @vpload_nxv2i64(ptr %ptr, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x i64> @llvm.vp.load.nxv2i64.p0(ptr %ptr, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x i64> %load
}

declare <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr, <vscale x 4 x i1>, i32)

define <vscale x 4 x i64> @vpload_nxv4i64(ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x i64> @llvm.vp.load.nxv4i64.p0(ptr %ptr, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x i64> %load
}

declare <vscale x 8 x i64> @llvm.vp.load.nxv8i64.p0(ptr, <vscale x 8 x i1>, i32)

define <vscale x 8 x i64> @vpload_nxv8i64(ptr %ptr, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x i64> @llvm.vp.load.nxv8i64.p0(ptr %ptr, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x i64> %load
}

declare <vscale x 1 x half> @llvm.vp.load.nxv1f16.p0(ptr, <vscale x 1 x i1>, i32)

define <vscale x 1 x half> @vpload_nxv1f16(ptr %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x half> @llvm.vp.load.nxv1f16.p0(ptr %ptr, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x half> %load
}

declare <vscale x 2 x half> @llvm.vp.load.nxv2f16.p0(ptr, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vpload_nxv2f16(ptr %ptr, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x half> @llvm.vp.load.nxv2f16.p0(ptr %ptr, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %load
}

define <vscale x 2 x half> @vpload_nxv2f16_allones_mask(ptr %ptr, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv2f16_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, mf2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x half> @llvm.vp.load.nxv2f16.p0(ptr %ptr, <vscale x 2 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 2 x half> %load
}

declare <vscale x 4 x half> @llvm.vp.load.nxv4f16.p0(ptr, <vscale x 4 x i1>, i32)

define <vscale x 4 x half> @vpload_nxv4f16(ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m1, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x half> @llvm.vp.load.nxv4f16.p0(ptr %ptr, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x half> %load
}

declare <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr, <vscale x 8 x i1>, i32)

define <vscale x 8 x half> @vpload_nxv8f16(ptr %ptr, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e16, m2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x half> @llvm.vp.load.nxv8f16.p0(ptr %ptr, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x half> %load
}

declare <vscale x 1 x float> @llvm.vp.load.nxv1f32.p0(ptr, <vscale x 1 x i1>, i32)

define <vscale x 1 x float> @vpload_nxv1f32(ptr %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x float> @llvm.vp.load.nxv1f32.p0(ptr %ptr, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x float> %load
}

declare <vscale x 2 x float> @llvm.vp.load.nxv2f32.p0(ptr, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vpload_nxv2f32(ptr %ptr, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x float> @llvm.vp.load.nxv2f32.p0(ptr %ptr, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %load
}

declare <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr, <vscale x 4 x i1>, i32)

define <vscale x 4 x float> @vpload_nxv4f32(ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x float> @llvm.vp.load.nxv4f32.p0(ptr %ptr, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x float> %load
}

declare <vscale x 8 x float> @llvm.vp.load.nxv8f32.p0(ptr, <vscale x 8 x i1>, i32)

define <vscale x 8 x float> @vpload_nxv8f32(ptr %ptr, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x float> @llvm.vp.load.nxv8f32.p0(ptr %ptr, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x float> %load
}

define <vscale x 8 x float> @vpload_nxv8f32_allones_mask(ptr %ptr, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv8f32_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e32, m4, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x float> @llvm.vp.load.nxv8f32.p0(ptr %ptr, <vscale x 8 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 8 x float> %load
}

declare <vscale x 1 x double> @llvm.vp.load.nxv1f64.p0(ptr, <vscale x 1 x i1>, i32)

define <vscale x 1 x double> @vpload_nxv1f64(ptr %ptr, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 1 x double> @llvm.vp.load.nxv1f64.p0(ptr %ptr, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x double> %load
}

declare <vscale x 2 x double> @llvm.vp.load.nxv2f64.p0(ptr, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vpload_nxv2f64(ptr %ptr, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 2 x double> @llvm.vp.load.nxv2f64.p0(ptr %ptr, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %load
}

declare <vscale x 4 x double> @llvm.vp.load.nxv4f64.p0(ptr, <vscale x 4 x i1>, i32)

define <vscale x 4 x double> @vpload_nxv4f64(ptr %ptr, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x double> @llvm.vp.load.nxv4f64.p0(ptr %ptr, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x double> %load
}

define <vscale x 4 x double> @vpload_nxv4f64_allones_mask(ptr %ptr, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv4f64_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m4, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    ret
  %load = call <vscale x 4 x double> @llvm.vp.load.nxv4f64.p0(ptr %ptr, <vscale x 4 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 4 x double> %load
}

declare <vscale x 8 x double> @llvm.vp.load.nxv8f64.p0(ptr, <vscale x 8 x i1>, i32)

define <vscale x 8 x double> @vpload_nxv8f64(ptr %ptr, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 8 x double> @llvm.vp.load.nxv8f64.p0(ptr %ptr, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x double> %load
}

declare <vscale x 16 x double> @llvm.vp.load.nxv16f64.p0(ptr, <vscale x 16 x i1>, i32)

define <vscale x 16 x double> @vpload_nxv16f64(ptr %ptr, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v8, v0
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    sub a3, a1, a2
; CHECK-NEXT:    sltu a4, a1, a3
; CHECK-NEXT:    addi a4, a4, -1
; CHECK-NEXT:    and a3, a4, a3
; CHECK-NEXT:    slli a4, a2, 3
; CHECK-NEXT:    srli a5, a2, 3
; CHECK-NEXT:    vsetvli a6, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a5
; CHECK-NEXT:    add a4, a0, a4
; CHECK-NEXT:    vsetvli zero, a3, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v16, (a4), v0.t
; CHECK-NEXT:    bltu a1, a2, .LBB38_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a1, a2
; CHECK-NEXT:  .LBB38_2:
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    ret
  %load = call <vscale x 16 x double> @llvm.vp.load.nxv16f64.p0(ptr %ptr, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x double> %load
}

declare <vscale x 17 x double> @llvm.vp.load.nxv17f64.p0(ptr, <vscale x 17 x i1>, i32)

declare <vscale x 1 x double> @llvm.vector.extract.nxv1f64(<vscale x 17 x double> %vec, i64 %idx)
declare <vscale x 16 x double> @llvm.vector.extract.nxv16f64(<vscale x 17 x double> %vec, i64 %idx)

; Note: We can't return <vscale x 17 x double> as that introduces a vector
; store can't yet be legalized through widening. In order to test purely the
; vp.load legalization, manually split it.

; Widen to nxv32f64 then split into 4 x nxv8f64, of which 1 is empty.

define <vscale x 16 x double> @vpload_nxv17f64(ptr %ptr, ptr %out, <vscale x 17 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpload_nxv17f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a3, vlenb
; CHECK-NEXT:    slli a5, a3, 1
; CHECK-NEXT:    vmv1r.v v8, v0
; CHECK-NEXT:    mv a4, a2
; CHECK-NEXT:    bltu a2, a5, .LBB39_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a4, a5
; CHECK-NEXT:  .LBB39_2:
; CHECK-NEXT:    sub a6, a4, a3
; CHECK-NEXT:    sltu a7, a4, a6
; CHECK-NEXT:    addi a7, a7, -1
; CHECK-NEXT:    and a6, a7, a6
; CHECK-NEXT:    slli a7, a3, 3
; CHECK-NEXT:    srli t0, a3, 3
; CHECK-NEXT:    vsetvli t1, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v8, t0
; CHECK-NEXT:    add a7, a0, a7
; CHECK-NEXT:    vsetvli zero, a6, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v16, (a7), v0.t
; CHECK-NEXT:    sub a5, a2, a5
; CHECK-NEXT:    sltu a2, a2, a5
; CHECK-NEXT:    addi a2, a2, -1
; CHECK-NEXT:    and a2, a2, a5
; CHECK-NEXT:    bltu a2, a3, .LBB39_4
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    mv a2, a3
; CHECK-NEXT:  .LBB39_4:
; CHECK-NEXT:    slli a5, a3, 4
; CHECK-NEXT:    srli a6, a3, 2
; CHECK-NEXT:    vsetvli a7, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v8, a6
; CHECK-NEXT:    add a5, a0, a5
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v24, (a5), v0.t
; CHECK-NEXT:    bltu a4, a3, .LBB39_6
; CHECK-NEXT:  # %bb.5:
; CHECK-NEXT:    mv a4, a3
; CHECK-NEXT:  .LBB39_6:
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vsetvli zero, a4, e64, m8, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0), v0.t
; CHECK-NEXT:    vs1r.v v24, (a1)
; CHECK-NEXT:    ret
  %load = call <vscale x 17 x double> @llvm.vp.load.nxv17f64.p0(ptr %ptr, <vscale x 17 x i1> %m, i32 %evl)
  %lo = call <vscale x 16 x double> @llvm.vector.extract.nxv16f64(<vscale x 17 x double> %load, i64 0)
  %hi = call <vscale x 1 x double> @llvm.vector.extract.nxv1f64(<vscale x 17 x double> %load, i64 16)
  store <vscale x 1 x double> %hi, ptr %out
  ret <vscale x 16 x double> %lo
}

define <vscale x 8 x i8> @vpload_all_active_nxv8i8(ptr %ptr) {
; CHECK-LABEL: vpload_all_active_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl1r.v v8, (a0)
; CHECK-NEXT:    ret
  %vscale = call i32 @llvm.vscale()
  %evl = mul i32 %vscale, 8
  %load = call <vscale x 8 x i8> @llvm.vp.load.nxv8i8.p0(ptr %ptr, <vscale x 8 x i1> splat (i1 true), i32 %evl)
  ret <vscale x 8 x i8> %load
}
