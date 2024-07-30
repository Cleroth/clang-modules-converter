; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

declare void @llvm.assume(i1)
declare void @barrier()
declare void @use.v2i8(<2 x i8>)
declare void @use.i8(i8)

define i1 @or_ugt(i8 %x, i8 %y) {
; CHECK-LABEL: @or_ugt(
; CHECK-NEXT:    [[XN1:%.*]] = or i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[XN1]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xn1 = or i8 %x, %y
  %r = icmp ugt i8 %xn1, %x
  ret i1 %r
}

define <2 x i1> @or_ule(<2 x i8> %x, <2 x i8> %y) {
; CHECK-LABEL: @or_ule(
; CHECK-NEXT:    [[XN1:%.*]] = or <2 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq <2 x i8> [[XN1]], [[X]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %xn1 = or <2 x i8> %x, %y
  %r = icmp ule <2 x i8> %xn1, %x
  ret <2 x i1> %r
}

define <2 x i1> @or_slt_pos(<2 x i8> %xx, <2 x i8> %yy, <2 x i8> %z) {
; CHECK-LABEL: @or_slt_pos(
; CHECK-NEXT:    [[X:%.*]] = add <2 x i8> [[XX:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[Y:%.*]] = and <2 x i8> [[YY:%.*]], <i8 127, i8 127>
; CHECK-NEXT:    [[XN1:%.*]] = or <2 x i8> [[X]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp slt <2 x i8> [[X]], [[XN1]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %x = add <2 x i8> %xx, %z
  %y = and <2 x i8> %yy, <i8 127, i8 127>
  %xn1 = or <2 x i8> %x, %y
  %r = icmp slt <2 x i8> %x, %xn1
  ret <2 x i1> %r
}

define i1 @or_sle_pos(i8 %x, i8 %y) {
; CHECK-LABEL: @or_sle_pos(
; CHECK-NEXT:    [[NS:%.*]] = icmp sgt i8 [[Y:%.*]], -1
; CHECK-NEXT:    call void @llvm.assume(i1 [[NS]])
; CHECK-NEXT:    [[XN1:%.*]] = or i8 [[X:%.*]], [[Y]]
; CHECK-NEXT:    [[R:%.*]] = icmp sle i8 [[XN1]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %ns = icmp sge i8 %y, 0
  call void @llvm.assume(i1 %ns)
  %xn1 = or i8 %x, %y
  %r = icmp sle i8 %xn1, %x
  ret i1 %r
}

define i1 @or_sle_fail_maybe_neg(i8 %x, i8 %y) {
; CHECK-LABEL: @or_sle_fail_maybe_neg(
; CHECK-NEXT:    [[XN1:%.*]] = or i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp sle i8 [[XN1]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xn1 = or i8 %x, %y
  %r = icmp sle i8 %xn1, %x
  ret i1 %r
}

define i1 @or_eq_noundef(i8 %x, i8 noundef %y) {
; CHECK-LABEL: @or_eq_noundef(
; CHECK-NEXT:    [[XN1:%.*]] = or i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[XN1]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xn1 = or i8 %x, %y
  %r = icmp eq i8 %xn1, %x
  ret i1 %r
}

define i1 @or_eq_notY_eq_0(i8 %x, i8 %y) {
; CHECK-LABEL: @or_eq_notY_eq_0(
; CHECK-NEXT:    [[TMP1:%.*]] = and i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %ny = xor i8 %y, -1
  %or = or i8 %x, %ny
  %cmp = icmp eq i8 %or, %ny
  ret i1 %cmp
}

define i1 @or_eq_notY_eq_0_fail_multiuse(i8 %x, i8 %y) {
; CHECK-LABEL: @or_eq_notY_eq_0_fail_multiuse(
; CHECK-NEXT:    [[NY:%.*]] = xor i8 [[Y:%.*]], -1
; CHECK-NEXT:    [[OR:%.*]] = or i8 [[NY]], [[X:%.*]]
; CHECK-NEXT:    call void @use.i8(i8 [[OR]])
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[OR]], [[NY]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %ny = xor i8 %y, -1
  %or = or i8 %x, %ny
  call void @use.i8(i8 %or)
  %cmp = icmp eq i8 %or, %ny
  ret i1 %cmp
}

define i1 @or_ne_notY_eq_1s(i8 %x, i8 %y) {
; CHECK-LABEL: @or_ne_notY_eq_1s(
; CHECK-NEXT:    [[TMP1:%.*]] = or i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[TMP1]], -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %ny = xor i8 %y, -1
  %or = or i8 %x, %ny
  %cmp = icmp ne i8 %or, %x
  ret i1 %cmp
}

define i1 @or_ne_notY_eq_1s_fail_bad_not(i8 %x, i8 %y) {
; CHECK-LABEL: @or_ne_notY_eq_1s_fail_bad_not(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i8 [[Y:%.*]], 1
; CHECK-NEXT:    [[TMP2:%.*]] = or i8 [[TMP1]], [[X:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[TMP2]], -1
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %ny = xor i8 %y, -2
  %or = or i8 %x, %ny
  %cmp = icmp ne i8 %or, %x
  ret i1 %cmp
}

define <2 x i1> @or_ne_vecC(<2 x i8> %x) {
; CHECK-LABEL: @or_ne_vecC(
; CHECK-NEXT:    [[TMP1:%.*]] = and <2 x i8> [[X:%.*]], <i8 -10, i8 -43>
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne <2 x i8> [[TMP1]], zeroinitializer
; CHECK-NEXT:    ret <2 x i1> [[CMP]]
;
  %or = or <2 x i8> %x, <i8 9, i8 42>
  %cmp = icmp ne <2 x i8> %or, <i8 9, i8 42>
  ret <2 x i1> %cmp
}

define i1 @or_eq_fail_maybe_undef(i8 %x, i8 %y) {
; CHECK-LABEL: @or_eq_fail_maybe_undef(
; CHECK-NEXT:    [[XN1:%.*]] = or i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[XN1]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xn1 = or i8 %x, %y
  %r = icmp eq i8 %xn1, %x
  ret i1 %r
}

define <2 x i1> @or_ne_noundef(<2 x i8> %x, <2 x i8> noundef %y) {
; CHECK-LABEL: @or_ne_noundef(
; CHECK-NEXT:    [[XN1:%.*]] = or <2 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne <2 x i8> [[XN1]], [[X]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %xn1 = or <2 x i8> %x, %y
  %r = icmp ne <2 x i8> %xn1, %x
  ret <2 x i1> %r
}

define <2 x i1> @or_ne_noundef_fail_reuse(<2 x i8> %x, <2 x i8> noundef %y) {
; CHECK-LABEL: @or_ne_noundef_fail_reuse(
; CHECK-NEXT:    [[XN1:%.*]] = or <2 x i8> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne <2 x i8> [[XN1]], [[X]]
; CHECK-NEXT:    call void @use.v2i8(<2 x i8> [[XN1]])
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %xn1 = or <2 x i8> %x, %y
  %r = icmp ne <2 x i8> %xn1, %x
  call void @use.v2i8(<2 x i8> %xn1)
  ret <2 x i1> %r
}

define i1 @or_slt_intmin(i8 %x) {
; CHECK-LABEL: @or_slt_intmin(
; CHECK-NEXT:    [[XN1:%.*]] = or i8 [[X:%.*]], -128
; CHECK-NEXT:    [[R:%.*]] = icmp slt i8 [[XN1]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xn1 = or i8 %x, 128
  %r = icmp slt i8 %xn1, %x
  ret i1 %r
}

define <2 x i1> @or_slt_intmin_2(<2 x i8> %xx, <2 x i8> %z) {
; CHECK-LABEL: @or_slt_intmin_2(
; CHECK-NEXT:    [[X:%.*]] = add <2 x i8> [[XX:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[XN1:%.*]] = or <2 x i8> [[X]], <i8 -128, i8 -128>
; CHECK-NEXT:    [[R:%.*]] = icmp slt <2 x i8> [[X]], [[XN1]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %x = add <2 x i8> %xx, %z
  %xn1 = or <2 x i8> %x, <i8 128, i8 128>
  %r = icmp slt <2 x i8> %x, %xn1
  ret <2 x i1> %r
}

define i1 @or_sle_intmin_indirect_2(i8 %xx, i8 %C, i8 %z) {
; CHECK-LABEL: @or_sle_intmin_indirect_2(
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[C:%.*]], -128
; CHECK-NEXT:    br i1 [[CMP]], label [[NEG:%.*]], label [[POS:%.*]]
; CHECK:       neg:
; CHECK-NEXT:    [[X:%.*]] = add i8 [[XX:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[XN1:%.*]] = or i8 [[X]], -128
; CHECK-NEXT:    [[R:%.*]] = icmp sle i8 [[X]], [[XN1]]
; CHECK-NEXT:    ret i1 [[R]]
; CHECK:       pos:
; CHECK-NEXT:    call void @barrier()
; CHECK-NEXT:    ret i1 false
;
  %x = add i8 %xx, %z
  %NC = sub i8 0, %C
  %CP2 = and i8 %C, %NC
  %cmp = icmp slt i8 %CP2, 0
  br i1 %cmp, label %neg, label %pos
neg:
  %xn1 = or i8 %x, %CP2
  %r = icmp sle i8 %x, %xn1
  ret i1 %r
pos:
  call void @barrier()
  ret i1 0
}

define i1 @or_sge_intmin(i8 %x) {
; CHECK-LABEL: @or_sge_intmin(
; CHECK-NEXT:    [[XN1:%.*]] = or i8 [[X:%.*]], -128
; CHECK-NEXT:    [[R:%.*]] = icmp sge i8 [[XN1]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %xn1 = or i8 %x, 128
  %r = icmp sge i8 %xn1, %x
  ret i1 %r
}

define i1 @or_sgt_intmin_indirect(i8 %x, i8 %C) {
; CHECK-LABEL: @or_sgt_intmin_indirect(
; CHECK-NEXT:    [[C_NOT:%.*]] = icmp eq i8 [[C:%.*]], -128
; CHECK-NEXT:    br i1 [[C_NOT]], label [[NEG:%.*]], label [[POS:%.*]]
; CHECK:       neg:
; CHECK-NEXT:    [[XN1:%.*]] = or i8 [[X:%.*]], -128
; CHECK-NEXT:    [[R:%.*]] = icmp sgt i8 [[XN1]], [[X]]
; CHECK-NEXT:    ret i1 [[R]]
; CHECK:       pos:
; CHECK-NEXT:    call void @barrier()
; CHECK-NEXT:    ret i1 false
;
  %NC = sub i8 0, %C
  %CP2 = and i8 %C, %NC
  %c = icmp sge i8 %CP2, 0
  br i1 %c, label %pos, label %neg
neg:
  %xn1 = or i8 %x, %CP2
  %r = icmp sgt i8 %xn1, %x
  ret i1 %r
pos:
  call void @barrier()
  ret i1 0
}

define <2 x i1> @or_sgt_intmin_2(<2 x i8> %xx, <2 x i8> %z) {
; CHECK-LABEL: @or_sgt_intmin_2(
; CHECK-NEXT:    [[X:%.*]] = add <2 x i8> [[XX:%.*]], [[Z:%.*]]
; CHECK-NEXT:    [[XN1:%.*]] = or <2 x i8> [[X]], <i8 -128, i8 -128>
; CHECK-NEXT:    [[R:%.*]] = icmp sgt <2 x i8> [[X]], [[XN1]]
; CHECK-NEXT:    ret <2 x i1> [[R]]
;
  %x = add <2 x i8> %xx, %z
  %xn1 = or <2 x i8> %x, <i8 128, i8 128>
  %r = icmp sgt <2 x i8> %x, %xn1
  ret <2 x i1> %r
}

define i1 @or_simplify_ule(i8 %y_in, i8 %rhs_in, i1 %c) {
; CHECK-LABEL: @or_simplify_ule(
; CHECK-NEXT:    [[RHS:%.*]] = and i8 [[RHS_IN:%.*]], -2
; CHECK-NEXT:    [[Y:%.*]] = or i8 [[Y_IN:%.*]], [[RHS_IN]]
; CHECK-NEXT:    [[LBO:%.*]] = or i8 [[Y]], 1
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[LBO]], [[RHS]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = or i8 %y_in, 1
  %rhs = and i8 %rhs_in, -2
  %lbo = or i8 %y, %rhs
  %r = icmp ule i8 %lbo, %rhs
  ret i1 %r
}

define i1 @or_simplify_uge(i8 %y_in, i8 %rhs_in, i1 %c) {
; CHECK-LABEL: @or_simplify_uge(
; CHECK-NEXT:    ret i1 false
;
  %y = or i8 %y_in, 129
  %rhs = and i8 %rhs_in, 127
  %lbo = or i8 %y, %rhs
  %r = icmp uge i8 %rhs, %lbo
  ret i1 %r
}

define i1 @or_simplify_ule_fail(i8 %y_in, i8 %rhs_in) {
; CHECK-LABEL: @or_simplify_ule_fail(
; CHECK-NEXT:    [[RHS:%.*]] = and i8 [[RHS_IN:%.*]], 127
; CHECK-NEXT:    [[Y:%.*]] = or i8 [[RHS]], [[Y_IN:%.*]]
; CHECK-NEXT:    [[LBO:%.*]] = or i8 [[Y]], 64
; CHECK-NEXT:    [[R:%.*]] = icmp ule i8 [[LBO]], [[RHS]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = or i8 %y_in, 64
  %rhs = and i8 %rhs_in, 127
  %lbo = or i8 %y, %rhs
  %r = icmp ule i8 %lbo, %rhs
  ret i1 %r
}

define i1 @or_simplify_ugt(i8 %y_in, i8 %rhs_in) {
; CHECK-LABEL: @or_simplify_ugt(
; CHECK-NEXT:    [[RHS:%.*]] = and i8 [[RHS_IN:%.*]], -2
; CHECK-NEXT:    [[Y:%.*]] = or i8 [[Y_IN:%.*]], [[RHS_IN]]
; CHECK-NEXT:    [[LBO:%.*]] = or i8 [[Y]], 1
; CHECK-NEXT:    [[R:%.*]] = icmp ugt i8 [[LBO]], [[RHS]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = or i8 %y_in, 1
  %rhs = and i8 %rhs_in, -2
  %lbo = or i8 %y, %rhs
  %r = icmp ugt i8 %lbo, %rhs
  ret i1 %r
}

define i1 @or_simplify_ult(i8 %y_in, i8 %rhs_in) {
; CHECK-LABEL: @or_simplify_ult(
; CHECK-NEXT:    [[RHS:%.*]] = and i8 [[RHS_IN:%.*]], -5
; CHECK-NEXT:    [[Y:%.*]] = or i8 [[Y_IN:%.*]], [[RHS_IN]]
; CHECK-NEXT:    [[LBO:%.*]] = or i8 [[Y]], 36
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[RHS]], [[LBO]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = or i8 %y_in, 36
  %rhs = and i8 %rhs_in, -5
  %lbo = or i8 %y, %rhs
  %r = icmp ult i8 %rhs, %lbo
  ret i1 %r
}

define i1 @or_simplify_ugt_fail(i8 %y_in, i8 %rhs_in) {
; CHECK-LABEL: @or_simplify_ugt_fail(
; CHECK-NEXT:    [[RHS:%.*]] = or i8 [[RHS_IN:%.*]], 1
; CHECK-NEXT:    [[LBO:%.*]] = or i8 [[RHS]], [[Y_IN:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp ne i8 [[LBO]], [[RHS]]
; CHECK-NEXT:    ret i1 [[R]]
;
  %y = and i8 %y_in, -2
  %rhs = or i8 %rhs_in, 1
  %lbo = or i8 %y, %rhs
  %r = icmp ugt i8 %lbo, %rhs
  ret i1 %r
}

define i1 @pr64610(ptr %b) {
; CHECK-LABEL: @pr64610(
; CHECK-NEXT:    ret i1 true
;
  %v = load i1, ptr %b, align 2
  %s = select i1 %v, i32 74, i32 0
  %or = or i32 %s, 1
  %r = icmp ugt i32 %or, %s
  ret i1 %r
}

define i1 @icmp_eq_x_invertable_y2_todo(i8 %x, i1 %y, i8 %z) {
; CHECK-LABEL: @icmp_eq_x_invertable_y2_todo(
; CHECK-NEXT:    [[TMP1:%.*]] = select i1 [[Y:%.*]], i8 -8, i8 [[Z:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = and i8 [[TMP1]], [[X:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[TMP2]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %zz = xor i8 %z, -1
  %yy = select i1 %y, i8 7, i8 %zz
  %or = or i8 %x, %yy
  %r = icmp eq i8 %yy, %or
  ret i1 %r
}

define i1 @icmp_eq_x_invertable_y2(i8 %x, i8 %y) {
; CHECK-LABEL: @icmp_eq_x_invertable_y2(
; CHECK-NEXT:    [[TMP1:%.*]] = and i8 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[R:%.*]] = icmp eq i8 [[TMP1]], 0
; CHECK-NEXT:    ret i1 [[R]]
;
  %yy = xor i8 %y, -1
  %or = or i8 %x, %yy
  %r = icmp eq i8 %yy, %or
  ret i1 %r
}

define i1 @PR38139(i8 %arg) {
; CHECK-LABEL: @PR38139(
; CHECK-NEXT:    [[R:%.*]] = icmp ult i8 [[ARG:%.*]], -64
; CHECK-NEXT:    ret i1 [[R]]
;
  %masked = or i8 %arg, 192
  %r = icmp ne i8 %masked, %arg
  ret i1 %r
}
