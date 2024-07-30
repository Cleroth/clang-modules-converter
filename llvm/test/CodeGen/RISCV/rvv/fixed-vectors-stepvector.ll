; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV64

declare <2 x i8> @llvm.experimental.stepvector.v2i8()

define <2 x i8> @stepvector_v2i8() {
; CHECK-LABEL: stepvector_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.experimental.stepvector.v2i8()
  ret <2 x i8> %v
}

declare <3 x i8> @llvm.experimental.stepvector.v3i8()

define <3 x i8> @stepvector_v3i8() {
; CHECK-LABEL: stepvector_v3i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <3 x i8> @llvm.experimental.stepvector.v3i8()
  ret <3 x i8> %v
}

declare <4 x i8> @llvm.experimental.stepvector.v4i8()

define <4 x i8> @stepvector_v4i8() {
; CHECK-LABEL: stepvector_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <4 x i8> @llvm.experimental.stepvector.v4i8()
  ret <4 x i8> %v
}

declare <8 x i8> @llvm.experimental.stepvector.v8i8()

define <8 x i8> @stepvector_v8i8() {
; CHECK-LABEL: stepvector_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <8 x i8> @llvm.experimental.stepvector.v8i8()
  ret <8 x i8> %v
}

declare <16 x i8> @llvm.experimental.stepvector.v16i8()

define <16 x i8> @stepvector_v16i8() {
; CHECK-LABEL: stepvector_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <16 x i8> @llvm.experimental.stepvector.v16i8()
  ret <16 x i8> %v
}

declare <2 x i16> @llvm.experimental.stepvector.v2i16()

define <2 x i16> @stepvector_v2i16() {
; CHECK-LABEL: stepvector_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.experimental.stepvector.v2i16()
  ret <2 x i16> %v
}

declare <4 x i16> @llvm.experimental.stepvector.v4i16()

define <4 x i16> @stepvector_v4i16() {
; CHECK-LABEL: stepvector_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.experimental.stepvector.v4i16()
  ret <4 x i16> %v
}

declare <8 x i16> @llvm.experimental.stepvector.v8i16()

define <8 x i16> @stepvector_v8i16() {
; CHECK-LABEL: stepvector_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <8 x i16> @llvm.experimental.stepvector.v8i16()
  ret <8 x i16> %v
}

declare <16 x i16> @llvm.experimental.stepvector.v16i16()

define <16 x i16> @stepvector_v16i16() {
; CHECK-LABEL: stepvector_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <16 x i16> @llvm.experimental.stepvector.v16i16()
  ret <16 x i16> %v
}

declare <2 x i32> @llvm.experimental.stepvector.v2i32()

define <2 x i32> @stepvector_v2i32() {
; CHECK-LABEL: stepvector_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i32> @llvm.experimental.stepvector.v2i32()
  ret <2 x i32> %v
}

declare <4 x i32> @llvm.experimental.stepvector.v4i32()

define <4 x i32> @stepvector_v4i32() {
; CHECK-LABEL: stepvector_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.experimental.stepvector.v4i32()
  ret <4 x i32> %v
}

declare <8 x i32> @llvm.experimental.stepvector.v8i32()

define <8 x i32> @stepvector_v8i32() {
; CHECK-LABEL: stepvector_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <8 x i32> @llvm.experimental.stepvector.v8i32()
  ret <8 x i32> %v
}

declare <16 x i32> @llvm.experimental.stepvector.v16i32()

define <16 x i32> @stepvector_v16i32() {
; CHECK-LABEL: stepvector_v16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <16 x i32> @llvm.experimental.stepvector.v16i32()
  ret <16 x i32> %v
}

declare <2 x i64> @llvm.experimental.stepvector.v2i64()

define <2 x i64> @stepvector_v2i64() {
; RV32-LABEL: stepvector_v2i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, 16
; RV32-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; RV32-NEXT:    vmv.s.x v9, a0
; RV32-NEXT:    vsext.vf4 v8, v9
; RV32-NEXT:    ret
;
; RV64-LABEL: stepvector_v2i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    ret
  %v = call <2 x i64> @llvm.experimental.stepvector.v2i64()
  ret <2 x i64> %v
}

declare <4 x i64> @llvm.experimental.stepvector.v4i64()

define <4 x i64> @stepvector_v4i64() {
; RV32-LABEL: stepvector_v4i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI14_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI14_0)
; RV32-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; RV32-NEXT:    vle8.v v10, (a0)
; RV32-NEXT:    vsext.vf4 v8, v10
; RV32-NEXT:    ret
;
; RV64-LABEL: stepvector_v4i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    ret
  %v = call <4 x i64> @llvm.experimental.stepvector.v4i64()
  ret <4 x i64> %v
}

declare <8 x i64> @llvm.experimental.stepvector.v8i64()

define <8 x i64> @stepvector_v8i64() {
; RV32-LABEL: stepvector_v8i64:
; RV32:       # %bb.0:
; RV32-NEXT:    lui a0, %hi(.LCPI15_0)
; RV32-NEXT:    addi a0, a0, %lo(.LCPI15_0)
; RV32-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; RV32-NEXT:    vle8.v v12, (a0)
; RV32-NEXT:    vsext.vf4 v8, v12
; RV32-NEXT:    ret
;
; RV64-LABEL: stepvector_v8i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    ret
  %v = call <8 x i64> @llvm.experimental.stepvector.v8i64()
  ret <8 x i64> %v
}

declare <16 x i64> @llvm.experimental.stepvector.v16i64()

define <16 x i64> @stepvector_v16i64() {
; RV32-LABEL: stepvector_v16i64:
; RV32:       # %bb.0:
; RV32-NEXT:    li a0, 32
; RV32-NEXT:    lui a1, %hi(.LCPI16_0)
; RV32-NEXT:    addi a1, a1, %lo(.LCPI16_0)
; RV32-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; RV32-NEXT:    vle8.v v16, (a1)
; RV32-NEXT:    vsext.vf4 v8, v16
; RV32-NEXT:    ret
;
; RV64-LABEL: stepvector_v16i64:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    ret
  %v = call <16 x i64> @llvm.experimental.stepvector.v16i64()
  ret <16 x i64> %v
}
