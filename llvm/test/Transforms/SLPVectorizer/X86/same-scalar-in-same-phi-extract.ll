; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer -slp-threshold=-99999 -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s

define void @test(i32 %arg) {
; CHECK-LABEL: define void @test(
; CHECK-SAME: i32 [[ARG:%.*]]) {
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[TMP0:%.*]] = insertelement <2 x i32> <i32 poison, i32 0>, i32 [[ARG]], i32 0
; CHECK-NEXT:    br label [[BB2:%.*]]
; CHECK:       bb2:
; CHECK-NEXT:    switch i32 0, label [[BB10:%.*]] [
; CHECK-NEXT:      i32 0, label [[BB9:%.*]]
; CHECK-NEXT:      i32 11, label [[BB9]]
; CHECK-NEXT:      i32 1, label [[BB4:%.*]]
; CHECK-NEXT:    ]
; CHECK:       bb3:
; CHECK-NEXT:    [[TMP1:%.*]] = extractelement <2 x i32> [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP2:%.*]] = zext i32 [[TMP1]] to i64
; CHECK-NEXT:    switch i32 0, label [[BB10]] [
; CHECK-NEXT:      i32 18, label [[BB7:%.*]]
; CHECK-NEXT:      i32 1, label [[BB7]]
; CHECK-NEXT:      i32 0, label [[BB10]]
; CHECK-NEXT:    ]
; CHECK:       bb4:
; CHECK-NEXT:    [[TMP3:%.*]] = phi <2 x i32> [ [[TMP0]], [[BB2]] ]
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <2 x i32> [[TMP3]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = zext i32 [[TMP4]] to i64
; CHECK-NEXT:    [[GETELEMENTPTR:%.*]] = getelementptr i32, ptr null, i64 [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = extractelement <2 x i32> [[TMP3]], i32 1
; CHECK-NEXT:    [[TMP6:%.*]] = zext i32 [[TMP7]] to i64
; CHECK-NEXT:    [[GETELEMENTPTR6:%.*]] = getelementptr i32, ptr null, i64 [[TMP6]]
; CHECK-NEXT:    ret void
; CHECK:       bb7:
; CHECK-NEXT:    [[PHI8:%.*]] = phi i64 [ [[TMP2]], [[BB3:%.*]] ], [ [[TMP2]], [[BB3]] ]
; CHECK-NEXT:    br label [[BB9]]
; CHECK:       bb9:
; CHECK-NEXT:    ret void
; CHECK:       bb10:
; CHECK-NEXT:    ret void
;
bb:
  %zext = zext i32 %arg to i64
  %zext1 = zext i32 0 to i64
  br label %bb2

bb2:
  switch i32 0, label %bb10 [
  i32 0, label %bb9
  i32 11, label %bb9
  i32 1, label %bb4
  ]

bb3:
  switch i32 0, label %bb10 [
  i32 18, label %bb7
  i32 1, label %bb7
  i32 0, label %bb10
  ]

bb4:
  %phi = phi i64 [ %zext, %bb2 ]
  %phi5 = phi i64 [ %zext1, %bb2 ]
  %getelementptr = getelementptr i32, ptr null, i64 %phi
  %getelementptr6 = getelementptr i32, ptr null, i64 %phi5
  ret void

bb7:
  %phi8 = phi i64 [ %zext, %bb3 ], [ %zext, %bb3 ]
  br label %bb9

bb9:
  ret void

bb10:
  ret void
}
