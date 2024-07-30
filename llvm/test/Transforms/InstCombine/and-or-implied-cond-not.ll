; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define i1 @test_imply_not1(i32 %depth) {
; CHECK-LABEL: define i1 @test_imply_not1(
; CHECK-SAME: i32 [[DEPTH:%.*]]) {
; CHECK-NEXT:    [[CMP1_NOT1:%.*]] = icmp eq i32 [[DEPTH]], 16
; CHECK-NEXT:    call void @use(i1 [[CMP1_NOT1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp slt i32 [[DEPTH]], 8
; CHECK-NEXT:    call void @use(i1 [[CMP2]])
; CHECK-NEXT:    br i1 [[CMP1_NOT1]], label [[IF_ELSE:%.*]], label [[IF_THEN:%.*]]
; CHECK:       if.then:
; CHECK-NEXT:    call void @func1()
; CHECK-NEXT:    unreachable
; CHECK:       if.else:
; CHECK-NEXT:    call void @func2()
; CHECK-NEXT:    unreachable
;
  %cmp1 = icmp eq i32 %depth, 16
  call void @use(i1 %cmp1)
  %cmp2 = icmp slt i32 %depth, 8
  call void @use(i1 %cmp2)
  %cmp.not = xor i1 %cmp1, true
  %brmerge = or i1 %cmp2, %cmp.not
  br i1 %brmerge, label %if.then, label %if.else
if.then:
  call void @func1()
  unreachable

if.else:
  call void @func2()
  unreachable
}

define i1 @test_imply_not2(i32 %a, i1 %cmp2) {
; CHECK-LABEL: define i1 @test_imply_not2(
; CHECK-SAME: i32 [[A:%.*]], i1 [[CMP2:%.*]]) {
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ne i32 [[A]], 0
; CHECK-NEXT:    [[BRMERGE:%.*]] = select i1 [[CMP1]], i1 true, i1 [[CMP2]]
; CHECK-NEXT:    ret i1 [[BRMERGE]]
;
  %cmp1 = icmp eq i32 %a, 0
  %or.cond = select i1 %cmp1, i1 %cmp2, i1 false
  %cmp.not = xor i1 %cmp1, true
  %brmerge = or i1 %or.cond, %cmp.not
  ret i1 %brmerge
}

define i1 @test_imply_not3(i32 %a, i32 %b, i1 %cond) {
; CHECK-LABEL: define i1 @test_imply_not3(
; CHECK-SAME: i32 [[A:%.*]], i32 [[B:%.*]], i1 [[COND:%.*]]) {
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i32 [[A]], [[B]]
; CHECK-NEXT:    call void @use(i1 [[CMP1]])
; CHECK-NEXT:    [[CMP2:%.*]] = icmp slt i32 [[A]], [[B]]
; CHECK-NEXT:    [[AND:%.*]] = select i1 [[CMP2]], i1 [[COND]], i1 false
; CHECK-NEXT:    ret i1 [[AND]]
;
  %cmp1 = icmp eq i32 %a, %b
  call void @use(i1 %cmp1)
  %cmp2 = icmp slt i32 %a, %b
  %cmp.not = xor i1 %cmp1, true
  %sel = select i1 %cmp.not, i1 %cond, i1 false
  %and = and i1 %cmp2, %sel
  ret i1 %and
}

declare void @func1()
declare void @func2()
declare void @use(i1)
