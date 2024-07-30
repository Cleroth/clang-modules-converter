; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 4
; RUN: opt -S --passes=slp-vectorizer -mtriple=riscv64-unknown-linux -pass-remarks-output=%t -mattr=+v -slp-threshold=-10 < %s | FileCheck %s
; RUN: FileCheck %s --check-prefix=YAML < %t

; YAML-LABEL: --- !Passed
; YAML-NEXT:  Pass:            slp-vectorizer
; YAML-NEXT:  Name:            StoresVectorized
; YAML-NEXT:  Function:        test
; YAML-NEXT:  Args:
; YAML-NEXT:  - String:          'Stores SLP vectorized with cost '
; YAML-NEXT:  - Cost:            '3'
; YAML-NEXT:  - String:          ' and with tree size '
; YAML-NEXT:  - TreeSize:        '7'

define void @test() {
; CHECK-LABEL: define void @test(
; CHECK-SAME: ) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP0:%.*]] = load float, ptr null, align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load float, ptr null, align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load float, ptr null, align 4
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <2 x float> <float poison, float 0.000000e+00>, float [[TMP1]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = insertelement <2 x float> poison, float [[TMP0]], i32 0
; CHECK-NEXT:    [[TMP5:%.*]] = insertelement <2 x float> [[TMP4]], float [[TMP2]], i32 1
; CHECK-NEXT:    [[TMP6:%.*]] = fcmp ogt <2 x float> [[TMP3]], [[TMP5]]
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <2 x i1> [[TMP6]], <2 x i1> poison, <4 x i32> <i32 0, i32 1, i32 0, i32 1>
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <2 x float> [[TMP5]], <2 x float> [[TMP3]], <4 x i32> <i32 0, i32 1, i32 2, i32 poison>
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <4 x float> [[TMP8]], <4 x float> <float poison, float poison, float poison, float 0.000000e+00>, <4 x i32> <i32 0, i32 1, i32 2, i32 7>
; CHECK-NEXT:    [[TMP10:%.*]] = select <4 x i1> [[TMP7]], <4 x float> [[TMP9]], <4 x float> zeroinitializer
; CHECK-NEXT:    store <4 x float> [[TMP10]], ptr null, align 4
; CHECK-NEXT:    ret void
;
entry:
  %0 = load float, ptr null, align 4
  %1 = load float, ptr null, align 4
  %2 = load float, ptr null, align 4
  %cmp.i = fcmp ogt float %1, %0
  %v14.0 = select i1 %cmp.i, float %1, float 0.000000e+00
  %v0.0 = select i1 %cmp.i, float %0, float 0.000000e+00
  %cmp4.i = fcmp ogt float 0.000000e+00, %2
  %v19.0 = select i1 %cmp4.i, float 0.000000e+00, float 0.000000e+00
  %v9.0 = select i1 %cmp4.i, float %2, float 0.000000e+00
  store float %v0.0, ptr null, align 4
  %v9idx = getelementptr i8, ptr null, i32 4
  store float %v9.0, ptr %v9idx, align 4
  %v14idx = getelementptr i8, ptr null, i32 8
  store float %v14.0, ptr %v14idx, align 4
  %v19idx = getelementptr i8, ptr null, i32 12
  store float %v19.0, ptr %v19idx, align 4
  ret void
}
