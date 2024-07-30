; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=x86_64-unknown-linux-gnu -passes=load-store-vectorizer -S -o - %s | FileCheck %s
; RUN: opt -mtriple=x86_64-unknown-linux-gnu -aa-pipeline=basic-aa -passes='function(load-store-vectorizer)' -S -o - %s | FileCheck %s

target datalayout = "e-m:e-i64:64-i128:128-n32:64-S128"

define void @correct_order(ptr noalias %ptr) {
; CHECK-LABEL: @correct_order(
; CHECK-NEXT:    [[NEXT_GEP1:%.*]] = getelementptr i32, ptr [[PTR:%.*]], i64 1
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i32>, ptr [[PTR]], align 4
; CHECK-NEXT:    [[L21:%.*]] = extractelement <2 x i32> [[TMP1]], i32 0
; CHECK-NEXT:    [[L12:%.*]] = extractelement <2 x i32> [[TMP1]], i32 1
; CHECK-NEXT:    store <2 x i32> zeroinitializer, ptr [[PTR]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i32>, ptr [[NEXT_GEP1]], align 4
; CHECK-NEXT:    [[L33:%.*]] = extractelement <2 x i32> [[TMP2]], i32 0
; CHECK-NEXT:    [[L44:%.*]] = extractelement <2 x i32> [[TMP2]], i32 1
; CHECK-NEXT:    ret void
;
  %next.gep1 = getelementptr i32, ptr %ptr, i64 1
  %next.gep2 = getelementptr i32, ptr %ptr, i64 2

  %l1 = load i32, ptr %next.gep1, align 4
  %l2 = load i32, ptr %ptr, align 4
  store i32 0, ptr %next.gep1, align 4
  store i32 0, ptr %ptr, align 4
  %l3 = load i32, ptr %next.gep1, align 4
  %l4 = load i32, ptr %next.gep2, align 4

  ret void
}

