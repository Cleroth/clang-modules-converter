; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -passes=globalopt -o - < %s | FileCheck %s

@g = internal global ptr null, align 8

;.
; CHECK: @[[G_INIT:[a-zA-Z0-9_$"\\.-]+]] = internal unnamed_addr global i1 false
;.
define internal i32 @f1() {
; CHECK-LABEL: define {{[^@]+}}@f1() unnamed_addr {
; CHECK-NEXT:    [[G_INIT_VAL:%.*]] = load i1, ptr @g.init, align 1
; CHECK-NEXT:    call fastcc void @f2()
; CHECK-NEXT:    [[NOTINIT:%.*]] = xor i1 [[G_INIT_VAL]], true
; CHECK-NEXT:    br i1 [[NOTINIT]], label [[TMP1:%.*]], label [[TMP2:%.*]]
; CHECK:       1:
; CHECK-NEXT:    br label [[TMP3:%.*]]
; CHECK:       2:
; CHECK-NEXT:    br label [[TMP3]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = phi i32 [ -1, [[TMP1]] ], [ 1, [[TMP2]] ]
; CHECK-NEXT:    ret i32 [[TMP4]]
;
  %1 = load ptr, ptr @g, align 8
  call void @f2();
  %2 = icmp eq ptr %1, null
  br i1 %2, label %3, label %4

3:                                          ; preds = %0
  br label %5

4:                                          ; preds = %0
  br label %5

5:                                          ; preds = %3, %4
  %6 = phi i32 [ -1, %3 ], [ 1, %4 ]
  ret i32 %6
}

define internal void @f2() {
; CHECK-LABEL: define {{[^@]+}}@f2() unnamed_addr {
; CHECK-NEXT:    store i1 true, ptr @g.init, align 1
; CHECK-NEXT:    ret void
;
  %1 = call noalias ptr @malloc(i64 4)
  store ptr %1, ptr @g, align 8
  ret void
}

define dso_local i32 @main() {
; CHECK-LABEL: define {{[^@]+}}@main() local_unnamed_addr {
; CHECK-NEXT:    store i1 false, ptr @g.init, align 1
; CHECK-NEXT:    [[TMP1:%.*]] = call fastcc i32 @f1()
; CHECK-NEXT:    ret i32 [[TMP1]]
;
  store ptr null, ptr @g, align 8
  %1 = call i32 @f1()
  ret i32 %1
}

declare dso_local noalias ptr @malloc(i64) allockind("alloc,uninitialized") allocsize(0)
