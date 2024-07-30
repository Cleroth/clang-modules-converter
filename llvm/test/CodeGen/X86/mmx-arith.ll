; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+mmx,+sse2 | FileCheck -check-prefix=X86 %s
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+mmx,+sse2 | FileCheck -check-prefix=X64 %s

;; A basic functional check to make sure that MMX arithmetic actually compiles.
;; First is a straight translation of the original with bitcasts as needed.

define void @test0(ptr %A, ptr %B) nounwind {
; X86-LABEL: test0:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    paddb %xmm0, %xmm1
; X86-NEXT:    movdq2q %xmm1, %mm0
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    paddsb (%ecx), %mm0
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    paddusb (%ecx), %mm0
; X86-NEXT:    movq2dq %mm0, %xmm0
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    psubb %xmm1, %xmm0
; X86-NEXT:    movdq2q %xmm0, %mm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    psubsb (%ecx), %mm0
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    psubusb (%ecx), %mm0
; X86-NEXT:    movq2dq %mm0, %xmm0
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; X86-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; X86-NEXT:    pmullw %xmm0, %xmm1
; X86-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}, %xmm1
; X86-NEXT:    packuswb %xmm1, %xmm1
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    pand %xmm1, %xmm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    por %xmm0, %xmm1
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    pxor %xmm1, %xmm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    emms
; X86-NEXT:    retl
;
; X64-LABEL: test0:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    paddb %xmm0, %xmm1
; X64-NEXT:    movdq2q %xmm1, %mm0
; X64-NEXT:    movq %xmm1, (%rdi)
; X64-NEXT:    paddsb (%rsi), %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    paddusb (%rsi), %mm0
; X64-NEXT:    movq2dq %mm0, %xmm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    psubb %xmm1, %xmm0
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    movq %xmm0, (%rdi)
; X64-NEXT:    psubsb (%rsi), %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    psubusb (%rsi), %mm0
; X64-NEXT:    movq2dq %mm0, %xmm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    punpcklbw {{.*#+}} xmm0 = xmm0[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; X64-NEXT:    punpcklbw {{.*#+}} xmm1 = xmm1[0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7]
; X64-NEXT:    pmullw %xmm0, %xmm1
; X64-NEXT:    pand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; X64-NEXT:    packuswb %xmm1, %xmm1
; X64-NEXT:    movq %xmm1, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    pand %xmm1, %xmm0
; X64-NEXT:    movq %xmm0, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    por %xmm0, %xmm1
; X64-NEXT:    movq %xmm1, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    pxor %xmm1, %xmm0
; X64-NEXT:    movq %xmm0, (%rdi)
; X64-NEXT:    emms
; X64-NEXT:    retq
entry:
  %tmp1 = load <1 x i64>, ptr %A
  %tmp3 = load <1 x i64>, ptr %B
  %tmp1a = bitcast <1 x i64> %tmp1 to <8 x i8>
  %tmp3a = bitcast <1 x i64> %tmp3 to <8 x i8>
  %tmp4 = add <8 x i8> %tmp1a, %tmp3a
  %tmp4a = bitcast <8 x i8> %tmp4 to <1 x i64>
  store <1 x i64> %tmp4a, ptr %A
  %tmp7 = load <1 x i64>, ptr %B
  %tmp12 = tail call <1 x i64> @llvm.x86.mmx.padds.b(<1 x i64> %tmp4a, <1 x i64> %tmp7)
  store <1 x i64> %tmp12, ptr %A
  %tmp16 = load <1 x i64>, ptr %B
  %tmp21 = tail call <1 x i64> @llvm.x86.mmx.paddus.b(<1 x i64> %tmp12, <1 x i64> %tmp16)
  store <1 x i64> %tmp21, ptr %A
  %tmp27 = load <1 x i64>, ptr %B
  %tmp21a = bitcast <1 x i64> %tmp21 to <8 x i8>
  %tmp27a = bitcast <1 x i64> %tmp27 to <8 x i8>
  %tmp28 = sub <8 x i8> %tmp21a, %tmp27a
  %tmp28a = bitcast <8 x i8> %tmp28 to <1 x i64>
  store <1 x i64> %tmp28a, ptr %A
  %tmp31 = load <1 x i64>, ptr %B
  %tmp36 = tail call <1 x i64> @llvm.x86.mmx.psubs.b(<1 x i64> %tmp28a, <1 x i64> %tmp31)
  store <1 x i64> %tmp36, ptr %A
  %tmp40 = load <1 x i64>, ptr %B
  %tmp45 = tail call <1 x i64> @llvm.x86.mmx.psubus.b(<1 x i64> %tmp36, <1 x i64> %tmp40)
  store <1 x i64> %tmp45, ptr %A
  %tmp51 = load <1 x i64>, ptr %B
  %tmp45a = bitcast <1 x i64> %tmp45 to <8 x i8>
  %tmp51a = bitcast <1 x i64> %tmp51 to <8 x i8>
  %tmp52 = mul <8 x i8> %tmp45a, %tmp51a
  %tmp52a = bitcast <8 x i8> %tmp52 to <1 x i64>
  store <1 x i64> %tmp52a, ptr %A
  %tmp57 = load <1 x i64>, ptr %B
  %tmp57a = bitcast <1 x i64> %tmp57 to <8 x i8>
  %tmp58 = and <8 x i8> %tmp52, %tmp57a
  %tmp58a = bitcast <8 x i8> %tmp58 to <1 x i64>
  store <1 x i64> %tmp58a, ptr %A
  %tmp63 = load <1 x i64>, ptr %B
  %tmp63a = bitcast <1 x i64> %tmp63 to <8 x i8>
  %tmp64 = or <8 x i8> %tmp58, %tmp63a
  %tmp64a = bitcast <8 x i8> %tmp64 to <1 x i64>
  store <1 x i64> %tmp64a, ptr %A
  %tmp69 = load <1 x i64>, ptr %B
  %tmp69a = bitcast <1 x i64> %tmp69 to <8 x i8>
  %tmp64b = bitcast <1 x i64> %tmp64a to <8 x i8>
  %tmp70 = xor <8 x i8> %tmp64b, %tmp69a
  %tmp70a = bitcast <8 x i8> %tmp70 to <1 x i64>
  store <1 x i64> %tmp70a, ptr %A
  tail call void @llvm.x86.mmx.emms()
  ret void
}

define void @test1(ptr %A, ptr %B) nounwind {
; X86-LABEL: test1:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    paddd %xmm1, %xmm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,3,3]
; X86-NEXT:    pmuludq %xmm1, %xmm0
; X86-NEXT:    shufps {{.*#+}} xmm1 = xmm1[1,1,1,1]
; X86-NEXT:    pmuludq %xmm1, %xmm2
; X86-NEXT:    pshufd {{.*#+}} xmm1 = xmm2[0,2,2,3]
; X86-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; X86-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    pand %xmm0, %xmm1
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    por %xmm1, %xmm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    pxor %xmm0, %xmm1
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    emms
; X86-NEXT:    retl
;
; X64-LABEL: test1:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    paddd %xmm0, %xmm1
; X64-NEXT:    movq %xmm1, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    pshufd {{.*#+}} xmm2 = xmm1[1,1,3,3]
; X64-NEXT:    pmuludq %xmm0, %xmm1
; X64-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[1,1,3,3]
; X64-NEXT:    pmuludq %xmm2, %xmm0
; X64-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; X64-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; X64-NEXT:    movq %xmm1, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    pand %xmm1, %xmm0
; X64-NEXT:    movq %xmm0, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    por %xmm0, %xmm1
; X64-NEXT:    movq %xmm1, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    pxor %xmm1, %xmm0
; X64-NEXT:    movq %xmm0, (%rdi)
; X64-NEXT:    emms
; X64-NEXT:    retq
entry:
  %tmp1 = load <1 x i64>, ptr %A
  %tmp3 = load <1 x i64>, ptr %B
  %tmp1a = bitcast <1 x i64> %tmp1 to <2 x i32>
  %tmp3a = bitcast <1 x i64> %tmp3 to <2 x i32>
  %tmp4 = add <2 x i32> %tmp1a, %tmp3a
  %tmp4a = bitcast <2 x i32> %tmp4 to <1 x i64>
  store <1 x i64> %tmp4a, ptr %A
  %tmp9 = load <1 x i64>, ptr %B
  %tmp9a = bitcast <1 x i64> %tmp9 to <2 x i32>
  %tmp10 = sub <2 x i32> %tmp4, %tmp9a
  %tmp10a = bitcast <2 x i32> %tmp4 to <1 x i64>
  store <1 x i64> %tmp10a, ptr %A
  %tmp15 = load <1 x i64>, ptr %B
  %tmp10b = bitcast <1 x i64> %tmp10a to <2 x i32>
  %tmp15a = bitcast <1 x i64> %tmp15 to <2 x i32>
  %tmp16 = mul <2 x i32> %tmp10b, %tmp15a
  %tmp16a = bitcast <2 x i32> %tmp16 to <1 x i64>
  store <1 x i64> %tmp16a, ptr %A
  %tmp21 = load <1 x i64>, ptr %B
  %tmp16b = bitcast <1 x i64> %tmp16a to <2 x i32>
  %tmp21a = bitcast <1 x i64> %tmp21 to <2 x i32>
  %tmp22 = and <2 x i32> %tmp16b, %tmp21a
  %tmp22a = bitcast <2 x i32> %tmp22 to <1 x i64>
  store <1 x i64> %tmp22a, ptr %A
  %tmp27 = load <1 x i64>, ptr %B
  %tmp22b = bitcast <1 x i64> %tmp22a to <2 x i32>
  %tmp27a = bitcast <1 x i64> %tmp27 to <2 x i32>
  %tmp28 = or <2 x i32> %tmp22b, %tmp27a
  %tmp28a = bitcast <2 x i32> %tmp28 to <1 x i64>
  store <1 x i64> %tmp28a, ptr %A
  %tmp33 = load <1 x i64>, ptr %B
  %tmp28b = bitcast <1 x i64> %tmp28a to <2 x i32>
  %tmp33a = bitcast <1 x i64> %tmp33 to <2 x i32>
  %tmp34 = xor <2 x i32> %tmp28b, %tmp33a
  %tmp34a = bitcast <2 x i32> %tmp34 to <1 x i64>
  store <1 x i64> %tmp34a, ptr %A
  tail call void @llvm.x86.mmx.emms( )
  ret void
}

define void @test2(ptr %A, ptr %B) nounwind {
; X86-LABEL: test2:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    pushl %esi
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $16, %esp
; X86-NEXT:    movl 12(%ebp), %ecx
; X86-NEXT:    movl 8(%ebp), %eax
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    paddw %xmm0, %xmm1
; X86-NEXT:    movdq2q %xmm1, %mm0
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    paddsw (%ecx), %mm0
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    paddusw (%ecx), %mm0
; X86-NEXT:    movq2dq %mm0, %xmm0
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    psubw %xmm1, %xmm0
; X86-NEXT:    movdq2q %xmm0, %mm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    psubsw (%ecx), %mm0
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    psubusw (%ecx), %mm0
; X86-NEXT:    movq2dq %mm0, %xmm0
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    pmullw %xmm0, %xmm1
; X86-NEXT:    movdq2q %xmm1, %mm0
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    pmulhw (%ecx), %mm0
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    pmaddwd (%ecx), %mm0
; X86-NEXT:    movq %mm0, (%esp)
; X86-NEXT:    movl (%esp), %edx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X86-NEXT:    movq %mm0, (%eax)
; X86-NEXT:    andl 4(%ecx), %esi
; X86-NEXT:    movd %esi, %xmm0
; X86-NEXT:    andl (%ecx), %edx
; X86-NEXT:    movd %edx, %xmm1
; X86-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    por %xmm1, %xmm0
; X86-NEXT:    movq %xmm0, (%eax)
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    pxor %xmm0, %xmm1
; X86-NEXT:    movq %xmm1, (%eax)
; X86-NEXT:    emms
; X86-NEXT:    leal -4(%ebp), %esp
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: test2:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    paddw %xmm0, %xmm1
; X64-NEXT:    movdq2q %xmm1, %mm0
; X64-NEXT:    movq %xmm1, (%rdi)
; X64-NEXT:    paddsw (%rsi), %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    paddusw (%rsi), %mm0
; X64-NEXT:    movq2dq %mm0, %xmm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    psubw %xmm1, %xmm0
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    movq %xmm0, (%rdi)
; X64-NEXT:    psubsw (%rsi), %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    psubusw (%rsi), %mm0
; X64-NEXT:    movq2dq %mm0, %xmm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    pmullw %xmm0, %xmm1
; X64-NEXT:    movdq2q %xmm1, %mm0
; X64-NEXT:    movq %xmm1, (%rdi)
; X64-NEXT:    pmulhw (%rsi), %mm0
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    pmaddwd (%rsi), %mm0
; X64-NEXT:    movq %mm0, %rax
; X64-NEXT:    movq %mm0, (%rdi)
; X64-NEXT:    andq (%rsi), %rax
; X64-NEXT:    movq %rax, %xmm0
; X64-NEXT:    movq %rax, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X64-NEXT:    por %xmm0, %xmm1
; X64-NEXT:    movq %xmm1, (%rdi)
; X64-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X64-NEXT:    pxor %xmm1, %xmm0
; X64-NEXT:    movq %xmm0, (%rdi)
; X64-NEXT:    emms
; X64-NEXT:    retq
entry:
  %tmp1 = load <1 x i64>, ptr %A
  %tmp3 = load <1 x i64>, ptr %B
  %tmp1a = bitcast <1 x i64> %tmp1 to <4 x i16>
  %tmp3a = bitcast <1 x i64> %tmp3 to <4 x i16>
  %tmp4 = add <4 x i16> %tmp1a, %tmp3a
  %tmp4a = bitcast <4 x i16> %tmp4 to <1 x i64>
  store <1 x i64> %tmp4a, ptr %A
  %tmp7 = load <1 x i64>, ptr %B
  %tmp12 = tail call <1 x i64> @llvm.x86.mmx.padds.w(<1 x i64> %tmp4a, <1 x i64> %tmp7)
  store <1 x i64> %tmp12, ptr %A
  %tmp16 = load <1 x i64>, ptr %B
  %tmp21 = tail call <1 x i64> @llvm.x86.mmx.paddus.w(<1 x i64> %tmp12, <1 x i64> %tmp16)
  store <1 x i64> %tmp21, ptr %A
  %tmp27 = load <1 x i64>, ptr %B
  %tmp21a = bitcast <1 x i64> %tmp21 to <4 x i16>
  %tmp27a = bitcast <1 x i64> %tmp27 to <4 x i16>
  %tmp28 = sub <4 x i16> %tmp21a, %tmp27a
  %tmp28a = bitcast <4 x i16> %tmp28 to <1 x i64>
  store <1 x i64> %tmp28a, ptr %A
  %tmp31 = load <1 x i64>, ptr %B
  %tmp36 = tail call <1 x i64> @llvm.x86.mmx.psubs.w(<1 x i64> %tmp28a, <1 x i64> %tmp31)
  store <1 x i64> %tmp36, ptr %A
  %tmp40 = load <1 x i64>, ptr %B
  %tmp45 = tail call <1 x i64> @llvm.x86.mmx.psubus.w(<1 x i64> %tmp36, <1 x i64> %tmp40)
  store <1 x i64> %tmp45, ptr %A
  %tmp51 = load <1 x i64>, ptr %B
  %tmp45a = bitcast <1 x i64> %tmp45 to <4 x i16>
  %tmp51a = bitcast <1 x i64> %tmp51 to <4 x i16>
  %tmp52 = mul <4 x i16> %tmp45a, %tmp51a
  %tmp52a = bitcast <4 x i16> %tmp52 to <1 x i64>
  store <1 x i64> %tmp52a, ptr %A
  %tmp55 = load <1 x i64>, ptr %B
  %tmp60 = tail call <1 x i64> @llvm.x86.mmx.pmulh.w(<1 x i64> %tmp52a, <1 x i64> %tmp55)
  store <1 x i64> %tmp60, ptr %A
  %tmp64 = load <1 x i64>, ptr %B
  %tmp69 = tail call <1 x i64> @llvm.x86.mmx.pmadd.wd(<1 x i64> %tmp60, <1 x i64> %tmp64)
  store <1 x i64> %tmp69, ptr %A
  %tmp75 = load <1 x i64>, ptr %B
  %tmp70a = bitcast <1 x i64> %tmp69 to <4 x i16>
  %tmp75a = bitcast <1 x i64> %tmp75 to <4 x i16>
  %tmp76 = and <4 x i16> %tmp70a, %tmp75a
  %tmp76a = bitcast <4 x i16> %tmp76 to <1 x i64>
  store <1 x i64> %tmp76a, ptr %A
  %tmp81 = load <1 x i64>, ptr %B
  %tmp76b = bitcast <1 x i64> %tmp76a to <4 x i16>
  %tmp81a = bitcast <1 x i64> %tmp81 to <4 x i16>
  %tmp82 = or <4 x i16> %tmp76b, %tmp81a
  %tmp82a = bitcast <4 x i16> %tmp82 to <1 x i64>
  store <1 x i64> %tmp82a, ptr %A
  %tmp87 = load <1 x i64>, ptr %B
  %tmp82b = bitcast <1 x i64> %tmp82a to <4 x i16>
  %tmp87a = bitcast <1 x i64> %tmp87 to <4 x i16>
  %tmp88 = xor <4 x i16> %tmp82b, %tmp87a
  %tmp88a = bitcast <4 x i16> %tmp88 to <1 x i64>
  store <1 x i64> %tmp88a, ptr %A
  tail call void @llvm.x86.mmx.emms( )
  ret void
}

define <1 x i64> @test3(ptr %a, ptr %b, i32 %count) nounwind {
; X86-LABEL: test3:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %ebp
; X86-NEXT:    pushl %ebx
; X86-NEXT:    pushl %edi
; X86-NEXT:    pushl %esi
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    testl %ecx, %ecx
; X86-NEXT:    je .LBB3_1
; X86-NEXT:  # %bb.2: # %bb26.preheader
; X86-NEXT:    xorl %ebx, %ebx
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:    .p2align 4, 0x90
; X86-NEXT:  .LBB3_3: # %bb26
; X86-NEXT:    # =>This Inner Loop Header: Depth=1
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    movl (%edi,%ebx,8), %ebp
; X86-NEXT:    movl %ecx, %esi
; X86-NEXT:    movl 4(%edi,%ebx,8), %ecx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edi
; X86-NEXT:    addl (%edi,%ebx,8), %ebp
; X86-NEXT:    adcl 4(%edi,%ebx,8), %ecx
; X86-NEXT:    addl %ebp, %eax
; X86-NEXT:    adcl %ecx, %edx
; X86-NEXT:    movl %esi, %ecx
; X86-NEXT:    incl %ebx
; X86-NEXT:    cmpl %esi, %ebx
; X86-NEXT:    jb .LBB3_3
; X86-NEXT:    jmp .LBB3_4
; X86-NEXT:  .LBB3_1:
; X86-NEXT:    xorl %eax, %eax
; X86-NEXT:    xorl %edx, %edx
; X86-NEXT:  .LBB3_4: # %bb31
; X86-NEXT:    popl %esi
; X86-NEXT:    popl %edi
; X86-NEXT:    popl %ebx
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: test3:
; X64:       # %bb.0: # %entry
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    testl %edx, %edx
; X64-NEXT:    je .LBB3_2
; X64-NEXT:    .p2align 4, 0x90
; X64-NEXT:  .LBB3_1: # %bb26
; X64-NEXT:    # =>This Inner Loop Header: Depth=1
; X64-NEXT:    movslq %ecx, %rcx
; X64-NEXT:    movq (%rdi,%rcx,8), %r8
; X64-NEXT:    addq (%rsi,%rcx,8), %r8
; X64-NEXT:    addq %r8, %rax
; X64-NEXT:    incl %ecx
; X64-NEXT:    cmpl %edx, %ecx
; X64-NEXT:    jb .LBB3_1
; X64-NEXT:  .LBB3_2: # %bb31
; X64-NEXT:    retq
entry:
  %tmp2942 = icmp eq i32 %count, 0
  br i1 %tmp2942, label %bb31, label %bb26

bb26:
  %i.037.0 = phi i32 [ 0, %entry ], [ %tmp25, %bb26 ]
  %sum.035.0 = phi <1 x i64> [ zeroinitializer, %entry ], [ %tmp22, %bb26 ]
  %tmp13 = getelementptr <1 x i64>, ptr %b, i32 %i.037.0
  %tmp14 = load <1 x i64>, ptr %tmp13
  %tmp18 = getelementptr <1 x i64>, ptr %a, i32 %i.037.0
  %tmp19 = load <1 x i64>, ptr %tmp18
  %tmp21 = add <1 x i64> %tmp19, %tmp14
  %tmp22 = add <1 x i64> %tmp21, %sum.035.0
  %tmp25 = add i32 %i.037.0, 1
  %tmp29 = icmp ult i32 %tmp25, %count
  br i1 %tmp29, label %bb26, label %bb31

bb31:
  %sum.035.1 = phi <1 x i64> [ zeroinitializer, %entry ], [ %tmp22, %bb26 ]
  ret <1 x i64> %sum.035.1
}

; There are no MMX operations here, so we use XMM or i64.
define void @ti8(double %a, double %b) nounwind {
; X86-LABEL: ti8:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    paddb %xmm0, %xmm1
; X86-NEXT:    movq %xmm1, 0
; X86-NEXT:    retl
;
; X64-LABEL: ti8:
; X64:       # %bb.0: # %entry
; X64-NEXT:    paddb %xmm1, %xmm0
; X64-NEXT:    movq %xmm0, 0
; X64-NEXT:    retq
entry:
  %tmp1 = bitcast double %a to <8 x i8>
  %tmp2 = bitcast double %b to <8 x i8>
  %tmp3 = add <8 x i8> %tmp1, %tmp2
  store <8 x i8> %tmp3, ptr null
  ret void
}

define void @ti16(double %a, double %b) nounwind {
; X86-LABEL: ti16:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    paddw %xmm0, %xmm1
; X86-NEXT:    movq %xmm1, 0
; X86-NEXT:    retl
;
; X64-LABEL: ti16:
; X64:       # %bb.0: # %entry
; X64-NEXT:    paddw %xmm1, %xmm0
; X64-NEXT:    movq %xmm0, 0
; X64-NEXT:    retq
entry:
  %tmp1 = bitcast double %a to <4 x i16>
  %tmp2 = bitcast double %b to <4 x i16>
  %tmp3 = add <4 x i16> %tmp1, %tmp2
  store <4 x i16> %tmp3, ptr null
  ret void
}

define void @ti32(double %a, double %b) nounwind {
; X86-LABEL: ti32:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movq {{.*#+}} xmm0 = mem[0],zero
; X86-NEXT:    movq {{.*#+}} xmm1 = mem[0],zero
; X86-NEXT:    paddd %xmm0, %xmm1
; X86-NEXT:    movq %xmm1, 0
; X86-NEXT:    retl
;
; X64-LABEL: ti32:
; X64:       # %bb.0: # %entry
; X64-NEXT:    paddd %xmm1, %xmm0
; X64-NEXT:    movq %xmm0, 0
; X64-NEXT:    retq
entry:
  %tmp1 = bitcast double %a to <2 x i32>
  %tmp2 = bitcast double %b to <2 x i32>
  %tmp3 = add <2 x i32> %tmp1, %tmp2
  store <2 x i32> %tmp3, ptr null
  ret void
}

define void @ti64(double %a, double %b) nounwind {
; X86-LABEL: ti64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    addl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    adcl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movl %eax, 0
; X86-NEXT:    movl %ecx, 4
; X86-NEXT:    retl
;
; X64-LABEL: ti64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq %xmm0, %rax
; X64-NEXT:    movq %xmm1, %rcx
; X64-NEXT:    addq %rax, %rcx
; X64-NEXT:    movq %rcx, 0
; X64-NEXT:    retq
entry:
  %tmp1 = bitcast double %a to <1 x i64>
  %tmp2 = bitcast double %b to <1 x i64>
  %tmp3 = add <1 x i64> %tmp1, %tmp2
  store <1 x i64> %tmp3, ptr null
  ret void
}

; MMX intrinsics calls get us MMX instructions.
define void @ti8a(double %a, double %b) nounwind {
; X86-LABEL: ti8a:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddb {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    movq %mm0, 0
; X86-NEXT:    retl
;
; X64-LABEL: ti8a:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    movdq2q %xmm1, %mm1
; X64-NEXT:    paddb %mm0, %mm1
; X64-NEXT:    movq %mm1, 0
; X64-NEXT:    retq
entry:
  %tmp1 = bitcast double %a to <1 x i64>
  %tmp2 = bitcast double %b to <1 x i64>
  %tmp3 = tail call <1 x i64> @llvm.x86.mmx.padd.b(<1 x i64> %tmp1, <1 x i64> %tmp2)
  store <1 x i64> %tmp3, ptr null
  ret void
}

define void @ti16a(double %a, double %b) nounwind {
; X86-LABEL: ti16a:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddw {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    movq %mm0, 0
; X86-NEXT:    retl
;
; X64-LABEL: ti16a:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    movdq2q %xmm1, %mm1
; X64-NEXT:    paddw %mm0, %mm1
; X64-NEXT:    movq %mm1, 0
; X64-NEXT:    retq
entry:
  %tmp1 = bitcast double %a to <1 x i64>
  %tmp2 = bitcast double %b to <1 x i64>
  %tmp3 = tail call <1 x i64> @llvm.x86.mmx.padd.w(<1 x i64> %tmp1, <1 x i64> %tmp2)
  store <1 x i64> %tmp3, ptr null
  ret void
}

define void @ti32a(double %a, double %b) nounwind {
; X86-LABEL: ti32a:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddd {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    movq %mm0, 0
; X86-NEXT:    retl
;
; X64-LABEL: ti32a:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    movdq2q %xmm1, %mm1
; X64-NEXT:    paddd %mm0, %mm1
; X64-NEXT:    movq %mm1, 0
; X64-NEXT:    retq
entry:
  %tmp1 = bitcast double %a to <1 x i64>
  %tmp2 = bitcast double %b to <1 x i64>
  %tmp3 = tail call <1 x i64> @llvm.x86.mmx.padd.d(<1 x i64> %tmp1, <1 x i64> %tmp2)
  store <1 x i64> %tmp3, ptr null
  ret void
}

define void @ti64a(double %a, double %b) nounwind {
; X86-LABEL: ti64a:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    paddq {{[0-9]+}}(%esp), %mm0
; X86-NEXT:    movq %mm0, 0
; X86-NEXT:    retl
;
; X64-LABEL: ti64a:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movdq2q %xmm0, %mm0
; X64-NEXT:    movdq2q %xmm1, %mm1
; X64-NEXT:    paddq %mm0, %mm1
; X64-NEXT:    movq %mm1, 0
; X64-NEXT:    retq
entry:
  %tmp1 = bitcast double %a to <1 x i64>
  %tmp2 = bitcast double %b to <1 x i64>
  %tmp3 = tail call <1 x i64> @llvm.x86.mmx.padd.q(<1 x i64> %tmp1, <1 x i64> %tmp2)
  store <1 x i64> %tmp3, ptr null
  ret void
}

; Make sure we clamp large shift amounts to 255
define i64 @pr43922() nounwind {
; X86-LABEL: pr43922:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %ebp
; X86-NEXT:    movl %esp, %ebp
; X86-NEXT:    andl $-8, %esp
; X86-NEXT:    subl $8, %esp
; X86-NEXT:    movq {{\.?LCPI[0-9]+_[0-9]+}}, %mm0 # mm0 = 0x7AAAAAAA7AAAAAAA
; X86-NEXT:    psrad $255, %mm0
; X86-NEXT:    movq %mm0, (%esp)
; X86-NEXT:    movl (%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movl %ebp, %esp
; X86-NEXT:    popl %ebp
; X86-NEXT:    retl
;
; X64-LABEL: pr43922:
; X64:       # %bb.0: # %entry
; X64-NEXT:    movq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %mm0 # mm0 = 0x7AAAAAAA7AAAAAAA
; X64-NEXT:    psrad $255, %mm0
; X64-NEXT:    movq %mm0, %rax
; X64-NEXT:    retq
entry:
  %0 = tail call <1 x i64> @llvm.x86.mmx.psrai.d(<1 x i64> bitcast (<2 x i32> <i32 2058005162, i32 2058005162> to <1 x i64>), i32 268435456)
  %1 = bitcast <1 x i64> %0 to i64
  ret i64 %1
}
declare <1 x i64> @llvm.x86.mmx.psrai.d(<1 x i64>, i32)

declare <1 x i64> @llvm.x86.mmx.padd.b(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.padd.w(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.padd.d(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.padd.q(<1 x i64>, <1 x i64>)

declare <1 x i64> @llvm.x86.mmx.paddus.b(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.psubus.b(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.paddus.w(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.psubus.w(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.pmulh.w(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.pmadd.wd(<1 x i64>, <1 x i64>)

declare void @llvm.x86.mmx.emms()

declare <1 x i64> @llvm.x86.mmx.padds.b(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.padds.w(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.psubs.b(<1 x i64>, <1 x i64>)
declare <1 x i64> @llvm.x86.mmx.psubs.w(<1 x i64>, <1 x i64>)

