; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 -mattr=+sve < %s | FileCheck %s

define i1 @ptest_v16i1_256bit_min_sve(ptr %a, ptr %b) vscale_range(2, 0) {
; CHECK-LABEL: ptest_v16i1_256bit_min_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl8
; CHECK-NEXT:    mov x8, #8 // =0x8
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0, x8, lsl #2]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x0]
; CHECK-NEXT:    fcmne p1.s, p0/z, z0.s, #0.0
; CHECK-NEXT:    fcmne p0.s, p0/z, z1.s, #0.0
; CHECK-NEXT:    mov z0.s, p1/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    mov z1.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z1.h, z1.h, z1.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    uzp1 z1.b, z1.b, z1.b
; CHECK-NEXT:    mov v1.d[1], v0.d[0]
; CHECK-NEXT:    umaxv b0, v1.16b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %v1 = load <16 x float>, ptr %a, align 4
  %v2 = fcmp une <16 x float> %v1, zeroinitializer
  %v3 = call i1 @llvm.vector.reduce.or.i1.v16i1 (<16 x i1> %v2)
  ret i1 %v3
}

define i1 @ptest_v16i1_512bit_min_sve(ptr %a, ptr %b) vscale_range(4, 0) {
; CHECK-LABEL: ptest_v16i1_512bit_min_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl16
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    fcmne p0.s, p0/z, z0.s, #0.0
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    umaxv b0, v0.16b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %v1 = load <16 x float>, ptr %a, align 4
  %v2 = fcmp une <16 x float> %v1, zeroinitializer
  %v3 = call i1 @llvm.vector.reduce.or.i1.v16i1 (<16 x i1> %v2)
  ret i1 %v3
}

define i1 @ptest_v16i1_512bit_sve(ptr %a, ptr %b) vscale_range(4, 4) {
; CHECK-LABEL: ptest_v16i1_512bit_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    fcmne p0.s, p0/z, z0.s, #0.0
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    umaxv b0, v0.16b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %v1 = load <16 x float>, ptr %a, align 4
  %v2 = fcmp une <16 x float> %v1, zeroinitializer
  %v3 = call i1 @llvm.vector.reduce.or.i1.v16i1 (<16 x i1> %v2)
  ret i1 %v3
}

define i1 @ptest_or_v16i1_512bit_min_sve(ptr %a, ptr %b) vscale_range(4, 0) {
; CHECK-LABEL: ptest_or_v16i1_512bit_min_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl16
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    fcmne p1.s, p0/z, z0.s, #0.0
; CHECK-NEXT:    fcmne p0.s, p0/z, z1.s, #0.0
; CHECK-NEXT:    mov p0.b, p1/m, p1.b
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    umaxv b0, v0.16b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %v1 = load <16 x float>, ptr %a, align 4
  %v2 = fcmp une <16 x float> %v1, zeroinitializer
  %v4 = load <16 x float>, ptr %b, align 4
  %v5 = fcmp une <16 x float> %v4, zeroinitializer
  %v6 = or <16 x i1> %v2, %v5
  %v7 = call i1 @llvm.vector.reduce.or.i1.v16i1 (<16 x i1> %v6)
  ret i1 %v7
}

declare i1 @llvm.vector.reduce.or.i1.v16i1(<16 x i1>)

;
; AND reduction.
;

define i1 @ptest_and_v16i1_512bit_sve(ptr %a, ptr %b) vscale_range(4, 4) {
; CHECK-LABEL: ptest_and_v16i1_512bit_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    fcmne p1.s, p0/z, z0.s, #0.0
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x1]
; CHECK-NEXT:    fcmne p0.s, p1/z, z0.s, #0.0
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    uminv b0, v0.16b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %v1 = load <16 x float>, ptr %a, align 4
  %v2 = fcmp une <16 x float> %v1, zeroinitializer
  %v4 = load <16 x float>, ptr %b, align 4
  %v5 = fcmp une <16 x float> %v4, zeroinitializer
  %v6 = and <16 x i1> %v2, %v5
  %v7 = call i1 @llvm.vector.reduce.and.i1.v16i1 (<16 x i1> %v6)
  ret i1 %v7
}

define i1 @ptest_and_v16i1_512bit_min_sve(ptr %a, ptr %b) vscale_range(4, 0) {
; CHECK-LABEL: ptest_and_v16i1_512bit_min_sve:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s, vl16
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x1]
; CHECK-NEXT:    fcmne p1.s, p0/z, z0.s, #0.0
; CHECK-NEXT:    fcmne p0.s, p0/z, z1.s, #0.0
; CHECK-NEXT:    and p0.b, p1/z, p1.b, p0.b
; CHECK-NEXT:    mov z0.s, p0/z, #-1 // =0xffffffffffffffff
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    uminv b0, v0.16b
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %v1 = load <16 x float>, ptr %a, align 4
  %v2 = fcmp une <16 x float> %v1, zeroinitializer
  %v4 = load <16 x float>, ptr %b, align 4
  %v5 = fcmp une <16 x float> %v4, zeroinitializer
  %v6 = and <16 x i1> %v2, %v5
  %v7 = call i1 @llvm.vector.reduce.and.i1.v16i1 (<16 x i1> %v6)
  ret i1 %v7
}

declare i1 @llvm.vector.reduce.and.i1.v16i1(<16 x i1>)
