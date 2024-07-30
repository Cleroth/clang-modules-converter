; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s -check-prefix=RV64I

; Basic shift support is tested as part of ALU.ll. This file ensures that
; shifts which may not be supported natively are lowered properly.

declare i64 @llvm.fshr.i64(i64, i64, i64)
declare i128 @llvm.fshr.i128(i128, i128, i128)

define i64 @lshr64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: lshr64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a4, a2, -32
; RV32I-NEXT:    srl a3, a1, a2
; RV32I-NEXT:    bltz a4, .LBB0_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a0, a3
; RV32I-NEXT:    j .LBB0_3
; RV32I-NEXT:  .LBB0_2:
; RV32I-NEXT:    srl a0, a0, a2
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    slli a1, a1, 1
; RV32I-NEXT:    sll a1, a1, a2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:  .LBB0_3:
; RV32I-NEXT:    srai a1, a4, 31
; RV32I-NEXT:    and a1, a1, a3
; RV32I-NEXT:    ret
;
; RV64I-LABEL: lshr64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srl a0, a0, a1
; RV64I-NEXT:    ret
  %1 = lshr i64 %a, %b
  ret i64 %1
}

define i64 @lshr64_minsize(i64 %a, i64 %b) minsize nounwind {
; RV32I-LABEL: lshr64_minsize:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __lshrdi3
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: lshr64_minsize:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srl a0, a0, a1
; RV64I-NEXT:    ret
  %1 = lshr i64 %a, %b
  ret i64 %1
}

define i64 @ashr64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: ashr64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    mv a3, a1
; RV32I-NEXT:    addi a4, a2, -32
; RV32I-NEXT:    sra a1, a1, a2
; RV32I-NEXT:    bltz a4, .LBB2_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    srai a3, a3, 31
; RV32I-NEXT:    mv a0, a1
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB2_2:
; RV32I-NEXT:    srl a0, a0, a2
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    slli a3, a3, 1
; RV32I-NEXT:    sll a2, a3, a2
; RV32I-NEXT:    or a0, a0, a2
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ashr64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sra a0, a0, a1
; RV64I-NEXT:    ret
  %1 = ashr i64 %a, %b
  ret i64 %1
}

define i64 @ashr64_minsize(i64 %a, i64 %b) minsize nounwind {
; RV32I-LABEL: ashr64_minsize:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __ashrdi3
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ashr64_minsize:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sra a0, a0, a1
; RV64I-NEXT:    ret
  %1 = ashr i64 %a, %b
  ret i64 %1
}

define i64 @shl64(i64 %a, i64 %b) nounwind {
; RV32I-LABEL: shl64:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi a4, a2, -32
; RV32I-NEXT:    sll a3, a0, a2
; RV32I-NEXT:    bltz a4, .LBB4_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a1, a3
; RV32I-NEXT:    j .LBB4_3
; RV32I-NEXT:  .LBB4_2:
; RV32I-NEXT:    sll a1, a1, a2
; RV32I-NEXT:    not a2, a2
; RV32I-NEXT:    srli a0, a0, 1
; RV32I-NEXT:    srl a0, a0, a2
; RV32I-NEXT:    or a1, a1, a0
; RV32I-NEXT:  .LBB4_3:
; RV32I-NEXT:    srai a0, a4, 31
; RV32I-NEXT:    and a0, a0, a3
; RV32I-NEXT:    ret
;
; RV64I-LABEL: shl64:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sll a0, a0, a1
; RV64I-NEXT:    ret
  %1 = shl i64 %a, %b
  ret i64 %1
}

define i64 @shl64_minsize(i64 %a, i64 %b) minsize nounwind {
; RV32I-LABEL: shl64_minsize:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    call __ashldi3
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: shl64_minsize:
; RV64I:       # %bb.0:
; RV64I-NEXT:    sll a0, a0, a1
; RV64I-NEXT:    ret
  %1 = shl i64 %a, %b
  ret i64 %1
}

define i128 @lshr128(i128 %a, i128 %b) nounwind {
; RV32I-LABEL: lshr128:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    lw a2, 0(a2)
; RV32I-NEXT:    lw a3, 0(a1)
; RV32I-NEXT:    lw a4, 4(a1)
; RV32I-NEXT:    lw a5, 8(a1)
; RV32I-NEXT:    lw a1, 12(a1)
; RV32I-NEXT:    sb zero, 31(sp)
; RV32I-NEXT:    sb zero, 30(sp)
; RV32I-NEXT:    sb zero, 29(sp)
; RV32I-NEXT:    sb zero, 28(sp)
; RV32I-NEXT:    sb zero, 27(sp)
; RV32I-NEXT:    sb zero, 26(sp)
; RV32I-NEXT:    sb zero, 25(sp)
; RV32I-NEXT:    sb zero, 24(sp)
; RV32I-NEXT:    sb zero, 23(sp)
; RV32I-NEXT:    sb zero, 22(sp)
; RV32I-NEXT:    sb zero, 21(sp)
; RV32I-NEXT:    sb zero, 20(sp)
; RV32I-NEXT:    sb zero, 19(sp)
; RV32I-NEXT:    sb zero, 18(sp)
; RV32I-NEXT:    sb zero, 17(sp)
; RV32I-NEXT:    sb zero, 16(sp)
; RV32I-NEXT:    sb a1, 12(sp)
; RV32I-NEXT:    sb a5, 8(sp)
; RV32I-NEXT:    sb a4, 4(sp)
; RV32I-NEXT:    sb a3, 0(sp)
; RV32I-NEXT:    srli a6, a1, 24
; RV32I-NEXT:    sb a6, 15(sp)
; RV32I-NEXT:    srli a6, a1, 16
; RV32I-NEXT:    sb a6, 14(sp)
; RV32I-NEXT:    srli a1, a1, 8
; RV32I-NEXT:    sb a1, 13(sp)
; RV32I-NEXT:    srli a1, a5, 24
; RV32I-NEXT:    sb a1, 11(sp)
; RV32I-NEXT:    srli a1, a5, 16
; RV32I-NEXT:    sb a1, 10(sp)
; RV32I-NEXT:    srli a5, a5, 8
; RV32I-NEXT:    sb a5, 9(sp)
; RV32I-NEXT:    srli a1, a4, 24
; RV32I-NEXT:    sb a1, 7(sp)
; RV32I-NEXT:    srli a1, a4, 16
; RV32I-NEXT:    sb a1, 6(sp)
; RV32I-NEXT:    srli a4, a4, 8
; RV32I-NEXT:    sb a4, 5(sp)
; RV32I-NEXT:    srli a1, a3, 24
; RV32I-NEXT:    sb a1, 3(sp)
; RV32I-NEXT:    srli a1, a3, 16
; RV32I-NEXT:    sb a1, 2(sp)
; RV32I-NEXT:    srli a3, a3, 8
; RV32I-NEXT:    sb a3, 1(sp)
; RV32I-NEXT:    slli a1, a2, 25
; RV32I-NEXT:    srli a1, a1, 28
; RV32I-NEXT:    mv a3, sp
; RV32I-NEXT:    add a1, a3, a1
; RV32I-NEXT:    lbu a3, 1(a1)
; RV32I-NEXT:    lbu a4, 0(a1)
; RV32I-NEXT:    lbu a5, 2(a1)
; RV32I-NEXT:    lbu a6, 3(a1)
; RV32I-NEXT:    slli a3, a3, 8
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    slli a5, a5, 16
; RV32I-NEXT:    slli a6, a6, 24
; RV32I-NEXT:    or a4, a6, a5
; RV32I-NEXT:    or a3, a4, a3
; RV32I-NEXT:    andi a2, a2, 7
; RV32I-NEXT:    srl a3, a3, a2
; RV32I-NEXT:    lbu a4, 5(a1)
; RV32I-NEXT:    lbu a5, 4(a1)
; RV32I-NEXT:    lbu a6, 6(a1)
; RV32I-NEXT:    lbu a7, 7(a1)
; RV32I-NEXT:    slli a4, a4, 8
; RV32I-NEXT:    or a4, a4, a5
; RV32I-NEXT:    slli a6, a6, 16
; RV32I-NEXT:    slli a7, a7, 24
; RV32I-NEXT:    or a5, a7, a6
; RV32I-NEXT:    or a4, a5, a4
; RV32I-NEXT:    slli a5, a4, 1
; RV32I-NEXT:    xori a6, a2, 31
; RV32I-NEXT:    sll a5, a5, a6
; RV32I-NEXT:    or a3, a3, a5
; RV32I-NEXT:    srl a4, a4, a2
; RV32I-NEXT:    lbu a5, 9(a1)
; RV32I-NEXT:    lbu a7, 8(a1)
; RV32I-NEXT:    lbu t0, 10(a1)
; RV32I-NEXT:    lbu t1, 11(a1)
; RV32I-NEXT:    slli a5, a5, 8
; RV32I-NEXT:    or a5, a5, a7
; RV32I-NEXT:    slli t0, t0, 16
; RV32I-NEXT:    slli t1, t1, 24
; RV32I-NEXT:    or a7, t1, t0
; RV32I-NEXT:    or a5, a7, a5
; RV32I-NEXT:    slli a7, a5, 1
; RV32I-NEXT:    not t0, a2
; RV32I-NEXT:    lbu t1, 13(a1)
; RV32I-NEXT:    sll a7, a7, t0
; RV32I-NEXT:    or a4, a4, a7
; RV32I-NEXT:    lbu a7, 12(a1)
; RV32I-NEXT:    slli t1, t1, 8
; RV32I-NEXT:    lbu t0, 14(a1)
; RV32I-NEXT:    lbu a1, 15(a1)
; RV32I-NEXT:    or a7, t1, a7
; RV32I-NEXT:    srl a5, a5, a2
; RV32I-NEXT:    slli t0, t0, 16
; RV32I-NEXT:    slli a1, a1, 24
; RV32I-NEXT:    or a1, a1, t0
; RV32I-NEXT:    or a1, a1, a7
; RV32I-NEXT:    slli a7, a1, 1
; RV32I-NEXT:    sll a6, a7, a6
; RV32I-NEXT:    or a5, a5, a6
; RV32I-NEXT:    srl a1, a1, a2
; RV32I-NEXT:    sw a1, 12(a0)
; RV32I-NEXT:    sw a5, 8(a0)
; RV32I-NEXT:    sw a4, 4(a0)
; RV32I-NEXT:    sw a3, 0(a0)
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: lshr128:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a4, a2, -64
; RV64I-NEXT:    srl a3, a1, a2
; RV64I-NEXT:    bltz a4, .LBB6_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a0, a3
; RV64I-NEXT:    j .LBB6_3
; RV64I-NEXT:  .LBB6_2:
; RV64I-NEXT:    srl a0, a0, a2
; RV64I-NEXT:    not a2, a2
; RV64I-NEXT:    slli a1, a1, 1
; RV64I-NEXT:    sll a1, a1, a2
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:  .LBB6_3:
; RV64I-NEXT:    srai a1, a4, 63
; RV64I-NEXT:    and a1, a1, a3
; RV64I-NEXT:    ret
  %1 = lshr i128 %a, %b
  ret i128 %1
}

define i128 @ashr128(i128 %a, i128 %b) nounwind {
; RV32I-LABEL: ashr128:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    lw a2, 0(a2)
; RV32I-NEXT:    lw a3, 12(a1)
; RV32I-NEXT:    lw a4, 8(a1)
; RV32I-NEXT:    lw a5, 4(a1)
; RV32I-NEXT:    lw a1, 0(a1)
; RV32I-NEXT:    sb a3, 12(sp)
; RV32I-NEXT:    sb a4, 8(sp)
; RV32I-NEXT:    sb a5, 4(sp)
; RV32I-NEXT:    sb a1, 0(sp)
; RV32I-NEXT:    srai a6, a3, 31
; RV32I-NEXT:    sb a6, 28(sp)
; RV32I-NEXT:    sb a6, 24(sp)
; RV32I-NEXT:    sb a6, 20(sp)
; RV32I-NEXT:    sb a6, 16(sp)
; RV32I-NEXT:    srli a7, a3, 24
; RV32I-NEXT:    sb a7, 15(sp)
; RV32I-NEXT:    srli a7, a3, 16
; RV32I-NEXT:    sb a7, 14(sp)
; RV32I-NEXT:    srli a3, a3, 8
; RV32I-NEXT:    sb a3, 13(sp)
; RV32I-NEXT:    srli a3, a4, 24
; RV32I-NEXT:    sb a3, 11(sp)
; RV32I-NEXT:    srli a3, a4, 16
; RV32I-NEXT:    sb a3, 10(sp)
; RV32I-NEXT:    srli a4, a4, 8
; RV32I-NEXT:    sb a4, 9(sp)
; RV32I-NEXT:    srli a3, a5, 24
; RV32I-NEXT:    sb a3, 7(sp)
; RV32I-NEXT:    srli a3, a5, 16
; RV32I-NEXT:    sb a3, 6(sp)
; RV32I-NEXT:    srli a5, a5, 8
; RV32I-NEXT:    sb a5, 5(sp)
; RV32I-NEXT:    srli a3, a1, 24
; RV32I-NEXT:    sb a3, 3(sp)
; RV32I-NEXT:    srli a3, a1, 16
; RV32I-NEXT:    sb a3, 2(sp)
; RV32I-NEXT:    srli a1, a1, 8
; RV32I-NEXT:    sb a1, 1(sp)
; RV32I-NEXT:    srli a1, a6, 24
; RV32I-NEXT:    sb a1, 31(sp)
; RV32I-NEXT:    srli a3, a6, 16
; RV32I-NEXT:    sb a3, 30(sp)
; RV32I-NEXT:    srli a4, a6, 8
; RV32I-NEXT:    sb a4, 29(sp)
; RV32I-NEXT:    sb a1, 27(sp)
; RV32I-NEXT:    sb a3, 26(sp)
; RV32I-NEXT:    sb a4, 25(sp)
; RV32I-NEXT:    sb a1, 23(sp)
; RV32I-NEXT:    sb a3, 22(sp)
; RV32I-NEXT:    sb a4, 21(sp)
; RV32I-NEXT:    sb a1, 19(sp)
; RV32I-NEXT:    sb a3, 18(sp)
; RV32I-NEXT:    sb a4, 17(sp)
; RV32I-NEXT:    slli a1, a2, 25
; RV32I-NEXT:    srli a1, a1, 28
; RV32I-NEXT:    mv a3, sp
; RV32I-NEXT:    add a1, a3, a1
; RV32I-NEXT:    lbu a3, 1(a1)
; RV32I-NEXT:    lbu a4, 0(a1)
; RV32I-NEXT:    lbu a5, 2(a1)
; RV32I-NEXT:    lbu a6, 3(a1)
; RV32I-NEXT:    slli a3, a3, 8
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    slli a5, a5, 16
; RV32I-NEXT:    slli a6, a6, 24
; RV32I-NEXT:    or a4, a6, a5
; RV32I-NEXT:    or a3, a4, a3
; RV32I-NEXT:    andi a2, a2, 7
; RV32I-NEXT:    srl a3, a3, a2
; RV32I-NEXT:    lbu a4, 5(a1)
; RV32I-NEXT:    lbu a5, 4(a1)
; RV32I-NEXT:    lbu a6, 6(a1)
; RV32I-NEXT:    lbu a7, 7(a1)
; RV32I-NEXT:    slli a4, a4, 8
; RV32I-NEXT:    or a4, a4, a5
; RV32I-NEXT:    slli a6, a6, 16
; RV32I-NEXT:    slli a7, a7, 24
; RV32I-NEXT:    or a5, a7, a6
; RV32I-NEXT:    or a4, a5, a4
; RV32I-NEXT:    slli a5, a4, 1
; RV32I-NEXT:    xori a6, a2, 31
; RV32I-NEXT:    sll a5, a5, a6
; RV32I-NEXT:    or a3, a3, a5
; RV32I-NEXT:    srl a4, a4, a2
; RV32I-NEXT:    lbu a5, 9(a1)
; RV32I-NEXT:    lbu a7, 8(a1)
; RV32I-NEXT:    lbu t0, 10(a1)
; RV32I-NEXT:    lbu t1, 11(a1)
; RV32I-NEXT:    slli a5, a5, 8
; RV32I-NEXT:    or a5, a5, a7
; RV32I-NEXT:    slli t0, t0, 16
; RV32I-NEXT:    slli t1, t1, 24
; RV32I-NEXT:    or a7, t1, t0
; RV32I-NEXT:    or a5, a7, a5
; RV32I-NEXT:    slli a7, a5, 1
; RV32I-NEXT:    not t0, a2
; RV32I-NEXT:    lbu t1, 13(a1)
; RV32I-NEXT:    sll a7, a7, t0
; RV32I-NEXT:    or a4, a4, a7
; RV32I-NEXT:    lbu a7, 12(a1)
; RV32I-NEXT:    slli t1, t1, 8
; RV32I-NEXT:    lbu t0, 14(a1)
; RV32I-NEXT:    lbu a1, 15(a1)
; RV32I-NEXT:    or a7, t1, a7
; RV32I-NEXT:    srl a5, a5, a2
; RV32I-NEXT:    slli t0, t0, 16
; RV32I-NEXT:    slli a1, a1, 24
; RV32I-NEXT:    or a1, a1, t0
; RV32I-NEXT:    or a1, a1, a7
; RV32I-NEXT:    slli a7, a1, 1
; RV32I-NEXT:    sll a6, a7, a6
; RV32I-NEXT:    or a5, a5, a6
; RV32I-NEXT:    sra a1, a1, a2
; RV32I-NEXT:    sw a1, 12(a0)
; RV32I-NEXT:    sw a5, 8(a0)
; RV32I-NEXT:    sw a4, 4(a0)
; RV32I-NEXT:    sw a3, 0(a0)
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ashr128:
; RV64I:       # %bb.0:
; RV64I-NEXT:    mv a3, a1
; RV64I-NEXT:    addi a4, a2, -64
; RV64I-NEXT:    sra a1, a1, a2
; RV64I-NEXT:    bltz a4, .LBB7_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    srai a3, a3, 63
; RV64I-NEXT:    mv a0, a1
; RV64I-NEXT:    mv a1, a3
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB7_2:
; RV64I-NEXT:    srl a0, a0, a2
; RV64I-NEXT:    not a2, a2
; RV64I-NEXT:    slli a3, a3, 1
; RV64I-NEXT:    sll a2, a3, a2
; RV64I-NEXT:    or a0, a0, a2
; RV64I-NEXT:    ret
  %1 = ashr i128 %a, %b
  ret i128 %1
}

define i128 @shl128(i128 %a, i128 %b) nounwind {
; RV32I-LABEL: shl128:
; RV32I:       # %bb.0:
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    lw a2, 0(a2)
; RV32I-NEXT:    lw a3, 0(a1)
; RV32I-NEXT:    lw a4, 4(a1)
; RV32I-NEXT:    lw a5, 8(a1)
; RV32I-NEXT:    lw a1, 12(a1)
; RV32I-NEXT:    sb zero, 15(sp)
; RV32I-NEXT:    sb zero, 14(sp)
; RV32I-NEXT:    sb zero, 13(sp)
; RV32I-NEXT:    sb zero, 12(sp)
; RV32I-NEXT:    sb zero, 11(sp)
; RV32I-NEXT:    sb zero, 10(sp)
; RV32I-NEXT:    sb zero, 9(sp)
; RV32I-NEXT:    sb zero, 8(sp)
; RV32I-NEXT:    sb zero, 7(sp)
; RV32I-NEXT:    sb zero, 6(sp)
; RV32I-NEXT:    sb zero, 5(sp)
; RV32I-NEXT:    sb zero, 4(sp)
; RV32I-NEXT:    sb zero, 3(sp)
; RV32I-NEXT:    sb zero, 2(sp)
; RV32I-NEXT:    sb zero, 1(sp)
; RV32I-NEXT:    sb zero, 0(sp)
; RV32I-NEXT:    sb a1, 28(sp)
; RV32I-NEXT:    sb a5, 24(sp)
; RV32I-NEXT:    sb a4, 20(sp)
; RV32I-NEXT:    sb a3, 16(sp)
; RV32I-NEXT:    srli a6, a1, 24
; RV32I-NEXT:    sb a6, 31(sp)
; RV32I-NEXT:    srli a6, a1, 16
; RV32I-NEXT:    sb a6, 30(sp)
; RV32I-NEXT:    srli a1, a1, 8
; RV32I-NEXT:    sb a1, 29(sp)
; RV32I-NEXT:    srli a1, a5, 24
; RV32I-NEXT:    sb a1, 27(sp)
; RV32I-NEXT:    srli a1, a5, 16
; RV32I-NEXT:    sb a1, 26(sp)
; RV32I-NEXT:    srli a5, a5, 8
; RV32I-NEXT:    sb a5, 25(sp)
; RV32I-NEXT:    srli a1, a4, 24
; RV32I-NEXT:    sb a1, 23(sp)
; RV32I-NEXT:    srli a1, a4, 16
; RV32I-NEXT:    sb a1, 22(sp)
; RV32I-NEXT:    srli a4, a4, 8
; RV32I-NEXT:    sb a4, 21(sp)
; RV32I-NEXT:    srli a1, a3, 24
; RV32I-NEXT:    sb a1, 19(sp)
; RV32I-NEXT:    srli a1, a3, 16
; RV32I-NEXT:    sb a1, 18(sp)
; RV32I-NEXT:    srli a3, a3, 8
; RV32I-NEXT:    sb a3, 17(sp)
; RV32I-NEXT:    slli a1, a2, 25
; RV32I-NEXT:    srli a1, a1, 28
; RV32I-NEXT:    addi a3, sp, 16
; RV32I-NEXT:    sub a1, a3, a1
; RV32I-NEXT:    lbu a3, 5(a1)
; RV32I-NEXT:    lbu a4, 4(a1)
; RV32I-NEXT:    lbu a5, 6(a1)
; RV32I-NEXT:    lbu a6, 7(a1)
; RV32I-NEXT:    slli a3, a3, 8
; RV32I-NEXT:    or a3, a3, a4
; RV32I-NEXT:    slli a5, a5, 16
; RV32I-NEXT:    slli a6, a6, 24
; RV32I-NEXT:    or a4, a6, a5
; RV32I-NEXT:    or a3, a4, a3
; RV32I-NEXT:    andi a2, a2, 7
; RV32I-NEXT:    sll a4, a3, a2
; RV32I-NEXT:    lbu a5, 1(a1)
; RV32I-NEXT:    lbu a6, 0(a1)
; RV32I-NEXT:    lbu a7, 2(a1)
; RV32I-NEXT:    lbu t0, 3(a1)
; RV32I-NEXT:    slli a5, a5, 8
; RV32I-NEXT:    or a5, a5, a6
; RV32I-NEXT:    slli a7, a7, 16
; RV32I-NEXT:    slli t0, t0, 24
; RV32I-NEXT:    or a6, t0, a7
; RV32I-NEXT:    or a5, a6, a5
; RV32I-NEXT:    srli a6, a5, 1
; RV32I-NEXT:    xori a7, a2, 31
; RV32I-NEXT:    srl a6, a6, a7
; RV32I-NEXT:    or a4, a4, a6
; RV32I-NEXT:    lbu a6, 9(a1)
; RV32I-NEXT:    lbu t0, 8(a1)
; RV32I-NEXT:    lbu t1, 10(a1)
; RV32I-NEXT:    lbu t2, 11(a1)
; RV32I-NEXT:    slli a6, a6, 8
; RV32I-NEXT:    or a6, a6, t0
; RV32I-NEXT:    slli t1, t1, 16
; RV32I-NEXT:    slli t2, t2, 24
; RV32I-NEXT:    or t0, t2, t1
; RV32I-NEXT:    or a6, t0, a6
; RV32I-NEXT:    sll t0, a6, a2
; RV32I-NEXT:    srli a3, a3, 1
; RV32I-NEXT:    not t1, a2
; RV32I-NEXT:    srl a3, a3, t1
; RV32I-NEXT:    or a3, t0, a3
; RV32I-NEXT:    lbu t0, 13(a1)
; RV32I-NEXT:    lbu t1, 12(a1)
; RV32I-NEXT:    lbu t2, 14(a1)
; RV32I-NEXT:    lbu a1, 15(a1)
; RV32I-NEXT:    slli t0, t0, 8
; RV32I-NEXT:    or t0, t0, t1
; RV32I-NEXT:    slli t2, t2, 16
; RV32I-NEXT:    slli a1, a1, 24
; RV32I-NEXT:    or a1, a1, t2
; RV32I-NEXT:    or a1, a1, t0
; RV32I-NEXT:    sll a1, a1, a2
; RV32I-NEXT:    srli a6, a6, 1
; RV32I-NEXT:    srl a6, a6, a7
; RV32I-NEXT:    or a1, a1, a6
; RV32I-NEXT:    sll a2, a5, a2
; RV32I-NEXT:    sw a2, 0(a0)
; RV32I-NEXT:    sw a1, 12(a0)
; RV32I-NEXT:    sw a3, 8(a0)
; RV32I-NEXT:    sw a4, 4(a0)
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: shl128:
; RV64I:       # %bb.0:
; RV64I-NEXT:    addi a4, a2, -64
; RV64I-NEXT:    sll a3, a0, a2
; RV64I-NEXT:    bltz a4, .LBB8_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a1, a3
; RV64I-NEXT:    j .LBB8_3
; RV64I-NEXT:  .LBB8_2:
; RV64I-NEXT:    sll a1, a1, a2
; RV64I-NEXT:    not a2, a2
; RV64I-NEXT:    srli a0, a0, 1
; RV64I-NEXT:    srl a0, a0, a2
; RV64I-NEXT:    or a1, a1, a0
; RV64I-NEXT:  .LBB8_3:
; RV64I-NEXT:    srai a0, a4, 63
; RV64I-NEXT:    and a0, a0, a3
; RV64I-NEXT:    ret
  %1 = shl i128 %a, %b
  ret i128 %1
}

define i64 @fshr64_minsize(i64 %a, i64 %b) minsize nounwind {
; RV32I-LABEL: fshr64_minsize:
; RV32I:       # %bb.0:
; RV32I-NEXT:    andi a4, a2, 32
; RV32I-NEXT:    mv a3, a0
; RV32I-NEXT:    beqz a4, .LBB9_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv a3, a1
; RV32I-NEXT:  .LBB9_2:
; RV32I-NEXT:    srl a5, a3, a2
; RV32I-NEXT:    beqz a4, .LBB9_4
; RV32I-NEXT:  # %bb.3:
; RV32I-NEXT:    mv a1, a0
; RV32I-NEXT:  .LBB9_4:
; RV32I-NEXT:    slli a0, a1, 1
; RV32I-NEXT:    not a4, a2
; RV32I-NEXT:    sll a0, a0, a4
; RV32I-NEXT:    or a0, a0, a5
; RV32I-NEXT:    srl a1, a1, a2
; RV32I-NEXT:    slli a3, a3, 1
; RV32I-NEXT:    sll a2, a3, a4
; RV32I-NEXT:    or a1, a2, a1
; RV32I-NEXT:    ret
;
; RV64I-LABEL: fshr64_minsize:
; RV64I:       # %bb.0:
; RV64I-NEXT:    srl a2, a0, a1
; RV64I-NEXT:    negw a1, a1
; RV64I-NEXT:    sll a0, a0, a1
; RV64I-NEXT:    or a0, a2, a0
; RV64I-NEXT:    ret
  %res = tail call i64 @llvm.fshr.i64(i64 %a, i64 %a, i64 %b)
  ret i64 %res
}

define i128 @fshr128_minsize(i128 %a, i128 %b) minsize nounwind {
; RV32I-LABEL: fshr128_minsize:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lw a3, 8(a1)
; RV32I-NEXT:    lw t2, 0(a1)
; RV32I-NEXT:    lw a2, 0(a2)
; RV32I-NEXT:    lw a7, 4(a1)
; RV32I-NEXT:    lw a1, 12(a1)
; RV32I-NEXT:    andi t1, a2, 64
; RV32I-NEXT:    mv t0, a7
; RV32I-NEXT:    mv a4, t2
; RV32I-NEXT:    beqz t1, .LBB10_2
; RV32I-NEXT:  # %bb.1:
; RV32I-NEXT:    mv t0, a1
; RV32I-NEXT:    mv a4, a3
; RV32I-NEXT:  .LBB10_2:
; RV32I-NEXT:    andi a6, a2, 32
; RV32I-NEXT:    mv a5, a4
; RV32I-NEXT:    bnez a6, .LBB10_13
; RV32I-NEXT:  # %bb.3:
; RV32I-NEXT:    bnez t1, .LBB10_14
; RV32I-NEXT:  .LBB10_4:
; RV32I-NEXT:    beqz a6, .LBB10_6
; RV32I-NEXT:  .LBB10_5:
; RV32I-NEXT:    mv t0, a3
; RV32I-NEXT:  .LBB10_6:
; RV32I-NEXT:    slli t3, t0, 1
; RV32I-NEXT:    not t2, a2
; RV32I-NEXT:    beqz t1, .LBB10_8
; RV32I-NEXT:  # %bb.7:
; RV32I-NEXT:    mv a1, a7
; RV32I-NEXT:  .LBB10_8:
; RV32I-NEXT:    srl a7, a5, a2
; RV32I-NEXT:    sll t1, t3, t2
; RV32I-NEXT:    srl t0, t0, a2
; RV32I-NEXT:    beqz a6, .LBB10_10
; RV32I-NEXT:  # %bb.9:
; RV32I-NEXT:    mv a3, a1
; RV32I-NEXT:  .LBB10_10:
; RV32I-NEXT:    or a7, t1, a7
; RV32I-NEXT:    slli t1, a3, 1
; RV32I-NEXT:    sll t1, t1, t2
; RV32I-NEXT:    or t0, t1, t0
; RV32I-NEXT:    srl a3, a3, a2
; RV32I-NEXT:    beqz a6, .LBB10_12
; RV32I-NEXT:  # %bb.11:
; RV32I-NEXT:    mv a1, a4
; RV32I-NEXT:  .LBB10_12:
; RV32I-NEXT:    slli a4, a1, 1
; RV32I-NEXT:    sll a4, a4, t2
; RV32I-NEXT:    or a3, a4, a3
; RV32I-NEXT:    srl a1, a1, a2
; RV32I-NEXT:    slli a5, a5, 1
; RV32I-NEXT:    sll a2, a5, t2
; RV32I-NEXT:    or a1, a2, a1
; RV32I-NEXT:    sw a1, 12(a0)
; RV32I-NEXT:    sw a3, 8(a0)
; RV32I-NEXT:    sw t0, 4(a0)
; RV32I-NEXT:    sw a7, 0(a0)
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB10_13:
; RV32I-NEXT:    mv a5, t0
; RV32I-NEXT:    beqz t1, .LBB10_4
; RV32I-NEXT:  .LBB10_14:
; RV32I-NEXT:    mv a3, t2
; RV32I-NEXT:    bnez a6, .LBB10_5
; RV32I-NEXT:    j .LBB10_6
;
; RV64I-LABEL: fshr128_minsize:
; RV64I:       # %bb.0:
; RV64I-NEXT:    andi a4, a2, 64
; RV64I-NEXT:    mv a3, a0
; RV64I-NEXT:    beqz a4, .LBB10_2
; RV64I-NEXT:  # %bb.1:
; RV64I-NEXT:    mv a3, a1
; RV64I-NEXT:  .LBB10_2:
; RV64I-NEXT:    srl a5, a3, a2
; RV64I-NEXT:    beqz a4, .LBB10_4
; RV64I-NEXT:  # %bb.3:
; RV64I-NEXT:    mv a1, a0
; RV64I-NEXT:  .LBB10_4:
; RV64I-NEXT:    slli a0, a1, 1
; RV64I-NEXT:    not a4, a2
; RV64I-NEXT:    sll a0, a0, a4
; RV64I-NEXT:    or a0, a0, a5
; RV64I-NEXT:    srl a1, a1, a2
; RV64I-NEXT:    slli a3, a3, 1
; RV64I-NEXT:    sll a2, a3, a4
; RV64I-NEXT:    or a1, a2, a1
; RV64I-NEXT:    ret
  %res = tail call i128 @llvm.fshr.i128(i128 %a, i128 %a, i128 %b)
  ret i128 %res
}
