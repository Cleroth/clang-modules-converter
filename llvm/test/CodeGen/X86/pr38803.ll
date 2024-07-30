; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mcpu=skylake-avx512 -mtriple=x86_64-unknown-unknown | FileCheck %s

@b = dso_local local_unnamed_addr global i32 0, align 4
@c = dso_local local_unnamed_addr global i32 0, align 4
@d = dso_local local_unnamed_addr global float 0.000000e+00, align 4

define dso_local float @_Z3fn2v() {
; CHECK-LABEL: _Z3fn2v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    pushq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    callq _Z1av@PLT
; CHECK-NEXT:    # kill: def $al killed $al def $eax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    vmovss {{.*#+}} xmm0 {%k1} {z} = [7.5E-1,0.0E+0,0.0E+0,0.0E+0]
; CHECK-NEXT:    cmpl $0, c(%rip)
; CHECK-NEXT:    je .LBB0_2
; CHECK-NEXT:  # %bb.1: # %if.then
; CHECK-NEXT:    vcvtsi2ssl b(%rip), %xmm1, %xmm1
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    vxorps %xmm2, %xmm2, %xmm2
; CHECK-NEXT:    vmovss %xmm2, %xmm1, %xmm1 {%k1}
; CHECK-NEXT:    vmovss %xmm1, d(%rip)
; CHECK-NEXT:  .LBB0_2: # %if.end
; CHECK-NEXT:    popq %rax
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    retq
entry:
  %call = tail call zeroext i1 @_Z1av()
  %cond = select i1 %call, float 7.500000e-01, float 0.000000e+00
  %0 = load i32, ptr @c, align 4
  %tobool2 = icmp eq i32 %0, 0
  br i1 %tobool2, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %1 = load i32, ptr @b, align 4
  %2 = sitofp i32 %1 to float
  %conv5 = select i1 %call, float 0.000000e+00, float %2
  store float %conv5, ptr @d, align 4
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret float %cond
}

declare zeroext i1 @_Z1av()
