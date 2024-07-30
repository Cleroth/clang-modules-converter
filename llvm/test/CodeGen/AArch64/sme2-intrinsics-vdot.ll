; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2,+sme-i16i64 -force-streaming -verify-machineinstrs < %s | FileCheck %s


; == FVDOT ==

define void @test_fvdot_lane_za32_vg1x2_nxv8f16(i32 %slice, <vscale x 8 x half> %zn1, <vscale x 8 x half> %zn2, <vscale x 8 x half> %zm) {
; CHECK-LABEL: test_fvdot_lane_za32_vg1x2_nxv8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    fvdot za.s[w8, 0, vgx2], { z0.h, z1.h }, z2.h[3]
; CHECK-NEXT:    fvdot za.s[w8, 7, vgx2], { z0.h, z1.h }, z2.h[3]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8f16(i32 %slice, <vscale x 8 x half> %zn1, <vscale x 8 x half> %zn2, <vscale x 8 x half> %zm, i32 3)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8f16(i32 %slice.7, <vscale x 8 x half> %zn1, <vscale x 8 x half> %zn2, <vscale x 8 x half> %zm, i32 3)
  ret void
}


; == BFVDOT ==

define void @test_fvdot_lane_za32_vg1x2_nxv8bf16(i32 %slice, <vscale x 8 x bfloat> %zn1, <vscale x 8 x bfloat> %zn2, <vscale x 8 x bfloat> %zm) {
; CHECK-LABEL: test_fvdot_lane_za32_vg1x2_nxv8bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    bfvdot za.s[w8, 0, vgx2], { z0.h, z1.h }, z2.h[3]
; CHECK-NEXT:    bfvdot za.s[w8, 7, vgx2], { z0.h, z1.h }, z2.h[3]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8bf16(i32 %slice, <vscale x 8 x bfloat> %zn1, <vscale x 8 x bfloat> %zn2, <vscale x 8 x bfloat> %zm, i32 3)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8bf16(i32 %slice.7, <vscale x 8 x bfloat> %zn1, <vscale x 8 x bfloat> %zn2, <vscale x 8 x bfloat> %zm, i32 3)
  ret void
}


; == SVDOT ==

define void @test_svdot_lane_za32_vg1x2_nxv8i16(i32 %slice, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zm) {
; CHECK-LABEL: test_svdot_lane_za32_vg1x2_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    svdot za.s[w8, 0, vgx2], { z0.h, z1.h }, z2.h[3]
; CHECK-NEXT:    svdot za.s[w8, 7, vgx2], { z0.h, z1.h }, z2.h[3]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.svdot.lane.za32.vg1x2.nxv8i16(i32 %slice, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zm, i32 3)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.svdot.lane.za32.vg1x2.nxv8i16(i32 %slice.7, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zm, i32 3)
  ret void
}

define void @test_svdot_lane_za32_vg1x4_nxv16i8(i32 %slice, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm) {
; CHECK-LABEL: test_svdot_lane_za32_vg1x4_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z3 killed $z3 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z2 killed $z2 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    svdot za.s[w8, 0, vgx4], { z0.b - z3.b }, z4.b[3]
; CHECK-NEXT:    svdot za.s[w8, 7, vgx4], { z0.b - z3.b }, z4.b[3]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.svdot.lane.za32.vg1x4.nxv16i8(i32 %slice, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm, i32 3)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.svdot.lane.za32.vg1x4.nxv16i8(i32 %slice.7, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm, i32 3)
  ret void
}

define void @test_svdot_lane_za64_vg1x4_nxv8i16(i32 %slice, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zn3, <vscale x 8 x i16> %zn4, <vscale x 8 x i16> %zm) {
; CHECK-LABEL: test_svdot_lane_za64_vg1x4_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z3 killed $z3 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z2 killed $z2 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    svdot za.d[w8, 0, vgx4], { z0.h - z3.h }, z4.h[1]
; CHECK-NEXT:    svdot za.d[w8, 7, vgx4], { z0.h - z3.h }, z4.h[1]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.svdot.lane.za64.vg1x4.nxv8i16(i32 %slice, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zn3, <vscale x 8 x i16> %zn4, <vscale x 8 x i16> %zm, i32 1)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.svdot.lane.za64.vg1x4.nxv8i16(i32 %slice.7, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zn3, <vscale x 8 x i16> %zn4, <vscale x 8 x i16> %zm, i32 1)
  ret void
}


; == UVDOT ==

define void @test_uvdot_lane_za32_vg1x2_nxv8i16(i32 %slice, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zm) {
; CHECK-LABEL: test_uvdot_lane_za32_vg1x2_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1 def $z0_z1
; CHECK-NEXT:    uvdot za.s[w8, 0, vgx2], { z0.h, z1.h }, z2.h[3]
; CHECK-NEXT:    uvdot za.s[w8, 7, vgx2], { z0.h, z1.h }, z2.h[3]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.uvdot.lane.za32.vg1x2.nxv8i16(i32 %slice, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zm, i32 3)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.uvdot.lane.za32.vg1x2.nxv8i16(i32 %slice.7, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zm, i32 3)
  ret void
}

define void @test_uvdot_lane_za32_vg1x4_nxv16i8(i32 %slice, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm) {
; CHECK-LABEL: test_uvdot_lane_za32_vg1x4_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z3 killed $z3 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z2 killed $z2 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    uvdot za.s[w8, 0, vgx4], { z0.b - z3.b }, z4.b[3]
; CHECK-NEXT:    uvdot za.s[w8, 7, vgx4], { z0.b - z3.b }, z4.b[3]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.uvdot.lane.za32.vg1x4.nxv16i8(i32 %slice, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm, i32 3)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.uvdot.lane.za32.vg1x4.nxv16i8(i32 %slice.7, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm, i32 3)
  ret void
}

define void @test_uvdot_lane_za64_vg1x4_nxv8i16(i32 %slice, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zn3, <vscale x 8 x i16> %zn4, <vscale x 8 x i16> %zm) {
; CHECK-LABEL: test_uvdot_lane_za64_vg1x4_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z3 killed $z3 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z2 killed $z2 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    uvdot za.d[w8, 0, vgx4], { z0.h - z3.h }, z4.h[1]
; CHECK-NEXT:    uvdot za.d[w8, 7, vgx4], { z0.h - z3.h }, z4.h[1]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.uvdot.lane.za64.vg1x4.nxv8i16(i32 %slice, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zn3, <vscale x 8 x i16> %zn4, <vscale x 8 x i16> %zm, i32 1)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.uvdot.lane.za64.vg1x4.nxv8i16(i32 %slice.7, <vscale x 8 x i16> %zn1, <vscale x 8 x i16> %zn2, <vscale x 8 x i16> %zn3, <vscale x 8 x i16> %zn4, <vscale x 8 x i16> %zm, i32 1)
  ret void
}


; == SUVDOT ==

define void @test_suvdot_lane_za32_vg1x4_nxv16i8(i32 %slice, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm) {
; CHECK-LABEL: test_suvdot_lane_za32_vg1x4_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z3 killed $z3 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z2 killed $z2 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    suvdot za.s[w8, 0, vgx4], { z0.b - z3.b }, z4.b[3]
; CHECK-NEXT:    suvdot za.s[w8, 7, vgx4], { z0.b - z3.b }, z4.b[3]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.suvdot.lane.za32.vg1x4.nxv16i8(i32 %slice, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm, i32 3)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.suvdot.lane.za32.vg1x4.nxv16i8(i32 %slice.7, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm, i32 3)
  ret void
}


; == USVDOT ==

define void @test_usvdot_lane_za32_vg1x4_nxv16i8(i32 %slice, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm) {
; CHECK-LABEL: test_usvdot_lane_za32_vg1x4_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $z3 killed $z3 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    // kill: def $z2 killed $z2 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z1 killed $z1 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    // kill: def $z0 killed $z0 killed $z0_z1_z2_z3 def $z0_z1_z2_z3
; CHECK-NEXT:    usvdot za.s[w8, 0, vgx4], { z0.b - z3.b }, z4.b[3]
; CHECK-NEXT:    usvdot za.s[w8, 7, vgx4], { z0.b - z3.b }, z4.b[3]
; CHECK-NEXT:    ret
  call void @llvm.aarch64.sme.usvdot.lane.za32.vg1x4.nxv16i8(i32 %slice, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm, i32 3)
  %slice.7 = add i32 %slice, 7
  call void @llvm.aarch64.sme.usvdot.lane.za32.vg1x4.nxv16i8(i32 %slice.7, <vscale x 16 x i8> %zn1, <vscale x 16 x i8> %zn2, <vscale x 16 x i8> %zn3, <vscale x 16 x i8> %zn4, <vscale x 16 x i8> %zm, i32 3)
  ret void
}


; == FVDOT ==
declare void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8f16(i32, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, i32)
declare void @llvm.aarch64.sme.fvdot.lane.za32.vg1x2.nxv8bf16(i32, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, i32)

; == SVDOT ==
declare void @llvm.aarch64.sme.svdot.lane.za32.vg1x2.nxv8i16(i32, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, i32)
declare void @llvm.aarch64.sme.svdot.lane.za32.vg1x4.nxv16i8(i32, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i32)
declare void @llvm.aarch64.sme.svdot.lane.za64.vg1x4.nxv8i16(i32, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, i32)

; == UVDOT ==
declare void @llvm.aarch64.sme.uvdot.lane.za32.vg1x2.nxv8i16(i32, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, i32)
declare void @llvm.aarch64.sme.uvdot.lane.za32.vg1x4.nxv16i8(i32, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i32)
declare void @llvm.aarch64.sme.uvdot.lane.za64.vg1x4.nxv8i16(i32, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, i32)

; == SUVDOT ==
declare void @llvm.aarch64.sme.suvdot.lane.za32.vg1x4.nxv16i8(i32, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i32)

; == USVDOT ==
declare void @llvm.aarch64.sme.usvdot.lane.za32.vg1x4.nxv16i8(i32, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, <vscale x 16 x i8>, i32)
