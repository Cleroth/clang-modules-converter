; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+v,+zfbfmin,+zvfbfmin -target-abi=ilp32d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+v,+zfbfmin,+zvfbfmin -target-abi=lp64d \
; RUN:   -verify-machineinstrs < %s | FileCheck %s

define <2 x bfloat> @select_v2bf16(i1 zeroext %c, <2 x bfloat> %a, <2 x bfloat> %b) {
; CHECK-LABEL: select_v2bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <2 x bfloat> %a, <2 x bfloat> %b
  ret <2 x bfloat> %v
}

define <2 x bfloat> @selectcc_v2bf16(bfloat %a, bfloat %b, <2 x bfloat> %c, <2 x bfloat> %d) {
; CHECK-LABEL: selectcc_v2bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcvt.s.bf16 fa5, fa1
; CHECK-NEXT:    fcvt.s.bf16 fa4, fa0
; CHECK-NEXT:    feq.s a0, fa4, fa5
; CHECK-NEXT:    vsetivli zero, 2, e8, mf8, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq bfloat %a, %b
  %v = select i1 %cmp, <2 x bfloat> %c, <2 x bfloat> %d
  ret <2 x bfloat> %v
}

define <4 x bfloat> @select_v4bf16(i1 zeroext %c, <4 x bfloat> %a, <4 x bfloat> %b) {
; CHECK-LABEL: select_v4bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <4 x bfloat> %a, <4 x bfloat> %b
  ret <4 x bfloat> %v
}

define <4 x bfloat> @selectcc_v4bf16(bfloat %a, bfloat %b, <4 x bfloat> %c, <4 x bfloat> %d) {
; CHECK-LABEL: selectcc_v4bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcvt.s.bf16 fa5, fa1
; CHECK-NEXT:    fcvt.s.bf16 fa4, fa0
; CHECK-NEXT:    feq.s a0, fa4, fa5
; CHECK-NEXT:    vsetivli zero, 4, e8, mf4, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq bfloat %a, %b
  %v = select i1 %cmp, <4 x bfloat> %c, <4 x bfloat> %d
  ret <4 x bfloat> %v
}

define <8 x bfloat> @select_v8bf16(i1 zeroext %c, <8 x bfloat> %a, <8 x bfloat> %b) {
; CHECK-LABEL: select_v8bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <8 x bfloat> %a, <8 x bfloat> %b
  ret <8 x bfloat> %v
}

define <8 x bfloat> @selectcc_v8bf16(bfloat %a, bfloat %b, <8 x bfloat> %c, <8 x bfloat> %d) {
; CHECK-LABEL: selectcc_v8bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcvt.s.bf16 fa5, fa1
; CHECK-NEXT:    fcvt.s.bf16 fa4, fa0
; CHECK-NEXT:    feq.s a0, fa4, fa5
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vmv.v.x v10, a0
; CHECK-NEXT:    vmsne.vi v0, v10, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq bfloat %a, %b
  %v = select i1 %cmp, <8 x bfloat> %c, <8 x bfloat> %d
  ret <8 x bfloat> %v
}

define <16 x bfloat> @select_v16bf16(i1 zeroext %c, <16 x bfloat> %a, <16 x bfloat> %b) {
; CHECK-LABEL: select_v16bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vmsne.vi v0, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = select i1 %c, <16 x bfloat> %a, <16 x bfloat> %b
  ret <16 x bfloat> %v
}

define <16 x bfloat> @selectcc_v16bf16(bfloat %a, bfloat %b, <16 x bfloat> %c, <16 x bfloat> %d) {
; CHECK-LABEL: selectcc_v16bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    fcvt.s.bf16 fa5, fa1
; CHECK-NEXT:    fcvt.s.bf16 fa4, fa0
; CHECK-NEXT:    feq.s a0, fa4, fa5
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vmv.v.x v12, a0
; CHECK-NEXT:    vmsne.vi v0, v12, 0
; CHECK-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %cmp = fcmp oeq bfloat %a, %b
  %v = select i1 %cmp, <16 x bfloat> %c, <16 x bfloat> %d
  ret <16 x bfloat> %v
}