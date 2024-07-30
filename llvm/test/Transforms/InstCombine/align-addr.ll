; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s
target datalayout = "E-p:64:64:64-p1:32:32:32-a0:0:8-f32:32:32-f64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-v64:64:64-v128:128:128"

; Instcombine should be able to prove vector alignment in the
; presence of a few mild address computation tricks.

define void @test0(ptr %b, i64 %n, i64 %u, i64 %y) nounwind  {
; CHECK-LABEL: @test0(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[C:%.*]] = ptrtoint ptr [[B:%.*]] to i64
; CHECK-NEXT:    [[D:%.*]] = and i64 [[C]], -16
; CHECK-NEXT:    [[E:%.*]] = inttoptr i64 [[D]] to ptr
; CHECK-NEXT:    [[V:%.*]] = shl i64 [[U:%.*]], 1
; CHECK-NEXT:    [[Z:%.*]] = and i64 [[Y:%.*]], -2
; CHECK-NEXT:    [[T1421:%.*]] = icmp eq i64 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[T1421]], label [[RETURN:%.*]], label [[BB:%.*]]
; CHECK:       bb:
; CHECK-NEXT:    [[I:%.*]] = phi i64 [ [[INDVAR_NEXT:%.*]], [[BB]] ], [ 20, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[J:%.*]] = mul i64 [[I]], [[V]]
; CHECK-NEXT:    [[TMP0:%.*]] = getelementptr double, ptr [[E]], i64 [[J]]
; CHECK-NEXT:    [[T8:%.*]] = getelementptr double, ptr [[TMP0]], i64 [[Z]]
; CHECK-NEXT:    store <2 x double> zeroinitializer, ptr [[T8]], align 8
; CHECK-NEXT:    [[INDVAR_NEXT]] = add i64 [[I]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[INDVAR_NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[RETURN]], label [[BB]]
; CHECK:       return:
; CHECK-NEXT:    ret void
;
entry:
  %c = ptrtoint ptr %b to i64
  %d = and i64 %c, -16
  %e = inttoptr i64 %d to ptr
  %v = mul i64 %u, 2
  %z = and i64 %y, -2
  %t1421 = icmp eq i64 %n, 0
  br i1 %t1421, label %return, label %bb

bb:
  %i = phi i64 [ %indvar.next, %bb ], [ 20, %entry ]
  %j = mul i64 %i, %v
  %h = add i64 %j, %z
  %t8 = getelementptr double, ptr %e, i64 %h
  store <2 x double><double 0.0, double 0.0>, ptr %t8, align 8
  %indvar.next = add i64 %i, 1
  %exitcond = icmp eq i64 %indvar.next, %n
  br i1 %exitcond, label %return, label %bb

return:
  ret void
}

; When we see a unaligned load from an insufficiently aligned global or
; alloca, increase the alignment of the load, turning it into an aligned load.

@GLOBAL = internal global [4 x i32] zeroinitializer

define <16 x i8> @test1(<2 x i64> %x) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[TMP:%.*]] = load <16 x i8>, ptr @GLOBAL, align 1
; CHECK-NEXT:    ret <16 x i8> [[TMP]]
;
entry:
  %tmp = load <16 x i8>, ptr @GLOBAL, align 1
  ret <16 x i8> %tmp
}

@GLOBAL_as1 = internal addrspace(1) global [4 x i32] zeroinitializer

define <16 x i8> @test1_as1(<2 x i64> %x) {
; CHECK-LABEL: @test1_as1(
; CHECK-NEXT:    [[TMP:%.*]] = load <16 x i8>, ptr addrspace(1) @GLOBAL_as1, align 1
; CHECK-NEXT:    ret <16 x i8> [[TMP]]
;
  %tmp = load <16 x i8>, ptr addrspace(1) @GLOBAL_as1, align 1
  ret <16 x i8> %tmp
}

@GLOBAL_as1_gep = internal addrspace(1) global [8 x i32] zeroinitializer

define <16 x i8> @test1_as1_gep(<2 x i64> %x) {
; CHECK-LABEL: @test1_as1_gep(
; CHECK-NEXT:    [[TMP:%.*]] = load <16 x i8>, ptr addrspace(1) getelementptr inbounds (i8, ptr addrspace(1) @GLOBAL_as1_gep, i32 16), align 1
; CHECK-NEXT:    ret <16 x i8> [[TMP]]
;
  %tmp = load <16 x i8>, ptr addrspace(1) getelementptr ([8 x i32], ptr addrspace(1) @GLOBAL_as1_gep, i16 0, i16 4), align 1
  ret <16 x i8> %tmp
}


; When a load or store lacks an explicit alignment, add one.

define double @test2(ptr %p, double %n) nounwind {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    [[T:%.*]] = load double, ptr [[P:%.*]], align 8
; CHECK-NEXT:    store double [[N:%.*]], ptr [[P]], align 8
; CHECK-NEXT:    ret double [[T]]
;
  %t = load double, ptr %p
  store double %n, ptr %p
  ret double %t
}

declare void @llvm.memset.p0.i64(ptr nocapture, i8, i64, i1) nounwind

declare void @use(ptr)

%struct.s = type { i32, i32, i32, i32 }

define void @test3(ptr sret(%struct.s) %a4) {
; Check that the alignment is bumped up the alignment of the sret type.
; CHECK-LABEL: @test3(
; CHECK-NEXT:    call void @llvm.memset.p0.i64(ptr noundef nonnull align 4 dereferenceable(16) [[A4:%.*]], i8 0, i64 16, i1 false)
; CHECK-NEXT:    call void @use(ptr [[A4]])
; CHECK-NEXT:    ret void
;
  call void @llvm.memset.p0.i64(ptr %a4, i8 0, i64 16, i1 false)
  call void @use(ptr %a4)
  ret void
}

declare ptr @llvm.ptrmask.p0.i64(ptr, i64)

define <16 x i8> @ptrmask_align_unknown_ptr_align1(ptr align 1 %ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_align_unknown_ptr_align1(
; CHECK-NEXT:    [[ALIGNED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR:%.*]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD:%.*]] = load <16 x i8>, ptr [[ALIGNED]], align 1
; CHECK-NEXT:    ret <16 x i8> [[LOAD]]
;
  %aligned = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 %mask)
  %load = load <16 x i8>, ptr %aligned, align 1
  ret <16 x i8> %load
}

define <16 x i8> @ptrmask_align_unknown_ptr_align8(ptr align 8 %ptr, i64 %mask) {
; CHECK-LABEL: @ptrmask_align_unknown_ptr_align8(
; CHECK-NEXT:    [[ALIGNED:%.*]] = call align 8 ptr @llvm.ptrmask.p0.i64(ptr [[PTR:%.*]], i64 [[MASK:%.*]])
; CHECK-NEXT:    [[LOAD:%.*]] = load <16 x i8>, ptr [[ALIGNED]], align 1
; CHECK-NEXT:    ret <16 x i8> [[LOAD]]
;
  %aligned = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 %mask)
  %load = load <16 x i8>, ptr %aligned, align 1
  ret <16 x i8> %load
}

; Increase load align from 1 to 2
define <16 x i8> @ptrmask_align2_ptr_align1(ptr align 1 %ptr) {
; CHECK-LABEL: @ptrmask_align2_ptr_align1(
; CHECK-NEXT:    [[ALIGNED:%.*]] = call align 2 ptr @llvm.ptrmask.p0.i64(ptr [[PTR:%.*]], i64 -2)
; CHECK-NEXT:    [[LOAD:%.*]] = load <16 x i8>, ptr [[ALIGNED]], align 1
; CHECK-NEXT:    ret <16 x i8> [[LOAD]]
;
  %aligned = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -2)
  %load = load <16 x i8>, ptr %aligned, align 1
  ret <16 x i8> %load
}

; Increase load align from 1 to 4
define <16 x i8> @ptrmask_align4_ptr_align1(ptr align 1 %ptr) {
; CHECK-LABEL: @ptrmask_align4_ptr_align1(
; CHECK-NEXT:    [[ALIGNED:%.*]] = call align 4 ptr @llvm.ptrmask.p0.i64(ptr [[PTR:%.*]], i64 -4)
; CHECK-NEXT:    [[LOAD:%.*]] = load <16 x i8>, ptr [[ALIGNED]], align 1
; CHECK-NEXT:    ret <16 x i8> [[LOAD]]
;
  %aligned = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -4)
  %load = load <16 x i8>, ptr %aligned, align 1
  ret <16 x i8> %load
}

; Increase load align from 1 to 8
define <16 x i8> @ptrmask_align8_ptr_align1(ptr align 1 %ptr) {
; CHECK-LABEL: @ptrmask_align8_ptr_align1(
; CHECK-NEXT:    [[ALIGNED:%.*]] = call align 8 ptr @llvm.ptrmask.p0.i64(ptr [[PTR:%.*]], i64 -8)
; CHECK-NEXT:    [[LOAD:%.*]] = load <16 x i8>, ptr [[ALIGNED]], align 1
; CHECK-NEXT:    ret <16 x i8> [[LOAD]]
;
  %aligned = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -8)
  %load = load <16 x i8>, ptr %aligned, align 1
  ret <16 x i8> %load
}

; Underlying alignment already the same as forced alignment by ptrmask
define <16 x i8> @ptrmask_align8_ptr_align8(ptr align 8 %ptr) {
; CHECK-LABEL: @ptrmask_align8_ptr_align8(
; CHECK-NEXT:    [[LOAD:%.*]] = load <16 x i8>, ptr [[PTR:%.*]], align 1
; CHECK-NEXT:    ret <16 x i8> [[LOAD]]
;
  %aligned = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -8)
  %load = load <16 x i8>, ptr %aligned, align 1
  ret <16 x i8> %load
}

; Underlying alignment greater than alignment forced by ptrmask
define <16 x i8> @ptrmask_align8_ptr_align16(ptr align 16 %ptr) {
; CHECK-LABEL: @ptrmask_align8_ptr_align16(
; CHECK-NEXT:    [[LOAD:%.*]] = load <16 x i8>, ptr [[PTR:%.*]], align 1
; CHECK-NEXT:    ret <16 x i8> [[LOAD]]
;
  %aligned = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -8)
  %load = load <16 x i8>, ptr %aligned, align 1
  ret <16 x i8> %load
}
