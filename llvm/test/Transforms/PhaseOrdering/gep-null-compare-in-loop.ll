; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2

; RUN: opt -O3 -S < %s | FileCheck %s

define internal i32 @loop(ptr %arg, ptr %arg1) {
bb:
  br label %bb2

bb2:
  %phi = phi ptr [ %arg, %bb ], [ %phi8, %bb11 ]
  %phi3 = phi i32 [ 0, %bb ], [ %add, %bb11 ]
  %icmp = icmp ne ptr %arg1, null
  %icmp4 = icmp eq ptr %phi, %arg1
  br i1 %icmp4, label %bb7, label %bb5

bb5:
  %getelementptr = getelementptr inbounds i32, ptr %phi, i64 1
  br label %bb7

bb7:
  %phi8 = phi ptr [ %phi, %bb2 ], [ %getelementptr, %bb5 ]
  %phi9 = phi ptr [ null, %bb2 ], [ %phi, %bb5 ]
  %icmp10 = icmp eq ptr %phi9, null
  br i1 %icmp10, label %bb12, label %bb11

bb11:
  %load = load i32, ptr %phi9, align 4
  %add = add i32 %load, %phi3
  br label %bb2

bb12:
  ret i32 %phi3
}

define i32 @using_alloca() {
; CHECK-LABEL: define noundef i32 @using_alloca
; CHECK-SAME: () local_unnamed_addr #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    ret i32 6
;
bb:
  %alloca = alloca [3 x i32], align 4
  store i32 1, ptr %alloca, align 4
  %getelementptr = getelementptr i32, ptr %alloca, i32 1
  store i32 2, ptr %getelementptr, align 4
  %getelementptr1 = getelementptr i32, ptr %alloca, i32 2
  store i32 3, ptr %getelementptr1, align 4
  %getelementptr2 = getelementptr i32, ptr %alloca, i32 3
  %call = call i32 @loop(ptr %alloca, ptr %getelementptr2)
  ret i32 %call
}

define i32 @using_malloc() {
; CHECK-LABEL: define noundef i32 @using_malloc
; CHECK-SAME: () local_unnamed_addr #[[ATTR0]] {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    ret i32 6
;
bb:
  %alloc = call dereferenceable_or_null(64) ptr @malloc(i64 64)
  store i32 1, ptr %alloc, align 4
  %getelementptr = getelementptr i32, ptr %alloc, i64 1
  store i32 2, ptr %getelementptr, align 4
  %getelementptr1 = getelementptr i32, ptr %alloc, i64 2
  store i32 3, ptr %getelementptr1, align 4
  %getelementptr2 = getelementptr i32, ptr %alloc, i64 3
  %call = call i32 @loop(ptr %alloc, ptr %getelementptr2)
  ret i32 %call
}

declare ptr @malloc(i64)

declare void @free(ptr)
