; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple aarch64-unknown-linux-gnu < %s | FileCheck %s

; SABA from ADD(ABS(SUB NSW))

define <4 x i32> @saba_abs_4s(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) #0 {
; CHECK-LABEL: saba_abs_4s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.4s, v1.4s, v2.4s
; CHECK-NEXT:    ret
  %sub = sub nsw <4 x i32> %b, %c
  %abs = call <4 x i32> @llvm.abs.v4i32(<4 x i32> %sub, i1 true)
  %add = add <4 x i32> %a, %abs
  ret <4 x i32> %add
}

define <2 x i32> @saba_abs_2s(<2 x i32> %a, <2 x i32> %b, <2 x i32> %c) #0 {
; CHECK-LABEL: saba_abs_2s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.2s, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %sub = sub nsw <2 x i32> %b, %c
  %abs = call <2 x i32> @llvm.abs.v2i32(<2 x i32> %sub, i1 true)
  %add = add <2 x i32> %a, %abs
  ret <2 x i32> %add
}

define <8 x i16> @saba_abs_8h(<8 x i16> %a, <8 x i16> %b, <8 x i16> %c) #0 {
; CHECK-LABEL: saba_abs_8h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.8h, v1.8h, v2.8h
; CHECK-NEXT:    ret
  %sub = sub nsw <8 x i16> %b, %c
  %abs = call <8 x i16> @llvm.abs.v8i16(<8 x i16> %sub, i1 true)
  %add = add <8 x i16> %a, %abs
  ret <8 x i16> %add
}

define <4 x i16> @saba_abs_4h(<4 x i16> %a, <4 x i16> %b, <4 x i16> %c) #0 {
; CHECK-LABEL: saba_abs_4h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.4h, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %sub = sub nsw <4 x i16> %b, %c
  %abs = call <4 x i16> @llvm.abs.v4i16(<4 x i16> %sub, i1 true)
  %add = add <4 x i16> %a, %abs
  ret <4 x i16> %add
}

define <16 x i8> @saba_abs_16b(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c) #0 {
; CHECK-LABEL: saba_abs_16b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %sub = sub nsw <16 x i8> %b, %c
  %abs = call <16 x i8> @llvm.abs.v16i8(<16 x i8> %sub, i1 true)
  %add = add <16 x i8> %a, %abs
  ret <16 x i8> %add
}

define <8 x i8> @saba_abs_8b(<8 x i8> %a, <8 x i8> %b, <8 x i8> %c) #0 {
; CHECK-LABEL: saba_abs_8b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %sub = sub nsw <8 x i8> %b, %c
  %abs = call <8 x i8> @llvm.abs.v8i8(<8 x i8> %sub, i1 true)
  %add = add <8 x i8> %a, %abs
  ret <8 x i8> %add
}

; SABA from ADD(SABD)

define <4 x i32> @saba_sabd_4s(<4 x i32> %a, <4 x i32> %b, <4 x i32> %c) #0 {
; CHECK-LABEL: saba_sabd_4s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.4s, v1.4s, v2.4s
; CHECK-NEXT:    ret
  %sabd = call <4 x i32> @llvm.aarch64.neon.sabd.v4i32(<4 x i32> %b, <4 x i32> %c)
  %add = add <4 x i32> %sabd, %a
  ret <4 x i32> %add
}

define <2 x i32> @saba_sabd_2s(<2 x i32> %a, <2 x i32> %b, <2 x i32> %c) #0 {
; CHECK-LABEL: saba_sabd_2s:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.2s, v1.2s, v2.2s
; CHECK-NEXT:    ret
  %sabd = call <2 x i32> @llvm.aarch64.neon.sabd.v2i32(<2 x i32> %b, <2 x i32> %c)
  %add = add <2 x i32> %sabd, %a
  ret <2 x i32> %add
}

define <8 x i16> @saba_sabd_8h(<8 x i16> %a, <8 x i16> %b, <8 x i16> %c) #0 {
; CHECK-LABEL: saba_sabd_8h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.8h, v1.8h, v2.8h
; CHECK-NEXT:    ret
  %sabd = call <8 x i16> @llvm.aarch64.neon.sabd.v8i16(<8 x i16> %b, <8 x i16> %c)
  %add = add <8 x i16> %sabd, %a
  ret <8 x i16> %add
}

define <4 x i16> @saba_sabd_4h(<4 x i16> %a, <4 x i16> %b, <4 x i16> %c) #0 {
; CHECK-LABEL: saba_sabd_4h:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.4h, v1.4h, v2.4h
; CHECK-NEXT:    ret
  %sabd = call <4 x i16> @llvm.aarch64.neon.sabd.v4i16(<4 x i16> %b, <4 x i16> %c)
  %add = add <4 x i16> %sabd, %a
  ret <4 x i16> %add
}

define <16 x i8> @saba_sabd_16b(<16 x i8> %a, <16 x i8> %b, <16 x i8> %c) #0 {
; CHECK-LABEL: saba_sabd_16b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %sabd = call <16 x i8> @llvm.aarch64.neon.sabd.v16i8(<16 x i8> %b, <16 x i8> %c)
  %add = add <16 x i8> %sabd, %a
  ret <16 x i8> %add
}

define <8 x i8> @saba_sabd_8b(<8 x i8> %a, <8 x i8> %b, <8 x i8> %c) #0 {
; CHECK-LABEL: saba_sabd_8b:
; CHECK:       // %bb.0:
; CHECK-NEXT:    saba v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %sabd = call <8 x i8> @llvm.aarch64.neon.sabd.v8i8(<8 x i8> %b, <8 x i8> %c)
  %add = add <8 x i8> %sabd, %a
  ret <8 x i8> %add
}

declare <4 x i32> @llvm.abs.v4i32(<4 x i32>, i1)
declare <2 x i32> @llvm.abs.v2i32(<2 x i32>, i1)
declare <8 x i16> @llvm.abs.v8i16(<8 x i16>, i1)
declare <4 x i16> @llvm.abs.v4i16(<4 x i16>, i1)
declare <16 x i8> @llvm.abs.v16i8(<16 x i8>, i1)
declare <8 x i8> @llvm.abs.v8i8(<8 x i8>, i1)

declare <4 x i32> @llvm.aarch64.neon.sabd.v4i32(<4 x i32>, <4 x i32>)
declare <2 x i32> @llvm.aarch64.neon.sabd.v2i32(<2 x i32>, <2 x i32>)
declare <8 x i16> @llvm.aarch64.neon.sabd.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i16> @llvm.aarch64.neon.sabd.v4i16(<4 x i16>, <4 x i16>)
declare <16 x i8> @llvm.aarch64.neon.sabd.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i8> @llvm.aarch64.neon.sabd.v8i8(<8 x i8>, <8 x i8>)
