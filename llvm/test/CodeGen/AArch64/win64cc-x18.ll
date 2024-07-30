; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py

;; Testing that x18 is not clobbered when passing pointers with the nest
;; attribute on windows

; RUN: llc < %s -mtriple=aarch64-pc-windows-msvc | FileCheck %s --check-prefixes=CHECK,CHECK-NO-X18
; RUN: llc < %s -mtriple=aarch64-linux-gnu | FileCheck %s --check-prefixes=CHECK,CHECK-X18

define dso_local i64 @other(ptr nest %p) #0 {
; CHECK-LABEL: other:
; CHECK-X18: ldr x0, [x18]
; CHECK-NO-X18: ldr x0, [x0]
  %r = load i64, ptr %p
; CHECK: ret
  ret i64 %r
}

define dso_local void @func() #0 {
; CHECK-LABEL: func:


entry:
  %p = alloca i64
; CHECK: mov w8, #1
; CHECK: stp x30, x8, [sp, #-16]
; CHECK-X18: add x18, sp, #8
  store i64 1, ptr %p
; CHECK-NO-X18: add x0, sp, #8
; CHECK: bl other
  call void @other(ptr nest %p)
; CHECK: ldr x30, [sp], #16
; CHECK: ret
  ret void
}

attributes #0 = { nounwind }