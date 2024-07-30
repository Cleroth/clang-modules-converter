; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn-- -lowerswitch -structurizecfg -si-annotate-control-flow < %s | FileCheck -check-prefix=OPT %s
; RUN: llc -mtriple=amdgcn -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

; Ensure two if.break calls, for both the inner and outer loops
; FIXME: duplicate comparison
define amdgpu_vs void @multi_else_break(<4 x float> %vec, i32 %ub, i32 %cont) {
; OPT-LABEL: @multi_else_break(
; OPT-NEXT:  main_body:
; OPT-NEXT:    br label [[LOOP_OUTER:%.*]]
; OPT:       LOOP.outer:
; OPT-NEXT:    [[PHI_BROKEN2:%.*]] = phi i64 [ [[TMP8:%.*]], [[FLOW1:%.*]] ], [ 0, [[MAIN_BODY:%.*]] ]
; OPT-NEXT:    [[TMP43:%.*]] = phi i32 [ 0, [[MAIN_BODY]] ], [ [[TMP3:%.*]], [[FLOW1]] ]
; OPT-NEXT:    br label [[LOOP:%.*]]
; OPT:       LOOP:
; OPT-NEXT:    [[PHI_BROKEN:%.*]] = phi i64 [ [[TMP6:%.*]], [[FLOW:%.*]] ], [ 0, [[LOOP_OUTER]] ]
; OPT-NEXT:    [[TMP45:%.*]] = phi i32 [ [[TMP43]], [[LOOP_OUTER]] ], [ [[TMP3]], [[FLOW]] ]
; OPT-NEXT:    [[TMP48:%.*]] = icmp slt i32 [[TMP45]], [[UB:%.*]]
; OPT-NEXT:    [[TMP0:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP48]])
; OPT-NEXT:    [[TMP1:%.*]] = extractvalue { i1, i64 } [[TMP0]], 0
; OPT-NEXT:    [[TMP2:%.*]] = extractvalue { i1, i64 } [[TMP0]], 1
; OPT-NEXT:    br i1 [[TMP1]], label [[ENDIF:%.*]], label [[FLOW]]
; OPT:       Flow:
; OPT-NEXT:    [[TMP3]] = phi i32 [ [[TMP47:%.*]], [[ENDIF]] ], [ undef, [[LOOP]] ]
; OPT-NEXT:    [[TMP4:%.*]] = phi i1 [ [[TMP51:%.*]], [[ENDIF]] ], [ true, [[LOOP]] ]
; OPT-NEXT:    [[TMP5:%.*]] = phi i1 [ [[TMP51_INV:%.*]], [[ENDIF]] ], [ true, [[LOOP]] ]
; OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP2]])
; OPT-NEXT:    [[TMP6]] = call i64 @llvm.amdgcn.if.break.i64(i1 [[TMP5]], i64 [[PHI_BROKEN]])
; OPT-NEXT:    [[TMP7:%.*]] = call i1 @llvm.amdgcn.loop.i64(i64 [[TMP6]])
; OPT-NEXT:    [[TMP8]] = call i64 @llvm.amdgcn.if.break.i64(i1 [[TMP4]], i64 [[PHI_BROKEN2]])
; OPT-NEXT:    br i1 [[TMP7]], label [[FLOW1]], label [[LOOP]]
; OPT:       Flow1:
; OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP6]])
; OPT-NEXT:    [[TMP9:%.*]] = call i1 @llvm.amdgcn.loop.i64(i64 [[TMP8]])
; OPT-NEXT:    br i1 [[TMP9]], label [[IF:%.*]], label [[LOOP_OUTER]]
; OPT:       IF:
; OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP8]])
; OPT-NEXT:    ret void
; OPT:       ENDIF:
; OPT-NEXT:    [[TMP47]] = add i32 [[TMP45]], 1
; OPT-NEXT:    [[TMP51]] = icmp eq i32 [[TMP47]], [[CONT:%.*]]
; OPT-NEXT:    [[TMP51_INV]] = xor i1 [[TMP51]], true
; OPT-NEXT:    br label [[FLOW]]
;
; GCN-LABEL: multi_else_break:
; GCN:       ; %bb.0: ; %main_body
; GCN-NEXT:    s_mov_b64 s[0:1], 0
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_branch .LBB0_2
; GCN-NEXT:  .LBB0_1: ; %loop.exit.guard
; GCN-NEXT:    ; in Loop: Header=BB0_2 Depth=1
; GCN-NEXT:    s_or_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_and_b64 s[2:3], exec, s[2:3]
; GCN-NEXT:    s_or_b64 s[0:1], s[2:3], s[0:1]
; GCN-NEXT:    s_andn2_b64 exec, exec, s[0:1]
; GCN-NEXT:    s_cbranch_execz .LBB0_6
; GCN-NEXT:  .LBB0_2: ; %LOOP.outer
; GCN-NEXT:    ; =>This Loop Header: Depth=1
; GCN-NEXT:    ; Child Loop BB0_4 Depth 2
; GCN-NEXT:    ; implicit-def: $sgpr6_sgpr7
; GCN-NEXT:    ; implicit-def: $sgpr2_sgpr3
; GCN-NEXT:    s_mov_b64 s[4:5], 0
; GCN-NEXT:    s_branch .LBB0_4
; GCN-NEXT:  .LBB0_3: ; %Flow
; GCN-NEXT:    ; in Loop: Header=BB0_4 Depth=2
; GCN-NEXT:    s_or_b64 exec, exec, s[8:9]
; GCN-NEXT:    s_and_b64 s[8:9], exec, s[6:7]
; GCN-NEXT:    s_or_b64 s[4:5], s[8:9], s[4:5]
; GCN-NEXT:    s_andn2_b64 exec, exec, s[4:5]
; GCN-NEXT:    s_cbranch_execz .LBB0_1
; GCN-NEXT:  .LBB0_4: ; %LOOP
; GCN-NEXT:    ; Parent Loop BB0_2 Depth=1
; GCN-NEXT:    ; => This Inner Loop Header: Depth=2
; GCN-NEXT:    v_cmp_lt_i32_e32 vcc, v0, v4
; GCN-NEXT:    s_or_b64 s[2:3], s[2:3], exec
; GCN-NEXT:    s_or_b64 s[6:7], s[6:7], exec
; GCN-NEXT:    s_and_saveexec_b64 s[8:9], vcc
; GCN-NEXT:    s_cbranch_execz .LBB0_3
; GCN-NEXT:  ; %bb.5: ; %ENDIF
; GCN-NEXT:    ; in Loop: Header=BB0_4 Depth=2
; GCN-NEXT:    v_add_i32_e32 v0, vcc, 1, v0
; GCN-NEXT:    s_andn2_b64 s[2:3], s[2:3], exec
; GCN-NEXT:    v_cmp_ne_u32_e32 vcc, v5, v0
; GCN-NEXT:    s_andn2_b64 s[6:7], s[6:7], exec
; GCN-NEXT:    s_and_b64 s[10:11], vcc, exec
; GCN-NEXT:    s_or_b64 s[6:7], s[6:7], s[10:11]
; GCN-NEXT:    s_branch .LBB0_3
; GCN-NEXT:  .LBB0_6: ; %IF
; GCN-NEXT:    s_endpgm
main_body:
  br label %LOOP.outer

LOOP.outer:                                       ; preds = %ENDIF, %main_body
  %tmp43 = phi i32 [ 0, %main_body ], [ %tmp47, %ENDIF ]
  br label %LOOP

LOOP:                                             ; preds = %ENDIF, %LOOP.outer
  %tmp45 = phi i32 [ %tmp43, %LOOP.outer ], [ %tmp47, %ENDIF ]
  %tmp48 = icmp slt i32 %tmp45, %ub
  br i1 %tmp48, label %ENDIF, label %IF

IF:                                               ; preds = %LOOP
  ret void

ENDIF:                                            ; preds = %LOOP
  %tmp47 = add i32 %tmp45, 1
  %tmp51 = icmp eq i32 %tmp47, %cont
  br i1 %tmp51, label %LOOP, label %LOOP.outer
}

define amdgpu_kernel void @multi_if_break_loop(i32 %arg) #0 {
; OPT-LABEL: @multi_if_break_loop(
; OPT-NEXT:  bb:
; OPT-NEXT:    [[ID:%.*]] = call i32 @llvm.amdgcn.workitem.id.x()
; OPT-NEXT:    [[TMP:%.*]] = sub i32 [[ID]], [[ARG:%.*]]
; OPT-NEXT:    br label [[BB1:%.*]]
; OPT:       bb1:
; OPT-NEXT:    [[PHI_BROKEN:%.*]] = phi i64 [ [[TMP4:%.*]], [[FLOW4:%.*]] ], [ 0, [[BB:%.*]] ]
; OPT-NEXT:    [[LSR_IV:%.*]] = phi i32 [ undef, [[BB]] ], [ [[TMP2:%.*]], [[FLOW4]] ]
; OPT-NEXT:    [[LSR_IV_NEXT:%.*]] = add i32 [[LSR_IV]], 1
; OPT-NEXT:    [[CMP0:%.*]] = icmp slt i32 [[LSR_IV_NEXT]], 0
; OPT-NEXT:    [[LOAD0:%.*]] = load volatile i32, ptr addrspace(1) undef, align 4
; OPT-NEXT:    br label [[NODEBLOCK:%.*]]
; OPT:       NodeBlock:
; OPT-NEXT:    [[PIVOT:%.*]] = icmp sge i32 [[LOAD0]], 1
; OPT-NEXT:    br i1 [[PIVOT]], label [[LEAFBLOCK1:%.*]], label [[FLOW:%.*]]
; OPT:       LeafBlock1:
; OPT-NEXT:    [[SWITCHLEAF2:%.*]] = icmp eq i32 [[LOAD0]], 1
; OPT-NEXT:    br i1 [[SWITCHLEAF2]], label [[CASE1:%.*]], label [[FLOW3:%.*]]
; OPT:       Flow3:
; OPT-NEXT:    [[TMP0:%.*]] = phi i32 [ [[LSR_IV_NEXT]], [[CASE1]] ], [ undef, [[LEAFBLOCK1]] ]
; OPT-NEXT:    [[TMP1:%.*]] = phi i1 [ [[CMP2:%.*]], [[CASE1]] ], [ true, [[LEAFBLOCK1]] ]
; OPT-NEXT:    br label [[FLOW]]
; OPT:       LeafBlock:
; OPT-NEXT:    [[SWITCHLEAF:%.*]] = icmp eq i32 [[LOAD0]], 0
; OPT-NEXT:    br i1 [[SWITCHLEAF]], label [[CASE0:%.*]], label [[FLOW5:%.*]]
; OPT:       Flow4:
; OPT-NEXT:    [[TMP2]] = phi i32 [ [[TMP9:%.*]], [[FLOW5]] ], [ [[TMP6:%.*]], [[FLOW]] ]
; OPT-NEXT:    [[TMP3:%.*]] = phi i1 [ [[TMP10:%.*]], [[FLOW5]] ], [ [[TMP7:%.*]], [[FLOW]] ]
; OPT-NEXT:    [[TMP4]] = call i64 @llvm.amdgcn.if.break.i64(i1 [[TMP3]], i64 [[PHI_BROKEN]])
; OPT-NEXT:    [[TMP5:%.*]] = call i1 @llvm.amdgcn.loop.i64(i64 [[TMP4]])
; OPT-NEXT:    br i1 [[TMP5]], label [[BB9:%.*]], label [[BB1]]
; OPT:       case0:
; OPT-NEXT:    [[LOAD1:%.*]] = load volatile i32, ptr addrspace(1) undef, align 4
; OPT-NEXT:    [[CMP1:%.*]] = icmp sge i32 [[TMP]], [[LOAD1]]
; OPT-NEXT:    br label [[FLOW5]]
; OPT:       Flow:
; OPT-NEXT:    [[TMP6]] = phi i32 [ [[TMP0]], [[FLOW3]] ], [ undef, [[NODEBLOCK]] ]
; OPT-NEXT:    [[TMP7]] = phi i1 [ [[TMP1]], [[FLOW3]] ], [ true, [[NODEBLOCK]] ]
; OPT-NEXT:    [[TMP8:%.*]] = phi i1 [ false, [[FLOW3]] ], [ true, [[NODEBLOCK]] ]
; OPT-NEXT:    br i1 [[TMP8]], label [[LEAFBLOCK:%.*]], label [[FLOW4]]
; OPT:       case1:
; OPT-NEXT:    [[LOAD2:%.*]] = load volatile i32, ptr addrspace(1) undef, align 4
; OPT-NEXT:    [[CMP2]] = icmp sge i32 [[TMP]], [[LOAD2]]
; OPT-NEXT:    br label [[FLOW3]]
; OPT:       Flow5:
; OPT-NEXT:    [[TMP9]] = phi i32 [ [[LSR_IV_NEXT]], [[CASE0]] ], [ undef, [[LEAFBLOCK]] ]
; OPT-NEXT:    [[TMP10]] = phi i1 [ [[CMP1]], [[CASE0]] ], [ [[TMP7]], [[LEAFBLOCK]] ]
; OPT-NEXT:    br label [[FLOW4]]
; OPT:       bb9:
; OPT-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP4]])
; OPT-NEXT:    ret void
;
; GCN-LABEL: multi_if_break_loop:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dword s2, s[2:3], 0x9
; GCN-NEXT:    s_mov_b64 s[0:1], 0
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_subrev_i32_e32 v0, vcc, s2, v0
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    s_branch .LBB1_2
; GCN-NEXT:  .LBB1_1: ; %Flow4
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_and_b64 s[4:5], exec, s[4:5]
; GCN-NEXT:    s_or_b64 s[0:1], s[4:5], s[0:1]
; GCN-NEXT:    s_andn2_b64 exec, exec, s[0:1]
; GCN-NEXT:    s_cbranch_execz .LBB1_9
; GCN-NEXT:  .LBB1_2: ; %bb1
; GCN-NEXT:    ; =>This Inner Loop Header: Depth=1
; GCN-NEXT:    buffer_load_dword v1, off, s[0:3], 0 glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_readfirstlane_b32 s8, v1
; GCN-NEXT:    s_mov_b64 s[4:5], -1
; GCN-NEXT:    s_cmp_lt_i32 s8, 1
; GCN-NEXT:    s_mov_b64 s[6:7], -1
; GCN-NEXT:    s_cbranch_scc1 .LBB1_6
; GCN-NEXT:  ; %bb.3: ; %LeafBlock1
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_cmp_eq_u32 s8, 1
; GCN-NEXT:    s_cbranch_scc0 .LBB1_5
; GCN-NEXT:  ; %bb.4: ; %case1
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    buffer_load_dword v1, off, s[0:3], 0 glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_ge_i32_e32 vcc, v0, v1
; GCN-NEXT:    s_orn2_b64 s[4:5], vcc, exec
; GCN-NEXT:  .LBB1_5: ; %Flow3
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_mov_b64 s[6:7], 0
; GCN-NEXT:  .LBB1_6: ; %Flow
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_and_b64 vcc, exec, s[6:7]
; GCN-NEXT:    s_cbranch_vccz .LBB1_1
; GCN-NEXT:  ; %bb.7: ; %LeafBlock
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    s_cmp_eq_u32 s8, 0
; GCN-NEXT:    s_cbranch_scc0 .LBB1_1
; GCN-NEXT:  ; %bb.8: ; %case0
; GCN-NEXT:    ; in Loop: Header=BB1_2 Depth=1
; GCN-NEXT:    buffer_load_dword v1, off, s[0:3], 0 glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_ge_i32_e32 vcc, v0, v1
; GCN-NEXT:    s_andn2_b64 s[4:5], s[4:5], exec
; GCN-NEXT:    s_and_b64 s[6:7], vcc, exec
; GCN-NEXT:    s_or_b64 s[4:5], s[4:5], s[6:7]
; GCN-NEXT:    s_branch .LBB1_1
; GCN-NEXT:  .LBB1_9: ; %bb9
; GCN-NEXT:    s_endpgm
bb:
  %id = call i32 @llvm.amdgcn.workitem.id.x()
  %tmp = sub i32 %id, %arg
  br label %bb1

bb1:
  %lsr.iv = phi i32 [ undef, %bb ], [ %lsr.iv.next, %case0 ], [ %lsr.iv.next, %case1 ]
  %lsr.iv.next = add i32 %lsr.iv, 1
  %cmp0 = icmp slt i32 %lsr.iv.next, 0
  %load0 = load volatile i32, ptr addrspace(1) undef, align 4
  switch i32 %load0, label %bb9 [
  i32 0, label %case0
  i32 1, label %case1
  ]

case0:
  %load1 = load volatile i32, ptr addrspace(1) undef, align 4
  %cmp1 = icmp slt i32 %tmp, %load1
  br i1 %cmp1, label %bb1, label %bb9

case1:
  %load2 = load volatile i32, ptr addrspace(1) undef, align 4
  %cmp2 = icmp slt i32 %tmp, %load2
  br i1 %cmp2, label %bb1, label %bb9

bb9:
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
