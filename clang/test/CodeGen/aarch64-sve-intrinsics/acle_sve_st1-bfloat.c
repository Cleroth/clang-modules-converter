// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64 -target-feature +sve -target-feature +bf16 -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64 -target-feature +sve -target-feature +bf16 -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve -target-feature +bf16 -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve -target-feature +bf16 -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,instcombine,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64 -target-feature +sve -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64 -target-feature +sme -target-feature +bf16 -S -disable-O0-optnone -Werror -Wall -o /dev/null %s

#include <arm_sve.h>

#if defined __ARM_FEATURE_SME
#define MODE_ATTR __arm_streaming
#else
#define MODE_ATTR
#endif


#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svst1_bf16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    tail call void @llvm.masked.store.nxv8bf16.p0(<vscale x 8 x bfloat> [[DATA:%.*]], ptr [[BASE:%.*]], i32 1, <vscale x 8 x i1> [[TMP0]])
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z15test_svst1_bf16u10__SVBool_tPu6__bf16u14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    tail call void @llvm.masked.store.nxv8bf16.p0(<vscale x 8 x bfloat> [[DATA:%.*]], ptr [[BASE:%.*]], i32 1, <vscale x 8 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret void
//
void test_svst1_bf16(svbool_t pg, bfloat16_t *base, svbfloat16_t data) MODE_ATTR
{
  return SVE_ACLE_FUNC(svst1,_bf16,,)(pg, base, data);
}

// CHECK-LABEL: @test_svst1_vnum_bf16(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call i64 @llvm.vscale.i64()
// CHECK-NEXT:    [[TMP2:%.*]] = shl nuw nsw i64 [[TMP1]], 4
// CHECK-NEXT:    [[DOTIDX:%.*]] = mul i64 [[TMP2]], [[VNUM:%.*]]
// CHECK-NEXT:    [[TMP3:%.*]] = getelementptr i8, ptr [[BASE:%.*]], i64 [[DOTIDX]]
// CHECK-NEXT:    tail call void @llvm.masked.store.nxv8bf16.p0(<vscale x 8 x bfloat> [[DATA:%.*]], ptr [[TMP3]], i32 1, <vscale x 8 x i1> [[TMP0]])
// CHECK-NEXT:    ret void
//
// CPP-CHECK-LABEL: @_Z20test_svst1_vnum_bf16u10__SVBool_tPu6__bf16lu14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call i64 @llvm.vscale.i64()
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = shl nuw nsw i64 [[TMP1]], 4
// CPP-CHECK-NEXT:    [[DOTIDX:%.*]] = mul i64 [[TMP2]], [[VNUM:%.*]]
// CPP-CHECK-NEXT:    [[TMP3:%.*]] = getelementptr i8, ptr [[BASE:%.*]], i64 [[DOTIDX]]
// CPP-CHECK-NEXT:    tail call void @llvm.masked.store.nxv8bf16.p0(<vscale x 8 x bfloat> [[DATA:%.*]], ptr [[TMP3]], i32 1, <vscale x 8 x i1> [[TMP0]])
// CPP-CHECK-NEXT:    ret void
//
void test_svst1_vnum_bf16(svbool_t pg, bfloat16_t *base, int64_t vnum, svbfloat16_t data) MODE_ATTR
{
  return SVE_ACLE_FUNC(svst1_vnum,_bf16,,)(pg, base, vnum, data);
}
