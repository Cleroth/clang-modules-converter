; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu \
; RUN:   -mcpu=pwr10 -ppc-asm-full-reg-names -ppc-vsr-nums-as-vr \
; RUN:   < %s | FileCheck %s
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-ibm-aix -vec-extabi \
; RUN:   -mcpu=pwr10 < %s | FileCheck %s -check-prefix=CHECK-AIX

define i32 @SplitPromoteVectorTest(i32 %Opc) align 2 {
; CHECK-LABEL: SplitPromoteVectorTest:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    plxv v2, .LCPI0_0@PCREL(0), 1
; CHECK-NEXT:    plxv v4, .LCPI0_1@PCREL(0), 1
; CHECK-NEXT:    mtvsrws v3, r3
; CHECK-NEXT:    li r5, 12
; CHECK-NEXT:    li r8, 0
; CHECK-NEXT:    vcmpequw v2, v3, v2
; CHECK-NEXT:    plxv v5, .LCPI0_2@PCREL(0), 1
; CHECK-NEXT:    vcmpequw v4, v3, v4
; CHECK-NEXT:    vcmpequw v5, v3, v5
; CHECK-NEXT:    vextubrx r4, r5, v2
; CHECK-NEXT:    vextubrx r6, r5, v4
; CHECK-NEXT:    or r9, r6, r4
; CHECK-NEXT:    li r6, 4
; CHECK-NEXT:    vextubrx r4, r8, v5
; CHECK-NEXT:    vextubrx r7, r6, v5
; CHECK-NEXT:    rlwimi r4, r7, 1, 30, 30
; CHECK-NEXT:    li r7, 8
; CHECK-NEXT:    vextubrx r10, r7, v5
; CHECK-NEXT:    rlwimi r4, r10, 2, 29, 29
; CHECK-NEXT:    vextubrx r10, r5, v5
; CHECK-NEXT:    plxv v5, .LCPI0_3@PCREL(0), 1
; CHECK-NEXT:    rlwimi r4, r10, 3, 28, 28
; CHECK-NEXT:    vcmpequw v5, v3, v5
; CHECK-NEXT:    vextubrx r10, r8, v5
; CHECK-NEXT:    rlwimi r4, r10, 4, 27, 27
; CHECK-NEXT:    vextubrx r10, r6, v5
; CHECK-NEXT:    rlwimi r4, r10, 5, 26, 26
; CHECK-NEXT:    vextubrx r10, r7, v5
; CHECK-NEXT:    rlwimi r4, r10, 6, 25, 25
; CHECK-NEXT:    vextubrx r10, r5, v5
; CHECK-NEXT:    plxv v5, .LCPI0_4@PCREL(0), 1
; CHECK-NEXT:    rlwimi r4, r10, 7, 24, 24
; CHECK-NEXT:    vcmpequw v5, v3, v5
; CHECK-NEXT:    vextubrx r10, r8, v5
; CHECK-NEXT:    rlwimi r4, r10, 8, 23, 23
; CHECK-NEXT:    vextubrx r10, r6, v5
; CHECK-NEXT:    rlwimi r4, r10, 9, 22, 22
; CHECK-NEXT:    vextubrx r10, r7, v5
; CHECK-NEXT:    rlwimi r4, r10, 10, 21, 21
; CHECK-NEXT:    vextubrx r10, r5, v5
; CHECK-NEXT:    rlwimi r4, r10, 11, 20, 20
; CHECK-NEXT:    vextubrx r10, r8, v4
; CHECK-NEXT:    rlwimi r4, r10, 12, 19, 19
; CHECK-NEXT:    vextubrx r10, r6, v4
; CHECK-NEXT:    rlwimi r4, r10, 13, 18, 18
; CHECK-NEXT:    vextubrx r10, r7, v4
; CHECK-NEXT:    plxv v4, .LCPI0_5@PCREL(0), 1
; CHECK-NEXT:    rlwimi r4, r10, 14, 17, 17
; CHECK-NEXT:    rlwimi r4, r9, 15, 0, 16
; CHECK-NEXT:    vcmpequw v4, v3, v4
; CHECK-NEXT:    vextubrx r10, r8, v4
; CHECK-NEXT:    vextubrx r9, r6, v4
; CHECK-NEXT:    clrlwi r10, r10, 31
; CHECK-NEXT:    rlwimi r10, r9, 1, 30, 30
; CHECK-NEXT:    vextubrx r9, r7, v4
; CHECK-NEXT:    rlwimi r10, r9, 2, 29, 29
; CHECK-NEXT:    vextubrx r9, r5, v4
; CHECK-NEXT:    plxv v4, .LCPI0_6@PCREL(0), 1
; CHECK-NEXT:    rlwimi r10, r9, 3, 28, 28
; CHECK-NEXT:    vcmpequw v4, v3, v4
; CHECK-NEXT:    vextubrx r9, r8, v4
; CHECK-NEXT:    rlwimi r10, r9, 4, 27, 27
; CHECK-NEXT:    vextubrx r9, r6, v4
; CHECK-NEXT:    rlwimi r10, r9, 5, 26, 26
; CHECK-NEXT:    vextubrx r9, r7, v4
; CHECK-NEXT:    rlwimi r10, r9, 6, 25, 25
; CHECK-NEXT:    vextubrx r9, r5, v4
; CHECK-NEXT:    plxv v4, .LCPI0_7@PCREL(0), 1
; CHECK-NEXT:    rlwimi r10, r9, 7, 24, 24
; CHECK-NEXT:    vcmpequw v3, v3, v4
; CHECK-NEXT:    vextubrx r9, r8, v3
; CHECK-NEXT:    vextubrx r5, r5, v3
; CHECK-NEXT:    rlwimi r10, r9, 8, 23, 23
; CHECK-NEXT:    vextubrx r9, r6, v3
; CHECK-NEXT:    rlwimi r10, r9, 9, 22, 22
; CHECK-NEXT:    vextubrx r9, r7, v3
; CHECK-NEXT:    rlwimi r10, r9, 10, 21, 21
; CHECK-NEXT:    rlwimi r10, r5, 11, 20, 20
; CHECK-NEXT:    vextubrx r5, r8, v2
; CHECK-NEXT:    rlwimi r10, r5, 12, 19, 19
; CHECK-NEXT:    vextubrx r5, r6, v2
; CHECK-NEXT:    rlwimi r10, r5, 13, 18, 18
; CHECK-NEXT:    vextubrx r5, r7, v2
; CHECK-NEXT:    rlwimi r10, r5, 14, 17, 17
; CHECK-NEXT:    or r4, r4, r10
; CHECK-NEXT:    andi. r4, r4, 65535
; CHECK-NEXT:    iseleq r3, 0, r3
; CHECK-NEXT:    blr
;
; CHECK-AIX-LABEL: SplitPromoteVectorTest:
; CHECK-AIX:       # %bb.0: # %entry
; CHECK-AIX-NEXT:    ld 4, L..C0(2) # %const.0
; CHECK-AIX-NEXT:    mtvsrws 34, 3
; CHECK-AIX-NEXT:    li 8, 15
; CHECK-AIX-NEXT:    li 5, 11
; CHECK-AIX-NEXT:    lxv 35, 0(4)
; CHECK-AIX-NEXT:    vcmpequw 3, 2, 3
; CHECK-AIX-NEXT:    vextublx 4, 8, 3
; CHECK-AIX-NEXT:    vextublx 6, 5, 3
; CHECK-AIX-NEXT:    clrlwi 4, 4, 31
; CHECK-AIX-NEXT:    rlwimi 4, 6, 1, 30, 30
; CHECK-AIX-NEXT:    li 6, 7
; CHECK-AIX-NEXT:    vextublx 7, 6, 3
; CHECK-AIX-NEXT:    rlwimi 4, 7, 2, 29, 29
; CHECK-AIX-NEXT:    li 7, 3
; CHECK-AIX-NEXT:    vextublx 9, 7, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 3, 28, 28
; CHECK-AIX-NEXT:    ld 9, L..C1(2) # %const.1
; CHECK-AIX-NEXT:    lxv 35, 0(9)
; CHECK-AIX-NEXT:    vcmpequw 3, 2, 3
; CHECK-AIX-NEXT:    vextublx 9, 8, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 4, 27, 27
; CHECK-AIX-NEXT:    vextublx 9, 5, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 5, 26, 26
; CHECK-AIX-NEXT:    vextublx 9, 6, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 6, 25, 25
; CHECK-AIX-NEXT:    vextublx 9, 7, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 7, 24, 24
; CHECK-AIX-NEXT:    ld 9, L..C2(2) # %const.2
; CHECK-AIX-NEXT:    lxv 35, 0(9)
; CHECK-AIX-NEXT:    vcmpequw 3, 2, 3
; CHECK-AIX-NEXT:    vextublx 9, 8, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 8, 23, 23
; CHECK-AIX-NEXT:    vextublx 9, 5, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 9, 22, 22
; CHECK-AIX-NEXT:    vextublx 9, 6, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 10, 21, 21
; CHECK-AIX-NEXT:    vextublx 9, 7, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 11, 20, 20
; CHECK-AIX-NEXT:    ld 9, L..C3(2) # %const.3
; CHECK-AIX-NEXT:    lxv 35, 0(9)
; CHECK-AIX-NEXT:    vcmpequw 3, 2, 3
; CHECK-AIX-NEXT:    vextublx 9, 8, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 12, 19, 19
; CHECK-AIX-NEXT:    vextublx 9, 5, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 13, 18, 18
; CHECK-AIX-NEXT:    vextublx 9, 6, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 14, 17, 17
; CHECK-AIX-NEXT:    vextublx 9, 7, 3
; CHECK-AIX-NEXT:    rlwimi 4, 9, 15, 16, 16
; CHECK-AIX-NEXT:    ld 9, L..C4(2) # %const.4
; CHECK-AIX-NEXT:    lxv 35, 0(9)
; CHECK-AIX-NEXT:    vcmpequw 3, 2, 3
; CHECK-AIX-NEXT:    vextublx 9, 8, 3
; CHECK-AIX-NEXT:    vextublx 10, 5, 3
; CHECK-AIX-NEXT:    clrlwi 9, 9, 31
; CHECK-AIX-NEXT:    rlwimi 9, 10, 1, 30, 30
; CHECK-AIX-NEXT:    vextublx 10, 6, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 2, 29, 29
; CHECK-AIX-NEXT:    vextublx 10, 7, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 3, 28, 28
; CHECK-AIX-NEXT:    ld 10, L..C5(2) # %const.5
; CHECK-AIX-NEXT:    lxv 35, 0(10)
; CHECK-AIX-NEXT:    vcmpequw 3, 2, 3
; CHECK-AIX-NEXT:    vextublx 10, 8, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 4, 27, 27
; CHECK-AIX-NEXT:    vextublx 10, 5, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 5, 26, 26
; CHECK-AIX-NEXT:    vextublx 10, 6, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 6, 25, 25
; CHECK-AIX-NEXT:    vextublx 10, 7, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 7, 24, 24
; CHECK-AIX-NEXT:    ld 10, L..C6(2) # %const.6
; CHECK-AIX-NEXT:    lxv 35, 0(10)
; CHECK-AIX-NEXT:    vcmpequw 3, 2, 3
; CHECK-AIX-NEXT:    vextublx 10, 8, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 8, 23, 23
; CHECK-AIX-NEXT:    vextublx 10, 5, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 9, 22, 22
; CHECK-AIX-NEXT:    vextublx 10, 6, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 10, 21, 21
; CHECK-AIX-NEXT:    vextublx 10, 7, 3
; CHECK-AIX-NEXT:    rlwimi 9, 10, 11, 20, 20
; CHECK-AIX-NEXT:    ld 10, L..C7(2) # %const.7
; CHECK-AIX-NEXT:    lxv 35, 0(10)
; CHECK-AIX-NEXT:    vcmpequw 2, 2, 3
; CHECK-AIX-NEXT:    vextublx 8, 8, 2
; CHECK-AIX-NEXT:    vextublx 5, 5, 2
; CHECK-AIX-NEXT:    rlwimi 9, 8, 12, 19, 19
; CHECK-AIX-NEXT:    rlwimi 9, 5, 13, 18, 18
; CHECK-AIX-NEXT:    vextublx 5, 6, 2
; CHECK-AIX-NEXT:    rlwimi 9, 5, 14, 17, 17
; CHECK-AIX-NEXT:    vextublx 5, 7, 2
; CHECK-AIX-NEXT:    rlwimi 9, 5, 15, 16, 16
; CHECK-AIX-NEXT:    or 4, 9, 4
; CHECK-AIX-NEXT:    andi. 4, 4, 65535
; CHECK-AIX-NEXT:    iseleq 3, 0, 3
; CHECK-AIX-NEXT:    blr
entry:
  %0 = insertelement <32 x i32> poison, i32 %Opc, i64 0
  %shuffle = shufflevector <32 x i32> %0, <32 x i32> poison, <32 x i32> zeroinitializer
  %1 = icmp eq <32 x i32> %shuffle, <i32 991, i32 888, i32 963, i32 906, i32 944, i32 915, i32 895, i32 952, i32 892, i32 949, i32 974, i32 879, i32 874, i32 943, i32 962, i32 905, i32 914, i32 951, i32 948, i32 894, i32 891, i32 973, i32 878, i32 989, i32 886, i32 987, i32 884, i32 961, i32 904, i32 942, i32 913, i32 893>
  %2 = bitcast <32 x i1> %1 to i32
  %3 = icmp ne i32 %2, 0
  %op.rdx = or i1 %3, false
  %op.rdx255 = or i1 %op.rdx, false
  %4 = or i1 %op.rdx255, false
  %5 = or i1 %4, false
  %6 = or i1 %5, false
  %7 = or i1 %6, false
  %cond = select i1 %7, i32 %Opc, i32 0
  ret i32 %cond
}
