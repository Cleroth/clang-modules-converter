; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple aarch64-none-linux-gnu | FileCheck --check-prefix=CHECK-LE %s
; RUN: llc < %s -mtriple aarch64_be-none-linux-gnu | FileCheck --check-prefix=CHECK-BE %s

define <4 x i16> @test_combine_v4i16_v2i64(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LE-LABEL: test_combine_v4i16_v2i64:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    uzp1 v0.4s, v0.4s, v1.4s
; CHECK-LE-NEXT:    xtn v0.4h, v0.4s
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test_combine_v4i16_v2i64:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    xtn v0.2s, v0.2d
; CHECK-BE-NEXT:    xtn v1.2s, v1.2d
; CHECK-BE-NEXT:    rev32 v0.4h, v0.4h
; CHECK-BE-NEXT:    rev32 v1.4h, v1.4h
; CHECK-BE-NEXT:    uzp1 v0.4h, v0.4h, v1.4h
; CHECK-BE-NEXT:    rev64 v0.4h, v0.4h
; CHECK-BE-NEXT:    ret
  %a1 = trunc <2 x i64> %a to <2 x i32>
  %b1 = trunc <2 x i64> %b to <2 x i32>

  %a2 = bitcast <2 x i32> %a1 to <4 x i16>
  %b2 = bitcast <2 x i32> %b1 to <4 x i16>

  %ab = shufflevector <4 x i16> %a2, <4 x i16> %b2, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  ret <4 x i16> %ab
}

define <4 x i16> @test_combine_v4i16_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LE-LABEL: test_combine_v4i16_v4i32:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    uzp1 v0.8h, v0.8h, v1.8h
; CHECK-LE-NEXT:    xtn v0.4h, v0.4s
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test_combine_v4i16_v4i32:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    rev64 v1.4s, v1.4s
; CHECK-BE-NEXT:    rev64 v0.4s, v0.4s
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    xtn v0.4h, v0.4s
; CHECK-BE-NEXT:    xtn v1.4h, v1.4s
; CHECK-BE-NEXT:    uzp1 v0.4h, v0.4h, v1.4h
; CHECK-BE-NEXT:    rev64 v0.4h, v0.4h
; CHECK-BE-NEXT:    ret
  %a1 = trunc <4 x i32> %a to <4 x i16>
  %b1 = trunc <4 x i32> %b to <4 x i16>

  %ab = shufflevector <4 x i16> %a1, <4 x i16> %b1, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  ret <4 x i16> %ab
}

define <4 x i16> @test_combine_v4i16_v8i16(<8 x i16> %a, <8 x i16> %b) {
; CHECK-LE-LABEL: test_combine_v4i16_v8i16:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    uzp1 v0.16b, v0.16b, v1.16b
; CHECK-LE-NEXT:    xtn v0.4h, v0.4s
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test_combine_v4i16_v8i16:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    rev64 v1.8h, v1.8h
; CHECK-BE-NEXT:    rev64 v0.8h, v0.8h
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    xtn v0.8b, v0.8h
; CHECK-BE-NEXT:    xtn v1.8b, v1.8h
; CHECK-BE-NEXT:    rev16 v0.8b, v0.8b
; CHECK-BE-NEXT:    rev16 v1.8b, v1.8b
; CHECK-BE-NEXT:    uzp1 v0.4h, v0.4h, v1.4h
; CHECK-BE-NEXT:    rev64 v0.4h, v0.4h
; CHECK-BE-NEXT:    ret
  %a1 = trunc <8 x i16> %a to <8 x i8>
  %b1 = trunc <8 x i16> %b to <8 x i8>

  %a2 = bitcast <8 x i8> %a1 to <4 x i16>
  %b2 = bitcast <8 x i8> %b1 to <4 x i16>

  %ab = shufflevector <4 x i16> %a2, <4 x i16> %b2, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  ret <4 x i16> %ab
}


define <8 x i8> @test_combine_v8i8_v2i64(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LE-LABEL: test_combine_v8i8_v2i64:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    uzp1 v0.4s, v0.4s, v1.4s
; CHECK-LE-NEXT:    xtn v0.8b, v0.8h
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test_combine_v8i8_v2i64:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    xtn v0.2s, v0.2d
; CHECK-BE-NEXT:    xtn v1.2s, v1.2d
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    rev32 v1.8b, v1.8b
; CHECK-BE-NEXT:    uzp1 v0.8b, v0.8b, v1.8b
; CHECK-BE-NEXT:    rev64 v0.8b, v0.8b
; CHECK-BE-NEXT:    ret
  %a1 = trunc <2 x i64> %a to <2 x i32>
  %b1 = trunc <2 x i64> %b to <2 x i32>

  %a2 = bitcast <2 x i32> %a1 to <8 x i8>
  %b2 = bitcast <2 x i32> %b1 to <8 x i8>

  %ab = shufflevector <8 x i8> %a2, <8 x i8> %b2, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  ret <8 x i8> %ab
}

define <8 x i8> @test_combine_v8i8_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LE-LABEL: test_combine_v8i8_v4i32:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    uzp1 v0.8h, v0.8h, v1.8h
; CHECK-LE-NEXT:    xtn v0.8b, v0.8h
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test_combine_v8i8_v4i32:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    rev64 v1.4s, v1.4s
; CHECK-BE-NEXT:    rev64 v0.4s, v0.4s
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    xtn v0.4h, v0.4s
; CHECK-BE-NEXT:    xtn v1.4h, v1.4s
; CHECK-BE-NEXT:    rev16 v0.8b, v0.8b
; CHECK-BE-NEXT:    rev16 v1.8b, v1.8b
; CHECK-BE-NEXT:    uzp1 v0.8b, v0.8b, v1.8b
; CHECK-BE-NEXT:    rev64 v0.8b, v0.8b
; CHECK-BE-NEXT:    ret
  %a1 = trunc <4 x i32> %a to <4 x i16>
  %b1 = trunc <4 x i32> %b to <4 x i16>

  %a2 = bitcast <4 x i16> %a1 to <8 x i8>
  %b2 = bitcast <4 x i16> %b1 to <8 x i8>

  %ab = shufflevector <8 x i8> %a2, <8 x i8> %b2, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  ret <8 x i8> %ab
}

define <8 x i8> @test_combine_v8i8_v8i16(<8 x i16> %a, <8 x i16> %b) {
; CHECK-LE-LABEL: test_combine_v8i8_v8i16:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    uzp1 v0.16b, v0.16b, v1.16b
; CHECK-LE-NEXT:    xtn v0.8b, v0.8h
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test_combine_v8i8_v8i16:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    rev64 v1.8h, v1.8h
; CHECK-BE-NEXT:    rev64 v0.8h, v0.8h
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    xtn v0.8b, v0.8h
; CHECK-BE-NEXT:    xtn v1.8b, v1.8h
; CHECK-BE-NEXT:    uzp1 v0.8b, v0.8b, v1.8b
; CHECK-BE-NEXT:    rev64 v0.8b, v0.8b
; CHECK-BE-NEXT:    ret
  %a1 = trunc <8 x i16> %a to <8 x i8>
  %b1 = trunc <8 x i16> %b to <8 x i8>

  %ab = shufflevector <8 x i8> %a1, <8 x i8> %b1, <8 x i32> <i32 0, i32 2, i32 4, i32 6, i32 8, i32 10, i32 12, i32 14>
  ret <8 x i8> %ab
}

define <2 x i32> @test_combine_v2i32_v2i64(<2 x i64> %a, <2 x i64> %b) {
; CHECK-LE-LABEL: test_combine_v2i32_v2i64:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    xtn v0.2s, v0.2d
; CHECK-LE-NEXT:    xtn v1.2s, v1.2d
; CHECK-LE-NEXT:    zip1 v0.2s, v0.2s, v1.2s
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test_combine_v2i32_v2i64:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    xtn v0.2s, v0.2d
; CHECK-BE-NEXT:    xtn v1.2s, v1.2d
; CHECK-BE-NEXT:    zip1 v0.2s, v0.2s, v1.2s
; CHECK-BE-NEXT:    rev64 v0.2s, v0.2s
; CHECK-BE-NEXT:    ret
  %a1 = trunc <2 x i64> %a to <2 x i32>
  %b1 = trunc <2 x i64> %b to <2 x i32>

  %ab = shufflevector <2 x i32> %a1, <2 x i32> %b1, <2 x i32> <i32 0, i32 2>
  ret <2 x i32> %ab
}

define <2 x i32> @test_combine_v2i32_v4i32(<4 x i32> %a, <4 x i32> %b) {
; CHECK-LE-LABEL: test_combine_v2i32_v4i32:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    xtn v0.4h, v0.4s
; CHECK-LE-NEXT:    xtn v1.4h, v1.4s
; CHECK-LE-NEXT:    zip1 v0.2s, v0.2s, v1.2s
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test_combine_v2i32_v4i32:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    rev64 v1.4s, v1.4s
; CHECK-BE-NEXT:    rev64 v0.4s, v0.4s
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    xtn v0.4h, v0.4s
; CHECK-BE-NEXT:    xtn v1.4h, v1.4s
; CHECK-BE-NEXT:    rev32 v0.4h, v0.4h
; CHECK-BE-NEXT:    rev32 v1.4h, v1.4h
; CHECK-BE-NEXT:    zip1 v0.2s, v0.2s, v1.2s
; CHECK-BE-NEXT:    rev64 v0.2s, v0.2s
; CHECK-BE-NEXT:    ret
  %a1 = trunc <4 x i32> %a to <4 x i16>
  %b1 = trunc <4 x i32> %b to <4 x i16>

  %a2 = bitcast <4 x i16> %a1 to <2 x i32>
  %b2 = bitcast <4 x i16> %b1 to <2 x i32>

  %ab = shufflevector <2 x i32> %a2, <2 x i32> %b2, <2 x i32> <i32 0, i32 2>
  ret <2 x i32> %ab
}

define <2 x i32> @test_combine_v2i32_v8i16(<8 x i16> %a, <8 x i16> %b) {
; CHECK-LE-LABEL: test_combine_v2i32_v8i16:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    xtn v0.8b, v0.8h
; CHECK-LE-NEXT:    xtn v1.8b, v1.8h
; CHECK-LE-NEXT:    zip1 v0.2s, v0.2s, v1.2s
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: test_combine_v2i32_v8i16:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    rev64 v1.8h, v1.8h
; CHECK-BE-NEXT:    rev64 v0.8h, v0.8h
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    xtn v0.8b, v0.8h
; CHECK-BE-NEXT:    xtn v1.8b, v1.8h
; CHECK-BE-NEXT:    rev32 v0.8b, v0.8b
; CHECK-BE-NEXT:    rev32 v1.8b, v1.8b
; CHECK-BE-NEXT:    zip1 v0.2s, v0.2s, v1.2s
; CHECK-BE-NEXT:    rev64 v0.2s, v0.2s
; CHECK-BE-NEXT:    ret
  %a1 = trunc <8 x i16> %a to <8 x i8>
  %b1 = trunc <8 x i16> %b to <8 x i8>

  %a2 = bitcast <8 x i8> %a1 to <2 x i32>
  %b2 = bitcast <8 x i8> %b1 to <2 x i32>

  %ab = shufflevector <2 x i32> %a2, <2 x i32> %b2, <2 x i32> <i32 0, i32 2>
  ret <2 x i32> %ab
}

define i8 @trunc_v4i64_v4i8(<4 x i64> %input) {
; CHECK-LE-LABEL: trunc_v4i64_v4i8:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    uzp1 v0.4s, v0.4s, v1.4s
; CHECK-LE-NEXT:    xtn v0.4h, v0.4s
; CHECK-LE-NEXT:    addv h0, v0.4h
; CHECK-LE-NEXT:    fmov w0, s0
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: trunc_v4i64_v4i8:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    xtn v1.2s, v1.2d
; CHECK-BE-NEXT:    xtn v0.2s, v0.2d
; CHECK-BE-NEXT:    uzp1 v0.4h, v0.4h, v1.4h
; CHECK-BE-NEXT:    addv h0, v0.4h
; CHECK-BE-NEXT:    fmov w0, s0
; CHECK-BE-NEXT:    ret
  %var = trunc <4 x i64> %input to <4 x i8>
  ; llvm.vector.reduce.add.v4i8 is needed to reproduce the codegen (see `trunc_v4i64_v4i8_ret` below as a comparison)
  %res = call i8 @llvm.vector.reduce.add.v4i8(<4 x i8> %var)
  ret i8 %res
}

define <4 x i8> @trunc_v4i64_v4i8_ret(<4 x i64> %input) {
; CHECK-LE-LABEL: trunc_v4i64_v4i8_ret:
; CHECK-LE:       // %bb.0:
; CHECK-LE-NEXT:    uzp1 v0.4s, v0.4s, v1.4s
; CHECK-LE-NEXT:    xtn v0.4h, v0.4s
; CHECK-LE-NEXT:    ret
;
; CHECK-BE-LABEL: trunc_v4i64_v4i8_ret:
; CHECK-BE:       // %bb.0:
; CHECK-BE-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-BE-NEXT:    ext v0.16b, v0.16b, v0.16b, #8
; CHECK-BE-NEXT:    uzp1 v0.4s, v0.4s, v1.4s
; CHECK-BE-NEXT:    xtn v0.4h, v0.4s
; CHECK-BE-NEXT:    rev64 v0.4h, v0.4h
; CHECK-BE-NEXT:    ret
  %var = trunc <4 x i64> %input to <4 x i8>
  ret <4 x i8> %var
}

declare i8 @llvm.vector.reduce.add.v4i8(<4 x i8>)
