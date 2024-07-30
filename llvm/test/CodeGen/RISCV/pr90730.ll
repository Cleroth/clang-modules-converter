; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=riscv64 -mattr=+zbb | FileCheck %s

define i32 @pr90730(i32 %x, i1 %y, ptr %p) {
; CHECK-LABEL: pr90730:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lui a1, 8
; CHECK-NEXT:    addiw a1, a1, -960
; CHECK-NEXT:    andn a0, a1, a0
; CHECK-NEXT:    sw zero, 0(a2)
; CHECK-NEXT:    ret
entry:
  %ext = zext i1 %y to i32
  %xor1 = xor i32 %ext, 31817
  %and1 = and i32 %xor1, %x
  store i32 %and1, ptr %p, align 4
  %v = load i32, ptr %p, align 4
  %and2 = and i32 %v, 31808
  %xor2 = xor i32 %and2, 31808
  store i32 0, ptr %p, align 4
  ret i32 %xor2
}
