// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: powerpc-registered-target
// RUN: %clang_cc1 -triple powerpc64-unknown-linux-gnu \
// RUN:    -emit-llvm %s -o -  -target-cpu pwr8 | FileCheck %s
// RUN: %clang_cc1 -triple powerpc64le-unknown-linux-gnu \
// RUN:   -emit-llvm %s -o -  -target-cpu pwr8 | FileCheck %s

// CHECK-LABEL: @test_builtin_ppc_fetch_and_add(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 [[A:%.*]], ptr [[A_ADDR]], align 4
// CHECK-NEXT:    store i32 [[B:%.*]], ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw add ptr [[A_ADDR]], i32 [[TMP0]] monotonic, align 4
// CHECK-NEXT:    ret void
//
void test_builtin_ppc_fetch_and_add(int a, int b) {
  __fetch_and_add(&a, b);
}

// CHECK-LABEL: @test_builtin_ppc_fetch_and_addlp(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    store i64 [[A:%.*]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    store i64 [[B:%.*]], ptr [[B_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr [[B_ADDR]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw add ptr [[A_ADDR]], i64 [[TMP0]] monotonic, align 8
// CHECK-NEXT:    ret void
//
void test_builtin_ppc_fetch_and_addlp(long a, long b) {
  __fetch_and_addlp(&a, b);
}
// CHECK-LABEL: @test_builtin_ppc_fetch_and_and(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 [[A:%.*]], ptr [[A_ADDR]], align 4
// CHECK-NEXT:    store i32 [[B:%.*]], ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw and ptr [[A_ADDR]], i32 [[TMP0]] monotonic, align 4
// CHECK-NEXT:    ret void
//
void test_builtin_ppc_fetch_and_and(unsigned int a, unsigned int b) {
  __fetch_and_and(&a, b);
}
// CHECK-LABEL: @test_builtin_ppc_fetch_and_andlp(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    store i64 [[A:%.*]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    store i64 [[B:%.*]], ptr [[B_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr [[B_ADDR]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw and ptr [[A_ADDR]], i64 [[TMP0]] monotonic, align 8
// CHECK-NEXT:    ret void
//
void test_builtin_ppc_fetch_and_andlp(unsigned long a, unsigned long b) {
  __fetch_and_andlp(&a, b);
}
// CHECK-LABEL: @test_builtin_ppc_fetch_and_or(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 [[A:%.*]], ptr [[A_ADDR]], align 4
// CHECK-NEXT:    store i32 [[B:%.*]], ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw or ptr [[A_ADDR]], i32 [[TMP0]] monotonic, align 4
// CHECK-NEXT:    ret void
//
void test_builtin_ppc_fetch_and_or(unsigned int a, unsigned int b) {
  __fetch_and_or(&a, b);
}
// CHECK-LABEL: @test_builtin_ppc_fetch_and_orlp(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    store i64 [[A:%.*]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    store i64 [[B:%.*]], ptr [[B_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr [[B_ADDR]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw or ptr [[A_ADDR]], i64 [[TMP0]] monotonic, align 8
// CHECK-NEXT:    ret void
//
void test_builtin_ppc_fetch_and_orlp(unsigned long a, unsigned long b) {
  __fetch_and_orlp(&a, b);
}
// CHECK-LABEL: @test_builtin_ppc_fetch_and_swap(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i32, align 4
// CHECK-NEXT:    store i32 [[A:%.*]], ptr [[A_ADDR]], align 4
// CHECK-NEXT:    store i32 [[B:%.*]], ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[B_ADDR]], align 4
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw xchg ptr [[A_ADDR]], i32 [[TMP0]] monotonic, align 4
// CHECK-NEXT:    ret void
//
void test_builtin_ppc_fetch_and_swap(unsigned int a, unsigned int b) {
  __fetch_and_swap(&a, b);
}
// CHECK-LABEL: @test_builtin_ppc_fetch_and_swaplp(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[A_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca i64, align 8
// CHECK-NEXT:    store i64 [[A:%.*]], ptr [[A_ADDR]], align 8
// CHECK-NEXT:    store i64 [[B:%.*]], ptr [[B_ADDR]], align 8
// CHECK-NEXT:    [[TMP0:%.*]] = load i64, ptr [[B_ADDR]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = atomicrmw xchg ptr [[A_ADDR]], i64 [[TMP0]] monotonic, align 8
// CHECK-NEXT:    ret void
//
void test_builtin_ppc_fetch_and_swaplp(unsigned long a, unsigned long b) {
  __fetch_and_swaplp(&a, b);
}
