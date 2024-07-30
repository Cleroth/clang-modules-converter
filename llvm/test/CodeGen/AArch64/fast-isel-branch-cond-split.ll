; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-apple-darwin -fast-isel -fast-isel-abort=1 -verify-machineinstrs < %s | FileCheck %s

define i64 @test_or(i32 %a, i32 %b) {
; CHECK-LABEL: test_or:
; CHECK:       ; %bb.0: ; %bb1
; CHECK-NEXT:    cbnz w0, LBB0_2
; CHECK-NEXT:  LBB0_1:
; CHECK-NEXT:    mov x0, xzr
; CHECK-NEXT:    ret
; CHECK-NEXT:  LBB0_2: ; %bb1.cond.split
; CHECK-NEXT:    cbz w1, LBB0_1
; CHECK-NEXT:  ; %bb.3: ; %bb4
; CHECK-NEXT:    stp x29, x30, [sp, #-16]! ; 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    bl _bar
; CHECK-NEXT:    ldp x29, x30, [sp], #16 ; 16-byte Folded Reload
; CHECK-NEXT:    ret
bb1:
  %0 = icmp eq i32 %a, 0
  %1 = icmp eq i32 %b, 0
  %or.cond = or i1 %0, %1
  br i1 %or.cond, label %bb3, label %bb4, !prof !0

bb3:
  ret i64 0

bb4:
  %2 = call i64 @bar()
  ret i64 %2
}

define i64 @test_or_select(i32 %a, i32 %b) {
; CHECK-LABEL: test_or_select:
; CHECK:       ; %bb.0: ; %bb1
; CHECK-NEXT:    cbnz w0, LBB1_2
; CHECK-NEXT:  LBB1_1:
; CHECK-NEXT:    mov x0, xzr
; CHECK-NEXT:    ret
; CHECK-NEXT:  LBB1_2: ; %bb1.cond.split
; CHECK-NEXT:    cbz w1, LBB1_1
; CHECK-NEXT:  ; %bb.3: ; %bb4
; CHECK-NEXT:    stp x29, x30, [sp, #-16]! ; 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    bl _bar
; CHECK-NEXT:    ldp x29, x30, [sp], #16 ; 16-byte Folded Reload
; CHECK-NEXT:    ret
bb1:
  %0 = icmp eq i32 %a, 0
  %1 = icmp eq i32 %b, 0
  %or.cond = select i1 %0, i1 true, i1 %1
  br i1 %or.cond, label %bb3, label %bb4, !prof !0

bb3:
  ret i64 0

bb4:
  %2 = call i64 @bar()
  ret i64 %2
}

define i64 @test_and(i32 %a, i32 %b) {
; CHECK-LABEL: test_and:
; CHECK:       ; %bb.0: ; %bb1
; CHECK-NEXT:    cbnz w0, LBB2_2
; CHECK-NEXT:  LBB2_1:
; CHECK-NEXT:    mov x0, xzr
; CHECK-NEXT:    ret
; CHECK-NEXT:  LBB2_2: ; %bb1.cond.split
; CHECK-NEXT:    cbz w1, LBB2_1
; CHECK-NEXT:  ; %bb.3: ; %bb4
; CHECK-NEXT:    stp x29, x30, [sp, #-16]! ; 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    bl _bar
; CHECK-NEXT:    ldp x29, x30, [sp], #16 ; 16-byte Folded Reload
; CHECK-NEXT:    ret
bb1:
  %0 = icmp ne i32 %a, 0
  %1 = icmp ne i32 %b, 0
  %or.cond = and i1 %0, %1
  br i1 %or.cond, label %bb4, label %bb3, !prof !1

bb3:
  ret i64 0

bb4:
  %2 = call i64 @bar()
  ret i64 %2
}

define i64 @test_and_select(i32 %a, i32 %b) {
; CHECK-LABEL: test_and_select:
; CHECK:       ; %bb.0: ; %bb1
; CHECK-NEXT:    cbnz w0, LBB3_2
; CHECK-NEXT:  LBB3_1:
; CHECK-NEXT:    mov x0, xzr
; CHECK-NEXT:    ret
; CHECK-NEXT:  LBB3_2: ; %bb1.cond.split
; CHECK-NEXT:    cbz w1, LBB3_1
; CHECK-NEXT:  ; %bb.3: ; %bb4
; CHECK-NEXT:    stp x29, x30, [sp, #-16]! ; 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    bl _bar
; CHECK-NEXT:    ldp x29, x30, [sp], #16 ; 16-byte Folded Reload
; CHECK-NEXT:    ret
bb1:
  %0 = icmp ne i32 %a, 0
  %1 = icmp ne i32 %b, 0
  %or.cond = select i1 %0, i1 %1, i1 false
  br i1 %or.cond, label %bb4, label %bb3, !prof !1

bb3:
  ret i64 0

bb4:
  %2 = call i64 @bar()
  ret i64 %2
}

; If the branch is unpredictable, don't add another branch.

define i64 @test_or_unpredictable(i32 %a, i32 %b) {
; CHECK-LABEL: test_or_unpredictable:
; CHECK:       ; %bb.0: ; %bb1
; CHECK-NEXT:    cmp w0, #0
; CHECK-NEXT:    mov x0, xzr
; CHECK-NEXT:    cset w8, eq
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    cset w9, eq
; CHECK-NEXT:    orr w8, w8, w9
; CHECK-NEXT:    tbnz w8, #0, LBB4_2
; CHECK-NEXT:  ; %bb.1: ; %bb4
; CHECK-NEXT:    stp x29, x30, [sp, #-16]! ; 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    bl _bar
; CHECK-NEXT:    ldp x29, x30, [sp], #16 ; 16-byte Folded Reload
; CHECK-NEXT:  LBB4_2: ; %common.ret
; CHECK-NEXT:    ret
bb1:
  %0 = icmp eq i32 %a, 0
  %1 = icmp eq i32 %b, 0
  %or.cond = or i1 %0, %1
  br i1 %or.cond, label %bb3, label %bb4, !unpredictable !2

bb3:
  ret i64 0

bb4:
  %2 = call i64 @bar()
  ret i64 %2
}

define i64 @test_and_unpredictable(i32 %a, i32 %b) {
; CHECK-LABEL: test_and_unpredictable:
; CHECK:       ; %bb.0: ; %bb1
; CHECK-NEXT:    cmp w0, #0
; CHECK-NEXT:    mov x0, xzr
; CHECK-NEXT:    cset w8, ne
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    cset w9, ne
; CHECK-NEXT:    and w8, w8, w9
; CHECK-NEXT:    tbz w8, #0, LBB5_2
; CHECK-NEXT:  ; %bb.1: ; %bb4
; CHECK-NEXT:    stp x29, x30, [sp, #-16]! ; 16-byte Folded Spill
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    bl _bar
; CHECK-NEXT:    ldp x29, x30, [sp], #16 ; 16-byte Folded Reload
; CHECK-NEXT:  LBB5_2: ; %common.ret
; CHECK-NEXT:    ret
bb1:
  %0 = icmp ne i32 %a, 0
  %1 = icmp ne i32 %b, 0
  %or.cond = and i1 %0, %1
  br i1 %or.cond, label %bb4, label %bb3, !unpredictable !2

bb3:
  ret i64 0

bb4:
  %2 = call i64 @bar()
  ret i64 %2
}

declare i64 @bar()

!0 = !{!"branch_weights", i32 5128, i32 32}
!1 = !{!"branch_weights", i32 1024, i32 4136}
!2 = !{}
