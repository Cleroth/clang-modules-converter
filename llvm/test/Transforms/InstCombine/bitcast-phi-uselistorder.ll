; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=instcombine < %s | FileCheck %s

@Q = internal unnamed_addr global double 1.000000e+00, align 8

define double @test(i1 %c, ptr %p) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[IF:%.*]], label [[END:%.*]]
; CHECK:       if:
; CHECK-NEXT:    [[LOAD1:%.*]] = load double, ptr @Q, align 8
; CHECK-NEXT:    br label [[END]]
; CHECK:       end:
; CHECK-NEXT:    [[TMP0:%.*]] = phi double [ 0.000000e+00, [[ENTRY:%.*]] ], [ [[LOAD1]], [[IF]] ]
; CHECK-NEXT:    store double [[TMP0]], ptr [[P:%.*]], align 8
; CHECK-NEXT:    ret double [[TMP0]]
;
entry:
  br i1 %c, label %if, label %end

if:
  %load = load i64, ptr @Q, align 8
  br label %end

end:
  %phi = phi i64 [ 0, %entry ], [ %load, %if ]
  store i64 %phi, ptr %p, align 8
  %cast = bitcast i64 %phi to double
  ret double %cast

  uselistorder i64 %phi, { 1, 0 }
}
