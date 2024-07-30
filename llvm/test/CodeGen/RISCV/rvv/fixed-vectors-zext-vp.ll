; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+m,+v < %s | FileCheck %s

declare <4 x i16> @llvm.vp.zext.v4i16.v4i8(<4 x i8>, <4 x i1>, i32)

define <4 x i16> @vzext_v4i16_v4i8(<4 x i8> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i16_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.vp.zext.v4i16.v4i8(<4 x i8> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i16> %v
}

define <4 x i16> @vzext_v4i16_v4i8_unmasked(<4 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i16_v4i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.vp.zext.v4i16.v4i8(<4 x i8> %va, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i16> %v
}

declare <4 x i32> @llvm.vp.zext.v4i32.v4i8(<4 x i8>, <4 x i1>, i32)

define <4 x i32> @vzext_v4i32_v4i8(<4 x i8> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i32_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf4 v9, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.zext.v4i32.v4i8(<4 x i8> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i32> %v
}

define <4 x i32> @vzext_v4i32_v4i8_unmasked(<4 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i32_v4i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf4 v9, v8
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.zext.v4i32.v4i8(<4 x i8> %va, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i32> %v
}

declare <4 x i64> @llvm.vp.zext.v4i64.v4i8(<4 x i8>, <4 x i1>, i32)

define <4 x i64> @vzext_v4i64_v4i8(<4 x i8> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i64_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vzext.vf8 v10, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.zext.v4i64.v4i8(<4 x i8> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i64> %v
}

define <4 x i64> @vzext_v4i64_v4i8_unmasked(<4 x i8> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i64_v4i8_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vzext.vf8 v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.zext.v4i64.v4i8(<4 x i8> %va, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i64> %v
}

declare <4 x i32> @llvm.vp.zext.v4i32.v4i16(<4 x i16>, <4 x i1>, i32)

define <4 x i32> @vzext_v4i32_v4i16(<4 x i16> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i32_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.zext.v4i32.v4i16(<4 x i16> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i32> %v
}

define <4 x i32> @vzext_v4i32_v4i16_unmasked(<4 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i32_v4i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8
; CHECK-NEXT:    vmv.v.v v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.vp.zext.v4i32.v4i16(<4 x i16> %va, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i32> %v
}

declare <4 x i64> @llvm.vp.zext.v4i64.v4i16(<4 x i16>, <4 x i1>, i32)

define <4 x i64> @vzext_v4i64_v4i16(<4 x i16> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i64_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vzext.vf4 v10, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.zext.v4i64.v4i16(<4 x i16> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i64> %v
}

define <4 x i64> @vzext_v4i64_v4i16_unmasked(<4 x i16> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i64_v4i16_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vzext.vf4 v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.zext.v4i64.v4i16(<4 x i16> %va, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i64> %v
}

declare <4 x i64> @llvm.vp.zext.v4i64.v4i32(<4 x i32>, <4 x i1>, i32)

define <4 x i64> @vzext_v4i64_v4i32(<4 x i32> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i64_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vzext.vf2 v10, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.zext.v4i64.v4i32(<4 x i32> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i64> %v
}

define <4 x i64> @vzext_v4i64_v4i32_unmasked(<4 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i64_v4i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vzext.vf2 v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <4 x i64> @llvm.vp.zext.v4i64.v4i32(<4 x i32> %va, <4 x i1> splat (i1 true), i32 %evl)
  ret <4 x i64> %v
}

declare <32 x i64> @llvm.vp.zext.v32i64.v32i32(<32 x i32>, <32 x i1>, i32)

define <32 x i64> @vzext_v32i64_v32i32(<32 x i32> %va, <32 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v32i64_v32i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 16
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v16, v0, 2
; CHECK-NEXT:    mv a1, a0
; CHECK-NEXT:    bltu a0, a2, .LBB12_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:  .LBB12_2:
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; CHECK-NEXT:    vzext.vf2 v24, v8, v0.t
; CHECK-NEXT:    addi a1, a0, -16
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    and a0, a0, a1
; CHECK-NEXT:    vsetivli zero, 16, e32, m8, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 16
; CHECK-NEXT:    vmv1r.v v0, v16
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vzext.vf2 v16, v8, v0.t
; CHECK-NEXT:    vmv8r.v v8, v24
; CHECK-NEXT:    ret
  %v = call <32 x i64> @llvm.vp.zext.v32i64.v32i32(<32 x i32> %va, <32 x i1> %m, i32 %evl)
  ret <32 x i64> %v
}

define <32 x i64> @vzext_v32i64_v32i32_unmasked(<32 x i32> %va, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v32i64_v32i32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 16
; CHECK-NEXT:    mv a1, a0
; CHECK-NEXT:    bltu a0, a2, .LBB13_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a1, 16
; CHECK-NEXT:  .LBB13_2:
; CHECK-NEXT:    vsetvli zero, a1, e64, m8, ta, ma
; CHECK-NEXT:    vzext.vf2 v24, v8
; CHECK-NEXT:    addi a1, a0, -16
; CHECK-NEXT:    sltu a0, a0, a1
; CHECK-NEXT:    addi a0, a0, -1
; CHECK-NEXT:    and a0, a0, a1
; CHECK-NEXT:    vsetivli zero, 16, e32, m8, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 16
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vzext.vf2 v16, v8
; CHECK-NEXT:    vmv8r.v v8, v24
; CHECK-NEXT:    ret
  %v = call <32 x i64> @llvm.vp.zext.v32i64.v32i32(<32 x i32> %va, <32 x i1> splat (i1 true), i32 %evl)
  ret <32 x i64> %v
}

declare <4 x i16> @llvm.vp.zext.v4i16.v4i7(<4 x i7>, <4 x i1>, i32)

define <4 x i16> @vzext_v4i16_v4i7(<4 x i7> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i16_v4i7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8, v0.t
; CHECK-NEXT:    li a0, 127
; CHECK-NEXT:    vand.vx v8, v9, a0, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.vp.zext.v4i16.v4i7(<4 x i7> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i16> %v
}

declare <4 x i8> @llvm.vp.zext.v4i8.v4i7(<4 x i7>, <4 x i1>, i32)

define <4 x i8> @vzext_v4i8_v4i7(<4 x i7> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i8_v4i7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 127
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vand.vx v8, v8, a1, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x i8> @llvm.vp.zext.v4i8.v4i7(<4 x i7> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i8> %v
}

declare <4 x i15> @llvm.vp.zext.v4i15.v4i8(<4 x i8>, <4 x i1>, i32)

define <4 x i15> @vzext_v4i15_v4i8(<4 x i8> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i15_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vzext.vf2 v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <4 x i15> @llvm.vp.zext.v4i15.v4i8(<4 x i8> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i15> %v
}

declare <4 x i15> @llvm.vp.zext.v4i15.v4i9(<4 x i9>, <4 x i1>, i32)

define <4 x i15> @vzext_v4i15_v4i9(<4 x i9> %va, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vzext_v4i15_v4i9:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a1, 511
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vand.vx v8, v8, a1, v0.t
; CHECK-NEXT:    ret
  %v = call <4 x i15> @llvm.vp.zext.v4i15.v4i9(<4 x i9> %va, <4 x i1> %m, i32 %evl)
  ret <4 x i15> %v
}
