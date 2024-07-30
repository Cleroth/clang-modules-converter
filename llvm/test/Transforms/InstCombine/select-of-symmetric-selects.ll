; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define i32 @select_of_symmetric_selects(i32 %a, i32 %b, i1 %c1, i1 %c2) {
; CHECK-LABEL: @select_of_symmetric_selects(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i1 [[C1:%.*]], [[C2:%.*]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[TMP1]], i32 [[B:%.*]], i32 [[A:%.*]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %sel1 = select i1 %c1, i32 %a, i32 %b
  %sel2 = select i1 %c1, i32 %b, i32 %a
  %ret = select i1 %c2, i32 %sel1, i32 %sel2
  ret i32 %ret
}

define i32 @select_of_symmetric_selects_negative1(i32 %a, i32 %b, i1 %c1, i1 %c2) {
; CHECK-LABEL: @select_of_symmetric_selects_negative1(
; CHECK-NEXT:    [[SEL1:%.*]] = select i1 [[C1:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[C2:%.*]], i32 [[SEL1]], i32 [[A]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %sel1 = select i1 %c1, i32 %a, i32 %b
  %sel2 = select i1 %c2, i32 %b, i32 %a
  %ret = select i1 %c2, i32 %sel1, i32 %sel2
  ret i32 %ret
}

define i32 @select_of_symmetric_selects_negative2(i32 %a, i32 %b, i32 %c, i1 %c1, i1 %c2) {
; CHECK-LABEL: @select_of_symmetric_selects_negative2(
; CHECK-NEXT:    [[SEL1:%.*]] = select i1 [[C1:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]
; CHECK-NEXT:    [[SEL2:%.*]] = select i1 [[C1]], i32 [[B]], i32 [[C:%.*]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[C2:%.*]], i32 [[SEL1]], i32 [[SEL2]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %sel1 = select i1 %c1, i32 %a, i32 %b
  %sel2 = select i1 %c1, i32 %b, i32 %c
  %ret = select i1 %c2, i32 %sel1, i32 %sel2
  ret i32 %ret
}

declare void @use(i32)

define i32 @select_of_symmetric_selects_multi_use1(i32 %a, i32 %b, i1 %c1, i1 %c2) {
; CHECK-LABEL: @select_of_symmetric_selects_multi_use1(
; CHECK-NEXT:    [[SEL1:%.*]] = select i1 [[C1:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]
; CHECK-NEXT:    [[SEL2:%.*]] = select i1 [[C1]], i32 [[B]], i32 [[A]]
; CHECK-NEXT:    call void @use(i32 [[SEL2]])
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[C2:%.*]], i32 [[SEL1]], i32 [[SEL2]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %sel1 = select i1 %c1, i32 %a, i32 %b
  %sel2 = select i1 %c1, i32 %b, i32 %a
  call void @use(i32 %sel2)
  %ret = select i1 %c2, i32 %sel1, i32 %sel2
  ret i32 %ret
}

define i32 @select_of_symmetric_selects_multi_use2(i32 %a, i32 %b, i1 %c1, i1 %c2) {
; CHECK-LABEL: @select_of_symmetric_selects_multi_use2(
; CHECK-NEXT:    [[SEL1:%.*]] = select i1 [[C1:%.*]], i32 [[A:%.*]], i32 [[B:%.*]]
; CHECK-NEXT:    call void @use(i32 [[SEL1]])
; CHECK-NEXT:    [[SEL2:%.*]] = select i1 [[C1]], i32 [[B]], i32 [[A]]
; CHECK-NEXT:    call void @use(i32 [[SEL2]])
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[C2:%.*]], i32 [[SEL1]], i32 [[SEL2]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %sel1 = select i1 %c1, i32 %a, i32 %b
  call void @use(i32 %sel1)
  %sel2 = select i1 %c1, i32 %b, i32 %a
  call void @use(i32 %sel2)
  %ret = select i1 %c2, i32 %sel1, i32 %sel2
  ret i32 %ret
}

define i32 @select_of_symmetric_selects_commuted(i32 %a, i32 %b, i1 %c1, i1 %c2) {
; CHECK-LABEL: @select_of_symmetric_selects_commuted(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i1 [[C1:%.*]], [[C2:%.*]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[TMP1]], i32 [[A:%.*]], i32 [[B:%.*]]
; CHECK-NEXT:    ret i32 [[RET]]
;
  %sel1 = select i1 %c1, i32 %a, i32 %b
  %sel2 = select i1 %c1, i32 %b, i32 %a
  %ret = select i1 %c2, i32 %sel2, i32 %sel1
  ret i32 %ret
}

define <4 x i32> @select_of_symmetric_selects_vector1(<4 x i32> %a, <4 x i32> %b, i1 %c1, i1 %c2) {
; CHECK-LABEL: @select_of_symmetric_selects_vector1(
; CHECK-NEXT:    [[TMP1:%.*]] = xor i1 [[C1:%.*]], [[C2:%.*]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[TMP1]], <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[RET]]
;
  %sel1 = select i1 %c1, <4 x i32> %a, <4 x i32> %b
  %sel2 = select i1 %c1, <4 x i32> %b, <4 x i32> %a
  %ret = select i1 %c2, <4 x i32> %sel2, <4 x i32> %sel1
  ret <4 x i32> %ret
}

define <4 x i32> @select_of_symmetric_selects_vector2(<4 x i32> %a, <4 x i32> %b, <4 x i1> %c1, <4 x i1> %c2) {
; CHECK-LABEL: @select_of_symmetric_selects_vector2(
; CHECK-NEXT:    [[TMP1:%.*]] = xor <4 x i1> [[C1:%.*]], [[C2:%.*]]
; CHECK-NEXT:    [[RET:%.*]] = select <4 x i1> [[TMP1]], <4 x i32> [[A:%.*]], <4 x i32> [[B:%.*]]
; CHECK-NEXT:    ret <4 x i32> [[RET]]
;
  %sel1 = select <4 x i1> %c1, <4 x i32> %a, <4 x i32> %b
  %sel2 = select <4 x i1> %c1, <4 x i32> %b, <4 x i32> %a
  %ret = select <4 x i1> %c2, <4 x i32> %sel2, <4 x i32> %sel1
  ret <4 x i32> %ret
}

define <2 x i32> @select_of_symmetric_selects_vector3(<2 x i32> %a, <2 x i32> %b, <2 x i1> %c1, i1 %c2) {
; CHECK-LABEL: @select_of_symmetric_selects_vector3(
; CHECK-NEXT:    [[SEL1:%.*]] = select <2 x i1> [[C1:%.*]], <2 x i32> [[A:%.*]], <2 x i32> [[B:%.*]]
; CHECK-NEXT:    [[SEL2:%.*]] = select <2 x i1> [[C1]], <2 x i32> [[B]], <2 x i32> [[A]]
; CHECK-NEXT:    [[RET:%.*]] = select i1 [[C2:%.*]], <2 x i32> [[SEL1]], <2 x i32> [[SEL2]]
; CHECK-NEXT:    ret <2 x i32> [[RET]]
;
  %sel1 = select <2 x i1> %c1, <2 x i32> %a, <2 x i32> %b
  %sel2 = select <2 x i1> %c1, <2 x i32> %b, <2 x i32> %a
  %ret = select i1 %c2, <2 x i32> %sel1, <2 x i32> %sel2
  ret <2 x i32> %ret
  }
