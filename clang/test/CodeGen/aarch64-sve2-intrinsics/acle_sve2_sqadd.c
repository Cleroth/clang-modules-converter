// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py
// REQUIRES: aarch64-registered-target

// RUN: %clang_cc1 -triple aarch64 -target-feature +sve -target-feature +sve2 -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple aarch64 -target-feature +sve -target-feature +sve2 -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve -target-feature +sve2 -O1 -Werror -Wall -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -DSVE_OVERLOADED_FORMS -triple aarch64 -target-feature +sve -target-feature +sve2 -O1 -Werror -Wall -emit-llvm -o - -x c++ %s | FileCheck %s -check-prefix=CPP-CHECK
#include <arm_sve.h>

#ifdef SVE_OVERLOADED_FORMS
// A simple used,unused... macro, long enough to represent any SVE builtin.
#define SVE_ACLE_FUNC(A1,A2_UNUSED,A3,A4_UNUSED) A1##A3
#else
#define SVE_ACLE_FUNC(A1,A2,A3,A4) A1##A2##A3##A4
#endif

// CHECK-LABEL: @test_svsqadd_u8_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svsqadd_u8_mu10__SVBool_tu11__SVUint8_tu10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svsqadd_u8_m(svbool_t pg, svuint8_t op1, svint8_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u8,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u16_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svsqadd_u16_mu10__SVBool_tu12__SVUint16_tu11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svsqadd_u16_m(svbool_t pg, svuint16_t op1, svint16_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u16,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u32_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svsqadd_u32_mu10__SVBool_tu12__SVUint32_tu11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svsqadd_u32_m(svbool_t pg, svuint32_t op1, svint32_t op2)
{
  // CHECKA-LABEL: test_svsqadd_u32_m
  return SVE_ACLE_FUNC(svsqadd,_u32,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u64_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svsqadd_u64_mu10__SVBool_tu12__SVUint64_tu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svuint64_t test_svsqadd_u64_m(svbool_t pg, svuint64_t op1, svint64_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u64,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u8_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 16 x i8> poison, i8 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 16 x i8> [[DOTSPLATINSERT]], <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z19test_svsqadd_n_u8_mu10__SVBool_tu11__SVUint8_ta(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 16 x i8> poison, i8 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 16 x i8> [[DOTSPLATINSERT]], <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svsqadd_n_u8_m(svbool_t pg, svuint8_t op1, int8_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u8,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u16_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 8 x i16> poison, i16 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 8 x i16> [[DOTSPLATINSERT]], <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z20test_svsqadd_n_u16_mu10__SVBool_tu12__SVUint16_ts(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 8 x i16> poison, i16 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 8 x i16> [[DOTSPLATINSERT]], <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svsqadd_n_u16_m(svbool_t pg, svuint16_t op1, int16_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u16,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u32_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 4 x i32> poison, i32 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[DOTSPLATINSERT]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z20test_svsqadd_n_u32_mu10__SVBool_tu12__SVUint32_ti(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 4 x i32> poison, i32 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[DOTSPLATINSERT]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svsqadd_n_u32_m(svbool_t pg, svuint32_t op1, int32_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u32,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u64_m(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z20test_svsqadd_n_u64_mu10__SVBool_tu12__SVUint64_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svuint64_t test_svsqadd_n_u64_m(svbool_t pg, svuint64_t op1, int64_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u64,_m,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u8_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = select <vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z17test_svsqadd_u8_zu10__SVBool_tu11__SVUint8_tu10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = select <vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
svuint8_t test_svsqadd_u8_z(svbool_t pg, svuint8_t op1, svint8_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u8,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u16_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svsqadd_u16_zu10__SVBool_tu12__SVUint16_tu11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svuint16_t test_svsqadd_u16_z(svbool_t pg, svuint16_t op1, svint16_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u16,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u32_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svsqadd_u32_zu10__SVBool_tu12__SVUint32_tu11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svsqadd_u32_z(svbool_t pg, svuint32_t op1, svint32_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u32,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u64_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[TMP1]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z18test_svsqadd_u64_zu10__SVBool_tu12__SVUint64_tu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[TMP1]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svsqadd_u64_z(svbool_t pg, svuint64_t op1, svint64_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u64,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u8_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 16 x i8> poison, i8 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 16 x i8> [[DOTSPLATINSERT]], <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP0:%.*]] = select <vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z19test_svsqadd_n_u8_zu10__SVBool_tu11__SVUint8_ta(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 16 x i8> poison, i8 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 16 x i8> [[DOTSPLATINSERT]], <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = select <vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG]], <vscale x 16 x i8> [[TMP0]], <vscale x 16 x i8> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP1]]
//
svuint8_t test_svsqadd_n_u8_z(svbool_t pg, svuint8_t op1, int8_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u8,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u16_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 8 x i16> poison, i16 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 8 x i16> [[DOTSPLATINSERT]], <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z20test_svsqadd_n_u16_zu10__SVBool_tu12__SVUint16_ts(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 8 x i16> poison, i16 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 8 x i16> [[DOTSPLATINSERT]], <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[TMP1]], <vscale x 8 x i16> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP2]]
//
svuint16_t test_svsqadd_n_u16_z(svbool_t pg, svuint16_t op1, int16_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u16,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u32_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 4 x i32> poison, i32 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[DOTSPLATINSERT]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z20test_svsqadd_n_u32_zu10__SVBool_tu12__SVUint32_ti(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 4 x i32> poison, i32 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[DOTSPLATINSERT]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP2]]
//
svuint32_t test_svsqadd_n_u32_z(svbool_t pg, svuint32_t op1, int32_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u32,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u64_z(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> zeroinitializer
// CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[TMP1]], <vscale x 2 x i64> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
// CPP-CHECK-LABEL: @_Z20test_svsqadd_n_u64_zu10__SVBool_tu12__SVUint64_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = select <vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP2:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[TMP1]], <vscale x 2 x i64> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP2]]
//
svuint64_t test_svsqadd_n_u64_z(svbool_t pg, svuint64_t op1, int64_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u64,_z,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u8_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z17test_svsqadd_u8_xu10__SVBool_tu11__SVUint8_tu10__SVInt8_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svsqadd_u8_x(svbool_t pg, svuint8_t op1, svint8_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u8,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u16_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svsqadd_u16_xu10__SVBool_tu12__SVUint16_tu11__SVInt16_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svsqadd_u16_x(svbool_t pg, svuint16_t op1, svint16_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u16,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u32_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svsqadd_u32_xu10__SVBool_tu12__SVUint32_tu11__SVInt32_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svsqadd_u32_x(svbool_t pg, svuint32_t op1, svint32_t op2)
{
  // CHECKA-LABEL: test_svsqadd_u32_x
  return SVE_ACLE_FUNC(svsqadd,_u32,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_u64_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z18test_svsqadd_u64_xu10__SVBool_tu12__SVUint64_tu11__SVInt64_t(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[OP2:%.*]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svuint64_t test_svsqadd_u64_x(svbool_t pg, svuint64_t op1, svint64_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_u64,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u8_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 16 x i8> poison, i8 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 16 x i8> [[DOTSPLATINSERT]], <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
// CPP-CHECK-LABEL: @_Z19test_svsqadd_n_u8_xu10__SVBool_tu11__SVUint8_ta(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 16 x i8> poison, i8 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 16 x i8> [[DOTSPLATINSERT]], <vscale x 16 x i8> poison, <vscale x 16 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 16 x i8> @llvm.aarch64.sve.usqadd.nxv16i8(<vscale x 16 x i1> [[PG:%.*]], <vscale x 16 x i8> [[OP1:%.*]], <vscale x 16 x i8> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 16 x i8> [[TMP0]]
//
svuint8_t test_svsqadd_n_u8_x(svbool_t pg, svuint8_t op1, int8_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u8,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u16_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 8 x i16> poison, i16 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 8 x i16> [[DOTSPLATINSERT]], <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z20test_svsqadd_n_u16_xu10__SVBool_tu12__SVUint16_ts(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 8 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv8i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 8 x i16> poison, i16 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 8 x i16> [[DOTSPLATINSERT]], <vscale x 8 x i16> poison, <vscale x 8 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 8 x i16> @llvm.aarch64.sve.usqadd.nxv8i16(<vscale x 8 x i1> [[TMP0]], <vscale x 8 x i16> [[OP1:%.*]], <vscale x 8 x i16> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 8 x i16> [[TMP1]]
//
svuint16_t test_svsqadd_n_u16_x(svbool_t pg, svuint16_t op1, int16_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u16,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u32_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 4 x i32> poison, i32 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[DOTSPLATINSERT]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z20test_svsqadd_n_u32_xu10__SVBool_tu12__SVUint32_ti(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 4 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv4i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 4 x i32> poison, i32 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[DOTSPLATINSERT]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 4 x i32> @llvm.aarch64.sve.usqadd.nxv4i32(<vscale x 4 x i1> [[TMP0]], <vscale x 4 x i32> [[OP1:%.*]], <vscale x 4 x i32> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 4 x i32> [[TMP1]]
//
svuint32_t test_svsqadd_n_u32_x(svbool_t pg, svuint32_t op1, int32_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u32,_x,)(pg, op1, op2);
}

// CHECK-LABEL: @test_svsqadd_n_u64_x(
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[DOTSPLAT]])
// CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
// CPP-CHECK-LABEL: @_Z20test_svsqadd_n_u64_xu10__SVBool_tu12__SVUint64_tl(
// CPP-CHECK-NEXT:  entry:
// CPP-CHECK-NEXT:    [[TMP0:%.*]] = tail call <vscale x 2 x i1> @llvm.aarch64.sve.convert.from.svbool.nxv2i1(<vscale x 16 x i1> [[PG:%.*]])
// CPP-CHECK-NEXT:    [[DOTSPLATINSERT:%.*]] = insertelement <vscale x 2 x i64> poison, i64 [[OP2:%.*]], i64 0
// CPP-CHECK-NEXT:    [[DOTSPLAT:%.*]] = shufflevector <vscale x 2 x i64> [[DOTSPLATINSERT]], <vscale x 2 x i64> poison, <vscale x 2 x i32> zeroinitializer
// CPP-CHECK-NEXT:    [[TMP1:%.*]] = tail call <vscale x 2 x i64> @llvm.aarch64.sve.usqadd.nxv2i64(<vscale x 2 x i1> [[TMP0]], <vscale x 2 x i64> [[OP1:%.*]], <vscale x 2 x i64> [[DOTSPLAT]])
// CPP-CHECK-NEXT:    ret <vscale x 2 x i64> [[TMP1]]
//
svuint64_t test_svsqadd_n_u64_x(svbool_t pg, svuint64_t op1, int64_t op2)
{
  return SVE_ACLE_FUNC(svsqadd,_n_u64,_x,)(pg, op1, op2);
}
