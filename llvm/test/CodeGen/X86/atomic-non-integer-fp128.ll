; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=sse2,cx16 | FileCheck %s --check-prefixes=X64-SSE
; RUN: llc < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=avx,cx16 | FileCheck %s --check-prefixes=X64-AVX
; RUN: llc < %s -mtriple=x86_64-linux-generic -verify-machineinstrs -mattr=avx512f,cx16 | FileCheck %s --check-prefixes=X64-AVX

; Codegen of fp128 without cx16 is tested in atomic-nocx16.ll

define void @store_fp128(ptr %fptr, fp128 %v) {
; X64-SSE-LABEL: store_fp128:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    pushq %rbx
; X64-SSE-NEXT:    .cfi_def_cfa_offset 16
; X64-SSE-NEXT:    .cfi_offset %rbx, -16
; X64-SSE-NEXT:    movaps %xmm0, -{{[0-9]+}}(%rsp)
; X64-SSE-NEXT:    movq -{{[0-9]+}}(%rsp), %rbx
; X64-SSE-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; X64-SSE-NEXT:    movq (%rdi), %rax
; X64-SSE-NEXT:    movq 8(%rdi), %rdx
; X64-SSE-NEXT:    .p2align 4, 0x90
; X64-SSE-NEXT:  .LBB0_1: # %atomicrmw.start
; X64-SSE-NEXT:    # =>This Inner Loop Header: Depth=1
; X64-SSE-NEXT:    lock cmpxchg16b (%rdi)
; X64-SSE-NEXT:    jne .LBB0_1
; X64-SSE-NEXT:  # %bb.2: # %atomicrmw.end
; X64-SSE-NEXT:    popq %rbx
; X64-SSE-NEXT:    .cfi_def_cfa_offset 8
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: store_fp128:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovaps %xmm0, (%rdi)
; X64-AVX-NEXT:    retq
  store atomic fp128 %v, ptr %fptr unordered, align 16
  ret void
}

define fp128 @load_fp128(ptr %fptr) {
; X64-SSE-LABEL: load_fp128:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    pushq %rbx
; X64-SSE-NEXT:    .cfi_def_cfa_offset 16
; X64-SSE-NEXT:    .cfi_offset %rbx, -16
; X64-SSE-NEXT:    xorl %eax, %eax
; X64-SSE-NEXT:    xorl %edx, %edx
; X64-SSE-NEXT:    xorl %ecx, %ecx
; X64-SSE-NEXT:    xorl %ebx, %ebx
; X64-SSE-NEXT:    lock cmpxchg16b (%rdi)
; X64-SSE-NEXT:    movq %rdx, -{{[0-9]+}}(%rsp)
; X64-SSE-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; X64-SSE-NEXT:    movaps -{{[0-9]+}}(%rsp), %xmm0
; X64-SSE-NEXT:    popq %rbx
; X64-SSE-NEXT:    .cfi_def_cfa_offset 8
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: load_fp128:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    vmovaps (%rdi), %xmm0
; X64-AVX-NEXT:    vmovaps %xmm0, -{{[0-9]+}}(%rsp)
; X64-AVX-NEXT:    vmovaps -{{[0-9]+}}(%rsp), %xmm0
; X64-AVX-NEXT:    retq
  %v = load atomic fp128, ptr %fptr unordered, align 16
  ret fp128 %v
}

define fp128 @exchange_fp128(ptr %fptr, fp128 %x) {
; X64-SSE-LABEL: exchange_fp128:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    pushq %rbx
; X64-SSE-NEXT:    .cfi_def_cfa_offset 16
; X64-SSE-NEXT:    .cfi_offset %rbx, -16
; X64-SSE-NEXT:    movaps %xmm0, -{{[0-9]+}}(%rsp)
; X64-SSE-NEXT:    movq -{{[0-9]+}}(%rsp), %rbx
; X64-SSE-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; X64-SSE-NEXT:    movq (%rdi), %rax
; X64-SSE-NEXT:    movq 8(%rdi), %rdx
; X64-SSE-NEXT:    .p2align 4, 0x90
; X64-SSE-NEXT:  .LBB2_1: # %atomicrmw.start
; X64-SSE-NEXT:    # =>This Inner Loop Header: Depth=1
; X64-SSE-NEXT:    lock cmpxchg16b (%rdi)
; X64-SSE-NEXT:    jne .LBB2_1
; X64-SSE-NEXT:  # %bb.2: # %atomicrmw.end
; X64-SSE-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; X64-SSE-NEXT:    movq %rdx, -{{[0-9]+}}(%rsp)
; X64-SSE-NEXT:    movaps -{{[0-9]+}}(%rsp), %xmm0
; X64-SSE-NEXT:    popq %rbx
; X64-SSE-NEXT:    .cfi_def_cfa_offset 8
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: exchange_fp128:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    pushq %rbx
; X64-AVX-NEXT:    .cfi_def_cfa_offset 16
; X64-AVX-NEXT:    .cfi_offset %rbx, -16
; X64-AVX-NEXT:    vmovaps %xmm0, -{{[0-9]+}}(%rsp)
; X64-AVX-NEXT:    movq -{{[0-9]+}}(%rsp), %rbx
; X64-AVX-NEXT:    movq -{{[0-9]+}}(%rsp), %rcx
; X64-AVX-NEXT:    movq (%rdi), %rax
; X64-AVX-NEXT:    movq 8(%rdi), %rdx
; X64-AVX-NEXT:    .p2align 4, 0x90
; X64-AVX-NEXT:  .LBB2_1: # %atomicrmw.start
; X64-AVX-NEXT:    # =>This Inner Loop Header: Depth=1
; X64-AVX-NEXT:    lock cmpxchg16b (%rdi)
; X64-AVX-NEXT:    jne .LBB2_1
; X64-AVX-NEXT:  # %bb.2: # %atomicrmw.end
; X64-AVX-NEXT:    movq %rax, -{{[0-9]+}}(%rsp)
; X64-AVX-NEXT:    movq %rdx, -{{[0-9]+}}(%rsp)
; X64-AVX-NEXT:    vmovaps -{{[0-9]+}}(%rsp), %xmm0
; X64-AVX-NEXT:    popq %rbx
; X64-AVX-NEXT:    .cfi_def_cfa_offset 8
; X64-AVX-NEXT:    retq
  %v = atomicrmw xchg ptr %fptr, fp128 %x monotonic, align 16
  ret fp128 %v
}

