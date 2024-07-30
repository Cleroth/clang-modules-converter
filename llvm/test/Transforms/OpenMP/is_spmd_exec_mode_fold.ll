; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --check-globals
; RUN: opt -S -passes=openmp-opt < %s | FileCheck %s
target triple = "nvptx64"

%struct.KernelEnvironmentTy = type { %struct.ConfigurationEnvironmentTy, ptr, ptr }
%struct.ConfigurationEnvironmentTy = type { i8, i8, i8, i32, i32, i32, i32, i32, i32 }

@G = external global i8
@is_spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 2, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0 }, ptr null, ptr null }
@will_be_spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0 }, ptr null, ptr null }
@none_spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0 }, ptr null, ptr null }
@will_not_be_spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0 }, ptr null, ptr null }

;.
; CHECK: @G = external global i8
; CHECK: @is_spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 2, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0 }, ptr null, ptr null }
; CHECK: @will_be_spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 3, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0 }, ptr null, ptr null }
; CHECK: @none_spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0 }, ptr null, ptr null }
; CHECK: @will_not_be_spmd_kernel_environment = local_unnamed_addr constant %struct.KernelEnvironmentTy { %struct.ConfigurationEnvironmentTy { i8 0, i8 0, i8 1, i32 0, i32 0, i32 0, i32 0, i32 0, i32 0 }, ptr null, ptr null }
;.
define weak void @is_spmd() "kernel" {
; CHECK-LABEL: define {{[^@]+}}@is_spmd
; CHECK-SAME: () #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:    [[I:%.*]] = call i32 @__kmpc_target_init(ptr @is_spmd_kernel_environment, ptr null)
; CHECK-NEXT:    call void @is_spmd_helper1()
; CHECK-NEXT:    call void @is_spmd_helper2()
; CHECK-NEXT:    call void @is_mixed_helper()
; CHECK-NEXT:    call void @__kmpc_target_deinit()
; CHECK-NEXT:    ret void
;
  %i = call i32 @__kmpc_target_init(ptr @is_spmd_kernel_environment, ptr null)
  call void @is_spmd_helper1()
  call void @is_spmd_helper2()
  call void @is_mixed_helper()
  call void @__kmpc_target_deinit()
  ret void
}

define weak void @will_be_spmd() "kernel" {
; CHECK-LABEL: define {{[^@]+}}@will_be_spmd
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CAPTURED_VARS_ADDRS:%.*]] = alloca [0 x ptr], align 8
; CHECK-NEXT:    [[I:%.*]] = call i32 @__kmpc_target_init(ptr @will_be_spmd_kernel_environment, ptr null)
; CHECK-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[I]], -1
; CHECK-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[COMMON_RET:%.*]]
; CHECK:       common.ret:
; CHECK-NEXT:    ret void
; CHECK:       user_code.entry:
; CHECK-NEXT:    [[TMP0:%.*]] = call i32 @__kmpc_global_thread_num(ptr null) #[[ATTR3:[0-9]+]]
; CHECK-NEXT:    call void @is_spmd_helper2()
; CHECK-NEXT:    call void @__kmpc_parallel_51(ptr null, i32 [[TMP0]], i32 1, i32 -1, i32 -1, ptr @__omp_outlined__, ptr @__omp_outlined___wrapper, ptr [[CAPTURED_VARS_ADDRS]], i64 0)
; CHECK-NEXT:    call void @__kmpc_target_deinit()
; CHECK-NEXT:    ret void
;
entry:
  %captured_vars_addrs = alloca [0 x ptr], align 8
  %i = call i32 @__kmpc_target_init(ptr @will_be_spmd_kernel_environment, ptr null)
  %exec_user_code = icmp eq i32 %i, -1
  br i1 %exec_user_code, label %user_code.entry, label %common.ret

common.ret:
  ret void

user_code.entry:
  %0 = call i32 @__kmpc_global_thread_num(ptr null)
  call void @is_spmd_helper2()
  call void @__kmpc_parallel_51(ptr null, i32 %0, i32 1, i32 -1, i32 -1, ptr @__omp_outlined__, ptr @__omp_outlined___wrapper, ptr %captured_vars_addrs, i64 0)
  call void @__kmpc_target_deinit()
  ret void
}

define weak void @non_spmd() "kernel" {
; CHECK-LABEL: define {{[^@]+}}@non_spmd
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    [[I:%.*]] = call i32 @__kmpc_target_init(ptr @none_spmd_kernel_environment, ptr null)
; CHECK-NEXT:    call void @is_generic_helper1()
; CHECK-NEXT:    call void @is_generic_helper2()
; CHECK-NEXT:    call void @is_mixed_helper()
; CHECK-NEXT:    call void @__kmpc_target_deinit()
; CHECK-NEXT:    ret void
;
  %i = call i32 @__kmpc_target_init(ptr @none_spmd_kernel_environment, ptr null)
  call void @is_generic_helper1()
  call void @is_generic_helper2()
  call void @is_mixed_helper()
  call void @__kmpc_target_deinit()
  ret void
}

define weak void @will_not_be_spmd() "kernel" {
; CHECK-LABEL: define {{[^@]+}}@will_not_be_spmd
; CHECK-SAME: () #[[ATTR0]] {
; CHECK-NEXT:    [[I:%.*]] = call i32 @__kmpc_target_init(ptr @will_not_be_spmd_kernel_environment, ptr null)
; CHECK-NEXT:    call void @is_generic_helper1()
; CHECK-NEXT:    call void @is_generic_helper2()
; CHECK-NEXT:    call void @is_mixed_helper()
; CHECK-NEXT:    call void @__kmpc_target_deinit()
; CHECK-NEXT:    ret void
;
  %i = call i32 @__kmpc_target_init(ptr @will_not_be_spmd_kernel_environment, ptr null)
  call void @is_generic_helper1()
  call void @is_generic_helper2()
  call void @is_mixed_helper()
  call void @__kmpc_target_deinit()
  ret void
}

define internal void @is_spmd_helper1() {
; CHECK-LABEL: define {{[^@]+}}@is_spmd_helper1() {
; CHECK-NEXT:    store i8 1, ptr @G, align 1
; CHECK-NEXT:    ret void
;
  %isSPMD = call i8 @__kmpc_is_spmd_exec_mode()
  store i8 %isSPMD, ptr @G
  ret void
}

define internal void @is_spmd_helper2() {
; CHECK-LABEL: define {{[^@]+}}@is_spmd_helper2() {
; CHECK-NEXT:    br label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    unreachable
; CHECK:       f:
; CHECK-NEXT:    ret void
;
  %isSPMD = call i8 @__kmpc_is_spmd_exec_mode()
  %c = icmp eq i8 %isSPMD, 0
  br i1 %c, label %t, label %f
t:
  call void @spmd_compatible()
  ret void
f:
  ret void
}

define internal void @is_generic_helper1() {
; CHECK-LABEL: define {{[^@]+}}@is_generic_helper1() {
; CHECK-NEXT:    store i8 0, ptr @G, align 1
; CHECK-NEXT:    ret void
;
  %isSPMD = call i8 @__kmpc_is_spmd_exec_mode()
  store i8 %isSPMD, ptr @G
  ret void
}

define internal void @is_generic_helper2() {
; CHECK-LABEL: define {{[^@]+}}@is_generic_helper2() {
; CHECK-NEXT:    [[C:%.*]] = icmp eq i8 0, 0
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       t:
; CHECK-NEXT:    call void @foo()
; CHECK-NEXT:    ret void
; CHECK:       f:
; CHECK-NEXT:    call void @bar()
; CHECK-NEXT:    ret void
;
  %isSPMD = call i8 @__kmpc_is_spmd_exec_mode()
  %c = icmp eq i8 %isSPMD, 0
  br i1 %c, label %t, label %f
t:
  call void @foo()
  ret void
f:
  call void @bar()
  ret void
}

define internal void @is_mixed_helper() {
; CHECK-LABEL: define {{[^@]+}}@is_mixed_helper() {
; CHECK-NEXT:    [[ISSPMD:%.*]] = call i8 @__kmpc_is_spmd_exec_mode()
; CHECK-NEXT:    store i8 [[ISSPMD]], ptr @G, align 1
; CHECK-NEXT:    ret void
;
  %isSPMD = call i8 @__kmpc_is_spmd_exec_mode()
  store i8 %isSPMD, ptr @G
  ret void
}

define internal void @__omp_outlined__(ptr noalias %.global_tid., ptr noalias %.bound_tid.) {
; CHECK-LABEL: define {{[^@]+}}@__omp_outlined__
; CHECK-SAME: (ptr noalias [[DOTGLOBAL_TID_:%.*]], ptr noalias [[DOTBOUND_TID_:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
entry:
  ret void
}

define internal void @__omp_outlined___wrapper(i16 zeroext %0, i32 %1) {
; CHECK-LABEL: define {{[^@]+}}@__omp_outlined___wrapper
; CHECK-SAME: (i16 zeroext [[TMP0:%.*]], i32 [[TMP1:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    ret void
;
entry:
  ret void
}

declare void @spmd_compatible() "llvm.assume"="ompx_spmd_amenable"
declare i8 @__kmpc_is_spmd_exec_mode()
declare i32 @__kmpc_target_init(ptr, ptr)
declare void @__kmpc_target_deinit()
declare void @__kmpc_parallel_51(ptr, i32, i32, i32, i32, ptr, ptr, ptr, i64)
declare i32 @__kmpc_global_thread_num(ptr)
declare void @foo()
declare void @bar()

!llvm.module.flags = !{!0, !1}
!nvvm.annotations = !{!2, !3, !4, !5}

!0 = !{i32 7, !"openmp", i32 50}
!1 = !{i32 7, !"openmp-device", i32 50}
!2 = !{ptr @is_spmd, !"kernel", i32 1}
!3 = !{ptr @will_be_spmd, !"kernel", i32 1}
!4 = !{ptr @non_spmd, !"kernel", i32 1}
!5 = !{ptr @will_not_be_spmd, !"kernel", i32 1}
;.
; CHECK: attributes #[[ATTR0]] = { "kernel" }
; CHECK: attributes #[[ATTR1:[0-9]+]] = { "llvm.assume"="ompx_spmd_amenable" }
; CHECK: attributes #[[ATTR2:[0-9]+]] = { alwaysinline }
; CHECK: attributes #[[ATTR3]] = { nounwind }
;.
; CHECK: [[META0:![0-9]+]] = !{i32 7, !"openmp", i32 50}
; CHECK: [[META1:![0-9]+]] = !{i32 7, !"openmp-device", i32 50}
; CHECK: [[META2:![0-9]+]] = !{ptr @is_spmd, !"kernel", i32 1}
; CHECK: [[META3:![0-9]+]] = !{ptr @will_be_spmd, !"kernel", i32 1}
; CHECK: [[META4:![0-9]+]] = !{ptr @non_spmd, !"kernel", i32 1}
; CHECK: [[META5:![0-9]+]] = !{ptr @will_not_be_spmd, !"kernel", i32 1}
;.
