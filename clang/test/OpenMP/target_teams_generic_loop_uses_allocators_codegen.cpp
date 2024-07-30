// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --function-signature --include-generated-funcs --replace-value-regex "__omp_offloading_[0-9a-z]+_[0-9a-z]+" "reduction_size[.].+[.]" "pl_cond[.].+[.|,]" --prefix-filecheck-ir-name _
// Test host codegen.
// RUN: %clang_cc1 -verify -fopenmp -fopenmp-version=50 -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-llvm %s -o - | FileCheck %s --check-prefix CHECK
// RUN: %clang_cc1 -fopenmp -fopenmp-version=50 -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -emit-pch -o %t %s
// RUN: %clang_cc1 -fopenmp -fopenmp-version=50 -x c++ -triple powerpc64le-unknown-unknown -fopenmp-targets=powerpc64le-ibm-linux-gnu -include-pch %t -verify %s -emit-llvm -o - | FileCheck %s --check-prefix CHECK

// expected-no-diagnostics
#ifndef HEADER
#define HEADER

enum omp_allocator_handle_t {
  omp_null_allocator = 0,
  omp_default_mem_alloc = 1,
  omp_large_cap_mem_alloc = 2,
  omp_const_mem_alloc = 3,
  omp_high_bw_mem_alloc = 4,
  omp_low_lat_mem_alloc = 5,
  omp_cgroup_mem_alloc = 6,
  omp_pteam_mem_alloc = 7,
  omp_thread_mem_alloc = 8,
  KMP_ALLOCATOR_MAX_HANDLE = __UINTPTR_MAX__
};

typedef enum omp_alloctrait_key_t { omp_atk_sync_hint = 1,
                                    omp_atk_alignment = 2,
                                    omp_atk_access = 3,
                                    omp_atk_pool_size = 4,
                                    omp_atk_fallback = 5,
                                    omp_atk_fb_data = 6,
                                    omp_atk_pinned = 7,
                                    omp_atk_partition = 8
} omp_alloctrait_key_t;
typedef enum omp_alloctrait_value_t {
  omp_atv_false = 0,
  omp_atv_true = 1,
  omp_atv_default = 2,
  omp_atv_contended = 3,
  omp_atv_uncontended = 4,
  omp_atv_sequential = 5,
  omp_atv_private = 6,
  omp_atv_all = 7,
  omp_atv_thread = 8,
  omp_atv_pteam = 9,
  omp_atv_cgroup = 10,
  omp_atv_default_mem_fb = 11,
  omp_atv_null_fb = 12,
  omp_atv_abort_fb = 13,
  omp_atv_allocator_fb = 14,
  omp_atv_environment = 15,
  omp_atv_nearest = 16,
  omp_atv_blocked = 17,
  omp_atv_interleaved = 18
} omp_alloctrait_value_t;

typedef struct omp_alloctrait_t {
  omp_alloctrait_key_t key;
  __UINTPTR_TYPE__ value;
} omp_alloctrait_t;

// Just map the traits variable as a firstprivate variable.

void foo() {
  omp_alloctrait_t traits[10];
  omp_allocator_handle_t my_allocator;

#pragma omp target teams loop uses_allocators(omp_null_allocator, omp_thread_mem_alloc, my_allocator(traits))
  for (int i = 0; i < 10; ++i)
    ;
}


// Destroy allocator upon exit from the region.

#endif
// CHECK-64-LABEL: define {{[^@]+}}@_Z3foov
// CHECK-64-SAME: () #[[ATTR0:[0-9]+]] {
// CHECK-64-NEXT:  entry:
// CHECK-64-NEXT:    [[TRAITS:%.*]] = alloca [10 x %struct.omp_alloctrait_t], align 8
// CHECK-64-NEXT:    [[MY_ALLOCATOR:%.*]] = alloca i64, align 8
// CHECK-64-NEXT:    [[DOTOFFLOAD_BASEPTRS:%.*]] = alloca [1 x ptr], align 8
// CHECK-64-NEXT:    [[DOTOFFLOAD_PTRS:%.*]] = alloca [1 x ptr], align 8
// CHECK-64-NEXT:    [[DOTOFFLOAD_MAPPERS:%.*]] = alloca [1 x ptr], align 8
// CHECK-64-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 0
// CHECK-64-NEXT:    store ptr [[TRAITS]], ptr [[TMP0]], align 8
// CHECK-64-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 0
// CHECK-64-NEXT:    store ptr [[TRAITS]], ptr [[TMP1]], align 8
// CHECK-64-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_MAPPERS]], i64 0, i64 0
// CHECK-64-NEXT:    store ptr null, ptr [[TMP2]], align 8
// CHECK-64-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 0
// CHECK-64-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 0
// CHECK-64-NEXT:    [[KERNEL_ARGS:%.*]] = alloca [[STRUCT___TGT_KERNEL_ARGUMENTS:%.*]], align 8
// CHECK-64-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 0
// CHECK-64-NEXT:    store i32 2, ptr [[TMP5]], align 4
// CHECK-64-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 1
// CHECK-64-NEXT:    store i32 1, ptr [[TMP6]], align 4
// CHECK-64-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 2
// CHECK-64-NEXT:    store ptr [[TMP3]], ptr [[TMP7]], align 8
// CHECK-64-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 3
// CHECK-64-NEXT:    store ptr [[TMP4]], ptr [[TMP8]], align 8
// CHECK-64-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 4
// CHECK-64-NEXT:    store ptr @.offload_sizes, ptr [[TMP9]], align 8
// CHECK-64-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 5
// CHECK-64-NEXT:    store ptr @.offload_maptypes, ptr [[TMP10]], align 8
// CHECK-64-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 6
// CHECK-64-NEXT:    store ptr null, ptr [[TMP11]], align 8
// CHECK-64-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 7
// CHECK-64-NEXT:    store ptr null, ptr [[TMP12]], align 8
// CHECK-64-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 8
// CHECK-64-NEXT:    store i64 10, ptr [[TMP13]], align 8
// CHECK-64-NEXT:    [[TMP14:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 9
// CHECK-64-NEXT:    store i64 0, ptr [[TMP14]], align 8
// CHECK-64-NEXT:    [[TMP15:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 10
// CHECK-64-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP15]], align 4
// CHECK-64-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 11
// CHECK-64-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP16]], align 4
// CHECK-64-NEXT:    [[TMP17:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 12
// CHECK-64-NEXT:    store i32 0, ptr [[TMP17]], align 4
// CHECK-64-NEXT:    [[TMP18:%.*]] = call i32 @__tgt_target_kernel(ptr @[[GLOB1:[0-9]+]], i64 -1, i32 0, i32 0, ptr @.{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l73.region_id, ptr [[KERNEL_ARGS]])
// CHECK-64-NEXT:    [[TMP19:%.*]] = icmp ne i32 [[TMP18]], 0
// CHECK-64-NEXT:    br i1 [[TMP19]], label [[OMP_OFFLOAD_FAILED:%.*]], label [[OMP_OFFLOAD_CONT:%.*]]
// CHECK-64:       omp_offload.failed:
// CHECK-64-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l73(ptr [[TRAITS]]) #[[ATTR2:[0-9]+]]
// CHECK-64-NEXT:    br label [[OMP_OFFLOAD_CONT]]
// CHECK-64:       omp_offload.cont:
// CHECK-64-NEXT:    ret void
// CHECK-64-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l73
// CHECK-64-SAME: (ptr noundef nonnull align 8 dereferenceable(160) [[TRAITS:%.*]]) #[[ATTR1:[0-9]+]] {
// CHECK-64-NEXT:  entry:
// CHECK-64-NEXT:    [[TRAITS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-64-NEXT:    [[MY_ALLOCATOR:%.*]] = alloca i64, align 8
// CHECK-64-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-64-NEXT:    store ptr [[TRAITS]], ptr [[TRAITS_ADDR]], align 8
// CHECK-64-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[TRAITS_ADDR]], align 8
// CHECK-64-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[TMP1]], align 8
// CHECK-64-NEXT:    [[TMP3:%.*]] = call ptr @__kmpc_init_allocator(i32 [[TMP0]], ptr null, i32 10, ptr [[TMP2]])
// CHECK-64-NEXT:    [[CONV:%.*]] = ptrtoint ptr [[TMP3]] to i64
// CHECK-64-NEXT:    store i64 [[CONV]], ptr [[MY_ALLOCATOR]], align 8
// CHECK-64-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_teams(ptr @[[GLOB1]], i32 0, ptr @.omp_outlined.)
// CHECK-64-NEXT:    [[TMP4:%.*]] = load i64, ptr [[MY_ALLOCATOR]], align 8
// CHECK-64-NEXT:    [[CONV1:%.*]] = inttoptr i64 [[TMP4]] to ptr
// CHECK-64-NEXT:    call void @__kmpc_destroy_allocator(i32 [[TMP0]], ptr [[CONV1]])
// CHECK-64-NEXT:    ret void
// CHECK-64-LABEL: define {{[^@]+}}@.omp_outlined.
// CHECK-64-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]]) #[[ATTR1]] {
// CHECK-64-NEXT:  entry:
// CHECK-64-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-64-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-64-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[DOTOMP_COMB_LB:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[DOTOMP_COMB_UB:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-64-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK-64-NEXT:    store i32 0, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK-64-NEXT:    store i32 9, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-64-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK-64-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK-64-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-64-NEXT:    [[TMP1:%.*]] = load i32, ptr [[TMP0]], align 4
// CHECK-64-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB2:[0-9]+]], i32 [[TMP1]], i32 92, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_COMB_LB]], ptr [[DOTOMP_COMB_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK-64-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-64-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP2]], 9
// CHECK-64-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK-64:       cond.true:
// CHECK-64-NEXT:    br label [[COND_END:%.*]]
// CHECK-64:       cond.false:
// CHECK-64-NEXT:    [[TMP3:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-64-NEXT:    br label [[COND_END]]
// CHECK-64:       cond.end:
// CHECK-64-NEXT:    [[COND:%.*]] = phi i32 [ 9, [[COND_TRUE]] ], [ [[TMP3]], [[COND_FALSE]] ]
// CHECK-64-NEXT:    store i32 [[COND]], ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-64-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK-64-NEXT:    store i32 [[TMP4]], ptr [[DOTOMP_IV]], align 4
// CHECK-64-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK-64:       omp.inner.for.cond:
// CHECK-64-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-64-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-64-NEXT:    [[CMP1:%.*]] = icmp sle i32 [[TMP5]], [[TMP6]]
// CHECK-64-NEXT:    br i1 [[CMP1]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK-64:       omp.inner.for.body:
// CHECK-64-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK-64-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64
// CHECK-64-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-64-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP9]] to i64
// CHECK-64-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB1]], i32 2, ptr @.omp_outlined..1, i64 [[TMP8]], i64 [[TMP10]])
// CHECK-64-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK-64:       omp.inner.for.inc:
// CHECK-64-NEXT:    [[TMP11:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-64-NEXT:    [[TMP12:%.*]] = load i32, ptr [[DOTOMP_STRIDE]], align 4
// CHECK-64-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP11]], [[TMP12]]
// CHECK-64-NEXT:    store i32 [[ADD]], ptr [[DOTOMP_IV]], align 4
// CHECK-64-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK-64:       omp.inner.for.end:
// CHECK-64-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK-64:       omp.loop.exit:
// CHECK-64-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB3:[0-9]+]], i32 [[TMP1]])
// CHECK-64-NEXT:    ret void
// CHECK-64-LABEL: define {{[^@]+}}@.omp_outlined..1
// CHECK-64-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], i64 noundef [[DOTPREVIOUS_LB_:%.*]], i64 noundef [[DOTPREVIOUS_UB_:%.*]]) #[[ATTR1]] {
// CHECK-64-NEXT:  entry:
// CHECK-64-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-64-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-64-NEXT:    [[DOTPREVIOUS_LB__ADDR:%.*]] = alloca i64, align 8
// CHECK-64-NEXT:    [[DOTPREVIOUS_UB__ADDR:%.*]] = alloca i64, align 8
// CHECK-64-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[DOTOMP_LB:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[DOTOMP_UB:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK-64-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-64-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK-64-NEXT:    store i64 [[DOTPREVIOUS_LB_]], ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK-64-NEXT:    store i64 [[DOTPREVIOUS_UB_]], ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK-64-NEXT:    store i32 0, ptr [[DOTOMP_LB]], align 4
// CHECK-64-NEXT:    store i32 9, ptr [[DOTOMP_UB]], align 4
// CHECK-64-NEXT:    [[TMP0:%.*]] = load i64, ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK-64-NEXT:    [[CONV:%.*]] = trunc i64 [[TMP0]] to i32
// CHECK-64-NEXT:    [[TMP1:%.*]] = load i64, ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK-64-NEXT:    [[CONV1:%.*]] = trunc i64 [[TMP1]] to i32
// CHECK-64-NEXT:    store i32 [[CONV]], ptr [[DOTOMP_LB]], align 4
// CHECK-64-NEXT:    store i32 [[CONV1]], ptr [[DOTOMP_UB]], align 4
// CHECK-64-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK-64-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK-64-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-64-NEXT:    [[TMP3:%.*]] = load i32, ptr [[TMP2]], align 4
// CHECK-64-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB3]], i32 [[TMP3]], i32 34, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_LB]], ptr [[DOTOMP_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK-64-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK-64-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP4]], 9
// CHECK-64-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK-64:       cond.true:
// CHECK-64-NEXT:    br label [[COND_END:%.*]]
// CHECK-64:       cond.false:
// CHECK-64-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK-64-NEXT:    br label [[COND_END]]
// CHECK-64:       cond.end:
// CHECK-64-NEXT:    [[COND:%.*]] = phi i32 [ 9, [[COND_TRUE]] ], [ [[TMP5]], [[COND_FALSE]] ]
// CHECK-64-NEXT:    store i32 [[COND]], ptr [[DOTOMP_UB]], align 4
// CHECK-64-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_LB]], align 4
// CHECK-64-NEXT:    store i32 [[TMP6]], ptr [[DOTOMP_IV]], align 4
// CHECK-64-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK-64:       omp.inner.for.cond:
// CHECK-64-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-64-NEXT:    [[TMP8:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK-64-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[TMP7]], [[TMP8]]
// CHECK-64-NEXT:    br i1 [[CMP2]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK-64:       omp.inner.for.body:
// CHECK-64-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-64-NEXT:    [[MUL:%.*]] = mul nsw i32 [[TMP9]], 1
// CHECK-64-NEXT:    [[ADD:%.*]] = add nsw i32 0, [[MUL]]
// CHECK-64-NEXT:    store i32 [[ADD]], ptr [[I]], align 4
// CHECK-64-NEXT:    br label [[OMP_BODY_CONTINUE:%.*]]
// CHECK-64:       omp.body.continue:
// CHECK-64-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK-64:       omp.inner.for.inc:
// CHECK-64-NEXT:    [[TMP10:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-64-NEXT:    [[ADD3:%.*]] = add nsw i32 [[TMP10]], 1
// CHECK-64-NEXT:    store i32 [[ADD3]], ptr [[DOTOMP_IV]], align 4
// CHECK-64-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK-64:       omp.inner.for.end:
// CHECK-64-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK-64:       omp.loop.exit:
// CHECK-64-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB3]], i32 [[TMP3]])
// CHECK-64-NEXT:    ret void
// CHECK-64-LABEL: define {{[^@]+}}@.omp_offloading.requires_reg
// CHECK-64-SAME: () #[[ATTR3:[0-9]+]] {
// CHECK-64-NEXT:  entry:
// CHECK-64-NEXT:    call void @__tgt_register_requires(i64 1)
// CHECK-64-NEXT:    ret void
// CHECK-LABEL: define {{[^@]+}}@_Z3foov
// CHECK-SAME: () #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TRAITS:%.*]] = alloca [10 x %struct.omp_alloctrait_t], align 8
// CHECK-NEXT:    [[MY_ALLOCATOR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[DOTOFFLOAD_BASEPTRS:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_PTRS:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[DOTOFFLOAD_MAPPERS:%.*]] = alloca [1 x ptr], align 8
// CHECK-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[KERNEL_ARGS:%.*]] = alloca [[STRUCT___TGT_KERNEL_ARGUMENTS:%.*]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[TRAITS]], ptr [[TMP0]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 0
// CHECK-NEXT:    store ptr [[TRAITS]], ptr [[TMP1]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_MAPPERS]], i64 0, i64 0
// CHECK-NEXT:    store ptr null, ptr [[TMP2]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_BASEPTRS]], i32 0, i32 0
// CHECK-NEXT:    [[TMP4:%.*]] = getelementptr inbounds [1 x ptr], ptr [[DOTOFFLOAD_PTRS]], i32 0, i32 0
// CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 0
// CHECK-NEXT:    store i32 3, ptr [[TMP5]], align 4
// CHECK-NEXT:    [[TMP6:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 1
// CHECK-NEXT:    store i32 1, ptr [[TMP6]], align 4
// CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 2
// CHECK-NEXT:    store ptr [[TMP3]], ptr [[TMP7]], align 8
// CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 3
// CHECK-NEXT:    store ptr [[TMP4]], ptr [[TMP8]], align 8
// CHECK-NEXT:    [[TMP9:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 4
// CHECK-NEXT:    store ptr @.offload_sizes, ptr [[TMP9]], align 8
// CHECK-NEXT:    [[TMP10:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 5
// CHECK-NEXT:    store ptr @.offload_maptypes, ptr [[TMP10]], align 8
// CHECK-NEXT:    [[TMP11:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 6
// CHECK-NEXT:    store ptr null, ptr [[TMP11]], align 8
// CHECK-NEXT:    [[TMP12:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 7
// CHECK-NEXT:    store ptr null, ptr [[TMP12]], align 8
// CHECK-NEXT:    [[TMP13:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 8
// CHECK-NEXT:    store i64 10, ptr [[TMP13]], align 8
// CHECK-NEXT:    [[TMP14:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 9
// CHECK-NEXT:    store i64 0, ptr [[TMP14]], align 8
// CHECK-NEXT:    [[TMP15:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 10
// CHECK-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP15]], align 4
// CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 11
// CHECK-NEXT:    store [3 x i32] zeroinitializer, ptr [[TMP16]], align 4
// CHECK-NEXT:    [[TMP17:%.*]] = getelementptr inbounds [[STRUCT___TGT_KERNEL_ARGUMENTS]], ptr [[KERNEL_ARGS]], i32 0, i32 12
// CHECK-NEXT:    store i32 0, ptr [[TMP17]], align 4
// CHECK-NEXT:    [[TMP18:%.*]] = call i32 @__tgt_target_kernel(ptr @[[GLOB1:[0-9]+]], i64 -1, i32 0, i32 0, ptr @.{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l66.region_id, ptr [[KERNEL_ARGS]])
// CHECK-NEXT:    [[TMP19:%.*]] = icmp ne i32 [[TMP18]], 0
// CHECK-NEXT:    br i1 [[TMP19]], label [[OMP_OFFLOAD_FAILED:%.*]], label [[OMP_OFFLOAD_CONT:%.*]]
// CHECK:       omp_offload.failed:
// CHECK-NEXT:    call void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l66(ptr [[TRAITS]]) #[[ATTR2:[0-9]+]]
// CHECK-NEXT:    br label [[OMP_OFFLOAD_CONT]]
// CHECK:       omp_offload.cont:
// CHECK-NEXT:    ret void
//
//
// CHECK-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l66
// CHECK-SAME: (ptr noundef nonnull align 8 dereferenceable(160) [[TRAITS:%.*]]) #[[ATTR1:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TRAITS_ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[MY_ALLOCATOR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1]])
// CHECK-NEXT:    store ptr [[TRAITS]], ptr [[TRAITS_ADDR]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load ptr, ptr [[TRAITS_ADDR]], align 8
// CHECK-NEXT:    [[TMP2:%.*]] = call ptr @__kmpc_init_allocator(i32 [[TMP0]], ptr null, i32 10, ptr [[TMP1]])
// CHECK-NEXT:    [[CONV:%.*]] = ptrtoint ptr [[TMP2]] to i64
// CHECK-NEXT:    store i64 [[CONV]], ptr [[MY_ALLOCATOR]], align 8
// CHECK-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_teams(ptr @[[GLOB1]], i32 0, ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l66.omp_outlined)
// CHECK-NEXT:    [[TMP3:%.*]] = load i64, ptr [[MY_ALLOCATOR]], align 8
// CHECK-NEXT:    [[CONV1:%.*]] = inttoptr i64 [[TMP3]] to ptr
// CHECK-NEXT:    call void @__kmpc_destroy_allocator(i32 [[TMP0]], ptr [[CONV1]])
// CHECK-NEXT:    ret void
//
//
// CHECK-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l66.omp_outlined
// CHECK-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]]) #[[ATTR1]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[DOTOMP_COMB_LB:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[DOTOMP_COMB_UB:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK-NEXT:    store i32 0, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK-NEXT:    store i32 9, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = load i32, ptr [[TMP0]], align 4
// CHECK-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB2:[0-9]+]], i32 [[TMP1]], i32 92, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_COMB_LB]], ptr [[DOTOMP_COMB_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP2]], 9
// CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK:       cond.true:
// CHECK-NEXT:    br label [[COND_END:%.*]]
// CHECK:       cond.false:
// CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-NEXT:    br label [[COND_END]]
// CHECK:       cond.end:
// CHECK-NEXT:    [[COND:%.*]] = phi i32 [ 9, [[COND_TRUE]] ], [ [[TMP3]], [[COND_FALSE]] ]
// CHECK-NEXT:    store i32 [[COND]], ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK-NEXT:    store i32 [[TMP4]], ptr [[DOTOMP_IV]], align 4
// CHECK-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK:       omp.inner.for.cond:
// CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-NEXT:    [[CMP1:%.*]] = icmp sle i32 [[TMP5]], [[TMP6]]
// CHECK-NEXT:    br i1 [[CMP1]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK:       omp.inner.for.body:
// CHECK-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_COMB_LB]], align 4
// CHECK-NEXT:    [[TMP8:%.*]] = zext i32 [[TMP7]] to i64
// CHECK-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_COMB_UB]], align 4
// CHECK-NEXT:    [[TMP10:%.*]] = zext i32 [[TMP9]] to i64
// CHECK-NEXT:    call void (ptr, i32, ptr, ...) @__kmpc_fork_call(ptr @[[GLOB1]], i32 2, ptr @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l66.omp_outlined.omp_outlined, i64 [[TMP8]], i64 [[TMP10]])
// CHECK-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK:       omp.inner.for.inc:
// CHECK-NEXT:    [[TMP11:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-NEXT:    [[TMP12:%.*]] = load i32, ptr [[DOTOMP_STRIDE]], align 4
// CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[TMP11]], [[TMP12]]
// CHECK-NEXT:    store i32 [[ADD]], ptr [[DOTOMP_IV]], align 4
// CHECK-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK:       omp.inner.for.end:
// CHECK-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK:       omp.loop.exit:
// CHECK-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB2]], i32 [[TMP1]])
// CHECK-NEXT:    ret void
//
//
// CHECK-LABEL: define {{[^@]+}}@{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}__Z3foov_l66.omp_outlined.omp_outlined
// CHECK-SAME: (ptr noalias noundef [[DOTGLOBAL_TID_:%.*]], ptr noalias noundef [[DOTBOUND_TID_:%.*]], i64 noundef [[DOTPREVIOUS_LB_:%.*]], i64 noundef [[DOTPREVIOUS_UB_:%.*]]) #[[ATTR1]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTGLOBAL_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTBOUND_TID__ADDR:%.*]] = alloca ptr, align 8
// CHECK-NEXT:    [[DOTPREVIOUS_LB__ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[DOTPREVIOUS_UB__ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[DOTOMP_IV:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[TMP:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[DOTOMP_LB:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[DOTOMP_UB:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[DOTOMP_STRIDE:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[DOTOMP_IS_LAST:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[I:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store ptr [[DOTGLOBAL_TID_]], ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-NEXT:    store ptr [[DOTBOUND_TID_]], ptr [[DOTBOUND_TID__ADDR]], align 8
// CHECK-NEXT:    store i64 [[DOTPREVIOUS_LB_]], ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK-NEXT:    store i64 [[DOTPREVIOUS_UB_]], ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK-NEXT:    store i32 0, ptr [[DOTOMP_LB]], align 4
// CHECK-NEXT:    store i32 9, ptr [[DOTOMP_UB]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr [[DOTPREVIOUS_LB__ADDR]], align 8
// CHECK-NEXT:    [[CONV:%.*]] = trunc i64 [[TMP0]] to i32
// CHECK-NEXT:    [[TMP1:%.*]] = load i64, ptr [[DOTPREVIOUS_UB__ADDR]], align 8
// CHECK-NEXT:    [[CONV1:%.*]] = trunc i64 [[TMP1]] to i32
// CHECK-NEXT:    store i32 [[CONV]], ptr [[DOTOMP_LB]], align 4
// CHECK-NEXT:    store i32 [[CONV1]], ptr [[DOTOMP_UB]], align 4
// CHECK-NEXT:    store i32 1, ptr [[DOTOMP_STRIDE]], align 4
// CHECK-NEXT:    store i32 0, ptr [[DOTOMP_IS_LAST]], align 4
// CHECK-NEXT:    [[TMP2:%.*]] = load ptr, ptr [[DOTGLOBAL_TID__ADDR]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = load i32, ptr [[TMP2]], align 4
// CHECK-NEXT:    call void @__kmpc_for_static_init_4(ptr @[[GLOB3:[0-9]+]], i32 [[TMP3]], i32 34, ptr [[DOTOMP_IS_LAST]], ptr [[DOTOMP_LB]], ptr [[DOTOMP_UB]], ptr [[DOTOMP_STRIDE]], i32 1, i32 1)
// CHECK-NEXT:    [[TMP4:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK-NEXT:    [[CMP:%.*]] = icmp sgt i32 [[TMP4]], 9
// CHECK-NEXT:    br i1 [[CMP]], label [[COND_TRUE:%.*]], label [[COND_FALSE:%.*]]
// CHECK:       cond.true:
// CHECK-NEXT:    br label [[COND_END:%.*]]
// CHECK:       cond.false:
// CHECK-NEXT:    [[TMP5:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK-NEXT:    br label [[COND_END]]
// CHECK:       cond.end:
// CHECK-NEXT:    [[COND:%.*]] = phi i32 [ 9, [[COND_TRUE]] ], [ [[TMP5]], [[COND_FALSE]] ]
// CHECK-NEXT:    store i32 [[COND]], ptr [[DOTOMP_UB]], align 4
// CHECK-NEXT:    [[TMP6:%.*]] = load i32, ptr [[DOTOMP_LB]], align 4
// CHECK-NEXT:    store i32 [[TMP6]], ptr [[DOTOMP_IV]], align 4
// CHECK-NEXT:    br label [[OMP_INNER_FOR_COND:%.*]]
// CHECK:       omp.inner.for.cond:
// CHECK-NEXT:    [[TMP7:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-NEXT:    [[TMP8:%.*]] = load i32, ptr [[DOTOMP_UB]], align 4
// CHECK-NEXT:    [[CMP2:%.*]] = icmp sle i32 [[TMP7]], [[TMP8]]
// CHECK-NEXT:    br i1 [[CMP2]], label [[OMP_INNER_FOR_BODY:%.*]], label [[OMP_INNER_FOR_END:%.*]]
// CHECK:       omp.inner.for.body:
// CHECK-NEXT:    [[TMP9:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-NEXT:    [[MUL:%.*]] = mul nsw i32 [[TMP9]], 1
// CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 0, [[MUL]]
// CHECK-NEXT:    store i32 [[ADD]], ptr [[I]], align 4
// CHECK-NEXT:    br label [[OMP_BODY_CONTINUE:%.*]]
// CHECK:       omp.body.continue:
// CHECK-NEXT:    br label [[OMP_INNER_FOR_INC:%.*]]
// CHECK:       omp.inner.for.inc:
// CHECK-NEXT:    [[TMP10:%.*]] = load i32, ptr [[DOTOMP_IV]], align 4
// CHECK-NEXT:    [[ADD3:%.*]] = add nsw i32 [[TMP10]], 1
// CHECK-NEXT:    store i32 [[ADD3]], ptr [[DOTOMP_IV]], align 4
// CHECK-NEXT:    br label [[OMP_INNER_FOR_COND]]
// CHECK:       omp.inner.for.end:
// CHECK-NEXT:    br label [[OMP_LOOP_EXIT:%.*]]
// CHECK:       omp.loop.exit:
// CHECK-NEXT:    call void @__kmpc_for_static_fini(ptr @[[GLOB3]], i32 [[TMP3]])
// CHECK-NEXT:    ret void
//
