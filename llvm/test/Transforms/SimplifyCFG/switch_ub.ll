; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=simplifycfg -simplifycfg-require-and-preserve-domtree=1 -S | FileCheck %s

declare void @foo_01()
declare void @foo_02()
declare void @foo_03()

define i32 @test_01(ptr %p, i32 %x, i1 %cond) {
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[BB:%.*]], label [[COMMON_RET:%.*]]
; CHECK:       common.ret:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i32 [ [[R:%.*]], [[BB]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[COMMON_RET_OP]]
; CHECK:       bb:
; CHECK-NEXT:    [[R]] = load i32, ptr [[P:%.*]], align 4
; CHECK-NEXT:    br label [[COMMON_RET]]
;
entry:
  br i1 %cond, label %bb, label %pred

pred:
  switch i32 %x, label %other_succ [i32 42, label %bb
  i32 123456, label %bb
  i32 -654321, label %bb]

bb:
  %phi = phi ptr [null, %pred], [null, %pred], [null, %pred], [%p, %entry]
  %r = load i32, ptr %phi
  ret i32 %r

other_succ:
  ret i32 0
}

define i32 @test_02(ptr %p, i32 %x, i1 %cond) {
; CHECK-LABEL: @test_02(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[BB:%.*]], label [[COMMON_RET:%.*]]
; CHECK:       common.ret:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i32 [ [[R:%.*]], [[BB]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    ret i32 [[COMMON_RET_OP]]
; CHECK:       bb:
; CHECK-NEXT:    [[R]] = load i32, ptr [[P:%.*]], align 4
; CHECK-NEXT:    br label [[COMMON_RET]]
;
entry:
  br i1 %cond, label %bb, label %pred

pred:
  switch i32 %x, label %bb [i32 42, label %other_succ
  i32 123456, label %other_succ
  i32 -654321, label %other_succ]

bb:
  %phi = phi ptr [null, %pred], [%p, %entry]
  %r = load i32, ptr %phi
  ret i32 %r

other_succ:
  ret i32 0
}

define i32 @test_03(ptr %p, i32 %x, i1 %cond) {
; CHECK-LABEL: @test_03(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[BB:%.*]], label [[PRED:%.*]]
; CHECK:       pred:
; CHECK-NEXT:    switch i32 [[X:%.*]], label [[UNREACHABLE:%.*]] [
; CHECK-NEXT:      i32 42, label [[COMMON_RET:%.*]]
; CHECK-NEXT:      i32 123456, label [[COMMON_RET]]
; CHECK-NEXT:      i32 -654321, label [[COMMON_RET]]
; CHECK-NEXT:      i32 1, label [[DO_1:%.*]]
; CHECK-NEXT:      i32 2, label [[DO_2:%.*]]
; CHECK-NEXT:      i32 3, label [[DO_3:%.*]]
; CHECK-NEXT:    ]
; CHECK:       common.ret:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i32 [ [[R:%.*]], [[BB]] ], [ 1, [[DO_1]] ], [ 1, [[DO_2]] ], [ 1, [[DO_3]] ], [ 0, [[PRED]] ], [ 0, [[PRED]] ], [ 0, [[PRED]] ]
; CHECK-NEXT:    ret i32 [[COMMON_RET_OP]]
; CHECK:       unreachable:
; CHECK-NEXT:    unreachable
; CHECK:       bb:
; CHECK-NEXT:    [[R]] = load i32, ptr [[P:%.*]], align 4
; CHECK-NEXT:    br label [[COMMON_RET]]
; CHECK:       do_1:
; CHECK-NEXT:    call void @foo_01()
; CHECK-NEXT:    br label [[COMMON_RET]]
; CHECK:       do_2:
; CHECK-NEXT:    call void @foo_02()
; CHECK-NEXT:    br label [[COMMON_RET]]
; CHECK:       do_3:
; CHECK-NEXT:    call void @foo_03()
; CHECK-NEXT:    br label [[COMMON_RET]]
;
entry:
  br i1 %cond, label %bb, label %pred

pred:
  switch i32 %x, label %bb [i32 42, label %other_succ
  i32 123456, label %other_succ
  i32 -654321, label %other_succ
  i32 1, label %do_1
  i32 2, label %do_2
  i32 3, label %do_3]

bb:
  %phi = phi ptr [null, %pred], [%p, %entry]
  %r = load i32, ptr %phi
  ret i32 %r

do_1:
  call void @foo_01()
  ret i32 1

do_2:
  call void @foo_02()
  ret i32 1

do_3:
  call void @foo_03()
  ret i32 1

other_succ:
  ret i32 0
}

define i32 @test_04(ptr %p, i32 %x, i1 %cond) {
; CHECK-LABEL: @test_04(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[BB:%.*]], label [[PRED:%.*]]
; CHECK:       pred:
; CHECK-NEXT:    switch i32 [[X:%.*]], label [[COMMON_RET:%.*]] [
; CHECK-NEXT:      i32 3, label [[DO_3:%.*]]
; CHECK-NEXT:      i32 2, label [[DO_2:%.*]]
; CHECK-NEXT:      i32 1, label [[DO_1:%.*]]
; CHECK-NEXT:    ]
; CHECK:       common.ret:
; CHECK-NEXT:    [[COMMON_RET_OP:%.*]] = phi i32 [ [[R:%.*]], [[BB]] ], [ 1, [[DO_1]] ], [ 1, [[DO_2]] ], [ 1, [[DO_3]] ], [ 0, [[PRED]] ]
; CHECK-NEXT:    ret i32 [[COMMON_RET_OP]]
; CHECK:       bb:
; CHECK-NEXT:    [[R]] = load i32, ptr [[P:%.*]], align 4
; CHECK-NEXT:    br label [[COMMON_RET]]
; CHECK:       do_1:
; CHECK-NEXT:    call void @foo_01()
; CHECK-NEXT:    br label [[COMMON_RET]]
; CHECK:       do_2:
; CHECK-NEXT:    call void @foo_02()
; CHECK-NEXT:    br label [[COMMON_RET]]
; CHECK:       do_3:
; CHECK-NEXT:    call void @foo_03()
; CHECK-NEXT:    br label [[COMMON_RET]]
;
entry:
  br i1 %cond, label %bb, label %pred

pred:
  switch i32 %x, label %other_succ [i32 42, label %bb
  i32 123456, label %bb
  i32 -654321, label %bb
  i32 1, label %do_1
  i32 2, label %do_2
  i32 3, label %do_3]

bb:
  %phi = phi ptr [null, %pred], [null, %pred], [null, %pred], [%p, %entry]
  %r = load i32, ptr %phi
  ret i32 %r

do_1:
  call void @foo_01()
  ret i32 1

do_2:
  call void @foo_02()
  ret i32 1

do_3:
  call void @foo_03()
  ret i32 1

other_succ:
  ret i32 0
}
