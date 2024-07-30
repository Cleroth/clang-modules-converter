; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=slp-vectorizer -S -mtriple=x86_64-unknown-linux-gnu -mcpu=skylake-avx512 | FileCheck %s

%struct.S = type { [8 x i32], [8 x i32], [16 x i32] }

define dso_local void @_Z4testP1S(ptr %p) local_unnamed_addr {
; CHECK-LABEL: @_Z4testP1S(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds [[STRUCT_S:%.*]], ptr [[P:%.*]], i64 0, i32 1, i64 0
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[P]], i64 0, i32 2, i64 15
; CHECK-NEXT:    [[I1:%.*]] = load i32, ptr [[ARRAYIDX1]], align 4
; CHECK-NEXT:    [[ARRAYIDX13:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[P]], i64 0, i32 2, i64 6
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x i32>, ptr [[ARRAYIDX13]], align 4
; CHECK-NEXT:    [[ARRAYIDX20:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[P]], i64 0, i32 2, i64 4
; CHECK-NEXT:    [[I7:%.*]] = load i32, ptr [[ARRAYIDX20]], align 4
; CHECK-NEXT:    [[ARRAYIDX27:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[P]], i64 0, i32 2, i64 12
; CHECK-NEXT:    [[I9:%.*]] = load i32, ptr [[ARRAYIDX27]], align 4
; CHECK-NEXT:    [[ARRAYIDX34:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[P]], i64 0, i32 2, i64 13
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i32>, ptr [[ARRAYIDX34]], align 4
; CHECK-NEXT:    [[ARRAYIDX48:%.*]] = getelementptr inbounds [[STRUCT_S]], ptr [[P]], i64 0, i32 2, i64 5
; CHECK-NEXT:    [[I15:%.*]] = load i32, ptr [[ARRAYIDX48]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load <8 x i32>, ptr [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = insertelement <8 x i32> poison, i32 [[I1]], i32 0
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <2 x i32> [[TMP0]], <2 x i32> poison, <8 x i32> <i32 1, i32 0, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <8 x i32> [[TMP3]], <8 x i32> [[TMP4]], <8 x i32> <i32 0, i32 8, i32 9, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP6:%.*]] = insertelement <8 x i32> [[TMP5]], i32 [[I7]], i32 3
; CHECK-NEXT:    [[TMP7:%.*]] = insertelement <8 x i32> [[TMP6]], i32 [[I9]], i32 4
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <2 x i32> [[TMP1]], <2 x i32> poison, <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <8 x i32> [[TMP7]], <8 x i32> [[TMP8]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 8, i32 9, i32 poison>
; CHECK-NEXT:    [[TMP10:%.*]] = insertelement <8 x i32> [[TMP9]], i32 [[I15]], i32 7
; CHECK-NEXT:    [[TMP11:%.*]] = add nsw <8 x i32> [[TMP10]], [[TMP2]]
; CHECK-NEXT:    store <8 x i32> [[TMP11]], ptr [[P]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %arrayidx = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 1, i64 0
  %i = load i32, ptr %arrayidx, align 4
  %arrayidx1 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 2, i64 15
  %i1 = load i32, ptr %arrayidx1, align 4
  %add = add nsw i32 %i1, %i
  store i32 %add, ptr %p, align 4
  %arrayidx4 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 1, i64 1
  %i2 = load i32, ptr %arrayidx4, align 4
  %arrayidx6 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 2, i64 7
  %i3 = load i32, ptr %arrayidx6, align 4
  %add7 = add nsw i32 %i3, %i2
  %arrayidx9 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 1
  store i32 %add7, ptr %arrayidx9, align 4
  %arrayidx11 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 1, i64 2
  %i4 = load i32, ptr %arrayidx11, align 4
  %arrayidx13 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 2, i64 6
  %i5 = load i32, ptr %arrayidx13, align 4
  %add14 = add nsw i32 %i5, %i4
  %arrayidx16 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 2
  store i32 %add14, ptr %arrayidx16, align 4
  %arrayidx18 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 1, i64 3
  %i6 = load i32, ptr %arrayidx18, align 4
  %arrayidx20 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 2, i64 4
  %i7 = load i32, ptr %arrayidx20, align 4
  %add21 = add nsw i32 %i7, %i6
  %arrayidx23 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 3
  store i32 %add21, ptr %arrayidx23, align 4
  %arrayidx25 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 1, i64 4
  %i8 = load i32, ptr %arrayidx25, align 4
  %arrayidx27 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 2, i64 12
  %i9 = load i32, ptr %arrayidx27, align 4
  %add28 = add nsw i32 %i9, %i8
  %arrayidx30 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 4
  store i32 %add28, ptr %arrayidx30, align 4
  %arrayidx32 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 1, i64 5
  %i10 = load i32, ptr %arrayidx32, align 4
  %arrayidx34 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 2, i64 13
  %i11 = load i32, ptr %arrayidx34, align 4
  %add35 = add nsw i32 %i11, %i10
  %arrayidx37 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 5
  store i32 %add35, ptr %arrayidx37, align 4
  %arrayidx39 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 1, i64 6
  %i12 = load i32, ptr %arrayidx39, align 4
  %arrayidx41 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 2, i64 14
  %i13 = load i32, ptr %arrayidx41, align 4
  %add42 = add nsw i32 %i13, %i12
  %arrayidx44 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 6
  store i32 %add42, ptr %arrayidx44, align 4
  %arrayidx46 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 1, i64 7
  %i14 = load i32, ptr %arrayidx46, align 4
  %arrayidx48 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 2, i64 5
  %i15 = load i32, ptr %arrayidx48, align 4
  %add49 = add nsw i32 %i15, %i14
  %arrayidx51 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 7
  store i32 %add49, ptr %arrayidx51, align 4
  ret void
}

; Test for 2 load groups 4 elements each against different base pointers.
; Both loaded groups are not ordered thus here are few specific points:
; (1) these groups are detected, (2) reordereing shuffles generated and
; (3) these loads vectorized as a part of tree that is seeded by stores
; and with VF=8.

define dso_local void @test_unordered_splits(ptr nocapture %p) local_unnamed_addr {
; CHECK-LABEL: @test_unordered_splits(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[P1:%.*]] = alloca [16 x i32], align 16
; CHECK-NEXT:    [[P2:%.*]] = alloca [16 x i32], align 16
; CHECK-NEXT:    [[G10:%.*]] = getelementptr inbounds [16 x i32], ptr [[P1]], i32 0, i64 4
; CHECK-NEXT:    [[G20:%.*]] = getelementptr inbounds [16 x i32], ptr [[P2]], i32 0, i64 12
; CHECK-NEXT:    [[TMP0:%.*]] = load <4 x i32>, ptr [[G10]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load <4 x i32>, ptr [[G20]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = shufflevector <4 x i32> [[TMP0]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP3:%.*]] = shufflevector <4 x i32> [[TMP1]], <4 x i32> poison, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <8 x i32> [[TMP2]], <8 x i32> [[TMP3]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <8 x i32> [[TMP4]], <8 x i32> poison, <8 x i32> <i32 1, i32 0, i32 2, i32 3, i32 7, i32 5, i32 6, i32 4>
; CHECK-NEXT:    store <8 x i32> [[TMP5]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %p1 = alloca [16 x i32], align 16
  %p2 = alloca [16 x i32], align 16
  %g10 = getelementptr inbounds [16 x i32], ptr %p1, i32 0, i64 4
  %g11 = getelementptr inbounds [16 x i32], ptr %p1, i32 0, i64 5
  %g12 = getelementptr inbounds [16 x i32], ptr %p1, i32 0, i64 6
  %g13 = getelementptr inbounds [16 x i32], ptr %p1, i32 0, i64 7
  %g20 = getelementptr inbounds [16 x i32], ptr %p2, i32 0, i64 12
  %g21 = getelementptr inbounds [16 x i32], ptr %p2, i32 0, i64 13
  %g22 = getelementptr inbounds [16 x i32], ptr %p2, i32 0, i64 14
  %g23 = getelementptr inbounds [16 x i32], ptr %p2, i32 0, i64 15
  %i1 = load i32, ptr %g11, align 4
  store i32 %i1, ptr %p, align 4
  %i3 = load i32, ptr %g10, align 4
  %arrayidx9 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 1
  store i32 %i3, ptr %arrayidx9, align 4
  %i5 = load i32, ptr %g12, align 4
  %arrayidx16 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 2
  store i32 %i5, ptr %arrayidx16, align 4
  %i7 = load i32, ptr %g13, align 4
  %arrayidx23 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 3
  store i32 %i7, ptr %arrayidx23, align 4
  %i9 = load i32, ptr %g23, align 4
  %arrayidx30 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 4
  store i32 %i9, ptr %arrayidx30, align 4
  %i11 = load i32, ptr %g21, align 4
  %arrayidx37 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 5
  store i32 %i11, ptr %arrayidx37, align 4
  %i13 = load i32, ptr %g22, align 4
  %arrayidx44 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 6
  store i32 %i13, ptr %arrayidx44, align 4
  %i15 = load i32, ptr %g20, align 4
  %arrayidx51 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 7
  store i32 %i15, ptr %arrayidx51, align 4
  ret void
}

define dso_local void @test_cost_splits(ptr nocapture %p) local_unnamed_addr {
; CHECK-LABEL: @test_cost_splits(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[P1:%.*]] = alloca [16 x i32], align 16
; CHECK-NEXT:    [[P2:%.*]] = alloca [16 x i32], align 16
; CHECK-NEXT:    [[P3:%.*]] = alloca [16 x i32], align 16
; CHECK-NEXT:    [[P4:%.*]] = alloca [16 x i32], align 16
; CHECK-NEXT:    [[G10:%.*]] = getelementptr inbounds [16 x i32], ptr [[P1]], i32 0, i64 4
; CHECK-NEXT:    [[G12:%.*]] = getelementptr inbounds [16 x i32], ptr [[P2]], i32 0, i64 6
; CHECK-NEXT:    [[G20:%.*]] = getelementptr inbounds [16 x i32], ptr [[P3]], i32 0, i64 12
; CHECK-NEXT:    [[G22:%.*]] = getelementptr inbounds [16 x i32], ptr [[P4]], i32 0, i64 14
; CHECK-NEXT:    [[TMP0:%.*]] = load <2 x i32>, ptr [[G10]], align 4
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x i32>, ptr [[G12]], align 4
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x i32>, ptr [[G20]], align 4
; CHECK-NEXT:    [[TMP3:%.*]] = load <2 x i32>, ptr [[G22]], align 4
; CHECK-NEXT:    [[TMP4:%.*]] = shufflevector <2 x i32> [[TMP0]], <2 x i32> poison, <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP5:%.*]] = shufflevector <2 x i32> [[TMP1]], <2 x i32> poison, <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP6:%.*]] = shufflevector <8 x i32> [[TMP4]], <8 x i32> [[TMP5]], <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP7:%.*]] = shufflevector <2 x i32> [[TMP2]], <2 x i32> poison, <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP8:%.*]] = shufflevector <8 x i32> [[TMP6]], <8 x i32> [[TMP7]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP9:%.*]] = shufflevector <2 x i32> [[TMP3]], <2 x i32> poison, <8 x i32> <i32 0, i32 1, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison, i32 poison>
; CHECK-NEXT:    [[TMP10:%.*]] = shufflevector <8 x i32> [[TMP8]], <8 x i32> [[TMP9]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 8, i32 9>
; CHECK-NEXT:    store <8 x i32> [[TMP10]], ptr [[P:%.*]], align 4
; CHECK-NEXT:    ret void
;
entry:
  %p1 = alloca [16 x i32], align 16
  %p2 = alloca [16 x i32], align 16
  %p3 = alloca [16 x i32], align 16
  %p4 = alloca [16 x i32], align 16
  %g10 = getelementptr inbounds [16 x i32], ptr %p1, i32 0, i64 4
  %g11 = getelementptr inbounds [16 x i32], ptr %p1, i32 0, i64 5
  %g12 = getelementptr inbounds [16 x i32], ptr %p2, i32 0, i64 6
  %g13 = getelementptr inbounds [16 x i32], ptr %p2, i32 0, i64 7
  %g20 = getelementptr inbounds [16 x i32], ptr %p3, i32 0, i64 12
  %g21 = getelementptr inbounds [16 x i32], ptr %p3, i32 0, i64 13
  %g22 = getelementptr inbounds [16 x i32], ptr %p4, i32 0, i64 14
  %g23 = getelementptr inbounds [16 x i32], ptr %p4, i32 0, i64 15
  %i1 = load i32, ptr %g10, align 4
  store i32 %i1, ptr %p, align 4
  %i3 = load i32, ptr %g11, align 4
  %arrayidx9 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 1
  store i32 %i3, ptr %arrayidx9, align 4
  %i5 = load i32, ptr %g12, align 4
  %arrayidx16 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 2
  store i32 %i5, ptr %arrayidx16, align 4
  %i7 = load i32, ptr %g13, align 4
  %arrayidx23 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 3
  store i32 %i7, ptr %arrayidx23, align 4
  %i9 = load i32, ptr %g20, align 4
  %arrayidx30 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 4
  store i32 %i9, ptr %arrayidx30, align 4
  %i11 = load i32, ptr %g21, align 4
  %arrayidx37 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 5
  store i32 %i11, ptr %arrayidx37, align 4
  %i13 = load i32, ptr %g22, align 4
  %arrayidx44 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 6
  store i32 %i13, ptr %arrayidx44, align 4
  %i15 = load i32, ptr %g23, align 4
  %arrayidx51 = getelementptr inbounds %struct.S, ptr %p, i64 0, i32 0, i64 7
  store i32 %i15, ptr %arrayidx51, align 4
  ret void
}
