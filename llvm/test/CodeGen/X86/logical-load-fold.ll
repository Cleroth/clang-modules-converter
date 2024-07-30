; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=sse2,sse-unaligned-mem | FileCheck %s --check-prefix=SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=avx                    | FileCheck %s --check-prefix=AVX

; Although we have the ability to fold an unaligned load with AVX
; and under special conditions with some SSE implementations, we
; can not fold the load under any circumstances in these test
; cases because they are not 16-byte loads. The load must be
; executed as a scalar ('movs*') with a zero extension to
; 128-bits and then used in the packed logical ('andp*') op.
; PR22371 - http://llvm.org/bugs/show_bug.cgi?id=22371

define double @load_double_no_fold(double %x, double %y) {
; SSE2-LABEL: load_double_no_fold:
; SSE2:       # %bb.0:
; SSE2-NEXT:    cmplesd %xmm0, %xmm1
; SSE2-NEXT:    movsd {{.*#+}} xmm0 = [1.0E+0,0.0E+0]
; SSE2-NEXT:    andpd %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; AVX-LABEL: load_double_no_fold:
; AVX:       # %bb.0:
; AVX-NEXT:    vcmplesd %xmm0, %xmm1, %xmm0
; AVX-NEXT:    vmovsd {{.*#+}} xmm1 = [1.0E+0,0.0E+0]
; AVX-NEXT:    vandpd %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq

  %cmp = fcmp oge double %x, %y
  %zext = zext i1 %cmp to i32
  %conv = sitofp i32 %zext to double
  ret double %conv
}

define float @load_float_no_fold(float %x, float %y) {
; SSE2-LABEL: load_float_no_fold:
; SSE2:       # %bb.0:
; SSE2-NEXT:    cmpless %xmm0, %xmm1
; SSE2-NEXT:    movss {{.*#+}} xmm0 = [1.0E+0,0.0E+0,0.0E+0,0.0E+0]
; SSE2-NEXT:    andps %xmm1, %xmm0
; SSE2-NEXT:    retq
;
; AVX-LABEL: load_float_no_fold:
; AVX:       # %bb.0:
; AVX-NEXT:    vcmpless %xmm0, %xmm1, %xmm0
; AVX-NEXT:    vmovss {{.*#+}} xmm1 = [1.0E+0,0.0E+0,0.0E+0,0.0E+0]
; AVX-NEXT:    vandps %xmm1, %xmm0, %xmm0
; AVX-NEXT:    retq

  %cmp = fcmp oge float %x, %y
  %zext = zext i1 %cmp to i32
  %conv = sitofp i32 %zext to float
  ret float %conv
}

