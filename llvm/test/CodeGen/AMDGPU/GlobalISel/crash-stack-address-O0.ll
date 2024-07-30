; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -O0 -mtriple=amdgcn-amd-amdhsa -mcpu=fiji -o - %s | FileCheck %s

; Make sure there's no crash at -O0 when matching MUBUF addressing
; modes for the stack.

define amdgpu_kernel void @stack_write_fi() {
; CHECK-LABEL: stack_write_fi:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_add_u32 s0, s0, s15
; CHECK-NEXT:    s_addc_u32 s1, s1, 0
; CHECK-NEXT:    s_mov_b32 s5, 0
; CHECK-NEXT:    s_mov_b32 s4, 0
; CHECK-NEXT:    v_mov_b32_e32 v0, s5
; CHECK-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    v_mov_b32_e32 v0, s4
; CHECK-NEXT:    buffer_store_dword v0, off, s[0:3], 0 offset:4
; CHECK-NEXT:    s_waitcnt vmcnt(0)
; CHECK-NEXT:    s_endpgm
entry:
  %alloca = alloca i64, align 4, addrspace(5)
  store volatile i64 0, ptr addrspace(5) %alloca, align 4
  ret void
}

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"amdhsa_code_object_version", i32 500}