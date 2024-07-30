; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown   -mattr=+mmx,+sse2 | FileCheck %s --check-prefix=X86-SSE
; RUN: llc < %s -mtriple=i686-unknown-unknown   -mattr=+mmx,+avx2 | FileCheck %s --check-prefix=X86-AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+mmx,+sse2 | FileCheck %s --check-prefix=X64-SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+mmx,+avx2 | FileCheck %s --check-prefix=X64-AVX

define i32 @PR29222(i32) nounwind {
; X86-SSE-LABEL: PR29222:
; X86-SSE:       # %bb.0:
; X86-SSE-NEXT:    pushl %ebp
; X86-SSE-NEXT:    movl %esp, %ebp
; X86-SSE-NEXT:    andl $-8, %esp
; X86-SSE-NEXT:    subl $8, %esp
; X86-SSE-NEXT:    movd 8(%ebp), %mm0
; X86-SSE-NEXT:    pshufw $68, %mm0, %mm0 # mm0 = mm0[0,1,0,1]
; X86-SSE-NEXT:    packsswb %mm0, %mm0
; X86-SSE-NEXT:    movq %mm0, (%esp)
; X86-SSE-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-SSE-NEXT:    packsswb %xmm0, %xmm0
; X86-SSE-NEXT:    movd %xmm0, %eax
; X86-SSE-NEXT:    movl %ebp, %esp
; X86-SSE-NEXT:    popl %ebp
; X86-SSE-NEXT:    retl
;
; X86-AVX-LABEL: PR29222:
; X86-AVX:       # %bb.0:
; X86-AVX-NEXT:    pushl %ebp
; X86-AVX-NEXT:    movl %esp, %ebp
; X86-AVX-NEXT:    andl $-8, %esp
; X86-AVX-NEXT:    subl $8, %esp
; X86-AVX-NEXT:    movd 8(%ebp), %mm0
; X86-AVX-NEXT:    pshufw $68, %mm0, %mm0 # mm0 = mm0[0,1,0,1]
; X86-AVX-NEXT:    packsswb %mm0, %mm0
; X86-AVX-NEXT:    movq %mm0, (%esp)
; X86-AVX-NEXT:    vpbroadcastq (%esp), %xmm0
; X86-AVX-NEXT:    vpacksswb %xmm0, %xmm0, %xmm0
; X86-AVX-NEXT:    vmovd %xmm0, %eax
; X86-AVX-NEXT:    movl %ebp, %esp
; X86-AVX-NEXT:    popl %ebp
; X86-AVX-NEXT:    retl
;
; X64-SSE-LABEL: PR29222:
; X64-SSE:       # %bb.0:
; X64-SSE-NEXT:    movd %edi, %mm0
; X64-SSE-NEXT:    pshufw $68, %mm0, %mm0 # mm0 = mm0[0,1,0,1]
; X64-SSE-NEXT:    packsswb %mm0, %mm0
; X64-SSE-NEXT:    movq2dq %mm0, %xmm0
; X64-SSE-NEXT:    packsswb %xmm0, %xmm0
; X64-SSE-NEXT:    movd %xmm0, %eax
; X64-SSE-NEXT:    retq
;
; X64-AVX-LABEL: PR29222:
; X64-AVX:       # %bb.0:
; X64-AVX-NEXT:    movd %edi, %mm0
; X64-AVX-NEXT:    pshufw $68, %mm0, %mm0 # mm0 = mm0[0,1,0,1]
; X64-AVX-NEXT:    packsswb %mm0, %mm0
; X64-AVX-NEXT:    movq %mm0, %rax
; X64-AVX-NEXT:    vmovq %rax, %xmm0
; X64-AVX-NEXT:    vpbroadcastq %xmm0, %xmm0
; X64-AVX-NEXT:    vpacksswb %xmm0, %xmm0, %xmm0
; X64-AVX-NEXT:    vmovd %xmm0, %eax
; X64-AVX-NEXT:    retq
  %2 = insertelement <2 x i32> undef, i32 %0, i32 0
  %3 = shufflevector <2 x i32> %2, <2 x i32> undef, <2 x i32> zeroinitializer
  %4 = bitcast <2 x i32> %3 to <1 x i64>
  %5 = tail call <1 x i64> @llvm.x86.mmx.packsswb(<1 x i64> %4, <1 x i64> %4)
  %6 = bitcast <1 x i64> %5 to i64
  %7 = insertelement <2 x i64> undef, i64 %6, i32 0
  %8 = bitcast <2 x i64> %7 to <8 x i16>
  %9 = tail call <16 x i8> @llvm.x86.sse2.packsswb.128(<8 x i16> %8, <8 x i16> undef)
  %10 = bitcast <16 x i8> %9 to <4 x i32>
  %11 = extractelement <4 x i32> %10, i32 0
  ret i32 %11
}

declare <1 x i64> @llvm.x86.mmx.packsswb(<1 x i64>, <1 x i64>)
declare <16 x i8> @llvm.x86.sse2.packsswb.128(<8 x i16>, <8 x i16>)
