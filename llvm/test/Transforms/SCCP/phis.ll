; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt < %s -passes=sccp -S | FileCheck %s

define i1 @float.1(i1 %cmp) {
; CHECK-LABEL: define i1 @float.1(
; CHECK-SAME: i1 [[CMP:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br i1 [[CMP]], label %[[IF_TRUE:.*]], label %[[END:.*]]
; CHECK:       [[IF_TRUE]]:
; CHECK-NEXT:    br label %[[END]]
; CHECK:       [[END]]:
; CHECK-NEXT:    ret i1 true
;
entry:
  br i1 %cmp, label %if.true, label %end

if.true:
  br label %end

end:
  %p = phi float [ 1.0, %entry ], [ 1.0, %if.true]
  %c = fcmp ueq float %p, 1.0
  ret i1 %c
}

define i1 @float.2(i1 %cmp) {
; CHECK-LABEL: define i1 @float.2(
; CHECK-SAME: i1 [[CMP:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 [[CMP]], label %[[IF_TRUE:.*]], label %[[END:.*]]
; CHECK:       [[IF_TRUE]]:
; CHECK-NEXT:    br label %[[END]]
; CHECK:       [[END]]:
; CHECK-NEXT:    [[P:%.*]] = phi float [ 1.000000e+00, %[[ENTRY]] ], [ 2.000000e+00, %[[IF_TRUE]] ]
; CHECK-NEXT:    [[C:%.*]] = fcmp ueq float [[P]], 1.000000e+00
; CHECK-NEXT:    ret i1 [[C]]
;
entry:
  br i1 %cmp, label %if.true, label %end

if.true:
  br label %end

end:
  %p = phi float [ 1.0, %entry ], [ 2.0, %if.true]
  %c = fcmp ueq float %p, 1.0
  ret i1 %c
}

define i1 @float.3(float %f, i1 %cmp) {
; CHECK-LABEL: define i1 @float.3(
; CHECK-SAME: float [[F:%.*]], i1 [[CMP:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 [[CMP]], label %[[IF_TRUE:.*]], label %[[END:.*]]
; CHECK:       [[IF_TRUE]]:
; CHECK-NEXT:    br label %[[END]]
; CHECK:       [[END]]:
; CHECK-NEXT:    [[P:%.*]] = phi float [ 1.000000e+00, %[[ENTRY]] ], [ [[F]], %[[IF_TRUE]] ]
; CHECK-NEXT:    [[C:%.*]] = fcmp ueq float [[P]], 1.000000e+00
; CHECK-NEXT:    ret i1 [[C]]
;

entry:
  br i1 %cmp, label %if.true, label %end

if.true:
  br label %end

end:
  %p = phi float [ 1.0, %entry ], [ %f, %if.true]
  %c = fcmp ueq float %p, 1.0
  ret i1 %c
}


define i1 @float.4_unreachable(float %f, i1 %cmp) {
; CHECK-LABEL: define i1 @float.4_unreachable(
; CHECK-SAME: float [[F:%.*]], i1 [[CMP:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    br i1 [[CMP]], label %[[IF_TRUE:.*]], label %[[END:.*]]
; CHECK:       [[IF_TRUE]]:
; CHECK-NEXT:    br label %[[END]]
; CHECK:       [[END]]:
; CHECK-NEXT:    ret i1 false
;

entry:
  br i1 %cmp, label %if.true, label %end

if.true:
  br label %end

dead:
  br label %end

end:
  %p = phi float [ 1.0, %entry ], [ 1.0, %if.true], [ %f, %dead ]
  %c = fcmp une float %p, 1.0
  ret i1 %c
}

define <2 x i16> @phi_vector_merge1(i1 %c, <2 x i8> %a) {
; CHECK-LABEL: define <2 x i16> @phi_vector_merge1(
; CHECK-SAME: i1 [[C:%.*]], <2 x i8> [[A:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[ZEXT:%.*]] = zext <2 x i8> [[A]] to <2 x i16>
; CHECK-NEXT:    br i1 [[C]], label %[[IF:.*]], label %[[JOIN:.*]]
; CHECK:       [[IF]]:
; CHECK-NEXT:    br label %[[JOIN]]
; CHECK:       [[JOIN]]:
; CHECK-NEXT:    [[PHI:%.*]] = phi <2 x i16> [ [[ZEXT]], %[[ENTRY]] ], [ <i16 1, i16 2>, %[[IF]] ]
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw <2 x i16> [[PHI]], <i16 2, i16 3>
; CHECK-NEXT:    ret <2 x i16> [[ADD]]
;
entry:
  %zext = zext <2 x i8> %a to <2 x i16>
  br i1 %c, label %if, label %join

if:
  br label %join

join:
  %phi = phi <2 x i16> [ %zext, %entry ], [ <i16 1, i16 2>, %if ]
  %add = add <2 x i16> %phi, <i16 2, i16 3>
  ret <2 x i16> %add
}

define <2 x i16> @phi_vector_merge2(i1 %c, <2 x i8> %a) {
; CHECK-LABEL: define <2 x i16> @phi_vector_merge2(
; CHECK-SAME: i1 [[C:%.*]], <2 x i8> [[A:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    [[ZEXT:%.*]] = zext <2 x i8> [[A]] to <2 x i16>
; CHECK-NEXT:    br i1 [[C]], label %[[IF:.*]], label %[[JOIN:.*]]
; CHECK:       [[IF]]:
; CHECK-NEXT:    br label %[[JOIN]]
; CHECK:       [[JOIN]]:
; CHECK-NEXT:    [[PHI:%.*]] = phi <2 x i16> [ <i16 1, i16 2>, %[[ENTRY]] ], [ [[ZEXT]], %[[IF]] ]
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw <2 x i16> [[PHI]], <i16 2, i16 3>
; CHECK-NEXT:    ret <2 x i16> [[ADD]]
;
entry:
  %zext = zext <2 x i8> %a to <2 x i16>
  br i1 %c, label %if, label %join

if:
  br label %join

join:
  %phi = phi <2 x i16> [ <i16 1, i16 2>, %entry ], [ %zext, %if ]
  %add = add <2 x i16> %phi, <i16 2, i16 3>
  ret <2 x i16> %add
}

define <2 x float> @phi_vector_merge_float(i1 %c) {
; CHECK-LABEL: define <2 x float> @phi_vector_merge_float(
; CHECK-SAME: i1 [[C:%.*]]) {
; CHECK-NEXT:  [[ENTRY:.*]]:
; CHECK-NEXT:    br i1 [[C]], label %[[IF:.*]], label %[[JOIN:.*]]
; CHECK:       [[IF]]:
; CHECK-NEXT:    br label %[[JOIN]]
; CHECK:       [[JOIN]]:
; CHECK-NEXT:    [[PHI:%.*]] = phi <2 x float> [ <float 2.000000e+00, float 1.000000e+00>, %[[ENTRY]] ], [ <float 1.000000e+00, float 2.000000e+00>, %[[IF]] ]
; CHECK-NEXT:    ret <2 x float> [[PHI]]
;
entry:
  br i1 %c, label %if, label %join

if:
  br label %join

join:
  %phi = phi <2 x float> [ <float 2.0, float 1.0>, %entry ], [ <float 1.0, float 2.0>, %if ]
  ret <2 x float> %phi
}
