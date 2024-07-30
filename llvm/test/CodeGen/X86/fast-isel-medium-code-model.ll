; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-linux-gnu -fast-isel -fast-isel-abort=3 -code-model=medium -large-data-threshold=5 < %s | FileCheck %s
; RUN: llc -mtriple=x86_64-linux-gnu -fast-isel -code-model=medium -large-data-threshold=3 < %s -o /dev/null \
; RUN:   -pass-remarks-output=- -pass-remarks-filter=sdagisel | FileCheck %s --check-prefix=FALLBACK --implicit-check-not=missed

declare void @foo()

define void @call_foo() {
; CHECK-LABEL: call_foo:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    callq foo@PLT
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
  call void @foo()
  ret void
}

@g = internal global i32 42

; FALLBACK: FastISel missed terminator
; FALLBACK: in function: g_addr

define ptr @g_addr() {
; CHECK-LABEL: g_addr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movabsq $g, %rax
; CHECK-NEXT:    retq
  ret ptr @g
}

; FALLBACK: FastISel missed
; FALLBACK: in function: load_g

define i32 @load_g() {
; CHECK-LABEL: load_g:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl g, %eax
; CHECK-NEXT:    retq
  %i = load i32, ptr @g
  ret i32 %i
}
