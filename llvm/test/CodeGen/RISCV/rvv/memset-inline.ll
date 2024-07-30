; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=riscv32 -mattr=+m,+v \
; RUN:   | FileCheck %s --check-prefixes=RV32-BOTH,RV32
; RUN: llc < %s -mtriple=riscv64 -mattr=+m,+v \
; RUN:   | FileCheck %s --check-prefixes=RV64-BOTH,RV64
; RUN: llc < %s -mtriple=riscv32 -mattr=+m,+v,+unaligned-scalar-mem,,+unaligned-vector-mem \
; RUN:   | FileCheck %s --check-prefixes=RV32-BOTH,RV32-FAST
; RUN: llc < %s -mtriple=riscv64 -mattr=+m,+v,+unaligned-scalar-mem,+unaligned-vector-mem \
; RUN:   | FileCheck %s --check-prefixes=RV64-BOTH,RV64-FAST
%struct.x = type { i8, i8, i8, i8, i8, i8, i8, i8, i8, i8, i8 }

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind
declare void @llvm.memset.inline.p0.i64(ptr nocapture, i8, i64, i1) nounwind

; /////////////////////////////////////////////////////////////////////////////

define void @memset_1(ptr %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: memset_1:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    sb a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: memset_1:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    sb a1, 0(a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 1, i1 0)
  ret void
}

define void @memset_2(ptr %a, i8 %value) nounwind {
; RV32-LABEL: memset_2:
; RV32:       # %bb.0:
; RV32-NEXT:    sb a1, 1(a0)
; RV32-NEXT:    sb a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: memset_2:
; RV64:       # %bb.0:
; RV64-NEXT:    sb a1, 1(a0)
; RV64-NEXT:    sb a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: memset_2:
; RV32-FAST:       # %bb.0:
; RV32-FAST-NEXT:    andi a2, a1, 255
; RV32-FAST-NEXT:    slli a1, a1, 8
; RV32-FAST-NEXT:    or a1, a1, a2
; RV32-FAST-NEXT:    sh a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: memset_2:
; RV64-FAST:       # %bb.0:
; RV64-FAST-NEXT:    andi a2, a1, 255
; RV64-FAST-NEXT:    slli a1, a1, 8
; RV64-FAST-NEXT:    or a1, a1, a2
; RV64-FAST-NEXT:    sh a1, 0(a0)
; RV64-FAST-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 2, i1 0)
  ret void
}

define void @memset_4(ptr %a, i8 %value) nounwind {
; RV32-LABEL: memset_4:
; RV32:       # %bb.0:
; RV32-NEXT:    sb a1, 3(a0)
; RV32-NEXT:    sb a1, 2(a0)
; RV32-NEXT:    sb a1, 1(a0)
; RV32-NEXT:    sb a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: memset_4:
; RV64:       # %bb.0:
; RV64-NEXT:    sb a1, 3(a0)
; RV64-NEXT:    sb a1, 2(a0)
; RV64-NEXT:    sb a1, 1(a0)
; RV64-NEXT:    sb a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: memset_4:
; RV32-FAST:       # %bb.0:
; RV32-FAST-NEXT:    andi a1, a1, 255
; RV32-FAST-NEXT:    lui a2, 4112
; RV32-FAST-NEXT:    addi a2, a2, 257
; RV32-FAST-NEXT:    mul a1, a1, a2
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: memset_4:
; RV64-FAST:       # %bb.0:
; RV64-FAST-NEXT:    slli a1, a1, 56
; RV64-FAST-NEXT:    lui a2, 65793
; RV64-FAST-NEXT:    slli a2, a2, 4
; RV64-FAST-NEXT:    addi a2, a2, 256
; RV64-FAST-NEXT:    mulhu a1, a1, a2
; RV64-FAST-NEXT:    sw a1, 0(a0)
; RV64-FAST-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 4, i1 0)
  ret void
}

define void @memset_8(ptr %a, i8 %value) nounwind {
; RV32-LABEL: memset_8:
; RV32:       # %bb.0:
; RV32-NEXT:    sb a1, 7(a0)
; RV32-NEXT:    sb a1, 6(a0)
; RV32-NEXT:    sb a1, 5(a0)
; RV32-NEXT:    sb a1, 4(a0)
; RV32-NEXT:    sb a1, 3(a0)
; RV32-NEXT:    sb a1, 2(a0)
; RV32-NEXT:    sb a1, 1(a0)
; RV32-NEXT:    sb a1, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: memset_8:
; RV64:       # %bb.0:
; RV64-NEXT:    sb a1, 7(a0)
; RV64-NEXT:    sb a1, 6(a0)
; RV64-NEXT:    sb a1, 5(a0)
; RV64-NEXT:    sb a1, 4(a0)
; RV64-NEXT:    sb a1, 3(a0)
; RV64-NEXT:    sb a1, 2(a0)
; RV64-NEXT:    sb a1, 1(a0)
; RV64-NEXT:    sb a1, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: memset_8:
; RV32-FAST:       # %bb.0:
; RV32-FAST-NEXT:    andi a1, a1, 255
; RV32-FAST-NEXT:    lui a2, 4112
; RV32-FAST-NEXT:    addi a2, a2, 257
; RV32-FAST-NEXT:    mul a1, a1, a2
; RV32-FAST-NEXT:    sw a1, 4(a0)
; RV32-FAST-NEXT:    sw a1, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: memset_8:
; RV64-FAST:       # %bb.0:
; RV64-FAST-NEXT:    andi a1, a1, 255
; RV64-FAST-NEXT:    lui a2, 4112
; RV64-FAST-NEXT:    addiw a2, a2, 257
; RV64-FAST-NEXT:    slli a3, a2, 32
; RV64-FAST-NEXT:    add a2, a2, a3
; RV64-FAST-NEXT:    mul a1, a1, a2
; RV64-FAST-NEXT:    sd a1, 0(a0)
; RV64-FAST-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 8, i1 0)
  ret void
}

define void @memset_16(ptr %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: memset_16:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32-BOTH-NEXT:    vmv.v.x v8, a1
; RV32-BOTH-NEXT:    vse8.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: memset_16:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64-BOTH-NEXT:    vmv.v.x v8, a1
; RV64-BOTH-NEXT:    vse8.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 16, i1 0)
  ret void
}

define void @memset_32(ptr %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: memset_32:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    addi a2, a0, 16
; RV32-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32-BOTH-NEXT:    vmv.v.x v8, a1
; RV32-BOTH-NEXT:    vse8.v v8, (a2)
; RV32-BOTH-NEXT:    vse8.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: memset_32:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    addi a2, a0, 16
; RV64-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64-BOTH-NEXT:    vmv.v.x v8, a1
; RV64-BOTH-NEXT:    vse8.v v8, (a2)
; RV64-BOTH-NEXT:    vse8.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 32, i1 0)
  ret void
}

define void @memset_64(ptr %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: memset_64:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    addi a2, a0, 48
; RV32-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32-BOTH-NEXT:    vmv.v.x v8, a1
; RV32-BOTH-NEXT:    vse8.v v8, (a2)
; RV32-BOTH-NEXT:    addi a1, a0, 32
; RV32-BOTH-NEXT:    vse8.v v8, (a1)
; RV32-BOTH-NEXT:    addi a1, a0, 16
; RV32-BOTH-NEXT:    vse8.v v8, (a1)
; RV32-BOTH-NEXT:    vse8.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: memset_64:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    addi a2, a0, 48
; RV64-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64-BOTH-NEXT:    vmv.v.x v8, a1
; RV64-BOTH-NEXT:    vse8.v v8, (a2)
; RV64-BOTH-NEXT:    addi a1, a0, 32
; RV64-BOTH-NEXT:    vse8.v v8, (a1)
; RV64-BOTH-NEXT:    addi a1, a0, 16
; RV64-BOTH-NEXT:    vse8.v v8, (a1)
; RV64-BOTH-NEXT:    vse8.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 %value, i64 64, i1 0)
  ret void
}

; /////////////////////////////////////////////////////////////////////////////

define void @aligned_memset_2(ptr align 2 %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: aligned_memset_2:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    andi a2, a1, 255
; RV32-BOTH-NEXT:    slli a1, a1, 8
; RV32-BOTH-NEXT:    or a1, a1, a2
; RV32-BOTH-NEXT:    sh a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memset_2:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    andi a2, a1, 255
; RV64-BOTH-NEXT:    slli a1, a1, 8
; RV64-BOTH-NEXT:    or a1, a1, a2
; RV64-BOTH-NEXT:    sh a1, 0(a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 2 %a, i8 %value, i64 2, i1 0)
  ret void
}

define void @aligned_memset_4(ptr align 4 %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: aligned_memset_4:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    andi a1, a1, 255
; RV32-BOTH-NEXT:    lui a2, 4112
; RV32-BOTH-NEXT:    addi a2, a2, 257
; RV32-BOTH-NEXT:    mul a1, a1, a2
; RV32-BOTH-NEXT:    sw a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memset_4:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    slli a1, a1, 56
; RV64-BOTH-NEXT:    lui a2, 65793
; RV64-BOTH-NEXT:    slli a2, a2, 4
; RV64-BOTH-NEXT:    addi a2, a2, 256
; RV64-BOTH-NEXT:    mulhu a1, a1, a2
; RV64-BOTH-NEXT:    sw a1, 0(a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 4 %a, i8 %value, i64 4, i1 0)
  ret void
}

define void @aligned_memset_8(ptr align 8 %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: aligned_memset_8:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    andi a1, a1, 255
; RV32-BOTH-NEXT:    lui a2, 4112
; RV32-BOTH-NEXT:    addi a2, a2, 257
; RV32-BOTH-NEXT:    mul a1, a1, a2
; RV32-BOTH-NEXT:    sw a1, 4(a0)
; RV32-BOTH-NEXT:    sw a1, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memset_8:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    andi a1, a1, 255
; RV64-BOTH-NEXT:    lui a2, 4112
; RV64-BOTH-NEXT:    addiw a2, a2, 257
; RV64-BOTH-NEXT:    slli a3, a2, 32
; RV64-BOTH-NEXT:    add a2, a2, a3
; RV64-BOTH-NEXT:    mul a1, a1, a2
; RV64-BOTH-NEXT:    sd a1, 0(a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 8 %a, i8 %value, i64 8, i1 0)
  ret void
}

define void @aligned_memset_16(ptr align 16 %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: aligned_memset_16:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32-BOTH-NEXT:    vmv.v.x v8, a1
; RV32-BOTH-NEXT:    vse8.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memset_16:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64-BOTH-NEXT:    vmv.v.x v8, a1
; RV64-BOTH-NEXT:    vse8.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 16 %a, i8 %value, i64 16, i1 0)
  ret void
}

define void @aligned_memset_32(ptr align 32 %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: aligned_memset_32:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    addi a2, a0, 16
; RV32-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32-BOTH-NEXT:    vmv.v.x v8, a1
; RV32-BOTH-NEXT:    vse8.v v8, (a2)
; RV32-BOTH-NEXT:    vse8.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memset_32:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    addi a2, a0, 16
; RV64-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64-BOTH-NEXT:    vmv.v.x v8, a1
; RV64-BOTH-NEXT:    vse8.v v8, (a2)
; RV64-BOTH-NEXT:    vse8.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 32 %a, i8 %value, i64 32, i1 0)
  ret void
}

define void @aligned_memset_64(ptr align 64 %a, i8 %value) nounwind {
; RV32-BOTH-LABEL: aligned_memset_64:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    addi a2, a0, 48
; RV32-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32-BOTH-NEXT:    vmv.v.x v8, a1
; RV32-BOTH-NEXT:    vse8.v v8, (a2)
; RV32-BOTH-NEXT:    addi a1, a0, 32
; RV32-BOTH-NEXT:    vse8.v v8, (a1)
; RV32-BOTH-NEXT:    addi a1, a0, 16
; RV32-BOTH-NEXT:    vse8.v v8, (a1)
; RV32-BOTH-NEXT:    vse8.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_memset_64:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    addi a2, a0, 48
; RV64-BOTH-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64-BOTH-NEXT:    vmv.v.x v8, a1
; RV64-BOTH-NEXT:    vse8.v v8, (a2)
; RV64-BOTH-NEXT:    addi a1, a0, 32
; RV64-BOTH-NEXT:    vse8.v v8, (a1)
; RV64-BOTH-NEXT:    addi a1, a0, 16
; RV64-BOTH-NEXT:    vse8.v v8, (a1)
; RV64-BOTH-NEXT:    vse8.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 64 %a, i8 %value, i64 64, i1 0)
  ret void
}

; /////////////////////////////////////////////////////////////////////////////

define void @bzero_1(ptr %a) nounwind {
; RV32-BOTH-LABEL: bzero_1:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    sb zero, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: bzero_1:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    sb zero, 0(a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 1, i1 0)
  ret void
}

define void @bzero_2(ptr %a) nounwind {
; RV32-LABEL: bzero_2:
; RV32:       # %bb.0:
; RV32-NEXT:    sb zero, 1(a0)
; RV32-NEXT:    sb zero, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: bzero_2:
; RV64:       # %bb.0:
; RV64-NEXT:    sb zero, 1(a0)
; RV64-NEXT:    sb zero, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: bzero_2:
; RV32-FAST:       # %bb.0:
; RV32-FAST-NEXT:    sh zero, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: bzero_2:
; RV64-FAST:       # %bb.0:
; RV64-FAST-NEXT:    sh zero, 0(a0)
; RV64-FAST-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 2, i1 0)
  ret void
}

define void @bzero_4(ptr %a) nounwind {
; RV32-LABEL: bzero_4:
; RV32:       # %bb.0:
; RV32-NEXT:    sb zero, 3(a0)
; RV32-NEXT:    sb zero, 2(a0)
; RV32-NEXT:    sb zero, 1(a0)
; RV32-NEXT:    sb zero, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: bzero_4:
; RV64:       # %bb.0:
; RV64-NEXT:    sb zero, 3(a0)
; RV64-NEXT:    sb zero, 2(a0)
; RV64-NEXT:    sb zero, 1(a0)
; RV64-NEXT:    sb zero, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: bzero_4:
; RV32-FAST:       # %bb.0:
; RV32-FAST-NEXT:    sw zero, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: bzero_4:
; RV64-FAST:       # %bb.0:
; RV64-FAST-NEXT:    sw zero, 0(a0)
; RV64-FAST-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 4, i1 0)
  ret void
}

define void @bzero_8(ptr %a) nounwind {
; RV32-LABEL: bzero_8:
; RV32:       # %bb.0:
; RV32-NEXT:    sb zero, 7(a0)
; RV32-NEXT:    sb zero, 6(a0)
; RV32-NEXT:    sb zero, 5(a0)
; RV32-NEXT:    sb zero, 4(a0)
; RV32-NEXT:    sb zero, 3(a0)
; RV32-NEXT:    sb zero, 2(a0)
; RV32-NEXT:    sb zero, 1(a0)
; RV32-NEXT:    sb zero, 0(a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: bzero_8:
; RV64:       # %bb.0:
; RV64-NEXT:    sb zero, 7(a0)
; RV64-NEXT:    sb zero, 6(a0)
; RV64-NEXT:    sb zero, 5(a0)
; RV64-NEXT:    sb zero, 4(a0)
; RV64-NEXT:    sb zero, 3(a0)
; RV64-NEXT:    sb zero, 2(a0)
; RV64-NEXT:    sb zero, 1(a0)
; RV64-NEXT:    sb zero, 0(a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: bzero_8:
; RV32-FAST:       # %bb.0:
; RV32-FAST-NEXT:    sw zero, 4(a0)
; RV32-FAST-NEXT:    sw zero, 0(a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: bzero_8:
; RV64-FAST:       # %bb.0:
; RV64-FAST-NEXT:    sd zero, 0(a0)
; RV64-FAST-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 8, i1 0)
  ret void
}

define void @bzero_16(ptr %a) nounwind {
; RV32-LABEL: bzero_16:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32-NEXT:    vmv.v.i v8, 0
; RV32-NEXT:    vse8.v v8, (a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: bzero_16:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64-NEXT:    vmv.v.i v8, 0
; RV64-NEXT:    vse8.v v8, (a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: bzero_16:
; RV32-FAST:       # %bb.0:
; RV32-FAST-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-FAST-NEXT:    vmv.v.i v8, 0
; RV32-FAST-NEXT:    vse64.v v8, (a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: bzero_16:
; RV64-FAST:       # %bb.0:
; RV64-FAST-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-FAST-NEXT:    vmv.v.i v8, 0
; RV64-FAST-NEXT:    vse64.v v8, (a0)
; RV64-FAST-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 16, i1 0)
  ret void
}

define void @bzero_32(ptr %a) nounwind {
; RV32-LABEL: bzero_32:
; RV32:       # %bb.0:
; RV32-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV32-NEXT:    vmv.v.i v8, 0
; RV32-NEXT:    vse8.v v8, (a0)
; RV32-NEXT:    addi a0, a0, 16
; RV32-NEXT:    vse8.v v8, (a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: bzero_32:
; RV64:       # %bb.0:
; RV64-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; RV64-NEXT:    vmv.v.i v8, 0
; RV64-NEXT:    vse8.v v8, (a0)
; RV64-NEXT:    addi a0, a0, 16
; RV64-NEXT:    vse8.v v8, (a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: bzero_32:
; RV32-FAST:       # %bb.0:
; RV32-FAST-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-FAST-NEXT:    vmv.v.i v8, 0
; RV32-FAST-NEXT:    vse64.v v8, (a0)
; RV32-FAST-NEXT:    addi a0, a0, 16
; RV32-FAST-NEXT:    vse64.v v8, (a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: bzero_32:
; RV64-FAST:       # %bb.0:
; RV64-FAST-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-FAST-NEXT:    vmv.v.i v8, 0
; RV64-FAST-NEXT:    vse64.v v8, (a0)
; RV64-FAST-NEXT:    addi a0, a0, 16
; RV64-FAST-NEXT:    vse64.v v8, (a0)
; RV64-FAST-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 32, i1 0)
  ret void
}

define void @bzero_64(ptr %a) nounwind {
; RV32-LABEL: bzero_64:
; RV32:       # %bb.0:
; RV32-NEXT:    li a1, 64
; RV32-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; RV32-NEXT:    vmv.v.i v8, 0
; RV32-NEXT:    vse8.v v8, (a0)
; RV32-NEXT:    ret
;
; RV64-LABEL: bzero_64:
; RV64:       # %bb.0:
; RV64-NEXT:    li a1, 64
; RV64-NEXT:    vsetvli zero, a1, e8, m4, ta, ma
; RV64-NEXT:    vmv.v.i v8, 0
; RV64-NEXT:    vse8.v v8, (a0)
; RV64-NEXT:    ret
;
; RV32-FAST-LABEL: bzero_64:
; RV32-FAST:       # %bb.0:
; RV32-FAST-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-FAST-NEXT:    vmv.v.i v8, 0
; RV32-FAST-NEXT:    vse64.v v8, (a0)
; RV32-FAST-NEXT:    ret
;
; RV64-FAST-LABEL: bzero_64:
; RV64-FAST:       # %bb.0:
; RV64-FAST-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-FAST-NEXT:    vmv.v.i v8, 0
; RV64-FAST-NEXT:    vse64.v v8, (a0)
; RV64-FAST-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr %a, i8 0, i64 64, i1 0)
  ret void
}

; /////////////////////////////////////////////////////////////////////////////

define void @aligned_bzero_2(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_2:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    sh zero, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_2:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    sh zero, 0(a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 2 %a, i8 0, i64 2, i1 0)
  ret void
}

define void @aligned_bzero_4(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_4:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    sw zero, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_4:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    sw zero, 0(a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 4 %a, i8 0, i64 4, i1 0)
  ret void
}

define void @aligned_bzero_8(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_8:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    sw zero, 4(a0)
; RV32-BOTH-NEXT:    sw zero, 0(a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_8:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    sd zero, 0(a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 8 %a, i8 0, i64 8, i1 0)
  ret void
}


define void @aligned_bzero_16(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_16:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-BOTH-NEXT:    vmv.v.i v8, 0
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_16:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-BOTH-NEXT:    vmv.v.i v8, 0
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 16 %a, i8 0, i64 16, i1 0)
  ret void
}

define void @aligned_bzero_32(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_32:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-BOTH-NEXT:    vmv.v.i v8, 0
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    addi a0, a0, 16
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_32:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-BOTH-NEXT:    vmv.v.i v8, 0
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    addi a0, a0, 16
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 32 %a, i8 0, i64 32, i1 0)
  ret void
}

define void @aligned_bzero_64(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_64:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-BOTH-NEXT:    vmv.v.i v8, 0
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_64:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-BOTH-NEXT:    vmv.v.i v8, 0
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 64 %a, i8 0, i64 64, i1 0)
  ret void
}

define void @aligned_bzero_66(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_66:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    sh zero, 64(a0)
; RV32-BOTH-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-BOTH-NEXT:    vmv.v.i v8, 0
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_66:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    sh zero, 64(a0)
; RV64-BOTH-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-BOTH-NEXT:    vmv.v.i v8, 0
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 64 %a, i8 0, i64 66, i1 0)
  ret void
}

define void @aligned_bzero_96(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_96:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV32-BOTH-NEXT:    vmv.v.i v8, 0
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    addi a1, a0, 80
; RV32-BOTH-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV32-BOTH-NEXT:    vmv.v.i v8, 0
; RV32-BOTH-NEXT:    vse64.v v8, (a1)
; RV32-BOTH-NEXT:    addi a0, a0, 64
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_96:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    vsetivli zero, 8, e64, m4, ta, ma
; RV64-BOTH-NEXT:    vmv.v.i v8, 0
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    addi a1, a0, 80
; RV64-BOTH-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; RV64-BOTH-NEXT:    vmv.v.i v8, 0
; RV64-BOTH-NEXT:    vse64.v v8, (a1)
; RV64-BOTH-NEXT:    addi a0, a0, 64
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 64 %a, i8 0, i64 96, i1 0)
  ret void
}

define void @aligned_bzero_128(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_128:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; RV32-BOTH-NEXT:    vmv.v.i v8, 0
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_128:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; RV64-BOTH-NEXT:    vmv.v.i v8, 0
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 64 %a, i8 0, i64 128, i1 0)
  ret void
}

define void @aligned_bzero_256(ptr %a) nounwind {
; RV32-BOTH-LABEL: aligned_bzero_256:
; RV32-BOTH:       # %bb.0:
; RV32-BOTH-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; RV32-BOTH-NEXT:    vmv.v.i v8, 0
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    addi a0, a0, 128
; RV32-BOTH-NEXT:    vse64.v v8, (a0)
; RV32-BOTH-NEXT:    ret
;
; RV64-BOTH-LABEL: aligned_bzero_256:
; RV64-BOTH:       # %bb.0:
; RV64-BOTH-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; RV64-BOTH-NEXT:    vmv.v.i v8, 0
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    addi a0, a0, 128
; RV64-BOTH-NEXT:    vse64.v v8, (a0)
; RV64-BOTH-NEXT:    ret
  tail call void @llvm.memset.inline.p0.i64(ptr align 64 %a, i8 0, i64 256, i1 0)
  ret void
}
