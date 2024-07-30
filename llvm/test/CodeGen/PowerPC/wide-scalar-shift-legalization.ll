; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=powerpc64le-unknown-linux-gnu | FileCheck %s --check-prefixes=ALL,LE,LE-64BIT
; RUN: llc < %s -mtriple=powerpc64-unknown-linux-gnu   | FileCheck %s --check-prefixes=ALL,BE
; RUN: llc < %s -mtriple=ppc32--                       | FileCheck %s --check-prefixes=ALL,LE,LE-32BIT

define void @lshr_4bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: lshr_4bytes:
; ALL:       # %bb.0:
; ALL-NEXT:    lwz 3, 0(3)
; ALL-NEXT:    lwz 4, 0(4)
; ALL-NEXT:    srw 3, 3, 4
; ALL-NEXT:    stw 3, 0(5)
; ALL-NEXT:    blr
  %src = load i32, ptr %src.ptr, align 1
  %bitOff = load i32, ptr %bitOff.ptr, align 1
  %res = lshr i32 %src, %bitOff
  store i32 %res, ptr %dst, align 1
  ret void
}
define void @shl_4bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: shl_4bytes:
; ALL:       # %bb.0:
; ALL-NEXT:    lwz 3, 0(3)
; ALL-NEXT:    lwz 4, 0(4)
; ALL-NEXT:    slw 3, 3, 4
; ALL-NEXT:    stw 3, 0(5)
; ALL-NEXT:    blr
  %src = load i32, ptr %src.ptr, align 1
  %bitOff = load i32, ptr %bitOff.ptr, align 1
  %res = shl i32 %src, %bitOff
  store i32 %res, ptr %dst, align 1
  ret void
}
define void @ashr_4bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; ALL-LABEL: ashr_4bytes:
; ALL:       # %bb.0:
; ALL-NEXT:    lwz 3, 0(3)
; ALL-NEXT:    lwz 4, 0(4)
; ALL-NEXT:    sraw 3, 3, 4
; ALL-NEXT:    stw 3, 0(5)
; ALL-NEXT:    blr
  %src = load i32, ptr %src.ptr, align 1
  %bitOff = load i32, ptr %bitOff.ptr, align 1
  %res = ashr i32 %src, %bitOff
  store i32 %res, ptr %dst, align 1
  ret void
}

define void @lshr_8bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; LE-64BIT-LABEL: lshr_8bytes:
; LE-64BIT:       # %bb.0:
; LE-64BIT-NEXT:    ld 3, 0(3)
; LE-64BIT-NEXT:    lwz 4, 0(4)
; LE-64BIT-NEXT:    srd 3, 3, 4
; LE-64BIT-NEXT:    std 3, 0(5)
; LE-64BIT-NEXT:    blr
;
; BE-LABEL: lshr_8bytes:
; BE:       # %bb.0:
; BE-NEXT:    ld 3, 0(3)
; BE-NEXT:    lwz 4, 4(4)
; BE-NEXT:    srd 3, 3, 4
; BE-NEXT:    std 3, 0(5)
; BE-NEXT:    blr
;
; LE-32BIT-LABEL: lshr_8bytes:
; LE-32BIT:       # %bb.0:
; LE-32BIT-NEXT:    lwz 4, 4(4)
; LE-32BIT-NEXT:    lwz 6, 4(3)
; LE-32BIT-NEXT:    lwz 3, 0(3)
; LE-32BIT-NEXT:    subfic 7, 4, 32
; LE-32BIT-NEXT:    srw 6, 6, 4
; LE-32BIT-NEXT:    addi 8, 4, -32
; LE-32BIT-NEXT:    slw 7, 3, 7
; LE-32BIT-NEXT:    srw 4, 3, 4
; LE-32BIT-NEXT:    srw 3, 3, 8
; LE-32BIT-NEXT:    or 6, 6, 7
; LE-32BIT-NEXT:    or 3, 6, 3
; LE-32BIT-NEXT:    stw 4, 0(5)
; LE-32BIT-NEXT:    stw 3, 4(5)
; LE-32BIT-NEXT:    blr
  %src = load i64, ptr %src.ptr, align 1
  %bitOff = load i64, ptr %bitOff.ptr, align 1
  %res = lshr i64 %src, %bitOff
  store i64 %res, ptr %dst, align 1
  ret void
}
define void @shl_8bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; LE-64BIT-LABEL: shl_8bytes:
; LE-64BIT:       # %bb.0:
; LE-64BIT-NEXT:    ld 3, 0(3)
; LE-64BIT-NEXT:    lwz 4, 0(4)
; LE-64BIT-NEXT:    sld 3, 3, 4
; LE-64BIT-NEXT:    std 3, 0(5)
; LE-64BIT-NEXT:    blr
;
; BE-LABEL: shl_8bytes:
; BE:       # %bb.0:
; BE-NEXT:    ld 3, 0(3)
; BE-NEXT:    lwz 4, 4(4)
; BE-NEXT:    sld 3, 3, 4
; BE-NEXT:    std 3, 0(5)
; BE-NEXT:    blr
;
; LE-32BIT-LABEL: shl_8bytes:
; LE-32BIT:       # %bb.0:
; LE-32BIT-NEXT:    lwz 4, 4(4)
; LE-32BIT-NEXT:    lwz 6, 0(3)
; LE-32BIT-NEXT:    lwz 3, 4(3)
; LE-32BIT-NEXT:    subfic 7, 4, 32
; LE-32BIT-NEXT:    slw 6, 6, 4
; LE-32BIT-NEXT:    addi 8, 4, -32
; LE-32BIT-NEXT:    srw 7, 3, 7
; LE-32BIT-NEXT:    slw 4, 3, 4
; LE-32BIT-NEXT:    slw 3, 3, 8
; LE-32BIT-NEXT:    or 6, 6, 7
; LE-32BIT-NEXT:    or 3, 6, 3
; LE-32BIT-NEXT:    stw 4, 4(5)
; LE-32BIT-NEXT:    stw 3, 0(5)
; LE-32BIT-NEXT:    blr
  %src = load i64, ptr %src.ptr, align 1
  %bitOff = load i64, ptr %bitOff.ptr, align 1
  %res = shl i64 %src, %bitOff
  store i64 %res, ptr %dst, align 1
  ret void
}
define void @ashr_8bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; LE-64BIT-LABEL: ashr_8bytes:
; LE-64BIT:       # %bb.0:
; LE-64BIT-NEXT:    ld 3, 0(3)
; LE-64BIT-NEXT:    lwz 4, 0(4)
; LE-64BIT-NEXT:    srad 3, 3, 4
; LE-64BIT-NEXT:    std 3, 0(5)
; LE-64BIT-NEXT:    blr
;
; BE-LABEL: ashr_8bytes:
; BE:       # %bb.0:
; BE-NEXT:    ld 3, 0(3)
; BE-NEXT:    lwz 4, 4(4)
; BE-NEXT:    srad 3, 3, 4
; BE-NEXT:    std 3, 0(5)
; BE-NEXT:    blr
;
; LE-32BIT-LABEL: ashr_8bytes:
; LE-32BIT:       # %bb.0:
; LE-32BIT-NEXT:    lwz 4, 4(4)
; LE-32BIT-NEXT:    lwz 6, 0(3)
; LE-32BIT-NEXT:    addi 7, 4, -32
; LE-32BIT-NEXT:    cmpwi 7, 0
; LE-32BIT-NEXT:    ble 0, .LBB5_2
; LE-32BIT-NEXT:  # %bb.1:
; LE-32BIT-NEXT:    sraw 3, 6, 7
; LE-32BIT-NEXT:    b .LBB5_3
; LE-32BIT-NEXT:  .LBB5_2:
; LE-32BIT-NEXT:    lwz 3, 4(3)
; LE-32BIT-NEXT:    subfic 7, 4, 32
; LE-32BIT-NEXT:    slw 7, 6, 7
; LE-32BIT-NEXT:    srw 3, 3, 4
; LE-32BIT-NEXT:    or 3, 3, 7
; LE-32BIT-NEXT:  .LBB5_3:
; LE-32BIT-NEXT:    sraw 4, 6, 4
; LE-32BIT-NEXT:    stw 4, 0(5)
; LE-32BIT-NEXT:    stw 3, 4(5)
; LE-32BIT-NEXT:    blr
  %src = load i64, ptr %src.ptr, align 1
  %bitOff = load i64, ptr %bitOff.ptr, align 1
  %res = ashr i64 %src, %bitOff
  store i64 %res, ptr %dst, align 1
  ret void
}

define void @lshr_16bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; LE-64BIT-LABEL: lshr_16bytes:
; LE-64BIT:       # %bb.0:
; LE-64BIT-NEXT:    lwz 4, 0(4)
; LE-64BIT-NEXT:    ld 6, 8(3)
; LE-64BIT-NEXT:    subfic 7, 4, 64
; LE-64BIT-NEXT:    ld 3, 0(3)
; LE-64BIT-NEXT:    srd 3, 3, 4
; LE-64BIT-NEXT:    sld 7, 6, 7
; LE-64BIT-NEXT:    or 3, 3, 7
; LE-64BIT-NEXT:    addi 7, 4, -64
; LE-64BIT-NEXT:    srd 4, 6, 4
; LE-64BIT-NEXT:    srd 7, 6, 7
; LE-64BIT-NEXT:    std 4, 8(5)
; LE-64BIT-NEXT:    or 3, 3, 7
; LE-64BIT-NEXT:    std 3, 0(5)
; LE-64BIT-NEXT:    blr
;
; BE-LABEL: lshr_16bytes:
; BE:       # %bb.0:
; BE-NEXT:    lwz 4, 12(4)
; BE-NEXT:    ld 6, 0(3)
; BE-NEXT:    ld 3, 8(3)
; BE-NEXT:    subfic 7, 4, 64
; BE-NEXT:    srd 3, 3, 4
; BE-NEXT:    sld 7, 6, 7
; BE-NEXT:    addi 8, 4, -64
; BE-NEXT:    or 3, 3, 7
; BE-NEXT:    srd 7, 6, 8
; BE-NEXT:    srd 4, 6, 4
; BE-NEXT:    or 3, 3, 7
; BE-NEXT:    std 4, 0(5)
; BE-NEXT:    std 3, 8(5)
; BE-NEXT:    blr
;
; LE-32BIT-LABEL: lshr_16bytes:
; LE-32BIT:       # %bb.0:
; LE-32BIT-NEXT:    stwu 1, -48(1)
; LE-32BIT-NEXT:    lwz 7, 0(3)
; LE-32BIT-NEXT:    li 6, 0
; LE-32BIT-NEXT:    lwz 4, 12(4)
; LE-32BIT-NEXT:    lwz 8, 4(3)
; LE-32BIT-NEXT:    lwz 9, 8(3)
; LE-32BIT-NEXT:    lwz 3, 12(3)
; LE-32BIT-NEXT:    stw 6, 28(1)
; LE-32BIT-NEXT:    stw 6, 24(1)
; LE-32BIT-NEXT:    stw 6, 20(1)
; LE-32BIT-NEXT:    stw 6, 16(1)
; LE-32BIT-NEXT:    addi 6, 1, 32
; LE-32BIT-NEXT:    stw 7, 32(1)
; LE-32BIT-NEXT:    rlwinm 7, 4, 29, 28, 31
; LE-32BIT-NEXT:    stw 3, 44(1)
; LE-32BIT-NEXT:    sub 6, 6, 7
; LE-32BIT-NEXT:    stw 9, 40(1)
; LE-32BIT-NEXT:    li 3, 7
; LE-32BIT-NEXT:    stw 8, 36(1)
; LE-32BIT-NEXT:    nand 3, 4, 3
; LE-32BIT-NEXT:    lwz 7, 4(6)
; LE-32BIT-NEXT:    clrlwi 4, 4, 29
; LE-32BIT-NEXT:    lwz 8, 8(6)
; LE-32BIT-NEXT:    subfic 10, 4, 32
; LE-32BIT-NEXT:    lwz 9, 0(6)
; LE-32BIT-NEXT:    clrlwi 3, 3, 27
; LE-32BIT-NEXT:    lwz 6, 12(6)
; LE-32BIT-NEXT:    srw 11, 8, 4
; LE-32BIT-NEXT:    slw 8, 8, 10
; LE-32BIT-NEXT:    slw 10, 9, 10
; LE-32BIT-NEXT:    srw 6, 6, 4
; LE-32BIT-NEXT:    srw 9, 9, 4
; LE-32BIT-NEXT:    srw 4, 7, 4
; LE-32BIT-NEXT:    slwi 7, 7, 1
; LE-32BIT-NEXT:    slw 3, 7, 3
; LE-32BIT-NEXT:    or 6, 8, 6
; LE-32BIT-NEXT:    or 4, 10, 4
; LE-32BIT-NEXT:    or 3, 11, 3
; LE-32BIT-NEXT:    stw 9, 0(5)
; LE-32BIT-NEXT:    stw 6, 12(5)
; LE-32BIT-NEXT:    stw 4, 4(5)
; LE-32BIT-NEXT:    stw 3, 8(5)
; LE-32BIT-NEXT:    addi 1, 1, 48
; LE-32BIT-NEXT:    blr
  %src = load i128, ptr %src.ptr, align 1
  %bitOff = load i128, ptr %bitOff.ptr, align 1
  %res = lshr i128 %src, %bitOff
  store i128 %res, ptr %dst, align 1
  ret void
}
define void @shl_16bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; LE-64BIT-LABEL: shl_16bytes:
; LE-64BIT:       # %bb.0:
; LE-64BIT-NEXT:    lwz 4, 0(4)
; LE-64BIT-NEXT:    ld 6, 0(3)
; LE-64BIT-NEXT:    subfic 7, 4, 64
; LE-64BIT-NEXT:    ld 3, 8(3)
; LE-64BIT-NEXT:    sld 3, 3, 4
; LE-64BIT-NEXT:    srd 7, 6, 7
; LE-64BIT-NEXT:    or 3, 3, 7
; LE-64BIT-NEXT:    addi 7, 4, -64
; LE-64BIT-NEXT:    sld 4, 6, 4
; LE-64BIT-NEXT:    sld 7, 6, 7
; LE-64BIT-NEXT:    std 4, 0(5)
; LE-64BIT-NEXT:    or 3, 3, 7
; LE-64BIT-NEXT:    std 3, 8(5)
; LE-64BIT-NEXT:    blr
;
; BE-LABEL: shl_16bytes:
; BE:       # %bb.0:
; BE-NEXT:    lwz 4, 12(4)
; BE-NEXT:    ld 6, 8(3)
; BE-NEXT:    ld 3, 0(3)
; BE-NEXT:    subfic 7, 4, 64
; BE-NEXT:    sld 3, 3, 4
; BE-NEXT:    srd 7, 6, 7
; BE-NEXT:    addi 8, 4, -64
; BE-NEXT:    or 3, 3, 7
; BE-NEXT:    sld 7, 6, 8
; BE-NEXT:    sld 4, 6, 4
; BE-NEXT:    or 3, 3, 7
; BE-NEXT:    std 4, 8(5)
; BE-NEXT:    std 3, 0(5)
; BE-NEXT:    blr
;
; LE-32BIT-LABEL: shl_16bytes:
; LE-32BIT:       # %bb.0:
; LE-32BIT-NEXT:    stwu 1, -48(1)
; LE-32BIT-NEXT:    lwz 7, 0(3)
; LE-32BIT-NEXT:    li 6, 0
; LE-32BIT-NEXT:    lwz 8, 4(3)
; LE-32BIT-NEXT:    lwz 9, 8(3)
; LE-32BIT-NEXT:    lwz 3, 12(3)
; LE-32BIT-NEXT:    lwz 4, 12(4)
; LE-32BIT-NEXT:    stw 6, 44(1)
; LE-32BIT-NEXT:    stw 6, 40(1)
; LE-32BIT-NEXT:    stw 6, 36(1)
; LE-32BIT-NEXT:    stw 6, 32(1)
; LE-32BIT-NEXT:    rlwinm 6, 4, 29, 28, 31
; LE-32BIT-NEXT:    stw 3, 28(1)
; LE-32BIT-NEXT:    addi 3, 1, 16
; LE-32BIT-NEXT:    stw 9, 24(1)
; LE-32BIT-NEXT:    stw 8, 20(1)
; LE-32BIT-NEXT:    stw 7, 16(1)
; LE-32BIT-NEXT:    li 7, 7
; LE-32BIT-NEXT:    lwzux 3, 6, 3
; LE-32BIT-NEXT:    nand 7, 4, 7
; LE-32BIT-NEXT:    clrlwi 4, 4, 29
; LE-32BIT-NEXT:    subfic 10, 4, 32
; LE-32BIT-NEXT:    lwz 8, 8(6)
; LE-32BIT-NEXT:    clrlwi 7, 7, 27
; LE-32BIT-NEXT:    lwz 9, 4(6)
; LE-32BIT-NEXT:    slw 3, 3, 4
; LE-32BIT-NEXT:    lwz 6, 12(6)
; LE-32BIT-NEXT:    slw 11, 9, 4
; LE-32BIT-NEXT:    srw 9, 9, 10
; LE-32BIT-NEXT:    srw 10, 6, 10
; LE-32BIT-NEXT:    slw 6, 6, 4
; LE-32BIT-NEXT:    slw 4, 8, 4
; LE-32BIT-NEXT:    srwi 8, 8, 1
; LE-32BIT-NEXT:    srw 7, 8, 7
; LE-32BIT-NEXT:    or 3, 3, 9
; LE-32BIT-NEXT:    or 4, 4, 10
; LE-32BIT-NEXT:    stw 3, 0(5)
; LE-32BIT-NEXT:    or 3, 11, 7
; LE-32BIT-NEXT:    stw 6, 12(5)
; LE-32BIT-NEXT:    stw 4, 8(5)
; LE-32BIT-NEXT:    stw 3, 4(5)
; LE-32BIT-NEXT:    addi 1, 1, 48
; LE-32BIT-NEXT:    blr
  %src = load i128, ptr %src.ptr, align 1
  %bitOff = load i128, ptr %bitOff.ptr, align 1
  %res = shl i128 %src, %bitOff
  store i128 %res, ptr %dst, align 1
  ret void
}
define void @ashr_16bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; LE-64BIT-LABEL: ashr_16bytes:
; LE-64BIT:       # %bb.0:
; LE-64BIT-NEXT:    lwz 4, 0(4)
; LE-64BIT-NEXT:    ld 6, 8(3)
; LE-64BIT-NEXT:    subfic 7, 4, 64
; LE-64BIT-NEXT:    ld 3, 0(3)
; LE-64BIT-NEXT:    srd 3, 3, 4
; LE-64BIT-NEXT:    sld 7, 6, 7
; LE-64BIT-NEXT:    or 3, 3, 7
; LE-64BIT-NEXT:    addi 7, 4, -64
; LE-64BIT-NEXT:    srad 4, 6, 4
; LE-64BIT-NEXT:    cmpwi 7, 1
; LE-64BIT-NEXT:    srad 8, 6, 7
; LE-64BIT-NEXT:    std 4, 8(5)
; LE-64BIT-NEXT:    isellt 3, 3, 8
; LE-64BIT-NEXT:    std 3, 0(5)
; LE-64BIT-NEXT:    blr
;
; BE-LABEL: ashr_16bytes:
; BE:       # %bb.0:
; BE-NEXT:    lwz 4, 12(4)
; BE-NEXT:    ld 6, 0(3)
; BE-NEXT:    addi 7, 4, -64
; BE-NEXT:    cmpwi 7, 1
; BE-NEXT:    blt 0, .LBB8_2
; BE-NEXT:  # %bb.1:
; BE-NEXT:    srad 3, 6, 7
; BE-NEXT:    b .LBB8_3
; BE-NEXT:  .LBB8_2:
; BE-NEXT:    ld 3, 8(3)
; BE-NEXT:    subfic 7, 4, 64
; BE-NEXT:    sld 7, 6, 7
; BE-NEXT:    srd 3, 3, 4
; BE-NEXT:    or 3, 3, 7
; BE-NEXT:  .LBB8_3:
; BE-NEXT:    srad 4, 6, 4
; BE-NEXT:    std 3, 8(5)
; BE-NEXT:    std 4, 0(5)
; BE-NEXT:    blr
;
; LE-32BIT-LABEL: ashr_16bytes:
; LE-32BIT:       # %bb.0:
; LE-32BIT-NEXT:    stwu 1, -48(1)
; LE-32BIT-NEXT:    lwz 7, 0(3)
; LE-32BIT-NEXT:    li 6, 7
; LE-32BIT-NEXT:    lwz 8, 4(3)
; LE-32BIT-NEXT:    lwz 9, 8(3)
; LE-32BIT-NEXT:    lwz 3, 12(3)
; LE-32BIT-NEXT:    lwz 4, 12(4)
; LE-32BIT-NEXT:    stw 3, 44(1)
; LE-32BIT-NEXT:    srawi 3, 7, 31
; LE-32BIT-NEXT:    stw 8, 36(1)
; LE-32BIT-NEXT:    rlwinm 8, 4, 29, 28, 31
; LE-32BIT-NEXT:    stw 7, 32(1)
; LE-32BIT-NEXT:    addi 7, 1, 32
; LE-32BIT-NEXT:    stw 9, 40(1)
; LE-32BIT-NEXT:    nand 6, 4, 6
; LE-32BIT-NEXT:    stw 3, 28(1)
; LE-32BIT-NEXT:    clrlwi 4, 4, 29
; LE-32BIT-NEXT:    stw 3, 24(1)
; LE-32BIT-NEXT:    subfic 10, 4, 32
; LE-32BIT-NEXT:    stw 3, 20(1)
; LE-32BIT-NEXT:    clrlwi 6, 6, 27
; LE-32BIT-NEXT:    stw 3, 16(1)
; LE-32BIT-NEXT:    sub 3, 7, 8
; LE-32BIT-NEXT:    lwz 7, 4(3)
; LE-32BIT-NEXT:    lwz 8, 8(3)
; LE-32BIT-NEXT:    lwz 9, 0(3)
; LE-32BIT-NEXT:    lwz 3, 12(3)
; LE-32BIT-NEXT:    srw 11, 8, 4
; LE-32BIT-NEXT:    slw 8, 8, 10
; LE-32BIT-NEXT:    slw 10, 9, 10
; LE-32BIT-NEXT:    srw 3, 3, 4
; LE-32BIT-NEXT:    sraw 9, 9, 4
; LE-32BIT-NEXT:    srw 4, 7, 4
; LE-32BIT-NEXT:    slwi 7, 7, 1
; LE-32BIT-NEXT:    or 3, 8, 3
; LE-32BIT-NEXT:    slw 6, 7, 6
; LE-32BIT-NEXT:    stw 3, 12(5)
; LE-32BIT-NEXT:    or 3, 10, 4
; LE-32BIT-NEXT:    stw 3, 4(5)
; LE-32BIT-NEXT:    or 3, 11, 6
; LE-32BIT-NEXT:    stw 9, 0(5)
; LE-32BIT-NEXT:    stw 3, 8(5)
; LE-32BIT-NEXT:    addi 1, 1, 48
; LE-32BIT-NEXT:    blr
  %src = load i128, ptr %src.ptr, align 1
  %bitOff = load i128, ptr %bitOff.ptr, align 1
  %res = ashr i128 %src, %bitOff
  store i128 %res, ptr %dst, align 1
  ret void
}

define void @lshr_32bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; LE-64BIT-LABEL: lshr_32bytes:
; LE-64BIT:       # %bb.0:
; LE-64BIT-NEXT:    li 6, 16
; LE-64BIT-NEXT:    lxvd2x 1, 0, 3
; LE-64BIT-NEXT:    xxlxor 2, 2, 2
; LE-64BIT-NEXT:    addi 7, 1, -64
; LE-64BIT-NEXT:    li 8, 32
; LE-64BIT-NEXT:    lxvd2x 0, 3, 6
; LE-64BIT-NEXT:    lwz 3, 0(4)
; LE-64BIT-NEXT:    li 4, 48
; LE-64BIT-NEXT:    stxvd2x 2, 7, 4
; LE-64BIT-NEXT:    stxvd2x 2, 7, 8
; LE-64BIT-NEXT:    rlwinm 4, 3, 29, 27, 31
; LE-64BIT-NEXT:    stxvd2x 0, 7, 6
; LE-64BIT-NEXT:    stxvd2x 1, 0, 7
; LE-64BIT-NEXT:    li 6, 7
; LE-64BIT-NEXT:    ldux 7, 4, 7
; LE-64BIT-NEXT:    ld 8, 16(4)
; LE-64BIT-NEXT:    nand 6, 3, 6
; LE-64BIT-NEXT:    ld 9, 8(4)
; LE-64BIT-NEXT:    clrlwi 3, 3, 29
; LE-64BIT-NEXT:    ld 4, 24(4)
; LE-64BIT-NEXT:    clrlwi 6, 6, 26
; LE-64BIT-NEXT:    srd 7, 7, 3
; LE-64BIT-NEXT:    sldi 10, 8, 1
; LE-64BIT-NEXT:    srd 11, 9, 3
; LE-64BIT-NEXT:    srd 8, 8, 3
; LE-64BIT-NEXT:    sld 6, 10, 6
; LE-64BIT-NEXT:    subfic 10, 3, 64
; LE-64BIT-NEXT:    srd 3, 4, 3
; LE-64BIT-NEXT:    or 6, 11, 6
; LE-64BIT-NEXT:    sld 11, 4, 10
; LE-64BIT-NEXT:    sld 9, 9, 10
; LE-64BIT-NEXT:    std 3, 24(5)
; LE-64BIT-NEXT:    or 7, 9, 7
; LE-64BIT-NEXT:    or 3, 11, 8
; LE-64BIT-NEXT:    std 6, 8(5)
; LE-64BIT-NEXT:    std 7, 0(5)
; LE-64BIT-NEXT:    std 3, 16(5)
; LE-64BIT-NEXT:    blr
;
; BE-LABEL: lshr_32bytes:
; BE:       # %bb.0:
; BE-NEXT:    ld 6, 0(3)
; BE-NEXT:    ld 7, 8(3)
; BE-NEXT:    ld 8, 16(3)
; BE-NEXT:    ld 3, 24(3)
; BE-NEXT:    lwz 4, 28(4)
; BE-NEXT:    addi 9, 1, -64
; BE-NEXT:    li 10, 0
; BE-NEXT:    addi 11, 1, -32
; BE-NEXT:    std 3, 56(9)
; BE-NEXT:    rlwinm 3, 4, 29, 27, 31
; BE-NEXT:    neg 3, 3
; BE-NEXT:    std 10, 24(9)
; BE-NEXT:    std 10, 16(9)
; BE-NEXT:    std 10, 8(9)
; BE-NEXT:    std 10, -64(1)
; BE-NEXT:    std 8, 48(9)
; BE-NEXT:    std 7, 40(9)
; BE-NEXT:    std 6, 32(9)
; BE-NEXT:    extsw 3, 3
; BE-NEXT:    ldux 3, 11, 3
; BE-NEXT:    li 6, 7
; BE-NEXT:    nand 6, 4, 6
; BE-NEXT:    clrlwi 4, 4, 29
; BE-NEXT:    clrlwi 6, 6, 26
; BE-NEXT:    ld 7, 8(11)
; BE-NEXT:    ld 8, 16(11)
; BE-NEXT:    ld 9, 24(11)
; BE-NEXT:    subfic 10, 4, 64
; BE-NEXT:    sldi 11, 7, 1
; BE-NEXT:    srd 7, 7, 4
; BE-NEXT:    srd 9, 9, 4
; BE-NEXT:    sld 6, 11, 6
; BE-NEXT:    sld 11, 3, 10
; BE-NEXT:    sld 10, 8, 10
; BE-NEXT:    srd 8, 8, 4
; BE-NEXT:    srd 3, 3, 4
; BE-NEXT:    or 7, 11, 7
; BE-NEXT:    or 6, 8, 6
; BE-NEXT:    or 8, 10, 9
; BE-NEXT:    std 3, 0(5)
; BE-NEXT:    std 8, 24(5)
; BE-NEXT:    std 7, 8(5)
; BE-NEXT:    std 6, 16(5)
; BE-NEXT:    blr
;
; LE-32BIT-LABEL: lshr_32bytes:
; LE-32BIT:       # %bb.0:
; LE-32BIT-NEXT:    stwu 1, -112(1)
; LE-32BIT-NEXT:    lwz 7, 0(3)
; LE-32BIT-NEXT:    li 6, 0
; LE-32BIT-NEXT:    lwz 8, 4(3)
; LE-32BIT-NEXT:    lwz 9, 8(3)
; LE-32BIT-NEXT:    lwz 10, 12(3)
; LE-32BIT-NEXT:    lwz 11, 16(3)
; LE-32BIT-NEXT:    lwz 12, 20(3)
; LE-32BIT-NEXT:    lwz 0, 24(3)
; LE-32BIT-NEXT:    lwz 3, 28(3)
; LE-32BIT-NEXT:    lwz 4, 28(4)
; LE-32BIT-NEXT:    stw 6, 48(1)
; LE-32BIT-NEXT:    stw 6, 44(1)
; LE-32BIT-NEXT:    stw 6, 40(1)
; LE-32BIT-NEXT:    stw 6, 36(1)
; LE-32BIT-NEXT:    stw 6, 32(1)
; LE-32BIT-NEXT:    stw 6, 28(1)
; LE-32BIT-NEXT:    stw 6, 24(1)
; LE-32BIT-NEXT:    stw 6, 20(1)
; LE-32BIT-NEXT:    rlwinm 6, 4, 29, 27, 31
; LE-32BIT-NEXT:    stw 3, 80(1)
; LE-32BIT-NEXT:    addi 3, 1, 52
; LE-32BIT-NEXT:    stw 25, 84(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    sub 3, 3, 6
; LE-32BIT-NEXT:    stw 26, 88(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 27, 92(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 28, 96(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 29, 100(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 30, 104(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 0, 76(1)
; LE-32BIT-NEXT:    stw 12, 72(1)
; LE-32BIT-NEXT:    stw 11, 68(1)
; LE-32BIT-NEXT:    stw 10, 64(1)
; LE-32BIT-NEXT:    stw 9, 60(1)
; LE-32BIT-NEXT:    li 9, 7
; LE-32BIT-NEXT:    stw 8, 56(1)
; LE-32BIT-NEXT:    nand 9, 4, 9
; LE-32BIT-NEXT:    stw 7, 52(1)
; LE-32BIT-NEXT:    clrlwi 4, 4, 29
; LE-32BIT-NEXT:    lwz 6, 4(3)
; LE-32BIT-NEXT:    subfic 30, 4, 32
; LE-32BIT-NEXT:    lwz 7, 8(3)
; LE-32BIT-NEXT:    clrlwi 9, 9, 27
; LE-32BIT-NEXT:    lwz 8, 12(3)
; LE-32BIT-NEXT:    slwi 29, 6, 1
; LE-32BIT-NEXT:    lwz 10, 16(3)
; LE-32BIT-NEXT:    srw 28, 7, 4
; LE-32BIT-NEXT:    lwz 11, 20(3)
; LE-32BIT-NEXT:    slwi 27, 8, 1
; LE-32BIT-NEXT:    lwz 12, 24(3)
; LE-32BIT-NEXT:    srw 26, 10, 4
; LE-32BIT-NEXT:    lwz 0, 0(3)
; LE-32BIT-NEXT:    srw 6, 6, 4
; LE-32BIT-NEXT:    lwz 3, 28(3)
; LE-32BIT-NEXT:    srw 25, 12, 4
; LE-32BIT-NEXT:    slw 12, 12, 30
; LE-32BIT-NEXT:    slw 7, 7, 30
; LE-32BIT-NEXT:    srw 3, 3, 4
; LE-32BIT-NEXT:    slw 10, 10, 30
; LE-32BIT-NEXT:    slw 30, 0, 30
; LE-32BIT-NEXT:    srw 8, 8, 4
; LE-32BIT-NEXT:    srw 0, 0, 4
; LE-32BIT-NEXT:    srw 4, 11, 4
; LE-32BIT-NEXT:    or 3, 12, 3
; LE-32BIT-NEXT:    stw 3, 28(5)
; LE-32BIT-NEXT:    or 3, 10, 4
; LE-32BIT-NEXT:    slwi 11, 11, 1
; LE-32BIT-NEXT:    stw 3, 20(5)
; LE-32BIT-NEXT:    or 3, 7, 8
; LE-32BIT-NEXT:    slw 29, 29, 9
; LE-32BIT-NEXT:    slw 27, 27, 9
; LE-32BIT-NEXT:    slw 9, 11, 9
; LE-32BIT-NEXT:    stw 3, 12(5)
; LE-32BIT-NEXT:    or 3, 30, 6
; LE-32BIT-NEXT:    stw 3, 4(5)
; LE-32BIT-NEXT:    or 3, 25, 9
; LE-32BIT-NEXT:    stw 3, 24(5)
; LE-32BIT-NEXT:    or 3, 26, 27
; LE-32BIT-NEXT:    stw 3, 16(5)
; LE-32BIT-NEXT:    or 3, 28, 29
; LE-32BIT-NEXT:    stw 0, 0(5)
; LE-32BIT-NEXT:    stw 3, 8(5)
; LE-32BIT-NEXT:    lwz 30, 104(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 29, 100(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 28, 96(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 27, 92(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 26, 88(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 25, 84(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    addi 1, 1, 112
; LE-32BIT-NEXT:    blr
  %src = load i256, ptr %src.ptr, align 1
  %bitOff = load i256, ptr %bitOff.ptr, align 1
  %res = lshr i256 %src, %bitOff
  store i256 %res, ptr %dst, align 1
  ret void
}
define void @shl_32bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; LE-64BIT-LABEL: shl_32bytes:
; LE-64BIT:       # %bb.0:
; LE-64BIT-NEXT:    li 6, 16
; LE-64BIT-NEXT:    lwz 4, 0(4)
; LE-64BIT-NEXT:    xxlxor 2, 2, 2
; LE-64BIT-NEXT:    addi 7, 1, -64
; LE-64BIT-NEXT:    lxvd2x 1, 0, 3
; LE-64BIT-NEXT:    addi 8, 1, -32
; LE-64BIT-NEXT:    lxvd2x 0, 3, 6
; LE-64BIT-NEXT:    stxvd2x 2, 7, 6
; LE-64BIT-NEXT:    li 6, 48
; LE-64BIT-NEXT:    rlwinm 3, 4, 29, 27, 31
; LE-64BIT-NEXT:    neg 3, 3
; LE-64BIT-NEXT:    stxvd2x 0, 7, 6
; LE-64BIT-NEXT:    li 6, 32
; LE-64BIT-NEXT:    extsw 3, 3
; LE-64BIT-NEXT:    stxvd2x 1, 7, 6
; LE-64BIT-NEXT:    stxvd2x 2, 0, 7
; LE-64BIT-NEXT:    li 6, 7
; LE-64BIT-NEXT:    ldux 3, 8, 3
; LE-64BIT-NEXT:    ld 7, 8(8)
; LE-64BIT-NEXT:    nand 6, 4, 6
; LE-64BIT-NEXT:    ld 9, 16(8)
; LE-64BIT-NEXT:    clrlwi 4, 4, 29
; LE-64BIT-NEXT:    ld 8, 24(8)
; LE-64BIT-NEXT:    clrlwi 6, 6, 26
; LE-64BIT-NEXT:    rldicl 10, 7, 63, 1
; LE-64BIT-NEXT:    sld 8, 8, 4
; LE-64BIT-NEXT:    sld 7, 7, 4
; LE-64BIT-NEXT:    srd 6, 10, 6
; LE-64BIT-NEXT:    sld 10, 9, 4
; LE-64BIT-NEXT:    or 6, 10, 6
; LE-64BIT-NEXT:    subfic 10, 4, 64
; LE-64BIT-NEXT:    srd 9, 9, 10
; LE-64BIT-NEXT:    srd 10, 3, 10
; LE-64BIT-NEXT:    sld 3, 3, 4
; LE-64BIT-NEXT:    std 6, 16(5)
; LE-64BIT-NEXT:    or 7, 7, 10
; LE-64BIT-NEXT:    std 3, 0(5)
; LE-64BIT-NEXT:    or 3, 8, 9
; LE-64BIT-NEXT:    std 7, 8(5)
; LE-64BIT-NEXT:    std 3, 24(5)
; LE-64BIT-NEXT:    blr
;
; BE-LABEL: shl_32bytes:
; BE:       # %bb.0:
; BE-NEXT:    ld 6, 0(3)
; BE-NEXT:    ld 7, 8(3)
; BE-NEXT:    ld 8, 16(3)
; BE-NEXT:    ld 3, 24(3)
; BE-NEXT:    lwz 4, 28(4)
; BE-NEXT:    addi 9, 1, -64
; BE-NEXT:    li 10, 0
; BE-NEXT:    std 10, 56(9)
; BE-NEXT:    std 10, 48(9)
; BE-NEXT:    std 10, 40(9)
; BE-NEXT:    std 10, 32(9)
; BE-NEXT:    std 3, 24(9)
; BE-NEXT:    std 8, 16(9)
; BE-NEXT:    std 7, 8(9)
; BE-NEXT:    std 6, -64(1)
; BE-NEXT:    rlwinm 3, 4, 29, 27, 31
; BE-NEXT:    ldux 6, 3, 9
; BE-NEXT:    li 7, 7
; BE-NEXT:    nand 7, 4, 7
; BE-NEXT:    clrlwi 4, 4, 29
; BE-NEXT:    clrlwi 7, 7, 26
; BE-NEXT:    ld 8, 16(3)
; BE-NEXT:    ld 9, 8(3)
; BE-NEXT:    ld 3, 24(3)
; BE-NEXT:    subfic 10, 4, 64
; BE-NEXT:    sld 6, 6, 4
; BE-NEXT:    rldicl 11, 8, 63, 1
; BE-NEXT:    sld 8, 8, 4
; BE-NEXT:    srd 7, 11, 7
; BE-NEXT:    srd 11, 9, 10
; BE-NEXT:    sld 9, 9, 4
; BE-NEXT:    srd 10, 3, 10
; BE-NEXT:    sld 3, 3, 4
; BE-NEXT:    or 6, 6, 11
; BE-NEXT:    or 7, 9, 7
; BE-NEXT:    or 8, 8, 10
; BE-NEXT:    std 3, 24(5)
; BE-NEXT:    std 8, 16(5)
; BE-NEXT:    std 6, 0(5)
; BE-NEXT:    std 7, 8(5)
; BE-NEXT:    blr
;
; LE-32BIT-LABEL: shl_32bytes:
; LE-32BIT:       # %bb.0:
; LE-32BIT-NEXT:    stwu 1, -112(1)
; LE-32BIT-NEXT:    lwz 7, 0(3)
; LE-32BIT-NEXT:    li 6, 0
; LE-32BIT-NEXT:    lwz 8, 4(3)
; LE-32BIT-NEXT:    lwz 9, 8(3)
; LE-32BIT-NEXT:    lwz 10, 12(3)
; LE-32BIT-NEXT:    lwz 11, 16(3)
; LE-32BIT-NEXT:    lwz 12, 20(3)
; LE-32BIT-NEXT:    lwz 0, 24(3)
; LE-32BIT-NEXT:    lwz 3, 28(3)
; LE-32BIT-NEXT:    lwz 4, 28(4)
; LE-32BIT-NEXT:    stw 25, 84(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 26, 88(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 27, 92(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 28, 96(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 29, 100(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 30, 104(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 6, 80(1)
; LE-32BIT-NEXT:    stw 6, 76(1)
; LE-32BIT-NEXT:    stw 6, 72(1)
; LE-32BIT-NEXT:    stw 6, 68(1)
; LE-32BIT-NEXT:    stw 6, 64(1)
; LE-32BIT-NEXT:    stw 6, 60(1)
; LE-32BIT-NEXT:    stw 6, 56(1)
; LE-32BIT-NEXT:    stw 6, 52(1)
; LE-32BIT-NEXT:    rlwinm 6, 4, 29, 27, 31
; LE-32BIT-NEXT:    stw 3, 48(1)
; LE-32BIT-NEXT:    addi 3, 1, 20
; LE-32BIT-NEXT:    stw 0, 44(1)
; LE-32BIT-NEXT:    stw 12, 40(1)
; LE-32BIT-NEXT:    stw 11, 36(1)
; LE-32BIT-NEXT:    stw 10, 32(1)
; LE-32BIT-NEXT:    stw 9, 28(1)
; LE-32BIT-NEXT:    stw 8, 24(1)
; LE-32BIT-NEXT:    li 8, 7
; LE-32BIT-NEXT:    stw 7, 20(1)
; LE-32BIT-NEXT:    nand 8, 4, 8
; LE-32BIT-NEXT:    lwzux 3, 6, 3
; LE-32BIT-NEXT:    clrlwi 4, 4, 29
; LE-32BIT-NEXT:    subfic 0, 4, 32
; LE-32BIT-NEXT:    clrlwi 8, 8, 27
; LE-32BIT-NEXT:    lwz 7, 8(6)
; LE-32BIT-NEXT:    slw 3, 3, 4
; LE-32BIT-NEXT:    lwz 9, 4(6)
; LE-32BIT-NEXT:    lwz 10, 16(6)
; LE-32BIT-NEXT:    srwi 29, 7, 1
; LE-32BIT-NEXT:    lwz 11, 12(6)
; LE-32BIT-NEXT:    slw 28, 9, 4
; LE-32BIT-NEXT:    lwz 12, 24(6)
; LE-32BIT-NEXT:    srwi 27, 10, 1
; LE-32BIT-NEXT:    lwz 30, 20(6)
; LE-32BIT-NEXT:    slw 26, 11, 4
; LE-32BIT-NEXT:    lwz 6, 28(6)
; LE-32BIT-NEXT:    srw 9, 9, 0
; LE-32BIT-NEXT:    slw 25, 30, 4
; LE-32BIT-NEXT:    srw 11, 11, 0
; LE-32BIT-NEXT:    slw 7, 7, 4
; LE-32BIT-NEXT:    srw 30, 30, 0
; LE-32BIT-NEXT:    slw 10, 10, 4
; LE-32BIT-NEXT:    srw 0, 6, 0
; LE-32BIT-NEXT:    slw 6, 6, 4
; LE-32BIT-NEXT:    slw 4, 12, 4
; LE-32BIT-NEXT:    srwi 12, 12, 1
; LE-32BIT-NEXT:    srw 29, 29, 8
; LE-32BIT-NEXT:    srw 27, 27, 8
; LE-32BIT-NEXT:    srw 8, 12, 8
; LE-32BIT-NEXT:    or 3, 3, 9
; LE-32BIT-NEXT:    or 4, 4, 0
; LE-32BIT-NEXT:    stw 3, 0(5)
; LE-32BIT-NEXT:    or 3, 25, 8
; LE-32BIT-NEXT:    stw 4, 24(5)
; LE-32BIT-NEXT:    or 4, 10, 30
; LE-32BIT-NEXT:    stw 3, 20(5)
; LE-32BIT-NEXT:    or 3, 26, 27
; LE-32BIT-NEXT:    stw 4, 16(5)
; LE-32BIT-NEXT:    or 4, 7, 11
; LE-32BIT-NEXT:    stw 3, 12(5)
; LE-32BIT-NEXT:    or 3, 28, 29
; LE-32BIT-NEXT:    stw 6, 28(5)
; LE-32BIT-NEXT:    stw 4, 8(5)
; LE-32BIT-NEXT:    stw 3, 4(5)
; LE-32BIT-NEXT:    lwz 30, 104(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 29, 100(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 28, 96(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 27, 92(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 26, 88(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 25, 84(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    addi 1, 1, 112
; LE-32BIT-NEXT:    blr
  %src = load i256, ptr %src.ptr, align 1
  %bitOff = load i256, ptr %bitOff.ptr, align 1
  %res = shl i256 %src, %bitOff
  store i256 %res, ptr %dst, align 1
  ret void
}
define void @ashr_32bytes(ptr %src.ptr, ptr %bitOff.ptr, ptr %dst) nounwind {
; LE-64BIT-LABEL: ashr_32bytes:
; LE-64BIT:       # %bb.0:
; LE-64BIT-NEXT:    lxvd2x 0, 0, 3
; LE-64BIT-NEXT:    ld 6, 24(3)
; LE-64BIT-NEXT:    lwz 4, 0(4)
; LE-64BIT-NEXT:    addi 7, 1, -64
; LE-64BIT-NEXT:    ld 3, 16(3)
; LE-64BIT-NEXT:    sradi 8, 6, 63
; LE-64BIT-NEXT:    rlwinm 9, 4, 29, 27, 31
; LE-64BIT-NEXT:    std 6, 24(7)
; LE-64BIT-NEXT:    std 3, 16(7)
; LE-64BIT-NEXT:    li 3, 7
; LE-64BIT-NEXT:    std 8, 56(7)
; LE-64BIT-NEXT:    std 8, 48(7)
; LE-64BIT-NEXT:    std 8, 40(7)
; LE-64BIT-NEXT:    std 8, 32(7)
; LE-64BIT-NEXT:    stxvd2x 0, 0, 7
; LE-64BIT-NEXT:    nand 3, 4, 3
; LE-64BIT-NEXT:    clrlwi 4, 4, 29
; LE-64BIT-NEXT:    ldux 6, 9, 7
; LE-64BIT-NEXT:    ld 7, 16(9)
; LE-64BIT-NEXT:    ld 8, 8(9)
; LE-64BIT-NEXT:    clrlwi 3, 3, 26
; LE-64BIT-NEXT:    ld 9, 24(9)
; LE-64BIT-NEXT:    srd 6, 6, 4
; LE-64BIT-NEXT:    sldi 10, 7, 1
; LE-64BIT-NEXT:    srd 11, 8, 4
; LE-64BIT-NEXT:    srd 7, 7, 4
; LE-64BIT-NEXT:    sld 3, 10, 3
; LE-64BIT-NEXT:    subfic 10, 4, 64
; LE-64BIT-NEXT:    srad 4, 9, 4
; LE-64BIT-NEXT:    or 3, 11, 3
; LE-64BIT-NEXT:    sld 11, 9, 10
; LE-64BIT-NEXT:    sld 8, 8, 10
; LE-64BIT-NEXT:    std 4, 24(5)
; LE-64BIT-NEXT:    or 6, 8, 6
; LE-64BIT-NEXT:    or 4, 11, 7
; LE-64BIT-NEXT:    std 3, 8(5)
; LE-64BIT-NEXT:    std 6, 0(5)
; LE-64BIT-NEXT:    std 4, 16(5)
; LE-64BIT-NEXT:    blr
;
; BE-LABEL: ashr_32bytes:
; BE:       # %bb.0:
; BE-NEXT:    ld 6, 0(3)
; BE-NEXT:    ld 7, 8(3)
; BE-NEXT:    ld 8, 16(3)
; BE-NEXT:    ld 3, 24(3)
; BE-NEXT:    lwz 4, 28(4)
; BE-NEXT:    addi 9, 1, -64
; BE-NEXT:    addi 10, 1, -32
; BE-NEXT:    std 3, 56(9)
; BE-NEXT:    std 6, 32(9)
; BE-NEXT:    sradi 3, 6, 63
; BE-NEXT:    rlwinm 6, 4, 29, 27, 31
; BE-NEXT:    std 3, 24(9)
; BE-NEXT:    std 3, 16(9)
; BE-NEXT:    std 3, 8(9)
; BE-NEXT:    std 3, -64(1)
; BE-NEXT:    neg 3, 6
; BE-NEXT:    std 8, 48(9)
; BE-NEXT:    std 7, 40(9)
; BE-NEXT:    extsw 3, 3
; BE-NEXT:    ldux 3, 10, 3
; BE-NEXT:    li 6, 7
; BE-NEXT:    nand 6, 4, 6
; BE-NEXT:    clrlwi 4, 4, 29
; BE-NEXT:    clrlwi 6, 6, 26
; BE-NEXT:    ld 7, 8(10)
; BE-NEXT:    ld 8, 16(10)
; BE-NEXT:    ld 9, 24(10)
; BE-NEXT:    subfic 10, 4, 64
; BE-NEXT:    sldi 11, 7, 1
; BE-NEXT:    srd 7, 7, 4
; BE-NEXT:    srd 9, 9, 4
; BE-NEXT:    sld 6, 11, 6
; BE-NEXT:    sld 11, 3, 10
; BE-NEXT:    sld 10, 8, 10
; BE-NEXT:    srd 8, 8, 4
; BE-NEXT:    srad 3, 3, 4
; BE-NEXT:    or 7, 11, 7
; BE-NEXT:    or 6, 8, 6
; BE-NEXT:    or 8, 10, 9
; BE-NEXT:    std 3, 0(5)
; BE-NEXT:    std 8, 24(5)
; BE-NEXT:    std 7, 8(5)
; BE-NEXT:    std 6, 16(5)
; BE-NEXT:    blr
;
; LE-32BIT-LABEL: ashr_32bytes:
; LE-32BIT:       # %bb.0:
; LE-32BIT-NEXT:    stwu 1, -112(1)
; LE-32BIT-NEXT:    lwz 7, 0(3)
; LE-32BIT-NEXT:    addi 6, 1, 52
; LE-32BIT-NEXT:    lwz 8, 4(3)
; LE-32BIT-NEXT:    lwz 9, 8(3)
; LE-32BIT-NEXT:    lwz 10, 12(3)
; LE-32BIT-NEXT:    lwz 11, 16(3)
; LE-32BIT-NEXT:    lwz 12, 20(3)
; LE-32BIT-NEXT:    lwz 0, 24(3)
; LE-32BIT-NEXT:    lwz 3, 28(3)
; LE-32BIT-NEXT:    lwz 4, 28(4)
; LE-32BIT-NEXT:    stw 3, 80(1)
; LE-32BIT-NEXT:    srawi 3, 7, 31
; LE-32BIT-NEXT:    stw 7, 52(1)
; LE-32BIT-NEXT:    rlwinm 7, 4, 29, 27, 31
; LE-32BIT-NEXT:    stw 25, 84(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 26, 88(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 27, 92(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 28, 96(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 29, 100(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 30, 104(1) # 4-byte Folded Spill
; LE-32BIT-NEXT:    stw 0, 76(1)
; LE-32BIT-NEXT:    stw 12, 72(1)
; LE-32BIT-NEXT:    stw 11, 68(1)
; LE-32BIT-NEXT:    stw 10, 64(1)
; LE-32BIT-NEXT:    stw 9, 60(1)
; LE-32BIT-NEXT:    li 9, 7
; LE-32BIT-NEXT:    stw 8, 56(1)
; LE-32BIT-NEXT:    nand 9, 4, 9
; LE-32BIT-NEXT:    stw 3, 48(1)
; LE-32BIT-NEXT:    clrlwi 4, 4, 29
; LE-32BIT-NEXT:    stw 3, 44(1)
; LE-32BIT-NEXT:    subfic 30, 4, 32
; LE-32BIT-NEXT:    stw 3, 40(1)
; LE-32BIT-NEXT:    clrlwi 9, 9, 27
; LE-32BIT-NEXT:    stw 3, 36(1)
; LE-32BIT-NEXT:    stw 3, 32(1)
; LE-32BIT-NEXT:    stw 3, 28(1)
; LE-32BIT-NEXT:    stw 3, 24(1)
; LE-32BIT-NEXT:    stw 3, 20(1)
; LE-32BIT-NEXT:    sub 3, 6, 7
; LE-32BIT-NEXT:    lwz 6, 4(3)
; LE-32BIT-NEXT:    lwz 7, 8(3)
; LE-32BIT-NEXT:    lwz 8, 12(3)
; LE-32BIT-NEXT:    slwi 29, 6, 1
; LE-32BIT-NEXT:    lwz 10, 16(3)
; LE-32BIT-NEXT:    srw 28, 7, 4
; LE-32BIT-NEXT:    lwz 11, 20(3)
; LE-32BIT-NEXT:    slwi 27, 8, 1
; LE-32BIT-NEXT:    lwz 12, 24(3)
; LE-32BIT-NEXT:    srw 26, 10, 4
; LE-32BIT-NEXT:    lwz 0, 0(3)
; LE-32BIT-NEXT:    srw 6, 6, 4
; LE-32BIT-NEXT:    lwz 3, 28(3)
; LE-32BIT-NEXT:    srw 25, 12, 4
; LE-32BIT-NEXT:    slw 12, 12, 30
; LE-32BIT-NEXT:    slw 7, 7, 30
; LE-32BIT-NEXT:    srw 3, 3, 4
; LE-32BIT-NEXT:    slw 10, 10, 30
; LE-32BIT-NEXT:    slw 30, 0, 30
; LE-32BIT-NEXT:    srw 8, 8, 4
; LE-32BIT-NEXT:    sraw 0, 0, 4
; LE-32BIT-NEXT:    srw 4, 11, 4
; LE-32BIT-NEXT:    or 3, 12, 3
; LE-32BIT-NEXT:    stw 3, 28(5)
; LE-32BIT-NEXT:    or 3, 10, 4
; LE-32BIT-NEXT:    slwi 11, 11, 1
; LE-32BIT-NEXT:    stw 3, 20(5)
; LE-32BIT-NEXT:    or 3, 7, 8
; LE-32BIT-NEXT:    slw 29, 29, 9
; LE-32BIT-NEXT:    slw 27, 27, 9
; LE-32BIT-NEXT:    slw 9, 11, 9
; LE-32BIT-NEXT:    stw 3, 12(5)
; LE-32BIT-NEXT:    or 3, 30, 6
; LE-32BIT-NEXT:    stw 3, 4(5)
; LE-32BIT-NEXT:    or 3, 25, 9
; LE-32BIT-NEXT:    stw 3, 24(5)
; LE-32BIT-NEXT:    or 3, 26, 27
; LE-32BIT-NEXT:    stw 3, 16(5)
; LE-32BIT-NEXT:    or 3, 28, 29
; LE-32BIT-NEXT:    stw 0, 0(5)
; LE-32BIT-NEXT:    stw 3, 8(5)
; LE-32BIT-NEXT:    lwz 30, 104(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 29, 100(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 28, 96(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 27, 92(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 26, 88(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    lwz 25, 84(1) # 4-byte Folded Reload
; LE-32BIT-NEXT:    addi 1, 1, 112
; LE-32BIT-NEXT:    blr
  %src = load i256, ptr %src.ptr, align 1
  %bitOff = load i256, ptr %bitOff.ptr, align 1
  %res = ashr i256 %src, %bitOff
  store i256 %res, ptr %dst, align 1
  ret void
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; LE: {{.*}}
