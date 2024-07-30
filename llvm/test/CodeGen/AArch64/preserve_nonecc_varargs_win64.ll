; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc -mtriple=aarch64-pc-windows < %s | FileCheck %s

define preserve_nonecc i32 @callee(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, ...) nounwind noinline ssp {
; CHECK-LABEL: callee:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #48
; CHECK-NEXT:    mov x0, x5
; CHECK-NEXT:    add x8, sp, #24
; CHECK-NEXT:    stp x6, x7, [sp, #32]
; CHECK-NEXT:    str x5, [sp, #24]
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    str x8, [sp, #8]
; CHECK-NEXT:    add sp, sp, #48
; CHECK-NEXT:    ret
  %args = alloca ptr, align 8
  call void @llvm.va_start(ptr %args)
  %p = load ptr, ptr %args, align 8
  %10 = load i32, ptr %p, align 8
  call void @llvm.va_end(ptr %args)
  ret i32 %10
}

declare void @llvm.va_start(ptr) nounwind
declare void @llvm.va_end(ptr) nounwind

define i32 @caller() nounwind ssp {
; CHECK-LABEL: caller:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sub sp, sp, #176
; CHECK-NEXT:    mov w8, #10 // =0xa
; CHECK-NEXT:    mov w9, #9 // =0x9
; CHECK-NEXT:    mov w0, #1 // =0x1
; CHECK-NEXT:    mov w1, #2 // =0x2
; CHECK-NEXT:    mov w2, #3 // =0x3
; CHECK-NEXT:    mov w3, #4 // =0x4
; CHECK-NEXT:    mov w4, #5 // =0x5
; CHECK-NEXT:    mov w5, #6 // =0x6
; CHECK-NEXT:    mov w6, #7 // =0x7
; CHECK-NEXT:    mov w7, #8 // =0x8
; CHECK-NEXT:    stp d15, d14, [sp, #16] // 16-byte Folded Spill
; CHECK-NEXT:    stp d13, d12, [sp, #32] // 16-byte Folded Spill
; CHECK-NEXT:    stp d11, d10, [sp, #48] // 16-byte Folded Spill
; CHECK-NEXT:    stp d9, d8, [sp, #64] // 16-byte Folded Spill
; CHECK-NEXT:    str x30, [sp, #80] // 8-byte Folded Spill
; CHECK-NEXT:    stp x28, x27, [sp, #96] // 16-byte Folded Spill
; CHECK-NEXT:    stp x26, x25, [sp, #112] // 16-byte Folded Spill
; CHECK-NEXT:    stp x24, x23, [sp, #128] // 16-byte Folded Spill
; CHECK-NEXT:    stp x22, x21, [sp, #144] // 16-byte Folded Spill
; CHECK-NEXT:    stp x20, x19, [sp, #160] // 16-byte Folded Spill
; CHECK-NEXT:    str w8, [sp, #8]
; CHECK-NEXT:    str w9, [sp]
; CHECK-NEXT:    bl callee
; CHECK-NEXT:    ldp x20, x19, [sp, #160] // 16-byte Folded Reload
; CHECK-NEXT:    ldr x30, [sp, #80] // 8-byte Folded Reload
; CHECK-NEXT:    ldp x22, x21, [sp, #144] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x24, x23, [sp, #128] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x26, x25, [sp, #112] // 16-byte Folded Reload
; CHECK-NEXT:    ldp x28, x27, [sp, #96] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d9, d8, [sp, #64] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d11, d10, [sp, #48] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d13, d12, [sp, #32] // 16-byte Folded Reload
; CHECK-NEXT:    ldp d15, d14, [sp, #16] // 16-byte Folded Reload
; CHECK-NEXT:    add sp, sp, #176
; CHECK-NEXT:    ret
  %r = tail call preserve_nonecc i32 (i32, i32, i32, i32, i32, ...) @callee(i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10)
  ret i32 %r
}

