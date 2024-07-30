; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=amdgcn -verify-machineinstrs < %s | FileCheck --check-prefix=GFX6 %s
; RUN: llc -mtriple=amdgcn--amdhsa -mcpu=kaveri -verify-machineinstrs < %s | FileCheck --check-prefix=GFX7 %s
; RUN: llc -mtriple=amdgcn -mcpu=tonga -verify-machineinstrs < %s | FileCheck --check-prefix=GFX8 %s
; RUN: llc -mtriple=r600 -mcpu=redwood < %s | FileCheck --check-prefix=EG %s
; RUN: llc -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX12 %s

define amdgpu_kernel void @constant_load_i64(ptr addrspace(1) %out, ptr addrspace(4) %in) #0 {
; GFX6-LABEL: constant_load_i64:
; GFX6:       ; %bb.0:
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dwordx2 s[4:5], s[2:3], 0x0
; GFX6-NEXT:    s_mov_b32 s3, 0xf000
; GFX6-NEXT:    s_mov_b32 s2, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s4
; GFX6-NEXT:    v_mov_b32_e32 v1, s5
; GFX6-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: constant_load_i64:
; GFX7:       ; %bb.0:
; GFX7-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dwordx2 s[2:3], s[2:3], 0x0
; GFX7-NEXT:    v_mov_b32_e32 v0, s0
; GFX7-NEXT:    v_mov_b32_e32 v1, s1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v2, s2
; GFX7-NEXT:    v_mov_b32_e32 v3, s3
; GFX7-NEXT:    flat_store_dwordx2 v[0:1], v[2:3]
; GFX7-NEXT:    s_endpgm
;
; GFX8-LABEL: constant_load_i64:
; GFX8:       ; %bb.0:
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_load_dwordx2 s[2:3], s[2:3], 0x0
; GFX8-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v2, s2
; GFX8-NEXT:    v_mov_b32_e32 v3, s3
; GFX8-NEXT:    flat_store_dwordx2 v[0:1], v[2:3]
; GFX8-NEXT:    s_endpgm
;
; EG-LABEL: constant_load_i64:
; EG:       ; %bb.0:
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 1, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_64 T0.XY, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
;
; GFX12-LABEL: constant_load_i64:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    s_load_b64 s[2:3], s[2:3], 0x0
; GFX12-NEXT:    v_mov_b32_e32 v2, 0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, s2 :: v_dual_mov_b32 v1, s3
; GFX12-NEXT:    global_store_b64 v2, v[0:1], s[0:1]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
  %ld = load i64, ptr addrspace(4) %in
  store i64 %ld, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @constant_load_v2i64(ptr addrspace(1) %out, ptr addrspace(4) %in) #0 {
; GFX6-LABEL: constant_load_v2i64:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x0
; GFX6-NEXT:    s_mov_b32 s3, 0xf000
; GFX6-NEXT:    s_mov_b32 s2, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s4
; GFX6-NEXT:    v_mov_b32_e32 v1, s5
; GFX6-NEXT:    v_mov_b32_e32 v2, s6
; GFX6-NEXT:    v_mov_b32_e32 v3, s7
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: constant_load_v2i64:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x0
; GFX7-NEXT:    v_mov_b32_e32 v4, s0
; GFX7-NEXT:    v_mov_b32_e32 v5, s1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s4
; GFX7-NEXT:    v_mov_b32_e32 v1, s5
; GFX7-NEXT:    v_mov_b32_e32 v2, s6
; GFX7-NEXT:    v_mov_b32_e32 v3, s7
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    s_endpgm
;
; GFX8-LABEL: constant_load_v2i64:
; GFX8:       ; %bb.0: ; %entry
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x0
; GFX8-NEXT:    v_mov_b32_e32 v4, s0
; GFX8-NEXT:    v_mov_b32_e32 v5, s1
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, s4
; GFX8-NEXT:    v_mov_b32_e32 v1, s5
; GFX8-NEXT:    v_mov_b32_e32 v2, s6
; GFX8-NEXT:    v_mov_b32_e32 v3, s7
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    s_endpgm
;
; EG-LABEL: constant_load_v2i64:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 0, @8, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @6
; EG-NEXT:    ALU 1, @9, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XYZW, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    PAD
; EG-NEXT:    Fetch clause starting at 6:
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 8:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 9:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
;
; GFX12-LABEL: constant_load_v2i64:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    s_load_b128 s[4:7], s[2:3], 0x0
; GFX12-NEXT:    v_mov_b32_e32 v4, 0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v3, s7
; GFX12-NEXT:    v_dual_mov_b32 v1, s5 :: v_dual_mov_b32 v2, s6
; GFX12-NEXT:    global_store_b128 v4, v[0:3], s[0:1]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
entry:
  %ld = load <2 x i64>, ptr addrspace(4) %in
  store <2 x i64> %ld, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @constant_load_v3i64(ptr addrspace(1) %out, ptr addrspace(4) %in) #0 {
; GFX6-LABEL: constant_load_v3i64:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dwordx2 s[8:9], s[2:3], 0x4
; GFX6-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x0
; GFX6-NEXT:    s_mov_b32 s3, 0xf000
; GFX6-NEXT:    s_mov_b32 s2, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s8
; GFX6-NEXT:    v_mov_b32_e32 v1, s9
; GFX6-NEXT:    buffer_store_dwordx2 v[0:1], off, s[0:3], 0 offset:16
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s4
; GFX6-NEXT:    v_mov_b32_e32 v1, s5
; GFX6-NEXT:    v_mov_b32_e32 v2, s6
; GFX6-NEXT:    v_mov_b32_e32 v3, s7
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[0:3], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: constant_load_v3i64:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_load_dwordx4 s[0:3], s[6:7], 0x0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dwordx2 s[8:9], s[2:3], 0x4
; GFX7-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x0
; GFX7-NEXT:    s_add_u32 s2, s0, 16
; GFX7-NEXT:    s_addc_u32 s3, s1, 0
; GFX7-NEXT:    v_mov_b32_e32 v4, s3
; GFX7-NEXT:    v_mov_b32_e32 v3, s2
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v5, s8
; GFX7-NEXT:    v_mov_b32_e32 v6, s9
; GFX7-NEXT:    flat_store_dwordx2 v[3:4], v[5:6]
; GFX7-NEXT:    v_mov_b32_e32 v5, s1
; GFX7-NEXT:    v_mov_b32_e32 v0, s4
; GFX7-NEXT:    v_mov_b32_e32 v1, s5
; GFX7-NEXT:    v_mov_b32_e32 v2, s6
; GFX7-NEXT:    v_mov_b32_e32 v3, s7
; GFX7-NEXT:    v_mov_b32_e32 v4, s0
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    s_endpgm
;
; GFX8-LABEL: constant_load_v3i64:
; GFX8:       ; %bb.0: ; %entry
; GFX8-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_load_dwordx2 s[8:9], s[2:3], 0x10
; GFX8-NEXT:    s_load_dwordx4 s[4:7], s[2:3], 0x0
; GFX8-NEXT:    s_add_u32 s2, s0, 16
; GFX8-NEXT:    s_addc_u32 s3, s1, 0
; GFX8-NEXT:    v_mov_b32_e32 v4, s3
; GFX8-NEXT:    v_mov_b32_e32 v3, s2
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v5, s8
; GFX8-NEXT:    v_mov_b32_e32 v6, s9
; GFX8-NEXT:    flat_store_dwordx2 v[3:4], v[5:6]
; GFX8-NEXT:    v_mov_b32_e32 v5, s1
; GFX8-NEXT:    v_mov_b32_e32 v0, s4
; GFX8-NEXT:    v_mov_b32_e32 v1, s5
; GFX8-NEXT:    v_mov_b32_e32 v2, s6
; GFX8-NEXT:    v_mov_b32_e32 v3, s7
; GFX8-NEXT:    v_mov_b32_e32 v4, s0
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    s_endpgm
;
; EG-LABEL: constant_load_v3i64:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 0, @12, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @8
; EG-NEXT:    ALU 1, @13, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @10
; EG-NEXT:    ALU 3, @15, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XY, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    Fetch clause starting at 8:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 0, #1
; EG-NEXT:    Fetch clause starting at 10:
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 16, #1
; EG-NEXT:    ALU clause starting at 12:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 13:
; EG-NEXT:     LSHR * T2.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 15:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR * T1.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
;
; GFX12-LABEL: constant_load_v3i64:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_load_b128 s[0:3], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    s_load_b64 s[8:9], s[2:3], 0x10
; GFX12-NEXT:    s_load_b128 s[4:7], s[2:3], 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v6, 0 :: v_dual_mov_b32 v5, s9
; GFX12-NEXT:    v_dual_mov_b32 v4, s8 :: v_dual_mov_b32 v1, s5
; GFX12-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v3, s7
; GFX12-NEXT:    v_mov_b32_e32 v2, s6
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b64 v6, v[4:5], s[0:1] offset:16
; GFX12-NEXT:    global_store_b128 v6, v[0:3], s[0:1]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
entry:
  %ld = load <3 x i64>, ptr addrspace(4) %in
  store <3 x i64> %ld, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @constant_load_v4i64(ptr addrspace(1) %out, ptr addrspace(4) %in) #0 {
; GFX6-LABEL: constant_load_v4i64:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_load_dwordx4 s[8:11], s[2:3], 0x9
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dwordx8 s[0:7], s[10:11], 0x0
; GFX6-NEXT:    s_mov_b32 s11, 0xf000
; GFX6-NEXT:    s_mov_b32 s10, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s4
; GFX6-NEXT:    v_mov_b32_e32 v1, s5
; GFX6-NEXT:    v_mov_b32_e32 v2, s6
; GFX6-NEXT:    v_mov_b32_e32 v3, s7
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[8:11], 0 offset:16
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s0
; GFX6-NEXT:    v_mov_b32_e32 v1, s1
; GFX6-NEXT:    v_mov_b32_e32 v2, s2
; GFX6-NEXT:    v_mov_b32_e32 v3, s3
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[8:11], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: constant_load_v4i64:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_load_dwordx4 s[8:11], s[6:7], 0x0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dwordx8 s[0:7], s[10:11], 0x0
; GFX7-NEXT:    s_add_u32 s10, s8, 16
; GFX7-NEXT:    s_addc_u32 s11, s9, 0
; GFX7-NEXT:    v_mov_b32_e32 v6, s10
; GFX7-NEXT:    v_mov_b32_e32 v7, s11
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s4
; GFX7-NEXT:    v_mov_b32_e32 v1, s5
; GFX7-NEXT:    v_mov_b32_e32 v2, s6
; GFX7-NEXT:    v_mov_b32_e32 v3, s7
; GFX7-NEXT:    flat_store_dwordx4 v[6:7], v[0:3]
; GFX7-NEXT:    v_mov_b32_e32 v4, s0
; GFX7-NEXT:    v_mov_b32_e32 v0, s8
; GFX7-NEXT:    v_mov_b32_e32 v5, s1
; GFX7-NEXT:    v_mov_b32_e32 v6, s2
; GFX7-NEXT:    v_mov_b32_e32 v7, s3
; GFX7-NEXT:    v_mov_b32_e32 v1, s9
; GFX7-NEXT:    flat_store_dwordx4 v[0:1], v[4:7]
; GFX7-NEXT:    s_endpgm
;
; GFX8-LABEL: constant_load_v4i64:
; GFX8:       ; %bb.0: ; %entry
; GFX8-NEXT:    s_load_dwordx4 s[8:11], s[2:3], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_load_dwordx8 s[0:7], s[10:11], 0x0
; GFX8-NEXT:    s_add_u32 s10, s8, 16
; GFX8-NEXT:    s_addc_u32 s11, s9, 0
; GFX8-NEXT:    v_mov_b32_e32 v6, s10
; GFX8-NEXT:    v_mov_b32_e32 v7, s11
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, s4
; GFX8-NEXT:    v_mov_b32_e32 v1, s5
; GFX8-NEXT:    v_mov_b32_e32 v2, s6
; GFX8-NEXT:    v_mov_b32_e32 v3, s7
; GFX8-NEXT:    flat_store_dwordx4 v[6:7], v[0:3]
; GFX8-NEXT:    v_mov_b32_e32 v4, s0
; GFX8-NEXT:    v_mov_b32_e32 v0, s8
; GFX8-NEXT:    v_mov_b32_e32 v5, s1
; GFX8-NEXT:    v_mov_b32_e32 v6, s2
; GFX8-NEXT:    v_mov_b32_e32 v7, s3
; GFX8-NEXT:    v_mov_b32_e32 v1, s9
; GFX8-NEXT:    flat_store_dwordx4 v[0:1], v[4:7]
; GFX8-NEXT:    s_endpgm
;
; EG-LABEL: constant_load_v4i64:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 0, @12, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @8
; EG-NEXT:    ALU 3, @13, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @10
; EG-NEXT:    ALU 1, @17, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XYZW, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    Fetch clause starting at 8:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 16, #1
; EG-NEXT:    Fetch clause starting at 10:
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 12:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 13:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 17:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
;
; GFX12-LABEL: constant_load_v4i64:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_load_b128 s[8:11], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    s_load_b256 s[0:7], s[10:11], 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v8, 0 :: v_dual_mov_b32 v1, s5
; GFX12-NEXT:    v_dual_mov_b32 v0, s4 :: v_dual_mov_b32 v3, s7
; GFX12-NEXT:    v_dual_mov_b32 v2, s6 :: v_dual_mov_b32 v5, s1
; GFX12-NEXT:    v_dual_mov_b32 v4, s0 :: v_dual_mov_b32 v7, s3
; GFX12-NEXT:    v_mov_b32_e32 v6, s2
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    global_store_b128 v8, v[0:3], s[8:9] offset:16
; GFX12-NEXT:    global_store_b128 v8, v[4:7], s[8:9]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
entry:
  %ld = load <4 x i64>, ptr addrspace(4) %in
  store <4 x i64> %ld, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @constant_load_v8i64(ptr addrspace(1) %out, ptr addrspace(4) %in) #0 {
; GFX6-LABEL: constant_load_v8i64:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_load_dwordx4 s[16:19], s[2:3], 0x9
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dwordx16 s[0:15], s[18:19], 0x0
; GFX6-NEXT:    s_mov_b32 s19, 0xf000
; GFX6-NEXT:    s_mov_b32 s18, -1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s12
; GFX6-NEXT:    v_mov_b32_e32 v1, s13
; GFX6-NEXT:    v_mov_b32_e32 v2, s14
; GFX6-NEXT:    v_mov_b32_e32 v3, s15
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[16:19], 0 offset:48
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s8
; GFX6-NEXT:    v_mov_b32_e32 v1, s9
; GFX6-NEXT:    v_mov_b32_e32 v2, s10
; GFX6-NEXT:    v_mov_b32_e32 v3, s11
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[16:19], 0 offset:32
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s4
; GFX6-NEXT:    v_mov_b32_e32 v1, s5
; GFX6-NEXT:    v_mov_b32_e32 v2, s6
; GFX6-NEXT:    v_mov_b32_e32 v3, s7
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[16:19], 0 offset:16
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s0
; GFX6-NEXT:    v_mov_b32_e32 v1, s1
; GFX6-NEXT:    v_mov_b32_e32 v2, s2
; GFX6-NEXT:    v_mov_b32_e32 v3, s3
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[16:19], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: constant_load_v8i64:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_load_dwordx4 s[16:19], s[6:7], 0x0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dwordx16 s[0:15], s[18:19], 0x0
; GFX7-NEXT:    s_add_u32 s18, s16, 48
; GFX7-NEXT:    s_addc_u32 s19, s17, 0
; GFX7-NEXT:    v_mov_b32_e32 v6, s18
; GFX7-NEXT:    v_mov_b32_e32 v7, s19
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s12
; GFX7-NEXT:    v_mov_b32_e32 v1, s13
; GFX7-NEXT:    v_mov_b32_e32 v2, s14
; GFX7-NEXT:    v_mov_b32_e32 v3, s15
; GFX7-NEXT:    v_mov_b32_e32 v4, s8
; GFX7-NEXT:    s_add_u32 s8, s16, 32
; GFX7-NEXT:    v_mov_b32_e32 v5, s9
; GFX7-NEXT:    flat_store_dwordx4 v[6:7], v[0:3]
; GFX7-NEXT:    s_addc_u32 s9, s17, 0
; GFX7-NEXT:    v_mov_b32_e32 v0, s8
; GFX7-NEXT:    v_mov_b32_e32 v6, s10
; GFX7-NEXT:    v_mov_b32_e32 v7, s11
; GFX7-NEXT:    v_mov_b32_e32 v1, s9
; GFX7-NEXT:    flat_store_dwordx4 v[0:1], v[4:7]
; GFX7-NEXT:    v_mov_b32_e32 v0, s4
; GFX7-NEXT:    s_add_u32 s4, s16, 16
; GFX7-NEXT:    v_mov_b32_e32 v1, s5
; GFX7-NEXT:    s_addc_u32 s5, s17, 0
; GFX7-NEXT:    v_mov_b32_e32 v4, s4
; GFX7-NEXT:    v_mov_b32_e32 v2, s6
; GFX7-NEXT:    v_mov_b32_e32 v3, s7
; GFX7-NEXT:    v_mov_b32_e32 v5, s5
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    v_mov_b32_e32 v4, s16
; GFX7-NEXT:    v_mov_b32_e32 v0, s0
; GFX7-NEXT:    v_mov_b32_e32 v1, s1
; GFX7-NEXT:    v_mov_b32_e32 v2, s2
; GFX7-NEXT:    v_mov_b32_e32 v3, s3
; GFX7-NEXT:    v_mov_b32_e32 v5, s17
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    s_endpgm
;
; GFX8-LABEL: constant_load_v8i64:
; GFX8:       ; %bb.0: ; %entry
; GFX8-NEXT:    s_load_dwordx4 s[16:19], s[2:3], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_load_dwordx16 s[0:15], s[18:19], 0x0
; GFX8-NEXT:    s_add_u32 s18, s16, 48
; GFX8-NEXT:    s_addc_u32 s19, s17, 0
; GFX8-NEXT:    v_mov_b32_e32 v6, s18
; GFX8-NEXT:    v_mov_b32_e32 v7, s19
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, s12
; GFX8-NEXT:    v_mov_b32_e32 v1, s13
; GFX8-NEXT:    v_mov_b32_e32 v2, s14
; GFX8-NEXT:    v_mov_b32_e32 v3, s15
; GFX8-NEXT:    v_mov_b32_e32 v4, s8
; GFX8-NEXT:    s_add_u32 s8, s16, 32
; GFX8-NEXT:    v_mov_b32_e32 v5, s9
; GFX8-NEXT:    flat_store_dwordx4 v[6:7], v[0:3]
; GFX8-NEXT:    s_addc_u32 s9, s17, 0
; GFX8-NEXT:    v_mov_b32_e32 v0, s8
; GFX8-NEXT:    v_mov_b32_e32 v6, s10
; GFX8-NEXT:    v_mov_b32_e32 v7, s11
; GFX8-NEXT:    v_mov_b32_e32 v1, s9
; GFX8-NEXT:    flat_store_dwordx4 v[0:1], v[4:7]
; GFX8-NEXT:    v_mov_b32_e32 v0, s4
; GFX8-NEXT:    s_add_u32 s4, s16, 16
; GFX8-NEXT:    v_mov_b32_e32 v1, s5
; GFX8-NEXT:    s_addc_u32 s5, s17, 0
; GFX8-NEXT:    v_mov_b32_e32 v4, s4
; GFX8-NEXT:    v_mov_b32_e32 v2, s6
; GFX8-NEXT:    v_mov_b32_e32 v3, s7
; GFX8-NEXT:    v_mov_b32_e32 v5, s5
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    v_mov_b32_e32 v4, s16
; GFX8-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    v_mov_b32_e32 v2, s2
; GFX8-NEXT:    v_mov_b32_e32 v3, s3
; GFX8-NEXT:    v_mov_b32_e32 v5, s17
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    s_endpgm
;
; EG-LABEL: constant_load_v8i64:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 0, @22, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @14
; EG-NEXT:    ALU 3, @23, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @16
; EG-NEXT:    ALU 3, @27, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @18
; EG-NEXT:    ALU 3, @31, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @20
; EG-NEXT:    ALU 1, @35, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XYZW, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    Fetch clause starting at 14:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 48, #1
; EG-NEXT:    Fetch clause starting at 16:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 32, #1
; EG-NEXT:    Fetch clause starting at 18:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 16, #1
; EG-NEXT:    Fetch clause starting at 20:
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 22:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 23:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    48(6.726233e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 27:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    32(4.484155e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 31:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 35:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
;
; GFX12-LABEL: constant_load_v8i64:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_load_b128 s[16:19], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    s_load_b512 s[0:15], s[18:19], 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v16, 0 :: v_dual_mov_b32 v1, s13
; GFX12-NEXT:    v_dual_mov_b32 v0, s12 :: v_dual_mov_b32 v3, s15
; GFX12-NEXT:    v_dual_mov_b32 v2, s14 :: v_dual_mov_b32 v5, s9
; GFX12-NEXT:    v_dual_mov_b32 v4, s8 :: v_dual_mov_b32 v7, s11
; GFX12-NEXT:    v_dual_mov_b32 v6, s10 :: v_dual_mov_b32 v9, s5
; GFX12-NEXT:    v_dual_mov_b32 v8, s4 :: v_dual_mov_b32 v11, s7
; GFX12-NEXT:    v_dual_mov_b32 v10, s6 :: v_dual_mov_b32 v13, s1
; GFX12-NEXT:    v_dual_mov_b32 v12, s0 :: v_dual_mov_b32 v15, s3
; GFX12-NEXT:    v_mov_b32_e32 v14, s2
; GFX12-NEXT:    s_clause 0x3
; GFX12-NEXT:    global_store_b128 v16, v[0:3], s[16:17] offset:48
; GFX12-NEXT:    global_store_b128 v16, v[4:7], s[16:17] offset:32
; GFX12-NEXT:    global_store_b128 v16, v[8:11], s[16:17] offset:16
; GFX12-NEXT:    global_store_b128 v16, v[12:15], s[16:17]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
entry:
  %ld = load <8 x i64>, ptr addrspace(4) %in
  store <8 x i64> %ld, ptr addrspace(1) %out
  ret void
}

define amdgpu_kernel void @constant_load_v16i64(ptr addrspace(1) %out, ptr addrspace(4) %in) #0 {
; GFX6-LABEL: constant_load_v16i64:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_load_dwordx4 s[0:3], s[2:3], 0x9
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dwordx16 s[16:31], s[2:3], 0x10
; GFX6-NEXT:    s_mov_b32 s39, 0xf000
; GFX6-NEXT:    s_mov_b32 s38, -1
; GFX6-NEXT:    s_mov_b32 s36, s0
; GFX6-NEXT:    s_mov_b32 s37, s1
; GFX6-NEXT:    s_load_dwordx16 s[0:15], s[2:3], 0x0
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s28
; GFX6-NEXT:    v_mov_b32_e32 v1, s29
; GFX6-NEXT:    v_mov_b32_e32 v2, s30
; GFX6-NEXT:    v_mov_b32_e32 v3, s31
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[36:39], 0 offset:112
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s24
; GFX6-NEXT:    v_mov_b32_e32 v1, s25
; GFX6-NEXT:    v_mov_b32_e32 v2, s26
; GFX6-NEXT:    v_mov_b32_e32 v3, s27
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[36:39], 0 offset:96
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s20
; GFX6-NEXT:    v_mov_b32_e32 v1, s21
; GFX6-NEXT:    v_mov_b32_e32 v2, s22
; GFX6-NEXT:    v_mov_b32_e32 v3, s23
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[36:39], 0 offset:80
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s16
; GFX6-NEXT:    v_mov_b32_e32 v1, s17
; GFX6-NEXT:    v_mov_b32_e32 v2, s18
; GFX6-NEXT:    v_mov_b32_e32 v3, s19
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[36:39], 0 offset:64
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s12
; GFX6-NEXT:    v_mov_b32_e32 v1, s13
; GFX6-NEXT:    v_mov_b32_e32 v2, s14
; GFX6-NEXT:    v_mov_b32_e32 v3, s15
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[36:39], 0 offset:48
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s8
; GFX6-NEXT:    v_mov_b32_e32 v1, s9
; GFX6-NEXT:    v_mov_b32_e32 v2, s10
; GFX6-NEXT:    v_mov_b32_e32 v3, s11
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[36:39], 0 offset:32
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s4
; GFX6-NEXT:    v_mov_b32_e32 v1, s5
; GFX6-NEXT:    v_mov_b32_e32 v2, s6
; GFX6-NEXT:    v_mov_b32_e32 v3, s7
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[36:39], 0 offset:16
; GFX6-NEXT:    s_waitcnt expcnt(0)
; GFX6-NEXT:    v_mov_b32_e32 v0, s0
; GFX6-NEXT:    v_mov_b32_e32 v1, s1
; GFX6-NEXT:    v_mov_b32_e32 v2, s2
; GFX6-NEXT:    v_mov_b32_e32 v3, s3
; GFX6-NEXT:    buffer_store_dwordx4 v[0:3], off, s[36:39], 0
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: constant_load_v16i64:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:    s_load_dwordx4 s[36:39], s[6:7], 0x0
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dwordx16 s[16:31], s[38:39], 0x10
; GFX7-NEXT:    s_load_dwordx16 s[0:15], s[38:39], 0x0
; GFX7-NEXT:    s_add_u32 s34, s36, 0x70
; GFX7-NEXT:    s_addc_u32 s35, s37, 0
; GFX7-NEXT:    v_mov_b32_e32 v5, s34
; GFX7-NEXT:    v_mov_b32_e32 v6, s35
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    v_mov_b32_e32 v0, s28
; GFX7-NEXT:    v_mov_b32_e32 v1, s29
; GFX7-NEXT:    v_mov_b32_e32 v2, s30
; GFX7-NEXT:    v_mov_b32_e32 v3, s31
; GFX7-NEXT:    v_mov_b32_e32 v4, s24
; GFX7-NEXT:    s_add_u32 s24, s36, 0x60
; GFX7-NEXT:    flat_store_dwordx4 v[5:6], v[0:3]
; GFX7-NEXT:    v_mov_b32_e32 v5, s25
; GFX7-NEXT:    s_addc_u32 s25, s37, 0
; GFX7-NEXT:    v_mov_b32_e32 v0, s24
; GFX7-NEXT:    v_mov_b32_e32 v6, s26
; GFX7-NEXT:    v_mov_b32_e32 v7, s27
; GFX7-NEXT:    v_mov_b32_e32 v1, s25
; GFX7-NEXT:    flat_store_dwordx4 v[0:1], v[4:7]
; GFX7-NEXT:    v_mov_b32_e32 v0, s20
; GFX7-NEXT:    s_add_u32 s20, s36, 0x50
; GFX7-NEXT:    v_mov_b32_e32 v1, s21
; GFX7-NEXT:    s_addc_u32 s21, s37, 0
; GFX7-NEXT:    v_mov_b32_e32 v4, s20
; GFX7-NEXT:    v_mov_b32_e32 v2, s22
; GFX7-NEXT:    v_mov_b32_e32 v3, s23
; GFX7-NEXT:    v_mov_b32_e32 v5, s21
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    s_nop 0
; GFX7-NEXT:    v_mov_b32_e32 v0, s16
; GFX7-NEXT:    s_add_u32 s16, s36, 64
; GFX7-NEXT:    v_mov_b32_e32 v1, s17
; GFX7-NEXT:    s_addc_u32 s17, s37, 0
; GFX7-NEXT:    v_mov_b32_e32 v4, s16
; GFX7-NEXT:    v_mov_b32_e32 v2, s18
; GFX7-NEXT:    v_mov_b32_e32 v3, s19
; GFX7-NEXT:    v_mov_b32_e32 v5, s17
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    s_nop 0
; GFX7-NEXT:    v_mov_b32_e32 v0, s12
; GFX7-NEXT:    s_add_u32 s12, s36, 48
; GFX7-NEXT:    v_mov_b32_e32 v1, s13
; GFX7-NEXT:    s_addc_u32 s13, s37, 0
; GFX7-NEXT:    v_mov_b32_e32 v4, s12
; GFX7-NEXT:    v_mov_b32_e32 v2, s14
; GFX7-NEXT:    v_mov_b32_e32 v3, s15
; GFX7-NEXT:    v_mov_b32_e32 v5, s13
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    s_nop 0
; GFX7-NEXT:    v_mov_b32_e32 v0, s8
; GFX7-NEXT:    s_add_u32 s8, s36, 32
; GFX7-NEXT:    v_mov_b32_e32 v1, s9
; GFX7-NEXT:    s_addc_u32 s9, s37, 0
; GFX7-NEXT:    v_mov_b32_e32 v4, s8
; GFX7-NEXT:    v_mov_b32_e32 v2, s10
; GFX7-NEXT:    v_mov_b32_e32 v3, s11
; GFX7-NEXT:    v_mov_b32_e32 v5, s9
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    s_nop 0
; GFX7-NEXT:    v_mov_b32_e32 v0, s4
; GFX7-NEXT:    s_add_u32 s4, s36, 16
; GFX7-NEXT:    v_mov_b32_e32 v1, s5
; GFX7-NEXT:    s_addc_u32 s5, s37, 0
; GFX7-NEXT:    v_mov_b32_e32 v4, s4
; GFX7-NEXT:    v_mov_b32_e32 v2, s6
; GFX7-NEXT:    v_mov_b32_e32 v3, s7
; GFX7-NEXT:    v_mov_b32_e32 v5, s5
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    v_mov_b32_e32 v4, s36
; GFX7-NEXT:    v_mov_b32_e32 v0, s0
; GFX7-NEXT:    v_mov_b32_e32 v1, s1
; GFX7-NEXT:    v_mov_b32_e32 v2, s2
; GFX7-NEXT:    v_mov_b32_e32 v3, s3
; GFX7-NEXT:    v_mov_b32_e32 v5, s37
; GFX7-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX7-NEXT:    s_endpgm
;
; GFX8-LABEL: constant_load_v16i64:
; GFX8:       ; %bb.0: ; %entry
; GFX8-NEXT:    s_load_dwordx4 s[36:39], s[2:3], 0x24
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    s_load_dwordx16 s[16:31], s[38:39], 0x40
; GFX8-NEXT:    s_load_dwordx16 s[0:15], s[38:39], 0x0
; GFX8-NEXT:    s_add_u32 s34, s36, 0x70
; GFX8-NEXT:    s_addc_u32 s35, s37, 0
; GFX8-NEXT:    v_mov_b32_e32 v5, s34
; GFX8-NEXT:    v_mov_b32_e32 v6, s35
; GFX8-NEXT:    s_waitcnt lgkmcnt(0)
; GFX8-NEXT:    v_mov_b32_e32 v0, s28
; GFX8-NEXT:    v_mov_b32_e32 v1, s29
; GFX8-NEXT:    v_mov_b32_e32 v2, s30
; GFX8-NEXT:    v_mov_b32_e32 v3, s31
; GFX8-NEXT:    v_mov_b32_e32 v4, s24
; GFX8-NEXT:    s_add_u32 s24, s36, 0x60
; GFX8-NEXT:    flat_store_dwordx4 v[5:6], v[0:3]
; GFX8-NEXT:    v_mov_b32_e32 v5, s25
; GFX8-NEXT:    s_addc_u32 s25, s37, 0
; GFX8-NEXT:    v_mov_b32_e32 v0, s24
; GFX8-NEXT:    v_mov_b32_e32 v6, s26
; GFX8-NEXT:    v_mov_b32_e32 v7, s27
; GFX8-NEXT:    v_mov_b32_e32 v1, s25
; GFX8-NEXT:    flat_store_dwordx4 v[0:1], v[4:7]
; GFX8-NEXT:    v_mov_b32_e32 v0, s20
; GFX8-NEXT:    s_add_u32 s20, s36, 0x50
; GFX8-NEXT:    v_mov_b32_e32 v1, s21
; GFX8-NEXT:    s_addc_u32 s21, s37, 0
; GFX8-NEXT:    v_mov_b32_e32 v4, s20
; GFX8-NEXT:    v_mov_b32_e32 v2, s22
; GFX8-NEXT:    v_mov_b32_e32 v3, s23
; GFX8-NEXT:    v_mov_b32_e32 v5, s21
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    s_nop 0
; GFX8-NEXT:    v_mov_b32_e32 v0, s16
; GFX8-NEXT:    s_add_u32 s16, s36, 64
; GFX8-NEXT:    v_mov_b32_e32 v1, s17
; GFX8-NEXT:    s_addc_u32 s17, s37, 0
; GFX8-NEXT:    v_mov_b32_e32 v4, s16
; GFX8-NEXT:    v_mov_b32_e32 v2, s18
; GFX8-NEXT:    v_mov_b32_e32 v3, s19
; GFX8-NEXT:    v_mov_b32_e32 v5, s17
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    s_nop 0
; GFX8-NEXT:    v_mov_b32_e32 v0, s12
; GFX8-NEXT:    s_add_u32 s12, s36, 48
; GFX8-NEXT:    v_mov_b32_e32 v1, s13
; GFX8-NEXT:    s_addc_u32 s13, s37, 0
; GFX8-NEXT:    v_mov_b32_e32 v4, s12
; GFX8-NEXT:    v_mov_b32_e32 v2, s14
; GFX8-NEXT:    v_mov_b32_e32 v3, s15
; GFX8-NEXT:    v_mov_b32_e32 v5, s13
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    s_nop 0
; GFX8-NEXT:    v_mov_b32_e32 v0, s8
; GFX8-NEXT:    s_add_u32 s8, s36, 32
; GFX8-NEXT:    v_mov_b32_e32 v1, s9
; GFX8-NEXT:    s_addc_u32 s9, s37, 0
; GFX8-NEXT:    v_mov_b32_e32 v4, s8
; GFX8-NEXT:    v_mov_b32_e32 v2, s10
; GFX8-NEXT:    v_mov_b32_e32 v3, s11
; GFX8-NEXT:    v_mov_b32_e32 v5, s9
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    s_nop 0
; GFX8-NEXT:    v_mov_b32_e32 v0, s4
; GFX8-NEXT:    s_add_u32 s4, s36, 16
; GFX8-NEXT:    v_mov_b32_e32 v1, s5
; GFX8-NEXT:    s_addc_u32 s5, s37, 0
; GFX8-NEXT:    v_mov_b32_e32 v4, s4
; GFX8-NEXT:    v_mov_b32_e32 v2, s6
; GFX8-NEXT:    v_mov_b32_e32 v3, s7
; GFX8-NEXT:    v_mov_b32_e32 v5, s5
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    v_mov_b32_e32 v4, s36
; GFX8-NEXT:    v_mov_b32_e32 v0, s0
; GFX8-NEXT:    v_mov_b32_e32 v1, s1
; GFX8-NEXT:    v_mov_b32_e32 v2, s2
; GFX8-NEXT:    v_mov_b32_e32 v3, s3
; GFX8-NEXT:    v_mov_b32_e32 v5, s37
; GFX8-NEXT:    flat_store_dwordx4 v[4:5], v[0:3]
; GFX8-NEXT:    s_endpgm
;
; EG-LABEL: constant_load_v16i64:
; EG:       ; %bb.0: ; %entry
; EG-NEXT:    ALU 0, @42, KC0[CB0:0-32], KC1[]
; EG-NEXT:    TEX 0 @26
; EG-NEXT:    ALU 3, @43, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @28
; EG-NEXT:    ALU 3, @47, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @30
; EG-NEXT:    ALU 3, @51, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @32
; EG-NEXT:    ALU 3, @55, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @34
; EG-NEXT:    ALU 3, @59, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @36
; EG-NEXT:    ALU 3, @63, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @38
; EG-NEXT:    ALU 3, @67, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T1.XYZW, T2.X, 0
; EG-NEXT:    TEX 0 @40
; EG-NEXT:    ALU 1, @71, KC0[CB0:0-32], KC1[]
; EG-NEXT:    MEM_RAT_CACHELESS STORE_RAW T0.XYZW, T1.X, 1
; EG-NEXT:    CF_END
; EG-NEXT:    Fetch clause starting at 26:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 112, #1
; EG-NEXT:    Fetch clause starting at 28:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 96, #1
; EG-NEXT:    Fetch clause starting at 30:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 80, #1
; EG-NEXT:    Fetch clause starting at 32:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 64, #1
; EG-NEXT:    Fetch clause starting at 34:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 48, #1
; EG-NEXT:    Fetch clause starting at 36:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 32, #1
; EG-NEXT:    Fetch clause starting at 38:
; EG-NEXT:     VTX_READ_128 T1.XYZW, T0.X, 16, #1
; EG-NEXT:    Fetch clause starting at 40:
; EG-NEXT:     VTX_READ_128 T0.XYZW, T0.X, 0, #1
; EG-NEXT:    ALU clause starting at 42:
; EG-NEXT:     MOV * T0.X, KC0[2].Z,
; EG-NEXT:    ALU clause starting at 43:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    112(1.569454e-43), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 47:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    96(1.345247e-43), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 51:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    80(1.121039e-43), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 55:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    64(8.968310e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 59:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    48(6.726233e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 63:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    32(4.484155e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 67:
; EG-NEXT:     ADD_INT * T0.W, KC0[2].Y, literal.x,
; EG-NEXT:    16(2.242078e-44), 0(0.000000e+00)
; EG-NEXT:     LSHR * T2.X, PV.W, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
; EG-NEXT:    ALU clause starting at 71:
; EG-NEXT:     LSHR * T1.X, KC0[2].Y, literal.x,
; EG-NEXT:    2(2.802597e-45), 0(0.000000e+00)
;
; GFX12-LABEL: constant_load_v16i64:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_load_b128 s[36:39], s[2:3], 0x24
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    s_clause 0x1
; GFX12-NEXT:    s_load_b512 s[16:31], s[38:39], 0x40
; GFX12-NEXT:    s_load_b512 s[0:15], s[38:39], 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_dual_mov_b32 v32, 0 :: v_dual_mov_b32 v1, s29
; GFX12-NEXT:    v_dual_mov_b32 v0, s28 :: v_dual_mov_b32 v3, s31
; GFX12-NEXT:    v_dual_mov_b32 v2, s30 :: v_dual_mov_b32 v5, s25
; GFX12-NEXT:    v_dual_mov_b32 v4, s24 :: v_dual_mov_b32 v7, s27
; GFX12-NEXT:    v_dual_mov_b32 v6, s26 :: v_dual_mov_b32 v9, s21
; GFX12-NEXT:    v_dual_mov_b32 v8, s20 :: v_dual_mov_b32 v11, s23
; GFX12-NEXT:    v_dual_mov_b32 v10, s22 :: v_dual_mov_b32 v13, s17
; GFX12-NEXT:    v_dual_mov_b32 v12, s16 :: v_dual_mov_b32 v15, s19
; GFX12-NEXT:    v_dual_mov_b32 v14, s18 :: v_dual_mov_b32 v17, s13
; GFX12-NEXT:    v_dual_mov_b32 v16, s12 :: v_dual_mov_b32 v19, s15
; GFX12-NEXT:    v_dual_mov_b32 v18, s14 :: v_dual_mov_b32 v21, s9
; GFX12-NEXT:    v_dual_mov_b32 v20, s8 :: v_dual_mov_b32 v23, s11
; GFX12-NEXT:    v_dual_mov_b32 v22, s10 :: v_dual_mov_b32 v25, s5
; GFX12-NEXT:    v_dual_mov_b32 v24, s4 :: v_dual_mov_b32 v27, s7
; GFX12-NEXT:    v_dual_mov_b32 v26, s6 :: v_dual_mov_b32 v29, s1
; GFX12-NEXT:    v_dual_mov_b32 v28, s0 :: v_dual_mov_b32 v31, s3
; GFX12-NEXT:    v_mov_b32_e32 v30, s2
; GFX12-NEXT:    s_clause 0x7
; GFX12-NEXT:    global_store_b128 v32, v[0:3], s[36:37] offset:112
; GFX12-NEXT:    global_store_b128 v32, v[4:7], s[36:37] offset:96
; GFX12-NEXT:    global_store_b128 v32, v[8:11], s[36:37] offset:80
; GFX12-NEXT:    global_store_b128 v32, v[12:15], s[36:37] offset:64
; GFX12-NEXT:    global_store_b128 v32, v[16:19], s[36:37] offset:48
; GFX12-NEXT:    global_store_b128 v32, v[20:23], s[36:37] offset:32
; GFX12-NEXT:    global_store_b128 v32, v[24:27], s[36:37] offset:16
; GFX12-NEXT:    global_store_b128 v32, v[28:31], s[36:37]
; GFX12-NEXT:    s_nop 0
; GFX12-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; GFX12-NEXT:    s_endpgm
entry:
  %ld = load <16 x i64>, ptr addrspace(4) %in
  store <16 x i64> %ld, ptr addrspace(1) %out
  ret void
}

attributes #0 = { nounwind }
