; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=aarch64 | FileCheck %s
; RUN: llc < %s -mtriple=aarch64 -global-isel | FileCheck %s

define i32 @testmsws(float %x) {
; CHECK-LABEL: testmsws:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    frintx s0, s0
; CHECK-NEXT:    fcvtzs x0, s0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
entry:
  %0 = tail call i64 @llvm.lrint.i64.f32(float %x)
  %conv = trunc i64 %0 to i32
  ret i32 %conv
}

define i64 @testmsxs(float %x) {
; CHECK-LABEL: testmsxs:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    frintx s0, s0
; CHECK-NEXT:    fcvtzs x0, s0
; CHECK-NEXT:    ret
entry:
  %0 = tail call i64 @llvm.lrint.i64.f32(float %x)
  ret i64 %0
}

define i32 @testmswd(double %x) {
; CHECK-LABEL: testmswd:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    frintx d0, d0
; CHECK-NEXT:    fcvtzs x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
entry:
  %0 = tail call i64 @llvm.lrint.i64.f64(double %x)
  %conv = trunc i64 %0 to i32
  ret i32 %conv
}

define i64 @testmsxd(double %x) {
; CHECK-LABEL: testmsxd:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    frintx d0, d0
; CHECK-NEXT:    fcvtzs x0, d0
; CHECK-NEXT:    ret
entry:
  %0 = tail call i64 @llvm.lrint.i64.f64(double %x)
  ret i64 %0
}

define dso_local i32 @testmswl(fp128 %x) {
; CHECK-LABEL: testmswl:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl lrintl
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %0 = tail call i64 @llvm.lrint.i64.f128(fp128 %x)
  %conv = trunc i64 %0 to i32
  ret i32 %conv
}

define dso_local i64 @testmsll(fp128 %x) {
; CHECK-LABEL: testmsll:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    b lrintl
entry:
  %0 = tail call i64 @llvm.lrint.i64.f128(fp128 %x)
  ret i64 %0
}

declare i64 @llvm.lrint.i64.f32(float) nounwind readnone
declare i64 @llvm.lrint.i64.f64(double) nounwind readnone
declare i64 @llvm.lrint.i64.f128(fp128) nounwind readnone
