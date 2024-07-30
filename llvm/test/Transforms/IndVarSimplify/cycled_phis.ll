; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=indvars -S | FileCheck %s

declare void @fail(i32)
declare i1 @cond()
declare i32 @switch.cond()
declare i32 @llvm.smax.i32(i32 %a, i32 %b)

; Unsigned comparison here is redundant and can be safely deleted.
define i32 @trivial.case(ptr %len.ptr) {
; CHECK-LABEL: @trivial.case(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[LEN_PTR:%.*]], align 4, !range [[RNG0:![0-9]+]]
; CHECK-NEXT:    br label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ 0, [[PREHEADER]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIGNED_CMP:%.*]] = icmp ult i32 [[IV]], [[LEN]]
; CHECK-NEXT:    br i1 [[SIGNED_CMP]], label [[SIGNED_PASSED:%.*]], label [[FAILED_SIGNED:%.*]]
; CHECK:       signed.passed:
; CHECK-NEXT:    br i1 true, label [[BACKEDGE]], label [[FAILED_UNSIGNED:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[COND]], label [[LOOP]], label [[DONE:%.*]]
; CHECK:       failed.signed:
; CHECK-NEXT:    call void @fail(i32 1)
; CHECK-NEXT:    unreachable
; CHECK:       failed.unsigned:
; CHECK-NEXT:    call void @fail(i32 2)
; CHECK-NEXT:    unreachable
; CHECK:       done:
; CHECK-NEXT:    [[IV_LCSSA2:%.*]] = phi i32 [ [[IV]], [[BACKEDGE]] ]
; CHECK-NEXT:    ret i32 [[IV_LCSSA2]]
;
entry:
  %len = load i32, ptr %len.ptr, !range !0
  br label %preheader

preheader:
  br label %loop

loop:
  %iv = phi i32 [0, %preheader], [%iv.next, %backedge]
  %signed.cmp = icmp slt i32 %iv, %len
  br i1 %signed.cmp, label %signed.passed, label %failed.signed

signed.passed:
  %unsigned.cmp = icmp ult i32 %iv, %len
  br i1 %unsigned.cmp, label %backedge, label %failed.unsigned

backedge:
  %iv.next = add i32 %iv, 1
  %cond = call i1 @cond()
  br i1 %cond, label %loop, label %done

failed.signed:
  call void @fail(i32 1)
  unreachable

failed.unsigned:
  call void @fail(i32 2)
  unreachable

done:
  ret i32 %iv
}

; TODO: The 2nd check can be made invariant.
; slt and ult checks are equivalent. When IV is negative, slt check will pass and ult will
; fail. Because IV is incrementing, this will fail on 1st iteration or never.
define i32 @unknown.start(i32 %start, ptr %len.ptr) {
; CHECK-LABEL: @unknown.start(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[LEN_PTR:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    br label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[START:%.*]], [[PREHEADER]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIGNED_CMP:%.*]] = icmp slt i32 [[IV]], [[LEN]]
; CHECK-NEXT:    br i1 [[SIGNED_CMP]], label [[SIGNED_PASSED:%.*]], label [[FAILED_SIGNED:%.*]]
; CHECK:       signed.passed:
; CHECK-NEXT:    [[UNSIGNED_CMP:%.*]] = icmp ult i32 [[IV]], [[LEN]]
; CHECK-NEXT:    br i1 [[UNSIGNED_CMP]], label [[BACKEDGE]], label [[FAILED_UNSIGNED:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[COND]], label [[LOOP]], label [[DONE:%.*]]
; CHECK:       failed.signed:
; CHECK-NEXT:    call void @fail(i32 1)
; CHECK-NEXT:    unreachable
; CHECK:       failed.unsigned:
; CHECK-NEXT:    call void @fail(i32 2)
; CHECK-NEXT:    unreachable
; CHECK:       done:
; CHECK-NEXT:    [[IV_LCSSA2:%.*]] = phi i32 [ [[IV]], [[BACKEDGE]] ]
; CHECK-NEXT:    ret i32 [[IV_LCSSA2]]
;
entry:
  %len = load i32, ptr %len.ptr, !range !0
  br label %preheader

preheader:
  br label %loop

loop:
  %iv = phi i32 [%start, %preheader], [%iv.next, %backedge]
  %signed.cmp = icmp slt i32 %iv, %len
  br i1 %signed.cmp, label %signed.passed, label %failed.signed

signed.passed:
  %unsigned.cmp = icmp ult i32 %iv, %len
  br i1 %unsigned.cmp, label %backedge, label %failed.unsigned

backedge:
  %iv.next = add i32 %iv, 1
  %cond = call i1 @cond()
  br i1 %cond, label %loop, label %done

failed.signed:
  call void @fail(i32 1)
  unreachable

failed.unsigned:
  call void @fail(i32 2)
  unreachable

done:
  ret i32 %iv
}


; TODO: We should be able to prove that:
; - %sibling.iv.next is non-negative;
; - therefore, %iv is non-negative;
; - therefore, unsigned check can be removed.
define i32 @start.from.sibling.iv(ptr %len.ptr, ptr %sibling.len.ptr) {
; CHECK-LABEL: @start.from.sibling.iv(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[LEN_PTR:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[SIBLING_LEN:%.*]] = load i32, ptr [[SIBLING_LEN_PTR:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    br label [[SIBLING_LOOP:%.*]]
; CHECK:       sibling.loop:
; CHECK-NEXT:    [[SIBLING_IV:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[SIBLING_IV_NEXT:%.*]], [[SIBLING_BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIBLING_RC:%.*]] = icmp ult i32 [[SIBLING_IV]], [[SIBLING_LEN]]
; CHECK-NEXT:    br i1 [[SIBLING_RC]], label [[SIBLING_BACKEDGE]], label [[FAILED_SIBLING:%.*]]
; CHECK:       sibling.backedge:
; CHECK-NEXT:    [[SIBLING_IV_NEXT]] = add nuw nsw i32 [[SIBLING_IV]], 1
; CHECK-NEXT:    [[SIBLING_COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[SIBLING_COND]], label [[SIBLING_LOOP]], label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[SIBLING_IV_NEXT_LCSSA:%.*]] = phi i32 [ [[SIBLING_IV_NEXT]], [[SIBLING_BACKEDGE]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[SIBLING_IV_NEXT_LCSSA]], [[PREHEADER]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIGNED_CMP:%.*]] = icmp slt i32 [[IV]], [[LEN]]
; CHECK-NEXT:    br i1 [[SIGNED_CMP]], label [[SIGNED_PASSED:%.*]], label [[FAILED_SIGNED:%.*]]
; CHECK:       signed.passed:
; CHECK-NEXT:    [[UNSIGNED_CMP:%.*]] = icmp ult i32 [[IV]], [[LEN]]
; CHECK-NEXT:    br i1 [[UNSIGNED_CMP]], label [[BACKEDGE]], label [[FAILED_UNSIGNED:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[COND]], label [[LOOP]], label [[DONE:%.*]]
; CHECK:       failed.signed:
; CHECK-NEXT:    call void @fail(i32 1)
; CHECK-NEXT:    unreachable
; CHECK:       failed.unsigned:
; CHECK-NEXT:    call void @fail(i32 2)
; CHECK-NEXT:    unreachable
; CHECK:       failed.sibling:
; CHECK-NEXT:    call void @fail(i32 3)
; CHECK-NEXT:    unreachable
; CHECK:       done:
; CHECK-NEXT:    [[IV_LCSSA2:%.*]] = phi i32 [ [[IV]], [[BACKEDGE]] ]
; CHECK-NEXT:    ret i32 [[IV_LCSSA2]]
;
entry:
  %len = load i32, ptr %len.ptr, !range !0
  %sibling.len = load i32, ptr %sibling.len.ptr, !range !0
  br label %sibling.loop

sibling.loop:
  %sibling.iv = phi i32 [0, %entry], [%sibling.iv.next, %sibling.backedge]
  %sibling.rc = icmp ult i32 %sibling.iv, %sibling.len
  br i1 %sibling.rc, label %sibling.backedge, label %failed.sibling

sibling.backedge:
  %sibling.iv.next = add nuw nsw i32 %sibling.iv, 1
  %sibling.cond = call i1 @cond()
  br i1 %sibling.cond, label %sibling.loop, label %preheader

preheader:
  br label %loop

loop:
  %iv = phi i32 [%sibling.iv.next, %preheader], [%iv.next, %backedge]
  %signed.cmp = icmp slt i32 %iv, %len
  br i1 %signed.cmp, label %signed.passed, label %failed.signed

signed.passed:
  %unsigned.cmp = icmp ult i32 %iv, %len
  br i1 %unsigned.cmp, label %backedge, label %failed.unsigned

backedge:
  %iv.next = add i32 %iv, 1
  %cond = call i1 @cond()
  br i1 %cond, label %loop, label %done

failed.signed:
  call void @fail(i32 1)
  unreachable

failed.unsigned:
  call void @fail(i32 2)
  unreachable

failed.sibling:
  call void @fail(i32 3)
  unreachable

done:
  ret i32 %iv
}

; Same as above, but the sibling loop is now wide. We can eliminate the unsigned comparison here.
define i32 @start.from.sibling.iv.wide(ptr %len.ptr, ptr %sibling.len.ptr) {
; CHECK-LABEL: @start.from.sibling.iv.wide(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[LEN_PTR:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[SIBLING_LEN:%.*]] = load i32, ptr [[SIBLING_LEN_PTR:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[SIBLING_LEN_WIDE:%.*]] = zext i32 [[SIBLING_LEN]] to i64
; CHECK-NEXT:    br label [[SIBLING_LOOP:%.*]]
; CHECK:       sibling.loop:
; CHECK-NEXT:    [[SIBLING_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[SIBLING_IV_NEXT:%.*]], [[SIBLING_BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIBLING_RC:%.*]] = icmp ult i64 [[SIBLING_IV]], [[SIBLING_LEN_WIDE]]
; CHECK-NEXT:    br i1 [[SIBLING_RC]], label [[SIBLING_BACKEDGE]], label [[FAILED_SIBLING:%.*]]
; CHECK:       sibling.backedge:
; CHECK-NEXT:    [[SIBLING_IV_NEXT]] = add nuw nsw i64 [[SIBLING_IV]], 1
; CHECK-NEXT:    [[SIBLING_COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[SIBLING_COND]], label [[SIBLING_LOOP]], label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    [[SIBLING_IV_NEXT_LCSSA:%.*]] = phi i64 [ [[SIBLING_IV_NEXT]], [[SIBLING_BACKEDGE]] ]
; CHECK-NEXT:    [[SIBLING_IV_NEXT_TRUNC:%.*]] = trunc i64 [[SIBLING_IV_NEXT_LCSSA]] to i32
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[SIBLING_IV_NEXT_TRUNC]], [[PREHEADER]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIGNED_CMP:%.*]] = icmp ult i32 [[IV]], [[LEN]]
; CHECK-NEXT:    br i1 [[SIGNED_CMP]], label [[SIGNED_PASSED:%.*]], label [[FAILED_SIGNED:%.*]]
; CHECK:       signed.passed:
; CHECK-NEXT:    br i1 true, label [[BACKEDGE]], label [[FAILED_UNSIGNED:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[COND]], label [[LOOP]], label [[DONE:%.*]]
; CHECK:       failed.signed:
; CHECK-NEXT:    call void @fail(i32 1)
; CHECK-NEXT:    unreachable
; CHECK:       failed.unsigned:
; CHECK-NEXT:    call void @fail(i32 2)
; CHECK-NEXT:    unreachable
; CHECK:       failed.sibling:
; CHECK-NEXT:    call void @fail(i32 3)
; CHECK-NEXT:    unreachable
; CHECK:       done:
; CHECK-NEXT:    [[IV_LCSSA2:%.*]] = phi i32 [ [[IV]], [[BACKEDGE]] ]
; CHECK-NEXT:    ret i32 [[IV_LCSSA2]]
;
entry:
  %len = load i32, ptr %len.ptr, !range !0
  %sibling.len = load i32, ptr %sibling.len.ptr, !range !0
  %sibling.len.wide = zext i32 %sibling.len to i64
  br label %sibling.loop

sibling.loop:
  %sibling.iv = phi i64 [0, %entry], [%sibling.iv.next, %sibling.backedge]
  %sibling.rc = icmp ult i64 %sibling.iv, %sibling.len.wide
  br i1 %sibling.rc, label %sibling.backedge, label %failed.sibling

sibling.backedge:
  %sibling.iv.next = add nuw nsw i64 %sibling.iv, 1
  %sibling.cond = call i1 @cond()
  br i1 %sibling.cond, label %sibling.loop, label %preheader

preheader:
  %sibling.iv.next.trunc = trunc i64 %sibling.iv.next to i32
  br label %loop

loop:
  %iv = phi i32 [%sibling.iv.next.trunc, %preheader], [%iv.next, %backedge]
  %signed.cmp = icmp slt i32 %iv, %len
  br i1 %signed.cmp, label %signed.passed, label %failed.signed

signed.passed:
  %unsigned.cmp = icmp ult i32 %iv, %len
  br i1 %unsigned.cmp, label %backedge, label %failed.unsigned

backedge:
  %iv.next = add i32 %iv, 1
  %cond = call i1 @cond()
  br i1 %cond, label %loop, label %done

failed.signed:
  call void @fail(i32 1)
  unreachable

failed.unsigned:
  call void @fail(i32 2)
  unreachable

failed.sibling:
  call void @fail(i32 3)
  unreachable

done:
  ret i32 %iv
}

; Slightly more complex version of previous one (cycled phis).
; TODO: remove unsigned comparison by proving non-negativity of iv.start.
; TODO: When we check against IV_START, for some reason we then cannot infer nuw for IV.next.
;       It was possible while checking against IV. Missing inference logic somewhere.
define i32 @start.from.sibling.iv.wide.cycled.phis(ptr %len.ptr, ptr %sibling.len.ptr) {
; CHECK-LABEL: @start.from.sibling.iv.wide.cycled.phis(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[LEN_PTR:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[SIBLING_LEN:%.*]] = load i32, ptr [[SIBLING_LEN_PTR:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[SIBLING_LEN_WIDE:%.*]] = zext i32 [[SIBLING_LEN]] to i64
; CHECK-NEXT:    br label [[SIBLING_LOOP:%.*]]
; CHECK:       sibling.loop:
; CHECK-NEXT:    [[SIBLING_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[SIBLING_IV_NEXT:%.*]], [[SIBLING_BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIBLING_RC:%.*]] = icmp ult i64 [[SIBLING_IV]], [[SIBLING_LEN_WIDE]]
; CHECK-NEXT:    br i1 [[SIBLING_RC]], label [[SIBLING_BACKEDGE]], label [[FAILED_SIBLING:%.*]]
; CHECK:       sibling.backedge:
; CHECK-NEXT:    [[SIBLING_IV_NEXT]] = add nuw nsw i64 [[SIBLING_IV]], 1
; CHECK-NEXT:    [[SIBLING_COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[SIBLING_COND]], label [[SIBLING_LOOP]], label [[OUTER_LOOP_PREHEADER:%.*]]
; CHECK:       outer.loop.preheader:
; CHECK-NEXT:    [[SIBLING_IV_NEXT_LCSSA:%.*]] = phi i64 [ [[SIBLING_IV_NEXT]], [[SIBLING_BACKEDGE]] ]
; CHECK-NEXT:    [[SIBLING_IV_NEXT_TRUNC:%.*]] = trunc i64 [[SIBLING_IV_NEXT_LCSSA]] to i32
; CHECK-NEXT:    br label [[OUTER_LOOP:%.*]]
; CHECK:       outer.loop:
; CHECK-NEXT:    [[IV_START:%.*]] = phi i32 [ [[SIBLING_IV_NEXT_TRUNC]], [[OUTER_LOOP_PREHEADER]] ], [ [[IV_NEXT_LCSSA:%.*]], [[OUTER_LOOP_BACKEDGE:%.*]] ]
; CHECK-NEXT:    br label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[IV_START]], [[PREHEADER]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIGNED_CMP:%.*]] = icmp slt i32 [[IV]], [[LEN]]
; CHECK-NEXT:    br i1 [[SIGNED_CMP]], label [[SIGNED_PASSED:%.*]], label [[FAILED_SIGNED:%.*]]
; CHECK:       signed.passed:
; CHECK-NEXT:    [[UNSIGNED_CMP:%.*]] = icmp ult i32 [[IV_START]], [[LEN]]
; CHECK-NEXT:    br i1 [[UNSIGNED_CMP]], label [[BACKEDGE]], label [[FAILED_UNSIGNED:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV_NEXT]] = add nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[COND]], label [[LOOP]], label [[OUTER_LOOP_BACKEDGE]]
; CHECK:       outer.loop.backedge:
; CHECK-NEXT:    [[IV_NEXT_LCSSA]] = phi i32 [ [[IV_NEXT]], [[BACKEDGE]] ]
; CHECK-NEXT:    [[IV_LCSSA2:%.*]] = phi i32 [ [[IV]], [[BACKEDGE]] ]
; CHECK-NEXT:    [[OUTER_COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[OUTER_COND]], label [[OUTER_LOOP]], label [[DONE:%.*]]
; CHECK:       failed.signed:
; CHECK-NEXT:    call void @fail(i32 1)
; CHECK-NEXT:    unreachable
; CHECK:       failed.unsigned:
; CHECK-NEXT:    call void @fail(i32 2)
; CHECK-NEXT:    unreachable
; CHECK:       failed.sibling:
; CHECK-NEXT:    call void @fail(i32 3)
; CHECK-NEXT:    unreachable
; CHECK:       done:
; CHECK-NEXT:    [[IV_LCSSA2_LCSSA:%.*]] = phi i32 [ [[IV_LCSSA2]], [[OUTER_LOOP_BACKEDGE]] ]
; CHECK-NEXT:    ret i32 [[IV_LCSSA2_LCSSA]]
;
entry:
  %len = load i32, ptr %len.ptr, !range !0
  %sibling.len = load i32, ptr %sibling.len.ptr, !range !0
  %sibling.len.wide = zext i32 %sibling.len to i64
  br label %sibling.loop

sibling.loop:
  %sibling.iv = phi i64 [0, %entry], [%sibling.iv.next, %sibling.backedge]
  %sibling.rc = icmp ult i64 %sibling.iv, %sibling.len.wide
  br i1 %sibling.rc, label %sibling.backedge, label %failed.sibling

sibling.backedge:
  %sibling.iv.next = add nuw nsw i64 %sibling.iv, 1
  %sibling.cond = call i1 @cond()
  br i1 %sibling.cond, label %sibling.loop, label %outer.loop.preheader

outer.loop.preheader:
  %sibling.iv.next.trunc = trunc i64 %sibling.iv.next to i32
  br label %outer.loop

outer.loop:
  %iv.start = phi i32 [%sibling.iv.next.trunc, %outer.loop.preheader], [%iv.next, %outer.loop.backedge]
  br label %preheader

preheader:
  br label %loop

loop:
  %iv = phi i32 [%iv.start, %preheader], [%iv.next, %backedge]
  %signed.cmp = icmp slt i32 %iv, %len
  br i1 %signed.cmp, label %signed.passed, label %failed.signed

signed.passed:
  %unsigned.cmp = icmp ult i32 %iv, %len
  br i1 %unsigned.cmp, label %backedge, label %failed.unsigned

backedge:
  %iv.next = add i32 %iv, 1
  %cond = call i1 @cond()
  br i1 %cond, label %loop, label %outer.loop.backedge


outer.loop.backedge:
  %outer.cond = call i1 @cond()
  br i1 %outer.cond, label %outer.loop, label %done

failed.signed:
  call void @fail(i32 1)
  unreachable

failed.unsigned:
  call void @fail(i32 2)
  unreachable

failed.sibling:
  call void @fail(i32 3)
  unreachable

done:
  ret i32 %iv
}


; Even more complex version of previous one (more sophisticated cycled phis).
; TODO: remove unsigned comparison by proving non-negativity of iv.start.
define i32 @start.from.sibling.iv.wide.cycled.phis.complex.phis(ptr %len.ptr, ptr %sibling.len.ptr, i32 %some.random.value) {
; CHECK-LABEL: @start.from.sibling.iv.wide.cycled.phis.complex.phis(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LEN:%.*]] = load i32, ptr [[LEN_PTR:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[SIBLING_LEN:%.*]] = load i32, ptr [[SIBLING_LEN_PTR:%.*]], align 4, !range [[RNG0]]
; CHECK-NEXT:    [[SIBLING_LEN_WIDE:%.*]] = zext i32 [[SIBLING_LEN]] to i64
; CHECK-NEXT:    br label [[SIBLING_LOOP:%.*]]
; CHECK:       sibling.loop:
; CHECK-NEXT:    [[SIBLING_IV:%.*]] = phi i64 [ 0, [[ENTRY:%.*]] ], [ [[SIBLING_IV_NEXT:%.*]], [[SIBLING_BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIBLING_RC:%.*]] = icmp ult i64 [[SIBLING_IV]], [[SIBLING_LEN_WIDE]]
; CHECK-NEXT:    br i1 [[SIBLING_RC]], label [[SIBLING_BACKEDGE]], label [[FAILED_SIBLING:%.*]]
; CHECK:       sibling.backedge:
; CHECK-NEXT:    [[SIBLING_IV_NEXT]] = add nuw nsw i64 [[SIBLING_IV]], 1
; CHECK-NEXT:    [[SIBLING_COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[SIBLING_COND]], label [[SIBLING_LOOP]], label [[OUTER_LOOP_PREHEADER:%.*]]
; CHECK:       outer.loop.preheader:
; CHECK-NEXT:    [[SIBLING_IV_NEXT_LCSSA:%.*]] = phi i64 [ [[SIBLING_IV_NEXT]], [[SIBLING_BACKEDGE]] ]
; CHECK-NEXT:    [[SIBLING_IV_NEXT_TRUNC:%.*]] = trunc i64 [[SIBLING_IV_NEXT_LCSSA]] to i32
; CHECK-NEXT:    br label [[OUTER_LOOP:%.*]]
; CHECK:       outer.loop:
; CHECK-NEXT:    [[IV_START:%.*]] = phi i32 [ [[SIBLING_IV_NEXT_TRUNC]], [[OUTER_LOOP_PREHEADER]] ], [ [[IV_START_UPDATED:%.*]], [[OUTER_LOOP_BACKEDGE:%.*]] ]
; CHECK-NEXT:    br label [[PREHEADER:%.*]]
; CHECK:       preheader:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i32 [ [[IV_START]], [[PREHEADER]] ], [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ]
; CHECK-NEXT:    [[SIGNED_CMP:%.*]] = icmp slt i32 [[IV]], [[LEN]]
; CHECK-NEXT:    br i1 [[SIGNED_CMP]], label [[SIGNED_PASSED:%.*]], label [[FAILED_SIGNED:%.*]]
; CHECK:       signed.passed:
; CHECK-NEXT:    [[UNSIGNED_CMP:%.*]] = icmp ult i32 [[IV_START]], [[LEN]]
; CHECK-NEXT:    br i1 [[UNSIGNED_CMP]], label [[BACKEDGE]], label [[FAILED_UNSIGNED:%.*]]
; CHECK:       backedge:
; CHECK-NEXT:    [[IV_NEXT]] = add nsw i32 [[IV]], 1
; CHECK-NEXT:    [[COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[COND]], label [[LOOP]], label [[OUTER_LOOP_SELECTION:%.*]]
; CHECK:       outer.loop.selection:
; CHECK-NEXT:    [[IV_NEXT_LCSSA:%.*]] = phi i32 [ [[IV_NEXT]], [[BACKEDGE]] ]
; CHECK-NEXT:    [[IV_LCSSA2:%.*]] = phi i32 [ [[IV]], [[BACKEDGE]] ]
; CHECK-NEXT:    [[SWITCH_COND:%.*]] = call i32 @switch.cond()
; CHECK-NEXT:    switch i32 [[SWITCH_COND]], label [[TAKE_SAME:%.*]] [
; CHECK-NEXT:      i32 1, label [[TAKE_INCREMENT:%.*]]
; CHECK-NEXT:      i32 2, label [[TAKE_SMAX:%.*]]
; CHECK-NEXT:    ]
; CHECK:       take.same:
; CHECK-NEXT:    br label [[OUTER_LOOP_BACKEDGE]]
; CHECK:       take.increment:
; CHECK-NEXT:    br label [[OUTER_LOOP_BACKEDGE]]
; CHECK:       take.smax:
; CHECK-NEXT:    [[SMAX:%.*]] = call i32 @llvm.smax.i32(i32 [[IV_START]], i32 [[SOME_RANDOM_VALUE:%.*]])
; CHECK-NEXT:    br label [[OUTER_LOOP_BACKEDGE]]
; CHECK:       outer.loop.backedge:
; CHECK-NEXT:    [[IV_START_UPDATED]] = phi i32 [ [[IV_START]], [[TAKE_SAME]] ], [ [[IV_NEXT_LCSSA]], [[TAKE_INCREMENT]] ], [ [[SMAX]], [[TAKE_SMAX]] ]
; CHECK-NEXT:    [[OUTER_COND:%.*]] = call i1 @cond()
; CHECK-NEXT:    br i1 [[OUTER_COND]], label [[OUTER_LOOP]], label [[DONE:%.*]]
; CHECK:       failed.signed:
; CHECK-NEXT:    call void @fail(i32 1)
; CHECK-NEXT:    unreachable
; CHECK:       failed.unsigned:
; CHECK-NEXT:    call void @fail(i32 2)
; CHECK-NEXT:    unreachable
; CHECK:       failed.sibling:
; CHECK-NEXT:    call void @fail(i32 3)
; CHECK-NEXT:    unreachable
; CHECK:       done:
; CHECK-NEXT:    [[IV_LCSSA2_LCSSA:%.*]] = phi i32 [ [[IV_LCSSA2]], [[OUTER_LOOP_BACKEDGE]] ]
; CHECK-NEXT:    ret i32 [[IV_LCSSA2_LCSSA]]
;
entry:
  %len = load i32, ptr %len.ptr, !range !0
  %sibling.len = load i32, ptr %sibling.len.ptr, !range !0
  %sibling.len.wide = zext i32 %sibling.len to i64
  br label %sibling.loop

sibling.loop:
  %sibling.iv = phi i64 [0, %entry], [%sibling.iv.next, %sibling.backedge]
  %sibling.rc = icmp ult i64 %sibling.iv, %sibling.len.wide
  br i1 %sibling.rc, label %sibling.backedge, label %failed.sibling

sibling.backedge:
  %sibling.iv.next = add nuw nsw i64 %sibling.iv, 1
  %sibling.cond = call i1 @cond()
  br i1 %sibling.cond, label %sibling.loop, label %outer.loop.preheader

outer.loop.preheader:
  %sibling.iv.next.trunc = trunc i64 %sibling.iv.next to i32
  br label %outer.loop

outer.loop:
  %iv.start = phi i32 [%sibling.iv.next.trunc, %outer.loop.preheader], [%iv.start.updated, %outer.loop.backedge]
  br label %preheader

preheader:
  br label %loop

loop:
  %iv = phi i32 [%iv.start, %preheader], [%iv.next, %backedge]
  %signed.cmp = icmp slt i32 %iv, %len
  br i1 %signed.cmp, label %signed.passed, label %failed.signed

signed.passed:
  %unsigned.cmp = icmp ult i32 %iv, %len
  br i1 %unsigned.cmp, label %backedge, label %failed.unsigned

backedge:
  %iv.next = add i32 %iv, 1
  %cond = call i1 @cond()
  br i1 %cond, label %loop, label %outer.loop.selection

outer.loop.selection:
  %switch.cond = call i32 @switch.cond()
  switch i32 %switch.cond, label %take.same
  [
  i32 1, label %take.increment
  i32 2, label %take.smax
  ]

take.same:
  br label %outer.loop.backedge

take.increment:
  br label %outer.loop.backedge

take.smax:
  %smax = call i32 @llvm.smax.i32(i32 %iv.start, i32 %some.random.value)
  br label %outer.loop.backedge

outer.loop.backedge:
  %iv.start.updated = phi i32 [%iv.start, %take.same],
  [%iv.next, %take.increment],
  [%smax, %take.smax]
  %outer.cond = call i1 @cond()
  br i1 %outer.cond, label %outer.loop, label %done

failed.signed:
  call void @fail(i32 1)
  unreachable

failed.unsigned:
  call void @fail(i32 2)
  unreachable

failed.sibling:
  call void @fail(i32 3)
  unreachable

done:
  ret i32 %iv
}

!0 = !{ i32 0, i32 2147483646 }
