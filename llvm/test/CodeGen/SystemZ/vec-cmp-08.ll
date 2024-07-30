; Test v1i128 comparisons.
; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
;
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z13 | FileCheck %s

; Test eq.
define <1 x i128> @f1(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vceqgs %v0, %v24, %v26
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    ber %r14
; CHECK-NEXT:  .LBB0_1:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp eq <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test ne.
define <1 x i128> @f2(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vceqgs %v0, %v24, %v26
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    bnher %r14
; CHECK-NEXT:  .LBB1_1:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp ne <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test sgt.
define <1 x i128> @f3(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vecg %v26, %v24
; CHECK-NEXT:    jlh .LBB2_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vchlgs %v0, %v24, %v26
; CHECK-NEXT:  .LBB2_2:
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    blr %r14
; CHECK-NEXT:  .LBB2_3:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp sgt <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test sge.
define <1 x i128> @f4(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vecg %v24, %v26
; CHECK-NEXT:    jlh .LBB3_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vchlgs %v0, %v26, %v24
; CHECK-NEXT:  .LBB3_2:
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    bnlr %r14
; CHECK-NEXT:  .LBB3_3:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp sge <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test sle.
define <1 x i128> @f5(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f5:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vecg %v26, %v24
; CHECK-NEXT:    jlh .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vchlgs %v0, %v24, %v26
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    bnlr %r14
; CHECK-NEXT:  .LBB4_3:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp sle <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test slt.
define <1 x i128> @f6(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f6:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vecg %v24, %v26
; CHECK-NEXT:    jlh .LBB5_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vchlgs %v0, %v26, %v24
; CHECK-NEXT:  .LBB5_2:
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    blr %r14
; CHECK-NEXT:  .LBB5_3:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp slt <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test ugt.
define <1 x i128> @f7(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f7:
; CHECK:       # %bb.0:
; CHECK-NEXT:    veclg %v26, %v24
; CHECK-NEXT:    jlh .LBB6_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vchlgs %v0, %v24, %v26
; CHECK-NEXT:  .LBB6_2:
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    blr %r14
; CHECK-NEXT:  .LBB6_3:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp ugt <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test uge.
define <1 x i128> @f8(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    veclg %v24, %v26
; CHECK-NEXT:    jlh .LBB7_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vchlgs %v0, %v26, %v24
; CHECK-NEXT:  .LBB7_2:
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    bnlr %r14
; CHECK-NEXT:  .LBB7_3:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp uge <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test ule.
define <1 x i128> @f9(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f9:
; CHECK:       # %bb.0:
; CHECK-NEXT:    veclg %v26, %v24
; CHECK-NEXT:    jlh .LBB8_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vchlgs %v0, %v24, %v26
; CHECK-NEXT:  .LBB8_2:
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    bnlr %r14
; CHECK-NEXT:  .LBB8_3:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp ule <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test ult.
define <1 x i128> @f10(<1 x i128> %val1, <1 x i128> %val2) {
; CHECK-LABEL: f10:
; CHECK:       # %bb.0:
; CHECK-NEXT:    veclg %v24, %v26
; CHECK-NEXT:    jlh .LBB9_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vchlgs %v0, %v26, %v24
; CHECK-NEXT:  .LBB9_2:
; CHECK-NEXT:    vgbm %v24, 65535
; CHECK-NEXT:    blr %r14
; CHECK-NEXT:  .LBB9_3:
; CHECK-NEXT:    vgbm %v24, 0
; CHECK-NEXT:    br %r14
  %cmp = icmp ult <1 x i128> %val1, %val2
  %ret = sext <1 x i1> %cmp to <1 x i128>
  ret <1 x i128> %ret
}

; Test eq selects.
define <1 x i128> @f11(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f11:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vceqgs %v0, %v24, %v26
; CHECK-NEXT:    je .LBB10_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:  .LBB10_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp eq <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}

; Test ne selects.
define <1 x i128> @f12(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f12:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vceqgs %v0, %v24, %v26
; CHECK-NEXT:    jnhe .LBB11_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:  .LBB11_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp ne <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}

; Test sgt selects.
define <1 x i128> @f13(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f13:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vecg %v26, %v24
; CHECK-NEXT:    je .LBB12_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    jnl .LBB12_4
; CHECK-NEXT:  .LBB12_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
; CHECK-NEXT:  .LBB12_3:
; CHECK-NEXT:    vchlgs %v0, %v24, %v26
; CHECK-NEXT:    jl .LBB12_2
; CHECK-NEXT:  .LBB12_4:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp sgt <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}

; Test sge selects.
define <1 x i128> @f14(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f14:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vecg %v24, %v26
; CHECK-NEXT:    je .LBB13_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    jl .LBB13_4
; CHECK-NEXT:  .LBB13_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
; CHECK-NEXT:  .LBB13_3:
; CHECK-NEXT:    vchlgs %v0, %v26, %v24
; CHECK-NEXT:    jnl .LBB13_2
; CHECK-NEXT:  .LBB13_4:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp sge <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}

; Test sle selects.
define <1 x i128> @f15(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vecg %v26, %v24
; CHECK-NEXT:    je .LBB14_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    jl .LBB14_4
; CHECK-NEXT:  .LBB14_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
; CHECK-NEXT:  .LBB14_3:
; CHECK-NEXT:    vchlgs %v0, %v24, %v26
; CHECK-NEXT:    jnl .LBB14_2
; CHECK-NEXT:  .LBB14_4:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp sle <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}

; Test slt selects.
define <1 x i128> @f16(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vecg %v24, %v26
; CHECK-NEXT:    je .LBB15_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    jnl .LBB15_4
; CHECK-NEXT:  .LBB15_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
; CHECK-NEXT:  .LBB15_3:
; CHECK-NEXT:    vchlgs %v0, %v26, %v24
; CHECK-NEXT:    jl .LBB15_2
; CHECK-NEXT:  .LBB15_4:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp slt <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}

; Test ugt selects.
define <1 x i128> @f17(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f17:
; CHECK:       # %bb.0:
; CHECK-NEXT:    veclg %v26, %v24
; CHECK-NEXT:    je .LBB16_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    jnl .LBB16_4
; CHECK-NEXT:  .LBB16_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
; CHECK-NEXT:  .LBB16_3:
; CHECK-NEXT:    vchlgs %v0, %v24, %v26
; CHECK-NEXT:    jl .LBB16_2
; CHECK-NEXT:  .LBB16_4:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp ugt <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}

; Test uge selects.
define <1 x i128> @f18(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f18:
; CHECK:       # %bb.0:
; CHECK-NEXT:    veclg %v24, %v26
; CHECK-NEXT:    je .LBB17_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    jl .LBB17_4
; CHECK-NEXT:  .LBB17_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
; CHECK-NEXT:  .LBB17_3:
; CHECK-NEXT:    vchlgs %v0, %v26, %v24
; CHECK-NEXT:    jnl .LBB17_2
; CHECK-NEXT:  .LBB17_4:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp uge <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}

; Test ule selects.
define <1 x i128> @f19(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f19:
; CHECK:       # %bb.0:
; CHECK-NEXT:    veclg %v26, %v24
; CHECK-NEXT:    je .LBB18_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    jl .LBB18_4
; CHECK-NEXT:  .LBB18_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
; CHECK-NEXT:  .LBB18_3:
; CHECK-NEXT:    vchlgs %v0, %v24, %v26
; CHECK-NEXT:    jnl .LBB18_2
; CHECK-NEXT:  .LBB18_4:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp ule <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}

; Test ult selects.
define <1 x i128> @f20(<1 x i128> %val1, <1 x i128> %val2,
; CHECK-LABEL: f20:
; CHECK:       # %bb.0:
; CHECK-NEXT:    veclg %v24, %v26
; CHECK-NEXT:    je .LBB19_3
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    jnl .LBB19_4
; CHECK-NEXT:  .LBB19_2:
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
; CHECK-NEXT:  .LBB19_3:
; CHECK-NEXT:    vchlgs %v0, %v26, %v24
; CHECK-NEXT:    jl .LBB19_2
; CHECK-NEXT:  .LBB19_4:
; CHECK-NEXT:    vlr %v28, %v30
; CHECK-NEXT:    vlr %v24, %v28
; CHECK-NEXT:    br %r14
                       <1 x i128> %val3, <1 x i128> %val4) {
  %cmp = icmp ult <1 x i128> %val1, %val2
  %ret = select <1 x i1> %cmp, <1 x i128> %val3, <1 x i128> %val4
  ret <1 x i128> %ret
}
