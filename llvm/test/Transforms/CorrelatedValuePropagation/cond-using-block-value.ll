; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes=correlated-propagation < %s | FileCheck %s

declare void @use(i1)

define void @test_icmp_from_implied_cond(i32 %a, i32 %b) {
; CHECK-LABEL: define void @test_icmp_from_implied_cond(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:    [[A_CMP:%.*]] = icmp ugt i32 [[A]], 32
; CHECK-NEXT:    br i1 [[A_CMP]], label [[END:%.*]], label [[L1:%.*]]
; CHECK:       l1:
; CHECK-NEXT:    [[COND:%.*]] = icmp ult i32 [[B]], [[A]]
; CHECK-NEXT:    br i1 [[COND]], label [[L2:%.*]], label [[END]]
; CHECK:       l2:
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[B_CMP2:%.*]] = icmp ult i32 [[B]], 31
; CHECK-NEXT:    call void @use(i1 [[B_CMP2]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %a.cmp = icmp ugt i32 %a, 32
  br i1 %a.cmp, label %end, label %l1

l1:
  %cond = icmp ult i32 %b, %a
  br i1 %cond, label %l2, label %end

l2:
  %b.cmp1 = icmp ult i32 %b, 32
  call void @use(i1 %b.cmp1)
  %b.cmp2 = icmp ult i32 %b, 31
  call void @use(i1 %b.cmp2)
  ret void

end:
  ret void
}

define i64 @test_sext_from_implied_cond(i32 %a, i32 %b) {
; CHECK-LABEL: define i64 @test_sext_from_implied_cond(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:    [[A_CMP:%.*]] = icmp slt i32 [[A]], 0
; CHECK-NEXT:    br i1 [[A_CMP]], label [[END:%.*]], label [[L1:%.*]]
; CHECK:       l1:
; CHECK-NEXT:    [[COND:%.*]] = icmp ult i32 [[B]], [[A]]
; CHECK-NEXT:    br i1 [[COND]], label [[L2:%.*]], label [[END]]
; CHECK:       l2:
; CHECK-NEXT:    [[SEXT:%.*]] = zext nneg i32 [[B]] to i64
; CHECK-NEXT:    ret i64 [[SEXT]]
; CHECK:       end:
; CHECK-NEXT:    ret i64 0
;
  %a.cmp = icmp slt i32 %a, 0
  br i1 %a.cmp, label %end, label %l1

l1:
  %cond = icmp ult i32 %b, %a
  br i1 %cond, label %l2, label %end

l2:
  %sext = sext i32 %b to i64
  ret i64 %sext

end:
  ret i64 0
}

define void @test_icmp_from_implied_range(i16 %x, i32 %b) {
; CHECK-LABEL: define void @test_icmp_from_implied_range(
; CHECK-SAME: i16 [[X:%.*]], i32 [[B:%.*]]) {
; CHECK-NEXT:    [[A:%.*]] = zext i16 [[X]] to i32
; CHECK-NEXT:    [[COND:%.*]] = icmp ult i32 [[B]], [[A]]
; CHECK-NEXT:    br i1 [[COND]], label [[L1:%.*]], label [[END:%.*]]
; CHECK:       l1:
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    [[B_CMP2:%.*]] = icmp ult i32 [[B]], 65534
; CHECK-NEXT:    call void @use(i1 [[B_CMP2]])
; CHECK-NEXT:    ret void
; CHECK:       end:
; CHECK-NEXT:    ret void
;
  %a = zext i16 %x to i32
  %cond = icmp ult i32 %b, %a
  br i1 %cond, label %l1, label %end

l1:
  %b.cmp1 = icmp ult i32 %b, 65535
  call void @use(i1 %b.cmp1)
  %b.cmp2 = icmp ult i32 %b, 65534
  call void @use(i1 %b.cmp2)
  ret void

end:
  ret void
}
