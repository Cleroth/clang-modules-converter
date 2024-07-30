; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -S -passes=argpromotion < %s | FileCheck %s
define internal i32 @foo(ptr %x, i32 %n, i32 %m) {
; CHECK-LABEL: define internal i32 @foo(
; CHECK-SAME: i32 [[X_0_VAL:%.*]], i32 [[N:%.*]], i32 [[M:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i32 [[N]], 0
; CHECK-NEXT:    br i1 [[CMP]], label %[[COND_TRUE:.*]], label %[[COND_FALSE:.*]]
; CHECK:       [[COND_TRUE]]:
; CHECK-NEXT:    br label %[[RETURN:.*]]
; CHECK:       [[COND_FALSE]]:
; CHECK-NEXT:    [[SUBVAL:%.*]] = sub i32 [[N]], 1
; CHECK-NEXT:    [[CALLRET:%.*]] = call i32 @foo(i32 [[X_0_VAL]], i32 [[SUBVAL]], i32 [[X_0_VAL]])
; CHECK-NEXT:    [[SUBVAL2:%.*]] = sub i32 [[N]], 2
; CHECK-NEXT:    [[CALLRET2:%.*]] = call i32 @foo(i32 [[X_0_VAL]], i32 [[SUBVAL2]], i32 [[M]])
; CHECK-NEXT:    [[CMP2:%.*]] = add i32 [[CALLRET]], [[CALLRET2]]
; CHECK-NEXT:    br label %[[RETURN]]
; CHECK:       [[COND_NEXT:.*]]:
; CHECK-NEXT:    br label %[[RETURN]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    [[RETVAL_0:%.*]] = phi i32 [ [[X_0_VAL]], %[[COND_TRUE]] ], [ [[CMP2]], %[[COND_FALSE]] ], [ poison, %[[COND_NEXT]] ]
; CHECK-NEXT:    ret i32 [[RETVAL_0]]
;
entry:
  %cmp = icmp ne i32 %n, 0
  br i1 %cmp, label %cond_true, label %cond_false

cond_true:                                        ; preds = %entry
  %val = load i32, ptr %x, align 4
  br label %return

cond_false:                                       ; preds = %entry
  %val2 = load i32, ptr %x, align 4
  %subval = sub i32 %n, 1
  %callret = call i32 @foo(ptr %x, i32 %subval, i32 %val2)
  %subval2 = sub i32 %n, 2
  %callret2 = call i32 @foo(ptr %x, i32 %subval2, i32 %m)
  %cmp2 = add i32 %callret, %callret2
  br label %return

cond_next:                                        ; No predecessors!
  br label %return

return:                                           ; preds = %cond_next, %cond_false, %cond_true
  %retval.0 = phi i32 [ %val, %cond_true ], [ %cmp2, %cond_false ], [ poison, %cond_next ]
  ret i32 %retval.0
}

define i32 @bar(ptr align(4) dereferenceable(4) %x, i32 %n, i32 %m) {
; CHECK-LABEL: define i32 @bar(
; CHECK-SAME: ptr align 4 dereferenceable(4) [[X:%.*]], i32 [[N:%.*]], i32 [[M:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[X_VAL:%.*]] = load i32, ptr [[X]], align 4
; CHECK-NEXT:    [[CALLRET3:%.*]] = call i32 @foo(i32 [[X_VAL]], i32 [[N]], i32 [[M]])
; CHECK-NEXT:    br label %[[RETURN:.*]]
; CHECK:       [[RETURN]]:
; CHECK-NEXT:    ret i32 [[CALLRET3]]
;
entry:
  %callret3 = call i32 @foo(ptr %x, i32 %n, i32 %m)
  br label %return

return:                                           ; preds = %entry
  ret i32 %callret3
}
