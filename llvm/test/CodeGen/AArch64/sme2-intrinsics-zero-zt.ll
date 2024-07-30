; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2 < %s | FileCheck %s
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sme2 -force-streaming < %s | FileCheck %s

define void @zero_zt0() {
; CHECK-LABEL: zero_zt0:
; CHECK:       // %bb.0:
; CHECK-NEXT:    zero { zt0 }
; CHECK-NEXT:    ret
    call void @llvm.aarch64.sme.zero.zt(i32 0)
    ret void
}

declare void @llvm.aarch64.sme.zero.zt(i32)
