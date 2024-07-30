; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-linux -mcpu=penryn | FileCheck %s --check-prefixes=CHECK,X64
; RUN: llc < %s -mtriple=i386-linux-gnu -mcpu=yonah | FileCheck %s --check-prefixes=CHECK,X86

; PR7518
define void @test1(<2 x float> %Q, ptr%P2) nounwind {
; X64-LABEL: test1:
; X64:       # %bb.0:
; X64-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; X64-NEXT:    addss %xmm0, %xmm1
; X64-NEXT:    movss %xmm1, (%rdi)
; X64-NEXT:    retq
;
; X86-LABEL: test1:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movshdup {{.*#+}} xmm1 = xmm0[1,1,3,3]
; X86-NEXT:    addss %xmm0, %xmm1
; X86-NEXT:    movss %xmm1, (%eax)
; X86-NEXT:    retl
  %a = extractelement <2 x float> %Q, i32 0
  %b = extractelement <2 x float> %Q, i32 1
  %c = fadd float %a, %b
  store float %c, ptr %P2
  ret void
}

define <2 x float> @test2(<2 x float> %Q, <2 x float> %R, ptr%P) nounwind {
; CHECK-LABEL: test2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addps %xmm1, %xmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %Z = fadd <2 x float> %Q, %R
  ret <2 x float> %Z
}

define <2 x float> @test3(<4 x float> %A) nounwind {
; CHECK-LABEL: test3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addps %xmm0, %xmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %B = shufflevector <4 x float> %A, <4 x float> undef, <2 x i32> <i32 0, i32 1>
  %C = fadd <2 x float> %B, %B
  ret <2 x float> %C
}

define <2 x float> @test4(<2 x float> %A) nounwind {
; CHECK-LABEL: test4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addps %xmm0, %xmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %C = fadd <2 x float> %A, %A
  ret <2 x float> %C
}

define <4 x float> @test5(<4 x float> %A) nounwind {
; CHECK-LABEL: test5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addps %xmm0, %xmm0
; CHECK-NEXT:    addps %xmm0, %xmm0
; CHECK-NEXT:    ret{{[l|q]}}
  %B = shufflevector <4 x float> %A, <4 x float> undef, <2 x i32> <i32 0, i32 1>
  %C = fadd <2 x float> %B, %B
  br label %BB

BB:
  %D = fadd <2 x float> %C, %C
  %E = shufflevector <2 x float> %D, <2 x float> undef, <4 x i32> <i32 0, i32 1, i32 undef, i32 undef>
  ret <4 x float> %E
}

