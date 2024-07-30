; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define ptr @test1a(ptr %p, ptr %q) {
; CHECK-LABEL: @test1a(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt ptr [[P:%.*]], [[Q:%.*]]
; CHECK-NEXT:    [[SELECT_V:%.*]] = select i1 [[CMP]], ptr [[P]], ptr [[Q]]
; CHECK-NEXT:    [[SELECT:%.*]] = getelementptr i8, ptr [[SELECT_V]], i64 16
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr i32, ptr %p, i64 4
  %gep2 = getelementptr i32, ptr %q, i64 4
  %cmp = icmp ugt ptr %p, %q
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

define ptr @test1b(ptr %p, ptr %q) {
; CHECK-LABEL: @test1b(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt ptr [[P:%.*]], [[Q:%.*]]
; CHECK-NEXT:    [[SELECT_V:%.*]] = select i1 [[CMP]], ptr [[P]], ptr [[Q]]
; CHECK-NEXT:    [[SELECT:%.*]] = getelementptr i8, ptr [[SELECT_V]], i64 16
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr inbounds i32, ptr %p, i64 4
  %gep2 = getelementptr i32, ptr %q, i64 4
  %cmp = icmp ugt ptr %p, %q
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

define ptr @test1c(ptr %p, ptr %q) {
; CHECK-LABEL: @test1c(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt ptr [[P:%.*]], [[Q:%.*]]
; CHECK-NEXT:    [[SELECT_V:%.*]] = select i1 [[CMP]], ptr [[P]], ptr [[Q]]
; CHECK-NEXT:    [[SELECT:%.*]] = getelementptr i8, ptr [[SELECT_V]], i64 16
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr i32, ptr %p, i64 4
  %gep2 = getelementptr inbounds i32, ptr %q, i64 4
  %cmp = icmp ugt ptr %p, %q
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

define ptr @test1d(ptr %p, ptr %q) {
; CHECK-LABEL: @test1d(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt ptr [[P:%.*]], [[Q:%.*]]
; CHECK-NEXT:    [[SELECT_V:%.*]] = select i1 [[CMP]], ptr [[P]], ptr [[Q]]
; CHECK-NEXT:    [[SELECT:%.*]] = getelementptr inbounds i8, ptr [[SELECT_V]], i64 16
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr inbounds i32, ptr %p, i64 4
  %gep2 = getelementptr inbounds i32, ptr %q, i64 4
  %cmp = icmp ugt ptr %p, %q
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

define ptr @test2(ptr %p, i64 %x, i64 %y) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[SELECT_V:%.*]] = call i64 @llvm.umax.i64(i64 [[X:%.*]], i64 [[Y:%.*]])
; CHECK-NEXT:    [[SELECT:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 [[SELECT_V]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr inbounds i32, ptr %p, i64 %x
  %gep2 = getelementptr inbounds i32, ptr %p, i64 %y
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

; PR50183
define ptr @test2a(ptr %p, i64 %x, i64 %y) {
; CHECK-LABEL: @test2a(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SELECT_IDX:%.*]] = select i1 [[CMP]], i64 [[X]], i64 0
; CHECK-NEXT:    [[SELECT:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 [[SELECT_IDX]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep = getelementptr inbounds i32, ptr %p, i64 %x
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %gep, ptr %p
  ret ptr %select
}

define ptr @test2a_nusw(ptr %p, i64 %x, i64 %y) {
; CHECK-LABEL: @test2a_nusw(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SELECT_IDX:%.*]] = select i1 [[CMP]], i64 [[X]], i64 0
; CHECK-NEXT:    [[SELECT:%.*]] = getelementptr nusw i32, ptr [[P:%.*]], i64 [[SELECT_IDX]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep = getelementptr nusw i32, ptr %p, i64 %x
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %gep, ptr %p
  ret ptr %select
}

define ptr @test2a_nuw(ptr %p, i64 %x, i64 %y) {
; CHECK-LABEL: @test2a_nuw(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SELECT_IDX:%.*]] = select i1 [[CMP]], i64 [[X]], i64 0
; CHECK-NEXT:    [[SELECT:%.*]] = getelementptr nuw i32, ptr [[P:%.*]], i64 [[SELECT_IDX]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep = getelementptr nuw i32, ptr %p, i64 %x
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %gep, ptr %p
  ret ptr %select
}

; PR50183
define ptr @test2b(ptr %p, i64 %x, i64 %y) {
; CHECK-LABEL: @test2b(
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[SELECT_IDX:%.*]] = select i1 [[CMP]], i64 0, i64 [[X]]
; CHECK-NEXT:    [[SELECT:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 [[SELECT_IDX]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep = getelementptr inbounds i32, ptr %p, i64 %x
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %p, ptr %gep
  ret ptr %select
}

; PR51069
define ptr @test2c(ptr %p, i64 %x, i64 %y) {
; CHECK-LABEL: @test2c(
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 [[X:%.*]]
; CHECK-NEXT:    [[ICMP:%.*]] = icmp ugt i64 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[SEL_IDX:%.*]] = select i1 [[ICMP]], i64 0, i64 24
; CHECK-NEXT:    [[SEL:%.*]] = getelementptr inbounds i8, ptr [[GEP1]], i64 [[SEL_IDX]]
; CHECK-NEXT:    ret ptr [[SEL]]
;
  %gep1 = getelementptr inbounds i32, ptr %p, i64 %x
  %gep2 = getelementptr inbounds i32, ptr %gep1, i64 6
  %icmp = icmp ugt i64 %x, %y
  %sel = select i1 %icmp, ptr %gep1, ptr %gep2
  ret ptr %sel
}

; PR51069
define ptr @test2d(ptr %p, i64 %x, i64 %y) {
; CHECK-LABEL: @test2d(
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 [[X:%.*]]
; CHECK-NEXT:    [[ICMP:%.*]] = icmp ugt i64 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[SEL_IDX:%.*]] = select i1 [[ICMP]], i64 24, i64 0
; CHECK-NEXT:    [[SEL:%.*]] = getelementptr inbounds i8, ptr [[GEP1]], i64 [[SEL_IDX]]
; CHECK-NEXT:    ret ptr [[SEL]]
;
  %gep1 = getelementptr inbounds i32, ptr %p, i64 %x
  %gep2 = getelementptr inbounds i32, ptr %gep1, i64 6
  %icmp = icmp ugt i64 %x, %y
  %sel = select i1 %icmp, ptr %gep2, ptr %gep1
  ret ptr %sel
}

; Three (or more) operand GEPs are currently expected to not be optimised,
; though they could be in principle.

define ptr @test3a(ptr %p, i64 %x, i64 %y) {
; CHECK-LABEL: @test3a(
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds [4 x i32], ptr [[P:%.*]], i64 2, i64 [[X:%.*]]
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds [4 x i32], ptr [[P]], i64 2, i64 [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[X]], [[Y]]
; CHECK-NEXT:    [[SELECT:%.*]] = select i1 [[CMP]], ptr [[GEP1]], ptr [[GEP2]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr inbounds [4 x i32], ptr %p, i64 2, i64 %x
  %gep2 = getelementptr inbounds [4 x i32], ptr %p, i64 2, i64 %y
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

define ptr @test3b(ptr %p, ptr %q, i64 %x, i64 %y) {
; CHECK-LABEL: @test3b(
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds [4 x i32], ptr [[P:%.*]], i64 2, i64 [[X:%.*]]
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds [4 x i32], ptr [[Q:%.*]], i64 2, i64 [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[SELECT:%.*]] = select i1 [[CMP]], ptr [[GEP1]], ptr [[GEP2]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr inbounds [4 x i32], ptr %p, i64 2, i64 %x
  %gep2 = getelementptr inbounds [4 x i32], ptr %q, i64 2, i64 %x
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

define ptr @test3c(ptr %p, ptr %q, i64 %x, i64 %y) {
; CHECK-LABEL: @test3c(
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds [4 x i32], ptr [[P:%.*]], i64 [[X:%.*]], i64 2
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds i32, ptr [[Q:%.*]], i64 [[X]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[SELECT:%.*]] = select i1 [[CMP]], ptr [[GEP1]], ptr [[GEP2]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr inbounds [4 x i32], ptr %p, i64 %x, i64 2
  %gep2 = getelementptr inbounds i32, ptr %q, i64 %x
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

define ptr @test3d(ptr %p, ptr %q, i64 %x, i64 %y) {
; CHECK-LABEL: @test3d(
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 [[X:%.*]]
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds [4 x i32], ptr [[Q:%.*]], i64 [[X]], i64 2
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[SELECT:%.*]] = select i1 [[CMP]], ptr [[GEP1]], ptr [[GEP2]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr inbounds i32, ptr %p, i64 %x
  %gep2 = getelementptr inbounds [4 x i32], ptr %q, i64 %x, i64 2
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

; Shouldn't be optimised as it would mean introducing an extra select

define ptr @test4(ptr %p, ptr %q, i64 %x, i64 %y) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 [[X:%.*]]
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr inbounds i32, ptr [[Q:%.*]], i64 [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i64 [[X]], [[Y]]
; CHECK-NEXT:    [[SELECT:%.*]] = select i1 [[CMP]], ptr [[GEP1]], ptr [[GEP2]]
; CHECK-NEXT:    ret ptr [[SELECT]]
;
  %gep1 = getelementptr inbounds i32, ptr %p, i64 %x
  %gep2 = getelementptr inbounds i32, ptr %q, i64 %y
  %cmp = icmp ugt i64 %x, %y
  %select = select i1 %cmp, ptr %gep1, ptr %gep2
  ret ptr %select
}

; We cannot create a select with a vector condition but scalar operands.

define <2 x ptr> @test5(ptr %p1, ptr %p2, <2 x i64> %idx, <2 x i1> %cc) {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr i64, ptr [[P1:%.*]], <2 x i64> [[IDX:%.*]]
; CHECK-NEXT:    [[GEP2:%.*]] = getelementptr i64, ptr [[P2:%.*]], <2 x i64> [[IDX]]
; CHECK-NEXT:    [[SELECT:%.*]] = select <2 x i1> [[CC:%.*]], <2 x ptr> [[GEP1]], <2 x ptr> [[GEP2]]
; CHECK-NEXT:    ret <2 x ptr> [[SELECT]]
;
  %gep1 = getelementptr i64, ptr %p1, <2 x i64> %idx
  %gep2 = getelementptr i64, ptr %p2, <2 x i64> %idx
  %select = select <2 x i1> %cc, <2 x ptr> %gep1, <2 x ptr> %gep2
  ret <2 x ptr> %select
}

; PR51069 - multiple uses
define ptr @test6(ptr %p, i64 %x, i64 %y) {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    [[GEP1:%.*]] = getelementptr inbounds i32, ptr [[P:%.*]], i64 [[X:%.*]]
; CHECK-NEXT:    [[ICMP:%.*]] = icmp ugt i64 [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[SEL_IDX:%.*]] = select i1 [[ICMP]], i64 [[Y]], i64 0
; CHECK-NEXT:    [[SEL:%.*]] = getelementptr inbounds i32, ptr [[GEP1]], i64 [[SEL_IDX]]
; CHECK-NEXT:    call void @use_i32p(ptr [[GEP1]])
; CHECK-NEXT:    ret ptr [[SEL]]
;
  %gep1 = getelementptr inbounds i32, ptr %p, i64 %x
  %gep2 = getelementptr inbounds i32, ptr %gep1, i64 %y
  %icmp = icmp ugt i64 %x, %y
  %sel = select i1 %icmp, ptr %gep2, ptr %gep1
  call void @use_i32p(ptr %gep1)
  ret ptr %sel
}
declare void @use_i32p(ptr)

; We cannot create a select-with-idx with a vector condition but scalar idx.

define <2 x ptr> @test7(<2 x ptr> %p1, i64 %idx, <2 x i1> %cc) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[GEP:%.*]] = getelementptr i64, <2 x ptr> [[P1:%.*]], i64 [[IDX:%.*]]
; CHECK-NEXT:    [[SELECT:%.*]] = select <2 x i1> [[CC:%.*]], <2 x ptr> [[P1]], <2 x ptr> [[GEP]]
; CHECK-NEXT:    ret <2 x ptr> [[SELECT]]
;
  %gep = getelementptr i64, <2 x ptr> %p1, i64 %idx
  %select = select <2 x i1> %cc, <2 x ptr> %p1, <2 x ptr> %gep
  ret <2 x ptr> %select
}