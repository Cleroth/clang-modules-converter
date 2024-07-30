; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple aarch64-- -o - %s | FileCheck %s

; This used to fail when legalizing types, due to not detecting that a cycle
; in the DAG was introduced when merging consecutive stores.
;
; When checking for cycles the DAG looks like this:
;
;   SelectionDAG has 16 nodes:
;     t0: ch = EntryToken
;       t3: i64 = add nuw GlobalAddress:i64<ptr @g0> 0, Constant:i64<8>
;     t6: ch = store<(store (s64) into %ir.sp1, align 1, !tbaa !1)> t0, Constant:i64<0>, t3, undef:i64
;     t7: i64,ch = load<(load (s64) from `ptr undef`, align 1)> t6, undef:i64, undef:i64
;       t8: i64 = add nuw t7, Constant:i64<8>
;     t9: i64,ch = load<(load (s64) from %ir.lp0, align 1)> t6, t8, undef:i64
;         t21: ch = store<(store (s64) into %ir.sp01, align 1)> t19:1, Constant:i64<0>, GlobalAddress:i64<ptr @g0> 0, undef:i64
;       t24: ch = TokenFactor t7:1, t9:1, t21
;     t14: ch,glue = CopyToReg t24, Register:i64 $x0, t19
;     t19: i64,ch = load<(load (s64) from %ir.lp12, align 1, !tbaa !7)> t0, t9, undef:i64
;     t15: ch = AArch64ISD::RET_GLUE t14, Register:i64 $x0, t14:1
;
; The t21 store depends on t19 (via a chain dependency),
; t19 load depends on t9 (via address operand),
; t9 load depends on the t6 store (via chain).
;
; So there is a ordering dependency between the two stores, even if it can't
; be found by only following chain dependencies. Neither can it be found by
; scanning from all merge candidates when only considering the non-chain
; operands as a starting point for the scan (as
; checkMergeStoreCandidatesForDependencies used to do).
;
; This test case validates that ISel is a success, and that no store merge is
; performed.

%str0 = type { i64, i64 }
%str1 = type { i64, ptr }

@g0 = external global %str0, align 1

define i64 @foo() {
; CHECK-LABEL: foo:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    adrp x8, :got:g0
; CHECK-NEXT:    ldr x8, [x8, :got_lo12:g0]
; CHECK-NEXT:    ldr x9, [x8]
; CHECK-NEXT:    str xzr, [x8, #8]
; CHECK-NEXT:    ldr x9, [x9, #8]
; CHECK-NEXT:    ldr x0, [x9]
; CHECK-NEXT:    str xzr, [x8]
; CHECK-NEXT:    ret
entry:
  %sp1 = getelementptr inbounds %str0, ptr @g0, i32 0, i32 1
  store i64 0, ptr %sp1, align 1, !tbaa !1
  %l0 = load ptr, ptr undef, align 1
  %lp0 = getelementptr inbounds %str1, ptr %l0, i32 0, i32 1
  %l1 = load ptr, ptr %lp0, align 1
  %l2 = load i64, ptr %l1, align 1, !tbaa !7
  store i64 0, ptr @g0, align 1
  ret i64 %l2
}

!llvm.ident = !{!0}

!0 = !{!"clang version 14.0.0.prerel"}
!1 = !{!2, !6, i16 1}
!2 = !{!"dinges", !3, i16 0, !6, i16 1}
!3 = !{!"int", !4, i16 0}
!4 = !{!"omnipotent char", !5, i16 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!"any pointer", !4, i16 0}
!7 = !{!2, !3, i16 0}
