; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv64 -mattr=+v | FileCheck %s

declare i64 @llvm.riscv.vsetvlimax(i64, i64);

define signext i32 @vsetvlmax_sext() {
; CHECK-LABEL: vsetvlmax_sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 1)
  %b = trunc i64 %a to i32
  ret i32 %b
}

define zeroext i32 @vsetvlmax_zext() {
; CHECK-LABEL: vsetvlmax_zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 1)
  %b = trunc i64 %a to i32
  ret i32 %b
}

define i64 @vsetvlmax_e8m1_and14bits() {
; CHECK-LABEL: vsetvlmax_e8m1_and14bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 0)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e8m1_and13bits() {
; CHECK-LABEL: vsetvlmax_e8m1_and13bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    slli a0, a0, 51
; CHECK-NEXT:    srli a0, a0, 51
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 0)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e8m2_and15bits() {
; CHECK-LABEL: vsetvlmax_e8m2_and15bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 1)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e8m2_and14bits() {
; CHECK-LABEL: vsetvlmax_e8m2_and14bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    slli a0, a0, 50
; CHECK-NEXT:    srli a0, a0, 50
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 1)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e8m4_and16bits() {
; CHECK-LABEL: vsetvlmax_e8m4_and16bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 2)
  %b = and i64 %a, 65535
  ret i64 %b
}

define i64 @vsetvlmax_e8m4_and15bits() {
; CHECK-LABEL: vsetvlmax_e8m4_and15bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    slli a0, a0, 49
; CHECK-NEXT:    srli a0, a0, 49
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 2)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e8m8_and17bits() {
; CHECK-LABEL: vsetvlmax_e8m8_and17bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 3)
  %b = and i64 %a, 131071
  ret i64 %b
}

define i64 @vsetvlmax_e8m8_and16bits() {
; CHECK-LABEL: vsetvlmax_e8m8_and16bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    slli a0, a0, 48
; CHECK-NEXT:    srli a0, a0, 48
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 3)
  %b = and i64 %a, 65535
  ret i64 %b
}

define i64 @vsetvlmax_e8mf2_and11bits() {
; CHECK-LABEL: vsetvlmax_e8mf2_and11bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 5)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e8mf2_and10bits() {
; CHECK-LABEL: vsetvlmax_e8mf2_and10bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, ma
; CHECK-NEXT:    andi a0, a0, 1023
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 5)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e8mf4_and12bits() {
; CHECK-LABEL: vsetvlmax_e8mf4_and12bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 6)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e8mf4_and11bits() {
; CHECK-LABEL: vsetvlmax_e8mf4_and11bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; CHECK-NEXT:    andi a0, a0, 2047
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 6)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e8mf8_and13bits() {
; CHECK-LABEL: vsetvlmax_e8mf8_and13bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 7)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e8mf8_and12bits() {
; CHECK-LABEL: vsetvlmax_e8mf8_and12bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    slli a0, a0, 52
; CHECK-NEXT:    srli a0, a0, 52
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 0, i64 7)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e16m1_and13bits() {
; CHECK-LABEL: vsetvlmax_e16m1_and13bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 0)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e16m1_and12bits() {
; CHECK-LABEL: vsetvlmax_e16m1_and12bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    slli a0, a0, 52
; CHECK-NEXT:    srli a0, a0, 52
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 0)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e16m2_and14bits() {
; CHECK-LABEL: vsetvlmax_e16m2_and14bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 1)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e16m2_and13bits() {
; CHECK-LABEL: vsetvlmax_e16m2_and13bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    slli a0, a0, 51
; CHECK-NEXT:    srli a0, a0, 51
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 1)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e16m4_and15bits() {
; CHECK-LABEL: vsetvlmax_e16m4_and15bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 2)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e16m4_and14bits() {
; CHECK-LABEL: vsetvlmax_e16m4_and14bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    slli a0, a0, 50
; CHECK-NEXT:    srli a0, a0, 50
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 2)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e16m8_and16bits() {
; CHECK-LABEL: vsetvlmax_e16m8_and16bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 3)
  %b = and i64 %a, 65535
  ret i64 %b
}

define i64 @vsetvlmax_e16m8_and15bits() {
; CHECK-LABEL: vsetvlmax_e16m8_and15bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-NEXT:    slli a0, a0, 49
; CHECK-NEXT:    srli a0, a0, 49
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 3)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e16mf2_and10bits() {
; CHECK-LABEL: vsetvlmax_e16mf2_and10bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf8, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 5)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e16mf2_and9bits() {
; CHECK-LABEL: vsetvlmax_e16mf2_and9bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf8, ta, ma
; CHECK-NEXT:    andi a0, a0, 511
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 5)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvlmax_e16mf4_and11bits() {
; CHECK-LABEL: vsetvlmax_e16mf4_and11bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 6)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e16mf4_and10bits() {
; CHECK-LABEL: vsetvlmax_e16mf4_and10bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    andi a0, a0, 1023
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 6)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e16mf8_and12bits() {
; CHECK-LABEL: vsetvlmax_e16mf8_and12bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 7)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e16mf8_and11bits() {
; CHECK-LABEL: vsetvlmax_e16mf8_and11bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    andi a0, a0, 2047
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 1, i64 7)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e32m1_and12bits() {
; CHECK-LABEL: vsetvlmax_e32m1_and12bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 0)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e32m1_and11bits() {
; CHECK-LABEL: vsetvlmax_e32m1_and11bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    andi a0, a0, 2047
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 0)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e32m2_and13bits() {
; CHECK-LABEL: vsetvlmax_e32m2_and13bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 1)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e32m2_and12bits() {
; CHECK-LABEL: vsetvlmax_e32m2_and12bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    slli a0, a0, 52
; CHECK-NEXT:    srli a0, a0, 52
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 1)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e32m4_and14bits() {
; CHECK-LABEL: vsetvlmax_e32m4_and14bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 2)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e32m4_and13bits() {
; CHECK-LABEL: vsetvlmax_e32m4_and13bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    slli a0, a0, 51
; CHECK-NEXT:    srli a0, a0, 51
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 2)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e32m8_and15bits() {
; CHECK-LABEL: vsetvlmax_e32m8_and15bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 3)
  %b = and i64 %a, 32767
  ret i64 %b
}

define i64 @vsetvlmax_e32m8_and14bits() {
; CHECK-LABEL: vsetvlmax_e32m8_and14bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    slli a0, a0, 50
; CHECK-NEXT:    srli a0, a0, 50
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 3)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e32mf2_and9bits() {
; CHECK-LABEL: vsetvlmax_e32mf2_and9bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf8, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 5)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvlmax_e32mf2_and8bits() {
; CHECK-LABEL: vsetvlmax_e32mf2_and8bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf8, ta, ma
; CHECK-NEXT:    andi a0, a0, 255
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 5)
  %b = and i64 %a, 255
  ret i64 %b
}

define i64 @vsetvlmax_e32mf4_and10bits() {
; CHECK-LABEL: vsetvlmax_e32mf4_and10bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf4, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 6)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e32mf4_and9bits() {
; CHECK-LABEL: vsetvlmax_e32mf4_and9bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf4, ta, ma
; CHECK-NEXT:    andi a0, a0, 511
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 6)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvlmax_e32mf8_and11bits() {
; CHECK-LABEL: vsetvlmax_e32mf8_and11bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 7)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e32mf8_and10bits() {
; CHECK-LABEL: vsetvlmax_e32mf8_and10bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    andi a0, a0, 1023
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 2, i64 7)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e64m1_and11bits() {
; CHECK-LABEL: vsetvlmax_e64m1_and11bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 0)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e64m1_and10bits() {
; CHECK-LABEL: vsetvlmax_e64m1_and10bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    andi a0, a0, 1023
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 0)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e64m2_and12bits() {
; CHECK-LABEL: vsetvlmax_e64m2_and12bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 1)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e64m2_and11bits() {
; CHECK-LABEL: vsetvlmax_e64m2_and11bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    andi a0, a0, 2047
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 1)
  %b = and i64 %a, 2047
  ret i64 %b
}

define i64 @vsetvlmax_e64m4_and13bits() {
; CHECK-LABEL: vsetvlmax_e64m4_and13bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 2)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e64m4_and12bits() {
; CHECK-LABEL: vsetvlmax_e64m4_and12bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    slli a0, a0, 52
; CHECK-NEXT:    srli a0, a0, 52
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 2)
  %b = and i64 %a, 4095
  ret i64 %b
}

define i64 @vsetvlmax_e64m8_and14bits() {
; CHECK-LABEL: vsetvlmax_e64m8_and14bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 3)
  %b = and i64 %a, 16383
  ret i64 %b
}

define i64 @vsetvlmax_e64m8_and13bits() {
; CHECK-LABEL: vsetvlmax_e64m8_and13bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    slli a0, a0, 51
; CHECK-NEXT:    srli a0, a0, 51
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 3)
  %b = and i64 %a, 8191
  ret i64 %b
}

define i64 @vsetvlmax_e64mf2_and8bits() {
; CHECK-LABEL: vsetvlmax_e64mf2_and8bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, mf8, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 5)
  %b = and i64 %a, 255
  ret i64 %b
}

define i64 @vsetvlmax_e64mf2_and7bits() {
; CHECK-LABEL: vsetvlmax_e64mf2_and7bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, mf8, ta, ma
; CHECK-NEXT:    andi a0, a0, 127
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 5)
  %b = and i64 %a, 127
  ret i64 %b
}

define i64 @vsetvlmax_e64mf4_and9bits() {
; CHECK-LABEL: vsetvlmax_e64mf4_and9bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, mf4, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 6)
  %b = and i64 %a, 511
  ret i64 %b
}

define i64 @vsetvlmax_e64mf4_and8bits() {
; CHECK-LABEL: vsetvlmax_e64mf4_and8bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, mf4, ta, ma
; CHECK-NEXT:    andi a0, a0, 255
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 6)
  %b = and i64 %a, 255
  ret i64 %b
}

define i64 @vsetvlmax_e64mf8_and10bits() {
; CHECK-LABEL: vsetvlmax_e64mf8_and10bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, mf2, ta, ma
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 7)
  %b = and i64 %a, 1023
  ret i64 %b
}

define i64 @vsetvlmax_e64mf8_and9bits() {
; CHECK-LABEL: vsetvlmax_e64mf8_and9bits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, mf2, ta, ma
; CHECK-NEXT:    andi a0, a0, 511
; CHECK-NEXT:    ret
  %a = call i64 @llvm.riscv.vsetvlimax(i64 3, i64 7)
  %b = and i64 %a, 511
  ret i64 %b
}
