; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 | FileCheck %s --check-prefixes=NOZBB,RV32I
; RUN: llc < %s -mtriple=riscv64 | FileCheck %s --check-prefixes=NOZBB,RV64I
; RUN: llc < %s -mtriple=riscv32 -mattr=+zbb | \
; RUN:   FileCheck %s --check-prefixes=ZBB,RV32ZBB
; RUN: llc < %s -mtriple=riscv64 -mattr=+zbb | \
; RUN:   FileCheck %s --check-prefixes=ZBB,RV64ZBB

; Basic tests.

declare i8 @llvm.smax.i8(i8 %a, i8 %b) readnone

define signext i8 @smax_i8(i8 signext %a, i8 signext %b) {
; NOZBB-LABEL: smax_i8:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    blt a1, a0, .LBB0_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB0_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smax_i8:
; ZBB:       # %bb.0:
; ZBB-NEXT:    max a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i8 @llvm.smax.i8(i8 %a, i8 %b)
  ret i8 %c
}

declare i16 @llvm.smax.i16(i16 %a, i16 %b) readnone

define signext i16 @smax_i16(i16 signext %a, i16 signext %b) {
; NOZBB-LABEL: smax_i16:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    blt a1, a0, .LBB1_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB1_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smax_i16:
; ZBB:       # %bb.0:
; ZBB-NEXT:    max a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i16 @llvm.smax.i16(i16 %a, i16 %b)
  ret i16 %c
}

declare i32 @llvm.smax.i32(i32 %a, i32 %b) readnone

define signext i32 @smax_i32(i32 signext %a, i32 signext %b) {
; NOZBB-LABEL: smax_i32:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    blt a1, a0, .LBB2_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB2_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smax_i32:
; ZBB:       # %bb.0:
; ZBB-NEXT:    max a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i32 @llvm.smax.i32(i32 %a, i32 %b)
  ret i32 %c
}

declare i64 @llvm.smax.i64(i64 %a, i64 %b) readnone

define i64 @smax_i64(i64 %a, i64 %b) {
; RV32I-LABEL: smax_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    beq a1, a3, .LBB3_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    slt a4, a3, a1
; RV32I-NEXT:    beqz a4, .LBB3_3
; RV32I-NEXT:    j .LBB3_4
; RV32I-NEXT:  .LBB3_2:
; RV32I-NEXT:    sltu a4, a2, a0
; RV32I-NEXT:    bnez a4, .LBB3_4
; RV32I-NEXT:  .LBB3_3:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:  .LBB3_4:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: smax_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    blt a1, a0, .LBB3_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a0, a1
; RV64I-NEXT:  .LBB3_2:
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: smax_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    beq a1, a3, .LBB3_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    slt a4, a3, a1
; RV32ZBB-NEXT:    beqz a4, .LBB3_3
; RV32ZBB-NEXT:    j .LBB3_4
; RV32ZBB-NEXT:  .LBB3_2:
; RV32ZBB-NEXT:    sltu a4, a2, a0
; RV32ZBB-NEXT:    bnez a4, .LBB3_4
; RV32ZBB-NEXT:  .LBB3_3:
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    mv a1, a3
; RV32ZBB-NEXT:  .LBB3_4:
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: smax_i64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    max a0, a0, a1
; RV64ZBB-NEXT:    ret
  %c = call i64 @llvm.smax.i64(i64 %a, i64 %b)
  ret i64 %c
}

declare i8 @llvm.smin.i8(i8 %a, i8 %b) readnone

define signext i8 @smin_i8(i8 signext %a, i8 signext %b) {
; NOZBB-LABEL: smin_i8:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    blt a0, a1, .LBB4_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB4_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smin_i8:
; ZBB:       # %bb.0:
; ZBB-NEXT:    min a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i8 @llvm.smin.i8(i8 %a, i8 %b)
  ret i8 %c
}

declare i16 @llvm.smin.i16(i16 %a, i16 %b) readnone

define signext i16 @smin_i16(i16 signext %a, i16 signext %b) {
; NOZBB-LABEL: smin_i16:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    blt a0, a1, .LBB5_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB5_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smin_i16:
; ZBB:       # %bb.0:
; ZBB-NEXT:    min a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i16 @llvm.smin.i16(i16 %a, i16 %b)
  ret i16 %c
}

declare i32 @llvm.smin.i32(i32 %a, i32 %b) readnone

define signext i32 @smin_i32(i32 signext %a, i32 signext %b) {
; NOZBB-LABEL: smin_i32:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    blt a0, a1, .LBB6_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB6_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smin_i32:
; ZBB:       # %bb.0:
; ZBB-NEXT:    min a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i32 @llvm.smin.i32(i32 %a, i32 %b)
  ret i32 %c
}

declare i64 @llvm.smin.i64(i64 %a, i64 %b) readnone

define i64 @smin_i64(i64 %a, i64 %b) {
; RV32I-LABEL: smin_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    beq a1, a3, .LBB7_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    slt a4, a1, a3
; RV32I-NEXT:    beqz a4, .LBB7_3
; RV32I-NEXT:    j .LBB7_4
; RV32I-NEXT:  .LBB7_2:
; RV32I-NEXT:    sltu a4, a0, a2
; RV32I-NEXT:    bnez a4, .LBB7_4
; RV32I-NEXT:  .LBB7_3:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:  .LBB7_4:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: smin_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    blt a0, a1, .LBB7_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a0, a1
; RV64I-NEXT:  .LBB7_2:
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: smin_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    beq a1, a3, .LBB7_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    slt a4, a1, a3
; RV32ZBB-NEXT:    beqz a4, .LBB7_3
; RV32ZBB-NEXT:    j .LBB7_4
; RV32ZBB-NEXT:  .LBB7_2:
; RV32ZBB-NEXT:    sltu a4, a0, a2
; RV32ZBB-NEXT:    bnez a4, .LBB7_4
; RV32ZBB-NEXT:  .LBB7_3:
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    mv a1, a3
; RV32ZBB-NEXT:  .LBB7_4:
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: smin_i64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    min a0, a0, a1
; RV64ZBB-NEXT:    ret
  %c = call i64 @llvm.smin.i64(i64 %a, i64 %b)
  ret i64 %c
}

declare i8 @llvm.umax.i8(i8 %a, i8 %b) readnone

define i8 @umax_i8(i8 zeroext %a, i8 zeroext %b) {
; NOZBB-LABEL: umax_i8:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    bltu a1, a0, .LBB8_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB8_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: umax_i8:
; ZBB:       # %bb.0:
; ZBB-NEXT:    maxu a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i8 @llvm.umax.i8(i8 %a, i8 %b)
  ret i8 %c
}

declare i16 @llvm.umax.i16(i16 %a, i16 %b) readnone

define i16 @umax_i16(i16 zeroext %a, i16 zeroext %b) {
; NOZBB-LABEL: umax_i16:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    bltu a1, a0, .LBB9_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB9_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: umax_i16:
; ZBB:       # %bb.0:
; ZBB-NEXT:    maxu a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i16 @llvm.umax.i16(i16 %a, i16 %b)
  ret i16 %c
}

declare i32 @llvm.umax.i32(i32 %a, i32 %b) readnone

define signext i32 @umax_i32(i32 signext %a, i32 signext %b) {
; NOZBB-LABEL: umax_i32:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    bltu a1, a0, .LBB10_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB10_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: umax_i32:
; ZBB:       # %bb.0:
; ZBB-NEXT:    maxu a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i32 @llvm.umax.i32(i32 %a, i32 %b)
  ret i32 %c
}

declare i64 @llvm.umax.i64(i64 %a, i64 %b) readnone

define i64 @umax_i64(i64 %a, i64 %b) {
; RV32I-LABEL: umax_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    beq a1, a3, .LBB11_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    sltu a4, a3, a1
; RV32I-NEXT:    beqz a4, .LBB11_3
; RV32I-NEXT:    j .LBB11_4
; RV32I-NEXT:  .LBB11_2:
; RV32I-NEXT:    sltu a4, a2, a0
; RV32I-NEXT:    bnez a4, .LBB11_4
; RV32I-NEXT:  .LBB11_3:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:  .LBB11_4:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: umax_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    bltu a1, a0, .LBB11_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a0, a1
; RV64I-NEXT:  .LBB11_2:
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: umax_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    beq a1, a3, .LBB11_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    sltu a4, a3, a1
; RV32ZBB-NEXT:    beqz a4, .LBB11_3
; RV32ZBB-NEXT:    j .LBB11_4
; RV32ZBB-NEXT:  .LBB11_2:
; RV32ZBB-NEXT:    sltu a4, a2, a0
; RV32ZBB-NEXT:    bnez a4, .LBB11_4
; RV32ZBB-NEXT:  .LBB11_3:
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    mv a1, a3
; RV32ZBB-NEXT:  .LBB11_4:
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: umax_i64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    maxu a0, a0, a1
; RV64ZBB-NEXT:    ret
  %c = call i64 @llvm.umax.i64(i64 %a, i64 %b)
  ret i64 %c
}

declare i8 @llvm.umin.i8(i8 %a, i8 %b) readnone

define zeroext i8 @umin_i8(i8 zeroext %a, i8 zeroext %b) {
; NOZBB-LABEL: umin_i8:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    bltu a0, a1, .LBB12_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB12_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: umin_i8:
; ZBB:       # %bb.0:
; ZBB-NEXT:    minu a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i8 @llvm.umin.i8(i8 %a, i8 %b)
  ret i8 %c
}

declare i16 @llvm.umin.i16(i16 %a, i16 %b) readnone

define zeroext i16 @umin_i16(i16 zeroext %a, i16 zeroext %b) {
; NOZBB-LABEL: umin_i16:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    bltu a0, a1, .LBB13_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB13_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: umin_i16:
; ZBB:       # %bb.0:
; ZBB-NEXT:    minu a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i16 @llvm.umin.i16(i16 %a, i16 %b)
  ret i16 %c
}

declare i32 @llvm.umin.i32(i32 %a, i32 %b) readnone

define signext i32 @umin_i32(i32 signext %a, i32 signext %b) {
; NOZBB-LABEL: umin_i32:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    bltu a0, a1, .LBB14_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    mv a0, a1
; NOZBB-NEXT:  .LBB14_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: umin_i32:
; ZBB:       # %bb.0:
; ZBB-NEXT:    minu a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i32 @llvm.umin.i32(i32 %a, i32 %b)
  ret i32 %c
}

declare i64 @llvm.umin.i64(i64 %a, i64 %b) readnone

define i64 @umin_i64(i64 %a, i64 %b) {
; RV32I-LABEL: umin_i64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    beq a1, a3, .LBB15_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    sltu a4, a1, a3
; RV32I-NEXT:    beqz a4, .LBB15_3
; RV32I-NEXT:    j .LBB15_4
; RV32I-NEXT:  .LBB15_2:
; RV32I-NEXT:    sltu a4, a0, a2
; RV32I-NEXT:    bnez a4, .LBB15_4
; RV32I-NEXT:  .LBB15_3:
; RV32I-NEXT:    mv a0, a2
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:  .LBB15_4:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: umin_i64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    bltu a0, a1, .LBB15_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a0, a1
; RV64I-NEXT:  .LBB15_2:
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: umin_i64:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    beq a1, a3, .LBB15_2
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    sltu a4, a1, a3
; RV32ZBB-NEXT:    beqz a4, .LBB15_3
; RV32ZBB-NEXT:    j .LBB15_4
; RV32ZBB-NEXT:  .LBB15_2:
; RV32ZBB-NEXT:    sltu a4, a0, a2
; RV32ZBB-NEXT:    bnez a4, .LBB15_4
; RV32ZBB-NEXT:  .LBB15_3:
; RV32ZBB-NEXT:    mv a0, a2
; RV32ZBB-NEXT:    mv a1, a3
; RV32ZBB-NEXT:  .LBB15_4:
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: umin_i64:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    minu a0, a0, a1
; RV64ZBB-NEXT:    ret
  %c = call i64 @llvm.umin.i64(i64 %a, i64 %b)
  ret i64 %c
}

; Tests with the same operand used twice. These should fold away.

define signext i32 @smin_same_op_i32(i32 signext %a) {
; NOZBB-LABEL: smin_same_op_i32:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smin_same_op_i32:
; ZBB:       # %bb.0:
; ZBB-NEXT:    ret
  %c = call i32 @llvm.smin.i32(i32 %a, i32 %a)
  ret i32 %c
}

define signext i32 @smax_same_op_i32(i32 signext %a) {
; NOZBB-LABEL: smax_same_op_i32:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smax_same_op_i32:
; ZBB:       # %bb.0:
; ZBB-NEXT:    ret
  %c = call i32 @llvm.smax.i32(i32 %a, i32 %a)
  ret i32 %c
}

define signext i32 @umin_same_op_i32(i32 signext %a) {
; NOZBB-LABEL: umin_same_op_i32:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: umin_same_op_i32:
; ZBB:       # %bb.0:
; ZBB-NEXT:    ret
  %c = call i32 @llvm.umin.i32(i32 %a, i32 %a)
  ret i32 %c
}

define signext i32 @umax_same_op_i32(i32 signext %a) {
; NOZBB-LABEL: umax_same_op_i32:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: umax_same_op_i32:
; ZBB:       # %bb.0:
; ZBB-NEXT:    ret
  %c = call i32 @llvm.umax.i32(i32 %a, i32 %a)
  ret i32 %c
}

; Tests with undef operands. These should fold to undef for RV32 or 0 for RV64.

define signext i32 @smin_undef_i32() {
; RV32I-LABEL: smin_undef_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: smin_undef_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: smin_undef_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: smin_undef_i32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    li a0, 0
; RV64ZBB-NEXT:    ret
  %c = call i32 @llvm.smin.i32(i32 undef, i32 undef)
  ret i32 %c
}

define signext i32 @smax_undef_i32() {
; RV32I-LABEL: smax_undef_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: smax_undef_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: smax_undef_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: smax_undef_i32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    li a0, 0
; RV64ZBB-NEXT:    ret
  %c = call i32 @llvm.smax.i32(i32 undef, i32 undef)
  ret i32 %c
}

define signext i32 @umin_undef_i32() {
; RV32I-LABEL: umin_undef_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: umin_undef_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: umin_undef_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: umin_undef_i32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    li a0, 0
; RV64ZBB-NEXT:    ret
  %c = call i32 @llvm.umin.i32(i32 undef, i32 undef)
  ret i32 %c
}

define signext i32 @umax_undef_i32() {
; RV32I-LABEL: umax_undef_i32:
; RV32I:       # %bb.0:
; RV32I-NEXT:    ret
;
; RV64I-LABEL: umax_undef_i32:
; RV64I:       # %bb.0:
; RV64I-NEXT:    li a0, 0
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: umax_undef_i32:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: umax_undef_i32:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    li a0, 0
; RV64ZBB-NEXT:    ret
  %c = call i32 @llvm.umax.i32(i32 undef, i32 undef)
  ret i32 %c
}

define signext i32 @smax_i32_pos_constant(i32 signext %a) {
; NOZBB-LABEL: smax_i32_pos_constant:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    li a1, 10
; NOZBB-NEXT:    blt a1, a0, .LBB24_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    li a0, 10
; NOZBB-NEXT:  .LBB24_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smax_i32_pos_constant:
; ZBB:       # %bb.0:
; ZBB-NEXT:    li a1, 10
; ZBB-NEXT:    max a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i32 @llvm.smax.i32(i32 %a, i32 10)
  ret i32 %c
}

define signext i32 @smax_i32_pos_constant_trailing_zeros(i32 signext %a) {
; NOZBB-LABEL: smax_i32_pos_constant_trailing_zeros:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    andi a0, a0, -8
; NOZBB-NEXT:    li a1, 16
; NOZBB-NEXT:    blt a1, a0, .LBB25_2
; NOZBB-NEXT:  # %bb.1:
; NOZBB-NEXT:    li a0, 16
; NOZBB-NEXT:  .LBB25_2:
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smax_i32_pos_constant_trailing_zeros:
; ZBB:       # %bb.0:
; ZBB-NEXT:    andi a0, a0, -8
; ZBB-NEXT:    li a1, 16
; ZBB-NEXT:    max a0, a0, a1
; ZBB-NEXT:    ret
  %b = and i32 %a, -8
  %c = call i32 @llvm.smax.i32(i32 %b, i32 16)
  %d = and i32 %c, -4
  ret i32 %d
}

define signext i32 @smin_i32_negone(i32 signext %a) {
; NOZBB-LABEL: smin_i32_negone:
; NOZBB:       # %bb.0:
; NOZBB-NEXT:    slti a1, a0, -1
; NOZBB-NEXT:    addi a1, a1, -1
; NOZBB-NEXT:    or a0, a1, a0
; NOZBB-NEXT:    ret
;
; ZBB-LABEL: smin_i32_negone:
; ZBB:       # %bb.0:
; ZBB-NEXT:    li a1, -1
; ZBB-NEXT:    min a0, a0, a1
; ZBB-NEXT:    ret
  %c = call i32 @llvm.smin.i32(i32 %a, i32 -1)
  ret i32 %c
}

define i64 @smin_i64_negone(i64 %a) {
; RV32I-LABEL: smin_i64_negone:
; RV32I:       # %bb.0:
; RV32I-NEXT:    slti a2, a1, 0
; RV32I-NEXT:    addi a2, a2, -1
; RV32I-NEXT:    or a0, a2, a0
; RV32I-NEXT:    slti a2, a1, -1
; RV32I-NEXT:    addi a2, a2, -1
; RV32I-NEXT:    or a1, a2, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: smin_i64_negone:
; RV64I:       # %bb.0:
; RV64I-NEXT:    slti a1, a0, -1
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    or a0, a1, a0
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: smin_i64_negone:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    li a2, -1
; RV32ZBB-NEXT:    min a2, a1, a2
; RV32ZBB-NEXT:    slti a1, a1, 0
; RV32ZBB-NEXT:    addi a1, a1, -1
; RV32ZBB-NEXT:    or a0, a1, a0
; RV32ZBB-NEXT:    mv a1, a2
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: smin_i64_negone:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    li a1, -1
; RV64ZBB-NEXT:    min a0, a0, a1
; RV64ZBB-NEXT:    ret
  %c = call i64 @llvm.smin.i64(i64 %a, i64 -1)
  ret i64 %c
}

define i64 @umax_i64_one(i64 %a, i64 %b) {
; RV32I-LABEL: umax_i64_one:
; RV32I:       # %bb.0:
; RV32I-NEXT:    mv a2, a0
; RV32I-NEXT:    beqz a1, .LBB28_3
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    beqz a1, .LBB28_4
; RV32I-NEXT:  .LBB28_2:
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB28_3:
; RV32I-NEXT:    li a0, 1
; RV32I-NEXT:    bnez a1, .LBB28_2
; RV32I-NEXT:  .LBB28_4:
; RV32I-NEXT:    seqz a0, a2
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    ret
;
; RV64I-LABEL: umax_i64_one:
; RV64I:       # %bb.0:
; RV64I-NEXT:    seqz a1, a0
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    ret
;
; RV32ZBB-LABEL: umax_i64_one:
; RV32ZBB:       # %bb.0:
; RV32ZBB-NEXT:    mv a2, a0
; RV32ZBB-NEXT:    li a3, 1
; RV32ZBB-NEXT:    beqz a1, .LBB28_3
; RV32ZBB-NEXT:  # %bb.1:
; RV32ZBB-NEXT:    beqz a1, .LBB28_4
; RV32ZBB-NEXT:  .LBB28_2:
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB28_3:
; RV32ZBB-NEXT:    li a0, 1
; RV32ZBB-NEXT:    bnez a1, .LBB28_2
; RV32ZBB-NEXT:  .LBB28_4:
; RV32ZBB-NEXT:    maxu a0, a2, a3
; RV32ZBB-NEXT:    ret
;
; RV64ZBB-LABEL: umax_i64_one:
; RV64ZBB:       # %bb.0:
; RV64ZBB-NEXT:    li a1, 1
; RV64ZBB-NEXT:    maxu a0, a0, a1
; RV64ZBB-NEXT:    ret
  %c = call i64 @llvm.umax.i64(i64 %a, i64 1)
  ret i64 %c
}
