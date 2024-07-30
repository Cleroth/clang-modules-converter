; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -aarch64-sve-vector-bits-min=256  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256
; RUN: llc -aarch64-sve-vector-bits-min=512  < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512
; RUN: llc -aarch64-sve-vector-bits-min=2048 < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512

target triple = "aarch64-unknown-linux-gnu"

; Don't use SVE for 64-bit vectors.
define <4 x half> @select_v4f16(<4 x half> %op1, <4 x half> %op2, <4 x i1> %mask) vscale_range(2,0) #0 {
; CHECK-LABEL: select_v4f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    shl v2.4h, v2.4h, #15
; CHECK-NEXT:    cmlt v2.4h, v2.4h, #0
; CHECK-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %sel = select <4 x i1> %mask, <4 x half> %op1, <4 x half> %op2
  ret <4 x half> %sel
}

; Don't use SVE for 128-bit vectors.
define <8 x half> @select_v8f16(<8 x half> %op1, <8 x half> %op2, <8 x i1> %mask) vscale_range(2,0) #0 {
; CHECK-LABEL: select_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v2.8h, v2.8b, #0
; CHECK-NEXT:    shl v2.8h, v2.8h, #15
; CHECK-NEXT:    cmlt v2.8h, v2.8h, #0
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %sel = select <8 x i1> %mask, <8 x half> %op1, <8 x half> %op2
  ret <8 x half> %sel
}

define void @select_v16f16(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: select_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x1]
; CHECK-NEXT:    fcmeq p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    sel z0.h, p1, z0.h, z1.h
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x half>, ptr %a
  %op2 = load <16 x half>, ptr %b
  %mask = fcmp oeq <16 x half> %op1, %op2
  %sel = select <16 x i1> %mask, <16 x half> %op1, <16 x half> %op2
  store <16 x half> %sel, ptr %a
  ret void
}

define void @select_v32f16(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: select_v32f16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.h, vl16
; VBITS_GE_256-NEXT:    mov x8, #16 // =0x10
; VBITS_GE_256-NEXT:    ld1h { z0.h }, p0/z, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z1.h }, p0/z, [x1, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z2.h }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ld1h { z3.h }, p0/z, [x1]
; VBITS_GE_256-NEXT:    fcmeq p1.h, p0/z, z0.h, z1.h
; VBITS_GE_256-NEXT:    fcmeq p2.h, p0/z, z2.h, z3.h
; VBITS_GE_256-NEXT:    sel z0.h, p1, z0.h, z1.h
; VBITS_GE_256-NEXT:    sel z1.h, p2, z2.h, z3.h
; VBITS_GE_256-NEXT:    st1h { z0.h }, p0, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z1.h }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: select_v32f16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.h, vl32
; VBITS_GE_512-NEXT:    ld1h { z0.h }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1h { z1.h }, p0/z, [x1]
; VBITS_GE_512-NEXT:    fcmeq p1.h, p0/z, z0.h, z1.h
; VBITS_GE_512-NEXT:    sel z0.h, p1, z0.h, z1.h
; VBITS_GE_512-NEXT:    st1h { z0.h }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <32 x half>, ptr %a
  %op2 = load <32 x half>, ptr %b
  %mask = fcmp oeq <32 x half> %op1, %op2
  %sel = select <32 x i1> %mask, <32 x half> %op1, <32 x half> %op2
  store <32 x half> %sel, ptr %a
  ret void
}

define void @select_v64f16(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: select_v64f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl64
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x1]
; CHECK-NEXT:    fcmeq p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    sel z0.h, p1, z0.h, z1.h
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <64 x half>, ptr %a
  %op2 = load <64 x half>, ptr %b
  %mask = fcmp oeq <64 x half> %op1, %op2
  %sel = select <64 x i1> %mask, <64 x half> %op1, <64 x half> %op2
  store <64 x half> %sel, ptr %a
  ret void
}

define void @select_v128f16(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: select_v128f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl128
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x1]
; CHECK-NEXT:    fcmeq p1.h, p0/z, z0.h, z1.h
; CHECK-NEXT:    sel z0.h, p1, z0.h, z1.h
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <128 x half>, ptr %a
  %op2 = load <128 x half>, ptr %b
  %mask = fcmp oeq <128 x half> %op1, %op2
  %sel = select <128 x i1> %mask, <128 x half> %op1, <128 x half> %op2
  store <128 x half> %sel, ptr %a
  ret void
}

; Don't use SVE for 64-bit vectors.
define <2 x float> @select_v2f32(<2 x float> %op1, <2 x float> %op2, <2 x i1> %mask) vscale_range(2,0) #0 {
; CHECK-LABEL: select_v2f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    shl v2.2s, v2.2s, #31
; CHECK-NEXT:    cmlt v2.2s, v2.2s, #0
; CHECK-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %sel = select <2 x i1> %mask, <2 x float> %op1, <2 x float> %op2
  ret <2 x float> %sel
}

; Don't use SVE for 128-bit vectors.
define <4 x float> @select_v4f32(<4 x float> %op1, <4 x float> %op2, <4 x i1> %mask) vscale_range(2,0) #0 {
; CHECK-LABEL: select_v4f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v2.4s, v2.4h, #0
; CHECK-NEXT:    shl v2.4s, v2.4s, #31
; CHECK-NEXT:    cmlt v2.4s, v2.4s, #0
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %sel = select <4 x i1> %mask, <4 x float> %op1, <4 x float> %op2
  ret <4 x float> %sel
}

define void @select_v8f32(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: select_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    fcmeq p1.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    sel z0.s, p1, z0.s, z1.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <8 x float>, ptr %a
  %op2 = load <8 x float>, ptr %b
  %mask = fcmp oeq <8 x float> %op1, %op2
  %sel = select <8 x i1> %mask, <8 x float> %op1, <8 x float> %op2
  store <8 x float> %sel, ptr %a
  ret void
}

define void @select_v16f32(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: select_v16f32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    mov x8, #8 // =0x8
; VBITS_GE_256-NEXT:    ld1w { z0.s }, p0/z, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z1.s }, p0/z, [x1, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z2.s }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ld1w { z3.s }, p0/z, [x1]
; VBITS_GE_256-NEXT:    fcmeq p1.s, p0/z, z0.s, z1.s
; VBITS_GE_256-NEXT:    fcmeq p2.s, p0/z, z2.s, z3.s
; VBITS_GE_256-NEXT:    sel z0.s, p1, z0.s, z1.s
; VBITS_GE_256-NEXT:    sel z1.s, p2, z2.s, z3.s
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z1.s }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: select_v16f32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.s, vl16
; VBITS_GE_512-NEXT:    ld1w { z0.s }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1w { z1.s }, p0/z, [x1]
; VBITS_GE_512-NEXT:    fcmeq p1.s, p0/z, z0.s, z1.s
; VBITS_GE_512-NEXT:    sel z0.s, p1, z0.s, z1.s
; VBITS_GE_512-NEXT:    st1w { z0.s }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <16 x float>, ptr %a
  %op2 = load <16 x float>, ptr %b
  %mask = fcmp oeq <16 x float> %op1, %op2
  %sel = select <16 x i1> %mask, <16 x float> %op1, <16 x float> %op2
  store <16 x float> %sel, ptr %a
  ret void
}

define void @select_v32f32(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: select_v32f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl32
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    fcmeq p1.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    sel z0.s, p1, z0.s, z1.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x float>, ptr %a
  %op2 = load <32 x float>, ptr %b
  %mask = fcmp oeq <32 x float> %op1, %op2
  %sel = select <32 x i1> %mask, <32 x float> %op1, <32 x float> %op2
  store <32 x float> %sel, ptr %a
  ret void
}

define void @select_v64f32(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: select_v64f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl64
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    fcmeq p1.s, p0/z, z0.s, z1.s
; CHECK-NEXT:    sel z0.s, p1, z0.s, z1.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <64 x float>, ptr %a
  %op2 = load <64 x float>, ptr %b
  %mask = fcmp oeq <64 x float> %op1, %op2
  %sel = select <64 x i1> %mask, <64 x float> %op1, <64 x float> %op2
  store <64 x float> %sel, ptr %a
  ret void
}

; Don't use SVE for 64-bit vectors.
define <1 x double> @select_v1f64(<1 x double> %op1, <1 x double> %op2, <1 x i1> %mask) vscale_range(2,0) #0 {
; CHECK-LABEL: select_v1f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0x1
; CHECK-NEXT:    csetm x8, ne
; CHECK-NEXT:    fmov d2, x8
; CHECK-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %sel = select <1 x i1> %mask, <1 x double> %op1, <1 x double> %op2
  ret <1 x double> %sel
}

; Don't use SVE for 128-bit vectors.
define <2 x double> @select_v2f64(<2 x double> %op1, <2 x double> %op2, <2 x i1> %mask) vscale_range(2,0) #0 {
; CHECK-LABEL: select_v2f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v2.2d, v2.2s, #0
; CHECK-NEXT:    shl v2.2d, v2.2d, #63
; CHECK-NEXT:    cmlt v2.2d, v2.2d, #0
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %sel = select <2 x i1> %mask, <2 x double> %op1, <2 x double> %op2
  ret <2 x double> %sel
}

define void @select_v4f64(ptr %a, ptr %b) vscale_range(2,0) #0 {
; CHECK-LABEL: select_v4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x1]
; CHECK-NEXT:    fcmeq p1.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    sel z0.d, p1, z0.d, z1.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <4 x double>, ptr %a
  %op2 = load <4 x double>, ptr %b
  %mask = fcmp oeq <4 x double> %op1, %op2
  %sel = select <4 x i1> %mask, <4 x double> %op1, <4 x double> %op2
  store <4 x double> %sel, ptr %a
  ret void
}

define void @select_v8f64(ptr %a, ptr %b) #0 {
; VBITS_GE_256-LABEL: select_v8f64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    mov x8, #4 // =0x4
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z2.d }, p0/z, [x0]
; VBITS_GE_256-NEXT:    ld1d { z3.d }, p0/z, [x1]
; VBITS_GE_256-NEXT:    fcmeq p1.d, p0/z, z0.d, z1.d
; VBITS_GE_256-NEXT:    fcmeq p2.d, p0/z, z2.d, z3.d
; VBITS_GE_256-NEXT:    sel z0.d, p1, z0.d, z1.d
; VBITS_GE_256-NEXT:    sel z1.d, p2, z2.d, z3.d
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z1.d }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: select_v8f64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1d { z1.d }, p0/z, [x1]
; VBITS_GE_512-NEXT:    fcmeq p1.d, p0/z, z0.d, z1.d
; VBITS_GE_512-NEXT:    sel z0.d, p1, z0.d, z1.d
; VBITS_GE_512-NEXT:    st1d { z0.d }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %op1 = load <8 x double>, ptr %a
  %op2 = load <8 x double>, ptr %b
  %mask = fcmp oeq <8 x double> %op1, %op2
  %sel = select <8 x i1> %mask, <8 x double> %op1, <8 x double> %op2
  store <8 x double> %sel, ptr %a
  ret void
}

define void @select_v16f64(ptr %a, ptr %b) vscale_range(8,0) #0 {
; CHECK-LABEL: select_v16f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x1]
; CHECK-NEXT:    fcmeq p1.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    sel z0.d, p1, z0.d, z1.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <16 x double>, ptr %a
  %op2 = load <16 x double>, ptr %b
  %mask = fcmp oeq <16 x double> %op1, %op2
  %sel = select <16 x i1> %mask, <16 x double> %op1, <16 x double> %op2
  store <16 x double> %sel, ptr %a
  ret void
}

define void @select_v32f64(ptr %a, ptr %b) vscale_range(16,0) #0 {
; CHECK-LABEL: select_v32f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x1]
; CHECK-NEXT:    fcmeq p1.d, p0/z, z0.d, z1.d
; CHECK-NEXT:    sel z0.d, p1, z0.d, z1.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %op1 = load <32 x double>, ptr %a
  %op2 = load <32 x double>, ptr %b
  %mask = fcmp oeq <32 x double> %op1, %op2
  %sel = select <32 x i1> %mask, <32 x double> %op1, <32 x double> %op2
  store <32 x double> %sel, ptr %a
  ret void
}

attributes #0 = { "target-features"="+sve" }
