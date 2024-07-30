; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2 -force-streaming < %s | FileCheck %s

; lookup table expand one register

define {<vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>} @luti4_i16(<vscale x 16 x i8> %x) {
; CHECK-LABEL: luti4_i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    luti4 { z0.h - z3.h }, zt0, z0[1]
; CHECK-NEXT:    ret
    %res = call {<vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv8i16(i32 0, <vscale x 16 x i8> %x, i32 1)
    ret {<vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>} %res
}

define {<vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>} @luti4_i32(<vscale x 16 x i8> %x) {
; CHECK-LABEL: luti4_i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    luti4 { z0.s - z3.s }, zt0, z0[1]
; CHECK-NEXT:    ret
    %res = call {<vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv4i32(i32 0, <vscale x 16 x i8> %x, i32 1)
    ret {<vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>} %res
}

define {<vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>} @luti4_bf16(<vscale x 16 x i8> %x) {
; CHECK-LABEL: luti4_bf16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    luti4 { z0.h - z3.h }, zt0, z0[1]
; CHECK-NEXT:    ret
    %res = call {<vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv8bf16(i32 0, <vscale x 16 x i8> %x, i32 1)
    ret {<vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>} %res
}

define {<vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>} @luti4_f16(<vscale x 16 x i8> %x) {
; CHECK-LABEL: luti4_f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    luti4 { z0.h - z3.h }, zt0, z0[1]
; CHECK-NEXT:    ret
    %res = call {<vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv8f16(i32 0, <vscale x 16 x i8> %x, i32 1)
    ret {<vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>} %res
}

define {<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>} @luti4_f32(<vscale x 16 x i8> %x) {
; CHECK-LABEL: luti4_f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    luti4 { z0.s - z3.s }, zt0, z0[1]
; CHECK-NEXT:    ret
    %res = call {<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv4f32(i32 0, <vscale x 16 x i8> %x, i32 1)
    ret {<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>} %res
}

declare {<vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>, <vscale x 8 x i16>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv8i16(i32, <vscale x 16 x i8>, i32)
declare {<vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv4i32(i32, <vscale x 16 x i8>, i32)
declare {<vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv8bf16(i32, <vscale x 16 x i8>, i32)
declare {<vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv8f16(i32, <vscale x 16 x i8>, i32)
declare {<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>} @llvm.aarch64.sme.luti4.lane.zt.x4.nxv4f32(i32, <vscale x 16 x i8>, i32)
