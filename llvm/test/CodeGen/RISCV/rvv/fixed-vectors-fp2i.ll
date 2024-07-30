; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH,ZVFH32
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH,ZVFH64
; RUN: llc -mtriple=riscv32 -target-abi=ilp32d -mattr=+v,+zfh,+zvfhmin,+f,+d -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN,ZVFHMIN32
; RUN: llc -mtriple=riscv64 -target-abi=lp64d -mattr=+v,+zfh,+zvfhmin,+f,+d -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN,ZVFHMIN64

define void @fp2si_v2f32_v2i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = fptosi <2 x float> %a to <2 x i32>
  store <2 x i32> %d, ptr %y
  ret void
}

define void @fp2ui_v2f32_v2i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f32_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = fptoui <2 x float> %a to <2 x i32>
  store <2 x i32> %d, ptr %y
  ret void
}

define <2 x i1> @fp2si_v2f32_v2i1(<2 x float> %x) {
; CHECK-LABEL: fp2si_v2f32_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptosi <2 x float> %x to <2 x i1>
  ret <2 x i1> %z
}

define <2 x i15> @fp2si_v2f32_v2i15(<2 x float> %x) {
; CHECK-LABEL: fp2si_v2f32_v2i15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %z = fptosi <2 x float> %x to <2 x i15>
  ret <2 x i15> %z
}

define <2 x i15> @fp2ui_v2f32_v2i15(<2 x float> %x) {
; CHECK-LABEL: fp2ui_v2f32_v2i15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %z = fptoui <2 x float> %x to <2 x i15>
  ret <2 x i15> %z
}

define <2 x i1> @fp2ui_v2f32_v2i1(<2 x float> %x) {
; CHECK-LABEL: fp2ui_v2f32_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptoui <2 x float> %x to <2 x i1>
  ret <2 x i1> %z
}

define void @fp2si_v3f32_v3i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v3f32_v3i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <3 x float>, ptr %x
  %d = fptosi <3 x float> %a to <3 x i32>
  store <3 x i32> %d, ptr %y
  ret void
}

define void @fp2ui_v3f32_v3i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v3f32_v3i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; CHECK-NEXT:    vsetivli zero, 3, e32, m1, ta, ma
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <3 x float>, ptr %x
  %d = fptoui <3 x float> %a to <3 x i32>
  store <3 x i32> %d, ptr %y
  ret void
}

define <3 x i1> @fp2si_v3f32_v3i1(<3 x float> %x) {
; CHECK-LABEL: fp2si_v3f32_v3i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptosi <3 x float> %x to <3 x i1>
  ret <3 x i1> %z
}

; FIXME: This is expanded when they could be widened + promoted
define <3 x i15> @fp2si_v3f32_v3i15(<3 x float> %x) {
; ZVFH32-LABEL: fp2si_v3f32_v3i15:
; ZVFH32:       # %bb.0:
; ZVFH32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFH32-NEXT:    vfncvt.rtz.x.f.w v9, v8
; ZVFH32-NEXT:    vslidedown.vi v8, v9, 2
; ZVFH32-NEXT:    vmv.x.s a1, v8
; ZVFH32-NEXT:    slli a2, a1, 17
; ZVFH32-NEXT:    srli a2, a2, 19
; ZVFH32-NEXT:    sh a2, 4(a0)
; ZVFH32-NEXT:    vmv.x.s a2, v9
; ZVFH32-NEXT:    lui a3, 8
; ZVFH32-NEXT:    addi a3, a3, -1
; ZVFH32-NEXT:    and a2, a2, a3
; ZVFH32-NEXT:    vslidedown.vi v8, v9, 1
; ZVFH32-NEXT:    vmv.x.s a4, v8
; ZVFH32-NEXT:    and a3, a4, a3
; ZVFH32-NEXT:    slli a3, a3, 15
; ZVFH32-NEXT:    slli a1, a1, 30
; ZVFH32-NEXT:    or a1, a2, a1
; ZVFH32-NEXT:    or a1, a1, a3
; ZVFH32-NEXT:    sw a1, 0(a0)
; ZVFH32-NEXT:    ret
;
; ZVFH64-LABEL: fp2si_v3f32_v3i15:
; ZVFH64:       # %bb.0:
; ZVFH64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFH64-NEXT:    vfncvt.rtz.x.f.w v9, v8
; ZVFH64-NEXT:    vmv.x.s a1, v9
; ZVFH64-NEXT:    lui a2, 8
; ZVFH64-NEXT:    addiw a2, a2, -1
; ZVFH64-NEXT:    and a1, a1, a2
; ZVFH64-NEXT:    vslidedown.vi v8, v9, 1
; ZVFH64-NEXT:    vmv.x.s a3, v8
; ZVFH64-NEXT:    and a2, a3, a2
; ZVFH64-NEXT:    slli a2, a2, 15
; ZVFH64-NEXT:    vslidedown.vi v8, v9, 2
; ZVFH64-NEXT:    vmv.x.s a3, v8
; ZVFH64-NEXT:    slli a3, a3, 30
; ZVFH64-NEXT:    or a1, a1, a3
; ZVFH64-NEXT:    or a1, a1, a2
; ZVFH64-NEXT:    sw a1, 0(a0)
; ZVFH64-NEXT:    slli a1, a1, 19
; ZVFH64-NEXT:    srli a1, a1, 51
; ZVFH64-NEXT:    sh a1, 4(a0)
; ZVFH64-NEXT:    ret
;
; ZVFHMIN32-LABEL: fp2si_v3f32_v3i15:
; ZVFHMIN32:       # %bb.0:
; ZVFHMIN32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN32-NEXT:    vfncvt.rtz.x.f.w v9, v8
; ZVFHMIN32-NEXT:    vslidedown.vi v8, v9, 2
; ZVFHMIN32-NEXT:    vmv.x.s a1, v8
; ZVFHMIN32-NEXT:    slli a2, a1, 17
; ZVFHMIN32-NEXT:    srli a2, a2, 19
; ZVFHMIN32-NEXT:    sh a2, 4(a0)
; ZVFHMIN32-NEXT:    vmv.x.s a2, v9
; ZVFHMIN32-NEXT:    lui a3, 8
; ZVFHMIN32-NEXT:    addi a3, a3, -1
; ZVFHMIN32-NEXT:    and a2, a2, a3
; ZVFHMIN32-NEXT:    vslidedown.vi v8, v9, 1
; ZVFHMIN32-NEXT:    vmv.x.s a4, v8
; ZVFHMIN32-NEXT:    and a3, a4, a3
; ZVFHMIN32-NEXT:    slli a3, a3, 15
; ZVFHMIN32-NEXT:    slli a1, a1, 30
; ZVFHMIN32-NEXT:    or a1, a2, a1
; ZVFHMIN32-NEXT:    or a1, a1, a3
; ZVFHMIN32-NEXT:    sw a1, 0(a0)
; ZVFHMIN32-NEXT:    ret
;
; ZVFHMIN64-LABEL: fp2si_v3f32_v3i15:
; ZVFHMIN64:       # %bb.0:
; ZVFHMIN64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN64-NEXT:    vfncvt.rtz.x.f.w v9, v8
; ZVFHMIN64-NEXT:    vmv.x.s a1, v9
; ZVFHMIN64-NEXT:    lui a2, 8
; ZVFHMIN64-NEXT:    addiw a2, a2, -1
; ZVFHMIN64-NEXT:    and a1, a1, a2
; ZVFHMIN64-NEXT:    vslidedown.vi v8, v9, 1
; ZVFHMIN64-NEXT:    vmv.x.s a3, v8
; ZVFHMIN64-NEXT:    and a2, a3, a2
; ZVFHMIN64-NEXT:    slli a2, a2, 15
; ZVFHMIN64-NEXT:    vslidedown.vi v8, v9, 2
; ZVFHMIN64-NEXT:    vmv.x.s a3, v8
; ZVFHMIN64-NEXT:    slli a3, a3, 30
; ZVFHMIN64-NEXT:    or a1, a1, a3
; ZVFHMIN64-NEXT:    or a1, a1, a2
; ZVFHMIN64-NEXT:    sw a1, 0(a0)
; ZVFHMIN64-NEXT:    slli a1, a1, 19
; ZVFHMIN64-NEXT:    srli a1, a1, 51
; ZVFHMIN64-NEXT:    sh a1, 4(a0)
; ZVFHMIN64-NEXT:    ret
  %z = fptosi <3 x float> %x to <3 x i15>
  ret <3 x i15> %z
}

; FIXME: This is expanded when they could be widened + promoted
define <3 x i15> @fp2ui_v3f32_v3i15(<3 x float> %x) {
; ZVFH32-LABEL: fp2ui_v3f32_v3i15:
; ZVFH32:       # %bb.0:
; ZVFH32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFH32-NEXT:    vfncvt.rtz.x.f.w v9, v8
; ZVFH32-NEXT:    vslidedown.vi v8, v9, 2
; ZVFH32-NEXT:    vmv.x.s a1, v8
; ZVFH32-NEXT:    slli a2, a1, 17
; ZVFH32-NEXT:    srli a2, a2, 19
; ZVFH32-NEXT:    sh a2, 4(a0)
; ZVFH32-NEXT:    vmv.x.s a2, v9
; ZVFH32-NEXT:    lui a3, 16
; ZVFH32-NEXT:    addi a3, a3, -1
; ZVFH32-NEXT:    and a2, a2, a3
; ZVFH32-NEXT:    vslidedown.vi v8, v9, 1
; ZVFH32-NEXT:    vmv.x.s a4, v8
; ZVFH32-NEXT:    and a3, a4, a3
; ZVFH32-NEXT:    slli a3, a3, 15
; ZVFH32-NEXT:    slli a1, a1, 30
; ZVFH32-NEXT:    or a1, a2, a1
; ZVFH32-NEXT:    or a1, a1, a3
; ZVFH32-NEXT:    sw a1, 0(a0)
; ZVFH32-NEXT:    ret
;
; ZVFH64-LABEL: fp2ui_v3f32_v3i15:
; ZVFH64:       # %bb.0:
; ZVFH64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFH64-NEXT:    vfncvt.rtz.x.f.w v9, v8
; ZVFH64-NEXT:    vmv.x.s a1, v9
; ZVFH64-NEXT:    lui a2, 16
; ZVFH64-NEXT:    addiw a2, a2, -1
; ZVFH64-NEXT:    and a1, a1, a2
; ZVFH64-NEXT:    vslidedown.vi v8, v9, 1
; ZVFH64-NEXT:    vmv.x.s a3, v8
; ZVFH64-NEXT:    and a2, a3, a2
; ZVFH64-NEXT:    slli a2, a2, 15
; ZVFH64-NEXT:    vslidedown.vi v8, v9, 2
; ZVFH64-NEXT:    vmv.x.s a3, v8
; ZVFH64-NEXT:    slli a3, a3, 30
; ZVFH64-NEXT:    or a1, a1, a3
; ZVFH64-NEXT:    or a1, a1, a2
; ZVFH64-NEXT:    sw a1, 0(a0)
; ZVFH64-NEXT:    slli a1, a1, 19
; ZVFH64-NEXT:    srli a1, a1, 51
; ZVFH64-NEXT:    sh a1, 4(a0)
; ZVFH64-NEXT:    ret
;
; ZVFHMIN32-LABEL: fp2ui_v3f32_v3i15:
; ZVFHMIN32:       # %bb.0:
; ZVFHMIN32-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN32-NEXT:    vfncvt.rtz.x.f.w v9, v8
; ZVFHMIN32-NEXT:    vslidedown.vi v8, v9, 2
; ZVFHMIN32-NEXT:    vmv.x.s a1, v8
; ZVFHMIN32-NEXT:    slli a2, a1, 17
; ZVFHMIN32-NEXT:    srli a2, a2, 19
; ZVFHMIN32-NEXT:    sh a2, 4(a0)
; ZVFHMIN32-NEXT:    vmv.x.s a2, v9
; ZVFHMIN32-NEXT:    lui a3, 16
; ZVFHMIN32-NEXT:    addi a3, a3, -1
; ZVFHMIN32-NEXT:    and a2, a2, a3
; ZVFHMIN32-NEXT:    vslidedown.vi v8, v9, 1
; ZVFHMIN32-NEXT:    vmv.x.s a4, v8
; ZVFHMIN32-NEXT:    and a3, a4, a3
; ZVFHMIN32-NEXT:    slli a3, a3, 15
; ZVFHMIN32-NEXT:    slli a1, a1, 30
; ZVFHMIN32-NEXT:    or a1, a2, a1
; ZVFHMIN32-NEXT:    or a1, a1, a3
; ZVFHMIN32-NEXT:    sw a1, 0(a0)
; ZVFHMIN32-NEXT:    ret
;
; ZVFHMIN64-LABEL: fp2ui_v3f32_v3i15:
; ZVFHMIN64:       # %bb.0:
; ZVFHMIN64-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; ZVFHMIN64-NEXT:    vfncvt.rtz.x.f.w v9, v8
; ZVFHMIN64-NEXT:    vmv.x.s a1, v9
; ZVFHMIN64-NEXT:    lui a2, 16
; ZVFHMIN64-NEXT:    addiw a2, a2, -1
; ZVFHMIN64-NEXT:    and a1, a1, a2
; ZVFHMIN64-NEXT:    vslidedown.vi v8, v9, 1
; ZVFHMIN64-NEXT:    vmv.x.s a3, v8
; ZVFHMIN64-NEXT:    and a2, a3, a2
; ZVFHMIN64-NEXT:    slli a2, a2, 15
; ZVFHMIN64-NEXT:    vslidedown.vi v8, v9, 2
; ZVFHMIN64-NEXT:    vmv.x.s a3, v8
; ZVFHMIN64-NEXT:    slli a3, a3, 30
; ZVFHMIN64-NEXT:    or a1, a1, a3
; ZVFHMIN64-NEXT:    or a1, a1, a2
; ZVFHMIN64-NEXT:    sw a1, 0(a0)
; ZVFHMIN64-NEXT:    slli a1, a1, 19
; ZVFHMIN64-NEXT:    srli a1, a1, 51
; ZVFHMIN64-NEXT:    sh a1, 4(a0)
; ZVFHMIN64-NEXT:    ret
  %z = fptoui <3 x float> %x to <3 x i15>
  ret <3 x i15> %z
}

define <3 x i1> @fp2ui_v3f32_v3i1(<3 x float> %x) {
; CHECK-LABEL: fp2ui_v3f32_v3i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptoui <3 x float> %x to <3 x i1>
  ret <3 x i1> %z
}

define void @fp2si_v8f32_v8i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v8f32_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfcvt.rtz.x.f.v v8, v8
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = fptosi <8 x float> %a to <8 x i32>
  store <8 x i32> %d, ptr %y
  ret void
}

define void @fp2ui_v8f32_v8i32(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v8f32_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfcvt.rtz.xu.f.v v8, v8
; CHECK-NEXT:    vse32.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = fptoui <8 x float> %a to <8 x i32>
  store <8 x i32> %d, ptr %y
  ret void
}

define <8 x i1> @fp2si_v8f32_v8i1(<8 x float> %x) {
; CHECK-LABEL: fp2si_v8f32_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v10, v8
; CHECK-NEXT:    vand.vi v8, v10, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptosi <8 x float> %x to <8 x i1>
  ret <8 x i1> %z
}

define <8 x i1> @fp2ui_v8f32_v8i1(<8 x float> %x) {
; CHECK-LABEL: fp2ui_v8f32_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v10, v8
; CHECK-NEXT:    vand.vi v8, v10, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptoui <8 x float> %x to <8 x i1>
  ret <8 x i1> %z
}

define void @fp2si_v2f32_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v9, v8
; CHECK-NEXT:    vse64.v v9, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = fptosi <2 x float> %a to <2 x i64>
  store <2 x i64> %d, ptr %y
  ret void
}

define void @fp2ui_v2f32_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f32_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v9, v8
; CHECK-NEXT:    vse64.v v9, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x float>, ptr %x
  %d = fptoui <2 x float> %a to <2 x i64>
  store <2 x i64> %d, ptr %y
  ret void
}

define void @fp2si_v8f32_v8i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v8f32_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v12, v8
; CHECK-NEXT:    vse64.v v12, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = fptosi <8 x float> %a to <8 x i64>
  store <8 x i64> %d, ptr %y
  ret void
}

define void @fp2ui_v8f32_v8i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v8f32_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v12, v8
; CHECK-NEXT:    vse64.v v12, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x float>, ptr %x
  %d = fptoui <8 x float> %a to <8 x i64>
  store <8 x i64> %d, ptr %y
  ret void
}

define void @fp2si_v2f16_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.x.f.v v8, v9
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x half>, ptr %x
  %d = fptosi <2 x half> %a to <2 x i64>
  store <2 x i64> %d, ptr %y
  ret void
}

define void @fp2ui_v2f16_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f16_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vfwcvt.f.f.v v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfwcvt.rtz.xu.f.v v8, v9
; CHECK-NEXT:    vse64.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x half>, ptr %x
  %d = fptoui <2 x half> %a to <2 x i64>
  store <2 x i64> %d, ptr %y
  ret void
}

define <2 x i1> @fp2si_v2f16_v2i1(<2 x half> %x) {
; ZVFH-LABEL: fp2si_v2f16_v2i1:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; ZVFH-NEXT:    vfncvt.rtz.x.f.w v9, v8
; ZVFH-NEXT:    vand.vi v8, v9, 1
; ZVFH-NEXT:    vmsne.vi v0, v8, 0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: fp2si_v2f16_v2i1:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfncvt.rtz.x.f.w v8, v9
; ZVFHMIN-NEXT:    vand.vi v8, v8, 1
; ZVFHMIN-NEXT:    vmsne.vi v0, v8, 0
; ZVFHMIN-NEXT:    ret
  %z = fptosi <2 x half> %x to <2 x i1>
  ret <2 x i1> %z
}

define <2 x i1> @fp2ui_v2f16_v2i1(<2 x half> %x) {
; ZVFH-LABEL: fp2ui_v2f16_v2i1:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; ZVFH-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; ZVFH-NEXT:    vand.vi v8, v9, 1
; ZVFH-NEXT:    vmsne.vi v0, v8, 0
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: fp2ui_v2f16_v2i1:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfncvt.rtz.xu.f.w v8, v9
; ZVFHMIN-NEXT:    vand.vi v8, v8, 1
; ZVFHMIN-NEXT:    vmsne.vi v0, v8, 0
; ZVFHMIN-NEXT:    ret
  %z = fptoui <2 x half> %x to <2 x i1>
  ret <2 x i1> %z
}

define void @fp2si_v2f64_v2i8(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v2f64_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v9, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %d = fptosi <2 x double> %a to <2 x i8>
  store <2 x i8> %d, ptr %y
  ret void
}

define void @fp2ui_v2f64_v2i8(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v2f64_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v9, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <2 x double>, ptr %x
  %d = fptoui <2 x double> %a to <2 x i8>
  store <2 x i8> %d, ptr %y
  ret void
}

define <2 x i1> @fp2si_v2f64_v2i1(<2 x double> %x) {
; CHECK-LABEL: fp2si_v2f64_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptosi <2 x double> %x to <2 x i1>
  ret <2 x i1> %z
}

define <2 x i1> @fp2ui_v2f64_v2i1(<2 x double> %x) {
; CHECK-LABEL: fp2ui_v2f64_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v9, v8
; CHECK-NEXT:    vand.vi v8, v9, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptoui <2 x double> %x to <2 x i1>
  ret <2 x i1> %z
}

define void @fp2si_v8f64_v8i8(ptr %x, ptr %y) {
; CHECK-LABEL: fp2si_v8f64_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfncvt.rtz.x.f.w v12, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x double>, ptr %x
  %d = fptosi <8 x double> %a to <8 x i8>
  store <8 x i8> %d, ptr %y
  ret void
}

define void @fp2ui_v8f64_v8i8(ptr %x, ptr %y) {
; CHECK-LABEL: fp2ui_v8f64_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v12, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vnsrl.wi v8, v8, 0
; CHECK-NEXT:    vse8.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x double>, ptr %x
  %d = fptoui <8 x double> %a to <8 x i8>
  store <8 x i8> %d, ptr %y
  ret void
}

define <8 x i1> @fp2si_v8f64_v8i1(<8 x double> %x) {
; CHECK-LABEL: fp2si_v8f64_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.x.f.w v12, v8
; CHECK-NEXT:    vand.vi v8, v12, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptosi <8 x double> %x to <8 x i1>
  ret <8 x i1> %z
}

define <8 x i1> @fp2ui_v8f64_v8i1(<8 x double> %x) {
; CHECK-LABEL: fp2ui_v8f64_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vfncvt.rtz.xu.f.w v12, v8
; CHECK-NEXT:    vand.vi v8, v12, 1
; CHECK-NEXT:    vmsne.vi v0, v8, 0
; CHECK-NEXT:    ret
  %z = fptoui <8 x double> %x to <8 x i1>
  ret <8 x i1> %z
}
