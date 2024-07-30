; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -O1 -mtriple arm -o - %s | FileCheck --check-prefix CHECK-LE %s
; RUN: llc -O1 -mtriple armv7 -o - %s | FileCheck --check-prefix CHECK-V7-LE %s
; RUN: llc -O1 -mtriple armeb -o - %s | FileCheck --check-prefix CHECK-BE %s
; RUN: llc -O1 -mtriple armv7eb -o - %s | FileCheck --check-prefix CHECK-V7-BE %s

; A collection of regression tests to verify the load-narrowing part of
; TargetLowering::SimplifySetCC (and/or other similar rewrites such as
; combining AND+LOAD into ZEXTLOAD).
;
; Using both arm and armv7 to show that alignment restrictions are
; considered for the narrowed load (armv7 is a bit more relaxed when it
; comes to unaligned memory accesses).

;--------------------------------------------------------------------------
; Test non byte-sized types.
;
; As long as LLVM IR isn't defining where the padding goes we can't really
; optimize these (without adding a target lowering hook that can inform
; ISel about which bits are padding).
; --------------------------------------------------------------------------

define i1 @test_129_15_0(ptr %y) {
; CHECK-LE-LABEL: test_129_15_0:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrh r0, [r0]
; CHECK-LE-NEXT:    mov r1, #255
; CHECK-LE-NEXT:    orr r1, r1, #32512
; CHECK-LE-NEXT:    ands r0, r0, r1
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_129_15_0:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrh r0, [r0]
; CHECK-V7-LE-NEXT:    bfc r0, #15, #17
; CHECK-V7-LE-NEXT:    cmp r0, #0
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_129_15_0:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldr r1, [r0, #12]
; CHECK-BE-NEXT:    ldrb r0, [r0, #16]
; CHECK-BE-NEXT:    orr r0, r0, r1, lsl #8
; CHECK-BE-NEXT:    mov r1, #255
; CHECK-BE-NEXT:    orr r1, r1, #32512
; CHECK-BE-NEXT:    ands r0, r0, r1
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_129_15_0:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrh r0, [r0, #15]
; CHECK-V7-BE-NEXT:    bfc r0, #15, #17
; CHECK-V7-BE-NEXT:    cmp r0, #0
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i129, ptr %y
  %b = and i129 %a, u0x7fff
  %cmp = icmp ne i129 %b, 0
  ret i1 %cmp
}

define i1 @test_126_20_4(ptr %y) {
; CHECK-LE-LABEL: test_126_20_4:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldr r0, [r0]
; CHECK-LE-NEXT:    mvn r1, #15
; CHECK-LE-NEXT:    sub r1, r1, #-16777216
; CHECK-LE-NEXT:    ands r0, r0, r1
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_126_20_4:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldr r0, [r0]
; CHECK-V7-LE-NEXT:    movw r1, #65520
; CHECK-V7-LE-NEXT:    movt r1, #255
; CHECK-V7-LE-NEXT:    ands r0, r0, r1
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_126_20_4:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldr r0, [r0, #12]
; CHECK-BE-NEXT:    mvn r1, #15
; CHECK-BE-NEXT:    sub r1, r1, #-16777216
; CHECK-BE-NEXT:    ands r0, r0, r1
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_126_20_4:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldr r0, [r0, #12]
; CHECK-V7-BE-NEXT:    movw r1, #65520
; CHECK-V7-BE-NEXT:    movt r1, #255
; CHECK-V7-BE-NEXT:    ands r0, r0, r1
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i126, ptr %y
  %b = and i126 %a, u0xfffff0
  %cmp = icmp ne i126 %b, 0
  ret i1 %cmp
}

define i1 @test_33_8_0(ptr %y) {
; CHECK-LE-LABEL: test_33_8_0:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrb r0, [r0]
; CHECK-LE-NEXT:    cmp r0, #0
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_33_8_0:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrb r0, [r0]
; CHECK-V7-LE-NEXT:    cmp r0, #0
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_33_8_0:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrb r0, [r0, #4]
; CHECK-BE-NEXT:    cmp r0, #0
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_33_8_0:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrb r0, [r0, #4]
; CHECK-V7-BE-NEXT:    cmp r0, #0
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i33, ptr %y
  %b = and i33 %a, u0xff
  %cmp = icmp ne i33 %b, 0
  ret i1 %cmp
}

define i1 @test_33_1_32(ptr %y) {
; CHECK-LE-LABEL: test_33_1_32:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrb r0, [r0, #4]
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_33_1_32:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrb r0, [r0, #4]
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_33_1_32:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldr r0, [r0]
; CHECK-BE-NEXT:    lsr r0, r0, #24
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_33_1_32:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldr r0, [r0]
; CHECK-V7-BE-NEXT:    lsr r0, r0, #24
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i33, ptr %y
  %b = and i33 %a, u0x100000000
  %cmp = icmp ne i33 %b, 0
  ret i1 %cmp
}

define i1 @test_33_1_31(ptr %y) {
; CHECK-LE-LABEL: test_33_1_31:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrb r0, [r0, #3]
; CHECK-LE-NEXT:    lsr r0, r0, #7
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_33_1_31:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrb r0, [r0, #3]
; CHECK-V7-LE-NEXT:    lsr r0, r0, #7
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_33_1_31:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrb r0, [r0, #1]
; CHECK-BE-NEXT:    lsr r0, r0, #7
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_33_1_31:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrb r0, [r0, #1]
; CHECK-V7-BE-NEXT:    lsr r0, r0, #7
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i33, ptr %y
  %b = and i33 %a, u0x80000000
  %cmp = icmp ne i33 %b, 0
  ret i1 %cmp
}

define i1 @test_33_1_0(ptr %y) {
; CHECK-LE-LABEL: test_33_1_0:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrb r0, [r0]
; CHECK-LE-NEXT:    and r0, r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_33_1_0:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrb r0, [r0]
; CHECK-V7-LE-NEXT:    and r0, r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_33_1_0:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrb r0, [r0, #4]
; CHECK-BE-NEXT:    and r0, r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_33_1_0:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrb r0, [r0, #4]
; CHECK-V7-BE-NEXT:    and r0, r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i33, ptr %y
  %b = and i33 %a, u0x1
  %cmp = icmp ne i33 %b, 0
  ret i1 %cmp
}

;--------------------------------------------------------------------------
; Test byte-sized types.
;--------------------------------------------------------------------------


define i1 @test_128_20_4(ptr %y) {
; CHECK-LE-LABEL: test_128_20_4:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldr r0, [r0]
; CHECK-LE-NEXT:    mvn r1, #15
; CHECK-LE-NEXT:    sub r1, r1, #-16777216
; CHECK-LE-NEXT:    ands r0, r0, r1
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_128_20_4:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldr r0, [r0]
; CHECK-V7-LE-NEXT:    movw r1, #65520
; CHECK-V7-LE-NEXT:    movt r1, #255
; CHECK-V7-LE-NEXT:    ands r0, r0, r1
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_128_20_4:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldr r0, [r0, #12]
; CHECK-BE-NEXT:    mvn r1, #15
; CHECK-BE-NEXT:    sub r1, r1, #-16777216
; CHECK-BE-NEXT:    ands r0, r0, r1
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_128_20_4:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldr r0, [r0, #12]
; CHECK-V7-BE-NEXT:    movw r1, #65520
; CHECK-V7-BE-NEXT:    movt r1, #255
; CHECK-V7-BE-NEXT:    ands r0, r0, r1
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i128, ptr %y
  %b = and i128 %a, u0xfffff0
  %cmp = icmp ne i128 %b, 0
  ret i1 %cmp
}

define i1 @test_48_16_0(ptr %y) {
; CHECK-LE-LABEL: test_48_16_0:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrh r0, [r0]
; CHECK-LE-NEXT:    cmp r0, #0
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_48_16_0:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrh r0, [r0]
; CHECK-V7-LE-NEXT:    cmp r0, #0
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_48_16_0:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrh r0, [r0, #4]
; CHECK-BE-NEXT:    cmp r0, #0
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_48_16_0:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrh r0, [r0, #4]
; CHECK-V7-BE-NEXT:    cmp r0, #0
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i48, ptr %y
  %b = and i48 %a, u0xffff
  %cmp = icmp ne i48 %b, 0
  ret i1 %cmp
}

define i1 @test_48_16_8(ptr %y) {
; CHECK-LE-LABEL: test_48_16_8:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrh r0, [r0, #1]
; CHECK-LE-NEXT:    lsls r0, r0, #8
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_48_16_8:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrh r0, [r0, #1]
; CHECK-V7-LE-NEXT:    cmp r0, #0
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_48_16_8:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrh r0, [r0, #3]
; CHECK-BE-NEXT:    cmp r0, #0
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_48_16_8:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrh r0, [r0, #3]
; CHECK-V7-BE-NEXT:    cmp r0, #0
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i48, ptr %y
  %b = and i48 %a, u0xffff00
  %cmp = icmp ne i48 %b, 0
  ret i1 %cmp
}

define i1 @test_48_16_16(ptr %y) {
; CHECK-LE-LABEL: test_48_16_16:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrh r0, [r0, #2]
; CHECK-LE-NEXT:    cmp r0, #0
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_48_16_16:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrh r0, [r0, #2]
; CHECK-V7-LE-NEXT:    cmp r0, #0
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_48_16_16:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrh r0, [r0, #2]
; CHECK-BE-NEXT:    cmp r0, #0
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_48_16_16:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrh r0, [r0, #2]
; CHECK-V7-BE-NEXT:    cmp r0, #0
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i48, ptr %y
  %b = and i48 %a, u0xffff0000
  %cmp = icmp ne i48 %b, 0
  ret i1 %cmp
}

define i1 @test_48_16_32(ptr %y) {
; CHECK-LE-LABEL: test_48_16_32:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrh r0, [r0, #4]
; CHECK-LE-NEXT:    cmp r0, #0
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_48_16_32:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrh r0, [r0, #4]
; CHECK-V7-LE-NEXT:    cmp r0, #0
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_48_16_32:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrh r0, [r0]
; CHECK-BE-NEXT:    cmp r0, #0
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_48_16_32:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrh r0, [r0]
; CHECK-V7-BE-NEXT:    cmp r0, #0
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i48, ptr %y
  %b = and i48 %a, u0xffff00000000
  %cmp = icmp ne i48 %b, 0
  ret i1 %cmp
}

define i1 @test_48_17_0(ptr %y) {
; CHECK-LE-LABEL: test_48_17_0:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldr r0, [r0]
; CHECK-LE-NEXT:    ldr r1, .LCPI11_0
; CHECK-LE-NEXT:    ands r0, r0, r1
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
; CHECK-LE-NEXT:    .p2align 2
; CHECK-LE-NEXT:  @ %bb.1:
; CHECK-LE-NEXT:  .LCPI11_0:
; CHECK-LE-NEXT:    .long 131071 @ 0x1ffff
;
; CHECK-V7-LE-LABEL: test_48_17_0:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldr r0, [r0]
; CHECK-V7-LE-NEXT:    bfc r0, #17, #15
; CHECK-V7-LE-NEXT:    cmp r0, #0
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_48_17_0:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldr r1, [r0]
; CHECK-BE-NEXT:    ldrh r0, [r0, #4]
; CHECK-BE-NEXT:    orr r0, r0, r1, lsl #16
; CHECK-BE-NEXT:    ldr r1, .LCPI11_0
; CHECK-BE-NEXT:    ands r0, r0, r1
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
; CHECK-BE-NEXT:    .p2align 2
; CHECK-BE-NEXT:  @ %bb.1:
; CHECK-BE-NEXT:  .LCPI11_0:
; CHECK-BE-NEXT:    .long 131071 @ 0x1ffff
;
; CHECK-V7-BE-LABEL: test_48_17_0:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldr r0, [r0, #2]
; CHECK-V7-BE-NEXT:    bfc r0, #17, #15
; CHECK-V7-BE-NEXT:    cmp r0, #0
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i48, ptr %y
  %b = and i48 %a, u0x1ffff
  %cmp = icmp ne i48 %b, 0
  ret i1 %cmp
}

define i1 @test_40_16_0(ptr %y) {
; CHECK-LE-LABEL: test_40_16_0:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrh r0, [r0]
; CHECK-LE-NEXT:    cmp r0, #0
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_40_16_0:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrh r0, [r0]
; CHECK-V7-LE-NEXT:    cmp r0, #0
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_40_16_0:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrh r0, [r0, #3]
; CHECK-BE-NEXT:    cmp r0, #0
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_40_16_0:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrh r0, [r0, #3]
; CHECK-V7-BE-NEXT:    cmp r0, #0
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i40, ptr %y
  %b = and i40 %a, u0xffff
  %cmp = icmp ne i40 %b, 0
  ret i1 %cmp
}

define i1 @test_40_1_32(ptr %y) {
; CHECK-LE-LABEL: test_40_1_32:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrb r0, [r0, #4]
; CHECK-LE-NEXT:    and r0, r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_40_1_32:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrb r0, [r0, #4]
; CHECK-V7-LE-NEXT:    and r0, r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_40_1_32:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrb r0, [r0]
; CHECK-BE-NEXT:    and r0, r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_40_1_32:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrb r0, [r0]
; CHECK-V7-BE-NEXT:    and r0, r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i40, ptr %y
  %b = and i40 %a, u0x100000000
  %cmp = icmp ne i40 %b, 0
  ret i1 %cmp
}

define i1 @test_24_16_0(ptr %y) {
; CHECK-LE-LABEL: test_24_16_0:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrh r0, [r0]
; CHECK-LE-NEXT:    cmp r0, #0
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_24_16_0:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrh r0, [r0]
; CHECK-V7-LE-NEXT:    cmp r0, #0
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_24_16_0:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrh r0, [r0, #1]
; CHECK-BE-NEXT:    cmp r0, #0
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_24_16_0:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrh r0, [r0, #1]
; CHECK-V7-BE-NEXT:    cmp r0, #0
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i24, ptr %y
  %b = and i24 %a, u0xffff
  %cmp = icmp ne i24 %b, 0
  ret i1 %cmp
}

define i1 @test_24_8_8(ptr %y) {
; CHECK-LE-LABEL: test_24_8_8:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrb r0, [r0, #1]
; CHECK-LE-NEXT:    lsls r0, r0, #8
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_24_8_8:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrb r0, [r0, #1]
; CHECK-V7-LE-NEXT:    lsls r0, r0, #8
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_24_8_8:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrb r0, [r0, #1]
; CHECK-BE-NEXT:    lsls r0, r0, #8
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_24_8_8:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrb r0, [r0, #1]
; CHECK-V7-BE-NEXT:    lsls r0, r0, #8
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i24, ptr %y
  %b = and i24 %a, u0xff00
  %cmp = icmp ne i24 %b, 0
  ret i1 %cmp
}

define i1 @test_24_8_12(ptr %y) {
; CHECK-LE-LABEL: test_24_8_12:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrb r1, [r0, #2]
; CHECK-LE-NEXT:    ldrh r0, [r0]
; CHECK-LE-NEXT:    orr r0, r0, r1, lsl #16
; CHECK-LE-NEXT:    ands r0, r0, #1044480
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_24_8_12:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrb r1, [r0, #2]
; CHECK-V7-LE-NEXT:    ldrh r0, [r0]
; CHECK-V7-LE-NEXT:    orr r0, r0, r1, lsl #16
; CHECK-V7-LE-NEXT:    ands r0, r0, #1044480
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_24_8_12:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrh r0, [r0]
; CHECK-BE-NEXT:    mov r1, #1044480
; CHECK-BE-NEXT:    ands r0, r1, r0, lsl #8
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_24_8_12:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrh r0, [r0]
; CHECK-V7-BE-NEXT:    mov r1, #1044480
; CHECK-V7-BE-NEXT:    ands r0, r1, r0, lsl #8
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i24, ptr %y
  %b = and i24 %a, u0xff000
  %cmp = icmp ne i24 %b, 0
  ret i1 %cmp
}

define i1 @test_24_8_16(ptr %y) {
; CHECK-LE-LABEL: test_24_8_16:
; CHECK-LE:       @ %bb.0:
; CHECK-LE-NEXT:    ldrb r0, [r0, #2]
; CHECK-LE-NEXT:    lsls r0, r0, #16
; CHECK-LE-NEXT:    movne r0, #1
; CHECK-LE-NEXT:    mov pc, lr
;
; CHECK-V7-LE-LABEL: test_24_8_16:
; CHECK-V7-LE:       @ %bb.0:
; CHECK-V7-LE-NEXT:    ldrb r0, [r0, #2]
; CHECK-V7-LE-NEXT:    lsls r0, r0, #16
; CHECK-V7-LE-NEXT:    movwne r0, #1
; CHECK-V7-LE-NEXT:    bx lr
;
; CHECK-BE-LABEL: test_24_8_16:
; CHECK-BE:       @ %bb.0:
; CHECK-BE-NEXT:    ldrb r0, [r0]
; CHECK-BE-NEXT:    lsls r0, r0, #16
; CHECK-BE-NEXT:    movne r0, #1
; CHECK-BE-NEXT:    mov pc, lr
;
; CHECK-V7-BE-LABEL: test_24_8_16:
; CHECK-V7-BE:       @ %bb.0:
; CHECK-V7-BE-NEXT:    ldrb r0, [r0]
; CHECK-V7-BE-NEXT:    lsls r0, r0, #16
; CHECK-V7-BE-NEXT:    movwne r0, #1
; CHECK-V7-BE-NEXT:    bx lr
  %a = load i24, ptr %y
  %b = and i24 %a, u0xff0000
  %cmp = icmp ne i24 %b, 0
  ret i1 %cmp
}
