; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=dse -S < %s | FileCheck %s

@global = external constant i8

define void @f() {
; CHECK-LABEL: @f(
; CHECK-NEXT:    [[TMP1:%.*]] = call noalias ptr @_Znwm(i64 32)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ugt ptr [[TMP1]], @global
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP2]])
; CHECK-NEXT:    store i8 0, ptr [[TMP1]], align 1
; CHECK-NEXT:    ret void
;
  %tmp1 = call noalias ptr @_Znwm(i64 32)
  %tmp2 = icmp ugt ptr %tmp1, @global
  call void @llvm.assume(i1 %tmp2)
  store i8 0, ptr %tmp1, align 1
  ret void
}

define void @f2() {
; CHECK-LABEL: @f2(
; CHECK-NEXT:    [[TMP1:%.*]] = call noalias ptr @_Znwm(i64 32)
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ugt ptr [[TMP1]], @global
; CHECK-NEXT:    call void @llvm.assume(i1 [[TMP2]])
; CHECK-NEXT:    store i8 0, ptr [[TMP1]], align 1
; CHECK-NEXT:    call void @quux(ptr @global)
; CHECK-NEXT:    ret void
;
  %tmp1 = call noalias ptr @_Znwm(i64 32)
  %tmp2 = icmp ugt ptr %tmp1, @global
  call void @llvm.assume(i1 %tmp2)
  store i8 0, ptr %tmp1, align 1
  call void @quux(ptr @global)
  ret void
}

; FIXME: This is a miscompile
define void @pr70547() {
; CHECK-LABEL: @pr70547(
; CHECK-NEXT:    [[A:%.*]] = alloca i8, align 1
; CHECK-NEXT:    store i8 0, ptr [[A]], align 1
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @quux(ptr [[A]]) #[[ATTR1:[0-9]+]]
; CHECK-NEXT:    [[V:%.*]] = load i8, ptr [[CALL]], align 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[V]], 1
; CHECK-NEXT:    call void @llvm.assume(i1 [[CMP]])
; CHECK-NEXT:    ret void
;
  %a = alloca i8
  store i8 0, ptr %a
  %call = call ptr @quux(ptr %a) memory(none) nounwind willreturn
  %v = load i8, ptr %call
  %cmp = icmp ne i8 %v, 1
  call void @llvm.assume(i1 %cmp)
  ret void
}

declare ptr @_Znwm(i64)

declare void @llvm.assume(i1)

declare void @quux(ptr)
