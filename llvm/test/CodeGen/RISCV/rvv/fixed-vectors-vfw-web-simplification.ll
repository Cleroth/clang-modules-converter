; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs %s -o - --riscv-lower-ext-max-web-size=1 | FileCheck %s --check-prefixes=NO_FOLDING
; RUN: llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs %s -o - --riscv-lower-ext-max-web-size=2 | FileCheck %s --check-prefixes=NO_FOLDING
; RUN: llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs %s -o - --riscv-lower-ext-max-web-size=3 | FileCheck %s --check-prefixes=FOLDING,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfhmin,+f,+d -verify-machineinstrs %s -o - --riscv-lower-ext-max-web-size=3 | FileCheck %s --check-prefixes=FOLDING,ZVFHMIN
; Check that the default value enables the web folding and
; that it is bigger than 3.
; RUN: llc -mtriple=riscv64 -mattr=+v,+zfh,+zvfh,+f,+d -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=FOLDING

define void @vfwmul_v2f116_multiple_users(ptr %x, ptr %y, ptr %z, <2 x half> %a, <2 x half> %b, <2 x half> %b2) {
; NO_FOLDING-LABEL: vfwmul_v2f116_multiple_users:
; NO_FOLDING:       # %bb.0:
; NO_FOLDING-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v11, v8
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v8, v9
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v9, v10
; NO_FOLDING-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; NO_FOLDING-NEXT:    vfmul.vv v10, v11, v8
; NO_FOLDING-NEXT:    vfadd.vv v11, v11, v9
; NO_FOLDING-NEXT:    vfsub.vv v8, v8, v9
; NO_FOLDING-NEXT:    vse32.v v10, (a0)
; NO_FOLDING-NEXT:    vse32.v v11, (a1)
; NO_FOLDING-NEXT:    vse32.v v8, (a2)
; NO_FOLDING-NEXT:    ret
;
; ZVFH-LABEL: vfwmul_v2f116_multiple_users:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFH-NEXT:    vfwmul.vv v11, v8, v9
; ZVFH-NEXT:    vfwadd.vv v12, v8, v10
; ZVFH-NEXT:    vfwsub.vv v8, v9, v10
; ZVFH-NEXT:    vse32.v v11, (a0)
; ZVFH-NEXT:    vse32.v v12, (a1)
; ZVFH-NEXT:    vse32.v v8, (a2)
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfwmul_v2f116_multiple_users:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetivli zero, 2, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v11, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmul.vv v10, v11, v8
; ZVFHMIN-NEXT:    vfadd.vv v11, v11, v9
; ZVFHMIN-NEXT:    vfsub.vv v8, v8, v9
; ZVFHMIN-NEXT:    vse32.v v10, (a0)
; ZVFHMIN-NEXT:    vse32.v v11, (a1)
; ZVFHMIN-NEXT:    vse32.v v8, (a2)
; ZVFHMIN-NEXT:    ret
  %c = fpext <2 x half> %a to <2 x float>
  %d = fpext <2 x half> %b to <2 x float>
  %d2 = fpext <2 x half> %b2 to <2 x float>
  %e = fmul <2 x float> %c, %d
  %f = fadd <2 x float> %c, %d2
  %g = fsub <2 x float> %d, %d2
  store <2 x float> %e, ptr %x
  store <2 x float> %f, ptr %y
  store <2 x float> %g, ptr %z
  ret void
}

define void @vfwmul_v2f32_multiple_users(ptr %x, ptr %y, ptr %z, <2 x float> %a, <2 x float> %b, <2 x float> %b2) {
; NO_FOLDING-LABEL: vfwmul_v2f32_multiple_users:
; NO_FOLDING:       # %bb.0:
; NO_FOLDING-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v11, v8
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v8, v9
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v9, v10
; NO_FOLDING-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; NO_FOLDING-NEXT:    vfmul.vv v10, v11, v8
; NO_FOLDING-NEXT:    vfadd.vv v11, v11, v9
; NO_FOLDING-NEXT:    vfsub.vv v8, v8, v9
; NO_FOLDING-NEXT:    vse64.v v10, (a0)
; NO_FOLDING-NEXT:    vse64.v v11, (a1)
; NO_FOLDING-NEXT:    vse64.v v8, (a2)
; NO_FOLDING-NEXT:    ret
;
; FOLDING-LABEL: vfwmul_v2f32_multiple_users:
; FOLDING:       # %bb.0:
; FOLDING-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; FOLDING-NEXT:    vfwmul.vv v11, v8, v9
; FOLDING-NEXT:    vfwadd.vv v12, v8, v10
; FOLDING-NEXT:    vfwsub.vv v8, v9, v10
; FOLDING-NEXT:    vse64.v v11, (a0)
; FOLDING-NEXT:    vse64.v v12, (a1)
; FOLDING-NEXT:    vse64.v v8, (a2)
; FOLDING-NEXT:    ret
  %c = fpext <2 x float> %a to <2 x double>
  %d = fpext <2 x float> %b to <2 x double>
  %d2 = fpext <2 x float> %b2 to <2 x double>
  %e = fmul <2 x double> %c, %d
  %f = fadd <2 x double> %c, %d2
  %g = fsub <2 x double> %d, %d2
  store <2 x double> %e, ptr %x
  store <2 x double> %f, ptr %y
  store <2 x double> %g, ptr %z
  ret void
}

define void @vfwmacc_v2f32_multiple_users(ptr %x, ptr %y, ptr %z, <2 x float> %a, <2 x float> %b, <2 x float> %b2, <2 x double> %w) {
; NO_FOLDING-LABEL: vfwmacc_v2f32_multiple_users:
; NO_FOLDING:       # %bb.0:
; NO_FOLDING-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v12, v8
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v8, v9
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v9, v10
; NO_FOLDING-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; NO_FOLDING-NEXT:    vfmul.vv v10, v12, v8
; NO_FOLDING-NEXT:    vfmadd.vv v12, v9, v11
; NO_FOLDING-NEXT:    vfsub.vv v8, v8, v9
; NO_FOLDING-NEXT:    vse64.v v10, (a0)
; NO_FOLDING-NEXT:    vse64.v v12, (a1)
; NO_FOLDING-NEXT:    vse64.v v8, (a2)
; NO_FOLDING-NEXT:    ret
;
; FOLDING-LABEL: vfwmacc_v2f32_multiple_users:
; FOLDING:       # %bb.0:
; FOLDING-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; FOLDING-NEXT:    vfwmul.vv v12, v8, v9
; FOLDING-NEXT:    vfwmacc.vv v11, v8, v10
; FOLDING-NEXT:    vfwsub.vv v8, v9, v10
; FOLDING-NEXT:    vse64.v v12, (a0)
; FOLDING-NEXT:    vse64.v v11, (a1)
; FOLDING-NEXT:    vse64.v v8, (a2)
; FOLDING-NEXT:    ret
  %c = fpext <2 x float> %a to <2 x double>
  %d = fpext <2 x float> %b to <2 x double>
  %d2 = fpext <2 x float> %b2 to <2 x double>
  %e = fmul <2 x double> %c, %d
  %f = call <2 x double> @llvm.fma(<2 x double> %c, <2 x double> %d2, <2 x double> %w)
  %g = fsub <2 x double> %d, %d2
  store <2 x double> %e, ptr %x
  store <2 x double> %f, ptr %y
  store <2 x double> %g, ptr %z
  ret void
}

; Negative test. We can't fold because the FMA addend is a user.
define void @vfwmacc_v2f32_multiple_users_addend_user(ptr %x, ptr %y, ptr %z, <2 x float> %a, <2 x float> %b, <2 x float> %b2) {
; NO_FOLDING-LABEL: vfwmacc_v2f32_multiple_users_addend_user:
; NO_FOLDING:       # %bb.0:
; NO_FOLDING-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v11, v8
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v8, v9
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v9, v10
; NO_FOLDING-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; NO_FOLDING-NEXT:    vfmul.vv v10, v11, v8
; NO_FOLDING-NEXT:    vfmadd.vv v11, v9, v8
; NO_FOLDING-NEXT:    vfsub.vv v8, v8, v9
; NO_FOLDING-NEXT:    vse64.v v10, (a0)
; NO_FOLDING-NEXT:    vse64.v v11, (a1)
; NO_FOLDING-NEXT:    vse64.v v8, (a2)
; NO_FOLDING-NEXT:    ret
;
; FOLDING-LABEL: vfwmacc_v2f32_multiple_users_addend_user:
; FOLDING:       # %bb.0:
; FOLDING-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; FOLDING-NEXT:    vfwcvt.f.f.v v11, v8
; FOLDING-NEXT:    vfwcvt.f.f.v v8, v9
; FOLDING-NEXT:    vfwcvt.f.f.v v9, v10
; FOLDING-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; FOLDING-NEXT:    vfmul.vv v10, v11, v8
; FOLDING-NEXT:    vfmadd.vv v11, v9, v8
; FOLDING-NEXT:    vfsub.vv v8, v8, v9
; FOLDING-NEXT:    vse64.v v10, (a0)
; FOLDING-NEXT:    vse64.v v11, (a1)
; FOLDING-NEXT:    vse64.v v8, (a2)
; FOLDING-NEXT:    ret
  %c = fpext <2 x float> %a to <2 x double>
  %d = fpext <2 x float> %b to <2 x double>
  %d2 = fpext <2 x float> %b2 to <2 x double>
  %e = fmul <2 x double> %c, %d
  %f = call <2 x double> @llvm.fma(<2 x double> %c, <2 x double> %d2, <2 x double> %d)
  %g = fsub <2 x double> %d, %d2
  store <2 x double> %e, ptr %x
  store <2 x double> %f, ptr %y
  store <2 x double> %g, ptr %z
  ret void
}

; Negative test. We can't fold because the FMA addend is a user.
define void @vfwmacc_v2f32_addend_user(ptr %x, <2 x float> %a, <2 x float> %b) {
; NO_FOLDING-LABEL: vfwmacc_v2f32_addend_user:
; NO_FOLDING:       # %bb.0:
; NO_FOLDING-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v10, v8
; NO_FOLDING-NEXT:    vfwcvt.f.f.v v8, v9
; NO_FOLDING-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; NO_FOLDING-NEXT:    vfmadd.vv v8, v10, v8
; NO_FOLDING-NEXT:    vse64.v v8, (a0)
; NO_FOLDING-NEXT:    ret
;
; FOLDING-LABEL: vfwmacc_v2f32_addend_user:
; FOLDING:       # %bb.0:
; FOLDING-NEXT:    vsetivli zero, 2, e32, mf2, ta, ma
; FOLDING-NEXT:    vfwcvt.f.f.v v10, v8
; FOLDING-NEXT:    vfwcvt.f.f.v v8, v9
; FOLDING-NEXT:    vsetvli zero, zero, e64, m1, ta, ma
; FOLDING-NEXT:    vfmadd.vv v8, v10, v8
; FOLDING-NEXT:    vse64.v v8, (a0)
; FOLDING-NEXT:    ret
  %c = fpext <2 x float> %a to <2 x double>
  %d = fpext <2 x float> %b to <2 x double>
  %f = call <2 x double> @llvm.fma(<2 x double> %c, <2 x double> %d, <2 x double> %d)
  store <2 x double> %f, ptr %x
  ret void
}
