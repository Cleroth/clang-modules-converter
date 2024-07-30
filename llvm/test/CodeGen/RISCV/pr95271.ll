; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck -check-prefix=RV32I %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s | FileCheck -check-prefix=RV64I %s

define i32 @PR95271(ptr %p) {
; RV32I-LABEL: PR95271:
; RV32I:       # %bb.0:
; RV32I-NEXT:    lw a0, 0(a0)
; RV32I-NEXT:    addi a0, a0, 1
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi a2, a2, 1365
; RV32I-NEXT:    and a1, a1, a2
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi a1, a1, 819
; RV32I-NEXT:    and a2, a0, a1
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    add a0, a2, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi a1, a1, -241
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 8
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    slli a1, a0, 16
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    ret
;
; RV64I-LABEL: PR95271:
; RV64I:       # %bb.0:
; RV64I-NEXT:    lw a0, 0(a0)
; RV64I-NEXT:    addiw a1, a0, 1
; RV64I-NEXT:    addi a0, a0, 1
; RV64I-NEXT:    srli a0, a0, 1
; RV64I-NEXT:    lui a2, 349525
; RV64I-NEXT:    addiw a2, a2, 1365
; RV64I-NEXT:    and a0, a0, a2
; RV64I-NEXT:    sub a1, a1, a0
; RV64I-NEXT:    lui a0, 209715
; RV64I-NEXT:    addiw a0, a0, 819
; RV64I-NEXT:    and a2, a1, a0
; RV64I-NEXT:    srli a1, a1, 2
; RV64I-NEXT:    and a0, a1, a0
; RV64I-NEXT:    add a0, a2, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 61681
; RV64I-NEXT:    addi a1, a1, -241
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    slli a1, a0, 8
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    slli a1, a0, 16
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    srliw a0, a0, 24
; RV64I-NEXT:    ret
  %load = load i32, ptr %p, align 4
  %inc = add i32 %load, 1
  %pop = tail call i32 @llvm.ctpop.i32(i32 %inc)
  ret i32 %pop
}
