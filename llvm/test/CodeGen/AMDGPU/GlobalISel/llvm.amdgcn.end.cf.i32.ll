; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel -mtriple=amdgcn--amdhsa -mcpu=gfx1010 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX10 %s
; RUN: llc -global-isel -mtriple=amdgcn--amdhsa -mcpu=gfx1100 -amdgpu-enable-delay-alu=0 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX11 %s

define amdgpu_kernel void @test_wave32(i32 %arg0, [8 x i32], i32 %saved) {
; GFX10-LABEL: test_wave32:
; GFX10:       ; %bb.0: ; %entry
; GFX10-NEXT:    s_load_dword s0, s[6:7], 0x0
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_cmp_lg_u32 s0, 0
; GFX10-NEXT:    s_cbranch_scc1 .LBB0_2
; GFX10-NEXT:  ; %bb.1: ; %mid
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    global_store_dword v[0:1], v0, off
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:  .LBB0_2: ; %bb
; GFX10-NEXT:    s_load_dword s0, s[6:7], 0x24
; GFX10-NEXT:    s_waitcnt lgkmcnt(0)
; GFX10-NEXT:    s_waitcnt_depctr 0xffe3
; GFX10-NEXT:    s_or_b32 exec_lo, exec_lo, s0
; GFX10-NEXT:    v_mov_b32_e32 v0, 0
; GFX10-NEXT:    global_store_dword v[0:1], v0, off
; GFX10-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX10-NEXT:    s_endpgm
;
; GFX11-LABEL: test_wave32:
; GFX11:       ; %bb.0: ; %entry
; GFX11-NEXT:    s_load_b32 s0, s[2:3], 0x0
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_cmp_lg_u32 s0, 0
; GFX11-NEXT:    s_cbranch_scc1 .LBB0_2
; GFX11-NEXT:  ; %bb.1: ; %mid
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off dlc
; GFX11-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX11-NEXT:  .LBB0_2: ; %bb
; GFX11-NEXT:    s_load_b32 s0, s[2:3], 0x24
; GFX11-NEXT:    s_waitcnt lgkmcnt(0)
; GFX11-NEXT:    s_or_b32 exec_lo, exec_lo, s0
; GFX11-NEXT:    v_mov_b32_e32 v0, 0
; GFX11-NEXT:    global_store_b32 v[0:1], v0, off dlc
; GFX11-NEXT:    s_waitcnt_vscnt null, 0x0
; GFX11-NEXT:    s_nop 0
; GFX11-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX11-NEXT:    s_endpgm
entry:
  %cond = icmp eq i32 %arg0, 0
  br i1 %cond, label %mid, label %bb

mid:
  store volatile i32 0, ptr addrspace(1) undef
  br label %bb

bb:
  call void @llvm.amdgcn.end.cf.i32(i32 %saved)
  store volatile i32 0, ptr addrspace(1) undef
  ret void
}

declare void @llvm.amdgcn.end.cf.i32(i32 %val)
