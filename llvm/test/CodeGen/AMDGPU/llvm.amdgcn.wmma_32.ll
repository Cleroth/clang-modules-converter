; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn -mcpu=gfx1100 -mattr=+wavefrontsize32 -verify-machineinstrs < %s | FileCheck %s --check-prefix=W32

declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16(<16 x half>, <16 x half> , <8 x float>)
declare <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf16(<16 x i16>, <16 x i16> , <8 x float>)
declare <16 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16(<16 x half>, <16 x half> , <16 x half>, i1 immarg)
declare <16 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.tied(<16 x half>, <16 x half> , <16 x half>, i1 immarg)
declare <16 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16(<16 x i16>, <16 x i16> , <16 x i16>, i1 immarg)
declare <16 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16.tied(<16 x i16>, <16 x i16> , <16 x i16>, i1 immarg)
declare <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8(i1 immarg, <4 x i32>, i1 immarg, <4 x i32> , <8 x i32>, i1 immarg)
declare <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4(i1 immarg, <2 x i32>, i1 immarg, <2 x i32> , <8 x i32>, i1 immarg)

; @llvm.amdgcn.wmma.f32.16x16x16.f16

define amdgpu_ps void @test_wmma_f32_16x16x16_f16(<16 x half> %A, <16 x half> %B, <8 x float> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_f32_16x16x16_f16:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_f32_16x16x16_f16 v[16:23], v[0:7], v[8:15], v[16:23]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[24:25], v[20:23], off offset:16
; W32-NEXT:    global_store_b128 v[24:25], v[16:19], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.f16(<16 x half> %A, <16 x half> %B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out, align 32
  ret void
}

; @llvm.amdgcn.wmma.f32.16x16x16.bf16

define amdgpu_ps void @test_wmma_f32_16x16x16_bf16(<16 x i16> %A, <16 x i16> %B, <8 x float> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_f32_16x16x16_bf16:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_f32_16x16x16_bf16 v[16:23], v[0:7], v[8:15], v[16:23]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[24:25], v[20:23], off offset:16
; W32-NEXT:    global_store_b128 v[24:25], v[16:19], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x float> @llvm.amdgcn.wmma.f32.16x16x16.bf16(<16 x i16> %A, <16 x i16> %B, <8 x float> %C)
  store <8 x float> %res, ptr addrspace(1) %out, align 32
  ret void
}

; @llvm.amdgcn.wmma.f16.16x16x16.f16

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_lo(<16 x half> %A, <16 x half> %B, <16 x half> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_f16_16x16x16_f16_lo:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_f16_16x16x16_f16 v[16:23], v[0:7], v[8:15], v[16:23]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[24:25], v[20:23], off offset:16
; W32-NEXT:    global_store_b128 v[24:25], v[16:19], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <16 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16(<16 x half> %A, <16 x half> %B, <16 x half> %C, i1 0)
  store <16 x half> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_hi(<16 x half> %A, <16 x half> %B, <16 x half> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_f16_16x16x16_f16_hi:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_f16_16x16x16_f16 v[16:23], v[0:7], v[8:15], v[16:23] op_sel:[0,0,1]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[24:25], v[20:23], off offset:16
; W32-NEXT:    global_store_b128 v[24:25], v[16:19], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <16 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16(<16 x half> %A, <16 x half> %B, <16 x half> %C, i1 1)
  store <16 x half> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_untied(<16 x half> %A.0, <16 x half> %B.0, <16 x half> %A.1, <16 x half> %B.1, <16 x half> %C, ptr addrspace(1) %out.0, ptr addrspace(1) %out.1) {
; W32-LABEL: test_wmma_f16_16x16x16_f16_untied:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_f16_16x16x16_f16 v[44:51], v[0:7], v[8:15], v[32:39]
; W32-NEXT:    v_wmma_f16_16x16x16_f16 v[32:39], v[16:23], v[24:31], v[32:39]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[40:41], v[48:51], off offset:16
; W32-NEXT:    global_store_b128 v[40:41], v[44:47], off
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[42:43], v[36:39], off offset:16
; W32-NEXT:    global_store_b128 v[42:43], v[32:35], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res.0 = call <16 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16(<16 x half> %A.0, <16 x half> %B.0, <16 x half> %C, i1 0)
  %res.1 = call <16 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16(<16 x half> %A.1, <16 x half> %B.1, <16 x half> %C, i1 0)
  store <16 x half> %res.0, ptr addrspace(1) %out.0, align 32
  store <16 x half> %res.1, ptr addrspace(1) %out.1, align 32
  ret void
}

define amdgpu_ps void @test_wmma_f16_16x16x16_f16_tied(<16 x half> %A.0, <16 x half> %B.0, <16 x half> %A.1, <16 x half> %B.1, <16 x half> %C, ptr addrspace(1) %out.0, ptr addrspace(1) %out.1) {
; W32-LABEL: test_wmma_f16_16x16x16_f16_tied:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_dual_mov_b32 v51, v39 :: v_dual_mov_b32 v50, v38
; W32-NEXT:    v_dual_mov_b32 v49, v37 :: v_dual_mov_b32 v48, v36
; W32-NEXT:    v_dual_mov_b32 v47, v35 :: v_dual_mov_b32 v46, v34
; W32-NEXT:    v_dual_mov_b32 v45, v33 :: v_dual_mov_b32 v44, v32
; W32-NEXT:    v_wmma_f16_16x16x16_f16 v[32:39], v[16:23], v[24:31], v[32:39]
; W32-NEXT:    s_delay_alu instid0(VALU_DEP_2)
; W32-NEXT:    v_wmma_f16_16x16x16_f16 v[44:51], v[0:7], v[8:15], v[44:51]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[40:41], v[48:51], off offset:16
; W32-NEXT:    global_store_b128 v[40:41], v[44:47], off
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[42:43], v[36:39], off offset:16
; W32-NEXT:    global_store_b128 v[42:43], v[32:35], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res.0 = call <16 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.tied(<16 x half> %A.0, <16 x half> %B.0, <16 x half> %C, i1 0)
  %res.1 = call <16 x half> @llvm.amdgcn.wmma.f16.16x16x16.f16.tied(<16 x half> %A.1, <16 x half> %B.1, <16 x half> %C, i1 0)
  store <16 x half> %res.0, ptr addrspace(1) %out.0, align 32
  store <16 x half> %res.1, ptr addrspace(1) %out.1, align 32
  ret void
}

; @llvm.amdgcn.wmma.bf16.16x16x16.bf16

define amdgpu_ps void @test_wmma_bf16_16x16x16_bf16_lo(<16 x i16> %A, <16 x i16> %B, <16 x i16> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_bf16_16x16x16_bf16_lo:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_bf16_16x16x16_bf16 v[16:23], v[0:7], v[8:15], v[16:23]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[24:25], v[20:23], off offset:16
; W32-NEXT:    global_store_b128 v[24:25], v[16:19], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <16 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16(<16 x i16> %A, <16 x i16> %B, <16 x i16> %C, i1 0)
  store <16 x i16> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_bf16_16x16x16_bf16_hi(<16 x i16> %A, <16 x i16> %B, <16 x i16> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_bf16_16x16x16_bf16_hi:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_bf16_16x16x16_bf16 v[16:23], v[0:7], v[8:15], v[16:23] op_sel:[0,0,1]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[24:25], v[20:23], off offset:16
; W32-NEXT:    global_store_b128 v[24:25], v[16:19], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <16 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16(<16 x i16> %A, <16 x i16> %B, <16 x i16> %C, i1 1)
  store <16 x i16> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_bf16_16x16x16_bf16_untied(<16 x i16> %A.0, <16 x i16> %B.0, <16 x i16> %A.1, <16 x i16> %B.1, <16 x i16> %C, ptr addrspace(1) %out.0, ptr addrspace(1) %out.1) {
; W32-LABEL: test_wmma_bf16_16x16x16_bf16_untied:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_bf16_16x16x16_bf16 v[44:51], v[0:7], v[8:15], v[32:39]
; W32-NEXT:    v_wmma_bf16_16x16x16_bf16 v[32:39], v[16:23], v[24:31], v[32:39]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[40:41], v[48:51], off offset:16
; W32-NEXT:    global_store_b128 v[40:41], v[44:47], off
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[42:43], v[36:39], off offset:16
; W32-NEXT:    global_store_b128 v[42:43], v[32:35], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res.0 = call <16 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16(<16 x i16> %A.0, <16 x i16> %B.0, <16 x i16> %C, i1 0)
  %res.1 = call <16 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16(<16 x i16> %A.1, <16 x i16> %B.1, <16 x i16> %C, i1 0)
  store <16 x i16> %res.0, ptr addrspace(1) %out.0, align 32
  store <16 x i16> %res.1, ptr addrspace(1) %out.1, align 32
  ret void
}

define amdgpu_ps void @test_wmma_bf16_16x16x16_bf16_tied(<16 x i16> %A.0, <16 x i16> %B.0, <16 x i16> %A.1, <16 x i16> %B.1, <16 x i16> %C, ptr addrspace(1) %out.0, ptr addrspace(1) %out.1) {
; W32-LABEL: test_wmma_bf16_16x16x16_bf16_tied:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_dual_mov_b32 v51, v39 :: v_dual_mov_b32 v50, v38
; W32-NEXT:    v_dual_mov_b32 v49, v37 :: v_dual_mov_b32 v48, v36
; W32-NEXT:    v_dual_mov_b32 v47, v35 :: v_dual_mov_b32 v46, v34
; W32-NEXT:    v_dual_mov_b32 v45, v33 :: v_dual_mov_b32 v44, v32
; W32-NEXT:    v_wmma_bf16_16x16x16_bf16 v[32:39], v[16:23], v[24:31], v[32:39]
; W32-NEXT:    s_delay_alu instid0(VALU_DEP_2)
; W32-NEXT:    v_wmma_bf16_16x16x16_bf16 v[44:51], v[0:7], v[8:15], v[44:51]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[40:41], v[48:51], off offset:16
; W32-NEXT:    global_store_b128 v[40:41], v[44:47], off
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[42:43], v[36:39], off offset:16
; W32-NEXT:    global_store_b128 v[42:43], v[32:35], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res.0 = call <16 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16.tied(<16 x i16> %A.0, <16 x i16> %B.0, <16 x i16> %C, i1 0)
  %res.1 = call <16 x i16> @llvm.amdgcn.wmma.bf16.16x16x16.bf16.tied(<16 x i16> %A.1, <16 x i16> %B.1, <16 x i16> %C, i1 0)
  store <16 x i16> %res.0, ptr addrspace(1) %out.0, align 32
  store <16 x i16> %res.1, ptr addrspace(1) %out.1, align 32
  ret void
}

; @llvm.amdgcn.wmma.i32.16x16x16.iu8

define amdgpu_ps void @test_wmma_i32_16x16x16_ui8_unsigned_unsigned(<4 x i32> %A, <4 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui8_unsigned_unsigned:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu8 v[8:15], v[0:3], v[4:7], v[8:15]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; W32-NEXT:    global_store_b128 v[16:17], v[8:11], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8(i1 0, <4 x i32> %A, i1 0, <4 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui8_unsigned_signed(<4 x i32> %A, <4 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui8_unsigned_signed:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu8 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[0,1,0]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; W32-NEXT:    global_store_b128 v[16:17], v[8:11], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8(i1 0, <4 x i32> %A, i1 1, <4 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui8_signed_unsigned(<4 x i32> %A, <4 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui8_signed_unsigned:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu8 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[1,0,0]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; W32-NEXT:    global_store_b128 v[16:17], v[8:11], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8(i1 1, <4 x i32> %A, i1 0, <4 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui8_signed_signed(<4 x i32> %A, <4 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui8_signed_signed:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu8 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[1,1,0]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; W32-NEXT:    global_store_b128 v[16:17], v[8:11], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8(i1 1, <4 x i32> %A, i1 1, <4 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui8_unsigned_unsigned_clamp(<4 x i32> %A, <4 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui8_unsigned_unsigned_clamp:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu8 v[8:15], v[0:3], v[4:7], v[8:15] clamp
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; W32-NEXT:    global_store_b128 v[16:17], v[8:11], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8(i1 0, <4 x i32> %A, i1 0, <4 x i32> %B, <8 x i32> %C, i1 1)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui8_unsigned_signed_clamp(<4 x i32> %A, <4 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui8_unsigned_signed_clamp:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu8 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[0,1,0] clamp
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; W32-NEXT:    global_store_b128 v[16:17], v[8:11], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8(i1 0, <4 x i32> %A, i1 1, <4 x i32> %B, <8 x i32> %C, i1 1)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui8_signed_unsigned_clamp(<4 x i32> %A, <4 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui8_signed_unsigned_clamp:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu8 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[1,0,0] clamp
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; W32-NEXT:    global_store_b128 v[16:17], v[8:11], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8(i1 1, <4 x i32> %A, i1 0, <4 x i32> %B, <8 x i32> %C, i1 1)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui8_signed_signed_clamp(<4 x i32> %A, <4 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui8_signed_signed_clamp:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu8 v[8:15], v[0:3], v[4:7], v[8:15] neg_lo:[1,1,0] clamp
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[16:17], v[12:15], off offset:16
; W32-NEXT:    global_store_b128 v[16:17], v[8:11], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu8(i1 1, <4 x i32> %A, i1 1, <4 x i32> %B, <8 x i32> %C, i1 1)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

; @llvm.amdgcn.wmma.i32.16x16x16.iu4

define amdgpu_ps void @test_wmma_i32_16x16x16_ui4_unsigned_unsigned(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui4_unsigned_unsigned:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu4 v[4:11], v[0:1], v[2:3], v[4:11]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; W32-NEXT:    global_store_b128 v[12:13], v[4:7], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4(i1 0, <2 x i32> %A, i1 0, <2 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui4_unsigned_signed(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui4_unsigned_signed:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu4 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[0,1,0]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; W32-NEXT:    global_store_b128 v[12:13], v[4:7], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4(i1 0, <2 x i32> %A, i1 1, <2 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui4_signed_unsigned(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui4_signed_unsigned:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu4 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[1,0,0]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; W32-NEXT:    global_store_b128 v[12:13], v[4:7], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4(i1 1, <2 x i32> %A, i1 0, <2 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui4_signed_signed(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui4_signed_signed:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu4 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[1,1,0]
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; W32-NEXT:    global_store_b128 v[12:13], v[4:7], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4(i1 1, <2 x i32> %A, i1 1, <2 x i32> %B, <8 x i32> %C, i1 0)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}


define amdgpu_ps void @test_wmma_i32_16x16x16_ui4_unsigned_unsigned_clamp(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui4_unsigned_unsigned_clamp:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu4 v[4:11], v[0:1], v[2:3], v[4:11] clamp
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; W32-NEXT:    global_store_b128 v[12:13], v[4:7], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4(i1 0, <2 x i32> %A, i1 0, <2 x i32> %B, <8 x i32> %C, i1 1)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui4_unsigned_signed_clamp(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui4_unsigned_signed_clamp:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu4 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[0,1,0] clamp
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; W32-NEXT:    global_store_b128 v[12:13], v[4:7], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4(i1 0, <2 x i32> %A, i1 1, <2 x i32> %B, <8 x i32> %C, i1 1)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui4_signed_unsigned_clamp(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui4_signed_unsigned_clamp:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu4 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[1,0,0] clamp
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; W32-NEXT:    global_store_b128 v[12:13], v[4:7], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4(i1 1, <2 x i32> %A, i1 0, <2 x i32> %B, <8 x i32> %C, i1 1)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

define amdgpu_ps void @test_wmma_i32_16x16x16_ui4_signed_signed_clamp(<2 x i32> %A, <2 x i32> %B, <8 x i32> %C, ptr addrspace(1) %out) {
; W32-LABEL: test_wmma_i32_16x16x16_ui4_signed_signed_clamp:
; W32:       ; %bb.0: ; %bb
; W32-NEXT:    v_wmma_i32_16x16x16_iu4 v[4:11], v[0:1], v[2:3], v[4:11] neg_lo:[1,1,0] clamp
; W32-NEXT:    s_clause 0x1
; W32-NEXT:    global_store_b128 v[12:13], v[8:11], off offset:16
; W32-NEXT:    global_store_b128 v[12:13], v[4:7], off
; W32-NEXT:    s_nop 0
; W32-NEXT:    s_sendmsg sendmsg(MSG_DEALLOC_VGPRS)
; W32-NEXT:    s_endpgm
bb:
  %res = call <8 x i32> @llvm.amdgcn.wmma.i32.16x16x16.iu4(i1 1, <2 x i32> %A, i1 1, <2 x i32> %B, <8 x i32> %C, i1 1)
  store <8 x i32> %res, ptr addrspace(1) %out, align 32
  ret void
}

