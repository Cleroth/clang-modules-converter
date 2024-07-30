; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 -mattr=+sve < %s | FileCheck %s

declare void @bar(ptr)

define void @foo(<vscale x 4 x i64> %dst, i1 %cond) {
; CHECK-LABEL: foo:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    tbz w0, #0, .LBB0_2
; CHECK-NEXT:  // %bb.1: // %if.then
; CHECK-NEXT:    stp x29, x30, [sp, #-32]! // 16-byte Folded Spill
; CHECK-NEXT:    stp x28, x19, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    mov x29, sp
; CHECK-NEXT:    addvl sp, sp, #-18
; CHECK-NEXT:    str p15, [sp, #4, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p14, [sp, #5, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p13, [sp, #6, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p12, [sp, #7, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p11, [sp, #8, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p10, [sp, #9, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p9, [sp, #10, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p8, [sp, #11, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p7, [sp, #12, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p6, [sp, #13, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p5, [sp, #14, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str p4, [sp, #15, mul vl] // 2-byte Folded Spill
; CHECK-NEXT:    str z23, [sp, #2, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z22, [sp, #3, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z21, [sp, #4, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z20, [sp, #5, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z19, [sp, #6, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z18, [sp, #7, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z17, [sp, #8, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z16, [sp, #9, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z15, [sp, #10, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z14, [sp, #11, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z13, [sp, #12, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z12, [sp, #13, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z11, [sp, #14, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z10, [sp, #15, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z9, [sp, #16, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    str z8, [sp, #17, mul vl] // 16-byte Folded Spill
; CHECK-NEXT:    mov x19, sp
; CHECK-NEXT:    .cfi_def_cfa w29, 32
; CHECK-NEXT:    .cfi_offset w19, -8
; CHECK-NEXT:    .cfi_offset w28, -16
; CHECK-NEXT:    .cfi_offset w30, -24
; CHECK-NEXT:    .cfi_offset w29, -32
; CHECK-NEXT:    .cfi_escape 0x10, 0x48, 0x0a, 0x11, 0x60, 0x22, 0x11, 0x78, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d8 @ cfa - 32 - 8 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x49, 0x0a, 0x11, 0x60, 0x22, 0x11, 0x70, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d9 @ cfa - 32 - 16 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4a, 0x0a, 0x11, 0x60, 0x22, 0x11, 0x68, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d10 @ cfa - 32 - 24 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4b, 0x0a, 0x11, 0x60, 0x22, 0x11, 0x60, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d11 @ cfa - 32 - 32 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4c, 0x0a, 0x11, 0x60, 0x22, 0x11, 0x58, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d12 @ cfa - 32 - 40 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4d, 0x0a, 0x11, 0x60, 0x22, 0x11, 0x50, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d13 @ cfa - 32 - 48 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4e, 0x0a, 0x11, 0x60, 0x22, 0x11, 0x48, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d14 @ cfa - 32 - 56 * VG
; CHECK-NEXT:    .cfi_escape 0x10, 0x4f, 0x0a, 0x11, 0x60, 0x22, 0x11, 0x40, 0x92, 0x2e, 0x00, 0x1e, 0x22 // $d15 @ cfa - 32 - 64 * VG
; CHECK-NEXT:    rdvl x9, #2
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    add x9, x9, #15
; CHECK-NEXT:    and x9, x9, #0xfffffffffffffff0
; CHECK-NEXT:    sub x8, x8, x9
; CHECK-NEXT:    and x0, x8, #0xffffffffffffffe0
; CHECK-NEXT:    mov sp, x0
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z1.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    bl bar
; CHECK-NEXT:    addvl sp, x29, #-18
; CHECK-NEXT:    ldr z23, [sp, #2, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z22, [sp, #3, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z21, [sp, #4, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z20, [sp, #5, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z19, [sp, #6, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z18, [sp, #7, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z17, [sp, #8, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z16, [sp, #9, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z15, [sp, #10, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z14, [sp, #11, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z13, [sp, #12, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z12, [sp, #13, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z11, [sp, #14, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z10, [sp, #15, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z9, [sp, #16, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr z8, [sp, #17, mul vl] // 16-byte Folded Reload
; CHECK-NEXT:    ldr p15, [sp, #4, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p14, [sp, #5, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p13, [sp, #6, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p12, [sp, #7, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p11, [sp, #8, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p10, [sp, #9, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p9, [sp, #10, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p8, [sp, #11, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p7, [sp, #12, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p6, [sp, #13, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p5, [sp, #14, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    ldr p4, [sp, #15, mul vl] // 2-byte Folded Reload
; CHECK-NEXT:    mov sp, x29
; CHECK-NEXT:    ldp x28, x19, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x29, x30, [sp], #32 // 16-byte Folded Reload
; CHECK-NEXT:  .LBB0_2: // %if.end
; CHECK-NEXT:    ret
entry:
  br i1 %cond, label %if.then, label %if.end

if.then:
  %ptr = alloca <vscale x 4 x i64>
  store <vscale x 4 x i64> %dst, ptr %ptr
  call void @bar(ptr %ptr)
  br label %if.end

if.end:
  ret void
}
