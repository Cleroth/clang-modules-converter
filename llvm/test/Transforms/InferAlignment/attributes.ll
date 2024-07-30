; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=infer-alignment -S | FileCheck %s

define void @attribute(ptr align 32 %a) {
; CHECK-LABEL: define void @attribute
; CHECK-SAME: (ptr align 32 [[A:%.*]]) {
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[A]], align 32
; CHECK-NEXT:    store i32 123, ptr [[A]], align 32
; CHECK-NEXT:    ret void
;
  %load = load i32, ptr %a, align 1
  store i32 123, ptr %a, align 1
  ret void
}

define void @attribute_through_call(ptr align 32 %a) {
; CHECK-LABEL: define void @attribute_through_call
; CHECK-SAME: (ptr align 32 [[A:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = call ptr @call(ptr [[A]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[RES]], align 32
; CHECK-NEXT:    store i32 123, ptr [[RES]], align 32
; CHECK-NEXT:    ret void
;
  %res = call ptr @call(ptr %a)
  %load = load i32, ptr %res, align 1
  store i32 123, ptr %res, align 1
  ret void
}

define void @attribute_return_value(ptr %a) {
; CHECK-LABEL: define void @attribute_return_value
; CHECK-SAME: (ptr [[A:%.*]]) {
; CHECK-NEXT:    [[RES:%.*]] = call align 32 ptr @call(ptr [[A]])
; CHECK-NEXT:    [[LOAD:%.*]] = load i32, ptr [[RES]], align 32
; CHECK-NEXT:    store i32 123, ptr [[RES]], align 32
; CHECK-NEXT:    ret void
;
  %res = call align 32 ptr @call(ptr %a)
  %load = load i32, ptr %res, align 1
  store i32 123, ptr %res, align 1
  ret void
}

declare ptr @call(ptr returned)
