; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt -passes=loop-unroll,simplifycfg -S -mtriple aarch64 %s | FileCheck %s

;; This test contains IR similar to what would be generated when SVE ACLE
;; routines are used with fixed-width vector types -- lots of subvector inserts
;; and extracts that are effectively just bitcasts since the types are the
;; same at a given SVE bit size. We want to make sure that they are not a
;; barrier to unrolling simple loops with a fixed trip count which could be
;; further optimized.

define void @test_ins_ext_cost(ptr readonly %a, ptr readonly %b, ptr readonly %c, ptr noalias %d) #0 {
; CHECK-LABEL: define void @test_ins_ext_cost(
; CHECK-SAME: ptr readonly [[A:%.*]], ptr readonly [[B:%.*]], ptr readonly [[C:%.*]], ptr noalias [[D:%.*]]) #[[ATTR0:[0-9]+]] {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[LOAD_A:%.*]] = load <8 x float>, ptr [[A]], align 16
; CHECK-NEXT:    [[LOAD_B:%.*]] = load <8 x float>, ptr [[B]], align 16
; CHECK-NEXT:    [[LOAD_C:%.*]] = load <8 x float>, ptr [[C]], align 16
; CHECK-NEXT:    [[CAST_SCALABLE_B:%.*]] = tail call <vscale x 4 x float> @llvm.vector.insert.nxv4f32.v8f32(<vscale x 4 x float> undef, <8 x float> [[LOAD_B]], i64 0)
; CHECK-NEXT:    [[CAST_SCALABLE_C:%.*]] = tail call <vscale x 4 x float> @llvm.vector.insert.nxv4f32.v8f32(<vscale x 4 x float> undef, <8 x float> [[LOAD_C]], i64 0)
; CHECK-NEXT:    [[ADD:%.*]] = fadd <vscale x 4 x float> [[CAST_SCALABLE_B]], [[CAST_SCALABLE_C]]
; CHECK-NEXT:    [[CAST_SCALABLE_A:%.*]] = tail call <vscale x 4 x float> @llvm.vector.insert.nxv4f32.v8f32(<vscale x 4 x float> undef, <8 x float> [[LOAD_A]], i64 0)
; CHECK-NEXT:    [[MUL:%.*]] = fmul <vscale x 4 x float> [[CAST_SCALABLE_A]], [[ADD]]
; CHECK-NEXT:    [[CAST_FIXED_D:%.*]] = tail call <8 x float> @llvm.vector.extract.v8f32.nxv4f32(<vscale x 4 x float> [[MUL]], i64 0)
; CHECK-NEXT:    store <8 x float> [[CAST_FIXED_D]], ptr [[D]], align 16
; CHECK-NEXT:    [[GEP_A_1:%.*]] = getelementptr inbounds <8 x float>, ptr [[A]], i64 1
; CHECK-NEXT:    [[LOAD_A_1:%.*]] = load <8 x float>, ptr [[GEP_A_1]], align 16
; CHECK-NEXT:    [[GEP_B_1:%.*]] = getelementptr inbounds <8 x float>, ptr [[B]], i64 1
; CHECK-NEXT:    [[LOAD_B_1:%.*]] = load <8 x float>, ptr [[GEP_B_1]], align 16
; CHECK-NEXT:    [[GEP_C_1:%.*]] = getelementptr inbounds <8 x float>, ptr [[C]], i64 1
; CHECK-NEXT:    [[LOAD_C_1:%.*]] = load <8 x float>, ptr [[GEP_C_1]], align 16
; CHECK-NEXT:    [[CAST_SCALABLE_B_1:%.*]] = tail call <vscale x 4 x float> @llvm.vector.insert.nxv4f32.v8f32(<vscale x 4 x float> undef, <8 x float> [[LOAD_B_1]], i64 0)
; CHECK-NEXT:    [[CAST_SCALABLE_C_1:%.*]] = tail call <vscale x 4 x float> @llvm.vector.insert.nxv4f32.v8f32(<vscale x 4 x float> undef, <8 x float> [[LOAD_C_1]], i64 0)
; CHECK-NEXT:    [[ADD_1:%.*]] = fadd <vscale x 4 x float> [[CAST_SCALABLE_B_1]], [[CAST_SCALABLE_C_1]]
; CHECK-NEXT:    [[CAST_SCALABLE_A_1:%.*]] = tail call <vscale x 4 x float> @llvm.vector.insert.nxv4f32.v8f32(<vscale x 4 x float> undef, <8 x float> [[LOAD_A_1]], i64 0)
; CHECK-NEXT:    [[MUL_1:%.*]] = fmul <vscale x 4 x float> [[CAST_SCALABLE_A_1]], [[ADD_1]]
; CHECK-NEXT:    [[CAST_FIXED_D_1:%.*]] = tail call <8 x float> @llvm.vector.extract.v8f32.nxv4f32(<vscale x 4 x float> [[MUL_1]], i64 0)
; CHECK-NEXT:    [[GEP_D_1:%.*]] = getelementptr inbounds <8 x float>, ptr [[D]], i64 0, i64 1
; CHECK-NEXT:    store <8 x float> [[CAST_FIXED_D_1]], ptr [[GEP_D_1]], align 16
; CHECK-NEXT:    ret void
;
entry:
  br label %for.body

for.body:
  %exit.cond = phi i1 [ true, %entry ], [ false, %for.body ]
  %iv = phi i64 [ 0, %entry ], [ 1, %for.body ]
  %gep.a = getelementptr inbounds <8 x float>, ptr %a, i64 %iv
  %load.a = load <8 x float>, ptr %gep.a, align 16
  %gep.b = getelementptr inbounds <8 x float>, ptr %b, i64 %iv
  %load.b = load <8 x float>, ptr %gep.b, align 16
  %gep.c = getelementptr inbounds <8 x float>, ptr %c, i64 %iv
  %load.c = load <8 x float>, ptr %gep.c, align 16
  %cast.scalable.b = tail call <vscale x 4 x float> @llvm.vector.insert.nxv4f32.v8f32(<vscale x 4 x float> undef, <8 x float> %load.b, i64 0)
  %cast.scalable.c = tail call <vscale x 4 x float> @llvm.vector.insert.nxv4f32.v8f32(<vscale x 4 x float> undef, <8 x float> %load.c, i64 0)
  %add = fadd <vscale x 4 x float> %cast.scalable.b, %cast.scalable.c
  %cast.scalable.a = tail call <vscale x 4 x float> @llvm.vector.insert.nxv4f32.v8f32(<vscale x 4 x float> undef, <8 x float> %load.a, i64 0)
  %mul = fmul <vscale x 4 x float> %cast.scalable.a, %add
  %cast.fixed.d = tail call <8 x float> @llvm.vector.extract.v8f32.nxv4f32(<vscale x 4 x float> %mul, i64 0)
  %gep.d = getelementptr inbounds <8 x float>, ptr %d, i64 0, i64 %iv
  store <8 x float> %cast.fixed.d, ptr %gep.d, align 16
  br i1 %exit.cond, label %for.body, label %exit

exit:
  ret void
}

attributes #0 = { "target-features"="+sve" vscale_range(2, 16) }
