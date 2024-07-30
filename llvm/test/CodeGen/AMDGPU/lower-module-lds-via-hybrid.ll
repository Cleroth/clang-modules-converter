; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -mtriple=amdgcn--amdhsa -passes=amdgpu-lower-module-lds < %s --amdgpu-lower-module-lds-strategy=hybrid | FileCheck -check-prefix=OPT %s
; RUN: llc -mtriple=amdgcn--amdhsa -verify-machineinstrs < %s --amdgpu-lower-module-lds-strategy=hybrid | FileCheck -check-prefix=GCN %s

; Opt checks from utils/update_test_checks.py, llc checks from utils/update_llc_test_checks.py

; Define four variables and four non-kernel functions which access exactly one variable each
@v0 = addrspace(3) global float poison
@v1 = addrspace(3) global i16 poison, align 16
@v2 = addrspace(3) global i64 poison
@v3 = addrspace(3) global i8 poison
@unused = addrspace(3) global i16 poison

; OPT{LITERAL}: @llvm.amdgcn.lds.offset.table = internal addrspace(4) constant [2 x [1 x i32]] [[1 x i32] [i32 ptrtoint (ptr addrspace(3) @llvm.amdgcn.kernel.k123.lds to i32)], [1 x i32] [i32 ptrtoint (ptr addrspace(3) @llvm.amdgcn.kernel.k23.lds to i32)]]

define void @f0() {
; OPT-LABEL: @f0(
; OPT-NEXT:    [[LD:%.*]] = load float, ptr addrspace(3) @llvm.amdgcn.kernel.k01.lds, align 4
; OPT-NEXT:    [[MUL:%.*]] = fmul float [[LD]], 2.000000e+00
; OPT-NEXT:    store float [[MUL]], ptr addrspace(3) @llvm.amdgcn.kernel.k01.lds, align 4
; OPT-NEXT:    ret void
;
; GCN-LABEL: f0:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_mov_b32 m0, -1
; GCN-NEXT:    ds_read_b32 v1, v0 offset:4
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_add_f32_e32 v1, v1, v1
; GCN-NEXT:    ds_write_b32 v0, v1 offset:4
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %ld = load float, ptr addrspace(3) @v0
  %mul = fmul float %ld, 2.
  store float %mul, ptr  addrspace(3) @v0
  ret void
}

define void @f1() {
; OPT-LABEL: @f1(
; OPT-NEXT:    [[LD:%.*]] = load i16, ptr addrspace(3) @llvm.amdgcn.module.lds, align 16
; OPT-NEXT:    [[MUL:%.*]] = mul i16 [[LD]], 3
; OPT-NEXT:    store i16 [[MUL]], ptr addrspace(3) @llvm.amdgcn.module.lds, align 16
; OPT-NEXT:    ret void
;
; GCN-LABEL: f1:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_mov_b32 m0, -1
; GCN-NEXT:    ds_read_u16 v1, v0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mul_lo_u32 v1, v1, 3
; GCN-NEXT:    ds_write_b16 v0, v1
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %ld = load i16, ptr addrspace(3) @v1
  %mul = mul i16 %ld, 3
  store i16 %mul, ptr  addrspace(3) @v1
  ret void
}

define void @f2() {
; OPT-LABEL: @f2(
; OPT-NEXT:    [[TMP1:%.*]] = call i32 @llvm.amdgcn.lds.kernel.id()
; OPT-NEXT:    [[V22:%.*]] = getelementptr inbounds [2 x [1 x i32]], ptr addrspace(4) @llvm.amdgcn.lds.offset.table, i32 0, i32 [[TMP1]], i32 0
; OPT-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspace(4) [[V22]], align 4
; OPT-NEXT:    [[V23:%.*]] = inttoptr i32 [[TMP2]] to ptr addrspace(3)
; OPT-NEXT:    [[LD:%.*]] = load i64, ptr addrspace(3) [[V23]], align 8
; OPT-NEXT:    [[MUL:%.*]] = mul i64 [[LD]], 4
; OPT-NEXT:    [[V2:%.*]] = getelementptr inbounds [2 x [1 x i32]], ptr addrspace(4) @llvm.amdgcn.lds.offset.table, i32 0, i32 [[TMP1]], i32 0
; OPT-NEXT:    [[TMP3:%.*]] = load i32, ptr addrspace(4) [[V2]], align 4
; OPT-NEXT:    [[V21:%.*]] = inttoptr i32 [[TMP3]] to ptr addrspace(3)
; OPT-NEXT:    store i64 [[MUL]], ptr addrspace(3) [[V21]], align 8
; OPT-NEXT:    ret void
;
; GCN-LABEL: f2:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    s_mov_b32 s4, s15
; GCN-NEXT:    s_ashr_i32 s5, s15, 31
; GCN-NEXT:    s_getpc_b64 s[6:7]
; GCN-NEXT:    s_add_u32 s6, s6, llvm.amdgcn.lds.offset.table@rel32@lo+4
; GCN-NEXT:    s_addc_u32 s7, s7, llvm.amdgcn.lds.offset.table@rel32@hi+12
; GCN-NEXT:    s_lshl_b64 s[4:5], s[4:5], 2
; GCN-NEXT:    s_add_u32 s4, s4, s6
; GCN-NEXT:    s_addc_u32 s5, s5, s7
; GCN-NEXT:    s_load_dword s4, s[4:5], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v2, s4
; GCN-NEXT:    s_mov_b32 m0, -1
; GCN-NEXT:    ds_read_b64 v[0:1], v2
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_lshl_b64 v[0:1], v[0:1], 2
; GCN-NEXT:    ds_write_b64 v2, v[0:1]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %ld = load i64, ptr addrspace(3) @v2
  %mul = mul i64 %ld, 4
  store i64 %mul, ptr  addrspace(3) @v2
  ret void
}

define void @f3() {
; OPT-LABEL: @f3(
; OPT-NEXT:    [[LD:%.*]] = load i8, ptr addrspace(3) getelementptr inbounds ([[LLVM_AMDGCN_KERNEL_K23_LDS_T:%.*]], ptr addrspace(3) @llvm.amdgcn.kernel.k23.lds, i32 0, i32 1), align 8
; OPT-NEXT:    [[MUL:%.*]] = mul i8 [[LD]], 5
; OPT-NEXT:    store i8 [[MUL]], ptr addrspace(3) getelementptr inbounds ([[LLVM_AMDGCN_KERNEL_K23_LDS_T]], ptr addrspace(3) @llvm.amdgcn.kernel.k23.lds, i32 0, i32 1), align 8
; OPT-NEXT:    ret void
;
; GCN-LABEL: f3:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_waitcnt vmcnt(0) expcnt(0) lgkmcnt(0)
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_mov_b32 m0, -1
; GCN-NEXT:    ds_read_u8 v1, v0 offset:8
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_mul_lo_u32 v1, v1, 5
; GCN-NEXT:    ds_write_b8 v0, v1 offset:8
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_setpc_b64 s[30:31]
  %ld = load i8, ptr addrspace(3) @v3
  %mul = mul i8 %ld, 5
  store i8 %mul, ptr  addrspace(3) @v3
  ret void
}

; Doesn't access any via a function, won't be in the lookup table
define amdgpu_kernel void @kernel_no_table() {
; OPT-LABEL: @kernel_no_table(
; OPT-NEXT:    [[LD:%.*]] = load i64, ptr addrspace(3) @llvm.amdgcn.kernel.kernel_no_table.lds, align 8
; OPT-NEXT:    [[MUL:%.*]] = mul i64 [[LD]], 8
; OPT-NEXT:    store i64 [[MUL]], ptr addrspace(3) @llvm.amdgcn.kernel.kernel_no_table.lds, align 8
; OPT-NEXT:    ret void
;
; GCN-LABEL: kernel_no_table:
; GCN:       ; %bb.0:
; GCN-NEXT:    v_mov_b32_e32 v2, 0
; GCN-NEXT:    s_mov_b32 m0, -1
; GCN-NEXT:    ds_read_b64 v[0:1], v2
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_lshl_b64 v[0:1], v[0:1], 3
; GCN-NEXT:    ds_write_b64 v2, v[0:1]
; GCN-NEXT:    s_endpgm
  %ld = load i64, ptr addrspace(3) @v2
  %mul = mul i64 %ld, 8
  store i64 %mul, ptr  addrspace(3) @v2
  ret void
}

; Access two variables, will allocate those two
define amdgpu_kernel void @k01() {
; OPT-LABEL: @k01(
; OPT-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.kernel.k01.lds) ]
; OPT-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.module.lds) ]
; OPT-NEXT:    call void @f0()
; OPT-NEXT:    call void @f1()
; OPT-NEXT:    ret void
;
; GCN-LABEL: k01:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_mov_b32 s32, 0
; GCN-NEXT:    s_mov_b32 flat_scratch_lo, s11
; GCN-NEXT:    s_add_i32 s10, s10, s15
; GCN-NEXT:    s_lshr_b32 flat_scratch_hi, s10, 8
; GCN-NEXT:    s_add_u32 s0, s0, s15
; GCN-NEXT:    s_addc_u32 s1, s1, 0
; GCN-NEXT:    s_mov_b64 s[10:11], s[8:9]
; GCN-NEXT:    s_mov_b64 s[8:9], s[6:7]
; GCN-NEXT:    s_getpc_b64 s[6:7]
; GCN-NEXT:    s_add_u32 s6, s6, f0@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s7, s7, f0@gotpcrel32@hi+12
; GCN-NEXT:    s_load_dwordx2 s[6:7], s[6:7], 0x0
; GCN-NEXT:    v_lshlrev_b32_e32 v2, 20, v2
; GCN-NEXT:    v_lshlrev_b32_e32 v1, 10, v1
; GCN-NEXT:    v_or_b32_e32 v0, v0, v1
; GCN-NEXT:    v_or_b32_e32 v31, v0, v2
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GCN-NEXT:    s_getpc_b64 s[6:7]
; GCN-NEXT:    s_add_u32 s6, s6, f1@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s7, s7, f1@gotpcrel32@hi+12
; GCN-NEXT:    s_load_dwordx2 s[6:7], s[6:7], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GCN-NEXT:    s_endpgm
  call void @f0()
  call void @f1()
  ret void
}

define amdgpu_kernel void @k23() {
; OPT-LABEL: @k23(
; OPT-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.kernel.k23.lds) ], !alias.scope [[META5:![0-9]+]], !noalias [[META8:![0-9]+]]
; OPT-NEXT:    call void @f2()
; OPT-NEXT:    call void @f3()
; OPT-NEXT:    ret void
;
; GCN-LABEL: k23:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_mov_b32 s32, 0
; GCN-NEXT:    s_mov_b32 flat_scratch_lo, s11
; GCN-NEXT:    s_add_i32 s10, s10, s15
; GCN-NEXT:    s_lshr_b32 flat_scratch_hi, s10, 8
; GCN-NEXT:    s_add_u32 s0, s0, s15
; GCN-NEXT:    s_addc_u32 s1, s1, 0
; GCN-NEXT:    s_mov_b64 s[10:11], s[8:9]
; GCN-NEXT:    s_mov_b64 s[8:9], s[6:7]
; GCN-NEXT:    s_mov_b64 s[16:17], s[4:5]
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:    s_add_u32 s4, s4, f2@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s5, s5, f2@gotpcrel32@hi+12
; GCN-NEXT:    v_lshlrev_b32_e32 v2, 20, v2
; GCN-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x0
; GCN-NEXT:    v_lshlrev_b32_e32 v1, 10, v1
; GCN-NEXT:    v_or_b32_e32 v0, v0, v1
; GCN-NEXT:    v_or_b32_e32 v31, v0, v2
; GCN-NEXT:    s_mov_b32 s15, 1
; GCN-NEXT:    s_mov_b64 s[4:5], s[16:17]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GCN-NEXT:    s_getpc_b64 s[4:5]
; GCN-NEXT:    s_add_u32 s4, s4, f3@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s5, s5, f3@gotpcrel32@hi+12
; GCN-NEXT:    s_load_dwordx2 s[6:7], s[4:5], 0x0
; GCN-NEXT:    s_mov_b64 s[4:5], s[16:17]
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GCN-NEXT:    s_endpgm


  call void @f2()
  call void @f3()
  ret void
}

; Access and allocate three variables
define amdgpu_kernel void @k123() {
; OPT-LABEL: @k123(
; OPT-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.kernel.k123.lds) ], !alias.scope [[META11:![0-9]+]], !noalias [[META14:![0-9]+]]
; OPT-NEXT:    call void @llvm.donothing() [ "ExplicitUse"(ptr addrspace(3) @llvm.amdgcn.module.lds) ]
; OPT-NEXT:    call void @f1()
; OPT-NEXT:    [[LD:%.*]] = load i8, ptr addrspace(3) getelementptr inbounds ([[LLVM_AMDGCN_KERNEL_K123_LDS_T:%.*]], ptr addrspace(3) @llvm.amdgcn.kernel.k123.lds, i32 0, i32 1), align 8, !alias.scope [[META14]], !noalias [[META11]]
; OPT-NEXT:    [[MUL:%.*]] = mul i8 [[LD]], 8
; OPT-NEXT:    store i8 [[MUL]], ptr addrspace(3) getelementptr inbounds ([[LLVM_AMDGCN_KERNEL_K123_LDS_T]], ptr addrspace(3) @llvm.amdgcn.kernel.k123.lds, i32 0, i32 1), align 8, !alias.scope [[META14]], !noalias [[META11]]
; OPT-NEXT:    call void @f2()
; OPT-NEXT:    ret void
;
; GCN-LABEL: k123:
; GCN:       ; %bb.0:
; GCN-NEXT:    s_mov_b32 s32, 0
; GCN-NEXT:    s_mov_b32 flat_scratch_lo, s11
; GCN-NEXT:    s_add_i32 s10, s10, s15
; GCN-NEXT:    s_lshr_b32 flat_scratch_hi, s10, 8
; GCN-NEXT:    s_add_u32 s0, s0, s15
; GCN-NEXT:    s_addc_u32 s1, s1, 0
; GCN-NEXT:    s_mov_b64 s[10:11], s[8:9]
; GCN-NEXT:    s_mov_b64 s[8:9], s[6:7]
; GCN-NEXT:    s_getpc_b64 s[6:7]
; GCN-NEXT:    s_add_u32 s6, s6, f1@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s7, s7, f1@gotpcrel32@hi+12
; GCN-NEXT:    v_lshlrev_b32_e32 v2, 20, v2
; GCN-NEXT:    s_load_dwordx2 s[6:7], s[6:7], 0x0
; GCN-NEXT:    v_lshlrev_b32_e32 v1, 10, v1
; GCN-NEXT:    v_or_b32_e32 v0, v0, v1
; GCN-NEXT:    v_or_b32_e32 v31, v0, v2
; GCN-NEXT:    s_mov_b32 s15, 0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GCN-NEXT:    v_mov_b32_e32 v0, 0
; GCN-NEXT:    s_mov_b32 m0, -1
; GCN-NEXT:    ds_read_u8 v1, v0 offset:16
; GCN-NEXT:    s_getpc_b64 s[6:7]
; GCN-NEXT:    s_add_u32 s6, s6, f2@gotpcrel32@lo+4
; GCN-NEXT:    s_addc_u32 s7, s7, f2@gotpcrel32@hi+12
; GCN-NEXT:    s_load_dwordx2 s[6:7], s[6:7], 0x0
; GCN-NEXT:    s_waitcnt lgkmcnt(0)
; GCN-NEXT:    v_lshlrev_b32_e32 v1, 3, v1
; GCN-NEXT:    ds_write_b8 v0, v1 offset:16
; GCN-NEXT:    s_swappc_b64 s[30:31], s[6:7]
; GCN-NEXT:    s_endpgm
  call void @f1()
  %ld = load i8, ptr addrspace(3) @v3
  %mul = mul i8 %ld, 8
  store i8 %mul, ptr  addrspace(3) @v3
  call void @f2()
  ret void
}

!0 = !{i32 0}
!1 = !{i32 2}
!2 = !{i32 1}

; OPT: attributes #0 = { "amdgpu-lds-size"="8" }
; OPT: attributes #1 = { "amdgpu-lds-size"="16" }
; OPT: attributes #2 = { "amdgpu-lds-size"="24" }
; OPT: attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }
; OPT: attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

; OPT: !0 = !{i32 0, i32 1}
; OPT: !1 = !{i32 4, i32 5}
; OPT: !2 = !{i32 8, i32 9}
; OPT: !3 = !{i32 1, !"amdhsa_code_object_version", i32 500}
; OPT: !4 = !{i32 1}
; OPT: !5 = !{!6}
; OPT: !6 = distinct !{!6, !7}
; OPT: !7 = distinct !{!7}
; OPT: !8 = !{!9}
; OPT: !9 = distinct !{!9, !7}
; OPT: !10 = !{i32 0}
; OPT: !11 = !{!12}
; OPT: !12 = distinct !{!12, !13}
; OPT: !13 = distinct !{!13}
; OPT: !14 = !{!15}
; OPT: !15 = distinct !{!15, !13}

attributes #0 = { "amdgpu-lds-size"="8" }
attributes #1 = { "amdgpu-lds-size"="16" }
attributes #2 = { "amdgpu-lds-size"="24" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

; Table size length number-kernels * number-variables * sizeof(uint16_t)
; GCN:      .type	llvm.amdgcn.lds.offset.table,@object
; GCN-NEXT: .section	.data.rel.ro,"aw"
; GCN-NEXT: .p2align	2, 0x0
; GCN-NEXT: llvm.amdgcn.lds.offset.table:
; GCN-NEXT: .long	8
; GCN-NEXT: .long	0
; GCN-NEXT: .size	llvm.amdgcn.lds.offset.table, 8

!llvm.module.flags = !{!3}
!3 = !{i32 1, !"amdhsa_code_object_version", i32 500}
