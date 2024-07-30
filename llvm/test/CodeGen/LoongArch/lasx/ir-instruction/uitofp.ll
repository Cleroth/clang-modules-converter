; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

define void @uitofp_v8i32_v8f32(ptr %res, ptr %in){
; CHECK-LABEL: uitofp_v8i32_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvffint.s.wu $xr0, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <8 x i32>, ptr %in
  %v1 = uitofp <8 x i32> %v0 to <8 x float>
  store <8 x float> %v1, ptr %res
  ret void
}

define void @uitofp_v4f64_v4f64(ptr %res, ptr %in){
; CHECK-LABEL: uitofp_v4f64_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvffint.d.lu $xr0, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %in
  %v1 = uitofp <4 x i64> %v0 to <4 x double>
  store <4 x double> %v1, ptr %res
  ret void
}

define void @uitofp_v4i64_v4f32(ptr %res, ptr %in){
; CHECK-LABEL: uitofp_v4i64_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvffint.d.lu $xr0, $xr0
; CHECK-NEXT:    xvpermi.d $xr1, $xr0, 238
; CHECK-NEXT:    xvfcvt.s.d $xr0, $xr1, $xr0
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i64>, ptr %in
  %v1 = uitofp <4 x i64> %v0 to <4 x float>
  store <4 x float> %v1, ptr %res
  ret void
}

define void @uitofp_v4i32_v4f64(ptr %res, ptr %in){
; CHECK-LABEL: uitofp_v4i32_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vld $vr0, $a1, 0
; CHECK-NEXT:    vext2xv.du.wu $xr0, $xr0
; CHECK-NEXT:    xvffint.d.lu $xr0, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
  %v0 = load <4 x i32>, ptr %in
  %v1 = uitofp <4 x i32> %v0 to <4 x double>
  store <4 x double> %v1, ptr %res
  ret void
}
