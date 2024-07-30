// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// REQUIRES: riscv-registered-target
// RUN: %clang_cc1 -triple riscv64 -target-feature +v -target-feature +zfh \
// RUN:   -target-feature +zvfh -disable-O0-optnone  \
// RUN:   -emit-llvm %s -o - | opt -S -passes=mem2reg | \
// RUN:   FileCheck --check-prefix=CHECK-RV64 %s

#include <riscv_vector.h>

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_f32mf2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.nxv1f32.i64(<vscale x 1 x float> [[TMP0]], <vscale x 1 x float> [[TMP1]], <vscale x 1 x float> [[TMP2]], <vscale x 1 x float> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_f32mf2x4(float *base, ptrdiff_t bstride, vfloat32mf2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_f32m1x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.nxv2f32.i64(<vscale x 2 x float> [[TMP0]], <vscale x 2 x float> [[TMP1]], <vscale x 2 x float> [[TMP2]], <vscale x 2 x float> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_f32m1x4(float *base, ptrdiff_t bstride, vfloat32m1x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_f32m2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.nxv4f32.i64(<vscale x 4 x float> [[TMP0]], <vscale x 4 x float> [[TMP1]], <vscale x 4 x float> [[TMP2]], <vscale x 4 x float> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_f32m2x4(float *base, ptrdiff_t bstride, vfloat32m2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_i32mf2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.nxv1i32.i64(<vscale x 1 x i32> [[TMP0]], <vscale x 1 x i32> [[TMP1]], <vscale x 1 x i32> [[TMP2]], <vscale x 1 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_i32mf2x4(int32_t *base, ptrdiff_t bstride, vint32mf2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_i32m1x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.nxv2i32.i64(<vscale x 2 x i32> [[TMP0]], <vscale x 2 x i32> [[TMP1]], <vscale x 2 x i32> [[TMP2]], <vscale x 2 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_i32m1x4(int32_t *base, ptrdiff_t bstride, vint32m1x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_i32m2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.nxv4i32.i64(<vscale x 4 x i32> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_i32m2x4(int32_t *base, ptrdiff_t bstride, vint32m2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_u32mf2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.nxv1i32.i64(<vscale x 1 x i32> [[TMP0]], <vscale x 1 x i32> [[TMP1]], <vscale x 1 x i32> [[TMP2]], <vscale x 1 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_u32mf2x4(uint32_t *base, ptrdiff_t bstride, vuint32mf2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_u32m1x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.nxv2i32.i64(<vscale x 2 x i32> [[TMP0]], <vscale x 2 x i32> [[TMP1]], <vscale x 2 x i32> [[TMP2]], <vscale x 2 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_u32m1x4(uint32_t *base, ptrdiff_t bstride, vuint32m1x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_u32m2x4
// CHECK-RV64-SAME: (ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.nxv4i32.i64(<vscale x 4 x i32> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_u32m2x4(uint32_t *base, ptrdiff_t bstride, vuint32m2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_f32mf2x4_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.mask.nxv1f32.i64(<vscale x 1 x float> [[TMP0]], <vscale x 1 x float> [[TMP1]], <vscale x 1 x float> [[TMP2]], <vscale x 1 x float> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_f32mf2x4_m(vbool64_t mask, float *base, ptrdiff_t bstride, vfloat32mf2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_f32m1x4_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.mask.nxv2f32.i64(<vscale x 2 x float> [[TMP0]], <vscale x 2 x float> [[TMP1]], <vscale x 2 x float> [[TMP2]], <vscale x 2 x float> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_f32m1x4_m(vbool32_t mask, float *base, ptrdiff_t bstride, vfloat32m1x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_f32m2x4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.mask.nxv4f32.i64(<vscale x 4 x float> [[TMP0]], <vscale x 4 x float> [[TMP1]], <vscale x 4 x float> [[TMP2]], <vscale x 4 x float> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_f32m2x4_m(vbool16_t mask, float *base, ptrdiff_t bstride, vfloat32m2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_i32mf2x4_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.mask.nxv1i32.i64(<vscale x 1 x i32> [[TMP0]], <vscale x 1 x i32> [[TMP1]], <vscale x 1 x i32> [[TMP2]], <vscale x 1 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_i32mf2x4_m(vbool64_t mask, int32_t *base, ptrdiff_t bstride, vint32mf2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_i32m1x4_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.mask.nxv2i32.i64(<vscale x 2 x i32> [[TMP0]], <vscale x 2 x i32> [[TMP1]], <vscale x 2 x i32> [[TMP2]], <vscale x 2 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_i32m1x4_m(vbool32_t mask, int32_t *base, ptrdiff_t bstride, vint32m1x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_i32m2x4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.mask.nxv4i32.i64(<vscale x 4 x i32> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_i32m2x4_m(vbool16_t mask, int32_t *base, ptrdiff_t bstride, vint32m2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_u32mf2x4_m
// CHECK-RV64-SAME: (<vscale x 1 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32>, <vscale x 1 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.mask.nxv1i32.i64(<vscale x 1 x i32> [[TMP0]], <vscale x 1 x i32> [[TMP1]], <vscale x 1 x i32> [[TMP2]], <vscale x 1 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 1 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_u32mf2x4_m(vbool64_t mask, uint32_t *base, ptrdiff_t bstride, vuint32mf2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_u32m1x4_m
// CHECK-RV64-SAME: (<vscale x 2 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32>, <vscale x 2 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.mask.nxv2i32.i64(<vscale x 2 x i32> [[TMP0]], <vscale x 2 x i32> [[TMP1]], <vscale x 2 x i32> [[TMP2]], <vscale x 2 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 2 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_u32m1x4_m(vbool32_t mask, uint32_t *base, ptrdiff_t bstride, vuint32m1x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(mask, base, bstride, v_tuple, vl);
}

// CHECK-RV64-LABEL: define dso_local void @test_vssseg4e32_v_u32m2x4_m
// CHECK-RV64-SAME: (<vscale x 4 x i1> [[MASK:%.*]], ptr noundef [[BASE:%.*]], i64 noundef [[BSTRIDE:%.*]], { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE:%.*]], i64 noundef [[VL:%.*]]) #[[ATTR0]] {
// CHECK-RV64-NEXT:  entry:
// CHECK-RV64-NEXT:    [[TMP0:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 0
// CHECK-RV64-NEXT:    [[TMP1:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 1
// CHECK-RV64-NEXT:    [[TMP2:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 2
// CHECK-RV64-NEXT:    [[TMP3:%.*]] = extractvalue { <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32>, <vscale x 4 x i32> } [[V_TUPLE]], 3
// CHECK-RV64-NEXT:    call void @llvm.riscv.vssseg4.mask.nxv4i32.i64(<vscale x 4 x i32> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[TMP2]], <vscale x 4 x i32> [[TMP3]], ptr [[BASE]], i64 [[BSTRIDE]], <vscale x 4 x i1> [[MASK]], i64 [[VL]])
// CHECK-RV64-NEXT:    ret void
//
void test_vssseg4e32_v_u32m2x4_m(vbool16_t mask, uint32_t *base, ptrdiff_t bstride, vuint32m2x4_t v_tuple, size_t vl) {
  return __riscv_vssseg4e32(mask, base, bstride, v_tuple, vl);
}

