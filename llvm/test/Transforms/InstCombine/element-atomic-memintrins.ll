; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=instcombine -S < %s | FileCheck %s

;; ---- memset -----

; Ensure 0-length memset is removed
define void @test_memset_zero_length(ptr %dest) {
; CHECK-LABEL: @test_memset_zero_length(
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 1 %dest, i8 1, i32 0, i32 1)
  ret void
}

define void @test_memset_to_store(ptr %dest) {
; CHECK-LABEL: @test_memset_to_store(
; CHECK-NEXT:    store atomic i8 1, ptr [[DEST:%.*]] unordered, align 1
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 1 [[DEST]], i8 1, i32 2, i32 1)
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 1 [[DEST]], i8 1, i32 4, i32 1)
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 1 [[DEST]], i8 1, i32 8, i32 1)
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 1 [[DEST]], i8 1, i32 16, i32 1)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 1 %dest, i8 1, i32 1, i32 1)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 1 %dest, i8 1, i32 2, i32 1)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 1 %dest, i8 1, i32 4, i32 1)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 1 %dest, i8 1, i32 8, i32 1)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 1 %dest, i8 1, i32 16, i32 1)
  ret void
}

define void @test_memset_to_store_2(ptr %dest) {
; CHECK-LABEL: @test_memset_to_store_2(
; CHECK-NEXT:    store atomic i8 1, ptr [[DEST:%.*]] unordered, align 2
; CHECK-NEXT:    store atomic i16 257, ptr [[DEST]] unordered, align 2
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 2 [[DEST]], i8 1, i32 4, i32 2)
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 2 [[DEST]], i8 1, i32 8, i32 2)
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 2 [[DEST]], i8 1, i32 16, i32 2)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 2 %dest, i8 1, i32 1, i32 1)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 2 %dest, i8 1, i32 2, i32 2)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 2 %dest, i8 1, i32 4, i32 2)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 2 %dest, i8 1, i32 8, i32 2)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 2 %dest, i8 1, i32 16, i32 2)
  ret void
}

define void @test_memset_to_store_4(ptr %dest) {
; CHECK-LABEL: @test_memset_to_store_4(
; CHECK-NEXT:    store atomic i8 1, ptr [[DEST:%.*]] unordered, align 4
; CHECK-NEXT:    store atomic i16 257, ptr [[DEST]] unordered, align 4
; CHECK-NEXT:    store atomic i32 16843009, ptr [[DEST]] unordered, align 4
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 4 [[DEST]], i8 1, i32 8, i32 4)
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 4 [[DEST]], i8 1, i32 16, i32 4)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 4 %dest, i8 1, i32 1, i32 1)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 4 %dest, i8 1, i32 2, i32 2)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 4 %dest, i8 1, i32 4, i32 4)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 4 %dest, i8 1, i32 8, i32 4)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 4 %dest, i8 1, i32 16, i32 4)
  ret void
}

define void @test_memset_to_store_8(ptr %dest) {
; CHECK-LABEL: @test_memset_to_store_8(
; CHECK-NEXT:    store atomic i8 1, ptr [[DEST:%.*]] unordered, align 8
; CHECK-NEXT:    store atomic i16 257, ptr [[DEST]] unordered, align 8
; CHECK-NEXT:    store atomic i32 16843009, ptr [[DEST]] unordered, align 8
; CHECK-NEXT:    store atomic i64 72340172838076673, ptr [[DEST]] unordered, align 8
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 8 [[DEST]], i8 1, i32 16, i32 8)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 8 %dest, i8 1, i32 1, i32 1)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 8 %dest, i8 1, i32 2, i32 2)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 8 %dest, i8 1, i32 4, i32 4)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 8 %dest, i8 1, i32 8, i32 8)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 8 %dest, i8 1, i32 16, i32 8)
  ret void
}

define void @test_memset_to_store_16(ptr %dest) {
; CHECK-LABEL: @test_memset_to_store_16(
; CHECK-NEXT:    store atomic i8 1, ptr [[DEST:%.*]] unordered, align 16
; CHECK-NEXT:    store atomic i16 257, ptr [[DEST]] unordered, align 16
; CHECK-NEXT:    store atomic i32 16843009, ptr [[DEST]] unordered, align 16
; CHECK-NEXT:    store atomic i64 72340172838076673, ptr [[DEST]] unordered, align 16
; CHECK-NEXT:    call void @llvm.memset.element.unordered.atomic.p0.i32(ptr nonnull align 16 [[DEST]], i8 1, i32 16, i32 16)
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 16 %dest, i8 1, i32 1, i32 1)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 16 %dest, i8 1, i32 2, i32 2)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 16 %dest, i8 1, i32 4, i32 4)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 16 %dest, i8 1, i32 8, i32 8)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 16 %dest, i8 1, i32 16, i32 16)
  ret void
}

declare void @llvm.memset.element.unordered.atomic.p0.i32(ptr nocapture writeonly, i8, i32, i32) nounwind argmemonly


;; =========================================
;; ----- memmove ------


@gconst = constant [32 x i8] c"0123456789012345678901234567890\00"
; Check that a memmove from a global constant is converted into a memcpy
define void @test_memmove_to_memcpy(ptr %dest) {
; CHECK-LABEL: @test_memmove_to_memcpy(
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 1 [[DEST:%.*]], ptr nonnull align 16 @gconst, i32 32, i32 1)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 @gconst, i32 32, i32 1)
  ret void
}

define void @test_memmove_zero_length(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memmove_zero_length(
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 0, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 0, i32 2)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 0, i32 4)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 0, i32 8)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 0, i32 16)
  ret void
}

; memmove with src==dest is removed
define void @test_memmove_removed(ptr %srcdest, i32 %sz) {
; CHECK-LABEL: @test_memmove_removed(
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 1 %srcdest, ptr align 1 %srcdest, i32 %sz, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 2 %srcdest, ptr align 2 %srcdest, i32 %sz, i32 2)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 4 %srcdest, ptr align 4 %srcdest, i32 %sz, i32 4)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 8 %srcdest, ptr align 8 %srcdest, i32 %sz, i32 8)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 16 %srcdest, ptr align 16 %srcdest, i32 %sz, i32 16)
  ret void
}

; memmove with a small constant length is converted to a load/store pair
define void @test_memmove_loadstore(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memmove_loadstore(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 1
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 1
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 1 [[DEST]], ptr nonnull align 1 [[SRC]], i32 2, i32 1)
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 1 [[DEST]], ptr nonnull align 1 [[SRC]], i32 4, i32 1)
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 1 [[DEST]], ptr nonnull align 1 [[SRC]], i32 8, i32 1)
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 1 [[DEST]], ptr nonnull align 1 [[SRC]], i32 16, i32 1)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 1, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 2, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 4, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 8, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 16, i32 1)
  ret void
}

define void @test_memmove_loadstore_2(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memmove_loadstore_2(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 2
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 2
; CHECK-NEXT:    [[TMP2:%.*]] = load atomic i16, ptr [[SRC]] unordered, align 2
; CHECK-NEXT:    store atomic i16 [[TMP2]], ptr [[DEST]] unordered, align 2
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 2 [[DEST]], ptr nonnull align 2 [[SRC]], i32 4, i32 2)
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 2 [[DEST]], ptr nonnull align 2 [[SRC]], i32 8, i32 2)
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 2 [[DEST]], ptr nonnull align 2 [[SRC]], i32 16, i32 2)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 1, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 2, i32 2)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 4, i32 2)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 8, i32 2)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 16, i32 2)
  ret void
}

define void @test_memmove_loadstore_4(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memmove_loadstore_4(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 4
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load atomic i16, ptr [[SRC]] unordered, align 4
; CHECK-NEXT:    store atomic i16 [[TMP2]], ptr [[DEST]] unordered, align 4
; CHECK-NEXT:    [[TMP3:%.*]] = load atomic i32, ptr [[SRC]] unordered, align 4
; CHECK-NEXT:    store atomic i32 [[TMP3]], ptr [[DEST]] unordered, align 4
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 4 [[DEST]], ptr nonnull align 4 [[SRC]], i32 8, i32 4)
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 4 [[DEST]], ptr nonnull align 4 [[SRC]], i32 16, i32 4)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 1, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 2, i32 2)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 4, i32 4)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 8, i32 4)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 16, i32 4)
  ret void
}

define void @test_memmove_loadstore_8(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memmove_loadstore_8(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 8
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load atomic i16, ptr [[SRC]] unordered, align 8
; CHECK-NEXT:    store atomic i16 [[TMP2]], ptr [[DEST]] unordered, align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load atomic i32, ptr [[SRC]] unordered, align 8
; CHECK-NEXT:    store atomic i32 [[TMP3]], ptr [[DEST]] unordered, align 8
; CHECK-NEXT:    [[TMP4:%.*]] = load atomic i64, ptr [[SRC]] unordered, align 8
; CHECK-NEXT:    store atomic i64 [[TMP4]], ptr [[DEST]] unordered, align 8
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 8 [[DEST]], ptr nonnull align 8 [[SRC]], i32 16, i32 8)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 1, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 2, i32 2)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 4, i32 4)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 8, i32 8)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 16, i32 8)
  ret void
}

define void @test_memmove_loadstore_16(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memmove_loadstore_16(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 16
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 16
; CHECK-NEXT:    [[TMP2:%.*]] = load atomic i16, ptr [[SRC]] unordered, align 16
; CHECK-NEXT:    store atomic i16 [[TMP2]], ptr [[DEST]] unordered, align 16
; CHECK-NEXT:    [[TMP3:%.*]] = load atomic i32, ptr [[SRC]] unordered, align 16
; CHECK-NEXT:    store atomic i32 [[TMP3]], ptr [[DEST]] unordered, align 16
; CHECK-NEXT:    [[TMP4:%.*]] = load atomic i64, ptr [[SRC]] unordered, align 16
; CHECK-NEXT:    store atomic i64 [[TMP4]], ptr [[DEST]] unordered, align 16
; CHECK-NEXT:    call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nonnull align 16 [[DEST]], ptr nonnull align 16 [[SRC]], i32 16, i32 16)
; CHECK-NEXT:    ret void
;
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 1, i32 1)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 2, i32 2)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 4, i32 4)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 8, i32 8)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 16, i32 16)
  ret void
}

declare void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr nocapture writeonly, ptr nocapture readonly, i32, i32) nounwind argmemonly

;; =========================================
;; ----- memcpy ------

define void @test_memcpy_zero_length(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memcpy_zero_length(
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 0, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 0, i32 2)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 0, i32 4)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 0, i32 8)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 0, i32 16)
  ret void
}

; memcpy with src==dest is removed
define void @test_memcpy_removed(ptr %srcdest, i32 %sz) {
; CHECK-LABEL: @test_memcpy_removed(
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 1 %srcdest, ptr align 1 %srcdest, i32 %sz, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 2 %srcdest, ptr align 2 %srcdest, i32 %sz, i32 2)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 4 %srcdest, ptr align 4 %srcdest, i32 %sz, i32 4)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 8 %srcdest, ptr align 8 %srcdest, i32 %sz, i32 8)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 16 %srcdest, ptr align 16 %srcdest, i32 %sz, i32 16)
  ret void
}

; memcpy with a small constant length is converted to a load/store pair
define void @test_memcpy_loadstore(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memcpy_loadstore(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 1
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 1
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 1 [[DEST]], ptr nonnull align 1 [[SRC]], i32 2, i32 1)
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 1 [[DEST]], ptr nonnull align 1 [[SRC]], i32 4, i32 1)
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 1 [[DEST]], ptr nonnull align 1 [[SRC]], i32 8, i32 1)
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 1 [[DEST]], ptr nonnull align 1 [[SRC]], i32 16, i32 1)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 1, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 2, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 4, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 8, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 1 %dest, ptr align 1 %src, i32 16, i32 1)
  ret void
}

define void @test_memcpy_loadstore_2(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memcpy_loadstore_2(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 2
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 2
; CHECK-NEXT:    [[TMP2:%.*]] = load atomic i16, ptr [[SRC]] unordered, align 2
; CHECK-NEXT:    store atomic i16 [[TMP2]], ptr [[DEST]] unordered, align 2
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 2 [[DEST]], ptr nonnull align 2 [[SRC]], i32 4, i32 2)
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 2 [[DEST]], ptr nonnull align 2 [[SRC]], i32 8, i32 2)
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 2 [[DEST]], ptr nonnull align 2 [[SRC]], i32 16, i32 2)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 1, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 2, i32 2)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 4, i32 2)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 8, i32 2)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 2 %dest, ptr align 2 %src, i32 16, i32 2)
  ret void
}

define void @test_memcpy_loadstore_4(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memcpy_loadstore_4(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 4
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load atomic i16, ptr [[SRC]] unordered, align 4
; CHECK-NEXT:    store atomic i16 [[TMP2]], ptr [[DEST]] unordered, align 4
; CHECK-NEXT:    [[TMP3:%.*]] = load atomic i32, ptr [[SRC]] unordered, align 4
; CHECK-NEXT:    store atomic i32 [[TMP3]], ptr [[DEST]] unordered, align 4
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 4 [[DEST]], ptr nonnull align 4 [[SRC]], i32 8, i32 4)
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 4 [[DEST]], ptr nonnull align 4 [[SRC]], i32 16, i32 4)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 1, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 2, i32 2)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 4, i32 4)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 8, i32 4)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 4 %dest, ptr align 4 %src, i32 16, i32 4)
  ret void
}

define void @test_memcpy_loadstore_8(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memcpy_loadstore_8(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 8
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 8
; CHECK-NEXT:    [[TMP2:%.*]] = load atomic i16, ptr [[SRC]] unordered, align 8
; CHECK-NEXT:    store atomic i16 [[TMP2]], ptr [[DEST]] unordered, align 8
; CHECK-NEXT:    [[TMP3:%.*]] = load atomic i32, ptr [[SRC]] unordered, align 8
; CHECK-NEXT:    store atomic i32 [[TMP3]], ptr [[DEST]] unordered, align 8
; CHECK-NEXT:    [[TMP4:%.*]] = load atomic i64, ptr [[SRC]] unordered, align 8
; CHECK-NEXT:    store atomic i64 [[TMP4]], ptr [[DEST]] unordered, align 8
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 8 [[DEST]], ptr nonnull align 8 [[SRC]], i32 16, i32 8)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 1, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 2, i32 2)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 4, i32 4)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 8, i32 8)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 8 %dest, ptr align 8 %src, i32 16, i32 8)
  ret void
}

define void @test_memcpy_loadstore_16(ptr %dest, ptr %src) {
; CHECK-LABEL: @test_memcpy_loadstore_16(
; CHECK-NEXT:    [[TMP1:%.*]] = load atomic i8, ptr [[SRC:%.*]] unordered, align 16
; CHECK-NEXT:    store atomic i8 [[TMP1]], ptr [[DEST:%.*]] unordered, align 16
; CHECK-NEXT:    [[TMP2:%.*]] = load atomic i16, ptr [[SRC]] unordered, align 16
; CHECK-NEXT:    store atomic i16 [[TMP2]], ptr [[DEST]] unordered, align 16
; CHECK-NEXT:    [[TMP3:%.*]] = load atomic i32, ptr [[SRC]] unordered, align 16
; CHECK-NEXT:    store atomic i32 [[TMP3]], ptr [[DEST]] unordered, align 16
; CHECK-NEXT:    [[TMP4:%.*]] = load atomic i64, ptr [[SRC]] unordered, align 16
; CHECK-NEXT:    store atomic i64 [[TMP4]], ptr [[DEST]] unordered, align 16
; CHECK-NEXT:    call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nonnull align 16 [[DEST]], ptr nonnull align 16 [[SRC]], i32 16, i32 16)
; CHECK-NEXT:    ret void
;
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 1, i32 1)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 2, i32 2)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 4, i32 4)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 8, i32 8)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 16, i32 16)
  ret void
}

define void @test_undefined(ptr %dest, ptr %src, i1 %c1) {
; CHECK-LABEL: @test_undefined(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C1:%.*]], label [[OK:%.*]], label [[UNDEFINED:%.*]]
; CHECK:       undefined:
; CHECK-NEXT:    store i1 true, ptr poison, align 1
; CHECK-NEXT:    br label [[OK]]
; CHECK:       ok:
; CHECK-NEXT:    ret void
;
entry:
  br i1 %c1, label %ok, label %undefined
undefined:
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 7, i32 4)
  call void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 -8, i32 4)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 7, i32 4)
  call void @llvm.memmove.element.unordered.atomic.p0.p0.i32(ptr align 16 %dest, ptr align 16 %src, i32 -8, i32 4)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 16 %dest, i8 1, i32 7, i32 4)
  call void @llvm.memset.element.unordered.atomic.p0.i32(ptr align 16 %dest, i8 1, i32 -8, i32 4)
  br label %ok
ok:
  ret void
}

declare void @llvm.memcpy.element.unordered.atomic.p0.p0.i32(ptr nocapture writeonly, ptr nocapture readonly, i32, i32) nounwind argmemonly
