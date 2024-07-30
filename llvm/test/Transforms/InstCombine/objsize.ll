; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; Test a pile of objectsize bounds checking.
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
; We need target data to get the sizes of the arrays and structures.
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128"

@a = private global [60 x i8] zeroinitializer, align 1 ; <ptr>
@.str = private constant [8 x i8] c"abcdefg\00"   ; <ptr>
define i32 @foo() nounwind {
; CHECK-LABEL: @foo(
; CHECK-NEXT:    ret i32 60
;
  %1 = call i32 @llvm.objectsize.i32.p0(ptr @a, i1 false, i1 false, i1 false)
  ret i32 %1
}

define ptr @bar() nounwind {
; CHECK-LABEL: @bar(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[RETVAL:%.*]] = alloca ptr, align 4
; CHECK-NEXT:    br i1 true, label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
; CHECK:       cond.true:
; CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[RETVAL]], align 4
; CHECK-NEXT:    ret ptr [[TMP0]]
; CHECK:       cond.false:
; CHECK-NEXT:    ret ptr poison
;
entry:
  %retval = alloca ptr
  %0 = call i32 @llvm.objectsize.i32.p0(ptr @a, i1 false, i1 false, i1 false)
  %cmp = icmp ne i32 %0, -1
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:
  %1 = load ptr, ptr %retval
  ret ptr %1

cond.false:
  %2 = load ptr, ptr %retval
  ret ptr %2
}

define i32 @f() nounwind {
; CHECK-LABEL: @f(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.objectsize.i32.p0(ptr getelementptr ([60 x i8], ptr @a, i32 1, i32 0), i1 false, i1 false, i1 false)
  ret i32 %1
}

@window = external global [0 x i8]

define i1 @baz() nounwind {
; CHECK-LABEL: @baz(
; CHECK-NEXT:    [[TMP1:%.*]] = tail call i32 @llvm.objectsize.i32.p0(ptr @window, i1 false, i1 false, i1 false)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp eq i32 [[TMP1]], -1
; CHECK-NEXT:    ret i1 [[TMP2]]
;
  %1 = tail call i32 @llvm.objectsize.i32.p0(ptr @window, i1 false, i1 false, i1 false)
  %2 = icmp eq i32 %1, -1
  ret i1 %2
}

define void @test1(ptr %q, i32 %x) nounwind noinline {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @llvm.objectsize.i32.p0(ptr getelementptr inbounds (i8, ptr @window, i32 10), i1 false, i1 false, i1 false)
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i32 [[TMP0]], -1
; CHECK-NEXT:    br i1 [[TMP1]], label %"47", label %"46"
; CHECK:       "46":
; CHECK-NEXT:    unreachable
; CHECK:       "47":
; CHECK-NEXT:    unreachable
;
entry:
  %0 = call i32 @llvm.objectsize.i32.p0(ptr getelementptr inbounds ([0 x i8], ptr @window, i32 0, i32 10), i1 false, i1 false, i1 false) ; <i64> [#uses=1]
  %1 = icmp eq i32 %0, -1                         ; <i1> [#uses=1]
  br i1 %1, label %"47", label %"46"

"46":                                             ; preds = %entry
  unreachable

"47":                                             ; preds = %entry
  unreachable
}

@.str5 = private constant [9 x i32] [i32 97, i32 98, i32 99, i32 100, i32 0, i32
  101, i32 102, i32 103, i32 0], align 4
define i32 @test2() nounwind {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    ret i32 34
;
  %1 = call i32 @llvm.objectsize.i32.p0(ptr getelementptr (i8, ptr @.str5, i32 2), i1 false, i1 false, i1 false)
  ret i32 %1
}

; rdar://7674946
@array = internal global [480 x float] zeroinitializer ; <ptr> [#uses=1]

declare ptr @__memcpy_chk(ptr, ptr, i32, i32) nounwind

declare i32 @llvm.objectsize.i32.p0(ptr, i1, i1, i1) nounwind readonly

declare i32 @llvm.objectsize.i32.p1(ptr addrspace(1), i1, i1, i1) nounwind readonly

declare ptr @__inline_memcpy_chk(ptr, ptr, i32) nounwind inlinehint

define void @test3(i1 %c1, ptr %ptr1, ptr %ptr2, ptr %ptr3) nounwind {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[BB11:%.*]], label [[BB12:%.*]]
; CHECK:       bb11:
; CHECK-NEXT:    unreachable
; CHECK:       bb12:
; CHECK-NEXT:    [[TMP0:%.*]] = call ptr @__inline_memcpy_chk(ptr nonnull getelementptr inbounds (i8, ptr @array, i32 4), ptr [[PTR3:%.*]], i32 512) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    unreachable
;
entry:
  br i1 %c1, label %bb11, label %bb12

bb11:
  %0 = getelementptr inbounds float, ptr getelementptr inbounds ([480 x float], ptr @array, i32 0, i32 128), i32 -127 ; <ptr> [#uses=1]
  %1 = call i32 @llvm.objectsize.i32.p0(ptr %0, i1 false, i1 false, i1 false) ; <i32> [#uses=1]
  %2 = call ptr @__memcpy_chk(ptr %ptr1, ptr %ptr2, i32 512, i32 %1) nounwind ; <ptr> [#uses=0]
  unreachable

bb12:
  %3 = getelementptr inbounds float, ptr getelementptr inbounds ([480 x float], ptr @array, i32 0, i32 128), i32 -127 ; <ptr> [#uses=1]
  %4 = call ptr @__inline_memcpy_chk(ptr %3, ptr %ptr3, i32 512) nounwind inlinehint ; <ptr> [#uses=0]
  unreachable
}

; rdar://7718857

%struct.data = type { [100 x i32], [100 x i32], [1024 x i8] }

define i32 @test4(ptr %esc) nounwind ssp {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = alloca [[STRUCT_DATA:%.*]], align 8
; CHECK-NEXT:    call void @llvm.memset.p0.i32(ptr noundef nonnull align 8 dereferenceable(1824) [[TMP0]], i8 0, i32 1824, i1 false) #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    store ptr [[TMP0]], ptr [[ESC:%.*]], align 4
; CHECK-NEXT:    ret i32 0
;
entry:
  %0 = alloca %struct.data, align 8
  %1 = call i32 @llvm.objectsize.i32.p0(ptr %0, i1 false, i1 false, i1 false) nounwind
  %2 = call ptr @__memset_chk(ptr %0, i32 0, i32 1824, i32 %1) nounwind
  store ptr %0, ptr %esc
  ret i32 0
}

; rdar://7782496
@s = external global ptr

define ptr @test5(i32 %n) nounwind ssp {
; CHECK-LABEL: @test5(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = tail call noalias dereferenceable_or_null(20) ptr @malloc(i32 20) #[[ATTR0]]
; CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr @s, align 8
; CHECK-NEXT:    tail call void @llvm.memcpy.p0.p0.i32(ptr noundef nonnull align 1 dereferenceable(10) [[TMP0]], ptr noundef nonnull align 1 dereferenceable(10) [[TMP1]], i32 10, i1 false) #[[ATTR0]]
; CHECK-NEXT:    ret ptr [[TMP0]]
;
entry:
  %0 = tail call noalias ptr @malloc(i32 20) nounwind
  %1 = tail call i32 @llvm.objectsize.i32.p0(ptr %0, i1 false, i1 false, i1 false)
  %2 = load ptr, ptr @s, align 8
  %3 = tail call ptr @__memcpy_chk(ptr %0, ptr %2, i32 10, i32 %1) nounwind
  ret ptr %0
}

define void @test6(i32 %n) nounwind ssp {
; CHECK-LABEL: @test6(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = tail call noalias dereferenceable_or_null(20) ptr @malloc(i32 20) #[[ATTR0]]
; CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr @s, align 8
; CHECK-NEXT:    [[TMP2:%.*]] = tail call ptr @__memcpy_chk(ptr [[TMP0]], ptr [[TMP1]], i32 30, i32 20) #[[ATTR0]]
; CHECK-NEXT:    ret void
;
entry:
  %0 = tail call noalias ptr @malloc(i32 20) nounwind
  %1 = tail call i32 @llvm.objectsize.i32.p0(ptr %0, i1 false, i1 false, i1 false)
  %2 = load ptr, ptr @s, align 8
  %3 = tail call ptr @__memcpy_chk(ptr %0, ptr %2, i32 30, i32 %1) nounwind
  ret void
}

declare ptr @__memset_chk(ptr, i32, i32, i32) nounwind

declare noalias ptr @malloc(i32) nounwind allockind("alloc,uninitialized") allocsize(0)

define i32 @test7(ptr %esc) {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[ALLOC:%.*]] = call noalias dereferenceable_or_null(48) ptr @malloc(i32 48) #[[ATTR0]]
; CHECK-NEXT:    store ptr [[ALLOC]], ptr [[ESC:%.*]], align 4
; CHECK-NEXT:    ret i32 32
;
  %alloc = call noalias ptr @malloc(i32 48) nounwind
  store ptr %alloc, ptr %esc
  %gep = getelementptr inbounds i8, ptr %alloc, i32 16
  %objsize = call i32 @llvm.objectsize.i32.p0(ptr %gep, i1 false, i1 false, i1 false) nounwind readonly
  ret i32 %objsize
}

declare noalias ptr @calloc(i32, i32) nounwind allockind("alloc,zeroed") allocsize(0,1)

define i32 @test8(ptr %esc) {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[ALLOC:%.*]] = call noalias dereferenceable_or_null(35) ptr @calloc(i32 5, i32 7) #[[ATTR0]]
; CHECK-NEXT:    store ptr [[ALLOC]], ptr [[ESC:%.*]], align 4
; CHECK-NEXT:    ret i32 30
;
  %alloc = call noalias ptr @calloc(i32 5, i32 7) nounwind
  store ptr %alloc, ptr %esc
  %gep = getelementptr inbounds i8, ptr %alloc, i32 5
  %objsize = call i32 @llvm.objectsize.i32.p0(ptr %gep, i1 false, i1 false, i1 false) nounwind readonly
  ret i32 %objsize
}

declare noalias ptr @strdup(ptr nocapture) nounwind
declare noalias ptr @strndup(ptr nocapture, i32) nounwind

define i32 @test9(ptr %esc) {
; CHECK-LABEL: @test9(
; CHECK-NEXT:    [[CALL:%.*]] = tail call dereferenceable_or_null(8) ptr @strdup(ptr nonnull @.str) #[[ATTR0]]
; CHECK-NEXT:    store ptr [[CALL]], ptr [[ESC:%.*]], align 8
; CHECK-NEXT:    ret i32 8
;
  %call = tail call ptr @strdup(ptr @.str) nounwind
  store ptr %call, ptr %esc, align 8
  %1 = tail call i32 @llvm.objectsize.i32.p0(ptr %call, i1 true, i1 false, i1 false)
  ret i32 %1
}

define i32 @test10(ptr %esc) {
; CHECK-LABEL: @test10(
; CHECK-NEXT:    [[CALL:%.*]] = tail call dereferenceable_or_null(4) ptr @strndup(ptr nonnull dereferenceable(8) @.str, i32 3) #[[ATTR0]]
; CHECK-NEXT:    store ptr [[CALL]], ptr [[ESC:%.*]], align 8
; CHECK-NEXT:    ret i32 4
;
  %call = tail call ptr @strndup(ptr @.str, i32 3) nounwind
  store ptr %call, ptr %esc, align 8
  %1 = tail call i32 @llvm.objectsize.i32.p0(ptr %call, i1 true, i1 false, i1 false)
  ret i32 %1
}

define i32 @test11(ptr %esc) {
; CHECK-LABEL: @test11(
; CHECK-NEXT:    [[STRDUP:%.*]] = tail call dereferenceable_or_null(8) ptr @strdup(ptr nonnull @.str)
; CHECK-NEXT:    store ptr [[STRDUP]], ptr [[ESC:%.*]], align 8
; CHECK-NEXT:    ret i32 8
;
  %call = tail call ptr @strndup(ptr @.str, i32 7) nounwind
  store ptr %call, ptr %esc, align 8
  %1 = tail call i32 @llvm.objectsize.i32.p0(ptr %call, i1 true, i1 false, i1 false)
  ret i32 %1
}

define i32 @test12(ptr %esc) {
; CHECK-LABEL: @test12(
; CHECK-NEXT:    [[STRDUP:%.*]] = tail call dereferenceable_or_null(8) ptr @strdup(ptr nonnull @.str)
; CHECK-NEXT:    store ptr [[STRDUP]], ptr [[ESC:%.*]], align 8
; CHECK-NEXT:    ret i32 8
;
  %call = tail call ptr @strndup(ptr @.str, i32 8) nounwind
  store ptr %call, ptr %esc, align 8
  %1 = tail call i32 @llvm.objectsize.i32.p0(ptr %call, i1 true, i1 false, i1 false)
  ret i32 %1
}

define i32 @test13(ptr %esc) {
; CHECK-LABEL: @test13(
; CHECK-NEXT:    [[STRDUP:%.*]] = tail call dereferenceable_or_null(8) ptr @strdup(ptr nonnull @.str)
; CHECK-NEXT:    store ptr [[STRDUP]], ptr [[ESC:%.*]], align 8
; CHECK-NEXT:    ret i32 8
;
  %call = tail call ptr @strndup(ptr @.str, i32 57) nounwind
  store ptr %call, ptr %esc, align 8
  %1 = tail call i32 @llvm.objectsize.i32.p0(ptr %call, i1 true, i1 false, i1 false)
  ret i32 %1
}

@globalalias = internal alias [60 x i8], ptr @a

define i32 @test18() {
; CHECK-LABEL: @test18(
; CHECK-NEXT:    ret i32 60
;
  %1 = call i32 @llvm.objectsize.i32.p0(ptr @globalalias, i1 false, i1 false, i1 false)
  ret i32 %1
}

@globalalias2 = weak alias [60 x i8], ptr @a

define i32 @test19() {
; CHECK-LABEL: @test19(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.objectsize.i32.p0(ptr @globalalias2, i1 false, i1 false, i1 false)
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.objectsize.i32.p0(ptr @globalalias2, i1 false, i1 false, i1 false)
  ret i32 %1
}

define i32 @test20() {
; CHECK-LABEL: @test20(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.objectsize.i32.p0(ptr null, i1 false, i1 false, i1 false)
  ret i32 %1
}

define i32 @test21() {
; CHECK-LABEL: @test21(
; CHECK-NEXT:    ret i32 0
;
  %1 = call i32 @llvm.objectsize.i32.p0(ptr null, i1 true, i1 false, i1 false)
  ret i32 %1
}

define i32 @test22() {
; CHECK-LABEL: @test22(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.objectsize.i32.p0(ptr null, i1 false, i1 true, i1 false)
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.objectsize.i32.p0(ptr null, i1 false, i1 true, i1 false)
  ret i32 %1
}

define i32 @test23() {
; CHECK-LABEL: @test23(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.objectsize.i32.p0(ptr null, i1 true, i1 true, i1 false)
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.objectsize.i32.p0(ptr null, i1 true, i1 true, i1 false)
  ret i32 %1
}

; 1 is an arbitrary non-zero address space.
define i32 @test24() {
; CHECK-LABEL: @test24(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.objectsize.i32.p1(ptr addrspace(1) null, i1 false, i1 false, i1 false)
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.objectsize.i32.p1(ptr addrspace(1) null, i1 false,
  i1 false, i1 false)
  ret i32 %1
}

define i32 @test25() {
; CHECK-LABEL: @test25(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.objectsize.i32.p1(ptr addrspace(1) null, i1 true, i1 false, i1 false)
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.objectsize.i32.p1(ptr addrspace(1) null, i1 true,
  i1 false, i1 false)
  ret i32 %1
}

define i32 @test26() {
; CHECK-LABEL: @test26(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.objectsize.i32.p1(ptr addrspace(1) null, i1 false, i1 true, i1 false)
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.objectsize.i32.p1(ptr addrspace(1) null, i1 false,
  i1 true, i1 false)
  ret i32 %1
}

define i32 @test27() {
; CHECK-LABEL: @test27(
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @llvm.objectsize.i32.p1(ptr addrspace(1) null, i1 true, i1 true, i1 false)
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  %1 = call i32 @llvm.objectsize.i32.p1(ptr addrspace(1) null, i1 true,
  i1 true, i1 false)
  ret i32 %1
}
