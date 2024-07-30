; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx940 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX940 %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx940 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX940 %s
; RUN: llc -global-isel=0 -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX12 %s
; RUN: llc -global-isel=1 -mtriple=amdgcn -mcpu=gfx1200 -verify-machineinstrs < %s | FileCheck -check-prefix=GFX12 %s

declare float @llvm.amdgcn.cvt.f32.bf8(i32, i32)
declare float @llvm.amdgcn.cvt.f32.fp8(i32, i32)
declare <2 x float> @llvm.amdgcn.cvt.pk.f32.bf8(i32, i1)
declare <2 x float> @llvm.amdgcn.cvt.pk.f32.fp8(i32, i1)
declare i32 @llvm.amdgcn.cvt.pk.bf8.f32(float, float, i32, i1)
declare i32 @llvm.amdgcn.cvt.pk.fp8.f32(float, float, i32, i1)
declare i32 @llvm.amdgcn.cvt.sr.bf8.f32(float, i32, i32, i32)
declare i32 @llvm.amdgcn.cvt.sr.fp8.f32(float, i32, i32, i32)

define float @test_cvt_f32_bf8_byte0(i32 %a) {
; GFX940-LABEL: test_cvt_f32_bf8_byte0:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_f32_bf8_sdwa v0, v0 src0_sel:BYTE_0
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_f32_bf8_byte0:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_f32_bf8_e32 v0, v0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.cvt.f32.bf8(i32 %a, i32 0)
  ret float %ret
}

define float @test_cvt_f32_bf8_byte1(i32 %a) {
; GFX940-LABEL: test_cvt_f32_bf8_byte1:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_f32_bf8_sdwa v0, v0 src0_sel:BYTE_1
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_f32_bf8_byte1:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_f32_bf8_e64 v0, v0 byte_sel:1
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.cvt.f32.bf8(i32 %a, i32 1)
  ret float %ret
}

define float @test_cvt_f32_bf8_byte2(i32 %a) {
; GFX940-LABEL: test_cvt_f32_bf8_byte2:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_f32_bf8_sdwa v0, v0 src0_sel:BYTE_2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_f32_bf8_byte2:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_f32_bf8_e64 v0, v0 byte_sel:2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.cvt.f32.bf8(i32 %a, i32 2)
  ret float %ret
}

define float @test_cvt_f32_bf8_byte3(i32 %a) {
; GFX940-LABEL: test_cvt_f32_bf8_byte3:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_f32_bf8_sdwa v0, v0 src0_sel:BYTE_3
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_f32_bf8_byte3:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_f32_bf8_e64 v0, v0 byte_sel:3
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.cvt.f32.bf8(i32 %a, i32 3)
  ret float %ret
}

define float @test_cvt_f32_fp8_byte0(i32 %a) {
; GFX940-LABEL: test_cvt_f32_fp8_byte0:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_f32_fp8_sdwa v0, v0 src0_sel:BYTE_0
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_f32_fp8_byte0:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_f32_fp8_e32 v0, v0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.cvt.f32.fp8(i32 %a, i32 0)
  ret float %ret
}

define float @test_cvt_f32_fp8_byte1(i32 %a) {
; GFX940-LABEL: test_cvt_f32_fp8_byte1:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_f32_fp8_sdwa v0, v0 src0_sel:BYTE_1
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_f32_fp8_byte1:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_f32_fp8_e64 v0, v0 byte_sel:1
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.cvt.f32.fp8(i32 %a, i32 1)
  ret float %ret
}

define float @test_cvt_f32_fp8_byte2(i32 %a) {
; GFX940-LABEL: test_cvt_f32_fp8_byte2:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_f32_fp8_sdwa v0, v0 src0_sel:BYTE_2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_f32_fp8_byte2:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_f32_fp8_e64 v0, v0 byte_sel:2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.cvt.f32.fp8(i32 %a, i32 2)
  ret float %ret
}

define float @test_cvt_f32_fp8_byte3(i32 %a) {
; GFX940-LABEL: test_cvt_f32_fp8_byte3:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_f32_fp8_sdwa v0, v0 src0_sel:BYTE_3
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_f32_fp8_byte3:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_f32_fp8_e64 v0, v0 byte_sel:3
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call float @llvm.amdgcn.cvt.f32.fp8(i32 %a, i32 3)
  ret float %ret
}

define <2 x float> @test_cvt_pk_f32_bf8_word0(i32 %a) {
; GFX940-LABEL: test_cvt_pk_f32_bf8_word0:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_pk_f32_bf8_e32 v[0:1], v0
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_pk_f32_bf8_word0:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_pk_f32_bf8_e32 v[0:1], v0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call <2 x float> @llvm.amdgcn.cvt.pk.f32.bf8(i32 %a, i1 false)
  ret <2 x float> %ret
}

define <2 x float> @test_cvt_pk_f32_bf8_word1(i32 %a) {
; GFX940-LABEL: test_cvt_pk_f32_bf8_word1:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_pk_f32_bf8_sdwa v[0:1], v0 src0_sel:WORD_1
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_pk_f32_bf8_word1:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_pk_f32_bf8_e64 v[0:1], v0 op_sel:[1,0]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call <2 x float> @llvm.amdgcn.cvt.pk.f32.bf8(i32 %a, i1 true)
  ret <2 x float> %ret
}

define <2 x float> @test_cvt_pk_f32_fp8_word0(i32 %a) {
; GFX940-LABEL: test_cvt_pk_f32_fp8_word0:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_pk_f32_fp8_e32 v[0:1], v0
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_pk_f32_fp8_word0:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_pk_f32_fp8_e32 v[0:1], v0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call <2 x float> @llvm.amdgcn.cvt.pk.f32.fp8(i32 %a, i1 false)
  ret <2 x float> %ret
}

define <2 x float> @test_cvt_pk_f32_fp8_word1(i32 %a) {
; GFX940-LABEL: test_cvt_pk_f32_fp8_word1:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_pk_f32_fp8_sdwa v[0:1], v0 src0_sel:WORD_1
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_pk_f32_fp8_word1:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_pk_f32_fp8_e64 v[0:1], v0 op_sel:[1,0]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call <2 x float> @llvm.amdgcn.cvt.pk.f32.fp8(i32 %a, i1 true)
  ret <2 x float> %ret
}

define i32 @test_cvt_pk_bf8_f32_word0(float %x, float %y, i32 %old) {
; GFX940-LABEL: test_cvt_pk_bf8_f32_word0:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_pk_bf8_f32 v2, v0, v1
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_pk_bf8_f32_word0:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_pk_bf8_f32 v2, v0, v1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.pk.bf8.f32(float %x, float %y, i32 %old, i1 false)
  ret i32 %ret
}

define i32 @test_cvt_pk_bf8_f32_word1(float %x, float %y, i32 %old) {
; GFX940-LABEL: test_cvt_pk_bf8_f32_word1:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_pk_bf8_f32 v2, v0, v1 op_sel:[0,0,1]
; GFX940-NEXT:    s_nop 0
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_pk_bf8_f32_word1:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_pk_bf8_f32 v2, v0, v1 op_sel:[0,0,1]
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.pk.bf8.f32(float %x, float %y, i32 %old, i1 true)
  ret i32 %ret
}

define i32 @test_cvt_pk_fp8_f32_word0(float %x, float %y, i32 %old) {
; GFX940-LABEL: test_cvt_pk_fp8_f32_word0:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_pk_fp8_f32 v2, v0, v1
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_pk_fp8_f32_word0:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_pk_fp8_f32 v2, v0, v1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.pk.fp8.f32(float %x, float %y, i32 %old, i1 false)
  ret i32 %ret
}

define i32 @test_cvt_pk_fp8_f32_word1(float %x, float %y, i32 %old) {
; GFX940-LABEL: test_cvt_pk_fp8_f32_word1:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_pk_fp8_f32 v2, v0, v1 op_sel:[0,0,1]
; GFX940-NEXT:    s_nop 0
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_pk_fp8_f32_word1:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_pk_fp8_f32 v2, v0, v1 op_sel:[0,0,1]
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.pk.fp8.f32(float %x, float %y, i32 %old, i1 true)
  ret i32 %ret
}

define i32 @test_cvt_sr_bf8_f32_byte0(float %x, i32 %r, i32 %old) {
; GFX940-LABEL: test_cvt_sr_bf8_f32_byte0:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_sr_bf8_f32 v2, v0, v1
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_sr_bf8_f32_byte0:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_sr_bf8_f32 v2, v0, v1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.sr.bf8.f32(float %x, i32 %r, i32 %old, i32 0)
  ret i32 %ret
}

define i32 @test_cvt_sr_bf8_f32_byte1(float %x, i32 %r, i32 %old) {
; GFX940-LABEL: test_cvt_sr_bf8_f32_byte1:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_sr_bf8_f32 v2, v0, v1 op_sel:[0,0,1,0]
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_sr_bf8_f32_byte1:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_sr_bf8_f32 v2, v0, v1 byte_sel:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.sr.bf8.f32(float %x, i32 %r, i32 %old, i32 1)
  ret i32 %ret
}

define i32 @test_cvt_sr_bf8_f32_byte2(float %x, i32 %r, i32 %old) {
; GFX940-LABEL: test_cvt_sr_bf8_f32_byte2:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_sr_bf8_f32 v2, v0, v1 op_sel:[0,0,0,1]
; GFX940-NEXT:    s_nop 0
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_sr_bf8_f32_byte2:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_sr_bf8_f32 v2, v0, v1 byte_sel:2
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.sr.bf8.f32(float %x, i32 %r, i32 %old, i32 2)
  ret i32 %ret
}

define i32 @test_cvt_sr_bf8_f32_byte3(float %x, i32 %r, i32 %old) {
; GFX940-LABEL: test_cvt_sr_bf8_f32_byte3:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_sr_bf8_f32 v2, v0, v1 op_sel:[0,0,1,1]
; GFX940-NEXT:    s_nop 0
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_sr_bf8_f32_byte3:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_sr_bf8_f32 v2, v0, v1 byte_sel:3
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.sr.bf8.f32(float %x, i32 %r, i32 %old, i32 3)
  ret i32 %ret
}

define i32 @test_cvt_sr_fp8_f32_byte0(float %x, i32 %r, i32 %old) {
; GFX940-LABEL: test_cvt_sr_fp8_f32_byte0:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_sr_fp8_f32 v2, v0, v1
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_sr_fp8_f32_byte0:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_sr_fp8_f32 v2, v0, v1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.sr.fp8.f32(float %x, i32 %r, i32 %old, i32 0)
  ret i32 %ret
}

define i32 @test_cvt_sr_fp8_f32_byte1(float %x, i32 %r, i32 %old) {
; GFX940-LABEL: test_cvt_sr_fp8_f32_byte1:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_sr_fp8_f32 v2, v0, v1 op_sel:[0,0,1,0]
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_sr_fp8_f32_byte1:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_sr_fp8_f32 v2, v0, v1 byte_sel:1
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.sr.fp8.f32(float %x, i32 %r, i32 %old, i32 1)
  ret i32 %ret
}

define i32 @test_cvt_sr_fp8_f32_byte2(float %x, i32 %r, i32 %old) {
; GFX940-LABEL: test_cvt_sr_fp8_f32_byte2:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_sr_fp8_f32 v2, v0, v1 op_sel:[0,0,0,1]
; GFX940-NEXT:    s_nop 0
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_sr_fp8_f32_byte2:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_sr_fp8_f32 v2, v0, v1 byte_sel:2
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.sr.fp8.f32(float %x, i32 %r, i32 %old, i32 2)
  ret i32 %ret
}

define i32 @test_cvt_sr_fp8_f32_byte3(float %x, i32 %r, i32 %old) {
; GFX940-LABEL: test_cvt_sr_fp8_f32_byte3:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_cvt_sr_fp8_f32 v2, v0, v1 op_sel:[0,0,1,1]
; GFX940-NEXT:    s_nop 0
; GFX940-NEXT:    v_mov_b32_e32 v0, v2
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_cvt_sr_fp8_f32_byte3:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_cvt_sr_fp8_f32 v2, v0, v1 byte_sel:3
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_mov_b32_e32 v0, v2
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %ret = tail call i32 @llvm.amdgcn.cvt.sr.fp8.f32(float %x, i32 %r, i32 %old, i32 3)
  ret i32 %ret
}

define float @test_sext_cvt_f32_fp8(i16 %a) {
; GFX940-LABEL: test_sext_cvt_f32_fp8:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX940-NEXT:    v_cvt_f32_fp8_sdwa v0, v0 src0_sel:BYTE_1
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_sext_cvt_f32_fp8:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_cvt_f32_fp8_e64 v0, v0 byte_sel:1
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %a.sext = sext i16 %a to i32
  %ret = tail call float @llvm.amdgcn.cvt.f32.fp8(i32 %a.sext, i32 1)
  ret float %ret
}

define float @test_sext_cvt_f32_bf8(i16 %a) {
; GFX940-LABEL: test_sext_cvt_f32_bf8:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX940-NEXT:    v_cvt_f32_bf8_sdwa v0, v0 src0_sel:BYTE_1
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_sext_cvt_f32_bf8:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_cvt_f32_bf8_e64 v0, v0 byte_sel:1
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %a.sext = sext i16 %a to i32
  %ret = tail call float @llvm.amdgcn.cvt.f32.bf8(i32 %a.sext, i32 1)
  ret float %ret
}

define <2 x float> @test_sext_cvt_pk_f32_bf8_word1(i16 %a) {
; GFX940-LABEL: test_sext_cvt_pk_f32_bf8_word1:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX940-NEXT:    v_cvt_pk_f32_bf8_sdwa v[0:1], v0 src0_sel:WORD_1
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_sext_cvt_pk_f32_bf8_word1:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_cvt_pk_f32_bf8_e64 v[0:1], v0 op_sel:[1,0]
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %a.sext = sext i16 %a to i32
  %ret = tail call <2 x float> @llvm.amdgcn.cvt.pk.f32.bf8(i32 %a.sext, i1 true)
  ret <2 x float> %ret
}

define <2 x float> @test_sext_cvt_pk_f32_fp8_word0(i16 %a) {
; GFX940-LABEL: test_sext_cvt_pk_f32_fp8_word0:
; GFX940:       ; %bb.0:
; GFX940-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GFX940-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX940-NEXT:    v_cvt_pk_f32_fp8_e32 v[0:1], v0
; GFX940-NEXT:    s_setpc_b64 s[30:31]
;
; GFX12-LABEL: test_sext_cvt_pk_f32_fp8_word0:
; GFX12:       ; %bb.0:
; GFX12-NEXT:    s_wait_loadcnt_dscnt 0x0
; GFX12-NEXT:    s_wait_expcnt 0x0
; GFX12-NEXT:    s_wait_samplecnt 0x0
; GFX12-NEXT:    s_wait_bvhcnt 0x0
; GFX12-NEXT:    s_wait_kmcnt 0x0
; GFX12-NEXT:    v_bfe_i32 v0, v0, 0, 16
; GFX12-NEXT:    s_delay_alu instid0(VALU_DEP_1)
; GFX12-NEXT:    v_cvt_pk_f32_fp8_e32 v[0:1], v0
; GFX12-NEXT:    s_setpc_b64 s[30:31]
  %a.sext = sext i16 %a to i32
  %ret = tail call <2 x float> @llvm.amdgcn.cvt.pk.f32.fp8(i32 %a.sext, i1 false)
  ret <2 x float> %ret
}
