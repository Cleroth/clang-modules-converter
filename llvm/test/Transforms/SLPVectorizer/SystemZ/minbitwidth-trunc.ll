; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer -mtriple=s390x-unknown-linux -mcpu=z14 < %s | FileCheck %s

define void @test() {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[TMP1:%.*]] = zext i8 0 to i32
; CHECK-NEXT:    [[TMP2:%.*]] = zext i8 0 to i32
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <4 x i32> <i32 poison, i32 0, i32 0, i32 0>, i32 [[TMP2]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = select <4 x i1> zeroinitializer, <4 x i32> zeroinitializer, <4 x i32> [[TMP3]]
; CHECK-NEXT:    [[TMP5:%.*]] = select i1 false, i32 0, i32 0
; CHECK-NEXT:    [[TMP6:%.*]] = select i1 false, i32 0, i32 [[TMP1]]
; CHECK-NEXT:    [[TMP7:%.*]] = select i1 false, i32 0, i32 [[TMP2]]
; CHECK-NEXT:    [[TMP8:%.*]] = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> [[TMP4]])
; CHECK-NEXT:    [[OP_RDX:%.*]] = xor i32 [[TMP8]], [[TMP5]]
; CHECK-NEXT:    [[OP_RDX1:%.*]] = xor i32 [[TMP6]], [[TMP7]]
; CHECK-NEXT:    [[OP_RDX2:%.*]] = xor i32 [[OP_RDX]], [[OP_RDX1]]
; CHECK-NEXT:    [[TMP9:%.*]] = trunc i32 [[OP_RDX2]] to i16
; CHECK-NEXT:    store i16 [[TMP9]], ptr null, align 2
; CHECK-NEXT:    ret void
;
  %1 = zext i8 0 to i32
  %.not = icmp sgt i32 0, %1
  %2 = zext i8 0 to i32
  %3 = select i1 %.not, i32 0, i32 0
  %4 = zext i8 0 to i32
  %.not.1 = icmp sgt i32 0, %4
  %5 = zext i8 0 to i32
  %6 = select i1 %.not.1, i32 0, i32 %5
  %7 = xor i32 %6, %3
  %8 = zext i8 0 to i32
  %.not.2 = icmp sgt i32 0, %8
  %9 = select i1 %.not.2, i32 0, i32 0
  %10 = xor i32 %9, %7
  %11 = zext i8 0 to i32
  %.not.3 = icmp sgt i32 0, %11
  %12 = select i1 %.not.3, i32 0, i32 0
  %13 = xor i32 %12, %10
  %14 = select i1 false, i32 0, i32 0
  %15 = xor i32 %14, %13
  %16 = select i1 false, i32 0, i32 %2
  %17 = xor i32 %16, %15
  %18 = select i1 false, i32 0, i32 %5
  %19 = xor i32 %18, %17
  %20 = trunc i32 %19 to i16
  store i16 %20, ptr null, align 2
  ret void
}
