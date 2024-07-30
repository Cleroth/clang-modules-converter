; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; Test 128-bit OR in vector registers on z13
;
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z13 | FileCheck %s

; Or.
define i128 @f1(i128 %a, i128 %b) {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl %v0, 0(%r4), 3
; CHECK-NEXT:    vl %v1, 0(%r3), 3
; CHECK-NEXT:    vo %v0, %v1, %v0
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
  %res = or i128 %a, %b
  ret i128 %res
}

; NOR.
define i128 @f2(i128 %a, i128 %b) {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl %v0, 0(%r4), 3
; CHECK-NEXT:    vl %v1, 0(%r3), 3
; CHECK-NEXT:    vno %v0, %v1, %v0
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
  %op = or i128 %a, %b
  %res = xor i128 %op, -1
  ret i128 %res
}

; Complement.
define i128 @f3(i128 %a) {
; CHECK-LABEL: f3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl %v0, 0(%r3), 3
; CHECK-NEXT:    vno %v0, %v0, %v0
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
  %res = xor i128 %a, -1
  ret i128 %res
}

; Select.
define i128 @f4(i128 %mask, i128 %true, i128 %false) {
; CHECK-LABEL: f4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl %v0, 0(%r3), 3
; CHECK-NEXT:    vl %v1, 0(%r5), 3
; CHECK-NEXT:    vl %v2, 0(%r4), 3
; CHECK-NEXT:    vsel %v0, %v2, %v1, %v0
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
  %notmask = xor i128 %mask, -1
  %res1 = and i128 %true, %mask
  %res2 = and i128 %false, %notmask
  %res = or i128 %res1, %res2
  ret i128 %res
}
