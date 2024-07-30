; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=globalopt < %s | FileCheck %s

; The global is stored once through a trivial GEP instruction (rather than
; GEP constant expression) here. We should still be able to optimize it.

%s = type { i32 }

@g = internal unnamed_addr global i32 undef

; CHECK-NOT: @g =

define void @store() {
; CHECK-LABEL: @store(
; CHECK-NEXT:    ret void
;
  store i32 1, ptr @g, align 4
  ret void
}

define i32 @load() {
; CHECK-LABEL: @load(
; CHECK-NEXT:    call fastcc void @store()
; CHECK-NEXT:    ret i32 1
;
  call fastcc void @store()
  %v = load i32, ptr @g
  ret i32 %v
}
