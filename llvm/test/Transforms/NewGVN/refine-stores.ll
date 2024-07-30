; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; REQUIRES: x86-registered-target
; RUN: opt < %s -passes=newgvn -S | FileCheck %s
;; Now that we do store refinement, we have to verify that we add fake uses
;; when we skip existing stores.
;; We also are testing that various variations that cause stores to move classes
;; have the right class movement happen
;; All of these tests result in verification failures if it does not.

source_filename = "bugpoint-output-daef094.bc"
target triple = "x86_64-apple-darwin16.5.0"

%struct.eggs = type {}

define void @spam(ptr %a) {
; CHECK-LABEL: @spam(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    store ptr null, ptr [[A:%.*]], align 8
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    br i1 undef, label [[BB3:%.*]], label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    call void @baz()
; CHECK-NEXT:    br label [[BB1]]
; CHECK:       bb3:
; CHECK-NEXT:    store i32 0, ptr undef, align 4
; CHECK-NEXT:    store ptr null, ptr [[A]], align 8
; CHECK-NEXT:    unreachable
;
bb:
  store ptr null, ptr %a
  br label %bb1

bb1:                                              ; preds = %bb2, %bb
  br i1 undef, label %bb3, label %bb2

bb2:                                              ; preds = %bb1
  call void @baz()
  br label %bb1

bb3:                                              ; preds = %bb1
  store i32 0, ptr undef
;; This store is defined by a memoryphi of the call and the first store
;; At first, we will prove it equivalent to the first store above.
;; Then the call will become reachable, and the equivalence will be removed
;; Without it being a use of the first store, we will not update the store
;; to reflect this.
  store ptr null, ptr %a
  unreachable
}

declare void @baz()


define void @a() {
; CHECK-LABEL: @a(
; CHECK-NEXT:  b:
; CHECK-NEXT:    br label [[C:%.*]]
; CHECK:       c:
; CHECK-NEXT:    store i64 undef, ptr null, align 8
; CHECK-NEXT:    br label [[E:%.*]]
; CHECK:       e:
; CHECK-NEXT:    store ptr undef, ptr null, align 8
; CHECK-NEXT:    br i1 undef, label [[C]], label [[E]]
;
b:
  br label %c

c:                                                ; preds = %e, %b
  %d = phi ptr [ undef, %b ], [ null, %e ]
  store i64 undef, ptr %d
  br label %e

e:                                                ; preds = %e, %c
;; The memory for this load starts out equivalent to just the store in c, we later discover the store after us, and
;; need to make sure the right set of values get marked as changed after memory leaders change
  %g = load ptr, ptr null
  store ptr undef, ptr null
  br i1 undef, label %c, label %e
}

%struct.hoge = type {}

define void @widget(ptr %arg) {
; CHECK-LABEL: @widget(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    br label [[BB1:%.*]]
; CHECK:       bb1:
; CHECK-NEXT:    [[TMP:%.*]] = phi ptr [ [[ARG:%.*]], [[BB:%.*]] ], [ null, [[BB1]] ]
; CHECK-NEXT:    store ptr [[TMP]], ptr undef, align 8
; CHECK-NEXT:    br i1 undef, label [[BB1]], label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    [[TMP3:%.*]] = phi i64 [ [[TMP8:%.*]], [[BB7:%.*]] ], [ 0, [[BB1]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = icmp eq i64 [[TMP3]], 0
; CHECK-NEXT:    br i1 [[TMP4]], label [[BB7]], label [[BB5:%.*]]
; CHECK:       bb5:
; CHECK-NEXT:    [[TMP6:%.*]] = load i64, ptr null, align 8
; CHECK-NEXT:    call void @quux()
; CHECK-NEXT:    store i64 [[TMP6]], ptr undef, align 8
; CHECK-NEXT:    br label [[BB7]]
; CHECK:       bb7:
; CHECK-NEXT:    [[TMP8]] = add i64 [[TMP3]], 1
; CHECK-NEXT:    br label [[BB2]]
;
bb:
  br label %bb1

bb1:                                              ; preds = %bb1, %bb
  %tmp = phi ptr [ %arg, %bb ], [ null, %bb1 ]
  store ptr %tmp, ptr undef
  br i1 undef, label %bb1, label %bb2

bb2:                                              ; preds = %bb7, %bb1
  %tmp3 = phi i64 [ %tmp8, %bb7 ], [ 0, %bb1 ]
  %tmp4 = icmp eq i64 %tmp3, 0
  br i1 %tmp4, label %bb7, label %bb5

bb5:                                              ; preds = %bb2
  ;; Originally thought equal to the store that comes after it until the phi edges
  ;; are completely traversed
  %tmp6 = load i64, ptr null
  call void @quux()
  store i64 %tmp6, ptr undef
  br label %bb7

bb7:                                              ; preds = %bb5, %bb2
  %tmp8 = add i64 %tmp3, 1
  br label %bb2
}

declare void @quux()

%struct.a = type {}

define void @b() {
; CHECK-LABEL: @b(
; CHECK-NEXT:    [[C:%.*]] = alloca [[STRUCT_A:%.*]], align 8
; CHECK-NEXT:    br label [[D:%.*]]
; CHECK:       m:
; CHECK-NEXT:    unreachable
; CHECK:       d:
; CHECK-NEXT:    [[E:%.*]] = load i32, ptr [[C]], align 4
; CHECK-NEXT:    br i1 undef, label [[I:%.*]], label [[J:%.*]]
; CHECK:       i:
; CHECK-NEXT:    br i1 undef, label [[K:%.*]], label [[M:%.*]]
; CHECK:       k:
; CHECK-NEXT:    br label [[L:%.*]]
; CHECK:       l:
; CHECK-NEXT:    unreachable
; CHECK:       j:
; CHECK-NEXT:    br label [[M]]
;
  %c = alloca %struct.a
  br label %d

m:                                                ; preds = %j, %i
  store i32 %e, ptr %h
  unreachable

d:                                                ; preds = %0
  %h = getelementptr i8, ptr %c
  %e = load i32, ptr %h
  br i1 undef, label %i, label %j

i:                                                ; preds = %d
  br i1 undef, label %k, label %m

k:                                                ; preds = %i
  br label %l

l:                                                ; preds = %k
  %n = phi i32 [ %e, %k ]
  ;; Becomes equal and then not equal to the other store, and
  ;; along the way, the load.
  store i32 %n, ptr %h
  unreachable

j:                                                ; preds = %d
  br label %m
}
