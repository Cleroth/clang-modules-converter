; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -verify-machineinstrs -target-abi=ilp32d < %s \
; RUN:   | FileCheck -check-prefixes=RV32-ALL,F-ABI-ALL,D-ABI-ALL,RV32IFD-ILP32D %s
; RUN: llc -mtriple=riscv32 -mattr=+f -verify-machineinstrs -target-abi=ilp32f < %s \
; RUN:   | FileCheck -check-prefixes=RV32-ALL,F-ABI-ALL,RV32IF-ILP32F %s
; RUN: llc -mtriple=riscv32 -mattr=+d -verify-machineinstrs -target-abi=ilp32 < %s \
; RUN:   | FileCheck -check-prefixes=RV32-ALL,RV32-ILP32-ALL,RV32IFD-ILP32 %s
; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV32-ALL,RV32-ILP32-ALL,RV32I-ILP32 %s
; RUN: llc -mtriple=riscv64 -mattr=+d -verify-machineinstrs -target-abi=lp64d < %s \
; RUN:   | FileCheck -check-prefixes=RV64-ALL,F-ABI-ALL,D-ABI-ALL,RV64IFD-LP64D %s
; RUN: llc -mtriple=riscv64 -mattr=+f -verify-machineinstrs -target-abi=lp64f < %s \
; RUN:   | FileCheck -check-prefixes=RV64-ALL,F-ABI-ALL,RV64IF-LP64F %s
; RUN: llc -mtriple=riscv64 -mattr=+d -verify-machineinstrs -target-abi=lp64 < %s \
; RUN:   | FileCheck -check-prefixes=RV64-ALL,RV64-LP64-ALL,RV64IFD-LP64 %s
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefixes=RV64-ALL,RV64-LP64-ALL,RV64I-LP64 %s

; This file checks for the backend's ability to tailcall libcalls. While other
; tests exhaustively check for selection of libcalls, this file is focused on
; testing a representative selection of libcalls under all relevant ABI and
; ISA combinations.

; Integer arithmetic libcalls:

define zeroext i8 @udiv8(i8 zeroext %a, i8 zeroext %b) nounwind {
; RV32-ALL-LABEL: udiv8:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    call __udivsi3
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64-ALL-LABEL: udiv8:
; RV64-ALL:       # %bb.0:
; RV64-ALL-NEXT:    addi sp, sp, -16
; RV64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-ALL-NEXT:    call __udivdi3
; RV64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-ALL-NEXT:    addi sp, sp, 16
; RV64-ALL-NEXT:    ret
  %1 = udiv i8 %a, %b
  ret i8 %1
}

define signext i16 @sdiv16(i16 signext %a, i16 signext %b) nounwind {
; RV32-ALL-LABEL: sdiv16:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    call __divsi3
; RV32-ALL-NEXT:    slli a0, a0, 16
; RV32-ALL-NEXT:    srai a0, a0, 16
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64-ALL-LABEL: sdiv16:
; RV64-ALL:       # %bb.0:
; RV64-ALL-NEXT:    addi sp, sp, -16
; RV64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-ALL-NEXT:    call __divdi3
; RV64-ALL-NEXT:    slli a0, a0, 48
; RV64-ALL-NEXT:    srai a0, a0, 48
; RV64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-ALL-NEXT:    addi sp, sp, 16
; RV64-ALL-NEXT:    ret
  %1 = sdiv i16 %a, %b
  ret i16 %1
}

define signext i32 @mul32(i32 %a, i32 %b) nounwind {
; RV32-ALL-LABEL: mul32:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    call __mulsi3
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64-ALL-LABEL: mul32:
; RV64-ALL:       # %bb.0:
; RV64-ALL-NEXT:    addi sp, sp, -16
; RV64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-ALL-NEXT:    call __muldi3
; RV64-ALL-NEXT:    sext.w a0, a0
; RV64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-ALL-NEXT:    addi sp, sp, 16
; RV64-ALL-NEXT:    ret
  %1 = mul i32 %a, %b
  ret i32 %1
}

define i64 @mul64(i64 %a, i64 %b) nounwind {
; RV32-ALL-LABEL: mul64:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    call __muldi3
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64-ALL-LABEL: mul64:
; RV64-ALL:       # %bb.0:
; RV64-ALL-NEXT:    tail __muldi3
  %1 = mul i64 %a, %b
  ret i64 %1
}

; Half libcalls:

declare half @llvm.sin.f16(half)

define half @sin_f16(half %a) nounwind {
; RV32IFD-ILP32D-LABEL: sin_f16:
; RV32IFD-ILP32D:       # %bb.0:
; RV32IFD-ILP32D-NEXT:    addi sp, sp, -16
; RV32IFD-ILP32D-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IFD-ILP32D-NEXT:    call __extendhfsf2
; RV32IFD-ILP32D-NEXT:    call sinf
; RV32IFD-ILP32D-NEXT:    call __truncsfhf2
; RV32IFD-ILP32D-NEXT:    fmv.x.w a0, fa0
; RV32IFD-ILP32D-NEXT:    lui a1, 1048560
; RV32IFD-ILP32D-NEXT:    or a0, a0, a1
; RV32IFD-ILP32D-NEXT:    fmv.w.x fa0, a0
; RV32IFD-ILP32D-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IFD-ILP32D-NEXT:    addi sp, sp, 16
; RV32IFD-ILP32D-NEXT:    ret
;
; RV32IF-ILP32F-LABEL: sin_f16:
; RV32IF-ILP32F:       # %bb.0:
; RV32IF-ILP32F-NEXT:    addi sp, sp, -16
; RV32IF-ILP32F-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IF-ILP32F-NEXT:    call __extendhfsf2
; RV32IF-ILP32F-NEXT:    call sinf
; RV32IF-ILP32F-NEXT:    call __truncsfhf2
; RV32IF-ILP32F-NEXT:    fmv.x.w a0, fa0
; RV32IF-ILP32F-NEXT:    lui a1, 1048560
; RV32IF-ILP32F-NEXT:    or a0, a0, a1
; RV32IF-ILP32F-NEXT:    fmv.w.x fa0, a0
; RV32IF-ILP32F-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IF-ILP32F-NEXT:    addi sp, sp, 16
; RV32IF-ILP32F-NEXT:    ret
;
; RV32IFD-ILP32-LABEL: sin_f16:
; RV32IFD-ILP32:       # %bb.0:
; RV32IFD-ILP32-NEXT:    addi sp, sp, -16
; RV32IFD-ILP32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IFD-ILP32-NEXT:    call __extendhfsf2
; RV32IFD-ILP32-NEXT:    call sinf
; RV32IFD-ILP32-NEXT:    call __truncsfhf2
; RV32IFD-ILP32-NEXT:    lui a1, 1048560
; RV32IFD-ILP32-NEXT:    or a0, a0, a1
; RV32IFD-ILP32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IFD-ILP32-NEXT:    addi sp, sp, 16
; RV32IFD-ILP32-NEXT:    ret
;
; RV32I-ILP32-LABEL: sin_f16:
; RV32I-ILP32:       # %bb.0:
; RV32I-ILP32-NEXT:    addi sp, sp, -16
; RV32I-ILP32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-ILP32-NEXT:    slli a0, a0, 16
; RV32I-ILP32-NEXT:    srli a0, a0, 16
; RV32I-ILP32-NEXT:    call __extendhfsf2
; RV32I-ILP32-NEXT:    call sinf
; RV32I-ILP32-NEXT:    call __truncsfhf2
; RV32I-ILP32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-ILP32-NEXT:    addi sp, sp, 16
; RV32I-ILP32-NEXT:    ret
;
; RV64IFD-LP64D-LABEL: sin_f16:
; RV64IFD-LP64D:       # %bb.0:
; RV64IFD-LP64D-NEXT:    addi sp, sp, -16
; RV64IFD-LP64D-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IFD-LP64D-NEXT:    call __extendhfsf2
; RV64IFD-LP64D-NEXT:    call sinf
; RV64IFD-LP64D-NEXT:    call __truncsfhf2
; RV64IFD-LP64D-NEXT:    fmv.x.w a0, fa0
; RV64IFD-LP64D-NEXT:    lui a1, 1048560
; RV64IFD-LP64D-NEXT:    or a0, a0, a1
; RV64IFD-LP64D-NEXT:    fmv.w.x fa0, a0
; RV64IFD-LP64D-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IFD-LP64D-NEXT:    addi sp, sp, 16
; RV64IFD-LP64D-NEXT:    ret
;
; RV64IF-LP64F-LABEL: sin_f16:
; RV64IF-LP64F:       # %bb.0:
; RV64IF-LP64F-NEXT:    addi sp, sp, -16
; RV64IF-LP64F-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IF-LP64F-NEXT:    call __extendhfsf2
; RV64IF-LP64F-NEXT:    call sinf
; RV64IF-LP64F-NEXT:    call __truncsfhf2
; RV64IF-LP64F-NEXT:    fmv.x.w a0, fa0
; RV64IF-LP64F-NEXT:    lui a1, 1048560
; RV64IF-LP64F-NEXT:    or a0, a0, a1
; RV64IF-LP64F-NEXT:    fmv.w.x fa0, a0
; RV64IF-LP64F-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IF-LP64F-NEXT:    addi sp, sp, 16
; RV64IF-LP64F-NEXT:    ret
;
; RV64IFD-LP64-LABEL: sin_f16:
; RV64IFD-LP64:       # %bb.0:
; RV64IFD-LP64-NEXT:    addi sp, sp, -16
; RV64IFD-LP64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IFD-LP64-NEXT:    call __extendhfsf2
; RV64IFD-LP64-NEXT:    call sinf
; RV64IFD-LP64-NEXT:    call __truncsfhf2
; RV64IFD-LP64-NEXT:    lui a1, 1048560
; RV64IFD-LP64-NEXT:    or a0, a0, a1
; RV64IFD-LP64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IFD-LP64-NEXT:    addi sp, sp, 16
; RV64IFD-LP64-NEXT:    ret
;
; RV64I-LP64-LABEL: sin_f16:
; RV64I-LP64:       # %bb.0:
; RV64I-LP64-NEXT:    addi sp, sp, -16
; RV64I-LP64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-LP64-NEXT:    slli a0, a0, 48
; RV64I-LP64-NEXT:    srli a0, a0, 48
; RV64I-LP64-NEXT:    call __extendhfsf2
; RV64I-LP64-NEXT:    call sinf
; RV64I-LP64-NEXT:    call __truncsfhf2
; RV64I-LP64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-LP64-NEXT:    addi sp, sp, 16
; RV64I-LP64-NEXT:    ret
  %1 = call half @llvm.sin.f16(half %a)
  ret half %1
}

; Float libcalls:

declare float @llvm.sin.f32(float)

define float @sin_f32(float %a) nounwind {
; F-ABI-ALL-LABEL: sin_f32:
; F-ABI-ALL:       # %bb.0:
; F-ABI-ALL-NEXT:    tail sinf
;
; RV32IFD-ILP32-LABEL: sin_f32:
; RV32IFD-ILP32:       # %bb.0:
; RV32IFD-ILP32-NEXT:    tail sinf
;
; RV32I-ILP32-LABEL: sin_f32:
; RV32I-ILP32:       # %bb.0:
; RV32I-ILP32-NEXT:    addi sp, sp, -16
; RV32I-ILP32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-ILP32-NEXT:    call sinf
; RV32I-ILP32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-ILP32-NEXT:    addi sp, sp, 16
; RV32I-ILP32-NEXT:    ret
;
; RV64-LP64-ALL-LABEL: sin_f32:
; RV64-LP64-ALL:       # %bb.0:
; RV64-LP64-ALL-NEXT:    addi sp, sp, -16
; RV64-LP64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-LP64-ALL-NEXT:    call sinf
; RV64-LP64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-LP64-ALL-NEXT:    addi sp, sp, 16
; RV64-LP64-ALL-NEXT:    ret
  %1 = call float @llvm.sin.f32(float %a)
  ret float %1
}

declare float @llvm.powi.f32.i32(float, i32)

define float @powi_f32(float %a, i32 %b) nounwind {
; RV32IFD-ILP32D-LABEL: powi_f32:
; RV32IFD-ILP32D:       # %bb.0:
; RV32IFD-ILP32D-NEXT:    tail __powisf2
;
; RV32IF-ILP32F-LABEL: powi_f32:
; RV32IF-ILP32F:       # %bb.0:
; RV32IF-ILP32F-NEXT:    tail __powisf2
;
; RV32IFD-ILP32-LABEL: powi_f32:
; RV32IFD-ILP32:       # %bb.0:
; RV32IFD-ILP32-NEXT:    tail __powisf2
;
; RV32I-ILP32-LABEL: powi_f32:
; RV32I-ILP32:       # %bb.0:
; RV32I-ILP32-NEXT:    addi sp, sp, -16
; RV32I-ILP32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-ILP32-NEXT:    call __powisf2
; RV32I-ILP32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-ILP32-NEXT:    addi sp, sp, 16
; RV32I-ILP32-NEXT:    ret
;
; RV64IFD-LP64D-LABEL: powi_f32:
; RV64IFD-LP64D:       # %bb.0:
; RV64IFD-LP64D-NEXT:    addi sp, sp, -16
; RV64IFD-LP64D-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IFD-LP64D-NEXT:    sext.w a0, a0
; RV64IFD-LP64D-NEXT:    call __powisf2
; RV64IFD-LP64D-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IFD-LP64D-NEXT:    addi sp, sp, 16
; RV64IFD-LP64D-NEXT:    ret
;
; RV64IF-LP64F-LABEL: powi_f32:
; RV64IF-LP64F:       # %bb.0:
; RV64IF-LP64F-NEXT:    addi sp, sp, -16
; RV64IF-LP64F-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IF-LP64F-NEXT:    sext.w a0, a0
; RV64IF-LP64F-NEXT:    call __powisf2
; RV64IF-LP64F-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IF-LP64F-NEXT:    addi sp, sp, 16
; RV64IF-LP64F-NEXT:    ret
;
; RV64-LP64-ALL-LABEL: powi_f32:
; RV64-LP64-ALL:       # %bb.0:
; RV64-LP64-ALL-NEXT:    addi sp, sp, -16
; RV64-LP64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-LP64-ALL-NEXT:    sext.w a1, a1
; RV64-LP64-ALL-NEXT:    call __powisf2
; RV64-LP64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-LP64-ALL-NEXT:    addi sp, sp, 16
; RV64-LP64-ALL-NEXT:    ret
  %1 = call float @llvm.powi.f32.i32(float %a, i32 %b)
  ret float %1
}

declare i64 @llvm.llround.i64.f32(float)

define i64 @llround_f32(float %a) nounwind {
; RV32-ALL-LABEL: llround_f32:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    call llroundf
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64IFD-LP64D-LABEL: llround_f32:
; RV64IFD-LP64D:       # %bb.0:
; RV64IFD-LP64D-NEXT:    fcvt.l.s a0, fa0, rmm
; RV64IFD-LP64D-NEXT:    ret
;
; RV64IF-LP64F-LABEL: llround_f32:
; RV64IF-LP64F:       # %bb.0:
; RV64IF-LP64F-NEXT:    fcvt.l.s a0, fa0, rmm
; RV64IF-LP64F-NEXT:    ret
;
; RV64IFD-LP64-LABEL: llround_f32:
; RV64IFD-LP64:       # %bb.0:
; RV64IFD-LP64-NEXT:    fmv.w.x fa5, a0
; RV64IFD-LP64-NEXT:    fcvt.l.s a0, fa5, rmm
; RV64IFD-LP64-NEXT:    ret
;
; RV64I-LP64-LABEL: llround_f32:
; RV64I-LP64:       # %bb.0:
; RV64I-LP64-NEXT:    addi sp, sp, -16
; RV64I-LP64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-LP64-NEXT:    call llroundf
; RV64I-LP64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-LP64-NEXT:    addi sp, sp, 16
; RV64I-LP64-NEXT:    ret
  %1 = call i64 @llvm.llround.i64.f32(float %a)
  ret i64 %1
}

; Double libcalls:

declare double @llvm.sin.f64(double)

define double @sin_f64(double %a) nounwind {
; D-ABI-ALL-LABEL: sin_f64:
; D-ABI-ALL:       # %bb.0:
; D-ABI-ALL-NEXT:    tail sin
;
; RV32IF-ILP32F-LABEL: sin_f64:
; RV32IF-ILP32F:       # %bb.0:
; RV32IF-ILP32F-NEXT:    addi sp, sp, -16
; RV32IF-ILP32F-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IF-ILP32F-NEXT:    call sin
; RV32IF-ILP32F-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IF-ILP32F-NEXT:    addi sp, sp, 16
; RV32IF-ILP32F-NEXT:    ret
;
; RV32-ILP32-ALL-LABEL: sin_f64:
; RV32-ILP32-ALL:       # %bb.0:
; RV32-ILP32-ALL-NEXT:    addi sp, sp, -16
; RV32-ILP32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ILP32-ALL-NEXT:    call sin
; RV32-ILP32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ILP32-ALL-NEXT:    addi sp, sp, 16
; RV32-ILP32-ALL-NEXT:    ret
;
; RV64IF-LP64F-LABEL: sin_f64:
; RV64IF-LP64F:       # %bb.0:
; RV64IF-LP64F-NEXT:    addi sp, sp, -16
; RV64IF-LP64F-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IF-LP64F-NEXT:    call sin
; RV64IF-LP64F-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IF-LP64F-NEXT:    addi sp, sp, 16
; RV64IF-LP64F-NEXT:    ret
;
; RV64IFD-LP64-LABEL: sin_f64:
; RV64IFD-LP64:       # %bb.0:
; RV64IFD-LP64-NEXT:    tail sin
;
; RV64I-LP64-LABEL: sin_f64:
; RV64I-LP64:       # %bb.0:
; RV64I-LP64-NEXT:    addi sp, sp, -16
; RV64I-LP64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-LP64-NEXT:    call sin
; RV64I-LP64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-LP64-NEXT:    addi sp, sp, 16
; RV64I-LP64-NEXT:    ret
  %1 = call double @llvm.sin.f64(double %a)
  ret double %1
}

declare double @llvm.powi.f64.i32(double, i32)

define double @powi_f64(double %a, i32 %b) nounwind {
; RV32IFD-ILP32D-LABEL: powi_f64:
; RV32IFD-ILP32D:       # %bb.0:
; RV32IFD-ILP32D-NEXT:    tail __powidf2
;
; RV32IF-ILP32F-LABEL: powi_f64:
; RV32IF-ILP32F:       # %bb.0:
; RV32IF-ILP32F-NEXT:    addi sp, sp, -16
; RV32IF-ILP32F-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32IF-ILP32F-NEXT:    call __powidf2
; RV32IF-ILP32F-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32IF-ILP32F-NEXT:    addi sp, sp, 16
; RV32IF-ILP32F-NEXT:    ret
;
; RV32-ILP32-ALL-LABEL: powi_f64:
; RV32-ILP32-ALL:       # %bb.0:
; RV32-ILP32-ALL-NEXT:    addi sp, sp, -16
; RV32-ILP32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ILP32-ALL-NEXT:    call __powidf2
; RV32-ILP32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ILP32-ALL-NEXT:    addi sp, sp, 16
; RV32-ILP32-ALL-NEXT:    ret
;
; RV64IFD-LP64D-LABEL: powi_f64:
; RV64IFD-LP64D:       # %bb.0:
; RV64IFD-LP64D-NEXT:    addi sp, sp, -16
; RV64IFD-LP64D-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IFD-LP64D-NEXT:    sext.w a0, a0
; RV64IFD-LP64D-NEXT:    call __powidf2
; RV64IFD-LP64D-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IFD-LP64D-NEXT:    addi sp, sp, 16
; RV64IFD-LP64D-NEXT:    ret
;
; RV64IF-LP64F-LABEL: powi_f64:
; RV64IF-LP64F:       # %bb.0:
; RV64IF-LP64F-NEXT:    addi sp, sp, -16
; RV64IF-LP64F-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IF-LP64F-NEXT:    sext.w a1, a1
; RV64IF-LP64F-NEXT:    call __powidf2
; RV64IF-LP64F-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IF-LP64F-NEXT:    addi sp, sp, 16
; RV64IF-LP64F-NEXT:    ret
;
; RV64-LP64-ALL-LABEL: powi_f64:
; RV64-LP64-ALL:       # %bb.0:
; RV64-LP64-ALL-NEXT:    addi sp, sp, -16
; RV64-LP64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-LP64-ALL-NEXT:    sext.w a1, a1
; RV64-LP64-ALL-NEXT:    call __powidf2
; RV64-LP64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-LP64-ALL-NEXT:    addi sp, sp, 16
; RV64-LP64-ALL-NEXT:    ret
  %1 = call double @llvm.powi.f64.i32(double %a, i32 %b)
  ret double %1
}

declare i64 @llvm.llround.i64.f64(double)

define i64 @llround_f64(double %a) nounwind {
; RV32-ALL-LABEL: llround_f64:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    call llround
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64IFD-LP64D-LABEL: llround_f64:
; RV64IFD-LP64D:       # %bb.0:
; RV64IFD-LP64D-NEXT:    fcvt.l.d a0, fa0, rmm
; RV64IFD-LP64D-NEXT:    ret
;
; RV64IF-LP64F-LABEL: llround_f64:
; RV64IF-LP64F:       # %bb.0:
; RV64IF-LP64F-NEXT:    addi sp, sp, -16
; RV64IF-LP64F-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IF-LP64F-NEXT:    call llround
; RV64IF-LP64F-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IF-LP64F-NEXT:    addi sp, sp, 16
; RV64IF-LP64F-NEXT:    ret
;
; RV64IFD-LP64-LABEL: llround_f64:
; RV64IFD-LP64:       # %bb.0:
; RV64IFD-LP64-NEXT:    fmv.d.x fa5, a0
; RV64IFD-LP64-NEXT:    fcvt.l.d a0, fa5, rmm
; RV64IFD-LP64-NEXT:    ret
;
; RV64I-LP64-LABEL: llround_f64:
; RV64I-LP64:       # %bb.0:
; RV64I-LP64-NEXT:    addi sp, sp, -16
; RV64I-LP64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-LP64-NEXT:    call llround
; RV64I-LP64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-LP64-NEXT:    addi sp, sp, 16
; RV64I-LP64-NEXT:    ret
  %1 = call i64 @llvm.llround.i64.f64(double %a)
  ret i64 %1
}

; Atomics libcalls:

define i8 @atomic_load_i8_unordered(ptr %a) nounwind {
; RV32-ALL-LABEL: atomic_load_i8_unordered:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    li a1, 0
; RV32-ALL-NEXT:    call __atomic_load_1
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64-ALL-LABEL: atomic_load_i8_unordered:
; RV64-ALL:       # %bb.0:
; RV64-ALL-NEXT:    addi sp, sp, -16
; RV64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-ALL-NEXT:    li a1, 0
; RV64-ALL-NEXT:    call __atomic_load_1
; RV64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-ALL-NEXT:    addi sp, sp, 16
; RV64-ALL-NEXT:    ret
  %1 = load atomic i8, ptr %a unordered, align 1
  ret i8 %1
}

define i16 @atomicrmw_add_i16_release(ptr %a, i16 %b) nounwind {
; RV32-ALL-LABEL: atomicrmw_add_i16_release:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    li a2, 3
; RV32-ALL-NEXT:    call __atomic_fetch_add_2
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64-ALL-LABEL: atomicrmw_add_i16_release:
; RV64-ALL:       # %bb.0:
; RV64-ALL-NEXT:    addi sp, sp, -16
; RV64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-ALL-NEXT:    li a2, 3
; RV64-ALL-NEXT:    call __atomic_fetch_add_2
; RV64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-ALL-NEXT:    addi sp, sp, 16
; RV64-ALL-NEXT:    ret
  %1 = atomicrmw add ptr %a, i16 %b release
  ret i16 %1
}

define i32 @atomicrmw_xor_i32_acq_rel(ptr %a, i32 %b) nounwind {
; RV32-ALL-LABEL: atomicrmw_xor_i32_acq_rel:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    li a2, 4
; RV32-ALL-NEXT:    call __atomic_fetch_xor_4
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64-ALL-LABEL: atomicrmw_xor_i32_acq_rel:
; RV64-ALL:       # %bb.0:
; RV64-ALL-NEXT:    addi sp, sp, -16
; RV64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-ALL-NEXT:    li a2, 4
; RV64-ALL-NEXT:    call __atomic_fetch_xor_4
; RV64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-ALL-NEXT:    addi sp, sp, 16
; RV64-ALL-NEXT:    ret
  %1 = atomicrmw xor ptr %a, i32 %b acq_rel
  ret i32 %1
}

define i64 @atomicrmw_nand_i64_seq_cst(ptr %a, i64 %b) nounwind {
; RV32-ALL-LABEL: atomicrmw_nand_i64_seq_cst:
; RV32-ALL:       # %bb.0:
; RV32-ALL-NEXT:    addi sp, sp, -16
; RV32-ALL-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-ALL-NEXT:    li a3, 5
; RV32-ALL-NEXT:    call __atomic_fetch_nand_8
; RV32-ALL-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-ALL-NEXT:    addi sp, sp, 16
; RV32-ALL-NEXT:    ret
;
; RV64-ALL-LABEL: atomicrmw_nand_i64_seq_cst:
; RV64-ALL:       # %bb.0:
; RV64-ALL-NEXT:    addi sp, sp, -16
; RV64-ALL-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-ALL-NEXT:    li a2, 5
; RV64-ALL-NEXT:    call __atomic_fetch_nand_8
; RV64-ALL-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-ALL-NEXT:    addi sp, sp, 16
; RV64-ALL-NEXT:    ret
  %1 = atomicrmw nand ptr %a, i64 %b seq_cst
  ret i64 %1
}
