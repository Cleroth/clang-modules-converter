; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 5
; RUN: opt -passes=loop-distribute -enable-loop-distribute -verify-loop-info -verify-dom-info -S < %s \
; RUN:   | FileCheck %s

; Check that definitions used outside the loop are handled correctly: (1) they
; are not dropped (2) when version the loop, a phi is added to merge the value
; from the non-distributed loop and the distributed loop.
;
;   for (i = 0; i < n; i++) {
;     A[i + 1] = A[i] * B[i];
;   ==========================
;     sum += C[i];
;   }

@B = common global ptr null, align 8
@A = common global ptr null, align 8
@C = common global ptr null, align 8
@D = common global ptr null, align 8
@E = common global ptr null, align 8
@SUM = common global i32 0, align 8

define void @f() {
; CHECK-LABEL: define void @f() {
; CHECK-NEXT:  [[ENTRY:.*:]]
; CHECK-NEXT:    [[A:%.*]] = load ptr, ptr @A, align 8
; CHECK-NEXT:    [[B:%.*]] = load ptr, ptr @B, align 8
; CHECK-NEXT:    [[C:%.*]] = load ptr, ptr @C, align 8
; CHECK-NEXT:    [[D:%.*]] = load ptr, ptr @D, align 8
; CHECK-NEXT:    [[E:%.*]] = load ptr, ptr @E, align 8
; CHECK-NEXT:    br label %[[FOR_BODY_LVER_CHECK:.*]]
; CHECK:       [[FOR_BODY_LVER_CHECK]]:
; CHECK-NEXT:    [[SCEVGEP:%.*]] = getelementptr i8, ptr [[A]], i64 84
; CHECK-NEXT:    [[SCEVGEP1:%.*]] = getelementptr i8, ptr [[C]], i64 80
; CHECK-NEXT:    [[BOUND0:%.*]] = icmp ult ptr [[A]], [[SCEVGEP1]]
; CHECK-NEXT:    [[BOUND1:%.*]] = icmp ult ptr [[C]], [[SCEVGEP]]
; CHECK-NEXT:    [[FOUND_CONFLICT:%.*]] = and i1 [[BOUND0]], [[BOUND1]]
; CHECK-NEXT:    br i1 [[FOUND_CONFLICT]], label %[[FOR_BODY_PH_LVER_ORIG:.*]], label %[[FOR_BODY_PH_LDIST1:.*]]
; CHECK:       [[FOR_BODY_PH_LVER_ORIG]]:
; CHECK-NEXT:    br label %[[FOR_BODY_LVER_ORIG:.*]]
; CHECK:       [[FOR_BODY_LVER_ORIG]]:
; CHECK-NEXT:    [[IND_LVER_ORIG:%.*]] = phi i64 [ 0, %[[FOR_BODY_PH_LVER_ORIG]] ], [ [[ADD_LVER_ORIG:%.*]], %[[FOR_BODY_LVER_ORIG]] ]
; CHECK-NEXT:    [[SUM_LVER_ORIG:%.*]] = phi i32 [ 0, %[[FOR_BODY_PH_LVER_ORIG]] ], [ [[SUM_ADD_LVER_ORIG:%.*]], %[[FOR_BODY_LVER_ORIG]] ]
; CHECK-NEXT:    [[ARRAYIDXA_LVER_ORIG:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[IND_LVER_ORIG]]
; CHECK-NEXT:    [[LOADA_LVER_ORIG:%.*]] = load i32, ptr [[ARRAYIDXA_LVER_ORIG]], align 4
; CHECK-NEXT:    [[ARRAYIDXB_LVER_ORIG:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[IND_LVER_ORIG]]
; CHECK-NEXT:    [[LOADB_LVER_ORIG:%.*]] = load i32, ptr [[ARRAYIDXB_LVER_ORIG]], align 4
; CHECK-NEXT:    [[MULA_LVER_ORIG:%.*]] = mul i32 [[LOADB_LVER_ORIG]], [[LOADA_LVER_ORIG]]
; CHECK-NEXT:    [[ADD_LVER_ORIG]] = add nuw nsw i64 [[IND_LVER_ORIG]], 1
; CHECK-NEXT:    [[ARRAYIDXA_PLUS_4_LVER_ORIG:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[ADD_LVER_ORIG]]
; CHECK-NEXT:    store i32 [[MULA_LVER_ORIG]], ptr [[ARRAYIDXA_PLUS_4_LVER_ORIG]], align 4
; CHECK-NEXT:    [[ARRAYIDXC_LVER_ORIG:%.*]] = getelementptr inbounds i32, ptr [[C]], i64 [[IND_LVER_ORIG]]
; CHECK-NEXT:    [[LOADC_LVER_ORIG:%.*]] = load i32, ptr [[ARRAYIDXC_LVER_ORIG]], align 4
; CHECK-NEXT:    [[SUM_ADD_LVER_ORIG]] = add nuw nsw i32 [[SUM_LVER_ORIG]], [[LOADC_LVER_ORIG]]
; CHECK-NEXT:    [[EXITCOND_LVER_ORIG:%.*]] = icmp eq i64 [[ADD_LVER_ORIG]], 20
; CHECK-NEXT:    br i1 [[EXITCOND_LVER_ORIG]], label %[[FOR_END_LOOPEXIT:.*]], label %[[FOR_BODY_LVER_ORIG]]
; CHECK:       [[FOR_BODY_PH_LDIST1]]:
; CHECK-NEXT:    br label %[[FOR_BODY_LDIST1:.*]]
; CHECK:       [[FOR_BODY_LDIST1]]:
; CHECK-NEXT:    [[IND_LDIST1:%.*]] = phi i64 [ 0, %[[FOR_BODY_PH_LDIST1]] ], [ [[ADD_LDIST1:%.*]], %[[FOR_BODY_LDIST1]] ]
; CHECK-NEXT:    [[ARRAYIDXA_LDIST1:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[IND_LDIST1]]
; CHECK-NEXT:    [[LOADA_LDIST1:%.*]] = load i32, ptr [[ARRAYIDXA_LDIST1]], align 4, !alias.scope [[META0:![0-9]+]], !noalias [[META3:![0-9]+]]
; CHECK-NEXT:    [[ARRAYIDXB_LDIST1:%.*]] = getelementptr inbounds i32, ptr [[B]], i64 [[IND_LDIST1]]
; CHECK-NEXT:    [[LOADB_LDIST1:%.*]] = load i32, ptr [[ARRAYIDXB_LDIST1]], align 4, !alias.scope [[META5:![0-9]+]]
; CHECK-NEXT:    [[MULA_LDIST1:%.*]] = mul i32 [[LOADB_LDIST1]], [[LOADA_LDIST1]]
; CHECK-NEXT:    [[ADD_LDIST1]] = add nuw nsw i64 [[IND_LDIST1]], 1
; CHECK-NEXT:    [[ARRAYIDXA_PLUS_4_LDIST1:%.*]] = getelementptr inbounds i32, ptr [[A]], i64 [[ADD_LDIST1]]
; CHECK-NEXT:    store i32 [[MULA_LDIST1]], ptr [[ARRAYIDXA_PLUS_4_LDIST1]], align 4, !alias.scope [[META0]], !noalias [[META3]]
; CHECK-NEXT:    [[EXITCOND_LDIST1:%.*]] = icmp eq i64 [[ADD_LDIST1]], 20
; CHECK-NEXT:    br i1 [[EXITCOND_LDIST1]], label %[[FOR_BODY_PH:.*]], label %[[FOR_BODY_LDIST1]]
; CHECK:       [[FOR_BODY_PH]]:
; CHECK-NEXT:    br label %[[FOR_BODY:.*]]
; CHECK:       [[FOR_BODY]]:
; CHECK-NEXT:    [[IND:%.*]] = phi i64 [ 0, %[[FOR_BODY_PH]] ], [ [[ADD:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi i32 [ 0, %[[FOR_BODY_PH]] ], [ [[SUM_ADD:%.*]], %[[FOR_BODY]] ]
; CHECK-NEXT:    [[ADD]] = add nuw nsw i64 [[IND]], 1
; CHECK-NEXT:    [[ARRAYIDXC:%.*]] = getelementptr inbounds i32, ptr [[C]], i64 [[IND]]
; CHECK-NEXT:    [[LOADC:%.*]] = load i32, ptr [[ARRAYIDXC]], align 4, !alias.scope [[META3]]
; CHECK-NEXT:    [[SUM_ADD]] = add nuw nsw i32 [[SUM]], [[LOADC]]
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i64 [[ADD]], 20
; CHECK-NEXT:    br i1 [[EXITCOND]], label %[[FOR_END_LOOPEXIT2:.*]], label %[[FOR_BODY]]
; CHECK:       [[FOR_END_LOOPEXIT]]:
; CHECK-NEXT:    [[SUM_ADD_LVER_PH:%.*]] = phi i32 [ [[SUM_ADD_LVER_ORIG]], %[[FOR_BODY_LVER_ORIG]] ]
; CHECK-NEXT:    br label %[[FOR_END:.*]]
; CHECK:       [[FOR_END_LOOPEXIT2]]:
; CHECK-NEXT:    [[SUM_ADD_LVER_PH3:%.*]] = phi i32 [ [[SUM_ADD]], %[[FOR_BODY]] ]
; CHECK-NEXT:    br label %[[FOR_END]]
; CHECK:       [[FOR_END]]:
; CHECK-NEXT:    [[SUM_ADD_LVER:%.*]] = phi i32 [ [[SUM_ADD_LVER_PH]], %[[FOR_END_LOOPEXIT]] ], [ [[SUM_ADD_LVER_PH3]], %[[FOR_END_LOOPEXIT2]] ]
; CHECK-NEXT:    store i32 [[SUM_ADD_LVER]], ptr @SUM, align 4
; CHECK-NEXT:    ret void
;
entry:
  %a = load ptr, ptr @A, align 8
  %b = load ptr, ptr @B, align 8
  %c = load ptr, ptr @C, align 8
  %d = load ptr, ptr @D, align 8
  %e = load ptr, ptr @E, align 8

  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %ind = phi i64 [ 0, %entry ], [ %add, %for.body ]
  %sum = phi i32 [ 0, %entry ], [ %sum_add, %for.body ]

  %arrayidxA = getelementptr inbounds i32, ptr %a, i64 %ind
  %loadA = load i32, ptr %arrayidxA, align 4

  %arrayidxB = getelementptr inbounds i32, ptr %b, i64 %ind
  %loadB = load i32, ptr %arrayidxB, align 4

  %mulA = mul i32 %loadB, %loadA

  %add = add nuw nsw i64 %ind, 1
  %arrayidxA_plus_4 = getelementptr inbounds i32, ptr %a, i64 %add
  store i32 %mulA, ptr %arrayidxA_plus_4, align 4

  %arrayidxC = getelementptr inbounds i32, ptr %c, i64 %ind
  %loadC = load i32, ptr %arrayidxC, align 4

  %sum_add = add nuw nsw i32 %sum, %loadC

  %exitcond = icmp eq i64 %add, 20
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  store i32 %sum_add, ptr @SUM, align 4
  ret void
}
;.
; CHECK: [[META0]] = !{[[META1:![0-9]+]]}
; CHECK: [[META1]] = distinct !{[[META1]], [[META2:![0-9]+]]}
; CHECK: [[META2]] = distinct !{[[META2]], !"LVerDomain"}
; CHECK: [[META3]] = !{[[META4:![0-9]+]]}
; CHECK: [[META4]] = distinct !{[[META4]], [[META2]]}
; CHECK: [[META5]] = !{[[META6:![0-9]+]]}
; CHECK: [[META6]] = distinct !{[[META6]], [[META2]]}
;.
