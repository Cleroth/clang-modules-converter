; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc  -mtriple=amdgcn-amd-amdhsa -o - %s | FileCheck %s

; The OR instruction should not be eliminated by the "OR Combine" DAG optimization.
define protected amdgpu_kernel void @_Z11test_kernelPii(ptr addrspace(1) nocapture %Ad.coerce, i32 %s) local_unnamed_addr #5 {
; CHECK-LABEL: _Z11test_kernelPii:
; CHECK:       ; %bb.0: ; %entry
; CHECK-NEXT:    s_load_dword s0, s[6:7], 0x2
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_cmp_lg_u32 s0, 3
; CHECK-NEXT:    s_cbranch_scc1 .LBB0_2
; CHECK-NEXT:  ; %bb.1: ; %if.then
; CHECK-NEXT:    s_load_dwordx2 s[2:3], s[6:7], 0x0
; CHECK-NEXT:    s_and_b32 s4, s0, 0xffff
; CHECK-NEXT:    s_mov_b32 s1, 0
; CHECK-NEXT:    s_mul_i32 s6, s4, 0xaaab
; CHECK-NEXT:    s_lshl_b64 s[4:5], s[0:1], 2
; CHECK-NEXT:    s_lshr_b32 s1, s6, 19
; CHECK-NEXT:    s_mul_i32 s1, s1, 12
; CHECK-NEXT:    s_sub_i32 s6, s0, s1
; CHECK-NEXT:    s_and_b32 s7, s6, 0xffff
; CHECK-NEXT:    s_waitcnt lgkmcnt(0)
; CHECK-NEXT:    s_add_u32 s0, s2, s4
; CHECK-NEXT:    s_addc_u32 s1, s3, s5
; CHECK-NEXT:    s_bfe_u32 s2, s6, 0xd0003
; CHECK-NEXT:    s_add_i32 s2, s2, s7
; CHECK-NEXT:    s_or_b32 s2, s2, 0xc0
; CHECK-NEXT:    v_mov_b32_e32 v0, s0
; CHECK-NEXT:    v_mov_b32_e32 v1, s1
; CHECK-NEXT:    v_mov_b32_e32 v2, s2
; CHECK-NEXT:    flat_store_dword v[0:1], v2
; CHECK-NEXT:  .LBB0_2: ; %if.end
; CHECK-NEXT:    s_endpgm
entry:
  %cmp = icmp eq i32 %s, 3
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %rem.lhs.trunc = trunc i32 %s to i16
  %rem4 = urem i16 %rem.lhs.trunc, 12
  %rem.zext = zext i16 %rem4 to i32
  %idxprom = zext i32 %s to i64
  %arrayidx3 = getelementptr inbounds i32, ptr addrspace(1) %Ad.coerce, i64 %idxprom
  %div = lshr i32 %rem.zext, 3
  %or = or i32 %rem.zext, 192
  %add = add nuw nsw i32 %or, %div
  store i32 %add, ptr addrspace(1) %arrayidx3, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}
