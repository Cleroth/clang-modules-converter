// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64 -target-feature +sve -target-feature +bf16 -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -triple aarch64 -target-feature +sve -target-feature +bf16 -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve -target-feature +bf16 -disable-O0-optnone -Werror -Wall -emit-llvm -o - %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s
// RUN: %clang_cc1 -fclang-abi-compat=latest -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve -target-feature +bf16 -disable-O0-optnone -Werror -Wall -emit-llvm -o - -x c++ %s | opt -S -passes=mem2reg,tailcallelim | FileCheck %s -check-prefix=CPP-CHECK

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
#define SVE_ACLE_FUNC(A1, A2_UNUSED, A3, A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1, A2, A3, A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svcnt_bf16_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.cnt.nxv8bf16(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svcnt_bf16_zu10__SVBool_tu14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.cnt.nxv8bf16(<vscale x 8 x i16> zeroinitializer, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svcnt_bf16_z(svbool_t pg, svbfloat16_t op) MODE_ATTR {
  // expected-warning@+1 {{implicit declaration of function 'svcnt_bf16_z'}}
  return SVE_ACLE_FUNC(svcnt, _bf16, _z, )(pg, op);
}

// CHECK-LABEL: @test_svcnt_bf16_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.cnt.nxv8bf16(<vscale x 8 x i16> [[INACTIVE:%.*]], <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svcnt_bf16_mu12__SVUint16_tu10__SVBool_tu14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.cnt.nxv8bf16(<vscale x 8 x i16> [[INACTIVE:%.*]], <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svcnt_bf16_m(svuint16_t inactive, svbool_t pg, svbfloat16_t op) MODE_ATTR {
  // expected-warning@+1 {{implicit declaration of function 'svcnt_bf16_m'}}
  return SVE_ACLE_FUNC(svcnt, _bf16, _m, )(inactive, pg, op);
}
// CHECK-LABEL: @test_svcnt_bf16_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.cnt.nxv8bf16(<vscale x 8 x i16> undef, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> [[OP:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svcnt_bf16_xu10__SVBool_tu14__SVBfloat16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.cnt.nxv8bf16(<vscale x 8 x i16> undef, <vscale x 8 x i1> [[TMP0]], <vscale x 8 x bfloat> [[OP:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svcnt_bf16_x(svbool_t pg, svbfloat16_t op) MODE_ATTR {
  // expected-warning@+1 {{implicit declaration of function 'svcnt_bf16_x'}}
  return SVE_ACLE_FUNC(svcnt, _bf16, _x, )(pg, op);
}
