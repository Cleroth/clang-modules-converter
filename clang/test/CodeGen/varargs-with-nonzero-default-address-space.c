// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 4
// RUN: %clang_cc1 -triple spirv64-unknown-unknown -fcuda-is-device -emit-llvm -o - %s | FileCheck %s

struct x {
  double b;
  long a;
};

// CHECK-LABEL: define spir_func void @testva(
// CHECK-SAME: i32 noundef [[N:%.*]], ...) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[N_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[AP:%.*]] = alloca ptr addrspace(4), align 8
// CHECK-NEXT:    [[T:%.*]] = alloca [[STRUCT_X:%.*]], align 8
// CHECK-NEXT:    [[AP2:%.*]] = alloca ptr addrspace(4), align 8
// CHECK-NEXT:    [[V:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[VARET:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[N_ADDR_ASCAST:%.*]] = addrspacecast ptr [[N_ADDR]] to ptr addrspace(4)
// CHECK-NEXT:    [[AP_ASCAST:%.*]] = addrspacecast ptr [[AP]] to ptr addrspace(4)
// CHECK-NEXT:    [[T_ASCAST:%.*]] = addrspacecast ptr [[T]] to ptr addrspace(4)
// CHECK-NEXT:    [[AP2_ASCAST:%.*]] = addrspacecast ptr [[AP2]] to ptr addrspace(4)
// CHECK-NEXT:    [[V_ASCAST:%.*]] = addrspacecast ptr [[V]] to ptr addrspace(4)
// CHECK-NEXT:    [[VARET_ASCAST:%.*]] = addrspacecast ptr [[VARET]] to ptr addrspace(4)
// CHECK-NEXT:    store i32 [[N]], ptr addrspace(4) [[N_ADDR_ASCAST]], align 4
// CHECK-NEXT:    call void @llvm.va_start.p4(ptr addrspace(4) [[AP_ASCAST]])
// CHECK-NEXT:    [[TMP0:%.*]] = va_arg ptr addrspace(4) [[AP_ASCAST]], ptr
// CHECK-NEXT:    call void @llvm.memcpy.p4.p0.i64(ptr addrspace(4) align 8 [[T_ASCAST]], ptr align 8 [[TMP0]], i64 16, i1 false)
// CHECK-NEXT:    call void @llvm.va_copy.p4(ptr addrspace(4) [[AP2_ASCAST]], ptr addrspace(4) [[AP_ASCAST]])
// CHECK-NEXT:    [[TMP1:%.*]] = va_arg ptr addrspace(4) [[AP2_ASCAST]], i32
// CHECK-NEXT:    store i32 [[TMP1]], ptr addrspace(4) [[VARET_ASCAST]], align 4
// CHECK-NEXT:    [[TMP2:%.*]] = load i32, ptr addrspace(4) [[VARET_ASCAST]], align 4
// CHECK-NEXT:    store i32 [[TMP2]], ptr addrspace(4) [[V_ASCAST]], align 4
// CHECK-NEXT:    call void @llvm.va_end.p4(ptr addrspace(4) [[AP2_ASCAST]])
// CHECK-NEXT:    call void @llvm.va_end.p4(ptr addrspace(4) [[AP_ASCAST]])
// CHECK-NEXT:    ret void

void testva(int n, ...) {
  __builtin_va_list ap;
  __builtin_va_start(ap, n);
  struct x t = __builtin_va_arg(ap, struct x);
  __builtin_va_list ap2;
  __builtin_va_copy(ap2, ap);
  int v = __builtin_va_arg(ap2, int);
  __builtin_va_end(ap2);
  __builtin_va_end(ap);
}
