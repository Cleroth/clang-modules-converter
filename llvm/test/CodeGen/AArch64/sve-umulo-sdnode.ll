; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve -verify-machineinstrs < %s | FileCheck %s

declare { <vscale x 2 x i8>, <vscale x 2 x i1> } @llvm.umul.with.overflow.nxv2i8(<vscale x 2 x i8>, <vscale x 2 x i8>)

define <vscale x 2 x i8> @umulo_nxv2i8(<vscale x 2 x i8> %x, <vscale x 2 x i8> %y) {
; CHECK-LABEL: umulo_nxv2i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z1.d, z1.d, #0xff
; CHECK-NEXT:    and z0.d, z0.d, #0xff
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    lsr z1.d, z0.d, #8
; CHECK-NEXT:    cmpne p0.d, p0/z, z1.d, #0
; CHECK-NEXT:    mov z0.d, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 2 x i8>, <vscale x 2 x i1> } @llvm.umul.with.overflow.nxv2i8(<vscale x 2 x i8> %x, <vscale x 2 x i8> %y)
  %b = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i1> } %a, 0
  %c = extractvalue { <vscale x 2 x i8>, <vscale x 2 x i1> } %a, 1
  %d = select <vscale x 2 x i1> %c, <vscale x 2 x i8> zeroinitializer, <vscale x 2 x i8> %b
  ret <vscale x 2 x i8> %d
}

declare { <vscale x 4 x i8>, <vscale x 4 x i1> } @llvm.umul.with.overflow.nxv4i8(<vscale x 4 x i8>, <vscale x 4 x i8>)

define <vscale x 4 x i8> @umulo_nxv4i8(<vscale x 4 x i8> %x, <vscale x 4 x i8> %y) {
; CHECK-LABEL: umulo_nxv4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z1.s, z1.s, #0xff
; CHECK-NEXT:    and z0.s, z0.s, #0xff
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mul z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    lsr z1.s, z0.s, #8
; CHECK-NEXT:    cmpne p0.s, p0/z, z1.s, #0
; CHECK-NEXT:    mov z0.s, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 4 x i8>, <vscale x 4 x i1> } @llvm.umul.with.overflow.nxv4i8(<vscale x 4 x i8> %x, <vscale x 4 x i8> %y)
  %b = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i1> } %a, 0
  %c = extractvalue { <vscale x 4 x i8>, <vscale x 4 x i1> } %a, 1
  %d = select <vscale x 4 x i1> %c, <vscale x 4 x i8> zeroinitializer, <vscale x 4 x i8> %b
  ret <vscale x 4 x i8> %d
}

declare { <vscale x 8 x i8>, <vscale x 8 x i1> } @llvm.umul.with.overflow.nxv8i8(<vscale x 8 x i8>, <vscale x 8 x i8>)

define <vscale x 8 x i8> @umulo_nxv8i8(<vscale x 8 x i8> %x, <vscale x 8 x i8> %y) {
; CHECK-LABEL: umulo_nxv8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z1.h, z1.h, #0xff
; CHECK-NEXT:    and z0.h, z0.h, #0xff
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mul z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    lsr z1.h, z0.h, #8
; CHECK-NEXT:    cmpne p0.h, p0/z, z1.h, #0
; CHECK-NEXT:    mov z0.h, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 8 x i8>, <vscale x 8 x i1> } @llvm.umul.with.overflow.nxv8i8(<vscale x 8 x i8> %x, <vscale x 8 x i8> %y)
  %b = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i1> } %a, 0
  %c = extractvalue { <vscale x 8 x i8>, <vscale x 8 x i1> } %a, 1
  %d = select <vscale x 8 x i1> %c, <vscale x 8 x i8> zeroinitializer, <vscale x 8 x i8> %b
  ret <vscale x 8 x i8> %d
}

declare { <vscale x 16 x i8>, <vscale x 16 x i1> } @llvm.umul.with.overflow.nxv16i8(<vscale x 16 x i8>, <vscale x 16 x i8>)

define <vscale x 16 x i8> @umulo_nxv16i8(<vscale x 16 x i8> %x, <vscale x 16 x i8> %y) {
; CHECK-LABEL: umulo_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    umulh z2.b, p0/m, z2.b, z1.b
; CHECK-NEXT:    mul z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT:    cmpne p0.b, p0/z, z2.b, #0
; CHECK-NEXT:    mov z0.b, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 16 x i8>, <vscale x 16 x i1> } @llvm.umul.with.overflow.nxv16i8(<vscale x 16 x i8> %x, <vscale x 16 x i8> %y)
  %b = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i1> } %a, 0
  %c = extractvalue { <vscale x 16 x i8>, <vscale x 16 x i1> } %a, 1
  %d = select <vscale x 16 x i1> %c, <vscale x 16 x i8> zeroinitializer, <vscale x 16 x i8> %b
  ret <vscale x 16 x i8> %d
}

declare { <vscale x 32 x i8>, <vscale x 32 x i1> } @llvm.umul.with.overflow.nxv32i8(<vscale x 32 x i8>, <vscale x 32 x i8>)

define <vscale x 32 x i8> @umulo_nxv32i8(<vscale x 32 x i8> %x, <vscale x 32 x i8> %y) {
; CHECK-LABEL: umulo_nxv32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    movprfx z4, z1
; CHECK-NEXT:    umulh z4.b, p0/m, z4.b, z3.b
; CHECK-NEXT:    movprfx z5, z0
; CHECK-NEXT:    umulh z5.b, p0/m, z5.b, z2.b
; CHECK-NEXT:    mul z1.b, p0/m, z1.b, z3.b
; CHECK-NEXT:    mul z0.b, p0/m, z0.b, z2.b
; CHECK-NEXT:    cmpne p1.b, p0/z, z4.b, #0
; CHECK-NEXT:    cmpne p0.b, p0/z, z5.b, #0
; CHECK-NEXT:    mov z0.b, p0/m, #0 // =0x0
; CHECK-NEXT:    mov z1.b, p1/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 32 x i8>, <vscale x 32 x i1> } @llvm.umul.with.overflow.nxv32i8(<vscale x 32 x i8> %x, <vscale x 32 x i8> %y)
  %b = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i1> } %a, 0
  %c = extractvalue { <vscale x 32 x i8>, <vscale x 32 x i1> } %a, 1
  %d = select <vscale x 32 x i1> %c, <vscale x 32 x i8> zeroinitializer, <vscale x 32 x i8> %b
  ret <vscale x 32 x i8> %d
}

declare { <vscale x 64 x i8>, <vscale x 64 x i1> } @llvm.umul.with.overflow.nxv64i8(<vscale x 64 x i8>, <vscale x 64 x i8>)

define <vscale x 64 x i8> @umulo_nxv64i8(<vscale x 64 x i8> %x, <vscale x 64 x i8> %y) {
; CHECK-LABEL: umulo_nxv64i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    movprfx z24, z3
; CHECK-NEXT:    umulh z24.b, p0/m, z24.b, z7.b
; CHECK-NEXT:    movprfx z25, z0
; CHECK-NEXT:    umulh z25.b, p0/m, z25.b, z4.b
; CHECK-NEXT:    movprfx z26, z2
; CHECK-NEXT:    umulh z26.b, p0/m, z26.b, z6.b
; CHECK-NEXT:    movprfx z27, z1
; CHECK-NEXT:    umulh z27.b, p0/m, z27.b, z5.b
; CHECK-NEXT:    mul z3.b, p0/m, z3.b, z7.b
; CHECK-NEXT:    mul z2.b, p0/m, z2.b, z6.b
; CHECK-NEXT:    mul z1.b, p0/m, z1.b, z5.b
; CHECK-NEXT:    mul z0.b, p0/m, z0.b, z4.b
; CHECK-NEXT:    cmpne p1.b, p0/z, z25.b, #0
; CHECK-NEXT:    cmpne p2.b, p0/z, z24.b, #0
; CHECK-NEXT:    cmpne p3.b, p0/z, z26.b, #0
; CHECK-NEXT:    cmpne p0.b, p0/z, z27.b, #0
; CHECK-NEXT:    mov z0.b, p1/m, #0 // =0x0
; CHECK-NEXT:    mov z2.b, p3/m, #0 // =0x0
; CHECK-NEXT:    mov z3.b, p2/m, #0 // =0x0
; CHECK-NEXT:    mov z1.b, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 64 x i8>, <vscale x 64 x i1> } @llvm.umul.with.overflow.nxv64i8(<vscale x 64 x i8> %x, <vscale x 64 x i8> %y)
  %b = extractvalue { <vscale x 64 x i8>, <vscale x 64 x i1> } %a, 0
  %c = extractvalue { <vscale x 64 x i8>, <vscale x 64 x i1> } %a, 1
  %d = select <vscale x 64 x i1> %c, <vscale x 64 x i8> zeroinitializer, <vscale x 64 x i8> %b
  ret <vscale x 64 x i8> %d
}

declare { <vscale x 2 x i16>, <vscale x 2 x i1> } @llvm.umul.with.overflow.nxv2i16(<vscale x 2 x i16>, <vscale x 2 x i16>)

define <vscale x 2 x i16> @umulo_nxv2i16(<vscale x 2 x i16> %x, <vscale x 2 x i16> %y) {
; CHECK-LABEL: umulo_nxv2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z1.d, z1.d, #0xffff
; CHECK-NEXT:    and z0.d, z0.d, #0xffff
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    lsr z1.d, z0.d, #16
; CHECK-NEXT:    cmpne p0.d, p0/z, z1.d, #0
; CHECK-NEXT:    mov z0.d, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 2 x i16>, <vscale x 2 x i1> } @llvm.umul.with.overflow.nxv2i16(<vscale x 2 x i16> %x, <vscale x 2 x i16> %y)
  %b = extractvalue { <vscale x 2 x i16>, <vscale x 2 x i1> } %a, 0
  %c = extractvalue { <vscale x 2 x i16>, <vscale x 2 x i1> } %a, 1
  %d = select <vscale x 2 x i1> %c, <vscale x 2 x i16> zeroinitializer, <vscale x 2 x i16> %b
  ret <vscale x 2 x i16> %d
}

declare { <vscale x 4 x i16>, <vscale x 4 x i1> } @llvm.umul.with.overflow.nxv4i16(<vscale x 4 x i16>, <vscale x 4 x i16>)

define <vscale x 4 x i16> @umulo_nxv4i16(<vscale x 4 x i16> %x, <vscale x 4 x i16> %y) {
; CHECK-LABEL: umulo_nxv4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z1.s, z1.s, #0xffff
; CHECK-NEXT:    and z0.s, z0.s, #0xffff
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mul z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    lsr z1.s, z0.s, #16
; CHECK-NEXT:    cmpne p0.s, p0/z, z1.s, #0
; CHECK-NEXT:    mov z0.s, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 4 x i16>, <vscale x 4 x i1> } @llvm.umul.with.overflow.nxv4i16(<vscale x 4 x i16> %x, <vscale x 4 x i16> %y)
  %b = extractvalue { <vscale x 4 x i16>, <vscale x 4 x i1> } %a, 0
  %c = extractvalue { <vscale x 4 x i16>, <vscale x 4 x i1> } %a, 1
  %d = select <vscale x 4 x i1> %c, <vscale x 4 x i16> zeroinitializer, <vscale x 4 x i16> %b
  ret <vscale x 4 x i16> %d
}

declare { <vscale x 8 x i16>, <vscale x 8 x i1> } @llvm.umul.with.overflow.nxv8i16(<vscale x 8 x i16>, <vscale x 8 x i16>)

define <vscale x 8 x i16> @umulo_nxv8i16(<vscale x 8 x i16> %x, <vscale x 8 x i16> %y) {
; CHECK-LABEL: umulo_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    umulh z2.h, p0/m, z2.h, z1.h
; CHECK-NEXT:    mul z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT:    cmpne p0.h, p0/z, z2.h, #0
; CHECK-NEXT:    mov z0.h, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 8 x i16>, <vscale x 8 x i1> } @llvm.umul.with.overflow.nxv8i16(<vscale x 8 x i16> %x, <vscale x 8 x i16> %y)
  %b = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i1> } %a, 0
  %c = extractvalue { <vscale x 8 x i16>, <vscale x 8 x i1> } %a, 1
  %d = select <vscale x 8 x i1> %c, <vscale x 8 x i16> zeroinitializer, <vscale x 8 x i16> %b
  ret <vscale x 8 x i16> %d
}

declare { <vscale x 16 x i16>, <vscale x 16 x i1> } @llvm.umul.with.overflow.nxv16i16(<vscale x 16 x i16>, <vscale x 16 x i16>)

define <vscale x 16 x i16> @umulo_nxv16i16(<vscale x 16 x i16> %x, <vscale x 16 x i16> %y) {
; CHECK-LABEL: umulo_nxv16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    movprfx z4, z1
; CHECK-NEXT:    umulh z4.h, p0/m, z4.h, z3.h
; CHECK-NEXT:    movprfx z5, z0
; CHECK-NEXT:    umulh z5.h, p0/m, z5.h, z2.h
; CHECK-NEXT:    mul z1.h, p0/m, z1.h, z3.h
; CHECK-NEXT:    mul z0.h, p0/m, z0.h, z2.h
; CHECK-NEXT:    cmpne p1.h, p0/z, z4.h, #0
; CHECK-NEXT:    cmpne p0.h, p0/z, z5.h, #0
; CHECK-NEXT:    mov z0.h, p0/m, #0 // =0x0
; CHECK-NEXT:    mov z1.h, p1/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 16 x i16>, <vscale x 16 x i1> } @llvm.umul.with.overflow.nxv16i16(<vscale x 16 x i16> %x, <vscale x 16 x i16> %y)
  %b = extractvalue { <vscale x 16 x i16>, <vscale x 16 x i1> } %a, 0
  %c = extractvalue { <vscale x 16 x i16>, <vscale x 16 x i1> } %a, 1
  %d = select <vscale x 16 x i1> %c, <vscale x 16 x i16> zeroinitializer, <vscale x 16 x i16> %b
  ret <vscale x 16 x i16> %d
}

declare { <vscale x 32 x i16>, <vscale x 32 x i1> } @llvm.umul.with.overflow.nxv32i16(<vscale x 32 x i16>, <vscale x 32 x i16>)

define <vscale x 32 x i16> @umulo_nxv32i16(<vscale x 32 x i16> %x, <vscale x 32 x i16> %y) {
; CHECK-LABEL: umulo_nxv32i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    movprfx z24, z3
; CHECK-NEXT:    umulh z24.h, p0/m, z24.h, z7.h
; CHECK-NEXT:    movprfx z25, z0
; CHECK-NEXT:    umulh z25.h, p0/m, z25.h, z4.h
; CHECK-NEXT:    movprfx z26, z2
; CHECK-NEXT:    umulh z26.h, p0/m, z26.h, z6.h
; CHECK-NEXT:    movprfx z27, z1
; CHECK-NEXT:    umulh z27.h, p0/m, z27.h, z5.h
; CHECK-NEXT:    mul z3.h, p0/m, z3.h, z7.h
; CHECK-NEXT:    mul z2.h, p0/m, z2.h, z6.h
; CHECK-NEXT:    mul z1.h, p0/m, z1.h, z5.h
; CHECK-NEXT:    mul z0.h, p0/m, z0.h, z4.h
; CHECK-NEXT:    cmpne p1.h, p0/z, z25.h, #0
; CHECK-NEXT:    cmpne p2.h, p0/z, z24.h, #0
; CHECK-NEXT:    cmpne p3.h, p0/z, z26.h, #0
; CHECK-NEXT:    cmpne p0.h, p0/z, z27.h, #0
; CHECK-NEXT:    mov z0.h, p1/m, #0 // =0x0
; CHECK-NEXT:    mov z2.h, p3/m, #0 // =0x0
; CHECK-NEXT:    mov z3.h, p2/m, #0 // =0x0
; CHECK-NEXT:    mov z1.h, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 32 x i16>, <vscale x 32 x i1> } @llvm.umul.with.overflow.nxv32i16(<vscale x 32 x i16> %x, <vscale x 32 x i16> %y)
  %b = extractvalue { <vscale x 32 x i16>, <vscale x 32 x i1> } %a, 0
  %c = extractvalue { <vscale x 32 x i16>, <vscale x 32 x i1> } %a, 1
  %d = select <vscale x 32 x i1> %c, <vscale x 32 x i16> zeroinitializer, <vscale x 32 x i16> %b
  ret <vscale x 32 x i16> %d
}

declare { <vscale x 2 x i32>, <vscale x 2 x i1> } @llvm.umul.with.overflow.nxv2i32(<vscale x 2 x i32>, <vscale x 2 x i32>)

define <vscale x 2 x i32> @umulo_nxv2i32(<vscale x 2 x i32> %x, <vscale x 2 x i32> %y) {
; CHECK-LABEL: umulo_nxv2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and z1.d, z1.d, #0xffffffff
; CHECK-NEXT:    and z0.d, z0.d, #0xffffffff
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    lsr z1.d, z0.d, #32
; CHECK-NEXT:    cmpne p0.d, p0/z, z1.d, #0
; CHECK-NEXT:    mov z0.d, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 2 x i32>, <vscale x 2 x i1> } @llvm.umul.with.overflow.nxv2i32(<vscale x 2 x i32> %x, <vscale x 2 x i32> %y)
  %b = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i1> } %a, 0
  %c = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i1> } %a, 1
  %d = select <vscale x 2 x i1> %c, <vscale x 2 x i32> zeroinitializer, <vscale x 2 x i32> %b
  ret <vscale x 2 x i32> %d
}

declare { <vscale x 4 x i32>, <vscale x 4 x i1> } @llvm.umul.with.overflow.nxv4i32(<vscale x 4 x i32>, <vscale x 4 x i32>)

define <vscale x 4 x i32> @umulo_nxv4i32(<vscale x 4 x i32> %x, <vscale x 4 x i32> %y) {
; CHECK-LABEL: umulo_nxv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    umulh z2.s, p0/m, z2.s, z1.s
; CHECK-NEXT:    mul z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    cmpne p0.s, p0/z, z2.s, #0
; CHECK-NEXT:    mov z0.s, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 4 x i32>, <vscale x 4 x i1> } @llvm.umul.with.overflow.nxv4i32(<vscale x 4 x i32> %x, <vscale x 4 x i32> %y)
  %b = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i1> } %a, 0
  %c = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i1> } %a, 1
  %d = select <vscale x 4 x i1> %c, <vscale x 4 x i32> zeroinitializer, <vscale x 4 x i32> %b
  ret <vscale x 4 x i32> %d
}

declare { <vscale x 8 x i32>, <vscale x 8 x i1> } @llvm.umul.with.overflow.nxv8i32(<vscale x 8 x i32>, <vscale x 8 x i32>)

define <vscale x 8 x i32> @umulo_nxv8i32(<vscale x 8 x i32> %x, <vscale x 8 x i32> %y) {
; CHECK-LABEL: umulo_nxv8i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    movprfx z4, z1
; CHECK-NEXT:    umulh z4.s, p0/m, z4.s, z3.s
; CHECK-NEXT:    movprfx z5, z0
; CHECK-NEXT:    umulh z5.s, p0/m, z5.s, z2.s
; CHECK-NEXT:    mul z1.s, p0/m, z1.s, z3.s
; CHECK-NEXT:    mul z0.s, p0/m, z0.s, z2.s
; CHECK-NEXT:    cmpne p1.s, p0/z, z4.s, #0
; CHECK-NEXT:    cmpne p0.s, p0/z, z5.s, #0
; CHECK-NEXT:    mov z0.s, p0/m, #0 // =0x0
; CHECK-NEXT:    mov z1.s, p1/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 8 x i32>, <vscale x 8 x i1> } @llvm.umul.with.overflow.nxv8i32(<vscale x 8 x i32> %x, <vscale x 8 x i32> %y)
  %b = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i1> } %a, 0
  %c = extractvalue { <vscale x 8 x i32>, <vscale x 8 x i1> } %a, 1
  %d = select <vscale x 8 x i1> %c, <vscale x 8 x i32> zeroinitializer, <vscale x 8 x i32> %b
  ret <vscale x 8 x i32> %d
}

declare { <vscale x 16 x i32>, <vscale x 16 x i1> } @llvm.umul.with.overflow.nxv16i32(<vscale x 16 x i32>, <vscale x 16 x i32>)

define <vscale x 16 x i32> @umulo_nxv16i32(<vscale x 16 x i32> %x, <vscale x 16 x i32> %y) {
; CHECK-LABEL: umulo_nxv16i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    movprfx z24, z3
; CHECK-NEXT:    umulh z24.s, p0/m, z24.s, z7.s
; CHECK-NEXT:    movprfx z25, z0
; CHECK-NEXT:    umulh z25.s, p0/m, z25.s, z4.s
; CHECK-NEXT:    movprfx z26, z2
; CHECK-NEXT:    umulh z26.s, p0/m, z26.s, z6.s
; CHECK-NEXT:    movprfx z27, z1
; CHECK-NEXT:    umulh z27.s, p0/m, z27.s, z5.s
; CHECK-NEXT:    mul z3.s, p0/m, z3.s, z7.s
; CHECK-NEXT:    mul z2.s, p0/m, z2.s, z6.s
; CHECK-NEXT:    mul z1.s, p0/m, z1.s, z5.s
; CHECK-NEXT:    mul z0.s, p0/m, z0.s, z4.s
; CHECK-NEXT:    cmpne p1.s, p0/z, z25.s, #0
; CHECK-NEXT:    cmpne p2.s, p0/z, z24.s, #0
; CHECK-NEXT:    cmpne p3.s, p0/z, z26.s, #0
; CHECK-NEXT:    cmpne p0.s, p0/z, z27.s, #0
; CHECK-NEXT:    mov z0.s, p1/m, #0 // =0x0
; CHECK-NEXT:    mov z2.s, p3/m, #0 // =0x0
; CHECK-NEXT:    mov z3.s, p2/m, #0 // =0x0
; CHECK-NEXT:    mov z1.s, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 16 x i32>, <vscale x 16 x i1> } @llvm.umul.with.overflow.nxv16i32(<vscale x 16 x i32> %x, <vscale x 16 x i32> %y)
  %b = extractvalue { <vscale x 16 x i32>, <vscale x 16 x i1> } %a, 0
  %c = extractvalue { <vscale x 16 x i32>, <vscale x 16 x i1> } %a, 1
  %d = select <vscale x 16 x i1> %c, <vscale x 16 x i32> zeroinitializer, <vscale x 16 x i32> %b
  ret <vscale x 16 x i32> %d
}

declare { <vscale x 2 x i64>, <vscale x 2 x i1> } @llvm.umul.with.overflow.nxv2i64(<vscale x 2 x i64>, <vscale x 2 x i64>)

define <vscale x 2 x i64> @umulo_nxv2i64(<vscale x 2 x i64> %x, <vscale x 2 x i64> %y) {
; CHECK-LABEL: umulo_nxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    umulh z2.d, p0/m, z2.d, z1.d
; CHECK-NEXT:    mul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    cmpne p0.d, p0/z, z2.d, #0
; CHECK-NEXT:    mov z0.d, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 2 x i64>, <vscale x 2 x i1> } @llvm.umul.with.overflow.nxv2i64(<vscale x 2 x i64> %x, <vscale x 2 x i64> %y)
  %b = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i1> } %a, 0
  %c = extractvalue { <vscale x 2 x i64>, <vscale x 2 x i1> } %a, 1
  %d = select <vscale x 2 x i1> %c, <vscale x 2 x i64> zeroinitializer, <vscale x 2 x i64> %b
  ret <vscale x 2 x i64> %d
}

declare { <vscale x 4 x i64>, <vscale x 4 x i1> } @llvm.umul.with.overflow.nxv4i64(<vscale x 4 x i64>, <vscale x 4 x i64>)

define <vscale x 4 x i64> @umulo_nxv4i64(<vscale x 4 x i64> %x, <vscale x 4 x i64> %y) {
; CHECK-LABEL: umulo_nxv4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    movprfx z4, z1
; CHECK-NEXT:    umulh z4.d, p0/m, z4.d, z3.d
; CHECK-NEXT:    movprfx z5, z0
; CHECK-NEXT:    umulh z5.d, p0/m, z5.d, z2.d
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z3.d
; CHECK-NEXT:    mul z0.d, p0/m, z0.d, z2.d
; CHECK-NEXT:    cmpne p1.d, p0/z, z4.d, #0
; CHECK-NEXT:    cmpne p0.d, p0/z, z5.d, #0
; CHECK-NEXT:    mov z0.d, p0/m, #0 // =0x0
; CHECK-NEXT:    mov z1.d, p1/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 4 x i64>, <vscale x 4 x i1> } @llvm.umul.with.overflow.nxv4i64(<vscale x 4 x i64> %x, <vscale x 4 x i64> %y)
  %b = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i1> } %a, 0
  %c = extractvalue { <vscale x 4 x i64>, <vscale x 4 x i1> } %a, 1
  %d = select <vscale x 4 x i1> %c, <vscale x 4 x i64> zeroinitializer, <vscale x 4 x i64> %b
  ret <vscale x 4 x i64> %d
}

declare { <vscale x 8 x i64>, <vscale x 8 x i1> } @llvm.umul.with.overflow.nxv8i64(<vscale x 8 x i64>, <vscale x 8 x i64>)

define <vscale x 8 x i64> @umulo_nxv8i64(<vscale x 8 x i64> %x, <vscale x 8 x i64> %y) {
; CHECK-LABEL: umulo_nxv8i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    movprfx z24, z3
; CHECK-NEXT:    umulh z24.d, p0/m, z24.d, z7.d
; CHECK-NEXT:    movprfx z25, z0
; CHECK-NEXT:    umulh z25.d, p0/m, z25.d, z4.d
; CHECK-NEXT:    movprfx z26, z2
; CHECK-NEXT:    umulh z26.d, p0/m, z26.d, z6.d
; CHECK-NEXT:    movprfx z27, z1
; CHECK-NEXT:    umulh z27.d, p0/m, z27.d, z5.d
; CHECK-NEXT:    mul z3.d, p0/m, z3.d, z7.d
; CHECK-NEXT:    mul z2.d, p0/m, z2.d, z6.d
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z5.d
; CHECK-NEXT:    mul z0.d, p0/m, z0.d, z4.d
; CHECK-NEXT:    cmpne p1.d, p0/z, z25.d, #0
; CHECK-NEXT:    cmpne p2.d, p0/z, z24.d, #0
; CHECK-NEXT:    cmpne p3.d, p0/z, z26.d, #0
; CHECK-NEXT:    cmpne p0.d, p0/z, z27.d, #0
; CHECK-NEXT:    mov z0.d, p1/m, #0 // =0x0
; CHECK-NEXT:    mov z2.d, p3/m, #0 // =0x0
; CHECK-NEXT:    mov z3.d, p2/m, #0 // =0x0
; CHECK-NEXT:    mov z1.d, p0/m, #0 // =0x0
; CHECK-NEXT:    ret
  %a = call { <vscale x 8 x i64>, <vscale x 8 x i1> } @llvm.umul.with.overflow.nxv8i64(<vscale x 8 x i64> %x, <vscale x 8 x i64> %y)
  %b = extractvalue { <vscale x 8 x i64>, <vscale x 8 x i1> } %a, 0
  %c = extractvalue { <vscale x 8 x i64>, <vscale x 8 x i1> } %a, 1
  %d = select <vscale x 8 x i1> %c, <vscale x 8 x i64> zeroinitializer, <vscale x 8 x i64> %b
  ret <vscale x 8 x i64> %d
}
