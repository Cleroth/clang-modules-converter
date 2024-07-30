; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+v -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+v -verify-machineinstrs < %s | FileCheck %s

; FIXME: We use exclusively byte types here because the MVT we use for the
; stores is calculated assuming byte elements. We need to deal with mismatched
; subvector "casts" to make other elements work.

define void @seteq_vv_v16i8(ptr %x, ptr %y) {
; CHECK-LABEL: seteq_vv_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v9, (a1)
; CHECK-NEXT:    vmseq.vv v0, v8, v9
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, ptr %x
  %b = load <16 x i8>, ptr %y
  %c = icmp eq <16 x i8> %a, %b
  %d = sext <16 x i1> %c to <16 x i8>
  store <16 x i8> %d, ptr %x
  ret void
}

define void @setne_vv_v32i8(ptr %x, ptr %y) {
; CHECK-LABEL: setne_vv_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 32
; CHECK-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v10, (a1)
; CHECK-NEXT:    vmsne.vv v0, v8, v10
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vse8.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, ptr %x
  %b = load <32 x i8>, ptr %y
  %c = icmp ne <32 x i8> %a, %b
  %d = zext <32 x i1> %c to <32 x i8>
  store <32 x i8> %d, ptr %x
  ret void
}

define void @setgt_vv_v64i8(ptr %x, ptr %y, ptr %z) {
; CHECK-LABEL: setgt_vv_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 64
; CHECK-NEXT:    vsetvli zero, a3, e8, m4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v12, (a1)
; CHECK-NEXT:    vmslt.vv v16, v12, v8
; CHECK-NEXT:    vsm.v v16, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, ptr %x
  %b = load <64 x i8>, ptr %y
  %c = icmp sgt <64 x i8> %a, %b
  store <64 x i1> %c, ptr %z
  ret void
}

define void @setlt_vv_v128i8(ptr %x, ptr %y, ptr %z) {
; CHECK-LABEL: setlt_vv_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 128
; CHECK-NEXT:    vsetvli zero, a3, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v16, (a1)
; CHECK-NEXT:    vmslt.vv v24, v8, v16
; CHECK-NEXT:    vsm.v v24, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, ptr %x
  %b = load <128 x i8>, ptr %y
  %c = icmp slt <128 x i8> %a, %b
  store <128 x i1> %c, ptr %z
  ret void
}

define void @setge_vv_v8i8(ptr %x, ptr %y, ptr %z) {
; CHECK-LABEL: setge_vv_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v9, (a1)
; CHECK-NEXT:    vmsle.vv v8, v9, v8
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, ptr %x
  %b = load <8 x i8>, ptr %y
  %c = icmp sge <8 x i8> %a, %b
  store <8 x i1> %c, ptr %z
  ret void
}

define void @setle_vv_v16i8(ptr %x, ptr %y, ptr %z) {
; CHECK-LABEL: setle_vv_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v9, (a1)
; CHECK-NEXT:    vmsle.vv v8, v8, v9
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, ptr %x
  %b = load <16 x i8>, ptr %y
  %c = icmp sle <16 x i8> %a, %b
  store <16 x i1> %c, ptr %z
  ret void
}

define void @setugt_vv_v32i8(ptr %x, ptr %y, ptr %z) {
; CHECK-LABEL: setugt_vv_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 32
; CHECK-NEXT:    vsetvli zero, a3, e8, m2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v10, (a1)
; CHECK-NEXT:    vmsltu.vv v12, v10, v8
; CHECK-NEXT:    vsm.v v12, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, ptr %x
  %b = load <32 x i8>, ptr %y
  %c = icmp ugt <32 x i8> %a, %b
  store <32 x i1> %c, ptr %z
  ret void
}

define void @setult_vv_v64i8(ptr %x, ptr %y, ptr %z) {
; CHECK-LABEL: setult_vv_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 64
; CHECK-NEXT:    vsetvli zero, a3, e8, m4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v12, (a1)
; CHECK-NEXT:    vmsltu.vv v16, v8, v12
; CHECK-NEXT:    vsm.v v16, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, ptr %x
  %b = load <64 x i8>, ptr %y
  %c = icmp ult <64 x i8> %a, %b
  store <64 x i1> %c, ptr %z
  ret void
}

define void @setuge_vv_v128i8(ptr %x, ptr %y, ptr %z) {
; CHECK-LABEL: setuge_vv_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 128
; CHECK-NEXT:    vsetvli zero, a3, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v16, (a1)
; CHECK-NEXT:    vmsleu.vv v24, v16, v8
; CHECK-NEXT:    vsm.v v24, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, ptr %x
  %b = load <128 x i8>, ptr %y
  %c = icmp uge <128 x i8> %a, %b
  store <128 x i1> %c, ptr %z
  ret void
}

define void @setule_vv_v8i8(ptr %x, ptr %y, ptr %z) {
; CHECK-LABEL: setule_vv_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v9, (a1)
; CHECK-NEXT:    vmsleu.vv v8, v8, v9
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, ptr %x
  %b = load <8 x i8>, ptr %y
  %c = icmp ule <8 x i8> %a, %b
  store <8 x i1> %c, ptr %z
  ret void
}

define void @seteq_vx_v16i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: seteq_vx_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmseq.vx v8, v8, a1
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, ptr %x
  %b = insertelement <16 x i8> poison, i8 %y, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> poison, <16 x i32> zeroinitializer
  %d = icmp eq <16 x i8> %a, %c
  store <16 x i1> %d, ptr %z
  ret void
}

define void @setne_vx_v32i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setne_vx_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 32
; CHECK-NEXT:    vsetvli zero, a3, e8, m2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsne.vx v10, v8, a1
; CHECK-NEXT:    vsm.v v10, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, ptr %x
  %b = insertelement <32 x i8> poison, i8 %y, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> poison, <32 x i32> zeroinitializer
  %d = icmp ne <32 x i8> %a, %c
  store <32 x i1> %d, ptr %z
  ret void
}

define void @setgt_vx_v64i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setgt_vx_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 64
; CHECK-NEXT:    vsetvli zero, a3, e8, m4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgt.vx v12, v8, a1
; CHECK-NEXT:    vsm.v v12, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, ptr %x
  %b = insertelement <64 x i8> poison, i8 %y, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> poison, <64 x i32> zeroinitializer
  %d = icmp sgt <64 x i8> %a, %c
  store <64 x i1> %d, ptr %z
  ret void
}

define void @setlt_vx_v128i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setlt_vx_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 128
; CHECK-NEXT:    vsetvli zero, a3, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmslt.vx v16, v8, a1
; CHECK-NEXT:    vsm.v v16, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, ptr %x
  %b = insertelement <128 x i8> poison, i8 %y, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> poison, <128 x i32> zeroinitializer
  %d = icmp slt <128 x i8> %a, %c
  store <128 x i1> %d, ptr %z
  ret void
}

define void @setge_vx_v8i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setge_vx_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmv.v.x v9, a1
; CHECK-NEXT:    vmsle.vv v8, v9, v8
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, ptr %x
  %b = insertelement <8 x i8> poison, i8 %y, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> poison, <8 x i32> zeroinitializer
  %d = icmp sge <8 x i8> %a, %c
  store <8 x i1> %d, ptr %z
  ret void
}

define void @setle_vx_v16i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setle_vx_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsle.vx v8, v8, a1
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, ptr %x
  %b = insertelement <16 x i8> poison, i8 %y, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> poison, <16 x i32> zeroinitializer
  %d = icmp sle <16 x i8> %a, %c
  store <16 x i1> %d, ptr %z
  ret void
}

define void @setugt_vx_v32i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setugt_vx_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 32
; CHECK-NEXT:    vsetvli zero, a3, e8, m2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgtu.vx v10, v8, a1
; CHECK-NEXT:    vsm.v v10, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, ptr %x
  %b = insertelement <32 x i8> poison, i8 %y, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> poison, <32 x i32> zeroinitializer
  %d = icmp ugt <32 x i8> %a, %c
  store <32 x i1> %d, ptr %z
  ret void
}

define void @setult_vx_v64i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setult_vx_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 64
; CHECK-NEXT:    vsetvli zero, a3, e8, m4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsltu.vx v12, v8, a1
; CHECK-NEXT:    vsm.v v12, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, ptr %x
  %b = insertelement <64 x i8> poison, i8 %y, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> poison, <64 x i32> zeroinitializer
  %d = icmp ult <64 x i8> %a, %c
  store <64 x i1> %d, ptr %z
  ret void
}

define void @setuge_vx_v128i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setuge_vx_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 128
; CHECK-NEXT:    vsetvli zero, a3, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmv.v.x v16, a1
; CHECK-NEXT:    vmsleu.vv v24, v16, v8
; CHECK-NEXT:    vsm.v v24, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, ptr %x
  %b = insertelement <128 x i8> poison, i8 %y, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> poison, <128 x i32> zeroinitializer
  %d = icmp uge <128 x i8> %a, %c
  store <128 x i1> %d, ptr %z
  ret void
}

define void @setule_vx_v8i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setule_vx_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsleu.vx v8, v8, a1
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, ptr %x
  %b = insertelement <8 x i8> poison, i8 %y, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> poison, <8 x i32> zeroinitializer
  %d = icmp ule <8 x i8> %a, %c
  store <8 x i1> %d, ptr %z
  ret void
}

define void @seteq_xv_v16i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: seteq_xv_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmseq.vx v8, v8, a1
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, ptr %x
  %b = insertelement <16 x i8> poison, i8 %y, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> poison, <16 x i32> zeroinitializer
  %d = icmp eq <16 x i8> %c, %a
  store <16 x i1> %d, ptr %z
  ret void
}

define void @setne_xv_v32i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setne_xv_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 32
; CHECK-NEXT:    vsetvli zero, a3, e8, m2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsne.vx v10, v8, a1
; CHECK-NEXT:    vsm.v v10, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, ptr %x
  %b = insertelement <32 x i8> poison, i8 %y, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> poison, <32 x i32> zeroinitializer
  %d = icmp ne <32 x i8> %c, %a
  store <32 x i1> %d, ptr %z
  ret void
}

define void @setgt_xv_v64i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setgt_xv_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 64
; CHECK-NEXT:    vsetvli zero, a3, e8, m4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmslt.vx v12, v8, a1
; CHECK-NEXT:    vsm.v v12, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, ptr %x
  %b = insertelement <64 x i8> poison, i8 %y, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> poison, <64 x i32> zeroinitializer
  %d = icmp sgt <64 x i8> %c, %a
  store <64 x i1> %d, ptr %z
  ret void
}

define void @setlt_xv_v128i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setlt_xv_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 128
; CHECK-NEXT:    vsetvli zero, a3, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgt.vx v16, v8, a1
; CHECK-NEXT:    vsm.v v16, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, ptr %x
  %b = insertelement <128 x i8> poison, i8 %y, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> poison, <128 x i32> zeroinitializer
  %d = icmp slt <128 x i8> %c, %a
  store <128 x i1> %d, ptr %z
  ret void
}

define void @setge_xv_v8i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setge_xv_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsle.vx v8, v8, a1
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, ptr %x
  %b = insertelement <8 x i8> poison, i8 %y, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> poison, <8 x i32> zeroinitializer
  %d = icmp sge <8 x i8> %c, %a
  store <8 x i1> %d, ptr %z
  ret void
}

define void @setle_xv_v16i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setle_xv_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmv.v.x v9, a1
; CHECK-NEXT:    vmsle.vv v8, v9, v8
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, ptr %x
  %b = insertelement <16 x i8> poison, i8 %y, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> poison, <16 x i32> zeroinitializer
  %d = icmp sle <16 x i8> %c, %a
  store <16 x i1> %d, ptr %z
  ret void
}

define void @setugt_xv_v32i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setugt_xv_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 32
; CHECK-NEXT:    vsetvli zero, a3, e8, m2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsltu.vx v10, v8, a1
; CHECK-NEXT:    vsm.v v10, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, ptr %x
  %b = insertelement <32 x i8> poison, i8 %y, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> poison, <32 x i32> zeroinitializer
  %d = icmp ugt <32 x i8> %c, %a
  store <32 x i1> %d, ptr %z
  ret void
}

define void @setult_xv_v64i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setult_xv_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 64
; CHECK-NEXT:    vsetvli zero, a3, e8, m4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgtu.vx v12, v8, a1
; CHECK-NEXT:    vsm.v v12, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, ptr %x
  %b = insertelement <64 x i8> poison, i8 %y, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> poison, <64 x i32> zeroinitializer
  %d = icmp ult <64 x i8> %c, %a
  store <64 x i1> %d, ptr %z
  ret void
}

define void @setuge_xv_v128i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setuge_xv_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a3, 128
; CHECK-NEXT:    vsetvli zero, a3, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsleu.vx v16, v8, a1
; CHECK-NEXT:    vsm.v v16, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, ptr %x
  %b = insertelement <128 x i8> poison, i8 %y, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> poison, <128 x i32> zeroinitializer
  %d = icmp uge <128 x i8> %c, %a
  store <128 x i1> %d, ptr %z
  ret void
}

define void @setule_xv_v8i8(ptr %x, i8 %y, ptr %z) {
; CHECK-LABEL: setule_xv_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmv.v.x v9, a1
; CHECK-NEXT:    vmsleu.vv v8, v9, v8
; CHECK-NEXT:    vsm.v v8, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, ptr %x
  %b = insertelement <8 x i8> poison, i8 %y, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> poison, <8 x i32> zeroinitializer
  %d = icmp ule <8 x i8> %c, %a
  store <8 x i1> %d, ptr %z
  ret void
}

define void @seteq_vi_v16i8(ptr %x, ptr %z) {
; CHECK-LABEL: seteq_vi_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmseq.vi v8, v8, 0
; CHECK-NEXT:    vsm.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, ptr %x
  %d = icmp eq <16 x i8> %a, splat (i8 0)
  store <16 x i1> %d, ptr %z
  ret void
}

define void @setne_vi_v32i8(ptr %x, ptr %z) {
; CHECK-LABEL: setne_vi_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 32
; CHECK-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsne.vi v10, v8, 0
; CHECK-NEXT:    vsm.v v10, (a1)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, ptr %x
  %d = icmp ne <32 x i8> %a, splat (i8 0)
  store <32 x i1> %d, ptr %z
  ret void
}

define void @setgt_vi_v64i8(ptr %x, ptr %z) {
; CHECK-LABEL: setgt_vi_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 64
; CHECK-NEXT:    vsetvli zero, a2, e8, m4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgt.vi v12, v8, 0
; CHECK-NEXT:    vsm.v v12, (a1)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, ptr %x
  %d = icmp sgt <64 x i8> %a, splat (i8 0)
  store <64 x i1> %d, ptr %z
  ret void
}

define void @setgt_vi_v64i8_nonzero(ptr %x, ptr %z) {
; CHECK-LABEL: setgt_vi_v64i8_nonzero:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 64
; CHECK-NEXT:    vsetvli zero, a2, e8, m4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgt.vi v12, v8, 5
; CHECK-NEXT:    vsm.v v12, (a1)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, ptr %x
  %d = icmp sgt <64 x i8> %a, splat (i8 5)
  store <64 x i1> %d, ptr %z
  ret void
}

define void @setlt_vi_v128i8(ptr %x, ptr %z) {
; CHECK-LABEL: setlt_vi_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 128
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsle.vi v16, v8, -1
; CHECK-NEXT:    vsm.v v16, (a1)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, ptr %x
  %d = icmp slt <128 x i8> %a, splat (i8 0)
  store <128 x i1> %d, ptr %z
  ret void
}

define void @setge_vi_v8i8(ptr %x, ptr %z) {
; CHECK-LABEL: setge_vi_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgt.vi v8, v8, -1
; CHECK-NEXT:    vsm.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, ptr %x
  %d = icmp sge <8 x i8> %a, splat (i8 0)
  store <8 x i1> %d, ptr %z
  ret void
}

define void @setle_vi_v16i8(ptr %x, ptr %z) {
; CHECK-LABEL: setle_vi_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e8, m1, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsle.vi v8, v8, 0
; CHECK-NEXT:    vsm.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, ptr %x
  %d = icmp sle <16 x i8> %a, splat (i8 0)
  store <16 x i1> %d, ptr %z
  ret void
}

define void @setugt_vi_v32i8(ptr %x, ptr %z) {
; CHECK-LABEL: setugt_vi_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 32
; CHECK-NEXT:    vsetvli zero, a2, e8, m2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgtu.vi v10, v8, 5
; CHECK-NEXT:    vsm.v v10, (a1)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, ptr %x
  %d = icmp ugt <32 x i8> %a, splat (i8 5)
  store <32 x i1> %d, ptr %z
  ret void
}

define void @setult_vi_v64i8(ptr %x, ptr %z) {
; CHECK-LABEL: setult_vi_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 64
; CHECK-NEXT:    vsetvli zero, a2, e8, m4, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsleu.vi v12, v8, 4
; CHECK-NEXT:    vsm.v v12, (a1)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, ptr %x
  %d = icmp ult <64 x i8> %a, splat (i8 5)
  store <64 x i1> %d, ptr %z
  ret void
}

define void @setuge_vi_v128i8(ptr %x, ptr %z) {
; CHECK-LABEL: setuge_vi_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a2, 128
; CHECK-NEXT:    vsetvli zero, a2, e8, m8, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgtu.vi v16, v8, 4
; CHECK-NEXT:    vsm.v v16, (a1)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, ptr %x
  %d = icmp uge <128 x i8> %a, splat (i8 5)
  store <128 x i1> %d, ptr %z
  ret void
}

define void @setule_vi_v8i8(ptr %x, ptr %z) {
; CHECK-LABEL: setule_vi_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e8, mf2, ta, ma
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsleu.vi v8, v8, 5
; CHECK-NEXT:    vsm.v v8, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, ptr %x
  %d = icmp ule <8 x i8> %a, splat (i8 5)
  store <8 x i1> %d, ptr %z
  ret void
}

define void @seteq_vv_v8i16(ptr %x, ptr %y) {
; CHECK-LABEL: seteq_vv_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e16, m1, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vle16.v v9, (a1)
; CHECK-NEXT:    vmseq.vv v0, v8, v9
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <8 x i16>, ptr %x
  %b = load <8 x i16>, ptr %y
  %c = icmp eq <8 x i16> %a, %b
  %d = sext <8 x i1> %c to <8 x i16>
  store <8 x i16> %d, ptr %x
  ret void
}

define void @setne_vv_v4i32(ptr %x, ptr %y) {
; CHECK-LABEL: setne_vv_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e32, m1, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vle32.v v9, (a1)
; CHECK-NEXT:    vmsne.vv v0, v8, v9
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <4 x i32>, ptr %x
  %b = load <4 x i32>, ptr %y
  %c = icmp ne <4 x i32> %a, %b
  %d = sext <4 x i1> %c to <4 x i32>
  store <4 x i32> %d, ptr %x
  ret void
}

define void @setgt_vv_v2i64(ptr %x, ptr %y) {
; CHECK-LABEL: setgt_vv_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 2, e64, m1, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vle64.v v9, (a1)
; CHECK-NEXT:    vmslt.vv v0, v9, v8
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, -1, v0
; CHECK-NEXT:    vse64.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <2 x i64>, ptr %x
  %b = load <2 x i64>, ptr %y
  %c = icmp sgt <2 x i64> %a, %b
  %d = sext <2 x i1> %c to <2 x i64>
  store <2 x i64> %d, ptr %x
  ret void
}

define void @setlt_vv_v16i16(ptr %x, ptr %y) {
; CHECK-LABEL: setlt_vv_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 16, e16, m2, ta, ma
; CHECK-NEXT:    vle16.v v8, (a0)
; CHECK-NEXT:    vle16.v v10, (a1)
; CHECK-NEXT:    vmslt.vv v0, v8, v10
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vse16.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <16 x i16>, ptr %x
  %b = load <16 x i16>, ptr %y
  %c = icmp slt <16 x i16> %a, %b
  %d = zext <16 x i1> %c to <16 x i16>
  store <16 x i16> %d, ptr %x
  ret void
}

define void @setugt_vv_v8i32(ptr %x, ptr %y) {
; CHECK-LABEL: setugt_vv_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 8, e32, m2, ta, ma
; CHECK-NEXT:    vle32.v v8, (a0)
; CHECK-NEXT:    vle32.v v10, (a1)
; CHECK-NEXT:    vmsltu.vv v0, v10, v8
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vse32.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <8 x i32>, ptr %x
  %b = load <8 x i32>, ptr %y
  %c = icmp ugt <8 x i32> %a, %b
  %d = zext <8 x i1> %c to <8 x i32>
  store <8 x i32> %d, ptr %x
  ret void
}

define void @setult_vv_v4i64(ptr %x, ptr %y) {
; CHECK-LABEL: setult_vv_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 4, e64, m2, ta, ma
; CHECK-NEXT:    vle64.v v8, (a0)
; CHECK-NEXT:    vle64.v v10, (a1)
; CHECK-NEXT:    vmsltu.vv v0, v8, v10
; CHECK-NEXT:    vmv.v.i v8, 0
; CHECK-NEXT:    vmerge.vim v8, v8, 1, v0
; CHECK-NEXT:    vse64.v v8, (a0)
; CHECK-NEXT:    ret
  %a = load <4 x i64>, ptr %x
  %b = load <4 x i64>, ptr %y
  %c = icmp ult <4 x i64> %a, %b
  %d = zext <4 x i1> %c to <4 x i64>
  store <4 x i64> %d, ptr %x
  ret void
}
