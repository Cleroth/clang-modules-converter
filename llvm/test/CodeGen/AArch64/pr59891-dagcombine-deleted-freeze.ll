; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64 | FileCheck %s

; Freezing operand of an operation that is being freezed
; may invalidate the whole SDValue we were trying to originally freeze.
define i8 @pr59891(i64 %0) {
; CHECK-LABEL: pr59891:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, wzr
; CHECK-NEXT:    ret
  %2 = freeze i64 %0
  %3 = trunc i64 %2 to i1
  %4 = trunc i64 %0 to i1
  %5 = xor i1 %3, %4
  %6 = freeze i1 %5
  %7 = zext i1 %6 to i8
  ret i8 %7
}
