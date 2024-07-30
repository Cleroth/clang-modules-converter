; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -global-isel=1 -mtriple=x86_64-linux-gnu -o - %s | FileCheck %s

declare void @use_addr(ptr)
declare ptr @llvm.stacksave.p0()
declare void @llvm.stackrestore.p0(ptr)

define void @test_scoped_alloca(i64 %n) {
; CHECK-LABEL: test_scoped_alloca:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movq %rsp, %rbp
; CHECK-NEXT:    .cfi_def_cfa_register %rbp
; CHECK-NEXT:    pushq %rbx
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_offset %rbx, -24
; CHECK-NEXT:    movq %rsp, %rbx
; CHECK-NEXT:    movq %rsp, %rax
; CHECK-NEXT:    imulq $1, %rdi, %rcx
; CHECK-NEXT:    addq $15, %rcx
; CHECK-NEXT:    andq $-16, %rcx
; CHECK-NEXT:    subq %rcx, %rax
; CHECK-NEXT:    movq %rax, %rsp
; CHECK-NEXT:    movq %rax, %rdi
; CHECK-NEXT:    callq use_addr
; CHECK-NEXT:    movq %rbx, %rsp
; CHECK-NEXT:    leaq -8(%rbp), %rsp
; CHECK-NEXT:    popq %rbx
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa %rsp, 8
; CHECK-NEXT:    retq
  %sp = call ptr @llvm.stacksave.p0()
  %addr = alloca i8, i64 %n
  call void @use_addr(ptr %addr)
  call void @llvm.stackrestore.p0(ptr %sp)
  ret void
}
