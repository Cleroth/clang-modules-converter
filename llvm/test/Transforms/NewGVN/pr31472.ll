; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=newgvn -S | FileCheck %s
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.12.0"

;; Ensure the invoke does not accidentally get deleted as unused, just because the value is not used.

; Function Attrs: norecurse ssp uwtable
define i32 @main() personality ptr @__gxx_personality_v0{
; CHECK-LABEL: @main(
; CHECK-NEXT:    [[TMP1:%.*]] = invoke i32 @foo()
; CHECK-NEXT:            to label [[GOOD:%.*]] unwind label [[BAD:%.*]]
; CHECK:       good:
; CHECK-NEXT:    ret i32 5
; CHECK:       bad:
; CHECK-NEXT:    [[TMP2:%.*]] = landingpad { ptr, i32 }
; CHECK-NEXT:            cleanup
; CHECK-NEXT:    resume { ptr, i32 } [[TMP2]]
;
  %1 = invoke i32 @foo()
  to label %good unwind label %bad

good:
; <label>:15:                                     ; preds = %.preheader
  ret i32 5


bad:
; <label>:20:                                     ; preds = %15, %.preheader
  %2 = landingpad { ptr, i32 }
  cleanup
  resume { ptr, i32 } %2
}

declare i32 @foo()
declare i32 @__gxx_personality_v0(...)
