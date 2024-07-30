; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -aarch64-sve-vector-bits-min=256 < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_256
; RUN: llc -aarch64-sve-vector-bits-min=512 < %s | FileCheck %s -check-prefixes=CHECK,VBITS_GE_512

target triple = "aarch64-unknown-linux-gnu"

; REVB pattern for shuffle v32i8 -> v16i16
define void @test_revbv16i16(ptr %a) #0 {
; CHECK-LABEL: test_revbv16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl32
; CHECK-NEXT:    ptrue p1.h
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    revb z0.h, p1/m, z0.h
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <32 x i8>, ptr %a
  %tmp2 = shufflevector <32 x i8> %tmp1, <32 x i8> undef, <32 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14, i32 17, i32 16, i32 19, i32 18, i32 21, i32 20, i32 23, i32 22, i32 undef, i32 24, i32 27, i32 undef, i32 29, i32 28, i32 undef, i32 undef>
  store <32 x i8> %tmp2, ptr %a
  ret void
}

; REVB pattern for shuffle v32i8 -> v8i32
define void @test_revbv8i32(ptr %a) #0 {
; CHECK-LABEL: test_revbv8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl32
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    revb z0.s, p1/m, z0.s
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <32 x i8>, ptr %a
  %tmp2 = shufflevector <32 x i8> %tmp1, <32 x i8> undef, <32 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12, i32 19, i32 18, i32 17, i32 16, i32 23, i32 22, i32 21, i32 20, i32 27, i32 undef, i32 undef, i32 undef, i32 31, i32 30, i32 29, i32 undef>
  store <32 x i8> %tmp2, ptr %a
  ret void
}

; REVB pattern for shuffle v32i8 -> v4i64
define void @test_revbv4i64(ptr %a) #0 {
; CHECK-LABEL: test_revbv4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b, vl32
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    revb z0.d, p1/m, z0.d
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <32 x i8>, ptr %a
  %tmp2 = shufflevector <32 x i8> %tmp1, <32 x i8> undef, <32 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 31, i32 30, i32 29, i32 undef, i32 27, i32 undef, i32 undef, i32 undef>
  store <32 x i8> %tmp2, ptr %a
  ret void
}

; REVH pattern for shuffle v16i16 -> v8i32
define void @test_revhv8i32(ptr %a) #0 {
; CHECK-LABEL: test_revhv8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    revh z0.s, p1/m, z0.s
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <16 x i16>, ptr %a
  %tmp2 = shufflevector <16 x i16> %tmp1, <16 x i16> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  store <16 x i16> %tmp2, ptr %a
  ret void
}

; REVH pattern for shuffle v16f16 -> v8f32
define void @test_revhv8f32(ptr %a) #0 {
; CHECK-LABEL: test_revhv8f32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    ptrue p1.s
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    revh z0.s, p1/m, z0.s
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <16 x half>, ptr %a
  %tmp2 = shufflevector <16 x half> %tmp1, <16 x half> undef, <16 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6, i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  store <16 x half> %tmp2, ptr %a
  ret void
}

; REVH pattern for shuffle v16i16 -> v4i64
define void @test_revhv4i64(ptr %a) #0 {
; CHECK-LABEL: test_revhv4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h, vl16
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    revh z0.d, p1/m, z0.d
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <16 x i16>, ptr %a
  %tmp2 = shufflevector <16 x i16> %tmp1, <16 x i16> undef, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  store <16 x i16> %tmp2, ptr %a
  ret void
}

; REVW pattern for shuffle v8i32 -> v4i64
define void @test_revwv4i64(ptr %a) #0 {
; CHECK-LABEL: test_revwv4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    revw z0.d, p1/m, z0.d
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i32>, ptr %a
  %tmp2 = shufflevector <8 x i32> %tmp1, <8 x i32> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  store <8 x i32> %tmp2, ptr %a
  ret void
}

; REVW pattern for shuffle v8f32 -> v4f64
define void @test_revwv4f64(ptr %a) #0 {
; CHECK-LABEL: test_revwv4f64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    revw z0.d, p1/m, z0.d
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <8 x float>, ptr %a
  %tmp2 = shufflevector <8 x float> %tmp1, <8 x float> undef, <8 x i32> <i32 1, i32 0, i32 3, i32 2, i32 5, i32 4, i32 7, i32 6>
  store <8 x float> %tmp2, ptr %a
  ret void
}

; Don't use SVE for 128-bit vectors
define <16 x i8> @test_revv16i8(ptr %a) #0 {
; CHECK-LABEL: test_revv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    rev64 v0.16b, v0.16b
; CHECK-NEXT:    ret
  %tmp1 = load <16 x i8>, ptr %a
  %tmp2 = shufflevector <16 x i8> %tmp1, <16 x i8> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
  ret <16 x i8> %tmp2
}

; REVW pattern for shuffle two v8i32 inputs with the second input available.
define void @test_revwv8i32v8i32(ptr %a, ptr %b) #0 {
; CHECK-LABEL: test_revwv8i32v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x1]
; CHECK-NEXT:    revw z0.d, p1/m, z0.d
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i32>, ptr %a
  %tmp2 = load <8 x i32>, ptr %b
  %tmp3 = shufflevector <8 x i32> %tmp1, <8 x i32> %tmp2, <8 x i32> <i32 9, i32 8, i32 11, i32 10, i32 13, i32 12, i32 15, i32 14>
  store <8 x i32> %tmp3, ptr %a
  ret void
}

; REVH pattern for shuffle v32i16 with 256 bits and 512 bits SVE.
define void @test_revhv32i16(ptr %a) #0 {
; VBITS_GE_256-LABEL: test_revhv32i16:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.h, vl16
; VBITS_GE_256-NEXT:    mov x8, #16 // =0x10
; VBITS_GE_256-NEXT:    ptrue p1.d
; VBITS_GE_256-NEXT:    ld1h { z0.h }, p0/z, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    ld1h { z1.h }, p0/z, [x0]
; VBITS_GE_256-NEXT:    revh z0.d, p1/m, z0.d
; VBITS_GE_256-NEXT:    revh z1.d, p1/m, z1.d
; VBITS_GE_256-NEXT:    st1h { z0.h }, p0, [x0, x8, lsl #1]
; VBITS_GE_256-NEXT:    st1h { z1.h }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: test_revhv32i16:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.h, vl32
; VBITS_GE_512-NEXT:    ptrue p1.d
; VBITS_GE_512-NEXT:    ld1h { z0.h }, p0/z, [x0]
; VBITS_GE_512-NEXT:    revh z0.d, p1/m, z0.d
; VBITS_GE_512-NEXT:    st1h { z0.h }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %tmp1 = load <32 x i16>, ptr %a
  %tmp2 = shufflevector <32 x i16> %tmp1, <32 x i16> undef, <32 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12, i32 19, i32 18, i32 17, i32 16, i32 23, i32 22, i32 21, i32 20, i32 27, i32 undef, i32 undef, i32 undef, i32 31, i32 30, i32 29, i32 undef>
  store <32 x i16> %tmp2, ptr %a
  ret void
}

; Only support to reverse bytes / halfwords / words within elements
define void @test_rev_elts_fail(ptr %a) #1 {
; CHECK-LABEL: test_rev_elts_fail:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    adrp x8, .LCPI11_0
; CHECK-NEXT:    add x8, x8, :lo12:.LCPI11_0
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x8]
; CHECK-NEXT:    tbl z0.d, { z0.d }, z1.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i64>, ptr %a
  %tmp2 = shufflevector <4 x i64> %tmp1, <4 x i64> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  store <4 x i64> %tmp2, ptr %a
  ret void
}

; This is the same test as above, but with sve2p1 it can use the REVD instruction to reverse
; the double-words within quard-words.
define void @test_revdv4i64_sve2p1(ptr %a) #2 {
; CHECK-LABEL: test_revdv4i64_sve2p1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    revd z0.q, p0/m, z0.q
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <4 x i64>, ptr %a
  %tmp2 = shufflevector <4 x i64> %tmp1, <4 x i64> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  store <4 x i64> %tmp2, ptr %a
  ret void
}

define void @test_revdv4f64_sve2p1(ptr %a) #2 {
; CHECK-LABEL: test_revdv4f64_sve2p1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d, vl4
; CHECK-NEXT:    ptrue p1.d
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    revd z0.q, p1/m, z0.q
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <4 x double>, ptr %a
  %tmp2 = shufflevector <4 x double> %tmp1, <4 x double> undef, <4 x i32> <i32 1, i32 0, i32 3, i32 2>
  store <4 x double> %tmp2, ptr %a
  ret void
}

; REV instruction will reverse the order of all elements in the vector.
; When the vector length and the target register size are inconsistent,
; the correctness of generated REV instruction for shuffle pattern cannot be guaranteed.

; sve-vector-bits-min=256, sve-vector-bits-max is not set, REV inst can't be generated.
define void @test_revv8i32(ptr %a) #0 {
; VBITS_GE_256-LABEL: test_revv8i32:
; VBITS_GE_256:       // %bb.0:
; VBITS_GE_256-NEXT:    ptrue p0.s, vl8
; VBITS_GE_256-NEXT:    index z0.s, #7, #-1
; VBITS_GE_256-NEXT:    ld1w { z1.s }, p0/z, [x0]
; VBITS_GE_256-NEXT:    tbl z0.s, { z1.s }, z0.s
; VBITS_GE_256-NEXT:    st1w { z0.s }, p0, [x0]
; VBITS_GE_256-NEXT:    ret
;
; VBITS_GE_512-LABEL: test_revv8i32:
; VBITS_GE_512:       // %bb.0:
; VBITS_GE_512-NEXT:    ptrue p0.s, vl8
; VBITS_GE_512-NEXT:    adrp x8, .LCPI14_0
; VBITS_GE_512-NEXT:    add x8, x8, :lo12:.LCPI14_0
; VBITS_GE_512-NEXT:    ptrue p1.s, vl16
; VBITS_GE_512-NEXT:    ld1w { z0.s }, p0/z, [x0]
; VBITS_GE_512-NEXT:    ld1w { z1.s }, p1/z, [x8]
; VBITS_GE_512-NEXT:    tbl z0.s, { z0.s }, z1.s
; VBITS_GE_512-NEXT:    st1w { z0.s }, p0, [x0]
; VBITS_GE_512-NEXT:    ret
  %tmp1 = load <8 x i32>, ptr %a
  %tmp2 = shufflevector <8 x i32> %tmp1, <8 x i32> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  store <8 x i32> %tmp2, ptr %a
  ret void
}

; REV pattern for v32i8 shuffle with vscale_range(2,2)
define void @test_revv32i8_vl256(ptr %a) #1 {
; CHECK-LABEL: test_revv32i8_vl256:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    rev z0.b, z0.b
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <32 x i8>, ptr %a
  %tmp2 = shufflevector <32 x i8> %tmp1, <32 x i8> undef, <32 x i32> <i32 31, i32 30, i32 29, i32 28, i32 27, i32 26, i32 25, i32 24, i32 23, i32 22, i32 21, i32 20, i32 19, i32 18, i32 17, i32 16, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  store <32 x i8> %tmp2, ptr %a
  ret void
}

; REV pattern for v16i16 shuffle with vscale_range(2,2)
define void @test_revv16i16_vl256(ptr %a) #1 {
; CHECK-LABEL: test_revv16i16_vl256:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    rev z0.h, z0.h
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <16 x i16>, ptr %a
  %tmp2 = shufflevector <16 x i16> %tmp1, <16 x i16> undef, <16 x i32> <i32 undef, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8, i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  store <16 x i16> %tmp2, ptr %a
  ret void
}

; REV pattern for v8f32 shuffle with vscale_range(2,2)
define void @test_revv8f32_vl256(ptr %a) #1 {
; CHECK-LABEL: test_revv8f32_vl256:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    rev z0.s, z0.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <8 x float>, ptr %a
  %tmp2 = shufflevector <8 x float> %tmp1, <8 x float> undef, <8 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0>
  store <8 x float> %tmp2, ptr %a
  ret void
}

; REV pattern for v4f64 shuffle with vscale_range(2,2)
define void @test_revv4f64_vl256(ptr %a) #1 {
; CHECK-LABEL: test_revv4f64_vl256:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    rev z0.d, z0.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <4 x double>, ptr %a
  %tmp2 = shufflevector <4 x double> %tmp1, <4 x double> undef, <4 x i32> <i32 3, i32 2, i32 1, i32 0>
  store <4 x double> %tmp2, ptr %a
  ret void
}

; REV pattern for shuffle two v8i32 inputs with the second input available, vscale_range(2,2).
define void @test_revv8i32v8i32(ptr %a, ptr %b) #1 {
; CHECK-LABEL: test_revv8i32v8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x1]
; CHECK-NEXT:    rev z0.s, z0.s
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i32>, ptr %a
  %tmp2 = load <8 x i32>, ptr %b
  %tmp3 = shufflevector <8 x i32> %tmp1, <8 x i32> %tmp2, <8 x i32> <i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
  store <8 x i32> %tmp3, ptr %a
  ret void
}

; Illegal REV pattern.
define void @test_rev_fail(ptr %a) #1 {
; CHECK-LABEL: test_rev_fail:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    adrp x8, .LCPI20_0
; CHECK-NEXT:    add x8, x8, :lo12:.LCPI20_0
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x8]
; CHECK-NEXT:    tbl z0.h, { z0.h }, z1.h
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    ret
  %tmp1 = load <16 x i16>, ptr %a
  %tmp2 = shufflevector <16 x i16> %tmp1, <16 x i16> undef, <16 x i32> <i32 7, i32 6, i32 5, i32 4, i32 3, i32 2, i32 1, i32 0, i32 15, i32 14, i32 13, i32 12, i32 11, i32 10, i32 9, i32 8>
  store <16 x i16> %tmp2, ptr %a
  ret void
}

; Don't use SVE for 128-bit shuffle with two inputs
define void @test_revv8i16v8i16(ptr %a, ptr %b, ptr %c) #1 {
; CHECK-LABEL: test_revv8i16v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; CHECK-NEXT:    sub x9, sp, #48
; CHECK-NEXT:    mov x29, sp
; CHECK-NEXT:    and sp, x9, #0xffffffffffffffe0
; CHECK-NEXT:    .cfi_def_cfa w29, 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    ldr q0, [x1]
; CHECK-NEXT:    ldr q1, [x0]
; CHECK-NEXT:    orr x9, x8, #0x1e
; CHECK-NEXT:    orr x10, x8, #0x1c
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    st1 { v0.h }[4], [x9]
; CHECK-NEXT:    orr x9, x8, #0x18
; CHECK-NEXT:    st1 { v0.h }[7], [x9]
; CHECK-NEXT:    orr x9, x8, #0xe
; CHECK-NEXT:    st1 { v1.h }[4], [x9]
; CHECK-NEXT:    orr x9, x8, #0xc
; CHECK-NEXT:    st1 { v1.h }[5], [x9]
; CHECK-NEXT:    orr x9, x8, #0x8
; CHECK-NEXT:    st1 { v0.h }[5], [x10]
; CHECK-NEXT:    orr x10, x8, #0x10
; CHECK-NEXT:    st1 { v1.h }[7], [x9]
; CHECK-NEXT:    orr x9, x8, #0x4
; CHECK-NEXT:    st1 { v0.h }[3], [x10]
; CHECK-NEXT:    mov w10, #26 // =0x1a
; CHECK-NEXT:    st1 { v1.h }[1], [x9]
; CHECK-NEXT:    orr x9, x8, #0x2
; CHECK-NEXT:    st1 { v1.h }[2], [x9]
; CHECK-NEXT:    orr x9, x8, x10
; CHECK-NEXT:    mov w10, #20 // =0x14
; CHECK-NEXT:    st1 { v0.h }[6], [x9]
; CHECK-NEXT:    orr x9, x8, x10
; CHECK-NEXT:    mov w10, #18 // =0x12
; CHECK-NEXT:    st1 { v0.h }[1], [x9]
; CHECK-NEXT:    orr x9, x8, x10
; CHECK-NEXT:    st1 { v0.h }[2], [x9]
; CHECK-NEXT:    mov w9, #10 // =0xa
; CHECK-NEXT:    orr x9, x8, x9
; CHECK-NEXT:    st1 { v1.h }[3], [x8]
; CHECK-NEXT:    st1 { v1.h }[6], [x9]
; CHECK-NEXT:    str h0, [sp, #22]
; CHECK-NEXT:    str h1, [sp, #6]
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x8]
; CHECK-NEXT:    st1h { z0.h }, p0, [x2]
; CHECK-NEXT:    mov sp, x29
; CHECK-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; CHECK-NEXT:    ret
  %tmp1 = load <8 x i16>, ptr %a
  %tmp2 = load <8 x i16>, ptr %b
  %tmp3 = shufflevector <8 x i16> %tmp1, <8 x i16> %tmp2, <16 x i32> <i32 3, i32 2, i32 1, i32 0, i32 7, i32 6, i32 5, i32 4, i32 11, i32 10, i32 9, i32 8, i32 15, i32 14, i32 13, i32 12>
  store <16 x i16> %tmp3, ptr %c
  ret void
}

attributes #0 = { "target-features"="+sve" }
attributes #1 = { "target-features"="+sve" vscale_range(2,2) }
attributes #2 = { "target-features"="+sve2p1" }
