; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

; PR51305: prefer `-(x & 1)` over `(x << (bitwidth(x)-1)) a>> (bitwidth(x)-1)`
; as the pattern to splat the lowest bit.

declare void @use8(i8)

; Basic positive scalar tests
define i8 @t0(i8 %x) {
; CHECK-LABEL: @t0(
; CHECK-NEXT:    [[TMP1:%.*]] = and i8 [[X:%.*]], 1
; CHECK-NEXT:    [[R:%.*]] = sub nsw i8 0, [[TMP1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %i0 = shl i8 %x, 7
  %r = ashr i8 %i0, 7
  ret i8 %r
}
define i16 @t1_otherbitwidth(i16 %x) {
; CHECK-LABEL: @t1_otherbitwidth(
; CHECK-NEXT:    [[TMP1:%.*]] = and i16 [[X:%.*]], 1
; CHECK-NEXT:    [[R:%.*]] = sub nsw i16 0, [[TMP1]]
; CHECK-NEXT:    ret i16 [[R]]
;
  %i0 = shl i16 %x, 15
  %r = ashr i16 %i0, 15
  ret i16 %r
}

; Basic positive vector tests
define <2 x i8> @t2_vec(<2 x i8> %x) {
; CHECK-LABEL: @t2_vec(
; CHECK-NEXT:    [[TMP1:%.*]] = and <2 x i8> [[X:%.*]], <i8 1, i8 1>
; CHECK-NEXT:    [[R:%.*]] = sub nsw <2 x i8> zeroinitializer, [[TMP1]]
; CHECK-NEXT:    ret <2 x i8> [[R]]
;
  %i0 = shl <2 x i8> %x, <i8 7, i8 7>
  %r = ashr <2 x i8> %i0, <i8 7, i8 7>
  ret <2 x i8> %r
}

; TODO: The result constants should contain poison instead of undef.

define <3 x i8> @t3_vec_poison0(<3 x i8> %x) {
; CHECK-LABEL: @t3_vec_poison0(
; CHECK-NEXT:    [[TMP1:%.*]] = and <3 x i8> [[X:%.*]], <i8 1, i8 undef, i8 1>
; CHECK-NEXT:    [[R:%.*]] = sub <3 x i8> zeroinitializer, [[TMP1]]
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %i0 = shl <3 x i8> %x, <i8 7, i8 poison, i8 7>
  %r = ashr <3 x i8> %i0, <i8 7, i8 7, i8 7>
  ret <3 x i8> %r
}
define <3 x i8> @t4_vec_poison1(<3 x i8> %x) {
; CHECK-LABEL: @t4_vec_poison1(
; CHECK-NEXT:    [[TMP1:%.*]] = and <3 x i8> [[X:%.*]], <i8 1, i8 undef, i8 1>
; CHECK-NEXT:    [[R:%.*]] = sub <3 x i8> zeroinitializer, [[TMP1]]
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %i0 = shl <3 x i8> %x, <i8 7, i8 7, i8 7>
  %r = ashr <3 x i8> %i0, <i8 7, i8 poison, i8 7>
  ret <3 x i8> %r
}
define <3 x i8> @t5_vec_poison2(<3 x i8> %x) {
; CHECK-LABEL: @t5_vec_poison2(
; CHECK-NEXT:    [[TMP1:%.*]] = and <3 x i8> [[X:%.*]], <i8 1, i8 undef, i8 1>
; CHECK-NEXT:    [[R:%.*]] = sub <3 x i8> zeroinitializer, [[TMP1]]
; CHECK-NEXT:    ret <3 x i8> [[R]]
;
  %i0 = shl <3 x i8> %x, <i8 7, i8 poison, i8 7>
  %r = ashr <3 x i8> %i0, <i8 7, i8 poison, i8 7>
  ret <3 x i8> %r
}

; In general, the `shl` needs to go away.
define i8 @n6_extrause(i8 %x) {
; CHECK-LABEL: @n6_extrause(
; CHECK-NEXT:    [[I0:%.*]] = shl i8 [[X:%.*]], 7
; CHECK-NEXT:    call void @use8(i8 [[I0]])
; CHECK-NEXT:    [[R:%.*]] = ashr exact i8 [[I0]], 7
; CHECK-NEXT:    ret i8 [[R]]
;
  %i0 = shl i8 %x, 7
  call void @use8(i8 %i0)
  %r = ashr i8 %i0, 7
  ret i8 %r
}

; But, if the input to the shift is already masked, then we're fine.
define i8 @t7_already_masked(i8 %x) {
; CHECK-LABEL: @t7_already_masked(
; CHECK-NEXT:    [[I0:%.*]] = and i8 [[X:%.*]], 1
; CHECK-NEXT:    call void @use8(i8 [[I0]])
; CHECK-NEXT:    [[TMP1:%.*]] = and i8 [[X]], 1
; CHECK-NEXT:    [[R:%.*]] = sub nsw i8 0, [[TMP1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %i0 = and i8 %x, 1
  call void @use8(i8 %i0)
  %i1 = shl i8 %i0, 7
  %r = ashr i8 %i1, 7
  ret i8 %r
}
; FIXME: we should fold this
define i8 @t8_already_masked_extrause(i8 %x) {
; CHECK-LABEL: @t8_already_masked_extrause(
; CHECK-NEXT:    [[I0:%.*]] = and i8 [[X:%.*]], 1
; CHECK-NEXT:    call void @use8(i8 [[I0]])
; CHECK-NEXT:    [[I1:%.*]] = shl i8 [[X]], 7
; CHECK-NEXT:    call void @use8(i8 [[I1]])
; CHECK-NEXT:    [[R:%.*]] = ashr exact i8 [[I1]], 7
; CHECK-NEXT:    ret i8 [[R]]
;
  %i0 = and i8 %x, 1
  call void @use8(i8 %i0)
  %i1 = shl i8 %i0, 7
  call void @use8(i8 %i1)
  %r = ashr i8 %i1, 7
  ret i8 %r
}
define i8 @n9_wrongly_masked_extrause(i8 %x) {
; CHECK-LABEL: @n9_wrongly_masked_extrause(
; CHECK-NEXT:    [[I0:%.*]] = and i8 [[X:%.*]], 3
; CHECK-NEXT:    call void @use8(i8 [[I0]])
; CHECK-NEXT:    [[I1:%.*]] = shl i8 [[X]], 7
; CHECK-NEXT:    call void @use8(i8 [[I1]])
; CHECK-NEXT:    [[R:%.*]] = ashr exact i8 [[I1]], 7
; CHECK-NEXT:    ret i8 [[R]]
;
  %i0 = and i8 %x, 3
  call void @use8(i8 %i0)
  %i1 = shl i8 %i0, 7
  call void @use8(i8 %i1)
  %r = ashr i8 %i1, 7
  ret i8 %r
}

; Wrong shift amounts
define i8 @n10(i8 %x) {
; CHECK-LABEL: @n10(
; CHECK-NEXT:    [[I0:%.*]] = shl i8 [[X:%.*]], 6
; CHECK-NEXT:    [[R:%.*]] = ashr i8 [[I0]], 7
; CHECK-NEXT:    ret i8 [[R]]
;
  %i0 = shl i8 %x, 6 ; not 7
  %r = ashr i8 %i0, 7
  ret i8 %r
}
define i8 @n11(i8 %x) {
; CHECK-LABEL: @n11(
; CHECK-NEXT:    [[I0:%.*]] = shl i8 [[X:%.*]], 7
; CHECK-NEXT:    [[R:%.*]] = ashr exact i8 [[I0]], 6
; CHECK-NEXT:    ret i8 [[R]]
;
  %i0 = shl i8 %x, 7
  %r = ashr i8 %i0, 6 ; not 7
  ret i8 %r
}
define i8 @n12(i8 %x) {
; CHECK-LABEL: @n12(
; CHECK-NEXT:    [[I0:%.*]] = shl i8 [[X:%.*]], 6
; CHECK-NEXT:    [[R:%.*]] = ashr exact i8 [[I0]], 6
; CHECK-NEXT:    ret i8 [[R]]
;
  %i0 = shl i8 %x, 6 ; not 7
  %r = ashr i8 %i0, 6 ; not 7
  ret i8 %r
}