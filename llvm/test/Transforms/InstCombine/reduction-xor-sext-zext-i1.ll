; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S | FileCheck %s

define i1 @reduce_xor_self(<8 x i1> %x) {
; CHECK-LABEL: @reduce_xor_self(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i1> [[X:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i8 0, 9) i8 @llvm.ctpop.i8(i8 [[TMP1]])
; CHECK-NEXT:    [[RES:%.*]] = trunc i8 [[TMP2]] to i1
; CHECK-NEXT:    ret i1 [[RES]]
;
  %res = call i1 @llvm.vector.reduce.xor.v8i32(<8 x i1> %x)
  ret i1 %res
}

define i32 @reduce_xor_sext(<4 x i1> %x) {
; CHECK-LABEL: @reduce_xor_sext(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <4 x i1> [[X:%.*]] to i4
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i4 0, 5) i4 @llvm.ctpop.i4(i4 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i4 [[TMP2]] to i1
; CHECK-NEXT:    [[RES:%.*]] = sext i1 [[TMP3]] to i32
; CHECK-NEXT:    ret i32 [[RES]]
;
  %sext = sext <4 x i1> %x to <4 x i32>
  %res = call i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> %sext)
  ret i32 %res
}

define i64 @reduce_xor_zext(<8 x i1> %x) {
; CHECK-LABEL: @reduce_xor_zext(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i1> [[X:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i8 0, 9) i8 @llvm.ctpop.i8(i8 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = and i8 [[TMP2]], 1
; CHECK-NEXT:    [[RES:%.*]] = zext nneg i8 [[TMP3]] to i64
; CHECK-NEXT:    ret i64 [[RES]]
;
  %zext = zext <8 x i1> %x to <8 x i64>
  %res = call i64 @llvm.vector.reduce.xor.v8i64(<8 x i64> %zext)
  ret i64 %res
}

define i16 @reduce_xor_sext_same(<16 x i1> %x) {
; CHECK-LABEL: @reduce_xor_sext_same(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <16 x i1> [[X:%.*]] to i16
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i16 0, 17) i16 @llvm.ctpop.i16(i16 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = and i16 [[TMP2]], 1
; CHECK-NEXT:    [[SEXT:%.*]] = sub nsw i16 0, [[TMP3]]
; CHECK-NEXT:    ret i16 [[SEXT]]
;
  %sext = sext <16 x i1> %x to <16 x i16>
  %res = call i16 @llvm.vector.reduce.xor.v16i16(<16 x i16> %sext)
  ret i16 %res
}

define i8 @reduce_xor_zext_long(<128 x i1> %x) {
; CHECK-LABEL: @reduce_xor_zext_long(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <128 x i1> [[X:%.*]] to i128
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i128 0, 129) i128 @llvm.ctpop.i128(i128 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i128 [[TMP2]] to i1
; CHECK-NEXT:    [[RES:%.*]] = sext i1 [[TMP3]] to i8
; CHECK-NEXT:    ret i8 [[RES]]
;
  %sext = sext <128 x i1> %x to <128 x i8>
  %res = call i8 @llvm.vector.reduce.xor.v128i8(<128 x i8> %sext)
  ret i8 %res
}

@glob = external global i8, align 1
define i8 @reduce_xor_zext_long_external_use(<128 x i1> %x) {
; CHECK-LABEL: @reduce_xor_zext_long_external_use(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <128 x i1> [[X:%.*]] to i128
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i128 0, 129) i128 @llvm.ctpop.i128(i128 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = trunc i128 [[TMP2]] to i1
; CHECK-NEXT:    [[RES:%.*]] = sext i1 [[TMP3]] to i8
; CHECK-NEXT:    [[TMP5:%.*]] = extractelement <128 x i1> [[X]], i64 0
; CHECK-NEXT:    [[EXT:%.*]] = sext i1 [[TMP5]] to i8
; CHECK-NEXT:    store i8 [[EXT]], ptr @glob, align 1
; CHECK-NEXT:    ret i8 [[RES]]
;
  %sext = sext <128 x i1> %x to <128 x i8>
  %res = call i8 @llvm.vector.reduce.xor.v128i8(<128 x i8> %sext)
  %ext = extractelement <128 x i8> %sext, i32 0
  store i8 %ext, ptr @glob, align 1
  ret i8 %res
}

@glob1 = external global i64, align 8
define i64 @reduce_xor_zext_external_use(<8 x i1> %x) {
; CHECK-LABEL: @reduce_xor_zext_external_use(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <8 x i1> [[X:%.*]] to i8
; CHECK-NEXT:    [[TMP2:%.*]] = call range(i8 0, 9) i8 @llvm.ctpop.i8(i8 [[TMP1]])
; CHECK-NEXT:    [[TMP3:%.*]] = and i8 [[TMP2]], 1
; CHECK-NEXT:    [[RES:%.*]] = zext nneg i8 [[TMP3]] to i64
; CHECK-NEXT:    [[TMP4:%.*]] = extractelement <8 x i1> [[X]], i64 0
; CHECK-NEXT:    [[EXT:%.*]] = zext i1 [[TMP4]] to i64
; CHECK-NEXT:    store i64 [[EXT]], ptr @glob1, align 8
; CHECK-NEXT:    ret i64 [[RES]]
;
  %zext = zext <8 x i1> %x to <8 x i64>
  %res = call i64 @llvm.vector.reduce.xor.v8i64(<8 x i64> %zext)
  %ext = extractelement <8 x i64> %zext, i32 0
  store i64 %ext, ptr @glob1, align 8
  ret i64 %res
}

declare i1 @llvm.vector.reduce.xor.v8i32(<8 x i1> %a)
declare i32 @llvm.vector.reduce.xor.v4i32(<4 x i32> %a)
declare i64 @llvm.vector.reduce.xor.v8i64(<8 x i64> %a)
declare i16 @llvm.vector.reduce.xor.v16i16(<16 x i16> %a)
declare i8 @llvm.vector.reduce.xor.v128i8(<128 x i8> %a)
