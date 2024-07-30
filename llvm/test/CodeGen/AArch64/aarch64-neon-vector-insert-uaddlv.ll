; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=arm64-apple-ios -o - %s | FileCheck %s

declare i32 @llvm.aarch64.neon.uaddlv.i32.v8i8(<8 x i8>) #0
declare i32 @llvm.aarch64.neon.uaddlv.i32.v16i8(<16 x i8>) #0
declare i32 @llvm.aarch64.neon.uaddlv.i32.v4i16(<4 x i16>) #0
declare i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16>) #0
declare i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32>) #0

define void @insert_vec_v2i32_uaddlv_from_v8i16(ptr %0) {
; CHECK-LABEL: insert_vec_v2i32_uaddlv_from_v8i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v1, #0000000000000000
; CHECK-NEXT:    uaddlv.8h s0, v0
; CHECK-NEXT:    mov.s v1[0], v0[0]
; CHECK-NEXT:    ucvtf.2s v0, v1
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16> zeroinitializer)
  %1 = insertelement <2 x i32> zeroinitializer, i32 %vaddlv, i64 0
  %2 = uitofp <2 x i32> %1 to <2 x float>
  store <2 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v4i32_uaddlv_from_v8i16(ptr %0) {
; CHECK-LABEL: insert_vec_v4i32_uaddlv_from_v8i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    uaddlv.8h s1, v0
; CHECK-NEXT:    mov.s v0[0], v1[0]
; CHECK-NEXT:    ucvtf.4s v0, v0
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16> zeroinitializer)
  %1 = insertelement <4 x i32> zeroinitializer, i32 %vaddlv, i64 0
  %2 = uitofp <4 x i32> %1 to <4 x float>
  store <4 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v16i32_uaddlv_from_v8i16(ptr %0) {
; CHECK-LABEL: insert_vec_v16i32_uaddlv_from_v8i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v2, #0000000000000000
; CHECK-NEXT:    uaddlv.8h s1, v0
; CHECK-NEXT:    stp q0, q0, [x0, #32]
; CHECK-NEXT:    mov.s v2[0], v1[0]
; CHECK-NEXT:    ucvtf.4s v1, v2
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16> zeroinitializer)
  %1 = insertelement <16 x i32> zeroinitializer, i32 %vaddlv, i64 0
  %2 = uitofp <16 x i32> %1 to <16 x float>
  store <16 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v23i32_uaddlv_from_v8i16(ptr %0) {
; CHECK-LABEL: insert_vec_v23i32_uaddlv_from_v8i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v2, #0000000000000000
; CHECK-NEXT:    str wzr, [x0, #88]
; CHECK-NEXT:    uaddlv.8h s1, v0
; CHECK-NEXT:    stp q0, q0, [x0, #16]
; CHECK-NEXT:    stp q0, q0, [x0, #48]
; CHECK-NEXT:    str d0, [x0, #80]
; CHECK-NEXT:    mov.s v2[0], v1[0]
; CHECK-NEXT:    ucvtf.4s v1, v2
; CHECK-NEXT:    str q1, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16> zeroinitializer)
  %1 = insertelement <23 x i32> zeroinitializer, i32 %vaddlv, i64 0
  %2 = uitofp <23 x i32> %1 to <23 x float>
  store <23 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v2i32_uaddlv_from_v16i8(ptr %0) {
; CHECK-LABEL: insert_vec_v2i32_uaddlv_from_v16i8:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v1, #0000000000000000
; CHECK-NEXT:    uaddlv.16b h0, v0
; CHECK-NEXT:    mov.s v1[0], v0[0]
; CHECK-NEXT:    ucvtf.2s v0, v1
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v16i8(<16 x i8> zeroinitializer)
  %1 = insertelement <2 x i32> zeroinitializer, i32 %vaddlv, i64 0
  %2 = uitofp <2 x i32> %1 to <2 x float>
  store <2 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v2i32_uaddlv_from_v8i8(ptr %0) {
; CHECK-LABEL: insert_vec_v2i32_uaddlv_from_v8i8:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    uaddlv.8b h1, v0
; CHECK-NEXT:    mov.s v0[0], v1[0]
; CHECK-NEXT:    ucvtf.2s v0, v0
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i8(<8 x i8> zeroinitializer)
  %1 = insertelement <2 x i32> zeroinitializer, i32 %vaddlv, i64 0
  %2 = uitofp <2 x i32> %1 to <2 x float>
  store <2 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v2i32_uaddlv_from_v4i16(ptr %0) {
; CHECK-LABEL: insert_vec_v2i32_uaddlv_from_v4i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    uaddlv.4h s1, v0
; CHECK-NEXT:    mov.s v0[0], v1[0]
; CHECK-NEXT:    ucvtf.2s v0, v0
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v4i16(<4 x i16> zeroinitializer)
  %1 = insertelement <2 x i32> zeroinitializer, i32 %vaddlv, i64 0
  %2 = uitofp <2 x i32> %1 to <2 x float>
  store <2 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v6i64_uaddlv_from_v4i32(ptr %0) {
; CHECK-LABEL: insert_vec_v6i64_uaddlv_from_v4i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v2, #0000000000000000
; CHECK-NEXT:    uaddlv.4s d1, v0
; CHECK-NEXT:    str d2, [x0, #16]
; CHECK-NEXT:    mov.d v0[0], v1[0]
; CHECK-NEXT:    ucvtf.2d v0, v0
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> zeroinitializer)
  %1 = insertelement <6 x i64> zeroinitializer, i64 %vaddlv, i64 0
  %2 = uitofp <6 x i64> %1 to <6 x float>
  store <6 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v2i64_uaddlv_from_v4i32(ptr %0) {
; CHECK-LABEL: insert_vec_v2i64_uaddlv_from_v4i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    uaddlv.4s d1, v0
; CHECK-NEXT:    mov.d v0[0], v1[0]
; CHECK-NEXT:    ucvtf.2d v0, v0
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> zeroinitializer)
  %1 = insertelement <2 x i64> zeroinitializer, i64 %vaddlv, i64 0
  %2 = uitofp <2 x i64> %1 to <2 x float>
  store <2 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v5i64_uaddlv_from_v4i32(ptr %0) {
; CHECK-LABEL: insert_vec_v5i64_uaddlv_from_v4i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    str wzr, [x0, #16]
; CHECK-NEXT:    uaddlv.4s d1, v0
; CHECK-NEXT:    mov.d v0[0], v1[0]
; CHECK-NEXT:    ucvtf.2d v0, v0
; CHECK-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> zeroinitializer)
  %1 = insertelement <5 x i64> zeroinitializer, i64 %vaddlv, i64 0
  %2 = uitofp <5 x i64> %1 to <5 x float>
  store <5 x float> %2, ptr %0, align 8
  ret void
}

define void @insert_vec_v8i16_uaddlv_from_v8i16(ptr %0) {
; CHECK-LABEL: insert_vec_v8i16_uaddlv_from_v8i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v1, #0000000000000000
; CHECK-NEXT:    stp xzr, xzr, [x0, #16]
; CHECK-NEXT:    uaddlv.8h s0, v0
; CHECK-NEXT:    mov.h v1[0], v0[0]
; CHECK-NEXT:    ushll.4s v1, v1, #0
; CHECK-NEXT:    ucvtf.4s v1, v1
; CHECK-NEXT:    str q1, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16> zeroinitializer)
  %1 = trunc i32 %vaddlv to i16
  %2 = insertelement <8 x i16> zeroinitializer, i16 %1, i64 0
  %3 = uitofp <8 x i16> %2 to <8 x float>
  store <8 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v3i16_uaddlv_from_v8i16(ptr %0) {
; CHECK-LABEL: insert_vec_v3i16_uaddlv_from_v8i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v1, #0000000000000000
; CHECK-NEXT:    add x8, x0, #8
; CHECK-NEXT:    uaddlv.8h s0, v0
; CHECK-NEXT:    mov.h v1[0], v0[0]
; CHECK-NEXT:    ushll.4s v1, v1, #0
; CHECK-NEXT:    ucvtf.4s v1, v1
; CHECK-NEXT:    st1.s { v1 }[2], [x8]
; CHECK-NEXT:    str d1, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16> zeroinitializer)
  %1 = trunc i32 %vaddlv to i16
  %2 = insertelement <3 x i16> zeroinitializer, i16 %1, i64 0
  %3 = uitofp <3 x i16> %2 to <3 x float>
  store <3 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v16i64_uaddlv_from_v4i16(ptr %0) {
; CHECK-LABEL: insert_vec_v16i64_uaddlv_from_v4i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v2, #0000000000000000
; CHECK-NEXT:    uaddlv.4h s1, v0
; CHECK-NEXT:    stp q0, q0, [x0, #32]
; CHECK-NEXT:    mov.s v2[0], v1[0]
; CHECK-NEXT:    ucvtf.2d v1, v2
; CHECK-NEXT:    fcvtn v1.2s, v1.2d
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v4i16(<4 x i16> zeroinitializer)
  %1 = zext i32 %vaddlv to i64
  %2 = insertelement <16 x i64> zeroinitializer, i64 %1, i64 0
  %3 = uitofp <16 x i64> %2 to <16 x float>
  store <16 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v16i8_uaddlv_from_v8i8(ptr %0) {
; CHECK-LABEL: insert_vec_v16i8_uaddlv_from_v8i8:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v2, #0000000000000000
; CHECK-NEXT:    uaddlv.8b h1, v0
; CHECK-NEXT:    stp q0, q0, [x0, #32]
; CHECK-NEXT:    mov.h v2[0], v1[0]
; CHECK-NEXT:    bic.4h v2, #255, lsl #8
; CHECK-NEXT:    ushll.4s v2, v2, #0
; CHECK-NEXT:    ucvtf.4s v2, v2
; CHECK-NEXT:    stp q2, q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i8(<8 x i8> zeroinitializer)
  %1 = trunc i32 %vaddlv to i8
  %2 = insertelement <16 x i8> zeroinitializer, i8 %1, i64 0
  %3 = uitofp <16 x i8> %2 to <16 x float>
  store <16 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v8i8_uaddlv_from_v8i8(ptr %0) {
; CHECK-LABEL: insert_vec_v8i8_uaddlv_from_v8i8:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    stp xzr, xzr, [x0, #16]
; CHECK-NEXT:    uaddlv.8b h1, v0
; CHECK-NEXT:    mov.h v0[0], v1[0]
; CHECK-NEXT:    bic.4h v0, #7, lsl #8
; CHECK-NEXT:    ushll.4s v0, v0, #0
; CHECK-NEXT:    ucvtf.4s v0, v0
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i8(<8 x i8> zeroinitializer)
  %1 = trunc i32 %vaddlv to i8
  %2 = insertelement <8 x i8> zeroinitializer, i8 %1, i64 0
  %3 = uitofp <8 x i8> %2 to <8 x float>
  store <8 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v12i16_uaddlv_from_v4i16(ptr %0) {
; CHECK-LABEL: insert_vec_v12i16_uaddlv_from_v4i16:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    stp xzr, xzr, [x0, #16]
; CHECK-NEXT:    stp xzr, xzr, [x0, #32]
; CHECK-NEXT:    uaddlv.4h s1, v0
; CHECK-NEXT:    mov.h v0[0], v1[0]
; CHECK-NEXT:    ushll.4s v0, v0, #0
; CHECK-NEXT:    ucvtf.4s v0, v0
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v4i16(<4 x i16> zeroinitializer)
  %1 = trunc i32 %vaddlv to i16
  %2 = insertelement <12 x i16> zeroinitializer, i16 %1, i64 0
  %3 = uitofp <12 x i16> %2 to <12 x float>
  store <12 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v8i32_uaddlv_from_v4i32(ptr %0) {
; CHECK-LABEL: insert_vec_v8i32_uaddlv_from_v4i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    stp xzr, xzr, [x0, #16]
; CHECK-NEXT:    uaddlv.4s d1, v0
; CHECK-NEXT:    mov.s v0[0], v1[0]
; CHECK-NEXT:    ucvtf.4s v0, v0
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> zeroinitializer)
  %1 = trunc i64 %vaddlv to i32
  %2 = insertelement <8 x i32> zeroinitializer, i32 %1, i64 0
  %3 = uitofp <8 x i32> %2 to <8 x float>
  store <8 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v16i32_uaddlv_from_v4i32(ptr %0) {
; CHECK-LABEL: insert_vec_v16i32_uaddlv_from_v4i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v2, #0000000000000000
; CHECK-NEXT:    uaddlv.4s d1, v0
; CHECK-NEXT:    stp q0, q0, [x0, #32]
; CHECK-NEXT:    mov.s v2[0], v1[0]
; CHECK-NEXT:    ucvtf.4s v1, v2
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> zeroinitializer)
  %1 = trunc i64 %vaddlv to i32
  %2 = insertelement <16 x i32> zeroinitializer, i32 %1, i64 0
  %3 = uitofp <16 x i32> %2 to <16 x float>
  store <16 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v4i16_uaddlv_from_v4i32(ptr %0) {
; CHECK-LABEL: insert_vec_v4i16_uaddlv_from_v4i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v1, #0000000000000000
; CHECK-NEXT:    uaddlv.4s d0, v0
; CHECK-NEXT:    mov.h v1[0], v0[0]
; CHECK-NEXT:    ushll.4s v0, v1, #0
; CHECK-NEXT:    ucvtf.4s v0, v0
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> zeroinitializer)
  %1 = trunc i64 %vaddlv to i16
  %2 = insertelement <4 x i16> zeroinitializer, i16 %1, i64 0
  %3 = uitofp <4 x i16> %2 to <4 x float>
  store <4 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v16i16_uaddlv_from_v4i32(ptr %0) {
; CHECK-LABEL: insert_vec_v16i16_uaddlv_from_v4i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v1, #0000000000000000
; CHECK-NEXT:    uaddlv.4s d0, v0
; CHECK-NEXT:    mov.h v1[0], v0[0]
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    ushll.4s v1, v1, #0
; CHECK-NEXT:    stp q0, q0, [x0, #32]
; CHECK-NEXT:    ucvtf.4s v1, v1
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> zeroinitializer)
  %1 = trunc i64 %vaddlv to i16
  %2 = insertelement <16 x i16> zeroinitializer, i16 %1, i64 0
  %3 = uitofp <16 x i16> %2 to <16 x float>
  store <16 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v8i8_uaddlv_from_v4i32(ptr %0) {
; CHECK-LABEL: insert_vec_v8i8_uaddlv_from_v4i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v1, #0000000000000000
; CHECK-NEXT:    stp xzr, xzr, [x0, #16]
; CHECK-NEXT:    uaddlv.4s d0, v0
; CHECK-NEXT:    mov.h v1[0], v0[0]
; CHECK-NEXT:    bic.4h v1, #255, lsl #8
; CHECK-NEXT:    ushll.4s v0, v1, #0
; CHECK-NEXT:    ucvtf.4s v0, v0
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> zeroinitializer)
  %1 = trunc i64 %vaddlv to i8
  %2 = insertelement <8 x i8> zeroinitializer, i8 %1, i64 0
  %3 = uitofp <8 x i8> %2 to <8 x float>
  store <8 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v16i8_uaddlv_from_v4i32(ptr %0) {
; CHECK-LABEL: insert_vec_v16i8_uaddlv_from_v4i32:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    movi.2d v1, #0000000000000000
; CHECK-NEXT:    uaddlv.4s d0, v0
; CHECK-NEXT:    mov.h v1[0], v0[0]
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    bic.4h v1, #255, lsl #8
; CHECK-NEXT:    stp q0, q0, [x0, #32]
; CHECK-NEXT:    ushll.4s v1, v1, #0
; CHECK-NEXT:    ucvtf.4s v1, v1
; CHECK-NEXT:    stp q1, q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i64 @llvm.aarch64.neon.uaddlv.i64.v4i32(<4 x i32> zeroinitializer)
  %1 = trunc i64 %vaddlv to i8
  %2 = insertelement <16 x i8> zeroinitializer, i8 %1, i64 0
  %3 = uitofp <16 x i8> %2 to <16 x float>
  store <16 x float> %3, ptr %0, align 8
  ret void
}

define void @insert_vec_v2i32_uaddlv_from_v8i16_nz_index(ptr %0) {
; CHECK-LABEL: insert_vec_v2i32_uaddlv_from_v8i16_nz_index:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    movi.2d v0, #0000000000000000
; CHECK-NEXT:    uaddlv.8h s1, v0
; CHECK-NEXT:    mov.s v0[2], v1[0]
; CHECK-NEXT:    ucvtf.4s v0, v0
; CHECK-NEXT:    str q0, [x0]
; CHECK-NEXT:    ret

entry:
  %vaddlv = tail call i32 @llvm.aarch64.neon.uaddlv.i32.v8i16(<8 x i16> zeroinitializer)
  %1 = insertelement <4 x i32> zeroinitializer, i32 %vaddlv, i64 2
  %2 = uitofp <4 x i32> %1 to <4 x float>
  store <4 x float> %2, ptr %0, align 8
  ret void
}
