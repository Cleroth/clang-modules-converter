; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt  -passes='loop(loop-deletion),loop-vectorize' -force-vector-width=4  -force-vector-interleave=1 -S %s | FileCheck %s

; Note: loop-deletion is needed to populate SCEV block dispositions.

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @test_pr63368(i1 %c, ptr %A) {
; CHECK-LABEL: define void @test_pr63368
; CHECK-SAME: (i1 [[C:%.*]], ptr [[A:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[VECTOR_BODY]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, ptr [[A]], align 4
; CHECK-NEXT:    [[INDEX_NEXT]] = add nuw i32 [[INDEX]], 4
; CHECK-NEXT:    [[TMP1:%.*]] = icmp eq i32 [[INDEX_NEXT]], 100
; CHECK-NEXT:    br i1 [[TMP1]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    br i1 true, label [[EXIT_1:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i32 [ 100, [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[LOOP_1_HEADER:%.*]]
; CHECK:       loop.1.header:
; CHECK-NEXT:    [[IV_1:%.*]] = phi i32 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IV_1_NEXT:%.*]], [[LOOP_1_LATCH:%.*]] ]
; CHECK-NEXT:    [[L:%.*]] = load i32, ptr [[A]], align 4
; CHECK-NEXT:    br i1 [[C]], label [[LOOP_1_LATCH]], label [[LOOP_1_LATCH]]
; CHECK:       loop.1.latch:
; CHECK-NEXT:    [[L_LCSSA:%.*]] = phi i32 [ [[L]], [[LOOP_1_HEADER]] ], [ [[L]], [[LOOP_1_HEADER]] ]
; CHECK-NEXT:    [[IV_1_NEXT]] = add nuw nsw i32 [[IV_1]], 1
; CHECK-NEXT:    [[EC_1:%.*]] = icmp eq i32 [[IV_1_NEXT]], 100
; CHECK-NEXT:    br i1 [[EC_1]], label [[EXIT_1]], label [[LOOP_1_HEADER]], !llvm.loop [[LOOP3:![0-9]+]]
; CHECK:       exit.1:
; CHECK-NEXT:    [[L_LCSSA_LCSSA:%.*]] = phi i32 [ [[L_LCSSA]], [[LOOP_1_LATCH]] ], [ [[TMP0]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    [[SMAX1:%.*]] = call i32 @llvm.smax.i32(i32 [[L_LCSSA_LCSSA]], i32 -1)
; CHECK-NEXT:    [[TMP2:%.*]] = add i32 [[SMAX1]], 2
; CHECK-NEXT:    [[MIN_ITERS_CHECK:%.*]] = icmp ult i32 [[TMP2]], 4
; CHECK-NEXT:    br i1 [[MIN_ITERS_CHECK]], label [[SCALAR_PH3:%.*]], label [[VECTOR_SCEVCHECK:%.*]]
; CHECK:       vector.scevcheck:
; CHECK-NEXT:    [[SMAX:%.*]] = call i32 @llvm.smax.i32(i32 [[L_LCSSA_LCSSA]], i32 -1)
; CHECK-NEXT:    [[TMP3:%.*]] = add i32 [[SMAX]], 1
; CHECK-NEXT:    [[TMP4:%.*]] = trunc i32 [[TMP3]] to i8
; CHECK-NEXT:    [[TMP5:%.*]] = icmp slt i8 [[TMP4]], 0
; CHECK-NEXT:    [[TMP6:%.*]] = icmp ugt i32 [[TMP3]], 255
; CHECK-NEXT:    [[TMP7:%.*]] = or i1 [[TMP5]], [[TMP6]]
; CHECK-NEXT:    [[TMP8:%.*]] = trunc i32 [[TMP3]] to i8
; CHECK-NEXT:    [[TMP9:%.*]] = add i8 1, [[TMP8]]
; CHECK-NEXT:    [[TMP10:%.*]] = icmp slt i8 [[TMP9]], 1
; CHECK-NEXT:    [[TMP11:%.*]] = icmp ugt i32 [[TMP3]], 255
; CHECK-NEXT:    [[TMP12:%.*]] = or i1 [[TMP10]], [[TMP11]]
; CHECK-NEXT:    [[TMP13:%.*]] = or i1 [[TMP7]], [[TMP12]]
; CHECK-NEXT:    br i1 [[TMP13]], label [[SCALAR_PH3]], label [[VECTOR_PH4:%.*]]
; CHECK:       vector.ph4:
; CHECK-NEXT:    [[N_MOD_VF:%.*]] = urem i32 [[TMP2]], 4
; CHECK-NEXT:    [[N_VEC:%.*]] = sub i32 [[TMP2]], [[N_MOD_VF]]
; CHECK-NEXT:    [[IND_END:%.*]] = trunc i32 [[N_VEC]] to i8
; CHECK-NEXT:    br label [[VECTOR_BODY7:%.*]]
; CHECK:       vector.body6:
; CHECK-NEXT:    [[INDEX8:%.*]] = phi i32 [ 0, [[VECTOR_PH4]] ], [ [[INDEX_NEXT9:%.*]], [[VECTOR_BODY7]] ]
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = trunc i32 [[INDEX8]] to i8
; CHECK-NEXT:    [[TMP14:%.*]] = add i8 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP15:%.*]] = add i8 [[TMP14]], 1
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr i8, ptr [[A]], i8 [[TMP15]]
; CHECK-NEXT:    [[TMP17:%.*]] = getelementptr i8, ptr [[TMP16]], i32 0
; CHECK-NEXT:    store <4 x i8> zeroinitializer, ptr [[TMP17]], align 1
; CHECK-NEXT:    [[INDEX_NEXT9]] = add nuw i32 [[INDEX8]], 4
; CHECK-NEXT:    [[TMP18:%.*]] = icmp eq i32 [[INDEX_NEXT9]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[TMP18]], label [[MIDDLE_BLOCK2:%.*]], label [[VECTOR_BODY7]], !llvm.loop [[LOOP4:![0-9]+]]
; CHECK:       middle.block2:
; CHECK-NEXT:    [[CMP_N6:%.*]] = icmp eq i32 [[TMP2]], [[N_VEC]]
; CHECK-NEXT:    br i1 [[CMP_N6]], label [[EXIT_2:%.*]], label [[SCALAR_PH3]]
; CHECK:       scalar.ph3:
; CHECK-NEXT:    [[BC_RESUME_VAL5:%.*]] = phi i8 [ [[IND_END]], [[MIDDLE_BLOCK2]] ], [ 0, [[EXIT_1]] ], [ 0, [[VECTOR_SCEVCHECK]] ]
; CHECK-NEXT:    br label [[LOOP_2:%.*]]
; CHECK:       loop.2:
; CHECK-NEXT:    [[IV_2:%.*]] = phi i8 [ [[BC_RESUME_VAL5]], [[SCALAR_PH3]] ], [ [[IV_2_NEXT:%.*]], [[LOOP_2]] ]
; CHECK-NEXT:    [[IV_2_NEXT]] = add i8 [[IV_2]], 1
; CHECK-NEXT:    [[GEP_A:%.*]] = getelementptr i8, ptr [[A]], i8 [[IV_2_NEXT]]
; CHECK-NEXT:    store i8 0, ptr [[GEP_A]], align 1
; CHECK-NEXT:    [[IV_2_SEXT:%.*]] = sext i8 [[IV_2]] to i32
; CHECK-NEXT:    [[EC_2:%.*]] = icmp sge i32 [[L_LCSSA_LCSSA]], [[IV_2_SEXT]]
; CHECK-NEXT:    br i1 [[EC_2]], label [[LOOP_2]], label [[EXIT_2]], !llvm.loop [[LOOP5:![0-9]+]]
; CHECK:       exit.2:
; CHECK-NEXT:    ret void
;

entry:
  br label %loop.1.header

loop.1.header:
  %iv.1 = phi i32 [ 0, %entry ], [ %iv.1.next, %loop.1.latch ]
  %l = load i32, ptr %A
  br i1 %c, label %loop.1.latch, label %loop.1.latch

loop.1.latch:
  %l.lcssa = phi i32 [ %l, %loop.1.header ], [ %l, %loop.1.header ]
  %iv.1.next = add nuw nsw i32 %iv.1, 1
  %ec.1 = icmp eq i32 %iv.1.next, 100
  br i1 %ec.1, label %exit.1, label %loop.1.header

exit.1:
  %l.lcssa.lcssa = phi i32 [ %l.lcssa, %loop.1.latch ]
  br label %loop.2

loop.2:
  %iv.2 = phi i8 [ 0, %exit.1 ], [ %iv.2.next, %loop.2 ]
  %iv.2.next = add i8 %iv.2, 1
  %gep.A = getelementptr i8, ptr %A, i8 %iv.2.next
  store i8 0, ptr %gep.A
  %iv.2.sext = sext i8 %iv.2 to i32
  %ec.2 = icmp sge i32 %l.lcssa.lcssa, %iv.2.sext
  br i1 %ec.2, label %loop.2, label %exit.2

exit.2:
  ret void
}
