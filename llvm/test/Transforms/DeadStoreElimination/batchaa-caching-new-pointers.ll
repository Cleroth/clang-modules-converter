; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S -passes=dse < %s | FileCheck %s
;
; DSE kills `store i32 44, ptr %struct.byte.4, align 4` but should not kill
; `call void @llvm.memset.p0.i64(...)`  because it has a clobber read:
; `%ret = load ptr, ptr %struct.byte.8`


%struct.type = type { ptr, ptr }

define ptr @foo(ptr noundef %ptr) {
; CHECK-LABEL: define ptr @foo(
; CHECK-SAME: ptr noundef [[PTR:%.*]]) {
; CHECK-NEXT:    [[STRUCT_ALLOCA:%.*]] = alloca [[STRUCT_TYPE:%.*]], align 8
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 56, ptr nonnull [[STRUCT_ALLOCA]]) #[[ATTR6:[0-9]+]]
; CHECK-NEXT:    [[STRUCT_BYTE_8:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_ALLOCA]], i64 8
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_BYTE_8]], i64 4
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 [[TMP1]], i8 42, i64 4, i1 false)
; CHECK-NEXT:    store i32 43, ptr [[STRUCT_BYTE_8]], align 4
; CHECK-NEXT:    [[RET:%.*]] = load ptr, ptr [[STRUCT_BYTE_8]], align 8
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 56, ptr nonnull [[STRUCT_ALLOCA]]) #[[ATTR6]]
; CHECK-NEXT:    ret ptr [[RET]]
;
  %struct.alloca = alloca %struct.type, align 8
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %struct.alloca) nounwind
  %struct.byte.8 = getelementptr inbounds i8, ptr %struct.alloca, i64 8
  ; Set %struct.alloca[8, 16) to 42.
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 %struct.byte.8, i8 42, i64 8, i1 false)
  ; Set %struct.alloca[8, 12) to 43.
  store i32 43, ptr %struct.byte.8, align 4
  ; Set %struct.alloca[4, 8) to 44.
  %struct.byte.4 = getelementptr inbounds i8, ptr %struct.alloca, i64 4
  store i32 44, ptr %struct.byte.4, align 4
  ; Return %struct.alloca[8, 16).
  %ret = load ptr, ptr %struct.byte.8
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %struct.alloca) nounwind
  ret ptr %ret
}

; Set of tests based on @foo, but where the memset's operands cannot be erased
; due to other uses. Instead, they contain a number of removable MemoryDefs;
; with non-void types result types.

define ptr @foo_with_removable_malloc() {
; CHECK-LABEL: define ptr @foo_with_removable_malloc() {
; CHECK-NEXT:    [[STRUCT_ALLOCA:%.*]] = alloca [[STRUCT_TYPE:%.*]], align 8
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 56, ptr nonnull [[STRUCT_ALLOCA]]) #[[ATTR6]]
; CHECK-NEXT:    [[STRUCT_BYTE_4:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_ALLOCA]], i64 4
; CHECK-NEXT:    [[STRUCT_BYTE_8:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_ALLOCA]], i64 8
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_BYTE_8]], i64 4
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 [[TMP1]], i8 42, i64 4, i1 false)
; CHECK-NEXT:    store i32 43, ptr [[STRUCT_BYTE_8]], align 4
; CHECK-NEXT:    [[RET:%.*]] = load ptr, ptr [[STRUCT_BYTE_8]], align 8
; CHECK-NEXT:    call void @readnone(ptr [[STRUCT_BYTE_4]])
; CHECK-NEXT:    call void @readnone(ptr [[STRUCT_BYTE_8]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 56, ptr nonnull [[STRUCT_ALLOCA]]) #[[ATTR6]]
; CHECK-NEXT:    ret ptr [[RET]]
;
  %struct.alloca = alloca %struct.type, align 8
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %struct.alloca) nounwind
  %struct.byte.4 = getelementptr inbounds i8, ptr %struct.alloca, i64 4
  %struct.byte.8 = getelementptr inbounds i8, ptr %struct.alloca, i64 8

  ; Set of removable memory deffs
  %m2 = tail call ptr @malloc(i64 4)
  %m1 = tail call ptr @malloc(i64 4)
  store i32 0, ptr %struct.byte.8
  store i32 0, ptr %struct.byte.8
  store i32 123, ptr %m1
  store i32 123, ptr %m2

  ; Set %struct.alloca[8, 16) to 42.
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 %struct.byte.8, i8 42, i64 8, i1 false)
  ; Set %struct.alloca[8, 12) to 43.
  store i32 43, ptr %struct.byte.8, align 4
  ; Set %struct.alloca[4, 8) to 44.
  store i32 44, ptr %struct.byte.4, align 4
  ; Return %struct.alloca[8, 16).
  %ret = load ptr, ptr %struct.byte.8
  call void @readnone(ptr %struct.byte.4);
  call void @readnone(ptr %struct.byte.8);
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %struct.alloca) nounwind
  ret ptr %ret
}

define ptr @foo_with_removable_malloc_free() {
; CHECK-LABEL: define ptr @foo_with_removable_malloc_free() {
; CHECK-NEXT:    [[STRUCT_ALLOCA:%.*]] = alloca [[STRUCT_TYPE:%.*]], align 8
; CHECK-NEXT:    [[M1:%.*]] = tail call ptr @malloc(i64 4)
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 56, ptr nonnull [[STRUCT_ALLOCA]]) #[[ATTR6]]
; CHECK-NEXT:    [[STRUCT_BYTE_4:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_ALLOCA]], i64 4
; CHECK-NEXT:    [[STRUCT_BYTE_8:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_ALLOCA]], i64 8
; CHECK-NEXT:    [[M2:%.*]] = tail call ptr @malloc(i64 4)
; CHECK-NEXT:    call void @free(ptr [[M1]])
; CHECK-NEXT:    call void @free(ptr [[M2]])
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_BYTE_8]], i64 4
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 [[TMP1]], i8 42, i64 4, i1 false)
; CHECK-NEXT:    store i32 43, ptr [[STRUCT_BYTE_8]], align 4
; CHECK-NEXT:    [[RET:%.*]] = load ptr, ptr [[STRUCT_BYTE_8]], align 8
; CHECK-NEXT:    call void @readnone(ptr [[STRUCT_BYTE_4]])
; CHECK-NEXT:    call void @readnone(ptr [[STRUCT_BYTE_8]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 56, ptr nonnull [[STRUCT_ALLOCA]]) #[[ATTR6]]
; CHECK-NEXT:    ret ptr [[RET]]
;
  %struct.alloca = alloca %struct.type, align 8
  %m1 = tail call ptr @malloc(i64 4)
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %struct.alloca) nounwind
  %struct.byte.4 = getelementptr inbounds i8, ptr %struct.alloca, i64 4
  %struct.byte.8 = getelementptr inbounds i8, ptr %struct.alloca, i64 8

  store i32 0, ptr %struct.byte.4
  store i32 0, ptr %struct.byte.8
  %m2 = tail call ptr @malloc(i64 4)
  store i32 123, ptr %m1
  call void @free(ptr %m1);
  store i32 123, ptr %m2
  call void @free(ptr %m2);

  ; Set %struct.alloca[8, 16) to 42.
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 %struct.byte.8, i8 42, i64 8, i1 false)
  ; Set %struct.alloca[8, 12) to 43.
  store i32 43, ptr %struct.byte.8, align 4
  ; Set %struct.alloca[4, 8) to 44.
  store i32 44, ptr %struct.byte.4, align 4
  ; Return %struct.alloca[8, 16).
  %ret = load ptr, ptr %struct.byte.8
  call void @readnone(ptr %struct.byte.4);
  call void @readnone(ptr %struct.byte.8);
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %struct.alloca) nounwind
  ret ptr %ret
}

define ptr @foo_with_malloc_to_calloc() {
; CHECK-LABEL: define ptr @foo_with_malloc_to_calloc() {
; CHECK-NEXT:    [[STRUCT_ALLOCA:%.*]] = alloca [[STRUCT_TYPE:%.*]], align 8
; CHECK-NEXT:    call void @llvm.lifetime.start.p0(i64 56, ptr nonnull [[STRUCT_ALLOCA]]) #[[ATTR6]]
; CHECK-NEXT:    [[STRUCT_BYTE_8:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_ALLOCA]], i64 8
; CHECK-NEXT:    [[STRUCT_BYTE_4:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_ALLOCA]], i64 4
; CHECK-NEXT:    [[CALLOC1:%.*]] = call ptr @calloc(i64 1, i64 4)
; CHECK-NEXT:    [[CALLOC:%.*]] = call ptr @calloc(i64 1, i64 4)
; CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds i8, ptr [[STRUCT_BYTE_8]], i64 4
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 [[TMP1]], i8 42, i64 4, i1 false)
; CHECK-NEXT:    store i32 43, ptr [[STRUCT_BYTE_8]], align 4
; CHECK-NEXT:    [[RET:%.*]] = load ptr, ptr [[STRUCT_BYTE_8]], align 8
; CHECK-NEXT:    call void @readnone(ptr [[STRUCT_BYTE_4]])
; CHECK-NEXT:    call void @readnone(ptr [[STRUCT_BYTE_8]])
; CHECK-NEXT:    call void @llvm.lifetime.end.p0(i64 56, ptr nonnull [[STRUCT_ALLOCA]]) #[[ATTR6]]
; CHECK-NEXT:    call void @use(ptr [[CALLOC1]])
; CHECK-NEXT:    call void @use(ptr [[CALLOC]])
; CHECK-NEXT:    ret ptr [[RET]]
;
  %struct.alloca = alloca %struct.type, align 8
  call void @llvm.lifetime.start.p0(i64 56, ptr nonnull %struct.alloca) nounwind
  %struct.byte.8 = getelementptr inbounds i8, ptr %struct.alloca, i64 8
  %struct.byte.4 = getelementptr inbounds i8, ptr %struct.alloca, i64 4

  ; Set of removable memory deffs
  %m1 = tail call ptr @malloc(i64 4)
  %m2 = tail call ptr @malloc(i64 4)
  store i32 0, ptr %struct.byte.4
  store i32 0, ptr %struct.byte.8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 %m2, i8 0, i64 4, i1 false)
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 %m1, i8 0, i64 4, i1 false)

  ; Set %struct.alloca[8, 16) to 42.
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 %struct.byte.8, i8 42, i64 8, i1 false)
  ; Set %struct.alloca[8, 12) to 43.
  store i32 43, ptr %struct.byte.8, align 4
  ; Set %struct.alloca[4, 8) to 44.
  store i32 44, ptr %struct.byte.4, align 4
  ; Return %struct.alloca[8, 16).
  %ret = load ptr, ptr %struct.byte.8
  call void @readnone(ptr %struct.byte.4);
  call void @readnone(ptr %struct.byte.8);
  call void @llvm.lifetime.end.p0(i64 56, ptr nonnull %struct.alloca) nounwind
  call void @use(ptr %m1)
  call void @use(ptr %m2)
  ret ptr %ret
}

declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture)

declare noalias ptr @malloc(i64) willreturn allockind("alloc,uninitialized") "alloc-family"="malloc"
declare void @readnone(ptr) readnone nounwind
declare void @free(ptr nocapture) allockind("free") "alloc-family"="malloc"

declare void @use(ptr)
