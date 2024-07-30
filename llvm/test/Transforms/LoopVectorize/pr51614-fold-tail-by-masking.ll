; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=loop-vectorize -force-vector-width=2 -enable-masked-interleaved-mem-accesses -enable-interleaved-mem-accesses -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"

@A = external dso_local local_unnamed_addr global [40 x [4 x i16]], align 1

; Make sure interleave group of loads with gap is considered masked with fold-tail,
; and forbidden with reverse access.

define dso_local i16 @reverse_interleave_load_fold_mask() optsize {
; CHECK-LABEL: @reverse_interleave_load_fold_mask(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br i1 false, label [[SCALAR_PH:%.*]], label [[VECTOR_PH:%.*]]
; CHECK:       vector.ph:
; CHECK-NEXT:    br label [[VECTOR_BODY:%.*]]
; CHECK:       vector.body:
; CHECK-NEXT:    [[INDEX:%.*]] = phi i32 [ 0, [[VECTOR_PH]] ], [ [[INDEX_NEXT:%.*]], [[PRED_LOAD_CONTINUE4:%.*]] ]
; CHECK-NEXT:    [[VEC_PHI:%.*]] = phi <2 x i16> [ zeroinitializer, [[VECTOR_PH]] ], [ [[TMP25:%.*]], [[PRED_LOAD_CONTINUE4]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = trunc i32 [[INDEX]] to i16
; CHECK-NEXT:    [[OFFSET_IDX:%.*]] = sub i16 41, [[TMP0]]
; CHECK-NEXT:    [[BROADCAST_SPLATINSERT1:%.*]] = insertelement <2 x i32> poison, i32 [[INDEX]], i64 0
; CHECK-NEXT:    [[BROADCAST_SPLAT2:%.*]] = shufflevector <2 x i32> [[BROADCAST_SPLATINSERT1]], <2 x i32> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[VEC_IV:%.*]] = add <2 x i32> [[BROADCAST_SPLAT2]], <i32 0, i32 1>
; CHECK-NEXT:    [[TMP1:%.*]] = icmp ule <2 x i32> [[VEC_IV]], <i32 40, i32 40>
; CHECK-NEXT:    [[TMP2:%.*]] = extractelement <2 x i1> [[TMP1]], i32 0
; CHECK-NEXT:    br i1 [[TMP2]], label [[PRED_LOAD_IF:%.*]], label [[PRED_LOAD_CONTINUE:%.*]]
; CHECK:       pred.load.if:
; CHECK-NEXT:    [[TMP3:%.*]] = add i16 [[OFFSET_IDX]], 0
; CHECK-NEXT:    [[TMP4:%.*]] = add nsw i16 [[TMP3]], -1
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr inbounds [40 x [4 x i16]], ptr @A, i16 0, i16 [[TMP4]], i16 0
; CHECK-NEXT:    [[TMP6:%.*]] = load i16, ptr [[TMP5]], align 1
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <2 x i16> poison, i16 [[TMP6]], i32 0
; CHECK-NEXT:    [[TMP8:%.*]] = getelementptr inbounds [40 x [4 x i16]], ptr @A, i16 0, i16 [[TMP4]], i16 3
; CHECK-NEXT:    [[TMP9:%.*]] = load i16, ptr [[TMP8]], align 1
; CHECK-NEXT:    [[TMP10:%.*]] = insertelement <2 x i16> poison, i16 [[TMP9]], i32 0
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE]]
; CHECK:       pred.load.continue:
; CHECK-NEXT:    [[TMP11:%.*]] = phi <2 x i16> [ poison, [[VECTOR_BODY]] ], [ [[TMP7]], [[PRED_LOAD_IF]] ]
; CHECK-NEXT:    [[TMP12:%.*]] = phi <2 x i16> [ poison, [[VECTOR_BODY]] ], [ [[TMP10]], [[PRED_LOAD_IF]] ]
; CHECK-NEXT:    [[TMP13:%.*]] = extractelement <2 x i1> [[TMP1]], i32 1
; CHECK-NEXT:    br i1 [[TMP13]], label [[PRED_LOAD_IF3:%.*]], label [[PRED_LOAD_CONTINUE4]]
; CHECK:       pred.load.if1:
; CHECK-NEXT:    [[TMP14:%.*]] = add i16 [[OFFSET_IDX]], -1
; CHECK-NEXT:    [[TMP15:%.*]] = add nsw i16 [[TMP14]], -1
; CHECK-NEXT:    [[TMP16:%.*]] = getelementptr inbounds [40 x [4 x i16]], ptr @A, i16 0, i16 [[TMP15]], i16 0
; CHECK-NEXT:    [[TMP17:%.*]] = load i16, ptr [[TMP16]], align 1
; CHECK-NEXT:    [[TMP18:%.*]] = insertelement <2 x i16> [[TMP11]], i16 [[TMP17]], i32 1
; CHECK-NEXT:    [[TMP19:%.*]] = getelementptr inbounds [40 x [4 x i16]], ptr @A, i16 0, i16 [[TMP15]], i16 3
; CHECK-NEXT:    [[TMP20:%.*]] = load i16, ptr [[TMP19]], align 1
; CHECK-NEXT:    [[TMP21:%.*]] = insertelement <2 x i16> [[TMP12]], i16 [[TMP20]], i32 1
; CHECK-NEXT:    br label [[PRED_LOAD_CONTINUE4]]
; CHECK:       pred.load.continue2:
; CHECK-NEXT:    [[TMP22:%.*]] = phi <2 x i16> [ [[TMP11]], [[PRED_LOAD_CONTINUE]] ], [ [[TMP18]], [[PRED_LOAD_IF3]] ]
; CHECK-NEXT:    [[TMP23:%.*]] = phi <2 x i16> [ [[TMP12]], [[PRED_LOAD_CONTINUE]] ], [ [[TMP21]], [[PRED_LOAD_IF3]] ]
; CHECK-NEXT:    [[TMP24:%.*]] = add nsw <2 x i16> [[TMP22]], [[TMP23]]
; CHECK-NEXT:    [[TMP25]] = add <2 x i16> [[VEC_PHI]], [[TMP24]]
; CHECK-NEXT:    [[TMP26:%.*]] = select <2 x i1> [[TMP1]], <2 x i16> [[TMP25]], <2 x i16> [[VEC_PHI]]
; CHECK-NEXT:    [[INDEX_NEXT]] = add i32 [[INDEX]], 2
; CHECK-NEXT:    [[TMP27:%.*]] = icmp eq i32 [[INDEX_NEXT]], 42
; CHECK-NEXT:    br i1 [[TMP27]], label [[MIDDLE_BLOCK:%.*]], label [[VECTOR_BODY]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       middle.block:
; CHECK-NEXT:    [[TMP28:%.*]] = call i16 @llvm.vector.reduce.add.v2i16(<2 x i16> [[TMP26]])
; CHECK-NEXT:    br i1 true, label [[EXIT:%.*]], label [[SCALAR_PH]]
; CHECK:       scalar.ph:
; CHECK-NEXT:    [[BC_RESUME_VAL:%.*]] = phi i16 [ -1, [[MIDDLE_BLOCK]] ], [ 41, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[BC_MERGE_RDX:%.*]] = phi i16 [ [[TMP28]], [[MIDDLE_BLOCK]] ], [ 0, [[ENTRY]] ]
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i16 [ [[BC_RESUME_VAL]], [[SCALAR_PH]] ], [ [[IVMINUS1:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi i16 [ [[BC_MERGE_RDX]], [[SCALAR_PH]] ], [ [[PREVSUM:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[IVMINUS1]] = add nsw i16 [[IV]], -1
; CHECK-NEXT:    [[GEPA0:%.*]] = getelementptr inbounds [40 x [4 x i16]], ptr @A, i16 0, i16 [[IVMINUS1]], i16 0
; CHECK-NEXT:    [[TMP29:%.*]] = load i16, ptr [[GEPA0]], align 1
; CHECK-NEXT:    [[GEPA3:%.*]] = getelementptr inbounds [40 x [4 x i16]], ptr @A, i16 0, i16 [[IVMINUS1]], i16 3
; CHECK-NEXT:    [[TMP30:%.*]] = load i16, ptr [[GEPA3]], align 1
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i16 [[TMP29]], [[TMP30]]
; CHECK-NEXT:    [[PREVSUM]] = add nsw i16 [[SUM]], [[ADD]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ugt i16 [[IV]], 1
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP]], label [[EXIT]], !llvm.loop [[LOOP2:![0-9]+]]
; CHECK:       exit:
; CHECK-NEXT:    [[PREVSUM_LCSSA:%.*]] = phi i16 [ [[PREVSUM]], [[LOOP]] ], [ [[TMP28]], [[MIDDLE_BLOCK]] ]
; CHECK-NEXT:    ret i16 [[PREVSUM_LCSSA]]
;
entry:
  br label %loop

loop:
  %iv = phi i16 [ 41, %entry ], [ %ivMinus1, %loop ]
  %sum = phi i16 [ 0, %entry ], [ %prevSum, %loop ]
  %ivMinus1 = add nsw i16 %iv, -1
  %gepA0 = getelementptr inbounds [40 x [4 x i16]], ptr @A, i16 0, i16 %ivMinus1, i16 0
  %0 = load i16, ptr %gepA0, align 1
  %gepA3 = getelementptr inbounds [40 x [4 x i16]], ptr @A, i16 0, i16 %ivMinus1, i16 3
  %1 = load i16, ptr %gepA3, align 1
  %add = add nsw i16 %0, %1
  %prevSum = add nsw i16 %sum, %add
  %cmp = icmp ugt i16 %iv, 1
  br i1 %cmp, label %loop, label %exit

exit:
  ret i16 %prevSum
}
