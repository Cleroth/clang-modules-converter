; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64 | FileCheck %s

define <8 x i16> @haddu_base(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: haddu_base:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %zextsrc2 = zext <8 x i16> %src2 to <8 x i32>
  %add = add <8 x i32> %zextsrc1, %zextsrc2
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @haddu_const(<8 x i16> %src1) {
; CHECK-LABEL: haddu_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %add = add <8 x i32> %zextsrc1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @haddu_const_lhs(<8 x i16> %src1) {
; CHECK-LABEL: haddu_const_lhs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %add = add <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>, %zextsrc1
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @haddu_const_zero(<8 x i16> %src1) {
; CHECK-LABEL: haddu_const_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v1.4s, v0.4h, #0
; CHECK-NEXT:    ushll2 v2.4s, v0.8h, #0
; CHECK-NEXT:    shrn v0.4h, v1.4s, #1
; CHECK-NEXT:    shrn2 v0.8h, v2.4s, #1
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %add = add <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, %zextsrc1
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @haddu_const_both() {
; CHECK-LABEL: haddu_const_both:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #2
; CHECK-NEXT:    ret
  %add = add <8 x i32> <i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3>, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @haddu_const_bothhigh() {
; CHECK-LABEL: haddu_const_bothhigh:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.8h, #1
; CHECK-NEXT:    ret
  %ext1 = zext <8 x i16> <i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534> to <8 x i32>
  %ext2 = zext <8 x i16> <i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535> to <8 x i32>
  %add = add <8 x i32> %ext1, %ext2
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @haddu_undef(<8 x i16> %src1) {
; CHECK-LABEL: haddu_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushll v1.4s, v0.4h, #0
; CHECK-NEXT:    ushll2 v2.4s, v0.8h, #0
; CHECK-NEXT:    shrn v0.4h, v1.4s, #1
; CHECK-NEXT:    shrn2 v0.8h, v2.4s, #1
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %zextsrc2 = zext <8 x i16> undef to <8 x i32>
  %add = add <8 x i32> %zextsrc2, %zextsrc1
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}



define <8 x i16> @haddu_i_base(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: haddu_i_base:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> %src1, <8 x i16> %src2)
  ret <8 x i16> %result
}

define <8 x i16> @haddu_i_const(<8 x i16> %src1) {
; CHECK-LABEL: haddu_i_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> %src1, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %result
}

define <8 x i16> @haddu_i_const_lhs(<8 x i16> %src1) {
; CHECK-LABEL: haddu_i_const_lhs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>, <8 x i16> %src1)
  ret <8 x i16> %result
}

define <8 x i16> @haddu_i_const_zero(<8 x i16> %src1) {
; CHECK-LABEL: haddu_i_const_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ushr v0.8h, v0.8h, #1
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> <i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0>, <8 x i16> %src1)
  ret <8 x i16> %result
}

define <8 x i16> @haddu_i_const_both() {
; CHECK-LABEL: haddu_i_const_both:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #2
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> <i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3>, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %result
}

define <8 x i16> @haddu_i_const_bothhigh() {
; CHECK-LABEL: haddu_i_const_bothhigh:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.8h, #1
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> <i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534>, <8 x i16> <i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535>)
  ret <8 x i16> %result
}

define <8 x i16> @haddu_i_undef(<8 x i16> %t, <8 x i16> %src1) {
; CHECK-LABEL: haddu_i_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> undef, <8 x i16> %src1)
  ret <8 x i16> %result
}





define <8 x i16> @hadds_base(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: hadds_base:
; CHECK:       // %bb.0:
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %zextsrc2 = sext <8 x i16> %src2 to <8 x i32>
  %add = add <8 x i32> %zextsrc1, %zextsrc2
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @hadds_const(<8 x i16> %src1) {
; CHECK-LABEL: hadds_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %add = add <8 x i32> %zextsrc1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @hadds_const_lhs(<8 x i16> %src1) {
; CHECK-LABEL: hadds_const_lhs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %add = add <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>, %zextsrc1
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @hadds_const_zero(<8 x i16> %src1) {
; CHECK-LABEL: hadds_const_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshll v1.4s, v0.4h, #0
; CHECK-NEXT:    sshll2 v2.4s, v0.8h, #0
; CHECK-NEXT:    shrn v0.4h, v1.4s, #1
; CHECK-NEXT:    shrn2 v0.8h, v2.4s, #1
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %add = add <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, %zextsrc1
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @hadds_const_both() {
; CHECK-LABEL: hadds_const_both:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #2
; CHECK-NEXT:    ret
  %add = add <8 x i32> <i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3>, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @hadds_const_bothhigh() {
; CHECK-LABEL: hadds_const_bothhigh:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32766 // =0x7ffe
; CHECK-NEXT:    dup v0.8h, w8
; CHECK-NEXT:    ret
  %ext1 = sext <8 x i16> <i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766> to <8 x i32>
  %ext2 = sext <8 x i16> <i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767> to <8 x i32>
  %add = add <8 x i32> %ext1, %ext2
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @hadds_undef(<8 x i16> %src1) {
; CHECK-LABEL: hadds_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshll v1.4s, v0.4h, #0
; CHECK-NEXT:    sshll2 v2.4s, v0.8h, #0
; CHECK-NEXT:    shrn v0.4h, v1.4s, #1
; CHECK-NEXT:    shrn2 v0.8h, v2.4s, #1
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %zextsrc2 = sext <8 x i16> undef to <8 x i32>
  %add = add <8 x i32> %zextsrc2, %zextsrc1
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}



define <8 x i16> @hadds_i_base(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: hadds_i_base:
; CHECK:       // %bb.0:
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> %src1, <8 x i16> %src2)
  ret <8 x i16> %result
}

define <8 x i16> @hadds_i_const(<8 x i16> %src1) {
; CHECK-LABEL: hadds_i_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> %src1, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %result
}

define <8 x i16> @hadds_i_const_lhs(<8 x i16> %src1) {
; CHECK-LABEL: hadds_i_const_lhs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>, <8 x i16> %src1)
  ret <8 x i16> %result
}

define <8 x i16> @hadds_i_const_zero(<8 x i16> %src1) {
; CHECK-LABEL: hadds_i_const_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshr v0.8h, v0.8h, #1
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> <i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0>, <8 x i16> %src1)
  ret <8 x i16> %result
}

define <8 x i16> @hadds_i_const_both() {
; CHECK-LABEL: hadds_i_const_both:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #2
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> <i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3>, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %result
}

define <8 x i16> @hadds_i_const_bothhigh() {
; CHECK-LABEL: hadds_i_const_bothhigh:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #32766 // =0x7ffe
; CHECK-NEXT:    dup v0.8h, w8
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> <i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766>, <8 x i16> <i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767>)
  ret <8 x i16> %result
}

define <8 x i16> @hadds_i_undef(<8 x i16> %t, <8 x i16> %src1) {
; CHECK-LABEL: hadds_i_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> undef, <8 x i16> %src1)
  ret <8 x i16> %result
}

define <8 x i16> @sub_fixedwidth_v4i32(<8 x i16> %a0, <8 x i16> %a1)  {
; CHECK-LABEL: sub_fixedwidth_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %or = or <8 x i16> %a0, %a1
  %xor = xor <8 x i16> %a0, %a1
  %srl = lshr <8 x i16> %xor, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = sub <8 x i16> %or, %srl
  ret <8 x i16> %res
}

define <8 x i16> @srhadd_fixedwidth_v8i16(<8 x i16> %a0, <8 x i16> %a1)  {
; CHECK-LABEL: srhadd_fixedwidth_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %or = or <8 x i16> %a0, %a1
  %xor = xor <8 x i16> %a0, %a1
  %srl = ashr <8 x i16> %xor, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = sub <8 x i16> %or, %srl
  ret <8 x i16> %res
}

define <8 x i16> @rhaddu_base(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: rhaddu_base:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %zextsrc2 = zext <8 x i16> %src2 to <8 x i32>
  %add1 = add <8 x i32> %zextsrc1, %zextsrc2
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_const(<8 x i16> %src1) {
; CHECK-LABEL: rhaddu_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %add1 = add <8 x i32> %zextsrc1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_const_lhs(<8 x i16> %src1) {
; CHECK-LABEL: rhaddu_const_lhs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %add1 = add <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>, %zextsrc1
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_const_zero(<8 x i16> %src1) {
; CHECK-LABEL: rhaddu_const_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %add1 = add <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, %zextsrc1
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_const_both() {
; CHECK-LABEL: rhaddu_const_both:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #2
; CHECK-NEXT:    ret
  %add1 = add <8 x i32> <i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3>, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_const_bothhigh() {
; CHECK-LABEL: rhaddu_const_bothhigh:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xffffffffffffffff
; CHECK-NEXT:    ret
  %ext1 = zext <8 x i16> <i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534> to <8 x i32>
  %ext2 = zext <8 x i16> <i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535> to <8 x i32>
  %add1 = add <8 x i32> %ext1, %ext2
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_undef(<8 x i16> %src1) {
; CHECK-LABEL: rhaddu_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = zext <8 x i16> %src1 to <8 x i32>
  %zextsrc2 = zext <8 x i16> undef to <8 x i32>
  %add1 = add <8 x i32> %zextsrc2, %zextsrc1
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = lshr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}



define <8 x i16> @rhaddu_i_base(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: rhaddu_i_base:
; CHECK:       // %bb.0:
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> %src1, <8 x i16> %src2)
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_i_const(<8 x i16> %src1) {
; CHECK-LABEL: rhaddu_i_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> %src1, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_i_const_lhs(<8 x i16> %src1) {
; CHECK-LABEL: rhaddu_i_const_lhs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>, <8 x i16> %src1)
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_i_const_zero(<8 x i16> %src1) {
; CHECK-LABEL: rhaddu_i_const_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.2d, #0000000000000000
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> <i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0>, <8 x i16> %src1)
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_i_const_both() {
; CHECK-LABEL: rhaddu_i_const_both:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #2
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> <i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3>, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_i_const_bothhigh() {
; CHECK-LABEL: rhaddu_i_const_bothhigh:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.2d, #0xffffffffffffffff
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> <i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534, i16 65534>, <8 x i16> <i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535, i16 65535>)
  ret <8 x i16> %result
}

define <8 x i16> @rhaddu_i_undef(<8 x i16> %t, <8 x i16> %src1) {
; CHECK-LABEL: rhaddu_i_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> undef, <8 x i16> %src1)
  ret <8 x i16> %result
}





define <8 x i16> @rhadds_base(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: rhadds_base:
; CHECK:       // %bb.0:
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %zextsrc2 = sext <8 x i16> %src2 to <8 x i32>
  %add1 = add <8 x i32> %zextsrc1, %zextsrc2
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_const(<8 x i16> %src1) {
; CHECK-LABEL: rhadds_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %add1 = add <8 x i32> %zextsrc1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_const_lhs(<8 x i16> %src1) {
; CHECK-LABEL: rhadds_const_lhs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %add1 = add <8 x i32> <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>, %zextsrc1
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_const_zero(<8 x i16> %src1) {
; CHECK-LABEL: rhadds_const_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %add1 = add <8 x i32> <i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0>, %zextsrc1
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_const_both() {
; CHECK-LABEL: rhadds_const_both:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #2
; CHECK-NEXT:    ret
  %add1 = add <8 x i32> <i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3, i32 3>, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_const_bothhigh() {
; CHECK-LABEL: rhadds_const_bothhigh:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.8h, #128, lsl #8
; CHECK-NEXT:    ret
  %ext1 = sext <8 x i16> <i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766> to <8 x i32>
  %ext2 = sext <8 x i16> <i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767> to <8 x i32>
  %add1 = add <8 x i32> %ext1, %ext2
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_undef(<8 x i16> %src1) {
; CHECK-LABEL: rhadds_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %zextsrc1 = sext <8 x i16> %src1 to <8 x i32>
  %zextsrc2 = sext <8 x i16> undef to <8 x i32>
  %add1 = add <8 x i32> %zextsrc2, %zextsrc1
  %add = add <8 x i32> %add1, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %resulti16 = ashr <8 x i32> %add, <i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1, i32 1>
  %result = trunc <8 x i32> %resulti16 to <8 x i16>
  ret <8 x i16> %result
}



define <8 x i16> @rhadds_i_base(<8 x i16> %src1, <8 x i16> %src2) {
; CHECK-LABEL: rhadds_i_base:
; CHECK:       // %bb.0:
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> %src1, <8 x i16> %src2)
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_i_const(<8 x i16> %src1) {
; CHECK-LABEL: rhadds_i_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> %src1, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_i_const_lhs(<8 x i16> %src1) {
; CHECK-LABEL: rhadds_i_const_lhs:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.8h, #1
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>, <8 x i16> %src1)
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_i_const_zero(<8 x i16> %src1) {
; CHECK-LABEL: rhadds_i_const_zero:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v1.2d, #0000000000000000
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> <i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0>, <8 x i16> %src1)
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_i_const_both() {
; CHECK-LABEL: rhadds_i_const_both:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.8h, #2
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> <i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3, i16 3>, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_i_const_bothhigh() {
; CHECK-LABEL: rhadds_i_const_bothhigh:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mvni v0.8h, #128, lsl #8
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> <i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766, i16 32766>, <8 x i16> <i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767, i16 32767>)
  ret <8 x i16> %result
}

define <8 x i16> @rhadds_i_undef(<8 x i16> %t, <8 x i16> %src1) {
; CHECK-LABEL: rhadds_i_undef:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    ret
  %result = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> undef, <8 x i16> %src1)
  ret <8 x i16> %result
}


define <8 x i8> @shadd_v8i8(<8 x i8> %x) {
; CHECK-LABEL: shadd_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <8 x i8> @llvm.aarch64.neon.shadd.v8i8(<8 x i8> %x, <8 x i8> %x)
  ret <8 x i8> %r
}

define <4 x i16> @shadd_v4i16(<4 x i16> %x) {
; CHECK-LABEL: shadd_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <4 x i16> @llvm.aarch64.neon.shadd.v4i16(<4 x i16> %x, <4 x i16> %x)
  ret <4 x i16> %r
}

define <2 x i32> @shadd_v2i32(<2 x i32> %x) {
; CHECK-LABEL: shadd_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <2 x i32> @llvm.aarch64.neon.shadd.v2i32(<2 x i32> %x, <2 x i32> %x)
  ret <2 x i32> %r
}

define <16 x i8> @shadd_v16i8(<16 x i8> %x) {
; CHECK-LABEL: shadd_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <16 x i8> @llvm.aarch64.neon.shadd.v16i8(<16 x i8> %x, <16 x i8> %x)
  ret <16 x i8> %r
}

define <8 x i16> @shadd_v8i16(<8 x i16> %x) {
; CHECK-LABEL: shadd_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> %x, <8 x i16> %x)
  ret <8 x i16> %r
}

define <4 x i32> @shadd_v4i32(<4 x i32> %x) {
; CHECK-LABEL: shadd_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <4 x i32> @llvm.aarch64.neon.shadd.v4i32(<4 x i32> %x, <4 x i32> %x)
  ret <4 x i32> %r
}

define <8 x i8> @uhadd_v8i8(<8 x i8> %x) {
; CHECK-LABEL: uhadd_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <8 x i8> @llvm.aarch64.neon.uhadd.v8i8(<8 x i8> %x, <8 x i8> %x)
  ret <8 x i8> %r
}

define <4 x i16> @uhadd_v4i16(<4 x i16> %x) {
; CHECK-LABEL: uhadd_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <4 x i16> @llvm.aarch64.neon.uhadd.v4i16(<4 x i16> %x, <4 x i16> %x)
  ret <4 x i16> %r
}

define <2 x i32> @uhadd_v2i32(<2 x i32> %x) {
; CHECK-LABEL: uhadd_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <2 x i32> @llvm.aarch64.neon.uhadd.v2i32(<2 x i32> %x, <2 x i32> %x)
  ret <2 x i32> %r
}

define <16 x i8> @uhadd_v16i8(<16 x i8> %x) {
; CHECK-LABEL: uhadd_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <16 x i8> @llvm.aarch64.neon.uhadd.v16i8(<16 x i8> %x, <16 x i8> %x)
  ret <16 x i8> %r
}

define <8 x i16> @uhadd_v8i16(<8 x i16> %x) {
; CHECK-LABEL: uhadd_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> %x, <8 x i16> %x)
  ret <8 x i16> %r
}

define <4 x i32> @uhadd_v4i32(<4 x i32> %x) {
; CHECK-LABEL: uhadd_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <4 x i32> @llvm.aarch64.neon.uhadd.v4i32(<4 x i32> %x, <4 x i32> %x)
  ret <4 x i32> %r
}
define <8 x i8> @srhadd_v8i8(<8 x i8> %x) {
; CHECK-LABEL: srhadd_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <8 x i8> @llvm.aarch64.neon.srhadd.v8i8(<8 x i8> %x, <8 x i8> %x)
  ret <8 x i8> %r
}

define <4 x i16> @srhadd_v4i16(<4 x i16> %x) {
; CHECK-LABEL: srhadd_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <4 x i16> @llvm.aarch64.neon.srhadd.v4i16(<4 x i16> %x, <4 x i16> %x)
  ret <4 x i16> %r
}

define <2 x i32> @srhadd_v2i32(<2 x i32> %x) {
; CHECK-LABEL: srhadd_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <2 x i32> @llvm.aarch64.neon.srhadd.v2i32(<2 x i32> %x, <2 x i32> %x)
  ret <2 x i32> %r
}

define <16 x i8> @srhadd_v16i8(<16 x i8> %x) {
; CHECK-LABEL: srhadd_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <16 x i8> @llvm.aarch64.neon.srhadd.v16i8(<16 x i8> %x, <16 x i8> %x)
  ret <16 x i8> %r
}

define <8 x i16> @srhadd_v8i16(<8 x i16> %x) {
; CHECK-LABEL: srhadd_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> %x, <8 x i16> %x)
  ret <8 x i16> %r
}

define <4 x i32> @srhadd_v4i32(<4 x i32> %x) {
; CHECK-LABEL: srhadd_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <4 x i32> @llvm.aarch64.neon.srhadd.v4i32(<4 x i32> %x, <4 x i32> %x)
  ret <4 x i32> %r
}

define <8 x i8> @urhadd_v8i8(<8 x i8> %x) {
; CHECK-LABEL: urhadd_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <8 x i8> @llvm.aarch64.neon.urhadd.v8i8(<8 x i8> %x, <8 x i8> %x)
  ret <8 x i8> %r
}

define <4 x i16> @urhadd_v4i16(<4 x i16> %x) {
; CHECK-LABEL: urhadd_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <4 x i16> @llvm.aarch64.neon.urhadd.v4i16(<4 x i16> %x, <4 x i16> %x)
  ret <4 x i16> %r
}

define <2 x i32> @urhadd_v2i32(<2 x i32> %x) {
; CHECK-LABEL: urhadd_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <2 x i32> @llvm.aarch64.neon.urhadd.v2i32(<2 x i32> %x, <2 x i32> %x)
  ret <2 x i32> %r
}

define <16 x i8> @urhadd_v16i8(<16 x i8> %x) {
; CHECK-LABEL: urhadd_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <16 x i8> @llvm.aarch64.neon.urhadd.v16i8(<16 x i8> %x, <16 x i8> %x)
  ret <16 x i8> %r
}

define <8 x i16> @urhadd_v8i16(<8 x i16> %x) {
; CHECK-LABEL: urhadd_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> %x, <8 x i16> %x)
  ret <8 x i16> %r
}

define <4 x i32> @urhadd_v4i32(<4 x i32> %x) {
; CHECK-LABEL: urhadd_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %r = tail call <4 x i32> @llvm.aarch64.neon.urhadd.v4i32(<4 x i32> %x, <4 x i32> %x)
  ret <4 x i32> %r
}

define <8 x i16> @uhadd_fixedwidth_v4i32(<8 x i16> %a0, <8 x i16> %a1)  {
; CHECK-LABEL: uhadd_fixedwidth_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %and = and <8 x i16> %a0, %a1
  %xor = xor <8 x i16> %a0, %a1
  %srl = lshr <8 x i16> %xor, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = add <8 x i16> %and, %srl
  ret <8 x i16> %res
}

define <8 x i16> @shadd_fixedwidth_v8i16(<8 x i16> %a0, <8 x i16> %a1)  {
; CHECK-LABEL: shadd_fixedwidth_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    ret
  %and = and <8 x i16> %a0, %a1
  %xor = xor <8 x i16> %a0, %a1
  %srl = ashr <8 x i16> %xor, <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>
  %res = add <8 x i16> %and, %srl
  ret <8 x i16> %res
}

define <8 x i16> @shadd_demandedelts(<8 x i16> %a0, <8 x i16> %a1) {
; CHECK-LABEL: shadd_demandedelts:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.8h, v0.h[0]
; CHECK-NEXT:    shadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    dup v0.8h, v0.h[0]
; CHECK-NEXT:    ret
  %s0 = shufflevector <8 x i16> %a0, <8 x i16> undef, <8 x i32> zeroinitializer
  %op = call <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16> %s0, <8 x i16> %a1)
  %r0 = shufflevector <8 x i16> %op, <8 x i16> undef, <8 x i32> zeroinitializer
  ret <8 x i16> %r0
}

define <8 x i16> @srhadd_demandedelts(<8 x i16> %a0, <8 x i16> %a1) {
; CHECK-LABEL: srhadd_demandedelts:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.8h, v0.h[0]
; CHECK-NEXT:    srhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    dup v0.8h, v0.h[0]
; CHECK-NEXT:    ret
  %s0 = shufflevector <8 x i16> %a0, <8 x i16> undef, <8 x i32> zeroinitializer
  %op = call <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16> %s0, <8 x i16> %a1)
  %r0 = shufflevector <8 x i16> %op, <8 x i16> undef, <8 x i32> zeroinitializer
  ret <8 x i16> %r0
}

define <8 x i16> @uhadd_demandedelts(<8 x i16> %a0, <8 x i16> %a1) {
; CHECK-LABEL: uhadd_demandedelts:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.8h, v0.h[0]
; CHECK-NEXT:    uhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    dup v0.8h, v0.h[0]
; CHECK-NEXT:    ret
  %s0 = shufflevector <8 x i16> %a0, <8 x i16> undef, <8 x i32> zeroinitializer
  %op = call <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16> %s0, <8 x i16> %a1)
  %r0 = shufflevector <8 x i16> %op, <8 x i16> undef, <8 x i32> zeroinitializer
  ret <8 x i16> %r0
}

define <8 x i16> @urhadd_demandedelts(<8 x i16> %a0, <8 x i16> %a1) {
; CHECK-LABEL: urhadd_demandedelts:
; CHECK:       // %bb.0:
; CHECK-NEXT:    dup v0.8h, v0.h[0]
; CHECK-NEXT:    urhadd v0.8h, v0.8h, v1.8h
; CHECK-NEXT:    dup v0.8h, v0.h[0]
; CHECK-NEXT:    ret
  %s0 = shufflevector <8 x i16> %a0, <8 x i16> undef, <8 x i32> zeroinitializer
  %op = call <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16> %s0, <8 x i16> %a1)
  %r0 = shufflevector <8 x i16> %op, <8 x i16> undef, <8 x i32> zeroinitializer
  ret <8 x i16> %r0
}

; Remove unnecessary sign_extend_inreg after shadd
define <2 x i32> @shadd_signbits_v2i32(<2 x i32> %a0, <2 x i32> %a1, ptr %p2) {
; CHECK-LABEL: shadd_signbits_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshr v0.2s, v0.2s, #17
; CHECK-NEXT:    sshr v1.2s, v1.2s, #17
; CHECK-NEXT:    shadd v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %x0 = ashr <2 x i32> %a0, <i32 17, i32 17>
  %x1 = ashr <2 x i32> %a1, <i32 17, i32 17>
  %m = and <2 x i32> %x0, %x1
  %s = xor <2 x i32> %x0, %x1
  %x = ashr <2 x i32> %s, <i32 1, i32 1>
  %avg = add <2 x i32> %m, %x
  %avg1 = shl <2 x i32> %avg, <i32 17, i32 17>
  %avg2 = ashr <2 x i32> %avg1, <i32 17, i32 17>
  store <2 x i32> %avg, ptr %p2 ; extra use
  ret <2 x i32> %avg2
}

; Remove unnecessary sign_extend_inreg after srhadd
define <2 x i32> @srhadd_signbits_v2i32(<2 x i32> %a0, <2 x i32> %a1, ptr %p2) {
; CHECK-LABEL: srhadd_signbits_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshr v0.2s, v0.2s, #17
; CHECK-NEXT:    sshr v1.2s, v1.2s, #17
; CHECK-NEXT:    srhadd v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    str d0, [x0]
; CHECK-NEXT:    ret
  %x0 = ashr <2 x i32> %a0, <i32 17, i32 17>
  %x1 = ashr <2 x i32> %a1, <i32 17, i32 17>
  %m = or <2 x i32> %x0, %x1
  %s = xor <2 x i32> %x0, %x1
  %x = ashr <2 x i32> %s, <i32 1, i32 1>
  %avg = sub <2 x i32> %m, %x
  %avg1 = shl <2 x i32> %avg, <i32 17, i32 17>
  %avg2 = ashr <2 x i32> %avg1, <i32 17, i32 17>
  store <2 x i32> %avg, ptr %p2 ; extra use
  ret <2 x i32> %avg2
}

; negative test - not enough signbits to remove sign_extend_inreg after srhadd
define <2 x i32> @srhadd_signbits_v2i32_negative(<2 x i32> %a0, <2 x i32> %a1, ptr %p2) {
; CHECK-LABEL: srhadd_signbits_v2i32_negative:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sshr v0.2s, v0.2s, #17
; CHECK-NEXT:    sshr v1.2s, v1.2s, #17
; CHECK-NEXT:    srhadd v1.2s, v0.2s, v1.2s
; CHECK-NEXT:    shl v0.2s, v1.2s, #22
; CHECK-NEXT:    str d1, [x0]
; CHECK-NEXT:    sshr v0.2s, v0.2s, #22
; CHECK-NEXT:    ret
  %x0 = ashr <2 x i32> %a0, <i32 17, i32 17>
  %x1 = ashr <2 x i32> %a1, <i32 17, i32 17>
  %m = or <2 x i32> %x0, %x1
  %s = xor <2 x i32> %x0, %x1
  %x = ashr <2 x i32> %s, <i32 1, i32 1>
  %avg = sub <2 x i32> %m, %x
  %avg1 = shl <2 x i32> %avg, <i32 22, i32 22>
  %avg2 = ashr <2 x i32> %avg1, <i32 22, i32 22>
  store <2 x i32> %avg, ptr %p2 ; extra use
  ret <2 x i32> %avg2
}

declare <8 x i8> @llvm.aarch64.neon.shadd.v8i8(<8 x i8>, <8 x i8>)
declare <4 x i16> @llvm.aarch64.neon.shadd.v4i16(<4 x i16>, <4 x i16>)
declare <2 x i32> @llvm.aarch64.neon.shadd.v2i32(<2 x i32>, <2 x i32>)
declare <8 x i8> @llvm.aarch64.neon.uhadd.v8i8(<8 x i8>, <8 x i8>)
declare <4 x i16> @llvm.aarch64.neon.uhadd.v4i16(<4 x i16>, <4 x i16>)
declare <2 x i32> @llvm.aarch64.neon.uhadd.v2i32(<2 x i32>, <2 x i32>)
declare <16 x i8> @llvm.aarch64.neon.shadd.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i16> @llvm.aarch64.neon.shadd.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.aarch64.neon.shadd.v4i32(<4 x i32>, <4 x i32>)
declare <16 x i8> @llvm.aarch64.neon.uhadd.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i16> @llvm.aarch64.neon.uhadd.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.aarch64.neon.uhadd.v4i32(<4 x i32>, <4 x i32>)

declare <8 x i8> @llvm.aarch64.neon.srhadd.v8i8(<8 x i8>, <8 x i8>)
declare <4 x i16> @llvm.aarch64.neon.srhadd.v4i16(<4 x i16>, <4 x i16>)
declare <2 x i32> @llvm.aarch64.neon.srhadd.v2i32(<2 x i32>, <2 x i32>)
declare <8 x i8> @llvm.aarch64.neon.urhadd.v8i8(<8 x i8>, <8 x i8>)
declare <4 x i16> @llvm.aarch64.neon.urhadd.v4i16(<4 x i16>, <4 x i16>)
declare <2 x i32> @llvm.aarch64.neon.urhadd.v2i32(<2 x i32>, <2 x i32>)
declare <16 x i8> @llvm.aarch64.neon.srhadd.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i16> @llvm.aarch64.neon.srhadd.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.aarch64.neon.srhadd.v4i32(<4 x i32>, <4 x i32>)
declare <16 x i8> @llvm.aarch64.neon.urhadd.v16i8(<16 x i8>, <16 x i8>)
declare <8 x i16> @llvm.aarch64.neon.urhadd.v8i16(<8 x i16>, <8 x i16>)
declare <4 x i32> @llvm.aarch64.neon.urhadd.v4i32(<4 x i32>, <4 x i32>)
