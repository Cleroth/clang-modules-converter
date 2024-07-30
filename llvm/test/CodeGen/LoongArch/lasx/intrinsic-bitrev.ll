; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

declare <32 x i8> @llvm.loongarch.lasx.xvbitrev.b(<32 x i8>, <32 x i8>)

define <32 x i8> @lasx_xvbitrev_b(<32 x i8> %va, <32 x i8> %vb) nounwind {
; CHECK-LABEL: lasx_xvbitrev_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitrev.b $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvbitrev.b(<32 x i8> %va, <32 x i8> %vb)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvbitrev.h(<16 x i16>, <16 x i16>)

define <16 x i16> @lasx_xvbitrev_h(<16 x i16> %va, <16 x i16> %vb) nounwind {
; CHECK-LABEL: lasx_xvbitrev_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitrev.h $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvbitrev.h(<16 x i16> %va, <16 x i16> %vb)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvbitrev.w(<8 x i32>, <8 x i32>)

define <8 x i32> @lasx_xvbitrev_w(<8 x i32> %va, <8 x i32> %vb) nounwind {
; CHECK-LABEL: lasx_xvbitrev_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitrev.w $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvbitrev.w(<8 x i32> %va, <8 x i32> %vb)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvbitrev.d(<4 x i64>, <4 x i64>)

define <4 x i64> @lasx_xvbitrev_d(<4 x i64> %va, <4 x i64> %vb) nounwind {
; CHECK-LABEL: lasx_xvbitrev_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitrev.d $xr0, $xr0, $xr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvbitrev.d(<4 x i64> %va, <4 x i64> %vb)
  ret <4 x i64> %res
}

declare <32 x i8> @llvm.loongarch.lasx.xvbitrevi.b(<32 x i8>, i32)

define <32 x i8> @lasx_xvbitrevi_b(<32 x i8> %va) nounwind {
; CHECK-LABEL: lasx_xvbitrevi_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitrevi.b $xr0, $xr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvbitrevi.b(<32 x i8> %va, i32 1)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvbitrevi.h(<16 x i16>, i32)

define <16 x i16> @lasx_xvbitrevi_h(<16 x i16> %va) nounwind {
; CHECK-LABEL: lasx_xvbitrevi_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitrevi.h $xr0, $xr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvbitrevi.h(<16 x i16> %va, i32 1)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvbitrevi.w(<8 x i32>, i32)

define <8 x i32> @lasx_xvbitrevi_w(<8 x i32> %va) nounwind {
; CHECK-LABEL: lasx_xvbitrevi_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitrevi.w $xr0, $xr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvbitrevi.w(<8 x i32> %va, i32 1)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvbitrevi.d(<4 x i64>, i32)

define <4 x i64> @lasx_xvbitrevi_d(<4 x i64> %va) nounwind {
; CHECK-LABEL: lasx_xvbitrevi_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvbitrevi.d $xr0, $xr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvbitrevi.d(<4 x i64> %va, i32 1)
  ret <4 x i64> %res
}
