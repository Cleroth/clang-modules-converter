// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// RUN: %clang_cc1 -triple thumbv8.1m.main-none-none-eabi -target-feature +mve.fp -mfloat-abi hard -O0 -disable-O0-optnone -emit-llvm -o - %s | opt -S -passes=mem2reg | FileCheck %s

// REQUIRES: aarch64-registered-target || arm-registered-target

#include <arm_mve.h>

// CHECK-LABEL: @test_vldrwq_gather_base_wb_s32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load <4 x i32>, ptr [[ADDR:%.*]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = call { <4 x i32>, <4 x i32> } @llvm.arm.mve.vldr.gather.base.wb.v4i32.v4i32(<4 x i32> [[TMP0]], i32 80)
// CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x i32>, <4 x i32> } [[TMP1]], 1
// CHECK-NEXT:    store <4 x i32> [[TMP2]], ptr [[ADDR]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x i32>, <4 x i32> } [[TMP1]], 0
// CHECK-NEXT:    ret <4 x i32> [[TMP3]]
//
int32x4_t test_vldrwq_gather_base_wb_s32(uint32x4_t *addr)
{
    return vldrwq_gather_base_wb_s32(addr, 0x50);
}

// CHECK-LABEL: @test_vldrwq_gather_base_wb_f32(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load <4 x i32>, ptr [[ADDR:%.*]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = call { <4 x float>, <4 x i32> } @llvm.arm.mve.vldr.gather.base.wb.v4f32.v4i32(<4 x i32> [[TMP0]], i32 64)
// CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { <4 x float>, <4 x i32> } [[TMP1]], 1
// CHECK-NEXT:    store <4 x i32> [[TMP2]], ptr [[ADDR]], align 8
// CHECK-NEXT:    [[TMP3:%.*]] = extractvalue { <4 x float>, <4 x i32> } [[TMP1]], 0
// CHECK-NEXT:    ret <4 x float> [[TMP3]]
//
float32x4_t test_vldrwq_gather_base_wb_f32(uint32x4_t *addr)
{
    return vldrwq_gather_base_wb_f32(addr, 0x40);
}

// CHECK-LABEL: @test_vldrdq_gather_base_wb_z_u64(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = load <2 x i64>, ptr [[ADDR:%.*]], align 8
// CHECK-NEXT:    [[TMP1:%.*]] = zext i16 [[P:%.*]] to i32
// CHECK-NEXT:    [[TMP2:%.*]] = call <2 x i1> @llvm.arm.mve.pred.i2v.v2i1(i32 [[TMP1]])
// CHECK-NEXT:    [[TMP3:%.*]] = call { <2 x i64>, <2 x i64> } @llvm.arm.mve.vldr.gather.base.wb.predicated.v2i64.v2i64.v2i1(<2 x i64> [[TMP0]], i32 656, <2 x i1> [[TMP2]])
// CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { <2 x i64>, <2 x i64> } [[TMP3]], 1
// CHECK-NEXT:    store <2 x i64> [[TMP4]], ptr [[ADDR]], align 8
// CHECK-NEXT:    [[TMP5:%.*]] = extractvalue { <2 x i64>, <2 x i64> } [[TMP3]], 0
// CHECK-NEXT:    ret <2 x i64> [[TMP5]]
//
uint64x2_t test_vldrdq_gather_base_wb_z_u64(uint64x2_t *addr, mve_pred16_t p)
{
    return vldrdq_gather_base_wb_z_u64(addr, 0x290, p);
}
