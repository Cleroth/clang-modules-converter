; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S < %s | FileCheck %s
; RUN: opt -S -passes=instcombine < %s | FileCheck %s --check-prefix=INSTCOMBINE

; Two of the llvm.umax calls are intentionally missing the mangling suffix here,
; to show that it will be added automatically.
define i32 @test(i8 %x, i8 %y) {
; CHECK-LABEL: define i32 @test(
; CHECK-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[X]], -1
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    [[MAX1:%.*]] = call i8 @llvm.umax.i8(i8 [[X]], i8 [[Y]])
; CHECK-NEXT:    [[X_EXT:%.*]] = zext i8 [[X]] to i16
; CHECK-NEXT:    [[Y_EXT:%.*]] = zext i8 [[Y]] to i16
; CHECK-NEXT:    [[MAX2:%.*]] = call i16 @llvm.umax.i16(i16 [[X_EXT]], i16 [[Y_EXT]])
; CHECK-NEXT:    [[X_EXT2:%.*]] = zext i8 [[X]] to i32
; CHECK-NEXT:    [[Y_EXT2:%.*]] = zext i8 [[Y]] to i32
; CHECK-NEXT:    [[MAX3:%.*]] = call i32 @llvm.umax.i32(i32 [[X_EXT2]], i32 [[Y_EXT2]])
; CHECK-NEXT:    ret i32 [[MAX3]]
;
; INSTCOMBINE-LABEL: define i32 @test(
; INSTCOMBINE-SAME: i8 [[X:%.*]], i8 [[Y:%.*]]) {
; INSTCOMBINE-NEXT:    [[CMP:%.*]] = icmp sgt i8 [[X]], -1
; INSTCOMBINE-NEXT:    call void @llvm.assume(i1 [[CMP]])
; INSTCOMBINE-NEXT:    [[TMP1:%.*]] = call i8 @llvm.umax.i8(i8 [[X]], i8 [[Y]])
; INSTCOMBINE-NEXT:    [[MAX3:%.*]] = zext i8 [[TMP1]] to i32
; INSTCOMBINE-NEXT:    ret i32 [[MAX3]]
;
  %cmp = icmp sgt i8 %x, -1
  call void @llvm.assume(i1 %cmp)
  %max1 = call i8 @llvm.umax(i8 %x, i8 %y)
  %x.ext = zext i8 %x to i16
  %y.ext = zext i8 %y to i16
  %max2 = call i16 @llvm.umax(i16 %x.ext, i16 %y.ext)
  %x.ext2 = zext i8 %x to i32
  %y.ext2 = zext i8 %y to i32
  %max3 = call i32 @llvm.umax.i32(i32 %x.ext2, i32 %y.ext2)
  ret i32 %max3
}
