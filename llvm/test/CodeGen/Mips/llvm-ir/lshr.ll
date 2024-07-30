; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips2 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r2 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r3 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r5 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32R2
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r6 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS32R6
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips3 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS3
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips4 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS4
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r2 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r3 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r5 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R2
; RUN: llc < %s -mtriple=mips64-unknown-linux-gnu -mcpu=mips64r6 -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MIPS64R6
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r3 -mattr=+micromips -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MMR3
; RUN: llc < %s -mtriple=mips-unknown-linux-gnu -mcpu=mips32r6 -mattr=+micromips -relocation-model=pic | FileCheck %s \
; RUN:    -check-prefix=MMR6

define signext i1 @lshr_i1(i1 signext %a, i1 signext %b) {
; MIPS2-LABEL: lshr_i1:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    move $2, $4
;
; MIPS32-LABEL: lshr_i1:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    move $2, $4
;
; MIPS32R2-LABEL: lshr_i1:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    move $2, $4
;
; MIPS32R6-LABEL: lshr_i1:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    move $2, $4
;
; MIPS3-LABEL: lshr_i1:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    move $2, $4
;
; MIPS4-LABEL: lshr_i1:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    move $2, $4
;
; MIPS64-LABEL: lshr_i1:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    move $2, $4
;
; MIPS64R2-LABEL: lshr_i1:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    move $2, $4
;
; MIPS64R6-LABEL: lshr_i1:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    move $2, $4
;
; MMR3-LABEL: lshr_i1:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    move $2, $4
; MMR3-NEXT:    jrc $ra
;
; MMR6-LABEL: lshr_i1:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    move $2, $4
; MMR6-NEXT:    jrc $ra
entry:

  %r = lshr i1 %a, %b
  ret i1 %r
}

define zeroext i8 @lshr_i8(i8 zeroext %a, i8 zeroext %b) {
; MIPS2-LABEL: lshr_i8:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    srlv $2, $4, $5
;
; MIPS32-LABEL: lshr_i8:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    srlv $2, $4, $5
;
; MIPS32R2-LABEL: lshr_i8:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    srlv $2, $4, $5
;
; MIPS32R6-LABEL: lshr_i8:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    srlv $2, $4, $5
;
; MIPS3-LABEL: lshr_i8:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    srlv $2, $4, $5
;
; MIPS4-LABEL: lshr_i8:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    srlv $2, $4, $5
;
; MIPS64-LABEL: lshr_i8:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    srlv $2, $4, $5
;
; MIPS64R2-LABEL: lshr_i8:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    srlv $2, $4, $5
;
; MIPS64R6-LABEL: lshr_i8:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    srlv $2, $4, $5
;
; MMR3-LABEL: lshr_i8:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    srlv $2, $4, $5
;
; MMR6-LABEL: lshr_i8:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    srlv $2, $4, $5
; MMR6-NEXT:    jrc $ra
entry:

  %r = lshr i8 %a, %b
  ret i8 %r
}

define zeroext i16 @lshr_i16(i16 zeroext %a, i16 zeroext %b) {
; MIPS2-LABEL: lshr_i16:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    srlv $2, $4, $5
;
; MIPS32-LABEL: lshr_i16:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    srlv $2, $4, $5
;
; MIPS32R2-LABEL: lshr_i16:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    srlv $2, $4, $5
;
; MIPS32R6-LABEL: lshr_i16:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    srlv $2, $4, $5
;
; MIPS3-LABEL: lshr_i16:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    srlv $2, $4, $5
;
; MIPS4-LABEL: lshr_i16:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    srlv $2, $4, $5
;
; MIPS64-LABEL: lshr_i16:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    srlv $2, $4, $5
;
; MIPS64R2-LABEL: lshr_i16:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    srlv $2, $4, $5
;
; MIPS64R6-LABEL: lshr_i16:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    srlv $2, $4, $5
;
; MMR3-LABEL: lshr_i16:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    srlv $2, $4, $5
;
; MMR6-LABEL: lshr_i16:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    srlv $2, $4, $5
; MMR6-NEXT:    jrc $ra
entry:

  %r = lshr i16 %a, %b
  ret i16 %r
}

define signext i32 @lshr_i32(i32 signext %a, i32 signext %b) {
; MIPS2-LABEL: lshr_i32:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    srlv $2, $4, $5
;
; MIPS32-LABEL: lshr_i32:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    srlv $2, $4, $5
;
; MIPS32R2-LABEL: lshr_i32:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    srlv $2, $4, $5
;
; MIPS32R6-LABEL: lshr_i32:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    srlv $2, $4, $5
;
; MIPS3-LABEL: lshr_i32:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    srlv $2, $4, $5
;
; MIPS4-LABEL: lshr_i32:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    srlv $2, $4, $5
;
; MIPS64-LABEL: lshr_i32:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    srlv $2, $4, $5
;
; MIPS64R2-LABEL: lshr_i32:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    srlv $2, $4, $5
;
; MIPS64R6-LABEL: lshr_i32:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    srlv $2, $4, $5
;
; MMR3-LABEL: lshr_i32:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    srlv $2, $4, $5
;
; MMR6-LABEL: lshr_i32:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    srlv $2, $4, $5
; MMR6-NEXT:    jrc $ra
entry:

  %r = lshr i32 %a, %b
  ret i32 %r
}

define signext i64 @lshr_i64(i64 signext %a, i64 signext %b) {
; MIPS2-LABEL: lshr_i64:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    srlv $6, $4, $7
; MIPS2-NEXT:    andi $1, $7, 32
; MIPS2-NEXT:    bnez $1, $BB4_2
; MIPS2-NEXT:    addiu $2, $zero, 0
; MIPS2-NEXT:  # %bb.1: # %entry
; MIPS2-NEXT:    srlv $1, $5, $7
; MIPS2-NEXT:    xori $2, $7, 31
; MIPS2-NEXT:    sll $3, $4, 1
; MIPS2-NEXT:    sllv $2, $3, $2
; MIPS2-NEXT:    or $3, $2, $1
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    move $2, $6
; MIPS2-NEXT:  $BB4_2:
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    move $3, $6
;
; MIPS32-LABEL: lshr_i64:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    srlv $1, $5, $7
; MIPS32-NEXT:    xori $2, $7, 31
; MIPS32-NEXT:    sll $3, $4, 1
; MIPS32-NEXT:    sllv $2, $3, $2
; MIPS32-NEXT:    or $3, $2, $1
; MIPS32-NEXT:    srlv $2, $4, $7
; MIPS32-NEXT:    andi $1, $7, 32
; MIPS32-NEXT:    movn $3, $2, $1
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    movn $2, $zero, $1
;
; MIPS32R2-LABEL: lshr_i64:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    srlv $1, $5, $7
; MIPS32R2-NEXT:    xori $2, $7, 31
; MIPS32R2-NEXT:    sll $3, $4, 1
; MIPS32R2-NEXT:    sllv $2, $3, $2
; MIPS32R2-NEXT:    or $3, $2, $1
; MIPS32R2-NEXT:    srlv $2, $4, $7
; MIPS32R2-NEXT:    andi $1, $7, 32
; MIPS32R2-NEXT:    movn $3, $2, $1
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    movn $2, $zero, $1
;
; MIPS32R6-LABEL: lshr_i64:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    srlv $1, $5, $7
; MIPS32R6-NEXT:    xori $2, $7, 31
; MIPS32R6-NEXT:    sll $3, $4, 1
; MIPS32R6-NEXT:    sllv $2, $3, $2
; MIPS32R6-NEXT:    or $1, $2, $1
; MIPS32R6-NEXT:    andi $2, $7, 32
; MIPS32R6-NEXT:    seleqz $1, $1, $2
; MIPS32R6-NEXT:    srlv $4, $4, $7
; MIPS32R6-NEXT:    selnez $3, $4, $2
; MIPS32R6-NEXT:    or $3, $3, $1
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    seleqz $2, $4, $2
;
; MIPS3-LABEL: lshr_i64:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    dsrlv $2, $4, $5
;
; MIPS4-LABEL: lshr_i64:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    dsrlv $2, $4, $5
;
; MIPS64-LABEL: lshr_i64:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    dsrlv $2, $4, $5
;
; MIPS64R2-LABEL: lshr_i64:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    dsrlv $2, $4, $5
;
; MIPS64R6-LABEL: lshr_i64:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    dsrlv $2, $4, $5
;
; MMR3-LABEL: lshr_i64:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    srlv $2, $5, $7
; MMR3-NEXT:    xori $1, $7, 31
; MMR3-NEXT:    sll16 $3, $4, 1
; MMR3-NEXT:    sllv $3, $3, $1
; MMR3-NEXT:    or16 $3, $2
; MMR3-NEXT:    srlv $2, $4, $7
; MMR3-NEXT:    andi16 $4, $7, 32
; MMR3-NEXT:    movn $3, $2, $4
; MMR3-NEXT:    li16 $5, 0
; MMR3-NEXT:    jr $ra
; MMR3-NEXT:    movn $2, $5, $4
;
; MMR6-LABEL: lshr_i64:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    srlv $1, $5, $7
; MMR6-NEXT:    xori $2, $7, 31
; MMR6-NEXT:    sll16 $3, $4, 1
; MMR6-NEXT:    sllv $2, $3, $2
; MMR6-NEXT:    or $1, $2, $1
; MMR6-NEXT:    andi16 $2, $7, 32
; MMR6-NEXT:    seleqz $1, $1, $2
; MMR6-NEXT:    srlv $4, $4, $7
; MMR6-NEXT:    selnez $3, $4, $2
; MMR6-NEXT:    or $3, $3, $1
; MMR6-NEXT:    seleqz $2, $4, $2
; MMR6-NEXT:    jrc $ra
entry:

  %r = lshr i64 %a, %b
  ret i64 %r
}

define signext i128 @lshr_i128(i128 signext %a, i128 signext %b) {
; MIPS2-LABEL: lshr_i128:
; MIPS2:       # %bb.0: # %entry
; MIPS2-NEXT:    addiu $sp, $sp, -32
; MIPS2-NEXT:    .cfi_def_cfa_offset 32
; MIPS2-NEXT:    swl $7, 28($sp)
; MIPS2-NEXT:    swl $6, 24($sp)
; MIPS2-NEXT:    swl $5, 20($sp)
; MIPS2-NEXT:    swl $4, 16($sp)
; MIPS2-NEXT:    swl $zero, 12($sp)
; MIPS2-NEXT:    swl $zero, 8($sp)
; MIPS2-NEXT:    swl $zero, 4($sp)
; MIPS2-NEXT:    swl $zero, 0($sp)
; MIPS2-NEXT:    addiu $1, $sp, 0
; MIPS2-NEXT:    swr $7, 31($sp)
; MIPS2-NEXT:    swr $6, 27($sp)
; MIPS2-NEXT:    swr $5, 23($sp)
; MIPS2-NEXT:    swr $4, 19($sp)
; MIPS2-NEXT:    swr $zero, 15($sp)
; MIPS2-NEXT:    swr $zero, 11($sp)
; MIPS2-NEXT:    swr $zero, 7($sp)
; MIPS2-NEXT:    swr $zero, 3($sp)
; MIPS2-NEXT:    addiu $1, $1, 16
; MIPS2-NEXT:    lw $2, 60($sp)
; MIPS2-NEXT:    srl $3, $2, 3
; MIPS2-NEXT:    andi $3, $3, 15
; MIPS2-NEXT:    subu $1, $1, $3
; MIPS2-NEXT:    lwl $3, 4($1)
; MIPS2-NEXT:    lwr $3, 7($1)
; MIPS2-NEXT:    sll $4, $3, 1
; MIPS2-NEXT:    lwl $5, 8($1)
; MIPS2-NEXT:    lwr $5, 11($1)
; MIPS2-NEXT:    andi $2, $2, 7
; MIPS2-NEXT:    not $6, $2
; MIPS2-NEXT:    srlv $7, $5, $2
; MIPS2-NEXT:    sllv $4, $4, $6
; MIPS2-NEXT:    srlv $3, $3, $2
; MIPS2-NEXT:    lwl $6, 0($1)
; MIPS2-NEXT:    lwr $6, 3($1)
; MIPS2-NEXT:    sll $8, $6, 1
; MIPS2-NEXT:    xori $9, $2, 31
; MIPS2-NEXT:    sllv $8, $8, $9
; MIPS2-NEXT:    or $3, $3, $8
; MIPS2-NEXT:    or $4, $7, $4
; MIPS2-NEXT:    lwl $7, 12($1)
; MIPS2-NEXT:    lwr $7, 15($1)
; MIPS2-NEXT:    srlv $1, $7, $2
; MIPS2-NEXT:    sll $5, $5, 1
; MIPS2-NEXT:    sllv $5, $5, $9
; MIPS2-NEXT:    or $5, $1, $5
; MIPS2-NEXT:    srlv $2, $6, $2
; MIPS2-NEXT:    jr $ra
; MIPS2-NEXT:    addiu $sp, $sp, 32
;
; MIPS32-LABEL: lshr_i128:
; MIPS32:       # %bb.0: # %entry
; MIPS32-NEXT:    addiu $sp, $sp, -32
; MIPS32-NEXT:    .cfi_def_cfa_offset 32
; MIPS32-NEXT:    swl $7, 28($sp)
; MIPS32-NEXT:    swl $6, 24($sp)
; MIPS32-NEXT:    swl $5, 20($sp)
; MIPS32-NEXT:    swl $4, 16($sp)
; MIPS32-NEXT:    swl $zero, 12($sp)
; MIPS32-NEXT:    swl $zero, 8($sp)
; MIPS32-NEXT:    swl $zero, 4($sp)
; MIPS32-NEXT:    swl $zero, 0($sp)
; MIPS32-NEXT:    addiu $1, $sp, 0
; MIPS32-NEXT:    swr $7, 31($sp)
; MIPS32-NEXT:    swr $6, 27($sp)
; MIPS32-NEXT:    swr $5, 23($sp)
; MIPS32-NEXT:    swr $4, 19($sp)
; MIPS32-NEXT:    swr $zero, 15($sp)
; MIPS32-NEXT:    swr $zero, 11($sp)
; MIPS32-NEXT:    swr $zero, 7($sp)
; MIPS32-NEXT:    swr $zero, 3($sp)
; MIPS32-NEXT:    addiu $1, $1, 16
; MIPS32-NEXT:    lw $2, 60($sp)
; MIPS32-NEXT:    srl $3, $2, 3
; MIPS32-NEXT:    andi $3, $3, 15
; MIPS32-NEXT:    subu $1, $1, $3
; MIPS32-NEXT:    lwl $3, 4($1)
; MIPS32-NEXT:    lwr $3, 7($1)
; MIPS32-NEXT:    sll $4, $3, 1
; MIPS32-NEXT:    lwl $5, 8($1)
; MIPS32-NEXT:    lwr $5, 11($1)
; MIPS32-NEXT:    andi $2, $2, 7
; MIPS32-NEXT:    not $6, $2
; MIPS32-NEXT:    srlv $7, $5, $2
; MIPS32-NEXT:    sllv $4, $4, $6
; MIPS32-NEXT:    srlv $3, $3, $2
; MIPS32-NEXT:    lwl $6, 0($1)
; MIPS32-NEXT:    lwr $6, 3($1)
; MIPS32-NEXT:    sll $8, $6, 1
; MIPS32-NEXT:    xori $9, $2, 31
; MIPS32-NEXT:    sllv $8, $8, $9
; MIPS32-NEXT:    or $3, $3, $8
; MIPS32-NEXT:    or $4, $7, $4
; MIPS32-NEXT:    lwl $7, 12($1)
; MIPS32-NEXT:    lwr $7, 15($1)
; MIPS32-NEXT:    srlv $1, $7, $2
; MIPS32-NEXT:    sll $5, $5, 1
; MIPS32-NEXT:    sllv $5, $5, $9
; MIPS32-NEXT:    or $5, $1, $5
; MIPS32-NEXT:    srlv $2, $6, $2
; MIPS32-NEXT:    jr $ra
; MIPS32-NEXT:    addiu $sp, $sp, 32
;
; MIPS32R2-LABEL: lshr_i128:
; MIPS32R2:       # %bb.0: # %entry
; MIPS32R2-NEXT:    addiu $sp, $sp, -32
; MIPS32R2-NEXT:    .cfi_def_cfa_offset 32
; MIPS32R2-NEXT:    swl $7, 28($sp)
; MIPS32R2-NEXT:    swl $6, 24($sp)
; MIPS32R2-NEXT:    swl $5, 20($sp)
; MIPS32R2-NEXT:    swl $4, 16($sp)
; MIPS32R2-NEXT:    swl $zero, 12($sp)
; MIPS32R2-NEXT:    swl $zero, 8($sp)
; MIPS32R2-NEXT:    swl $zero, 4($sp)
; MIPS32R2-NEXT:    swl $zero, 0($sp)
; MIPS32R2-NEXT:    swr $7, 31($sp)
; MIPS32R2-NEXT:    swr $6, 27($sp)
; MIPS32R2-NEXT:    swr $5, 23($sp)
; MIPS32R2-NEXT:    swr $4, 19($sp)
; MIPS32R2-NEXT:    swr $zero, 15($sp)
; MIPS32R2-NEXT:    swr $zero, 11($sp)
; MIPS32R2-NEXT:    swr $zero, 7($sp)
; MIPS32R2-NEXT:    swr $zero, 3($sp)
; MIPS32R2-NEXT:    addiu $1, $sp, 0
; MIPS32R2-NEXT:    addiu $1, $1, 16
; MIPS32R2-NEXT:    lw $2, 60($sp)
; MIPS32R2-NEXT:    ext $3, $2, 3, 4
; MIPS32R2-NEXT:    subu $1, $1, $3
; MIPS32R2-NEXT:    lwl $3, 4($1)
; MIPS32R2-NEXT:    lwr $3, 7($1)
; MIPS32R2-NEXT:    sll $4, $3, 1
; MIPS32R2-NEXT:    lwl $5, 8($1)
; MIPS32R2-NEXT:    lwr $5, 11($1)
; MIPS32R2-NEXT:    andi $2, $2, 7
; MIPS32R2-NEXT:    not $6, $2
; MIPS32R2-NEXT:    srlv $7, $5, $2
; MIPS32R2-NEXT:    sllv $4, $4, $6
; MIPS32R2-NEXT:    srlv $3, $3, $2
; MIPS32R2-NEXT:    lwl $6, 0($1)
; MIPS32R2-NEXT:    lwr $6, 3($1)
; MIPS32R2-NEXT:    sll $8, $6, 1
; MIPS32R2-NEXT:    xori $9, $2, 31
; MIPS32R2-NEXT:    sllv $8, $8, $9
; MIPS32R2-NEXT:    or $3, $3, $8
; MIPS32R2-NEXT:    or $4, $7, $4
; MIPS32R2-NEXT:    lwl $7, 12($1)
; MIPS32R2-NEXT:    lwr $7, 15($1)
; MIPS32R2-NEXT:    srlv $1, $7, $2
; MIPS32R2-NEXT:    sll $5, $5, 1
; MIPS32R2-NEXT:    sllv $5, $5, $9
; MIPS32R2-NEXT:    or $5, $1, $5
; MIPS32R2-NEXT:    srlv $2, $6, $2
; MIPS32R2-NEXT:    jr $ra
; MIPS32R2-NEXT:    addiu $sp, $sp, 32
;
; MIPS32R6-LABEL: lshr_i128:
; MIPS32R6:       # %bb.0: # %entry
; MIPS32R6-NEXT:    addiu $sp, $sp, -32
; MIPS32R6-NEXT:    .cfi_def_cfa_offset 32
; MIPS32R6-NEXT:    addiu $1, $sp, 0
; MIPS32R6-NEXT:    sw $7, 28($sp)
; MIPS32R6-NEXT:    sw $6, 24($sp)
; MIPS32R6-NEXT:    sw $5, 20($sp)
; MIPS32R6-NEXT:    sw $4, 16($sp)
; MIPS32R6-NEXT:    addiu $1, $1, 16
; MIPS32R6-NEXT:    lw $2, 60($sp)
; MIPS32R6-NEXT:    ext $3, $2, 3, 4
; MIPS32R6-NEXT:    subu $1, $1, $3
; MIPS32R6-NEXT:    sw $zero, 12($sp)
; MIPS32R6-NEXT:    sw $zero, 8($sp)
; MIPS32R6-NEXT:    sw $zero, 4($sp)
; MIPS32R6-NEXT:    sw $zero, 0($sp)
; MIPS32R6-NEXT:    lw $3, 4($1)
; MIPS32R6-NEXT:    sll $4, $3, 1
; MIPS32R6-NEXT:    lw $5, 8($1)
; MIPS32R6-NEXT:    andi $2, $2, 7
; MIPS32R6-NEXT:    not $6, $2
; MIPS32R6-NEXT:    srlv $7, $5, $2
; MIPS32R6-NEXT:    sllv $4, $4, $6
; MIPS32R6-NEXT:    srlv $3, $3, $2
; MIPS32R6-NEXT:    lw $6, 0($1)
; MIPS32R6-NEXT:    sll $8, $6, 1
; MIPS32R6-NEXT:    xori $9, $2, 31
; MIPS32R6-NEXT:    sllv $8, $8, $9
; MIPS32R6-NEXT:    or $3, $3, $8
; MIPS32R6-NEXT:    or $4, $7, $4
; MIPS32R6-NEXT:    lw $1, 12($1)
; MIPS32R6-NEXT:    srlv $1, $1, $2
; MIPS32R6-NEXT:    sll $5, $5, 1
; MIPS32R6-NEXT:    sllv $5, $5, $9
; MIPS32R6-NEXT:    or $5, $1, $5
; MIPS32R6-NEXT:    srlv $2, $6, $2
; MIPS32R6-NEXT:    jr $ra
; MIPS32R6-NEXT:    addiu $sp, $sp, 32
;
; MIPS3-LABEL: lshr_i128:
; MIPS3:       # %bb.0: # %entry
; MIPS3-NEXT:    sll $3, $7, 0
; MIPS3-NEXT:    dsrlv $6, $4, $7
; MIPS3-NEXT:    andi $1, $3, 64
; MIPS3-NEXT:    bnez $1, .LBB5_2
; MIPS3-NEXT:    daddiu $2, $zero, 0
; MIPS3-NEXT:  # %bb.1: # %entry
; MIPS3-NEXT:    dsrlv $1, $5, $7
; MIPS3-NEXT:    dsll $2, $4, 1
; MIPS3-NEXT:    xori $3, $3, 63
; MIPS3-NEXT:    dsllv $2, $2, $3
; MIPS3-NEXT:    or $3, $2, $1
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    move $2, $6
; MIPS3-NEXT:  .LBB5_2:
; MIPS3-NEXT:    jr $ra
; MIPS3-NEXT:    move $3, $6
;
; MIPS4-LABEL: lshr_i128:
; MIPS4:       # %bb.0: # %entry
; MIPS4-NEXT:    dsrlv $1, $5, $7
; MIPS4-NEXT:    dsll $2, $4, 1
; MIPS4-NEXT:    sll $5, $7, 0
; MIPS4-NEXT:    xori $3, $5, 63
; MIPS4-NEXT:    dsllv $2, $2, $3
; MIPS4-NEXT:    or $3, $2, $1
; MIPS4-NEXT:    dsrlv $2, $4, $7
; MIPS4-NEXT:    andi $1, $5, 64
; MIPS4-NEXT:    movn $3, $2, $1
; MIPS4-NEXT:    jr $ra
; MIPS4-NEXT:    movn $2, $zero, $1
;
; MIPS64-LABEL: lshr_i128:
; MIPS64:       # %bb.0: # %entry
; MIPS64-NEXT:    dsrlv $1, $5, $7
; MIPS64-NEXT:    dsll $2, $4, 1
; MIPS64-NEXT:    sll $5, $7, 0
; MIPS64-NEXT:    xori $3, $5, 63
; MIPS64-NEXT:    dsllv $2, $2, $3
; MIPS64-NEXT:    or $3, $2, $1
; MIPS64-NEXT:    dsrlv $2, $4, $7
; MIPS64-NEXT:    andi $1, $5, 64
; MIPS64-NEXT:    movn $3, $2, $1
; MIPS64-NEXT:    jr $ra
; MIPS64-NEXT:    movn $2, $zero, $1
;
; MIPS64R2-LABEL: lshr_i128:
; MIPS64R2:       # %bb.0: # %entry
; MIPS64R2-NEXT:    dsrlv $1, $5, $7
; MIPS64R2-NEXT:    dsll $2, $4, 1
; MIPS64R2-NEXT:    sll $5, $7, 0
; MIPS64R2-NEXT:    xori $3, $5, 63
; MIPS64R2-NEXT:    dsllv $2, $2, $3
; MIPS64R2-NEXT:    or $3, $2, $1
; MIPS64R2-NEXT:    dsrlv $2, $4, $7
; MIPS64R2-NEXT:    andi $1, $5, 64
; MIPS64R2-NEXT:    movn $3, $2, $1
; MIPS64R2-NEXT:    jr $ra
; MIPS64R2-NEXT:    movn $2, $zero, $1
;
; MIPS64R6-LABEL: lshr_i128:
; MIPS64R6:       # %bb.0: # %entry
; MIPS64R6-NEXT:    dsrlv $1, $5, $7
; MIPS64R6-NEXT:    dsll $2, $4, 1
; MIPS64R6-NEXT:    sll $3, $7, 0
; MIPS64R6-NEXT:    xori $5, $3, 63
; MIPS64R6-NEXT:    dsllv $2, $2, $5
; MIPS64R6-NEXT:    or $1, $2, $1
; MIPS64R6-NEXT:    andi $2, $3, 64
; MIPS64R6-NEXT:    sll $2, $2, 0
; MIPS64R6-NEXT:    seleqz $1, $1, $2
; MIPS64R6-NEXT:    dsrlv $4, $4, $7
; MIPS64R6-NEXT:    selnez $3, $4, $2
; MIPS64R6-NEXT:    or $3, $3, $1
; MIPS64R6-NEXT:    jr $ra
; MIPS64R6-NEXT:    seleqz $2, $4, $2
;
; MMR3-LABEL: lshr_i128:
; MMR3:       # %bb.0: # %entry
; MMR3-NEXT:    addiusp -40
; MMR3-NEXT:    .cfi_def_cfa_offset 40
; MMR3-NEXT:    swp $16, 32($sp)
; MMR3-NEXT:    .cfi_offset 17, -4
; MMR3-NEXT:    .cfi_offset 16, -8
; MMR3-NEXT:    swl $7, 28($sp)
; MMR3-NEXT:    swl $6, 24($sp)
; MMR3-NEXT:    swl $5, 20($sp)
; MMR3-NEXT:    li16 $2, 0
; MMR3-NEXT:    swl $4, 16($sp)
; MMR3-NEXT:    swl $2, 12($sp)
; MMR3-NEXT:    swl $2, 8($sp)
; MMR3-NEXT:    swl $2, 4($sp)
; MMR3-NEXT:    swl $2, 0($sp)
; MMR3-NEXT:    swr $7, 31($sp)
; MMR3-NEXT:    swr $6, 27($sp)
; MMR3-NEXT:    swr $5, 23($sp)
; MMR3-NEXT:    swr $4, 19($sp)
; MMR3-NEXT:    swr $2, 15($sp)
; MMR3-NEXT:    swr $2, 11($sp)
; MMR3-NEXT:    swr $2, 7($sp)
; MMR3-NEXT:    swr $2, 3($sp)
; MMR3-NEXT:    addiur1sp $2, 0
; MMR3-NEXT:    addiur2 $2, $2, 16
; MMR3-NEXT:    lw $3, 68($sp)
; MMR3-NEXT:    ext $4, $3, 3, 4
; MMR3-NEXT:    subu16 $2, $2, $4
; MMR3-NEXT:    lwl $7, 4($2)
; MMR3-NEXT:    lwr $7, 7($2)
; MMR3-NEXT:    sll16 $4, $7, 1
; MMR3-NEXT:    lwl $5, 8($2)
; MMR3-NEXT:    lwr $5, 11($2)
; MMR3-NEXT:    andi16 $6, $3, 7
; MMR3-NEXT:    not16 $3, $6
; MMR3-NEXT:    andi16 $3, $3, 31
; MMR3-NEXT:    srlv $16, $5, $6
; MMR3-NEXT:    sllv $4, $4, $3
; MMR3-NEXT:    srlv $17, $7, $6
; MMR3-NEXT:    lwl $7, 0($2)
; MMR3-NEXT:    lwr $7, 3($2)
; MMR3-NEXT:    sll16 $3, $7, 1
; MMR3-NEXT:    xori $1, $6, 31
; MMR3-NEXT:    sllv $3, $3, $1
; MMR3-NEXT:    or16 $3, $17
; MMR3-NEXT:    or16 $4, $16
; MMR3-NEXT:    lwl $8, 12($2)
; MMR3-NEXT:    lwr $8, 15($2)
; MMR3-NEXT:    srlv $2, $8, $6
; MMR3-NEXT:    sll16 $5, $5, 1
; MMR3-NEXT:    sllv $5, $5, $1
; MMR3-NEXT:    or16 $5, $2
; MMR3-NEXT:    srlv $2, $7, $6
; MMR3-NEXT:    lwp $16, 32($sp)
; MMR3-NEXT:    addiusp 40
; MMR3-NEXT:    jrc $ra
;
; MMR6-LABEL: lshr_i128:
; MMR6:       # %bb.0: # %entry
; MMR6-NEXT:    addiu $sp, $sp, -40
; MMR6-NEXT:    .cfi_def_cfa_offset 40
; MMR6-NEXT:    sw $16, 36($sp) # 4-byte Folded Spill
; MMR6-NEXT:    .cfi_offset 16, -4
; MMR6-NEXT:    li16 $2, 0
; MMR6-NEXT:    sw $7, 32($sp)
; MMR6-NEXT:    sw $6, 28($sp)
; MMR6-NEXT:    sw $5, 24($sp)
; MMR6-NEXT:    sw $4, 20($sp)
; MMR6-NEXT:    sw $2, 16($sp)
; MMR6-NEXT:    sw $2, 12($sp)
; MMR6-NEXT:    sw $2, 8($sp)
; MMR6-NEXT:    sw $2, 4($sp)
; MMR6-NEXT:    addiu $2, $sp, 4
; MMR6-NEXT:    addiur2 $2, $2, 16
; MMR6-NEXT:    lw $3, 68($sp)
; MMR6-NEXT:    ext $4, $3, 3, 4
; MMR6-NEXT:    subu16 $5, $2, $4
; MMR6-NEXT:    lw16 $4, 4($5)
; MMR6-NEXT:    sll16 $6, $4, 1
; MMR6-NEXT:    lw16 $7, 8($5)
; MMR6-NEXT:    andi16 $2, $3, 7
; MMR6-NEXT:    not16 $3, $2
; MMR6-NEXT:    andi16 $3, $3, 31
; MMR6-NEXT:    srlv $1, $7, $2
; MMR6-NEXT:    sllv $6, $6, $3
; MMR6-NEXT:    srlv $3, $4, $2
; MMR6-NEXT:    lw16 $16, 0($5)
; MMR6-NEXT:    sll16 $4, $16, 1
; MMR6-NEXT:    xori $8, $2, 31
; MMR6-NEXT:    sllv $4, $4, $8
; MMR6-NEXT:    or $3, $3, $4
; MMR6-NEXT:    or $4, $1, $6
; MMR6-NEXT:    lw16 $5, 12($5)
; MMR6-NEXT:    srlv $1, $5, $2
; MMR6-NEXT:    sll16 $5, $7, 1
; MMR6-NEXT:    sllv $5, $5, $8
; MMR6-NEXT:    or $5, $1, $5
; MMR6-NEXT:    srlv $2, $16, $2
; MMR6-NEXT:    lw $16, 36($sp) # 4-byte Folded Reload
; MMR6-NEXT:    addiu $sp, $sp, 40
; MMR6-NEXT:    jrc $ra
entry:

; o32 shouldn't use TImode helpers.
; GP32-NOT:       lw        $25, %call16(__lshrti3)($gp)
; MM-NOT:         lw        $25, %call16(__lshrti3)($2)

  %r = lshr i128 %a, %b
  ret i128 %r
}