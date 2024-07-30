; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -aarch64-sve-vector-bits-min=256  -aarch64-enable-atomic-cfg-tidy=false < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256
; RUN: llc -aarch64-sve-vector-bits-min=512  -aarch64-enable-atomic-cfg-tidy=false < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512
; RUN: llc -aarch64-sve-vector-bits-min=2048 -aarch64-enable-atomic-cfg-tidy=false < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512

; Test we can code generater patterns of the form:
;   fixed_length_vector = ISD::EXTRACT_SUBVECTOR scalable_vector, 0
;   scalable_vector = ISD::INSERT_SUBVECTOR scalable_vector, fixed_length_vector, 0
;
; NOTE: Currently shufflevector does not support scalable vectors so it cannot
; be used to model the above operations.  Instead these tests rely on knowing
; how fixed length operation are lowered to scalable ones, with multiple blocks
; ensuring insert/extract sequences are not folded away.

target triple = "aarch64-unknown-linux-gnu"

define void @subvector_v8i16(ptr %in, ptr %out) vscale_range(2,0) #0 {
; CHECK-LABEL: subvector_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    str q0, [x1]
; CHECK-NEXT:    ret
  %a = load <8 x i16>, ptr %in
  br label %bb1

bb1:
  store <8 x i16> %a, ptr %out
  ret void
}

define void @subvector_v16i16(ptr %in, ptr %out) vscale_range(2,0) #0 {
; CHECK-LABEL: subvector_v16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    st1h { z0.h }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <16 x i16>, ptr %in
  br label %bb1

bb1:
  store <16 x i16> %a, ptr %out
  ret void
}

define void @subvector_v32i16(ptr %in, ptr %out) #0 {
; VBITS_GE_256-LABEL: subvector_v32i16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.h, vl16
; VBITS_GE_256-NEXT:    mov x8, #16 // =0x10
; VBITS_GE_256-NEXT:    ld1h { z0.h }, p0/z, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z1.h }, p0/z, [x0]
; VBITS_GE_256-NEXT:    st1h { z0.h }, p0, [x1, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z1.h }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: subvector_v32i16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.h, vl32
; VBITS_GE_512-NEXT:    ld1h { z0.h }, p0/z, [x0]
; VBITS_GE_512-NEXT:    st1h { z0.h }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %a = load <32 x i16>, ptr %in
  br label %bb1

bb1:
  store <32 x i16> %a, ptr %out
  ret void
}

define void @subvector_v64i16(ptr %in, ptr %out) vscale_range(8,0) #0 {
; CHECK-LABEL: subvector_v64i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl64
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    st1h { z0.h }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <64 x i16>, ptr %in
  br label %bb1

bb1:
  store <64 x i16> %a, ptr %out
  ret void
}

define void @subvector_v8i32(ptr %in, ptr %out) vscale_range(2,0) #0 {
; CHECK-LABEL: subvector_v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <8 x i32>, ptr %in
  br label %bb1

bb1:
  store <8 x i32> %a, ptr %out
  ret void
}

define void @subvector_v16i32(ptr %in, ptr %out) #0 {
; VBITS_GE_256-LABEL: subvector_v16i32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    mov x8, #8 // =0x8
; VBITS_GE_256-NEXT:    ld1w { z0.s }, p0/z, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z1.s }, p0/z, [x0]
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x1, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z1.s }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: subvector_v16i32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.s, vl16
; VBITS_GE_512-NEXT:    ld1w { z0.s }, p0/z, [x0]
; VBITS_GE_512-NEXT:    st1w { z0.s }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %a = load <16 x i32>, ptr %in
  br label %bb1

bb1:
  store <16 x i32> %a, ptr %out
  ret void
}

define void @subvector_v32i32(ptr %in, ptr %out) vscale_range(8,0) #0 {
; CHECK-LABEL: subvector_v32i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl32
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <32 x i32>, ptr %in
  br label %bb1

bb1:
  store <32 x i32> %a, ptr %out
  ret void
}

define void @subvector_v64i32(ptr %in, ptr %out) vscale_range(16,0) #0 {
; CHECK-LABEL: subvector_v64i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl64
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <64 x i32>, ptr %in
  br label %bb1

bb1:
  store <64 x i32> %a, ptr %out
  ret void
}


define void @subvector_v8i64(ptr %in, ptr %out) vscale_range(2,0) #0 {
; CHECK-LABEL: subvector_v8i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    mov x8, #4 // =0x4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0, x8, lsl #3]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x0]
; CHECK-NEXT:    st1d { z0.d }, p0, [x1, x8, lsl #3]
; CHECK-NEXT:    st1d { z1.d }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <8 x i64>, ptr %in
  br label %bb1

bb1:
  store <8 x i64> %a, ptr %out
  ret void
}

define void @subvector_v16i64(ptr %in, ptr %out) vscale_range(8,0) #0 {
; CHECK-LABEL: subvector_v16i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <16 x i64>, ptr %in
  br label %bb1

bb1:
  store <16 x i64> %a, ptr %out
  ret void
}

define void @subvector_v32i64(ptr %in, ptr %out) vscale_range(16,0) #0 {
; CHECK-LABEL: subvector_v32i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <32 x i64>, ptr %in
  br label %bb1

bb1:
  store <32 x i64> %a, ptr %out
  ret void
}

define void @subvector_v8f16(ptr %in, ptr %out) vscale_range(2,0) #0 {
; CHECK-LABEL: subvector_v8f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    str q0, [x1]
; CHECK-NEXT:    ret
  %a = load <8 x half>, ptr %in
  br label %bb1

bb1:
  store <8 x half> %a, ptr %out
  ret void
}

define void @subvector_v16f16(ptr %in, ptr %out) vscale_range(2,0) #0 {
; CHECK-LABEL: subvector_v16f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    st1h { z0.h }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <16 x half>, ptr %in
  br label %bb1

bb1:
  store <16 x half> %a, ptr %out
  ret void
}

define void @subvector_v32f16(ptr %in, ptr %out) #0 {
; VBITS_GE_256-LABEL: subvector_v32f16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.h, vl16
; VBITS_GE_256-NEXT:    mov x8, #16 // =0x10
; VBITS_GE_256-NEXT:    ld1h { z0.h }, p0/z, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z1.h }, p0/z, [x0]
; VBITS_GE_256-NEXT:    st1h { z0.h }, p0, [x1, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z1.h }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: subvector_v32f16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.h, vl32
; VBITS_GE_512-NEXT:    ld1h { z0.h }, p0/z, [x0]
; VBITS_GE_512-NEXT:    st1h { z0.h }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %a = load <32 x half>, ptr %in
  br label %bb1

bb1:
  store <32 x half> %a, ptr %out
  ret void
}

define void @subvector_v64f16(ptr %in, ptr %out) vscale_range(8,0) #0 {
; CHECK-LABEL: subvector_v64f16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl64
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    st1h { z0.h }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <64 x half>, ptr %in
  br label %bb1

bb1:
  store <64 x half> %a, ptr %out
  ret void
}

define void @subvector_v8f32(ptr %in, ptr %out) vscale_range(2,0) #0 {
; CHECK-LABEL: subvector_v8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %in
  br label %bb1

bb1:
  store <8 x float> %a, ptr %out
  ret void
}

define void @subvector_v16f32(ptr %in, ptr %out) #0 {
; VBITS_GE_256-LABEL: subvector_v16f32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    mov x8, #8 // =0x8
; VBITS_GE_256-NEXT:    ld1w { z0.s }, p0/z, [x0, x8, lsl #2]
; VBITS_GE_256-NEXT:    ld1w { z1.s }, p0/z, [x0]
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x1, x8, lsl #2]
; VBITS_GE_256-NEXT:    st1w { z1.s }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: subvector_v16f32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.s, vl16
; VBITS_GE_512-NEXT:    ld1w { z0.s }, p0/z, [x0]
; VBITS_GE_512-NEXT:    st1w { z0.s }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %a = load <16 x float>, ptr %in
  br label %bb1

bb1:
  store <16 x float> %a, ptr %out
  ret void
}

define void @subvector_v32f32(ptr %in, ptr %out) vscale_range(8,0) #0 {
; CHECK-LABEL: subvector_v32f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl32
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <32 x float>, ptr %in
  br label %bb1

bb1:
  store <32 x float> %a, ptr %out
  ret void
}

define void @subvector_v64f32(ptr %in, ptr %out) vscale_range(16,0) #0 {
; CHECK-LABEL: subvector_v64f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl64
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <64 x float>, ptr %in
  br label %bb1

bb1:
  store <64 x float> %a, ptr %out
  ret void
}
define void @subvector_v8f64(ptr %in, ptr %out) #0 {
; VBITS_GE_256-LABEL: subvector_v8f64:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.d, vl4
; VBITS_GE_256-NEXT:    mov x8, #4 // =0x4
; VBITS_GE_256-NEXT:    ld1d { z0.d }, p0/z, [x0, x8, lsl #3]
; VBITS_GE_256-NEXT:    ld1d { z1.d }, p0/z, [x0]
; VBITS_GE_256-NEXT:    st1d { z0.d }, p0, [x1, x8, lsl #3]
; VBITS_GE_256-NEXT:    st1d { z1.d }, p0, [x1]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: subvector_v8f64:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.d, vl8
; VBITS_GE_512-NEXT:    ld1d { z0.d }, p0/z, [x0]
; VBITS_GE_512-NEXT:    st1d { z0.d }, p0, [x1]
; VBITS_GE_512-NEXT:    ret
  %a = load <8 x double>, ptr %in
  br label %bb1

bb1:
  store <8 x double> %a, ptr %out
  ret void
}

define void @subvector_v16f64(ptr %in, ptr %out) vscale_range(8,0) #0 {
; CHECK-LABEL: subvector_v16f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl16
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <16 x double>, ptr %in
  br label %bb1

bb1:
  store <16 x double> %a, ptr %out
  ret void
}

define void @subvector_v32f64(ptr %in, ptr %out) vscale_range(16,0) #0 {
; CHECK-LABEL: subvector_v32f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl32
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    st1d { z0.d }, p0, [x1]
; CHECK-NEXT:    ret
  %a = load <32 x double>, ptr %in
  br label %bb1

bb1:
  store <32 x double> %a, ptr %out
  ret void
}

define <8 x i1> @no_warn_dropped_scalable(ptr %in) #0 {
; CHECK-LABEL: no_warn_dropped_scalable:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    cmpgt p0.s, p0/z, z0.s, #0
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $z0
; CHECK-NEXT:    ret
  %a = load <8 x i32>, ptr %in
  br label %bb1

bb1:
  %cond = icmp sgt <8 x i32> %a, zeroinitializer
  ret <8 x i1> %cond
}

; binop(insert_subvec(a), insert_subvec(b)) -> insert_subvec(binop(a,b)) like
; combines remove redundant subvector operations. This test ensures it's not
; performed when the input idiom is the result of operation legalisation. When
; not prevented the test triggers infinite combine->legalise->combine->...
define void @no_subvector_binop_hang(ptr %in, ptr %out, i1 %cond) #0 {
; CHECK-LABEL: no_subvector_binop_hang:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tbz w2, #0, .LBB23_2
; CHECK-NEXT:  // %bb.1: // %bb.1
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    orr z0.d, z0.d, z1.d
; CHECK-NEXT:    st1w { z0.s }, p0, [x1]
; CHECK-NEXT:  .LBB23_2: // %bb.2
; CHECK-NEXT:    ret
  %a = load <8 x i32>, ptr %in
  %b = load <8 x i32>, ptr %out
  br i1 %cond, label %bb.1, label %bb.2

bb.1:
  %or = or <8 x i32> %a, %b
  store <8 x i32> %or, ptr %out
  br label %bb.2

bb.2:
  ret void
}

attributes #0 = { "target-features"="+sve" }
