; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

define half @use_coshf16(half %a) nounwind {
; CHECK-LABEL: use_coshf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    callq __extendhfsf2@PLT
; CHECK-NEXT:    callq coshf@PLT
; CHECK-NEXT:    callq __truncsfhf2@PLT
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    retq
  %x = call half @llvm.cosh.f16(half %a)
  ret half %x
}

define float @use_coshf32(float %a) nounwind {
; CHECK-LABEL: use_coshf32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    jmp coshf@PLT # TAILCALL
  %x = call float @llvm.cosh.f32(float %a)
  ret float %x
}

define double @use_coshf64(double %a) nounwind {
; CHECK-LABEL: use_coshf64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    jmp cosh@PLT # TAILCALL
  %x = call double @llvm.cosh.f64(double %a)
  ret double %x
}

define x86_fp80 @use_coshf80(x86_fp80 %a) nounwind {
; CHECK-LABEL: use_coshf80:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq $24, %rsp
; CHECK-NEXT:    fldt 32(%rsp)
; CHECK-NEXT:    fstpt (%rsp)
; CHECK-NEXT:    callq coshl@PLT
; CHECK-NEXT:    addq  $24, %rsp
; CHECK-NEXT:    retq
  %x = call x86_fp80 @llvm.cosh.f80(x86_fp80 %a)
  ret x86_fp80 %x
}

define fp128 @use_coshfp128(fp128 %a) nounwind {
; CHECK-LABEL: use_coshfp128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    jmp  coshf128@PLT # TAILCALL
  %x = call fp128 @llvm.cosh.f128(fp128 %a)
  ret fp128 %x
}

define ppc_fp128 @use_coshppc_fp128(ppc_fp128 %a) nounwind {
; CHECK-LABEL: use_coshppc_fp128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    callq coshl@PLT
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    retq
  %x = call ppc_fp128 @llvm.cosh.ppcf128(ppc_fp128 %a)
  ret ppc_fp128 %x
}

declare half @llvm.cosh.f16(half)
declare float @llvm.cosh.f32(float)
declare double @llvm.cosh.f64(double)
declare x86_fp80 @llvm.cosh.f80(x86_fp80)
declare fp128 @llvm.cosh.f128(fp128)
declare ppc_fp128 @llvm.cosh.ppcf128(ppc_fp128)