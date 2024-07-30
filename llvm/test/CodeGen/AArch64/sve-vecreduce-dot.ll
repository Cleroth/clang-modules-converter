; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64 -mattr=+sve,+dotprod < %s | FileCheck %s

define i32 @test(<vscale x 32 x i8> %bin.rdx, <vscale x 32 x i8> %bin.rdx2)  {
; CHECK-LABEL: test:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sunpklo z4.h, z2.b
; CHECK-NEXT:    sunpklo z5.h, z0.b
; CHECK-NEXT:    sunpkhi z0.h, z0.b
; CHECK-NEXT:    sunpkhi z2.h, z2.b
; CHECK-NEXT:    sunpklo z6.h, z1.b
; CHECK-NEXT:    sunpkhi z1.h, z1.b
; CHECK-NEXT:    sunpklo z7.h, z3.b
; CHECK-NEXT:    sunpkhi z3.h, z3.b
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    sunpkhi z24.s, z5.h
; CHECK-NEXT:    sunpklo z5.s, z5.h
; CHECK-NEXT:    sunpklo z25.s, z4.h
; CHECK-NEXT:    sunpklo z26.s, z0.h
; CHECK-NEXT:    sunpkhi z4.s, z4.h
; CHECK-NEXT:    sunpklo z27.s, z2.h
; CHECK-NEXT:    sunpkhi z0.s, z0.h
; CHECK-NEXT:    sunpkhi z2.s, z2.h
; CHECK-NEXT:    sunpklo z28.s, z6.h
; CHECK-NEXT:    sunpkhi z6.s, z6.h
; CHECK-NEXT:    mul z5.s, p0/m, z5.s, z25.s
; CHECK-NEXT:    sunpkhi z25.s, z1.h
; CHECK-NEXT:    sunpklo z1.s, z1.h
; CHECK-NEXT:    mul z26.s, p0/m, z26.s, z27.s
; CHECK-NEXT:    mul z4.s, p0/m, z4.s, z24.s
; CHECK-NEXT:    sunpkhi z24.s, z3.h
; CHECK-NEXT:    mul z0.s, p0/m, z0.s, z2.s
; CHECK-NEXT:    sunpkhi z2.s, z7.h
; CHECK-NEXT:    sunpklo z7.s, z7.h
; CHECK-NEXT:    sunpklo z3.s, z3.h
; CHECK-NEXT:    mla z0.s, p0/m, z25.s, z24.s
; CHECK-NEXT:    mad z2.s, p0/m, z6.s, z4.s
; CHECK-NEXT:    mad z1.s, p0/m, z3.s, z26.s
; CHECK-NEXT:    movprfx z3, z5
; CHECK-NEXT:    mla z3.s, p0/m, z28.s, z7.s
; CHECK-NEXT:    add z0.s, z2.s, z0.s
; CHECK-NEXT:    add z1.s, z3.s, z1.s
; CHECK-NEXT:    add z0.s, z1.s, z0.s
; CHECK-NEXT:    uaddv d0, p0, z0.s
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %a = sext <vscale x 32 x i8> %bin.rdx to <vscale x 32 x i32>
  %b = sext <vscale x 32 x i8> %bin.rdx2 to <vscale x 32 x i32>
  %c = mul <vscale x 32 x i32> %a, %b
  %r = call i32 @llvm.vector.reduce.add.nxv32i32(<vscale x 32 x i32> %c)
  ret i32 %r
}
declare i32 @llvm.vector.reduce.add.nxv32i32(<vscale x 32 x i32> )
