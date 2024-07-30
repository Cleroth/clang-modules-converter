; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

define <2 x i1> @isnan_v2f16(<2 x half> %x) {
; CHECK-LABEL: isnan_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 768
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <2 x i1> @llvm.is.fpclass.v2f16(<2 x half> %x, i32 3)  ; nan
  ret <2 x i1> %1
}

define <2 x i1> @isnan_v2f32(<2 x float> %x) {
; CHECK-LABEL: isnan_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 927
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <2 x i1> @llvm.is.fpclass.v2f32(<2 x float> %x, i32 639)
  ret <2 x i1> %1
}


define <4 x i1> @isnan_v4f32(<4 x float> %x) {
; CHECK-LABEL: isnan_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 768
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <4 x i1> @llvm.is.fpclass.v4f32(<4 x float> %x, i32 3)  ; nan
  ret <4 x i1> %1
}

define <8 x i1> @isnan_v8f32(<8 x float> %x) {
; CHECK-LABEL: isnan_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 512
; CHECK-NEXT:    vmseq.vx v0, v8, a0
; CHECK-NEXT:    ret
  %1 = call <8 x i1> @llvm.is.fpclass.v8f32(<8 x float> %x, i32 2)
  ret <8 x i1> %1
}

define <16 x i1> @isnan_v16f32(<16 x float> %x) {
; CHECK-LABEL: isnan_v16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e32, m4, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 256
; CHECK-NEXT:    vmseq.vx v0, v8, a0
; CHECK-NEXT:    ret
  %1 = call <16 x i1> @llvm.is.fpclass.v16f32(<16 x float> %x, i32 1)
  ret <16 x i1> %1
}

define <2 x i1> @isnormal_v2f64(<2 x double> %x) {
; CHECK-LABEL: isnormal_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 129
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <2 x i1> @llvm.is.fpclass.v2f64(<2 x double> %x, i32 516) ; 0x204 = "inf"
  ret <2 x i1> %1
}

define <4 x i1> @isposinf_v4f64(<4 x double> %x) {
; CHECK-LABEL: isposinf_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 128
; CHECK-NEXT:    vmseq.vx v0, v8, a0
; CHECK-NEXT:    ret
  %1 = call <4 x i1> @llvm.is.fpclass.v4f64(<4 x double> %x, i32 512) ; 0x200 = "+inf"
  ret <4 x i1> %1
}

define <8 x i1> @isneginf_v8f64(<8 x double> %x) {
; CHECK-LABEL: isneginf_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    vmseq.vi v0, v8, 1
; CHECK-NEXT:    ret
  %1 = call <8 x i1> @llvm.is.fpclass.v8f64(<8 x double> %x, i32 4) ; "-inf"
  ret <8 x i1> %1
}

define <16 x i1> @isfinite_v16f64(<16 x double> %x) {
; CHECK-LABEL: isfinite_v16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 126
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <16 x i1> @llvm.is.fpclass.v16f64(<16 x double> %x, i32 504) ; 0x1f8 = "finite"
  ret <16 x i1> %1
}

define <16 x i1> @isposfinite_v16f64(<16 x double> %x) {
; CHECK-LABEL: isposfinite_v16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 112
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <16 x i1> @llvm.is.fpclass.v16f64(<16 x double> %x, i32 448) ; 0x1c0 = "+finite"
  ret <16 x i1> %1
}

define <16 x i1> @isnegfinite_v16f64(<16 x double> %x) {
; CHECK-LABEL: isnegfinite_v16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    vand.vi v8, v8, 14
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <16 x i1> @llvm.is.fpclass.v16f64(<16 x double> %x, i32 56) ; 0x38 = "-finite"
  ret <16 x i1> %1
}

define <16 x i1> @isnotfinite_v16f64(<16 x double> %x) {
; CHECK-LABEL: isnotfinite_v16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-NEXT:    vfclass.v v8, v8
; CHECK-NEXT:    li a0, 897
; CHECK-NEXT:    vand.vx v8, v8, a0
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %1 = call <16 x i1> @llvm.is.fpclass.v16f64(<16 x double> %x, i32 519) ; 0x207 = "inf|nan"
  ret <16 x i1> %1
}

declare <2 x i1> @llvm.is.fpclass.v2f16(<2 x half>, i32)
declare <2 x i1> @llvm.is.fpclass.v2f32(<2 x float>, i32)
declare <4 x i1> @llvm.is.fpclass.v4f32(<4 x float>, i32)
declare <8 x i1> @llvm.is.fpclass.v8f32(<8 x float>, i32)
declare <16 x i1> @llvm.is.fpclass.v16f32(<16 x float>, i32)
declare <2 x i1> @llvm.is.fpclass.v2f64(<2 x double>, i32)
declare <4 x i1> @llvm.is.fpclass.v4f64(<4 x double>, i32)
declare <8 x i1> @llvm.is.fpclass.v8f64(<8 x double>, i32)
declare <16 x i1> @llvm.is.fpclass.v16f64(<16 x double>, i32)
