; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64 | FileCheck %s --check-prefixes=CHECK,CHECK-CVT
; RUN: llc < %s -mtriple=aarch64 -mattr=+fullfp16 | FileCheck %s --check-prefixes=CHECK,CHECK-FP16

; i32 saturate

define i32 @stest_f64i32(double %x) {
; CHECK-LABEL: stest_f64i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w0, d0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i64
  %0 = icmp slt i64 %conv, 2147483647
  %spec.store.select = select i1 %0, i64 %conv, i64 2147483647
  %1 = icmp sgt i64 %spec.store.select, -2147483648
  %spec.store.select7 = select i1 %1, i64 %spec.store.select, i64 -2147483648
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @utest_f64i32(double %x) {
; CHECK-LABEL: utest_f64i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
entry:
  %conv = fptoui double %x to i64
  %0 = icmp ult i64 %conv, 4294967295
  %spec.store.select = select i1 %0, i64 %conv, i64 4294967295
  %conv6 = trunc i64 %spec.store.select to i32
  ret i32 %conv6
}

define i32 @ustest_f64i32(double %x) {
; CHECK-LABEL: ustest_f64i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i64
  %0 = icmp slt i64 %conv, 4294967295
  %spec.store.select = select i1 %0, i64 %conv, i64 4294967295
  %1 = icmp sgt i64 %spec.store.select, 0
  %spec.store.select7 = select i1 %1, i64 %spec.store.select, i64 0
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @stest_f32i32(float %x) {
; CHECK-LABEL: stest_f32i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w0, s0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i64
  %0 = icmp slt i64 %conv, 2147483647
  %spec.store.select = select i1 %0, i64 %conv, i64 2147483647
  %1 = icmp sgt i64 %spec.store.select, -2147483648
  %spec.store.select7 = select i1 %1, i64 %spec.store.select, i64 -2147483648
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @utest_f32i32(float %x) {
; CHECK-LABEL: utest_f32i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
entry:
  %conv = fptoui float %x to i64
  %0 = icmp ult i64 %conv, 4294967295
  %spec.store.select = select i1 %0, i64 %conv, i64 4294967295
  %conv6 = trunc i64 %spec.store.select to i32
  ret i32 %conv6
}

define i32 @ustest_f32i32(float %x) {
; CHECK-LABEL: ustest_f32i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i64
  %0 = icmp slt i64 %conv, 4294967295
  %spec.store.select = select i1 %0, i64 %conv, i64 4294967295
  %1 = icmp sgt i64 %spec.store.select, 0
  %spec.store.select7 = select i1 %1, i64 %spec.store.select, i64 0
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @stest_f16i32(half %x) {
; CHECK-CVT-LABEL: stest_f16i32:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    fcvtzs w0, s0
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: stest_f16i32:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzs w0, h0
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i64
  %0 = icmp slt i64 %conv, 2147483647
  %spec.store.select = select i1 %0, i64 %conv, i64 2147483647
  %1 = icmp sgt i64 %spec.store.select, -2147483648
  %spec.store.select7 = select i1 %1, i64 %spec.store.select, i64 -2147483648
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @utesth_f16i32(half %x) {
; CHECK-CVT-LABEL: utesth_f16i32:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    fcvtzu w0, s0
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: utesth_f16i32:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzu w0, h0
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptoui half %x to i64
  %0 = icmp ult i64 %conv, 4294967295
  %spec.store.select = select i1 %0, i64 %conv, i64 4294967295
  %conv6 = trunc i64 %spec.store.select to i32
  ret i32 %conv6
}

define i32 @ustest_f16i32(half %x) {
; CHECK-CVT-LABEL: ustest_f16i32:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    fcvtzu w0, s0
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: ustest_f16i32:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzu w0, h0
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i64
  %0 = icmp slt i64 %conv, 4294967295
  %spec.store.select = select i1 %0, i64 %conv, i64 4294967295
  %1 = icmp sgt i64 %spec.store.select, 0
  %spec.store.select7 = select i1 %1, i64 %spec.store.select, i64 0
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

; i16 saturate

define i16 @stest_f64i16(double %x) {
; CHECK-LABEL: stest_f64i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w8, d0
; CHECK-NEXT:    mov w9, #32767 // =0x7fff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w8, w8, w9, lt
; CHECK-NEXT:    mov w9, #-32768 // =0xffff8000
; CHECK-NEXT:    cmn w8, #8, lsl #12 // =32768
; CHECK-NEXT:    csel w0, w8, w9, gt
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i32
  %0 = icmp slt i32 %conv, 32767
  %spec.store.select = select i1 %0, i32 %conv, i32 32767
  %1 = icmp sgt i32 %spec.store.select, -32768
  %spec.store.select7 = select i1 %1, i32 %spec.store.select, i32 -32768
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @utest_f64i16(double %x) {
; CHECK-LABEL: utest_f64i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w8, d0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
entry:
  %conv = fptoui double %x to i32
  %0 = icmp ult i32 %conv, 65535
  %spec.store.select = select i1 %0, i32 %conv, i32 65535
  %conv6 = trunc i32 %spec.store.select to i16
  ret i16 %conv6
}

define i16 @ustest_f64i16(double %x) {
; CHECK-LABEL: ustest_f64i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w8, d0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w8, w8, w9, lt
; CHECK-NEXT:    bic w0, w8, w8, asr #31
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i32
  %0 = icmp slt i32 %conv, 65535
  %spec.store.select = select i1 %0, i32 %conv, i32 65535
  %1 = icmp sgt i32 %spec.store.select, 0
  %spec.store.select7 = select i1 %1, i32 %spec.store.select, i32 0
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @stest_f32i16(float %x) {
; CHECK-LABEL: stest_f32i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w8, s0
; CHECK-NEXT:    mov w9, #32767 // =0x7fff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w8, w8, w9, lt
; CHECK-NEXT:    mov w9, #-32768 // =0xffff8000
; CHECK-NEXT:    cmn w8, #8, lsl #12 // =32768
; CHECK-NEXT:    csel w0, w8, w9, gt
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i32
  %0 = icmp slt i32 %conv, 32767
  %spec.store.select = select i1 %0, i32 %conv, i32 32767
  %1 = icmp sgt i32 %spec.store.select, -32768
  %spec.store.select7 = select i1 %1, i32 %spec.store.select, i32 -32768
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @utest_f32i16(float %x) {
; CHECK-LABEL: utest_f32i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w8, s0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
entry:
  %conv = fptoui float %x to i32
  %0 = icmp ult i32 %conv, 65535
  %spec.store.select = select i1 %0, i32 %conv, i32 65535
  %conv6 = trunc i32 %spec.store.select to i16
  ret i16 %conv6
}

define i16 @ustest_f32i16(float %x) {
; CHECK-LABEL: ustest_f32i16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w8, s0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w8, w8, w9, lt
; CHECK-NEXT:    bic w0, w8, w8, asr #31
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i32
  %0 = icmp slt i32 %conv, 65535
  %spec.store.select = select i1 %0, i32 %conv, i32 65535
  %1 = icmp sgt i32 %spec.store.select, 0
  %spec.store.select7 = select i1 %1, i32 %spec.store.select, i32 0
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @stest_f16i16(half %x) {
; CHECK-CVT-LABEL: stest_f16i16:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    mov w9, #32767 // =0x7fff
; CHECK-CVT-NEXT:    fcvtzs w8, s0
; CHECK-CVT-NEXT:    cmp w8, w9
; CHECK-CVT-NEXT:    csel w8, w8, w9, lt
; CHECK-CVT-NEXT:    mov w9, #-32768 // =0xffff8000
; CHECK-CVT-NEXT:    cmn w8, #8, lsl #12 // =32768
; CHECK-CVT-NEXT:    csel w0, w8, w9, gt
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: stest_f16i16:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzs w8, h0
; CHECK-FP16-NEXT:    mov w9, #32767 // =0x7fff
; CHECK-FP16-NEXT:    cmp w8, w9
; CHECK-FP16-NEXT:    csel w8, w8, w9, lt
; CHECK-FP16-NEXT:    mov w9, #-32768 // =0xffff8000
; CHECK-FP16-NEXT:    cmn w8, #8, lsl #12 // =32768
; CHECK-FP16-NEXT:    csel w0, w8, w9, gt
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i32
  %0 = icmp slt i32 %conv, 32767
  %spec.store.select = select i1 %0, i32 %conv, i32 32767
  %1 = icmp sgt i32 %spec.store.select, -32768
  %spec.store.select7 = select i1 %1, i32 %spec.store.select, i32 -32768
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @utesth_f16i16(half %x) {
; CHECK-CVT-LABEL: utesth_f16i16:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    mov w9, #65535 // =0xffff
; CHECK-CVT-NEXT:    fcvtzu w8, s0
; CHECK-CVT-NEXT:    cmp w8, w9
; CHECK-CVT-NEXT:    csel w0, w8, w9, lo
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: utesth_f16i16:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzu w8, h0
; CHECK-FP16-NEXT:    mov w9, #65535 // =0xffff
; CHECK-FP16-NEXT:    cmp w8, w9
; CHECK-FP16-NEXT:    csel w0, w8, w9, lo
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptoui half %x to i32
  %0 = icmp ult i32 %conv, 65535
  %spec.store.select = select i1 %0, i32 %conv, i32 65535
  %conv6 = trunc i32 %spec.store.select to i16
  ret i16 %conv6
}

define i16 @ustest_f16i16(half %x) {
; CHECK-CVT-LABEL: ustest_f16i16:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    mov w9, #65535 // =0xffff
; CHECK-CVT-NEXT:    fcvtzs w8, s0
; CHECK-CVT-NEXT:    cmp w8, w9
; CHECK-CVT-NEXT:    csel w8, w8, w9, lt
; CHECK-CVT-NEXT:    bic w0, w8, w8, asr #31
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: ustest_f16i16:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzs w8, h0
; CHECK-FP16-NEXT:    mov w9, #65535 // =0xffff
; CHECK-FP16-NEXT:    cmp w8, w9
; CHECK-FP16-NEXT:    csel w8, w8, w9, lt
; CHECK-FP16-NEXT:    bic w0, w8, w8, asr #31
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i32
  %0 = icmp slt i32 %conv, 65535
  %spec.store.select = select i1 %0, i32 %conv, i32 65535
  %1 = icmp sgt i32 %spec.store.select, 0
  %spec.store.select7 = select i1 %1, i32 %spec.store.select, i32 0
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

; i64 saturate

define i64 @stest_f64i64(double %x) {
; CHECK-LABEL: stest_f64i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs x0, d0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i128
  %0 = icmp slt i128 %conv, 9223372036854775807
  %spec.store.select = select i1 %0, i128 %conv, i128 9223372036854775807
  %1 = icmp sgt i128 %spec.store.select, -9223372036854775808
  %spec.store.select7 = select i1 %1, i128 %spec.store.select, i128 -9223372036854775808
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @utest_f64i64(double %x) {
; CHECK-LABEL: utest_f64i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixunsdfti
; CHECK-NEXT:    cmp x1, #0
; CHECK-NEXT:    csel x0, x0, xzr, eq
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptoui double %x to i128
  %0 = icmp ult i128 %conv, 18446744073709551616
  %spec.store.select = select i1 %0, i128 %conv, i128 18446744073709551616
  %conv6 = trunc i128 %spec.store.select to i64
  ret i64 %conv6
}

define i64 @ustest_f64i64(double %x) {
; CHECK-LABEL: ustest_f64i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixdfti
; CHECK-NEXT:    cmp x1, #1
; CHECK-NEXT:    csel x8, x0, xzr, lt
; CHECK-NEXT:    csinc x9, x1, xzr, lt
; CHECK-NEXT:    cmp xzr, x8
; CHECK-NEXT:    ngcs xzr, x9
; CHECK-NEXT:    csel x0, x8, xzr, lt
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i128
  %0 = icmp slt i128 %conv, 18446744073709551616
  %spec.store.select = select i1 %0, i128 %conv, i128 18446744073709551616
  %1 = icmp sgt i128 %spec.store.select, 0
  %spec.store.select7 = select i1 %1, i128 %spec.store.select, i128 0
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @stest_f32i64(float %x) {
; CHECK-LABEL: stest_f32i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs x0, s0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i128
  %0 = icmp slt i128 %conv, 9223372036854775807
  %spec.store.select = select i1 %0, i128 %conv, i128 9223372036854775807
  %1 = icmp sgt i128 %spec.store.select, -9223372036854775808
  %spec.store.select7 = select i1 %1, i128 %spec.store.select, i128 -9223372036854775808
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @utest_f32i64(float %x) {
; CHECK-LABEL: utest_f32i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixunssfti
; CHECK-NEXT:    cmp x1, #0
; CHECK-NEXT:    csel x0, x0, xzr, eq
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptoui float %x to i128
  %0 = icmp ult i128 %conv, 18446744073709551616
  %spec.store.select = select i1 %0, i128 %conv, i128 18446744073709551616
  %conv6 = trunc i128 %spec.store.select to i64
  ret i64 %conv6
}

define i64 @ustest_f32i64(float %x) {
; CHECK-LABEL: ustest_f32i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixsfti
; CHECK-NEXT:    cmp x1, #1
; CHECK-NEXT:    csel x8, x0, xzr, lt
; CHECK-NEXT:    csinc x9, x1, xzr, lt
; CHECK-NEXT:    cmp xzr, x8
; CHECK-NEXT:    ngcs xzr, x9
; CHECK-NEXT:    csel x0, x8, xzr, lt
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i128
  %0 = icmp slt i128 %conv, 18446744073709551616
  %spec.store.select = select i1 %0, i128 %conv, i128 18446744073709551616
  %1 = icmp sgt i128 %spec.store.select, 0
  %spec.store.select7 = select i1 %1, i128 %spec.store.select, i128 0
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @stest_f16i64(half %x) {
; CHECK-CVT-LABEL: stest_f16i64:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    fcvtzs x0, s0
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: stest_f16i64:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzs x0, h0
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i128
  %0 = icmp slt i128 %conv, 9223372036854775807
  %spec.store.select = select i1 %0, i128 %conv, i128 9223372036854775807
  %1 = icmp sgt i128 %spec.store.select, -9223372036854775808
  %spec.store.select7 = select i1 %1, i128 %spec.store.select, i128 -9223372036854775808
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @utesth_f16i64(half %x) {
; CHECK-LABEL: utesth_f16i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixunshfti
; CHECK-NEXT:    cmp x1, #0
; CHECK-NEXT:    csel x0, x0, xzr, eq
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptoui half %x to i128
  %0 = icmp ult i128 %conv, 18446744073709551616
  %spec.store.select = select i1 %0, i128 %conv, i128 18446744073709551616
  %conv6 = trunc i128 %spec.store.select to i64
  ret i64 %conv6
}

define i64 @ustest_f16i64(half %x) {
; CHECK-LABEL: ustest_f16i64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixhfti
; CHECK-NEXT:    cmp x1, #1
; CHECK-NEXT:    csel x8, x0, xzr, lt
; CHECK-NEXT:    csinc x9, x1, xzr, lt
; CHECK-NEXT:    cmp xzr, x8
; CHECK-NEXT:    ngcs xzr, x9
; CHECK-NEXT:    csel x0, x8, xzr, lt
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptosi half %x to i128
  %0 = icmp slt i128 %conv, 18446744073709551616
  %spec.store.select = select i1 %0, i128 %conv, i128 18446744073709551616
  %1 = icmp sgt i128 %spec.store.select, 0
  %spec.store.select7 = select i1 %1, i128 %spec.store.select, i128 0
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}



; i32 saturate

define i32 @stest_f64i32_mm(double %x) {
; CHECK-LABEL: stest_f64i32_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w0, d0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i64
  %spec.store.select = call i64 @llvm.smin.i64(i64 %conv, i64 2147483647)
  %spec.store.select7 = call i64 @llvm.smax.i64(i64 %spec.store.select, i64 -2147483648)
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @utest_f64i32_mm(double %x) {
; CHECK-LABEL: utest_f64i32_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
entry:
  %conv = fptoui double %x to i64
  %spec.store.select = call i64 @llvm.umin.i64(i64 %conv, i64 4294967295)
  %conv6 = trunc i64 %spec.store.select to i32
  ret i32 %conv6
}

define i32 @ustest_f64i32_mm(double %x) {
; CHECK-LABEL: ustest_f64i32_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w0, d0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i64
  %spec.store.select = call i64 @llvm.smin.i64(i64 %conv, i64 4294967295)
  %spec.store.select7 = call i64 @llvm.smax.i64(i64 %spec.store.select, i64 0)
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @stest_f32i32_mm(float %x) {
; CHECK-LABEL: stest_f32i32_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w0, s0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i64
  %spec.store.select = call i64 @llvm.smin.i64(i64 %conv, i64 2147483647)
  %spec.store.select7 = call i64 @llvm.smax.i64(i64 %spec.store.select, i64 -2147483648)
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @utest_f32i32_mm(float %x) {
; CHECK-LABEL: utest_f32i32_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
entry:
  %conv = fptoui float %x to i64
  %spec.store.select = call i64 @llvm.umin.i64(i64 %conv, i64 4294967295)
  %conv6 = trunc i64 %spec.store.select to i32
  ret i32 %conv6
}

define i32 @ustest_f32i32_mm(float %x) {
; CHECK-LABEL: ustest_f32i32_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w0, s0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i64
  %spec.store.select = call i64 @llvm.smin.i64(i64 %conv, i64 4294967295)
  %spec.store.select7 = call i64 @llvm.smax.i64(i64 %spec.store.select, i64 0)
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @stest_f16i32_mm(half %x) {
; CHECK-CVT-LABEL: stest_f16i32_mm:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    fcvtzs w0, s0
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: stest_f16i32_mm:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzs w0, h0
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i64
  %spec.store.select = call i64 @llvm.smin.i64(i64 %conv, i64 2147483647)
  %spec.store.select7 = call i64 @llvm.smax.i64(i64 %spec.store.select, i64 -2147483648)
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

define i32 @utesth_f16i32_mm(half %x) {
; CHECK-CVT-LABEL: utesth_f16i32_mm:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    fcvtzu w0, s0
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: utesth_f16i32_mm:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzu w0, h0
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptoui half %x to i64
  %spec.store.select = call i64 @llvm.umin.i64(i64 %conv, i64 4294967295)
  %conv6 = trunc i64 %spec.store.select to i32
  ret i32 %conv6
}

define i32 @ustest_f16i32_mm(half %x) {
; CHECK-CVT-LABEL: ustest_f16i32_mm:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    fcvtzu w0, s0
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: ustest_f16i32_mm:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzu w0, h0
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i64
  %spec.store.select = call i64 @llvm.smin.i64(i64 %conv, i64 4294967295)
  %spec.store.select7 = call i64 @llvm.smax.i64(i64 %spec.store.select, i64 0)
  %conv6 = trunc i64 %spec.store.select7 to i32
  ret i32 %conv6
}

; i16 saturate

define i16 @stest_f64i16_mm(double %x) {
; CHECK-LABEL: stest_f64i16_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w8, d0
; CHECK-NEXT:    mov w9, #32767 // =0x7fff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w8, w8, w9, lt
; CHECK-NEXT:    mov w9, #-32768 // =0xffff8000
; CHECK-NEXT:    cmn w8, #8, lsl #12 // =32768
; CHECK-NEXT:    csel w0, w8, w9, gt
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i32
  %spec.store.select = call i32 @llvm.smin.i32(i32 %conv, i32 32767)
  %spec.store.select7 = call i32 @llvm.smax.i32(i32 %spec.store.select, i32 -32768)
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @utest_f64i16_mm(double %x) {
; CHECK-LABEL: utest_f64i16_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w8, d0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
entry:
  %conv = fptoui double %x to i32
  %spec.store.select = call i32 @llvm.umin.i32(i32 %conv, i32 65535)
  %conv6 = trunc i32 %spec.store.select to i16
  ret i16 %conv6
}

define i16 @ustest_f64i16_mm(double %x) {
; CHECK-LABEL: ustest_f64i16_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w8, d0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w8, w8, w9, lt
; CHECK-NEXT:    bic w0, w8, w8, asr #31
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i32
  %spec.store.select = call i32 @llvm.smin.i32(i32 %conv, i32 65535)
  %spec.store.select7 = call i32 @llvm.smax.i32(i32 %spec.store.select, i32 0)
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @stest_f32i16_mm(float %x) {
; CHECK-LABEL: stest_f32i16_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w8, s0
; CHECK-NEXT:    mov w9, #32767 // =0x7fff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w8, w8, w9, lt
; CHECK-NEXT:    mov w9, #-32768 // =0xffff8000
; CHECK-NEXT:    cmn w8, #8, lsl #12 // =32768
; CHECK-NEXT:    csel w0, w8, w9, gt
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i32
  %spec.store.select = call i32 @llvm.smin.i32(i32 %conv, i32 32767)
  %spec.store.select7 = call i32 @llvm.smax.i32(i32 %spec.store.select, i32 -32768)
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @utest_f32i16_mm(float %x) {
; CHECK-LABEL: utest_f32i16_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzu w8, s0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w0, w8, w9, lo
; CHECK-NEXT:    ret
entry:
  %conv = fptoui float %x to i32
  %spec.store.select = call i32 @llvm.umin.i32(i32 %conv, i32 65535)
  %conv6 = trunc i32 %spec.store.select to i16
  ret i16 %conv6
}

define i16 @ustest_f32i16_mm(float %x) {
; CHECK-LABEL: ustest_f32i16_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs w8, s0
; CHECK-NEXT:    mov w9, #65535 // =0xffff
; CHECK-NEXT:    cmp w8, w9
; CHECK-NEXT:    csel w8, w8, w9, lt
; CHECK-NEXT:    bic w0, w8, w8, asr #31
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i32
  %spec.store.select = call i32 @llvm.smin.i32(i32 %conv, i32 65535)
  %spec.store.select7 = call i32 @llvm.smax.i32(i32 %spec.store.select, i32 0)
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @stest_f16i16_mm(half %x) {
; CHECK-CVT-LABEL: stest_f16i16_mm:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    mov w9, #32767 // =0x7fff
; CHECK-CVT-NEXT:    fcvtzs w8, s0
; CHECK-CVT-NEXT:    cmp w8, w9
; CHECK-CVT-NEXT:    csel w8, w8, w9, lt
; CHECK-CVT-NEXT:    mov w9, #-32768 // =0xffff8000
; CHECK-CVT-NEXT:    cmn w8, #8, lsl #12 // =32768
; CHECK-CVT-NEXT:    csel w0, w8, w9, gt
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: stest_f16i16_mm:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzs w8, h0
; CHECK-FP16-NEXT:    mov w9, #32767 // =0x7fff
; CHECK-FP16-NEXT:    cmp w8, w9
; CHECK-FP16-NEXT:    csel w8, w8, w9, lt
; CHECK-FP16-NEXT:    mov w9, #-32768 // =0xffff8000
; CHECK-FP16-NEXT:    cmn w8, #8, lsl #12 // =32768
; CHECK-FP16-NEXT:    csel w0, w8, w9, gt
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i32
  %spec.store.select = call i32 @llvm.smin.i32(i32 %conv, i32 32767)
  %spec.store.select7 = call i32 @llvm.smax.i32(i32 %spec.store.select, i32 -32768)
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

define i16 @utesth_f16i16_mm(half %x) {
; CHECK-CVT-LABEL: utesth_f16i16_mm:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    mov w9, #65535 // =0xffff
; CHECK-CVT-NEXT:    fcvtzu w8, s0
; CHECK-CVT-NEXT:    cmp w8, w9
; CHECK-CVT-NEXT:    csel w0, w8, w9, lo
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: utesth_f16i16_mm:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzu w8, h0
; CHECK-FP16-NEXT:    mov w9, #65535 // =0xffff
; CHECK-FP16-NEXT:    cmp w8, w9
; CHECK-FP16-NEXT:    csel w0, w8, w9, lo
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptoui half %x to i32
  %spec.store.select = call i32 @llvm.umin.i32(i32 %conv, i32 65535)
  %conv6 = trunc i32 %spec.store.select to i16
  ret i16 %conv6
}

define i16 @ustest_f16i16_mm(half %x) {
; CHECK-CVT-LABEL: ustest_f16i16_mm:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    mov w9, #65535 // =0xffff
; CHECK-CVT-NEXT:    fcvtzs w8, s0
; CHECK-CVT-NEXT:    cmp w8, w9
; CHECK-CVT-NEXT:    csel w8, w8, w9, lt
; CHECK-CVT-NEXT:    bic w0, w8, w8, asr #31
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: ustest_f16i16_mm:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzs w8, h0
; CHECK-FP16-NEXT:    mov w9, #65535 // =0xffff
; CHECK-FP16-NEXT:    cmp w8, w9
; CHECK-FP16-NEXT:    csel w8, w8, w9, lt
; CHECK-FP16-NEXT:    bic w0, w8, w8, asr #31
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i32
  %spec.store.select = call i32 @llvm.smin.i32(i32 %conv, i32 65535)
  %spec.store.select7 = call i32 @llvm.smax.i32(i32 %spec.store.select, i32 0)
  %conv6 = trunc i32 %spec.store.select7 to i16
  ret i16 %conv6
}

; i64 saturate

define i64 @stest_f64i64_mm(double %x) {
; CHECK-LABEL: stest_f64i64_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs x0, d0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i128
  %spec.store.select = call i128 @llvm.smin.i128(i128 %conv, i128 9223372036854775807)
  %spec.store.select7 = call i128 @llvm.smax.i128(i128 %spec.store.select, i128 -9223372036854775808)
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @utest_f64i64_mm(double %x) {
; CHECK-LABEL: utest_f64i64_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixunsdfti
; CHECK-NEXT:    cmp x1, #0
; CHECK-NEXT:    csel x0, x0, xzr, eq
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptoui double %x to i128
  %spec.store.select = call i128 @llvm.umin.i128(i128 %conv, i128 18446744073709551616)
  %conv6 = trunc i128 %spec.store.select to i64
  ret i64 %conv6
}

define i64 @ustest_f64i64_mm(double %x) {
; CHECK-LABEL: ustest_f64i64_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixdfti
; CHECK-NEXT:    cmp x1, #1
; CHECK-NEXT:    csinc x8, x1, xzr, lt
; CHECK-NEXT:    csel x9, x0, xzr, lt
; CHECK-NEXT:    cmp x8, #0
; CHECK-NEXT:    csel x0, xzr, x9, lt
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptosi double %x to i128
  %spec.store.select = call i128 @llvm.smin.i128(i128 %conv, i128 18446744073709551616)
  %spec.store.select7 = call i128 @llvm.smax.i128(i128 %spec.store.select, i128 0)
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @stest_f32i64_mm(float %x) {
; CHECK-LABEL: stest_f32i64_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvtzs x0, s0
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i128
  %spec.store.select = call i128 @llvm.smin.i128(i128 %conv, i128 9223372036854775807)
  %spec.store.select7 = call i128 @llvm.smax.i128(i128 %spec.store.select, i128 -9223372036854775808)
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @utest_f32i64_mm(float %x) {
; CHECK-LABEL: utest_f32i64_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixunssfti
; CHECK-NEXT:    cmp x1, #0
; CHECK-NEXT:    csel x0, x0, xzr, eq
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptoui float %x to i128
  %spec.store.select = call i128 @llvm.umin.i128(i128 %conv, i128 18446744073709551616)
  %conv6 = trunc i128 %spec.store.select to i64
  ret i64 %conv6
}

define i64 @ustest_f32i64_mm(float %x) {
; CHECK-LABEL: ustest_f32i64_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixsfti
; CHECK-NEXT:    cmp x1, #1
; CHECK-NEXT:    csinc x8, x1, xzr, lt
; CHECK-NEXT:    csel x9, x0, xzr, lt
; CHECK-NEXT:    cmp x8, #0
; CHECK-NEXT:    csel x0, xzr, x9, lt
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptosi float %x to i128
  %spec.store.select = call i128 @llvm.smin.i128(i128 %conv, i128 18446744073709551616)
  %spec.store.select7 = call i128 @llvm.smax.i128(i128 %spec.store.select, i128 0)
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @stest_f16i64_mm(half %x) {
; CHECK-CVT-LABEL: stest_f16i64_mm:
; CHECK-CVT:       // %bb.0: // %entry
; CHECK-CVT-NEXT:    fcvt s0, h0
; CHECK-CVT-NEXT:    fcvtzs x0, s0
; CHECK-CVT-NEXT:    ret
;
; CHECK-FP16-LABEL: stest_f16i64_mm:
; CHECK-FP16:       // %bb.0: // %entry
; CHECK-FP16-NEXT:    fcvtzs x0, h0
; CHECK-FP16-NEXT:    ret
entry:
  %conv = fptosi half %x to i128
  %spec.store.select = call i128 @llvm.smin.i128(i128 %conv, i128 9223372036854775807)
  %spec.store.select7 = call i128 @llvm.smax.i128(i128 %spec.store.select, i128 -9223372036854775808)
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

define i64 @utesth_f16i64_mm(half %x) {
; CHECK-LABEL: utesth_f16i64_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixunshfti
; CHECK-NEXT:    cmp x1, #0
; CHECK-NEXT:    csel x0, x0, xzr, eq
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptoui half %x to i128
  %spec.store.select = call i128 @llvm.umin.i128(i128 %conv, i128 18446744073709551616)
  %conv6 = trunc i128 %spec.store.select to i64
  ret i64 %conv6
}

define i64 @ustest_f16i64_mm(half %x) {
; CHECK-LABEL: ustest_f16i64_mm:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -16
; CHECK-NEXT:    bl __fixhfti
; CHECK-NEXT:    cmp x1, #1
; CHECK-NEXT:    csinc x8, x1, xzr, lt
; CHECK-NEXT:    csel x9, x0, xzr, lt
; CHECK-NEXT:    cmp x8, #0
; CHECK-NEXT:    csel x0, xzr, x9, lt
; CHECK-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %conv = fptosi half %x to i128
  %spec.store.select = call i128 @llvm.smin.i128(i128 %conv, i128 18446744073709551616)
  %spec.store.select7 = call i128 @llvm.smax.i128(i128 %spec.store.select, i128 0)
  %conv6 = trunc i128 %spec.store.select7 to i64
  ret i64 %conv6
}

declare i32 @llvm.smin.i32(i32, i32)
declare i32 @llvm.smax.i32(i32, i32)
declare i32 @llvm.umin.i32(i32, i32)
declare i64 @llvm.smin.i64(i64, i64)
declare i64 @llvm.smax.i64(i64, i64)
declare i64 @llvm.umin.i64(i64, i64)
declare i128 @llvm.smin.i128(i128, i128)
declare i128 @llvm.smax.i128(i128, i128)
declare i128 @llvm.umin.i128(i128, i128)
