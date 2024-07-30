; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn-- -mcpu=fiji -data-layout=A5 -passes=amdgpu-promote-alloca < %s | FileCheck -check-prefix=OPT %s

define i64 @test_pointer_array(i64 %v) {
; OPT-LABEL: @test_pointer_array(
; OPT-NEXT:  entry:
; OPT-NEXT:    [[TMP0:%.*]] = inttoptr i64 [[V:%.*]] to ptr
; OPT-NEXT:    [[TMP1:%.*]] = insertelement <3 x ptr> undef, ptr [[TMP0]], i32 0
; OPT-NEXT:    ret i64 [[V]]
;
entry:
  %a = alloca [3 x ptr], align 16, addrspace(5)
  store i64 %v, ptr addrspace(5) %a, align 16
  %ld = load i64, ptr addrspace(5) %a, align 16
  ret i64 %ld
}
