; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: opt -mtriple=amdgcn-- -S -structurizecfg -si-annotate-control-flow %s | FileCheck -check-prefix=IR %s
; RUN: llc -mtriple=amdgcn -mcpu=hawaii -verify-machineinstrs < %s | FileCheck -check-prefix=GCN %s

; After structurizing, there are 3 levels of loops. The i1 phi
; conditions mutually depend on each other, so it isn't safe to delete
; the condition that appears to have no uses until the loop is
; completely processed.

define amdgpu_kernel void @reduced_nested_loop_conditions(ptr addrspace(3) nocapture %arg) #0 {
; GCN-LABEL: reduced_nested_loop_conditions:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_load_dword s0, s[2:3], 0x9
; GCN-NEXT:    v_lshlrev_b32_e32 v0, 3, v0
; GCN-NEXT:    s_mov_b32 m0, -1
; GCN-NEXT:    s_mov_b32 s2, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_add_i32_e32 v0, vcc, s0, v0
; GCN-NEXT:    ds_read_b64 v[0:1], v0
; GCN-NEXT:    s_and_b64 vcc, exec, 0
; GCN-NEXT:    s_branch .LBB0_2
; GCN-NEXT:  .LBB0_1: ; %Flow
; GCN-NEXT:    ; in Loop: Header=BB0_2 Depth=1
; GCN-NEXT:    ; implicit-def: $sgpr2
; GCN-NEXT:    s_mov_b64 vcc, vcc
; GCN-NEXT:    s_cbranch_vccz .LBB0_4
; GCN-NEXT:  .LBB0_2: ; %bb5
; GCN-NEXT:    ; =>This Inner Loop Header: Depth=1
; GCN-NEXT:    s_cmp_lg_u32 s2, 1
; GCN-NEXT:    s_mov_b64 s[0:1], -1
; GCN-NEXT:    s_cbranch_scc0 .LBB0_1
; GCN-NEXT:  ; %bb.3: ; %bb10
; GCN-NEXT:    ; in Loop: Header=BB0_2 Depth=1
; GCN-NEXT:    s_mov_b64 s[0:1], 0
; GCN-NEXT:    s_branch .LBB0_1
; GCN-NEXT:  .LBB0_4: ; %loop.exit.guard
; GCN-NEXT:    s_and_b64 vcc, exec, s[0:1]
; GCN-NEXT:    s_cbranch_vccz .LBB0_7
; GCN-NEXT:  ; %bb.5: ; %bb8
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    ds_read_b32 v0, v0
; GCN-NEXT:    s_and_b64 vcc, exec, 0
; GCN-NEXT:  .LBB0_6: ; %bb9
; GCN-NEXT:    ; =>This Inner Loop Header: Depth=1
; GCN-NEXT:    s_mov_b64 vcc, vcc
; GCN-NEXT:    s_cbranch_vccz .LBB0_6
; GCN-NEXT:  .LBB0_7: ; %DummyReturnBlock
; GCN-NEXT:    s_endpgm
; IR-LABEL: @reduced_nested_loop_conditions(
; IR-NEXT:  bb:
; IR-NEXT:    [[MY_TMP:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x() #[[ATTR4:[0-9]+]]
; IR-NEXT:    [[MY_TMP1:%.*]] = getelementptr inbounds i64, ptr addrspace(3) [[ARG:%.*]], i32 [[MY_TMP]]
; IR-NEXT:    [[MY_TMP2:%.*]] = load volatile i64, ptr addrspace(3) [[MY_TMP1]], align 8
; IR-NEXT:    br label [[BB5:%.*]]
; IR:       bb3:
; IR-NEXT:    br i1 true, label [[BB4:%.*]], label [[BB13:%.*]]
; IR:       bb4:
; IR-NEXT:    br label [[FLOW:%.*]]
; IR:       bb5:
; IR-NEXT:    [[PHI_BROKEN:%.*]] = phi i64 [ [[TMP6:%.*]], [[BB10:%.*]] ], [ 0, [[BB:%.*]] ]
; IR-NEXT:    [[MY_TMP6:%.*]] = phi i32 [ 0, [[BB]] ], [ [[TMP5:%.*]], [[BB10]] ]
; IR-NEXT:    [[MY_TMP7:%.*]] = icmp eq i32 [[MY_TMP6]], 1
; IR-NEXT:    [[TMP0:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[MY_TMP7]])
; IR-NEXT:    [[TMP1:%.*]] = extractvalue { i1, i64 } [[TMP0]], 0
; IR-NEXT:    [[TMP2:%.*]] = extractvalue { i1, i64 } [[TMP0]], 1
; IR-NEXT:    br i1 [[TMP1]], label [[BB8:%.*]], label [[FLOW]]
; IR:       bb8:
; IR-NEXT:    br label [[BB13]]
; IR:       bb9:
; IR-NEXT:    br i1 false, label [[BB3:%.*]], label [[BB9:%.*]]
; IR:       bb10:
; IR-NEXT:    [[TMP3:%.*]] = call i1 @llvm.amdgcn.loop.i64(i64 [[TMP6]])
; IR-NEXT:    br i1 [[TMP3]], label [[BB23:%.*]], label [[BB5]]
; IR:       Flow:
; IR-NEXT:    [[TMP4:%.*]] = phi i1 [ [[MY_TMP22:%.*]], [[BB4]] ], [ true, [[BB5]] ]
; IR-NEXT:    [[TMP5]] = phi i32 [ [[MY_TMP21:%.*]], [[BB4]] ], [ undef, [[BB5]] ]
; IR-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP2]])
; IR-NEXT:    [[TMP6]] = call i64 @llvm.amdgcn.if.break.i64(i1 [[TMP4]], i64 [[PHI_BROKEN]])
; IR-NEXT:    br label [[BB10]]
; IR:       bb13:
; IR-NEXT:    [[MY_TMP14:%.*]] = phi i1 [ [[MY_TMP22]], [[BB3]] ], [ true, [[BB8]] ]
; IR-NEXT:    [[MY_TMP15:%.*]] = bitcast i64 [[MY_TMP2]] to <2 x i32>
; IR-NEXT:    br i1 [[MY_TMP14]], label [[BB16:%.*]], label [[BB20:%.*]]
; IR:       bb16:
; IR-NEXT:    [[MY_TMP17:%.*]] = extractelement <2 x i32> [[MY_TMP15]], i64 1
; IR-NEXT:    [[MY_TMP18:%.*]] = getelementptr inbounds i32, ptr addrspace(3) undef, i32 [[MY_TMP17]]
; IR-NEXT:    [[MY_TMP19:%.*]] = load volatile i32, ptr addrspace(3) [[MY_TMP18]], align 4
; IR-NEXT:    br label [[BB20]]
; IR:       bb20:
; IR-NEXT:    [[MY_TMP21]] = phi i32 [ [[MY_TMP19]], [[BB16]] ], [ 0, [[BB13]] ]
; IR-NEXT:    [[MY_TMP22]] = phi i1 [ false, [[BB16]] ], [ [[MY_TMP14]], [[BB13]] ]
; IR-NEXT:    br label [[BB9]]
; IR:       bb23:
; IR-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP6]])
; IR-NEXT:    ret void
bb:
  %my.tmp = tail call i32 @llvm.amdgcn.workitem.id.x() #1
  %my.tmp1 = getelementptr inbounds i64, ptr addrspace(3) %arg, i32 %my.tmp
  %my.tmp2 = load volatile i64, ptr addrspace(3) %my.tmp1
  br label %bb5

bb3:                                              ; preds = %bb9
  br i1 true, label %bb4, label %bb13

bb4:                                              ; preds = %bb3
  br label %bb10

bb5:                                              ; preds = %bb10, %bb
  %my.tmp6 = phi i32 [ 0, %bb ], [ %my.tmp11, %bb10 ]
  %my.tmp7 = icmp eq i32 %my.tmp6, 1
  br i1 %my.tmp7, label %bb8, label %bb10

bb8:                                              ; preds = %bb5
  br label %bb13

bb9:                                              ; preds = %bb20, %bb9
  br i1 false, label %bb3, label %bb9

bb10:                                             ; preds = %bb5, %bb4
  %my.tmp11 = phi i32 [ %my.tmp21, %bb4 ], [ undef, %bb5 ]
  %my.tmp12 = phi i1 [ %my.tmp22, %bb4 ], [ true, %bb5 ]
  br i1 %my.tmp12, label %bb23, label %bb5

bb13:                                             ; preds = %bb8, %bb3
  %my.tmp14 = phi i1 [ %my.tmp22, %bb3 ], [ true, %bb8 ]
  %my.tmp15 = bitcast i64 %my.tmp2 to <2 x i32>
  br i1 %my.tmp14, label %bb16, label %bb20

bb16:                                             ; preds = %bb13
  %my.tmp17 = extractelement <2 x i32> %my.tmp15, i64 1
  %my.tmp18 = getelementptr inbounds i32, ptr addrspace(3) undef, i32 %my.tmp17
  %my.tmp19 = load volatile i32, ptr addrspace(3) %my.tmp18
  br label %bb20

bb20:                                             ; preds = %bb16, %bb13
  %my.tmp21 = phi i32 [ %my.tmp19, %bb16 ], [ 0, %bb13 ]
  %my.tmp22 = phi i1 [ false, %bb16 ], [ %my.tmp14, %bb13 ]
  br label %bb9

bb23:                                             ; preds = %bb10
  ret void
}

; Earlier version of above, before a run of the structurizer.

define amdgpu_kernel void @nested_loop_conditions(ptr addrspace(1) nocapture %arg) #0 {
; GCN-LABEL: nested_loop_conditions:
; GCN:       ; %bb.0: ; %bb
; GCN-NEXT:    s_mov_b32 s3, 0xf000
; GCN-NEXT:    s_mov_b32 s2, -1
; GCN-NEXT:    buffer_load_dword v0, off, s[0:3], 0 glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_lt_i32_e32 vcc, 8, v0
; GCN-NEXT:    s_cbranch_vccnz .LBB1_6
; GCN-NEXT:  ; %bb.1: ; %bb14.lr.ph
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-NEXT:    s_branch .LBB1_3
; GCN-NEXT:  .LBB1_2: ; %Flow
; GCN-NEXT:    ; in Loop: Header=BB1_3 Depth=1
; GCN-NEXT:    s_and_b64 vcc, exec, s[0:1]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_mov_b64 vcc, vcc
; GCN-NEXT:    s_cbranch_vccnz .LBB1_6
; GCN-NEXT:  .LBB1_3: ; %bb14
; GCN-NEXT:    ; =>This Loop Header: Depth=1
; GCN-NEXT:    ; Child Loop BB1_4 Depth 2
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_cmp_lg_u32 s4, 1
; GCN-NEXT:    s_mov_b64 s[0:1], -1
; GCN-NEXT:    ; implicit-def: $sgpr4
; GCN-NEXT:    s_cbranch_scc1 .LBB1_2
; GCN-NEXT:  .LBB1_4: ; %bb18
; GCN-NEXT:    ; Parent Loop BB1_3 Depth=1
; GCN-NEXT:    ; => This Inner Loop Header: Depth=2
; GCN-NEXT:    buffer_load_dword v0, off, s[0:3], 0 glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_lt_i32_e32 vcc, 8, v0
; GCN-NEXT:    s_cbranch_vccnz .LBB1_4
; GCN-NEXT:  ; %bb.5: ; %bb21
; GCN-NEXT:    ; in Loop: Header=BB1_3 Depth=1
; GCN-NEXT:    s_load_dword s4, s[0:1], 0x0
; GCN-NEXT:    buffer_load_dword v0, off, s[0:3], 0 glc
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    v_cmp_lt_i32_e64 s[0:1], 8, v0
; GCN-NEXT:    s_branch .LBB1_2
; GCN-NEXT:  .LBB1_6: ; %bb31
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    buffer_store_dword v0, off, s[0:3], 0
; GCN-NEXT:    s_waitcnt vmcnt(0)
; GCN-NEXT:    s_endpgm
; IR-LABEL: @nested_loop_conditions(
; IR-NEXT:  bb:
; IR-NEXT:    [[MY_TMP1134:%.*]] = load volatile i32, ptr addrspace(1) undef, align 4
; IR-NEXT:    [[MY_TMP1235:%.*]] = icmp slt i32 [[MY_TMP1134]], 9
; IR-NEXT:    br i1 [[MY_TMP1235]], label [[BB14_LR_PH:%.*]], label [[FLOW:%.*]]
; IR:       bb14.lr.ph:
; IR-NEXT:    [[MY_TMP:%.*]] = tail call i32 @llvm.amdgcn.workitem.id.x() #[[ATTR4]]
; IR-NEXT:    [[MY_TMP1:%.*]] = zext i32 [[MY_TMP]] to i64
; IR-NEXT:    [[MY_TMP2:%.*]] = getelementptr inbounds i64, ptr addrspace(1) [[ARG:%.*]], i64 [[MY_TMP1]]
; IR-NEXT:    [[MY_TMP3:%.*]] = load i64, ptr addrspace(1) [[MY_TMP2]], align 16
; IR-NEXT:    [[MY_TMP932:%.*]] = load <4 x i32>, ptr addrspace(1) undef, align 16
; IR-NEXT:    [[MY_TMP1033:%.*]] = extractelement <4 x i32> [[MY_TMP932]], i64 0
; IR-NEXT:    br label [[BB14:%.*]]
; IR:       Flow3:
; IR-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP20:%.*]])
; IR-NEXT:    [[TMP0:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP14:%.*]])
; IR-NEXT:    [[TMP1:%.*]] = extractvalue { i1, i64 } [[TMP0]], 0
; IR-NEXT:    [[TMP2:%.*]] = extractvalue { i1, i64 } [[TMP0]], 1
; IR-NEXT:    br i1 [[TMP1]], label [[BB4_BB13_CRIT_EDGE:%.*]], label [[FLOW4:%.*]]
; IR:       bb4.bb13_crit_edge:
; IR-NEXT:    br label [[FLOW4]]
; IR:       Flow4:
; IR-NEXT:    [[TMP3:%.*]] = phi i1 [ true, [[BB4_BB13_CRIT_EDGE]] ], [ false, [[FLOW3:%.*]] ]
; IR-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP2]])
; IR-NEXT:    br label [[FLOW]]
; IR:       bb13:
; IR-NEXT:    br label [[BB31:%.*]]
; IR:       Flow:
; IR-NEXT:    [[TMP4:%.*]] = phi i1 [ [[TMP3]], [[FLOW4]] ], [ true, [[BB:%.*]] ]
; IR-NEXT:    [[TMP5:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP4]])
; IR-NEXT:    [[TMP6:%.*]] = extractvalue { i1, i64 } [[TMP5]], 0
; IR-NEXT:    [[TMP7:%.*]] = extractvalue { i1, i64 } [[TMP5]], 1
; IR-NEXT:    br i1 [[TMP6]], label [[BB13:%.*]], label [[BB31]]
; IR:       bb14:
; IR-NEXT:    [[PHI_BROKEN:%.*]] = phi i64 [ [[TMP16:%.*]], [[FLOW1:%.*]] ], [ 0, [[BB14_LR_PH]] ]
; IR-NEXT:    [[MY_TMP1037:%.*]] = phi i32 [ [[MY_TMP1033]], [[BB14_LR_PH]] ], [ [[TMP12:%.*]], [[FLOW1]] ]
; IR-NEXT:    [[MY_TMP936:%.*]] = phi <4 x i32> [ [[MY_TMP932]], [[BB14_LR_PH]] ], [ [[TMP11:%.*]], [[FLOW1]] ]
; IR-NEXT:    [[MY_TMP15:%.*]] = icmp eq i32 [[MY_TMP1037]], 1
; IR-NEXT:    [[TMP8:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[MY_TMP15]])
; IR-NEXT:    [[TMP9:%.*]] = extractvalue { i1, i64 } [[TMP8]], 0
; IR-NEXT:    [[TMP10:%.*]] = extractvalue { i1, i64 } [[TMP8]], 1
; IR-NEXT:    br i1 [[TMP9]], label [[BB16:%.*]], label [[FLOW1]]
; IR:       bb16:
; IR-NEXT:    [[MY_TMP17:%.*]] = bitcast i64 [[MY_TMP3]] to <2 x i32>
; IR-NEXT:    br label [[BB18:%.*]]
; IR:       Flow1:
; IR-NEXT:    [[TMP11]] = phi <4 x i32> [ [[MY_TMP9:%.*]], [[BB21:%.*]] ], [ undef, [[BB14]] ]
; IR-NEXT:    [[TMP12]] = phi i32 [ [[MY_TMP10:%.*]], [[BB21]] ], [ undef, [[BB14]] ]
; IR-NEXT:    [[TMP13:%.*]] = phi i1 [ [[MY_TMP12:%.*]], [[BB21]] ], [ true, [[BB14]] ]
; IR-NEXT:    [[TMP14]] = phi i1 [ [[MY_TMP12]], [[BB21]] ], [ false, [[BB14]] ]
; IR-NEXT:    [[TMP15:%.*]] = phi i1 [ false, [[BB21]] ], [ true, [[BB14]] ]
; IR-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP10]])
; IR-NEXT:    [[TMP16]] = call i64 @llvm.amdgcn.if.break.i64(i1 [[TMP13]], i64 [[PHI_BROKEN]])
; IR-NEXT:    [[TMP17:%.*]] = call i1 @llvm.amdgcn.loop.i64(i64 [[TMP16]])
; IR-NEXT:    br i1 [[TMP17]], label [[FLOW2:%.*]], label [[BB14]]
; IR:       bb18:
; IR-NEXT:    [[MY_TMP19:%.*]] = load volatile i32, ptr addrspace(1) undef, align 4
; IR-NEXT:    [[MY_TMP20:%.*]] = icmp slt i32 [[MY_TMP19]], 9
; IR-NEXT:    br i1 [[MY_TMP20]], label [[BB21]], label [[BB18]]
; IR:       bb21:
; IR-NEXT:    [[MY_TMP22:%.*]] = extractelement <2 x i32> [[MY_TMP17]], i64 1
; IR-NEXT:    [[MY_TMP23:%.*]] = lshr i32 [[MY_TMP22]], 16
; IR-NEXT:    [[MY_TMP24:%.*]] = select i1 undef, i32 undef, i32 [[MY_TMP23]]
; IR-NEXT:    [[MY_TMP25:%.*]] = uitofp i32 [[MY_TMP24]] to float
; IR-NEXT:    [[MY_TMP26:%.*]] = fmul float [[MY_TMP25]], 0x3EF0001000000000
; IR-NEXT:    [[MY_TMP27:%.*]] = fsub float [[MY_TMP26]], undef
; IR-NEXT:    [[MY_TMP28:%.*]] = fcmp olt float [[MY_TMP27]], 5.000000e-01
; IR-NEXT:    [[MY_TMP29:%.*]] = select i1 [[MY_TMP28]], i64 1, i64 2
; IR-NEXT:    [[MY_TMP30:%.*]] = extractelement <4 x i32> [[MY_TMP936]], i64 [[MY_TMP29]]
; IR-NEXT:    [[MY_TMP7:%.*]] = zext i32 [[MY_TMP30]] to i64
; IR-NEXT:    [[MY_TMP8:%.*]] = getelementptr inbounds <4 x i32>, ptr addrspace(1) undef, i64 [[MY_TMP7]]
; IR-NEXT:    [[MY_TMP9]] = load <4 x i32>, ptr addrspace(1) [[MY_TMP8]], align 16
; IR-NEXT:    [[MY_TMP10]] = extractelement <4 x i32> [[MY_TMP9]], i64 0
; IR-NEXT:    [[MY_TMP11:%.*]] = load volatile i32, ptr addrspace(1) undef, align 4
; IR-NEXT:    [[MY_TMP12]] = icmp sge i32 [[MY_TMP11]], 9
; IR-NEXT:    br label [[FLOW1]]
; IR:       Flow2:
; IR-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP16]])
; IR-NEXT:    [[TMP18:%.*]] = call { i1, i64 } @llvm.amdgcn.if.i64(i1 [[TMP15]])
; IR-NEXT:    [[TMP19:%.*]] = extractvalue { i1, i64 } [[TMP18]], 0
; IR-NEXT:    [[TMP20]] = extractvalue { i1, i64 } [[TMP18]], 1
; IR-NEXT:    br i1 [[TMP19]], label [[BB31_LOOPEXIT:%.*]], label [[FLOW3]]
; IR:       bb31.loopexit:
; IR-NEXT:    br label [[FLOW3]]
; IR:       bb31:
; IR-NEXT:    call void @llvm.amdgcn.end.cf.i64(i64 [[TMP7]])
; IR-NEXT:    store volatile i32 0, ptr addrspace(1) undef, align 4
; IR-NEXT:    ret void
bb:
  %my.tmp1134 = load volatile i32, ptr addrspace(1) undef
  %my.tmp1235 = icmp slt i32 %my.tmp1134, 9
  br i1 %my.tmp1235, label %bb14.lr.ph, label %bb13

bb14.lr.ph:                                       ; preds = %bb
  %my.tmp = tail call i32 @llvm.amdgcn.workitem.id.x() #1
  %my.tmp1 = zext i32 %my.tmp to i64
  %my.tmp2 = getelementptr inbounds i64, ptr addrspace(1) %arg, i64 %my.tmp1
  %my.tmp3 = load i64, ptr addrspace(1) %my.tmp2, align 16
  %my.tmp932 = load <4 x i32>, ptr addrspace(1) undef, align 16
  %my.tmp1033 = extractelement <4 x i32> %my.tmp932, i64 0
  br label %bb14

bb4.bb13_crit_edge:                               ; preds = %bb21
  br label %bb13

bb13:                                             ; preds = %bb4.bb13_crit_edge, %bb
  br label %bb31

bb14:                                             ; preds = %bb21, %bb14.lr.ph
  %my.tmp1037 = phi i32 [ %my.tmp1033, %bb14.lr.ph ], [ %my.tmp10, %bb21 ]
  %my.tmp936 = phi <4 x i32> [ %my.tmp932, %bb14.lr.ph ], [ %my.tmp9, %bb21 ]
  %my.tmp15 = icmp eq i32 %my.tmp1037, 1
  br i1 %my.tmp15, label %bb16, label %bb31.loopexit

bb16:                                             ; preds = %bb14
  %my.tmp17 = bitcast i64 %my.tmp3 to <2 x i32>
  br label %bb18

bb18:                                             ; preds = %bb18, %bb16
  %my.tmp19 = load volatile i32, ptr addrspace(1) undef
  %my.tmp20 = icmp slt i32 %my.tmp19, 9
  br i1 %my.tmp20, label %bb21, label %bb18

bb21:                                             ; preds = %bb18
  %my.tmp22 = extractelement <2 x i32> %my.tmp17, i64 1
  %my.tmp23 = lshr i32 %my.tmp22, 16
  %my.tmp24 = select i1 undef, i32 undef, i32 %my.tmp23
  %my.tmp25 = uitofp i32 %my.tmp24 to float
  %my.tmp26 = fmul float %my.tmp25, 0x3EF0001000000000
  %my.tmp27 = fsub float %my.tmp26, undef
  %my.tmp28 = fcmp olt float %my.tmp27, 5.000000e-01
  %my.tmp29 = select i1 %my.tmp28, i64 1, i64 2
  %my.tmp30 = extractelement <4 x i32> %my.tmp936, i64 %my.tmp29
  %my.tmp7 = zext i32 %my.tmp30 to i64
  %my.tmp8 = getelementptr inbounds <4 x i32>, ptr addrspace(1) undef, i64 %my.tmp7
  %my.tmp9 = load <4 x i32>, ptr addrspace(1) %my.tmp8, align 16
  %my.tmp10 = extractelement <4 x i32> %my.tmp9, i64 0
  %my.tmp11 = load volatile i32, ptr addrspace(1) undef
  %my.tmp12 = icmp slt i32 %my.tmp11, 9
  br i1 %my.tmp12, label %bb14, label %bb4.bb13_crit_edge

bb31.loopexit:                                    ; preds = %bb14
  br label %bb31

bb31:                                             ; preds = %bb31.loopexit, %bb13
  store volatile i32 0, ptr addrspace(1) undef
  ret void
}

declare i32 @llvm.amdgcn.workitem.id.x() #1

attributes #0 = { nounwind }
attributes #1 = { nounwind readnone }
