; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple aarch64-unknown-linux-gnu | FileCheck %s --check-prefixes=CHECK-SD
; RUN: llc -mtriple=aarch64 -global-isel -global-isel-abort=2 -verify-machineinstrs %s -o - 2>&1 | FileCheck %s --check-prefixes=CHECK-GI

; Tests for wider-than-legal extensions into mul/mla.

define <16 x i16> @mul_i16(<16 x i8> %a, <16 x i8> %b) {
; CHECK-SD-LABEL: mul_i16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    umull2 v2.8h, v0.16b, v1.16b
; CHECK-SD-NEXT:    umull v0.8h, v0.8b, v1.8b
; CHECK-SD-NEXT:    mov v1.16b, v2.16b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: mul_i16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    umull v2.8h, v0.8b, v1.8b
; CHECK-GI-NEXT:    umull2 v1.8h, v0.16b, v1.16b
; CHECK-GI-NEXT:    mov v0.16b, v2.16b
; CHECK-GI-NEXT:    ret
entry:
  %ea = zext <16 x i8> %a to <16 x i16>
  %eb = zext <16 x i8> %b to <16 x i16>
  %m = mul <16 x i16> %ea, %eb
  ret <16 x i16> %m
}

define <16 x i32> @mul_i32(<16 x i8> %a, <16 x i8> %b) {
; CHECK-SD-LABEL: mul_i32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    umull v2.8h, v0.8b, v1.8b
; CHECK-SD-NEXT:    umull2 v4.8h, v0.16b, v1.16b
; CHECK-SD-NEXT:    ushll v0.4s, v2.4h, #0
; CHECK-SD-NEXT:    ushll2 v3.4s, v4.8h, #0
; CHECK-SD-NEXT:    ushll2 v1.4s, v2.8h, #0
; CHECK-SD-NEXT:    ushll v2.4s, v4.4h, #0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: mul_i32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    ushll v2.8h, v0.8b, #0
; CHECK-GI-NEXT:    ushll v3.8h, v1.8b, #0
; CHECK-GI-NEXT:    ushll2 v4.8h, v0.16b, #0
; CHECK-GI-NEXT:    ushll2 v5.8h, v1.16b, #0
; CHECK-GI-NEXT:    umull v0.4s, v2.4h, v3.4h
; CHECK-GI-NEXT:    umull2 v1.4s, v2.8h, v3.8h
; CHECK-GI-NEXT:    umull v2.4s, v4.4h, v5.4h
; CHECK-GI-NEXT:    umull2 v3.4s, v4.8h, v5.8h
; CHECK-GI-NEXT:    ret
entry:
  %ea = zext <16 x i8> %a to <16 x i32>
  %eb = zext <16 x i8> %b to <16 x i32>
  %m = mul <16 x i32> %ea, %eb
  ret <16 x i32> %m
}

define <16 x i64> @mul_i64(<16 x i8> %a, <16 x i8> %b) {
; CHECK-SD-LABEL: mul_i64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    umull v2.8h, v0.8b, v1.8b
; CHECK-SD-NEXT:    umull2 v0.8h, v0.16b, v1.16b
; CHECK-SD-NEXT:    ushll v3.4s, v2.4h, #0
; CHECK-SD-NEXT:    ushll2 v2.4s, v2.8h, #0
; CHECK-SD-NEXT:    ushll v5.4s, v0.4h, #0
; CHECK-SD-NEXT:    ushll2 v6.4s, v0.8h, #0
; CHECK-SD-NEXT:    ushll2 v1.2d, v3.4s, #0
; CHECK-SD-NEXT:    ushll v0.2d, v3.2s, #0
; CHECK-SD-NEXT:    ushll2 v3.2d, v2.4s, #0
; CHECK-SD-NEXT:    ushll v2.2d, v2.2s, #0
; CHECK-SD-NEXT:    ushll v4.2d, v5.2s, #0
; CHECK-SD-NEXT:    ushll2 v7.2d, v6.4s, #0
; CHECK-SD-NEXT:    ushll2 v5.2d, v5.4s, #0
; CHECK-SD-NEXT:    ushll v6.2d, v6.2s, #0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: mul_i64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    ushll v2.8h, v0.8b, #0
; CHECK-GI-NEXT:    ushll v3.8h, v1.8b, #0
; CHECK-GI-NEXT:    ushll2 v0.8h, v0.16b, #0
; CHECK-GI-NEXT:    ushll2 v1.8h, v1.16b, #0
; CHECK-GI-NEXT:    ushll v4.4s, v2.4h, #0
; CHECK-GI-NEXT:    ushll2 v5.4s, v2.8h, #0
; CHECK-GI-NEXT:    ushll v2.4s, v3.4h, #0
; CHECK-GI-NEXT:    ushll v6.4s, v0.4h, #0
; CHECK-GI-NEXT:    ushll2 v3.4s, v3.8h, #0
; CHECK-GI-NEXT:    ushll v7.4s, v1.4h, #0
; CHECK-GI-NEXT:    ushll2 v16.4s, v0.8h, #0
; CHECK-GI-NEXT:    ushll2 v17.4s, v1.8h, #0
; CHECK-GI-NEXT:    umull v0.2d, v4.2s, v2.2s
; CHECK-GI-NEXT:    umull2 v1.2d, v4.4s, v2.4s
; CHECK-GI-NEXT:    umull v2.2d, v5.2s, v3.2s
; CHECK-GI-NEXT:    umull2 v3.2d, v5.4s, v3.4s
; CHECK-GI-NEXT:    umull v4.2d, v6.2s, v7.2s
; CHECK-GI-NEXT:    umull2 v5.2d, v6.4s, v7.4s
; CHECK-GI-NEXT:    umull v6.2d, v16.2s, v17.2s
; CHECK-GI-NEXT:    umull2 v7.2d, v16.4s, v17.4s
; CHECK-GI-NEXT:    ret
entry:
  %ea = zext <16 x i8> %a to <16 x i64>
  %eb = zext <16 x i8> %b to <16 x i64>
  %m = mul <16 x i64> %ea, %eb
  ret <16 x i64> %m
}


define <16 x i16> @mla_i16(<16 x i8> %a, <16 x i8> %b, <16 x i16> %c) {
; CHECK-SD-LABEL: mla_i16:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    umlal2 v3.8h, v0.16b, v1.16b
; CHECK-SD-NEXT:    umlal v2.8h, v0.8b, v1.8b
; CHECK-SD-NEXT:    mov v0.16b, v2.16b
; CHECK-SD-NEXT:    mov v1.16b, v3.16b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: mla_i16:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    umlal v2.8h, v0.8b, v1.8b
; CHECK-GI-NEXT:    umlal2 v3.8h, v0.16b, v1.16b
; CHECK-GI-NEXT:    mov v0.16b, v2.16b
; CHECK-GI-NEXT:    mov v1.16b, v3.16b
; CHECK-GI-NEXT:    ret
entry:
  %ea = zext <16 x i8> %a to <16 x i16>
  %eb = zext <16 x i8> %b to <16 x i16>
  %m = mul <16 x i16> %ea, %eb
  %d = add <16 x i16> %m, %c
  ret <16 x i16> %d
}

define <16 x i32> @mla_i32(<16 x i8> %a, <16 x i8> %b, <16 x i32> %c) {
; CHECK-SD-LABEL: mla_i32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    umull2 v7.8h, v0.16b, v1.16b
; CHECK-SD-NEXT:    umull v6.8h, v0.8b, v1.8b
; CHECK-SD-NEXT:    uaddw2 v5.4s, v5.4s, v7.8h
; CHECK-SD-NEXT:    uaddw v0.4s, v2.4s, v6.4h
; CHECK-SD-NEXT:    uaddw2 v1.4s, v3.4s, v6.8h
; CHECK-SD-NEXT:    uaddw v2.4s, v4.4s, v7.4h
; CHECK-SD-NEXT:    mov v3.16b, v5.16b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: mla_i32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    ushll v6.8h, v0.8b, #0
; CHECK-GI-NEXT:    ushll v7.8h, v1.8b, #0
; CHECK-GI-NEXT:    ushll2 v0.8h, v0.16b, #0
; CHECK-GI-NEXT:    ushll2 v1.8h, v1.16b, #0
; CHECK-GI-NEXT:    umlal v2.4s, v6.4h, v7.4h
; CHECK-GI-NEXT:    umlal2 v3.4s, v6.8h, v7.8h
; CHECK-GI-NEXT:    umlal v4.4s, v0.4h, v1.4h
; CHECK-GI-NEXT:    umlal2 v5.4s, v0.8h, v1.8h
; CHECK-GI-NEXT:    mov v0.16b, v2.16b
; CHECK-GI-NEXT:    mov v1.16b, v3.16b
; CHECK-GI-NEXT:    mov v2.16b, v4.16b
; CHECK-GI-NEXT:    mov v3.16b, v5.16b
; CHECK-GI-NEXT:    ret
entry:
  %ea = zext <16 x i8> %a to <16 x i32>
  %eb = zext <16 x i8> %b to <16 x i32>
  %m = mul <16 x i32> %ea, %eb
  %d = add <16 x i32> %m, %c
  ret <16 x i32> %d
}

define <16 x i64> @mla_i64(<16 x i8> %a, <16 x i8> %b, <16 x i64> %c) {
; CHECK-SD-LABEL: mla_i64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    umull v16.8h, v0.8b, v1.8b
; CHECK-SD-NEXT:    umull2 v0.8h, v0.16b, v1.16b
; CHECK-SD-NEXT:    ldp q20, q21, [sp]
; CHECK-SD-NEXT:    ushll v17.4s, v16.4h, #0
; CHECK-SD-NEXT:    ushll2 v16.4s, v16.8h, #0
; CHECK-SD-NEXT:    ushll2 v19.4s, v0.8h, #0
; CHECK-SD-NEXT:    ushll v18.4s, v0.4h, #0
; CHECK-SD-NEXT:    uaddw2 v1.2d, v3.2d, v17.4s
; CHECK-SD-NEXT:    uaddw v0.2d, v2.2d, v17.2s
; CHECK-SD-NEXT:    uaddw2 v3.2d, v5.2d, v16.4s
; CHECK-SD-NEXT:    uaddw v2.2d, v4.2d, v16.2s
; CHECK-SD-NEXT:    uaddw2 v16.2d, v21.2d, v19.4s
; CHECK-SD-NEXT:    uaddw v4.2d, v6.2d, v18.2s
; CHECK-SD-NEXT:    uaddw2 v5.2d, v7.2d, v18.4s
; CHECK-SD-NEXT:    uaddw v6.2d, v20.2d, v19.2s
; CHECK-SD-NEXT:    mov v7.16b, v16.16b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: mla_i64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    mov v16.16b, v2.16b
; CHECK-GI-NEXT:    mov v17.16b, v3.16b
; CHECK-GI-NEXT:    mov v2.16b, v4.16b
; CHECK-GI-NEXT:    mov v3.16b, v5.16b
; CHECK-GI-NEXT:    mov v4.16b, v6.16b
; CHECK-GI-NEXT:    mov v5.16b, v7.16b
; CHECK-GI-NEXT:    ushll v6.8h, v0.8b, #0
; CHECK-GI-NEXT:    ushll v7.8h, v1.8b, #0
; CHECK-GI-NEXT:    ushll2 v0.8h, v0.16b, #0
; CHECK-GI-NEXT:    ushll2 v1.8h, v1.16b, #0
; CHECK-GI-NEXT:    ushll v18.4s, v6.4h, #0
; CHECK-GI-NEXT:    ushll v20.4s, v7.4h, #0
; CHECK-GI-NEXT:    ushll2 v19.4s, v6.8h, #0
; CHECK-GI-NEXT:    ushll v21.4s, v0.4h, #0
; CHECK-GI-NEXT:    ushll2 v22.4s, v7.8h, #0
; CHECK-GI-NEXT:    ushll v23.4s, v1.4h, #0
; CHECK-GI-NEXT:    ldp q6, q7, [sp]
; CHECK-GI-NEXT:    ushll2 v0.4s, v0.8h, #0
; CHECK-GI-NEXT:    ushll2 v1.4s, v1.8h, #0
; CHECK-GI-NEXT:    umlal v16.2d, v18.2s, v20.2s
; CHECK-GI-NEXT:    umlal2 v17.2d, v18.4s, v20.4s
; CHECK-GI-NEXT:    umlal v2.2d, v19.2s, v22.2s
; CHECK-GI-NEXT:    umlal2 v3.2d, v19.4s, v22.4s
; CHECK-GI-NEXT:    umlal v4.2d, v21.2s, v23.2s
; CHECK-GI-NEXT:    umlal2 v5.2d, v21.4s, v23.4s
; CHECK-GI-NEXT:    umlal v6.2d, v0.2s, v1.2s
; CHECK-GI-NEXT:    umlal2 v7.2d, v0.4s, v1.4s
; CHECK-GI-NEXT:    mov v0.16b, v16.16b
; CHECK-GI-NEXT:    mov v1.16b, v17.16b
; CHECK-GI-NEXT:    ret
entry:
  %ea = zext <16 x i8> %a to <16 x i64>
  %eb = zext <16 x i8> %b to <16 x i64>
  %m = mul <16 x i64> %ea, %eb
  %d = add <16 x i64> %m, %c
  ret <16 x i64> %d
}
