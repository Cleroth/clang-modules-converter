; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 -mattr=+d --verify-machineinstrs < %s \
; RUN:   | FileCheck %s

define void @getSetCCResultType(ptr %p) {
; CHECK-LABEL: getSetCCResultType:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ld.w $a1, $a0, 0
; CHECK-NEXT:    ld.w $a2, $a0, 12
; CHECK-NEXT:    ld.w $a3, $a0, 4
; CHECK-NEXT:    ld.w $a4, $a0, 8
; CHECK-NEXT:    sltui $a1, $a1, 1
; CHECK-NEXT:    sub.d $a1, $zero, $a1
; CHECK-NEXT:    sltui $a3, $a3, 1
; CHECK-NEXT:    sub.d $a3, $zero, $a3
; CHECK-NEXT:    sltui $a4, $a4, 1
; CHECK-NEXT:    sub.d $a4, $zero, $a4
; CHECK-NEXT:    sltui $a2, $a2, 1
; CHECK-NEXT:    sub.d $a2, $zero, $a2
; CHECK-NEXT:    st.w $a2, $a0, 12
; CHECK-NEXT:    st.w $a4, $a0, 8
; CHECK-NEXT:    st.w $a3, $a0, 4
; CHECK-NEXT:    st.w $a1, $a0, 0
; CHECK-NEXT:    ret
entry:
  %0 = load <4 x i32>, ptr %p, align 16
  %cmp = icmp eq <4 x i32> %0, zeroinitializer
  %sext = sext <4 x i1> %cmp to <4 x i32>
  store <4 x i32> %sext, ptr %p, align 16
  ret void
}
