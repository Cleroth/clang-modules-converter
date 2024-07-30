; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s

; Test that the prepareSREMEqFold optimization doesn't crash on scalable
; vector types.
define <vscale x 4 x i1> @srem_eq_fold_nxv4i8(<vscale x 4 x i8> %va) {
; CHECK-LABEL: srem_eq_fold_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 42
; CHECK-NEXT:    vsetvli a1, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v9, a0
; CHECK-NEXT:    li a1, -85
; CHECK-NEXT:    vmacc.vx v9, a1, v8
; CHECK-NEXT:    vsll.vi v8, v9, 7
; CHECK-NEXT:    vsrl.vi v9, v9, 1
; CHECK-NEXT:    vor.vv v8, v9, v8
; CHECK-NEXT:    vmsleu.vx v0, v8, a0
; CHECK-NEXT:    ret
  %rem = srem <vscale x 4 x i8> %va, splat (i8 6)

  %cc = icmp eq <vscale x 4 x i8> %rem, zeroinitializer
  ret <vscale x 4 x i1> %cc
}

define <vscale x 1 x i32> @vmulh_vv_nxv1i32(<vscale x 1 x i32> %va, <vscale x 1 x i32> %vb) {
; CHECK-LABEL: vmulh_vv_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vmulh.vv v8, v9, v8
; CHECK-NEXT:    ret
  %vc = sext <vscale x 1 x i32> %vb to <vscale x 1 x i64>
  %vd = sext <vscale x 1 x i32> %va to <vscale x 1 x i64>
  %ve = mul <vscale x 1 x i64> %vc, %vd
  %vf = lshr <vscale x 1 x i64> %ve, splat (i64 32)
  %vg = trunc <vscale x 1 x i64> %vf to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %vg
}

define <vscale x 1 x i32> @vmulh_vx_nxv1i32(<vscale x 1 x i32> %va, i32 %x) {
; CHECK-LABEL: vmulh_vx_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head1 = insertelement <vscale x 1 x i32> poison, i32 %x, i32 0
  %splat1 = shufflevector <vscale x 1 x i32> %head1, <vscale x 1 x i32> poison, <vscale x 1 x i32> zeroinitializer
  %vb = sext <vscale x 1 x i32> %splat1 to <vscale x 1 x i64>
  %vc = sext <vscale x 1 x i32> %va to <vscale x 1 x i64>
  %vd = mul <vscale x 1 x i64> %vb, %vc
  %ve = lshr <vscale x 1 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 1 x i64> %ve to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %vf
}

define <vscale x 1 x i32> @vmulh_vi_nxv1i32_0(<vscale x 1 x i32> %va) {
; CHECK-LABEL: vmulh_vi_nxv1i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, -7
; CHECK-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %vb = sext <vscale x 1 x i32> splat (i32 -7) to <vscale x 1 x i64>
  %vc = sext <vscale x 1 x i32> %va to <vscale x 1 x i64>
  %vd = mul <vscale x 1 x i64> %vb, %vc
  %ve = lshr <vscale x 1 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 1 x i64> %ve to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %vf
}

define <vscale x 1 x i32> @vmulh_vi_nxv1i32_1(<vscale x 1 x i32> %va) {
; CHECK-LABEL: vmulh_vi_nxv1i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    vsetvli a1, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %vb = sext <vscale x 1 x i32> splat (i32 16) to <vscale x 1 x i64>
  %vc = sext <vscale x 1 x i32> %va to <vscale x 1 x i64>
  %vd = mul <vscale x 1 x i64> %vb, %vc
  %ve = lshr <vscale x 1 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 1 x i64> %ve to <vscale x 1 x i32>
  ret <vscale x 1 x i32> %vf
}

define <vscale x 2 x i32> @vmulh_vv_nxv2i32(<vscale x 2 x i32> %va, <vscale x 2 x i32> %vb) {
; CHECK-LABEL: vmulh_vv_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmulh.vv v8, v9, v8
; CHECK-NEXT:    ret
  %vc = sext <vscale x 2 x i32> %vb to <vscale x 2 x i64>
  %vd = sext <vscale x 2 x i32> %va to <vscale x 2 x i64>
  %ve = mul <vscale x 2 x i64> %vc, %vd
  %vf = lshr <vscale x 2 x i64> %ve, splat (i64 32)
  %vg = trunc <vscale x 2 x i64> %vf to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %vg
}

define <vscale x 2 x i32> @vmulh_vx_nxv2i32(<vscale x 2 x i32> %va, i32 %x) {
; CHECK-LABEL: vmulh_vx_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head1 = insertelement <vscale x 2 x i32> poison, i32 %x, i32 0
  %splat1 = shufflevector <vscale x 2 x i32> %head1, <vscale x 2 x i32> poison, <vscale x 2 x i32> zeroinitializer
  %vb = sext <vscale x 2 x i32> %splat1 to <vscale x 2 x i64>
  %vc = sext <vscale x 2 x i32> %va to <vscale x 2 x i64>
  %vd = mul <vscale x 2 x i64> %vb, %vc
  %ve = lshr <vscale x 2 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 2 x i64> %ve to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %vf
}

define <vscale x 2 x i32> @vmulh_vi_nxv2i32_0(<vscale x 2 x i32> %va) {
; CHECK-LABEL: vmulh_vi_nxv2i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, -7
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %vb = sext <vscale x 2 x i32> splat (i32 -7) to <vscale x 2 x i64>
  %vc = sext <vscale x 2 x i32> %va to <vscale x 2 x i64>
  %vd = mul <vscale x 2 x i64> %vb, %vc
  %ve = lshr <vscale x 2 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 2 x i64> %ve to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %vf
}

define <vscale x 2 x i32> @vmulh_vi_nxv2i32_1(<vscale x 2 x i32> %va) {
; CHECK-LABEL: vmulh_vi_nxv2i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    vsetvli a1, zero, e32, m1, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %vb = sext <vscale x 2 x i32> splat (i32 16) to <vscale x 2 x i64>
  %vc = sext <vscale x 2 x i32> %va to <vscale x 2 x i64>
  %vd = mul <vscale x 2 x i64> %vb, %vc
  %ve = lshr <vscale x 2 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 2 x i64> %ve to <vscale x 2 x i32>
  ret <vscale x 2 x i32> %vf
}

define <vscale x 4 x i32> @vmulh_vv_nxv4i32(<vscale x 4 x i32> %va, <vscale x 4 x i32> %vb) {
; CHECK-LABEL: vmulh_vv_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmulh.vv v8, v10, v8
; CHECK-NEXT:    ret
  %vc = sext <vscale x 4 x i32> %vb to <vscale x 4 x i64>
  %vd = sext <vscale x 4 x i32> %va to <vscale x 4 x i64>
  %ve = mul <vscale x 4 x i64> %vc, %vd
  %vf = lshr <vscale x 4 x i64> %ve, splat (i64 32)
  %vg = trunc <vscale x 4 x i64> %vf to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %vg
}

define <vscale x 4 x i32> @vmulh_vx_nxv4i32(<vscale x 4 x i32> %va, i32 %x) {
; CHECK-LABEL: vmulh_vx_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head1 = insertelement <vscale x 4 x i32> poison, i32 %x, i32 0
  %splat1 = shufflevector <vscale x 4 x i32> %head1, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %vb = sext <vscale x 4 x i32> %splat1 to <vscale x 4 x i64>
  %vc = sext <vscale x 4 x i32> %va to <vscale x 4 x i64>
  %vd = mul <vscale x 4 x i64> %vb, %vc
  %ve = lshr <vscale x 4 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 4 x i64> %ve to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %vf
}

define <vscale x 4 x i32> @vmulh_vi_nxv4i32_0(<vscale x 4 x i32> %va) {
; CHECK-LABEL: vmulh_vi_nxv4i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, -7
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %vb = sext <vscale x 4 x i32> splat (i32 -7) to <vscale x 4 x i64>
  %vc = sext <vscale x 4 x i32> %va to <vscale x 4 x i64>
  %vd = mul <vscale x 4 x i64> %vb, %vc
  %ve = lshr <vscale x 4 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 4 x i64> %ve to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %vf
}

define <vscale x 4 x i32> @vmulh_vi_nxv4i32_1(<vscale x 4 x i32> %va) {
; CHECK-LABEL: vmulh_vi_nxv4i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %vb = sext <vscale x 4 x i32> splat (i32 16) to <vscale x 4 x i64>
  %vc = sext <vscale x 4 x i32> %va to <vscale x 4 x i64>
  %vd = mul <vscale x 4 x i64> %vb, %vc
  %ve = lshr <vscale x 4 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 4 x i64> %ve to <vscale x 4 x i32>
  ret <vscale x 4 x i32> %vf
}

define <vscale x 8 x i32> @vmulh_vv_nxv8i32(<vscale x 8 x i32> %va, <vscale x 8 x i32> %vb) {
; CHECK-LABEL: vmulh_vv_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmulh.vv v8, v12, v8
; CHECK-NEXT:    ret
  %vc = sext <vscale x 8 x i32> %vb to <vscale x 8 x i64>
  %vd = sext <vscale x 8 x i32> %va to <vscale x 8 x i64>
  %ve = mul <vscale x 8 x i64> %vc, %vd
  %vf = lshr <vscale x 8 x i64> %ve, splat (i64 32)
  %vg = trunc <vscale x 8 x i64> %vf to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %vg
}

define <vscale x 8 x i32> @vmulh_vx_nxv8i32(<vscale x 8 x i32> %va, i32 %x) {
; CHECK-LABEL: vmulh_vx_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %head1 = insertelement <vscale x 8 x i32> poison, i32 %x, i32 0
  %splat1 = shufflevector <vscale x 8 x i32> %head1, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %vb = sext <vscale x 8 x i32> %splat1 to <vscale x 8 x i64>
  %vc = sext <vscale x 8 x i32> %va to <vscale x 8 x i64>
  %vd = mul <vscale x 8 x i64> %vb, %vc
  %ve = lshr <vscale x 8 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 8 x i64> %ve to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %vf
}

define <vscale x 8 x i32> @vmulh_vi_nxv8i32_0(<vscale x 8 x i32> %va) {
; CHECK-LABEL: vmulh_vi_nxv8i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, -7
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %vb = sext <vscale x 8 x i32> splat (i32 -7) to <vscale x 8 x i64>
  %vc = sext <vscale x 8 x i32> %va to <vscale x 8 x i64>
  %vd = mul <vscale x 8 x i64> %vb, %vc
  %ve = lshr <vscale x 8 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 8 x i64> %ve to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %vf
}

define <vscale x 8 x i32> @vmulh_vi_nxv8i32_1(<vscale x 8 x i32> %va) {
; CHECK-LABEL: vmulh_vi_nxv8i32_1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 16
; CHECK-NEXT:    vsetvli a1, zero, e32, m4, ta, ma
; CHECK-NEXT:    vmulh.vx v8, v8, a0
; CHECK-NEXT:    ret
  %vb = sext <vscale x 8 x i32> splat (i32 16) to <vscale x 8 x i64>
  %vc = sext <vscale x 8 x i32> %va to <vscale x 8 x i64>
  %vd = mul <vscale x 8 x i64> %vb, %vc
  %ve = lshr <vscale x 8 x i64> %vd, splat (i64 32)
  %vf = trunc <vscale x 8 x i64> %ve to <vscale x 8 x i32>
  ret <vscale x 8 x i32> %vf
}
