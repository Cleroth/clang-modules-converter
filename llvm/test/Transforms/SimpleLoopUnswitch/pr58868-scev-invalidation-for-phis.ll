; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes="loop-mssa(loop-deletion,simple-loop-unswitch<nontrivial;trivial>),loop(indvars)" -verify-scev -S %s | FileCheck %s

define void @pr58868(i1 %c.1, ptr %src, ptr %dst) {
; CHECK-LABEL: @pr58868(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C_1:%.*]], label [[ENTRY_SPLIT_US:%.*]], label [[ENTRY_SPLIT:%.*]]
; CHECK:       entry.split.us:
; CHECK-NEXT:    br label [[OUTER_HEADER_US:%.*]]
; CHECK:       outer.header.us:
; CHECK-NEXT:    br label [[OUTER_BB1_US:%.*]]
; CHECK:       outer.bb1.us:
; CHECK-NEXT:    br label [[OUTER_BB2_US:%.*]]
; CHECK:       outer.bb2.us:
; CHECK-NEXT:    [[LV_US:%.*]] = load i16, ptr [[SRC:%.*]], align 1
; CHECK-NEXT:    br i1 true, label [[OUTER_HEADER_LOOPEXIT_US:%.*]], label [[OUTER_BB2_SPLIT_SPLIT_US:%.*]]
; CHECK:       outer.header.loopexit.us:
; CHECK-NEXT:    br label [[OUTER_HEADER_US]]
; CHECK:       outer.bb2.split.split.us:
; CHECK-NEXT:    [[LV_LCSSA_US:%.*]] = phi i16 [ [[LV_US]], [[OUTER_BB2_US]] ]
; CHECK-NEXT:    br label [[OUTER_BB2_SPLIT:%.*]]
; CHECK:       entry.split:
; CHECK-NEXT:    br label [[OUTER_HEADER:%.*]]
; CHECK:       outer.header.loopexit:
; CHECK-NEXT:    unreachable
; CHECK:       outer.header:
; CHECK-NEXT:    br label [[OUTER_BB2:%.*]]
; CHECK:       outer.bb2:
; CHECK-NEXT:    [[LV:%.*]] = load i16, ptr [[SRC]], align 1
; CHECK-NEXT:    br i1 false, label [[OUTER_HEADER_LOOPEXIT:%.*]], label [[OUTER_BB2_SPLIT_SPLIT:%.*]]
; CHECK:       outer.bb2.split.split:
; CHECK-NEXT:    [[LV_LCSSA:%.*]] = phi i16 [ [[LV]], [[OUTER_BB2]] ]
; CHECK-NEXT:    br label [[OUTER_BB2_SPLIT]]
; CHECK:       outer.bb2.split:
; CHECK-NEXT:    [[DOTUS_PHI:%.*]] = phi i16 [ [[LV_LCSSA]], [[OUTER_BB2_SPLIT_SPLIT]] ], [ [[LV_LCSSA_US]], [[OUTER_BB2_SPLIT_SPLIT_US]] ]
; CHECK-NEXT:    br label [[INNER_HEADER:%.*]]
; CHECK:       inner.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i16 [ [[DOTUS_PHI]], [[OUTER_BB2_SPLIT]] ], [ [[IV_NEXT:%.*]], [[INNER_LATCH:%.*]] ]
; CHECK-NEXT:    br label [[INNER_LATCH]]
; CHECK:       inner.latch:
; CHECK-NEXT:    [[IV_NEXT]] = add nsw i16 [[IV]], 1
; CHECK-NEXT:    store i16 0, ptr [[DST:%.*]], align 1
; CHECK-NEXT:    [[C_2:%.*]] = icmp ne i16 [[IV]], 0
; CHECK-NEXT:    br i1 [[C_2]], label [[INNER_HEADER]], label [[EXIT:%.*]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %outer.header

outer.header:
  br i1 %c.1, label %outer.bb1, label %outer.bb2

outer.bb1:
  br label %outer.bb2

outer.bb2:
  %lv = load i16, ptr %src, align 1
  br label %inner.header

inner.header:
  %iv = phi i16 [ %lv, %outer.bb2 ], [ %iv.next, %inner.latch ]
  br i1 %c.1, label %outer.header, label %inner.latch

inner.latch:
  %iv.next = add nsw i16 %iv, 1
  store i16 0, ptr %dst, align 1
  %c.2 = icmp ne i16 %iv, 0
  br i1 %c.2, label %inner.header, label %exit

exit:
  ret void
}
