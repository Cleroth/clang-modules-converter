; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; Test the three-operand form of 64-bit addition.
;
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z196 | FileCheck %s

declare i64 @foo(i64, i64, i64)

; Check SLGRK.
define i64 @f1(i64 %dummy, i64 %a, i64 %b, ptr %flag) {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slgrk %r2, %r3, %r4
; CHECK-NEXT:    ipm %r0
; CHECK-NEXT:    afi %r0, -536870912
; CHECK-NEXT:    risbg %r0, %r0, 63, 191, 33
; CHECK-NEXT:    stg %r0, 0(%r5)
; CHECK-NEXT:    br %r14
  %t = call {i64, i1} @llvm.usub.with.overflow.i64(i64 %a, i64 %b)
  %val = extractvalue {i64, i1} %t, 0
  %obit = extractvalue {i64, i1} %t, 1
  %ext = zext i1 %obit to i64
  store i64 %ext, ptr %flag
  ret i64 %val
}

; Check using the overflow result for a branch.
define i64 @f2(i64 %dummy, i64 %a, i64 %b) {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slgrk %r2, %r3, %r4
; CHECK-NEXT:    bnler %r14
; CHECK-NEXT:  .LBB1_1: # %call
; CHECK-NEXT:    lghi %r2, 0
; CHECK-NEXT:    jg foo@PLT
  %t = call {i64, i1} @llvm.usub.with.overflow.i64(i64 %a, i64 %b)
  %val = extractvalue {i64, i1} %t, 0
  %obit = extractvalue {i64, i1} %t, 1
  br i1 %obit, label %call, label %exit

call:
  %res = tail call i64 @foo(i64 0, i64 %a, i64 %b)
  ret i64 %res

exit:
  ret i64 %val
}

; ... and the same with the inverted direction.
define i64 @f3(i64 %dummy, i64 %a, i64 %b) {
; CHECK-LABEL: f3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slgrk %r2, %r3, %r4
; CHECK-NEXT:    bler %r14
; CHECK-NEXT:  .LBB2_1: # %call
; CHECK-NEXT:    lghi %r2, 0
; CHECK-NEXT:    jg foo@PLT
  %t = call {i64, i1} @llvm.usub.with.overflow.i64(i64 %a, i64 %b)
  %val = extractvalue {i64, i1} %t, 0
  %obit = extractvalue {i64, i1} %t, 1
  br i1 %obit, label %exit, label %call

call:
  %res = tail call i64 @foo(i64 0, i64 %a, i64 %b)
  ret i64 %res

exit:
  ret i64 %val
}

; Check that we can still use SLGR in obvious cases.
define i64 @f4(i64 %a, i64 %b, ptr %flag) {
; CHECK-LABEL: f4:
; CHECK:       # %bb.0:
; CHECK-NEXT:    slgr %r2, %r3
; CHECK-NEXT:    ipm %r0
; CHECK-NEXT:    afi %r0, -536870912
; CHECK-NEXT:    risbg %r0, %r0, 63, 191, 33
; CHECK-NEXT:    stg %r0, 0(%r4)
; CHECK-NEXT:    br %r14
  %t = call {i64, i1} @llvm.usub.with.overflow.i64(i64 %a, i64 %b)
  %val = extractvalue {i64, i1} %t, 0
  %obit = extractvalue {i64, i1} %t, 1
  %ext = zext i1 %obit to i64
  store i64 %ext, ptr %flag
  ret i64 %val
}

declare {i64, i1} @llvm.usub.with.overflow.i64(i64, i64) nounwind readnone

