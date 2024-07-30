; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+m,+v,+zfbfmin,+zvfbfmin -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+m,+v,+zfbfmin,+zvfbfmin -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s

declare <vscale x 1 x bfloat> @llvm.vp.select.nxv1bf16(<vscale x 1 x i1>, <vscale x 1 x bfloat>, <vscale x 1 x bfloat>, i32)

define <vscale x 1 x bfloat> @select_nxv1bf16(<vscale x 1 x i1> %a, <vscale x 1 x bfloat> %b, <vscale x 1 x bfloat> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv1bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x bfloat> @llvm.vp.select.nxv1bf16(<vscale x 1 x i1> %a, <vscale x 1 x bfloat> %b, <vscale x 1 x bfloat> %c, i32 %evl)
  ret <vscale x 1 x bfloat> %v
}

declare <vscale x 2 x bfloat> @llvm.vp.select.nxv2bf16(<vscale x 2 x i1>, <vscale x 2 x bfloat>, <vscale x 2 x bfloat>, i32)

define <vscale x 2 x bfloat> @select_nxv2bf16(<vscale x 2 x i1> %a, <vscale x 2 x bfloat> %b, <vscale x 2 x bfloat> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv2bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x bfloat> @llvm.vp.select.nxv2bf16(<vscale x 2 x i1> %a, <vscale x 2 x bfloat> %b, <vscale x 2 x bfloat> %c, i32 %evl)
  ret <vscale x 2 x bfloat> %v
}

declare <vscale x 4 x bfloat> @llvm.vp.select.nxv4bf16(<vscale x 4 x i1>, <vscale x 4 x bfloat>, <vscale x 4 x bfloat>, i32)

define <vscale x 4 x bfloat> @select_nxv4bf16(<vscale x 4 x i1> %a, <vscale x 4 x bfloat> %b, <vscale x 4 x bfloat> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv4bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v9, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x bfloat> @llvm.vp.select.nxv4bf16(<vscale x 4 x i1> %a, <vscale x 4 x bfloat> %b, <vscale x 4 x bfloat> %c, i32 %evl)
  ret <vscale x 4 x bfloat> %v
}

declare <vscale x 8 x bfloat> @llvm.vp.select.nxv8bf16(<vscale x 8 x i1>, <vscale x 8 x bfloat>, <vscale x 8 x bfloat>, i32)

define <vscale x 8 x bfloat> @select_nxv8bf16(<vscale x 8 x i1> %a, <vscale x 8 x bfloat> %b, <vscale x 8 x bfloat> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv8bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v10, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x bfloat> @llvm.vp.select.nxv8bf16(<vscale x 8 x i1> %a, <vscale x 8 x bfloat> %b, <vscale x 8 x bfloat> %c, i32 %evl)
  ret <vscale x 8 x bfloat> %v
}

declare <vscale x 16 x bfloat> @llvm.vp.select.nxv16bf16(<vscale x 16 x i1>, <vscale x 16 x bfloat>, <vscale x 16 x bfloat>, i32)

define <vscale x 16 x bfloat> @select_nxv16bf16(<vscale x 16 x i1> %a, <vscale x 16 x bfloat> %b, <vscale x 16 x bfloat> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv16bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v12, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x bfloat> @llvm.vp.select.nxv16bf16(<vscale x 16 x i1> %a, <vscale x 16 x bfloat> %b, <vscale x 16 x bfloat> %c, i32 %evl)
  ret <vscale x 16 x bfloat> %v
}

declare <vscale x 32 x bfloat> @llvm.vp.select.nxv32bf16(<vscale x 32 x i1>, <vscale x 32 x bfloat>, <vscale x 32 x bfloat>, i32)

define <vscale x 32 x bfloat> @select_nxv32bf16(<vscale x 32 x i1> %a, <vscale x 32 x bfloat> %b, <vscale x 32 x bfloat> %c, i32 zeroext %evl) {
; CHECK-LABEL: select_nxv32bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vmerge.vvm v8, v16, v8, v0
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x bfloat> @llvm.vp.select.nxv32bf16(<vscale x 32 x i1> %a, <vscale x 32 x bfloat> %b, <vscale x 32 x bfloat> %c, i32 %evl)
  ret <vscale x 32 x bfloat> %v
}
