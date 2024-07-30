; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z15 -verify-machineinstrs -O3 \
; RUN:   | FileCheck %s

; Test reassociation of fp add, subtract and multiply.

define double @fun0_fadd(ptr %x) {
; CHECK-LABEL: fun0_fadd:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ld %f0, 0(%r2)
; CHECK-NEXT:    adb %f0, 8(%r2)
; CHECK-NEXT:    ld %f1, 24(%r2)
; CHECK-NEXT:    adb %f1, 16(%r2)
; CHECK-NEXT:    adbr %f0, %f1
; CHECK-NEXT:    ld %f1, 40(%r2)
; CHECK-NEXT:    adb %f1, 32(%r2)
; CHECK-NEXT:    adb %f1, 48(%r2)
; CHECK-NEXT:    adbr %f0, %f1
; CHECK-NEXT:    adb %f0, 56(%r2)
; CHECK-NEXT:    br %r14
entry:
  %0 = load double, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds double, ptr %x, i64 1
  %1 = load double, ptr %arrayidx1, align 8
  %add = fadd reassoc nsz arcp contract afn double %1, %0
  %arrayidx2 = getelementptr inbounds double, ptr %x, i64 2
  %2 = load double, ptr %arrayidx2, align 8
  %add3 = fadd reassoc nsz arcp contract afn double %add, %2
  %arrayidx4 = getelementptr inbounds double, ptr %x, i64 3
  %3 = load double, ptr %arrayidx4, align 8
  %add5 = fadd reassoc nsz arcp contract afn double %add3, %3
  %arrayidx6 = getelementptr inbounds double, ptr %x, i64 4
  %4 = load double, ptr %arrayidx6, align 8
  %add7 = fadd reassoc nsz arcp contract afn double %add5, %4
  %arrayidx8 = getelementptr inbounds double, ptr %x, i64 5
  %5 = load double, ptr %arrayidx8, align 8
  %add9 = fadd reassoc nsz arcp contract afn double %add7, %5
  %arrayidx10 = getelementptr inbounds double, ptr %x, i64 6
  %6 = load double, ptr %arrayidx10, align 8
  %add11 = fadd reassoc nsz arcp contract afn double %add9, %6
  %arrayidx12 = getelementptr inbounds double, ptr %x, i64 7
  %7 = load double, ptr %arrayidx12, align 8
  %add13 = fadd reassoc nsz arcp contract afn double %add11, %7
  ret double %add13
}

define float @fun1_fadd(ptr %x) {
; CHECK-LABEL: fun1_fadd:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lde %f0, 0(%r2)
; CHECK-NEXT:    aeb %f0, 4(%r2)
; CHECK-NEXT:    lde %f1, 12(%r2)
; CHECK-NEXT:    aeb %f1, 8(%r2)
; CHECK-NEXT:    aebr %f0, %f1
; CHECK-NEXT:    lde %f1, 20(%r2)
; CHECK-NEXT:    aeb %f1, 16(%r2)
; CHECK-NEXT:    aeb %f1, 24(%r2)
; CHECK-NEXT:    aebr %f0, %f1
; CHECK-NEXT:    aeb %f0, 28(%r2)
; CHECK-NEXT:    br %r14
entry:
  %0 = load float, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds float, ptr %x, i64 1
  %1 = load float, ptr %arrayidx1, align 8
  %add = fadd reassoc nsz arcp contract afn float %1, %0
  %arrayidx2 = getelementptr inbounds float, ptr %x, i64 2
  %2 = load float, ptr %arrayidx2, align 8
  %add3 = fadd reassoc nsz arcp contract afn float %add, %2
  %arrayidx4 = getelementptr inbounds float, ptr %x, i64 3
  %3 = load float, ptr %arrayidx4, align 8
  %add5 = fadd reassoc nsz arcp contract afn float %add3, %3
  %arrayidx6 = getelementptr inbounds float, ptr %x, i64 4
  %4 = load float, ptr %arrayidx6, align 8
  %add7 = fadd reassoc nsz arcp contract afn float %add5, %4
  %arrayidx8 = getelementptr inbounds float, ptr %x, i64 5
  %5 = load float, ptr %arrayidx8, align 8
  %add9 = fadd reassoc nsz arcp contract afn float %add7, %5
  %arrayidx10 = getelementptr inbounds float, ptr %x, i64 6
  %6 = load float, ptr %arrayidx10, align 8
  %add11 = fadd reassoc nsz arcp contract afn float %add9, %6
  %arrayidx12 = getelementptr inbounds float, ptr %x, i64 7
  %7 = load float, ptr %arrayidx12, align 8
  %add13 = fadd reassoc nsz arcp contract afn float %add11, %7
  ret float %add13
}

define fp128 @fun2_fadd(ptr %x) {
; CHECK-LABEL: fun2_fadd:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v0, 0(%r3), 3
; CHECK-NEXT:    vl %v1, 16(%r3), 3
; CHECK-NEXT:    wfaxb %v0, %v1, %v0
; CHECK-NEXT:    vl %v1, 32(%r3), 3
; CHECK-NEXT:    vl %v2, 48(%r3), 3
; CHECK-NEXT:    wfaxb %v1, %v1, %v2
; CHECK-NEXT:    wfaxb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 64(%r3), 3
; CHECK-NEXT:    vl %v2, 80(%r3), 3
; CHECK-NEXT:    wfaxb %v1, %v1, %v2
; CHECK-NEXT:    vl %v2, 96(%r3), 3
; CHECK-NEXT:    wfaxb %v1, %v1, %v2
; CHECK-NEXT:    wfaxb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 112(%r3), 3
; CHECK-NEXT:    wfaxb %v0, %v0, %v1
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
entry:
  %0 = load fp128, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds fp128, ptr %x, i64 1
  %1 = load fp128, ptr %arrayidx1, align 8
  %add = fadd reassoc nsz arcp contract afn fp128 %1, %0
  %arrayidx2 = getelementptr inbounds fp128, ptr %x, i64 2
  %2 = load fp128, ptr %arrayidx2, align 8
  %add3 = fadd reassoc nsz arcp contract afn fp128 %add, %2
  %arrayidx4 = getelementptr inbounds fp128, ptr %x, i64 3
  %3 = load fp128, ptr %arrayidx4, align 8
  %add5 = fadd reassoc nsz arcp contract afn fp128 %add3, %3
  %arrayidx6 = getelementptr inbounds fp128, ptr %x, i64 4
  %4 = load fp128, ptr %arrayidx6, align 8
  %add7 = fadd reassoc nsz arcp contract afn fp128 %add5, %4
  %arrayidx8 = getelementptr inbounds fp128, ptr %x, i64 5
  %5 = load fp128, ptr %arrayidx8, align 8
  %add9 = fadd reassoc nsz arcp contract afn fp128 %add7, %5
  %arrayidx10 = getelementptr inbounds fp128, ptr %x, i64 6
  %6 = load fp128, ptr %arrayidx10, align 8
  %add11 = fadd reassoc nsz arcp contract afn fp128 %add9, %6
  %arrayidx12 = getelementptr inbounds fp128, ptr %x, i64 7
  %7 = load fp128, ptr %arrayidx12, align 8
  %add13 = fadd reassoc nsz arcp contract afn fp128 %add11, %7
  ret fp128 %add13
}

define <2 x double> @fun3_fadd(ptr %x) {
; CHECK-LABEL: fun3_fadd:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v0, 0(%r2), 3
; CHECK-NEXT:    vl %v1, 16(%r2), 3
; CHECK-NEXT:    vfadb %v0, %v1, %v0
; CHECK-NEXT:    vl %v1, 32(%r2), 3
; CHECK-NEXT:    vl %v2, 48(%r2), 3
; CHECK-NEXT:    vfadb %v1, %v1, %v2
; CHECK-NEXT:    vfadb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 64(%r2), 3
; CHECK-NEXT:    vl %v2, 80(%r2), 3
; CHECK-NEXT:    vfadb %v1, %v1, %v2
; CHECK-NEXT:    vl %v2, 96(%r2), 3
; CHECK-NEXT:    vfadb %v1, %v1, %v2
; CHECK-NEXT:    vfadb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 112(%r2), 3
; CHECK-NEXT:    vfadb %v24, %v0, %v1
; CHECK-NEXT:    br %r14
entry:
  %0 = load <2 x double>, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds <2 x double>, ptr %x, i64 1
  %1 = load <2 x double>, ptr %arrayidx1, align 8
  %add = fadd reassoc nsz arcp contract afn <2 x double> %1, %0
  %arrayidx2 = getelementptr inbounds <2 x double>, ptr %x, i64 2
  %2 = load <2 x double>, ptr %arrayidx2, align 8
  %add3 = fadd reassoc nsz arcp contract afn <2 x double> %add, %2
  %arrayidx4 = getelementptr inbounds <2 x double>, ptr %x, i64 3
  %3 = load <2 x double>, ptr %arrayidx4, align 8
  %add5 = fadd reassoc nsz arcp contract afn <2 x double> %add3, %3
  %arrayidx6 = getelementptr inbounds <2 x double>, ptr %x, i64 4
  %4 = load <2 x double>, ptr %arrayidx6, align 8
  %add7 = fadd reassoc nsz arcp contract afn <2 x double> %add5, %4
  %arrayidx8 = getelementptr inbounds <2 x double>, ptr %x, i64 5
  %5 = load <2 x double>, ptr %arrayidx8, align 8
  %add9 = fadd reassoc nsz arcp contract afn <2 x double> %add7, %5
  %arrayidx10 = getelementptr inbounds <2 x double>, ptr %x, i64 6
  %6 = load <2 x double>, ptr %arrayidx10, align 8
  %add11 = fadd reassoc nsz arcp contract afn <2 x double> %add9, %6
  %arrayidx12 = getelementptr inbounds <2 x double>, ptr %x, i64 7
  %7 = load <2 x double>, ptr %arrayidx12, align 8
  %add13 = fadd reassoc nsz arcp contract afn <2 x double> %add11, %7
  ret <2 x double> %add13
}

define <4 x float> @fun4_fadd(ptr %x) {
; CHECK-LABEL: fun4_fadd:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v0, 0(%r2), 3
; CHECK-NEXT:    vl %v1, 16(%r2), 3
; CHECK-NEXT:    vfasb %v0, %v1, %v0
; CHECK-NEXT:    vl %v1, 32(%r2), 3
; CHECK-NEXT:    vl %v2, 48(%r2), 3
; CHECK-NEXT:    vfasb %v1, %v1, %v2
; CHECK-NEXT:    vfasb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 64(%r2), 3
; CHECK-NEXT:    vl %v2, 80(%r2), 3
; CHECK-NEXT:    vfasb %v1, %v1, %v2
; CHECK-NEXT:    vl %v2, 96(%r2), 3
; CHECK-NEXT:    vfasb %v1, %v1, %v2
; CHECK-NEXT:    vfasb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 112(%r2), 3
; CHECK-NEXT:    vfasb %v24, %v0, %v1
; CHECK-NEXT:    br %r14
entry:
  %0 = load <4 x float>, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds <4 x float>, ptr %x, i64 1
  %1 = load <4 x float>, ptr %arrayidx1, align 8
  %add = fadd reassoc nsz arcp contract afn <4 x float> %1, %0
  %arrayidx2 = getelementptr inbounds <4 x float>, ptr %x, i64 2
  %2 = load <4 x float>, ptr %arrayidx2, align 8
  %add3 = fadd reassoc nsz arcp contract afn <4 x float> %add, %2
  %arrayidx4 = getelementptr inbounds <4 x float>, ptr %x, i64 3
  %3 = load <4 x float>, ptr %arrayidx4, align 8
  %add5 = fadd reassoc nsz arcp contract afn <4 x float> %add3, %3
  %arrayidx6 = getelementptr inbounds <4 x float>, ptr %x, i64 4
  %4 = load <4 x float>, ptr %arrayidx6, align 8
  %add7 = fadd reassoc nsz arcp contract afn <4 x float> %add5, %4
  %arrayidx8 = getelementptr inbounds <4 x float>, ptr %x, i64 5
  %5 = load <4 x float>, ptr %arrayidx8, align 8
  %add9 = fadd reassoc nsz arcp contract afn <4 x float> %add7, %5
  %arrayidx10 = getelementptr inbounds <4 x float>, ptr %x, i64 6
  %6 = load <4 x float>, ptr %arrayidx10, align 8
  %add11 = fadd reassoc nsz arcp contract afn <4 x float> %add9, %6
  %arrayidx12 = getelementptr inbounds <4 x float>, ptr %x, i64 7
  %7 = load <4 x float>, ptr %arrayidx12, align 8
  %add13 = fadd reassoc nsz arcp contract afn <4 x float> %add11, %7
  ret <4 x float> %add13
}

define double @fun5_fsub(ptr %x) {
; CHECK-LABEL: fun5_fsub:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ld %f0, 0(%r2)
; CHECK-NEXT:    sdb %f0, 8(%r2)
; CHECK-NEXT:    ld %f1, 24(%r2)
; CHECK-NEXT:    adb %f1, 16(%r2)
; CHECK-NEXT:    sdbr %f0, %f1
; CHECK-NEXT:    ld %f1, 40(%r2)
; CHECK-NEXT:    adb %f1, 32(%r2)
; CHECK-NEXT:    adb %f1, 48(%r2)
; CHECK-NEXT:    sdbr %f0, %f1
; CHECK-NEXT:    sdb %f0, 56(%r2)
; CHECK-NEXT:    br %r14
entry:
  %0 = load double, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds double, ptr %x, i64 1
  %1 = load double, ptr %arrayidx1, align 8
  %sub = fsub reassoc nsz arcp contract afn double %0, %1
  %arrayidx2 = getelementptr inbounds double, ptr %x, i64 2
  %2 = load double, ptr %arrayidx2, align 8
  %sub3 = fsub reassoc nsz arcp contract afn double %sub, %2
  %arrayidx4 = getelementptr inbounds double, ptr %x, i64 3
  %3 = load double, ptr %arrayidx4, align 8
  %sub5 = fsub reassoc nsz arcp contract afn double %sub3, %3
  %arrayidx6 = getelementptr inbounds double, ptr %x, i64 4
  %4 = load double, ptr %arrayidx6, align 8
  %sub7 = fsub reassoc nsz arcp contract afn double %sub5, %4
  %arrayidx8 = getelementptr inbounds double, ptr %x, i64 5
  %5 = load double, ptr %arrayidx8, align 8
  %sub9 = fsub reassoc nsz arcp contract afn double %sub7, %5
  %arrayidx10 = getelementptr inbounds double, ptr %x, i64 6
  %6 = load double, ptr %arrayidx10, align 8
  %sub11 = fsub reassoc nsz arcp contract afn double %sub9, %6
  %arrayidx12 = getelementptr inbounds double, ptr %x, i64 7
  %7 = load double, ptr %arrayidx12, align 8
  %sub13 = fsub reassoc nsz arcp contract afn double %sub11, %7
  ret double %sub13
}

define float @fun6_fsub(ptr %x) {
; CHECK-LABEL: fun6_fsub:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lde %f0, 0(%r2)
; CHECK-NEXT:    seb %f0, 4(%r2)
; CHECK-NEXT:    lde %f1, 12(%r2)
; CHECK-NEXT:    aeb %f1, 8(%r2)
; CHECK-NEXT:    sebr %f0, %f1
; CHECK-NEXT:    lde %f1, 20(%r2)
; CHECK-NEXT:    aeb %f1, 16(%r2)
; CHECK-NEXT:    aeb %f1, 24(%r2)
; CHECK-NEXT:    sebr %f0, %f1
; CHECK-NEXT:    seb %f0, 28(%r2)
; CHECK-NEXT:    br %r14
entry:
  %0 = load float, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds float, ptr %x, i64 1
  %1 = load float, ptr %arrayidx1, align 8
  %sub = fsub reassoc nsz arcp contract afn float %0, %1
  %arrayidx2 = getelementptr inbounds float, ptr %x, i64 2
  %2 = load float, ptr %arrayidx2, align 8
  %sub3 = fsub reassoc nsz arcp contract afn float %sub, %2
  %arrayidx4 = getelementptr inbounds float, ptr %x, i64 3
  %3 = load float, ptr %arrayidx4, align 8
  %sub5 = fsub reassoc nsz arcp contract afn float %sub3, %3
  %arrayidx6 = getelementptr inbounds float, ptr %x, i64 4
  %4 = load float, ptr %arrayidx6, align 8
  %sub7 = fsub reassoc nsz arcp contract afn float %sub5, %4
  %arrayidx8 = getelementptr inbounds float, ptr %x, i64 5
  %5 = load float, ptr %arrayidx8, align 8
  %sub9 = fsub reassoc nsz arcp contract afn float %sub7, %5
  %arrayidx10 = getelementptr inbounds float, ptr %x, i64 6
  %6 = load float, ptr %arrayidx10, align 8
  %sub11 = fsub reassoc nsz arcp contract afn float %sub9, %6
  %arrayidx12 = getelementptr inbounds float, ptr %x, i64 7
  %7 = load float, ptr %arrayidx12, align 8
  %sub13 = fsub reassoc nsz arcp contract afn float %sub11, %7
  ret float %sub13
}

define fp128 @fun7_fsub(ptr %x) {
; CHECK-LABEL: fun7_fsub:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v0, 0(%r3), 3
; CHECK-NEXT:    vl %v1, 16(%r3), 3
; CHECK-NEXT:    wfsxb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 32(%r3), 3
; CHECK-NEXT:    vl %v2, 48(%r3), 3
; CHECK-NEXT:    wfaxb %v1, %v1, %v2
; CHECK-NEXT:    wfsxb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 64(%r3), 3
; CHECK-NEXT:    vl %v2, 80(%r3), 3
; CHECK-NEXT:    wfaxb %v1, %v1, %v2
; CHECK-NEXT:    vl %v2, 96(%r3), 3
; CHECK-NEXT:    wfaxb %v1, %v1, %v2
; CHECK-NEXT:    wfsxb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 112(%r3), 3
; CHECK-NEXT:    wfsxb %v0, %v0, %v1
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
entry:
  %0 = load fp128, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds fp128, ptr %x, i64 1
  %1 = load fp128, ptr %arrayidx1, align 8
  %sub = fsub reassoc nsz arcp contract afn fp128 %0, %1
  %arrayidx2 = getelementptr inbounds fp128, ptr %x, i64 2
  %2 = load fp128, ptr %arrayidx2, align 8
  %sub3 = fsub reassoc nsz arcp contract afn fp128 %sub, %2
  %arrayidx4 = getelementptr inbounds fp128, ptr %x, i64 3
  %3 = load fp128, ptr %arrayidx4, align 8
  %sub5 = fsub reassoc nsz arcp contract afn fp128 %sub3, %3
  %arrayidx6 = getelementptr inbounds fp128, ptr %x, i64 4
  %4 = load fp128, ptr %arrayidx6, align 8
  %sub7 = fsub reassoc nsz arcp contract afn fp128 %sub5, %4
  %arrayidx8 = getelementptr inbounds fp128, ptr %x, i64 5
  %5 = load fp128, ptr %arrayidx8, align 8
  %sub9 = fsub reassoc nsz arcp contract afn fp128 %sub7, %5
  %arrayidx10 = getelementptr inbounds fp128, ptr %x, i64 6
  %6 = load fp128, ptr %arrayidx10, align 8
  %sub11 = fsub reassoc nsz arcp contract afn fp128 %sub9, %6
  %arrayidx12 = getelementptr inbounds fp128, ptr %x, i64 7
  %7 = load fp128, ptr %arrayidx12, align 8
  %sub13 = fsub reassoc nsz arcp contract afn fp128 %sub11, %7
  ret fp128 %sub13
}

define <2 x double> @fun8_fsub(ptr %x) {
; CHECK-LABEL: fun8_fsub:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v0, 0(%r2), 3
; CHECK-NEXT:    vl %v1, 16(%r2), 3
; CHECK-NEXT:    vfsdb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 32(%r2), 3
; CHECK-NEXT:    vl %v2, 48(%r2), 3
; CHECK-NEXT:    vfadb %v1, %v1, %v2
; CHECK-NEXT:    vfsdb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 64(%r2), 3
; CHECK-NEXT:    vl %v2, 80(%r2), 3
; CHECK-NEXT:    vfadb %v1, %v1, %v2
; CHECK-NEXT:    vl %v2, 96(%r2), 3
; CHECK-NEXT:    vfadb %v1, %v1, %v2
; CHECK-NEXT:    vfsdb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 112(%r2), 3
; CHECK-NEXT:    vfsdb %v24, %v0, %v1
; CHECK-NEXT:    br %r14
entry:
  %0 = load <2 x double>, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds <2 x double>, ptr %x, i64 1
  %1 = load <2 x double>, ptr %arrayidx1, align 8
  %sub = fsub reassoc nsz arcp contract afn <2 x double> %0, %1
  %arrayidx2 = getelementptr inbounds <2 x double>, ptr %x, i64 2
  %2 = load <2 x double>, ptr %arrayidx2, align 8
  %sub3 = fsub reassoc nsz arcp contract afn <2 x double> %sub, %2
  %arrayidx4 = getelementptr inbounds <2 x double>, ptr %x, i64 3
  %3 = load <2 x double>, ptr %arrayidx4, align 8
  %sub5 = fsub reassoc nsz arcp contract afn <2 x double> %sub3, %3
  %arrayidx6 = getelementptr inbounds <2 x double>, ptr %x, i64 4
  %4 = load <2 x double>, ptr %arrayidx6, align 8
  %sub7 = fsub reassoc nsz arcp contract afn <2 x double> %sub5, %4
  %arrayidx8 = getelementptr inbounds <2 x double>, ptr %x, i64 5
  %5 = load <2 x double>, ptr %arrayidx8, align 8
  %sub9 = fsub reassoc nsz arcp contract afn <2 x double> %sub7, %5
  %arrayidx10 = getelementptr inbounds <2 x double>, ptr %x, i64 6
  %6 = load <2 x double>, ptr %arrayidx10, align 8
  %sub11 = fsub reassoc nsz arcp contract afn <2 x double> %sub9, %6
  %arrayidx12 = getelementptr inbounds <2 x double>, ptr %x, i64 7
  %7 = load <2 x double>, ptr %arrayidx12, align 8
  %sub13 = fsub reassoc nsz arcp contract afn <2 x double> %sub11, %7
  ret <2 x double> %sub13
}

define <4 x float> @fun9_fsub(ptr %x) {
; CHECK-LABEL: fun9_fsub:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v0, 0(%r2), 3
; CHECK-NEXT:    vl %v1, 16(%r2), 3
; CHECK-NEXT:    vfssb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 32(%r2), 3
; CHECK-NEXT:    vl %v2, 48(%r2), 3
; CHECK-NEXT:    vfasb %v1, %v1, %v2
; CHECK-NEXT:    vfssb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 64(%r2), 3
; CHECK-NEXT:    vl %v2, 80(%r2), 3
; CHECK-NEXT:    vfasb %v1, %v1, %v2
; CHECK-NEXT:    vl %v2, 96(%r2), 3
; CHECK-NEXT:    vfasb %v1, %v1, %v2
; CHECK-NEXT:    vfssb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 112(%r2), 3
; CHECK-NEXT:    vfssb %v24, %v0, %v1
; CHECK-NEXT:    br %r14
entry:
  %0 = load <4 x float>, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds <4 x float>, ptr %x, i64 1
  %1 = load <4 x float>, ptr %arrayidx1, align 8
  %sub = fsub reassoc nsz arcp contract afn <4 x float> %0, %1
  %arrayidx2 = getelementptr inbounds <4 x float>, ptr %x, i64 2
  %2 = load <4 x float>, ptr %arrayidx2, align 8
  %sub3 = fsub reassoc nsz arcp contract afn <4 x float> %sub, %2
  %arrayidx4 = getelementptr inbounds <4 x float>, ptr %x, i64 3
  %3 = load <4 x float>, ptr %arrayidx4, align 8
  %sub5 = fsub reassoc nsz arcp contract afn <4 x float> %sub3, %3
  %arrayidx6 = getelementptr inbounds <4 x float>, ptr %x, i64 4
  %4 = load <4 x float>, ptr %arrayidx6, align 8
  %sub7 = fsub reassoc nsz arcp contract afn <4 x float> %sub5, %4
  %arrayidx8 = getelementptr inbounds <4 x float>, ptr %x, i64 5
  %5 = load <4 x float>, ptr %arrayidx8, align 8
  %sub9 = fsub reassoc nsz arcp contract afn <4 x float> %sub7, %5
  %arrayidx10 = getelementptr inbounds <4 x float>, ptr %x, i64 6
  %6 = load <4 x float>, ptr %arrayidx10, align 8
  %sub11 = fsub reassoc nsz arcp contract afn <4 x float> %sub9, %6
  %arrayidx12 = getelementptr inbounds <4 x float>, ptr %x, i64 7
  %7 = load <4 x float>, ptr %arrayidx12, align 8
  %sub13 = fsub reassoc nsz arcp contract afn <4 x float> %sub11, %7
  ret <4 x float> %sub13
}

define double @fun10_fmul(ptr %x) {
; CHECK-LABEL: fun10_fmul:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    ld %f0, 8(%r2)
; CHECK-NEXT:    mdb %f0, 0(%r2)
; CHECK-NEXT:    ld %f1, 24(%r2)
; CHECK-NEXT:    mdb %f1, 16(%r2)
; CHECK-NEXT:    mdbr %f0, %f1
; CHECK-NEXT:    ld %f1, 40(%r2)
; CHECK-NEXT:    mdb %f1, 32(%r2)
; CHECK-NEXT:    mdb %f1, 48(%r2)
; CHECK-NEXT:    mdbr %f0, %f1
; CHECK-NEXT:    mdb %f0, 56(%r2)
; CHECK-NEXT:    br %r14
entry:
  %0 = load double, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds double, ptr %x, i64 1
  %1 = load double, ptr %arrayidx1, align 8
  %mul = fmul reassoc nsz arcp contract afn double %0, %1
  %arrayidx2 = getelementptr inbounds double, ptr %x, i64 2
  %2 = load double, ptr %arrayidx2, align 8
  %mul3 = fmul reassoc nsz arcp contract afn double %mul, %2
  %arrayidx4 = getelementptr inbounds double, ptr %x, i64 3
  %3 = load double, ptr %arrayidx4, align 8
  %mul5 = fmul reassoc nsz arcp contract afn double %mul3, %3
  %arrayidx6 = getelementptr inbounds double, ptr %x, i64 4
  %4 = load double, ptr %arrayidx6, align 8
  %mul7 = fmul reassoc nsz arcp contract afn double %mul5, %4
  %arrayidx8 = getelementptr inbounds double, ptr %x, i64 5
  %5 = load double, ptr %arrayidx8, align 8
  %mul9 = fmul reassoc nsz arcp contract afn double %mul7, %5
  %arrayidx10 = getelementptr inbounds double, ptr %x, i64 6
  %6 = load double, ptr %arrayidx10, align 8
  %mul11 = fmul reassoc nsz arcp contract afn double %mul9, %6
  %arrayidx12 = getelementptr inbounds double, ptr %x, i64 7
  %7 = load double, ptr %arrayidx12, align 8
  %mul13 = fmul reassoc nsz arcp contract afn double %mul11, %7
  ret double %mul13
}

define float @fun11_fmul(ptr %x) {
; CHECK-LABEL: fun11_fmul:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lde %f0, 4(%r2)
; CHECK-NEXT:    meeb %f0, 0(%r2)
; CHECK-NEXT:    lde %f1, 12(%r2)
; CHECK-NEXT:    meeb %f1, 8(%r2)
; CHECK-NEXT:    meebr %f0, %f1
; CHECK-NEXT:    lde %f1, 20(%r2)
; CHECK-NEXT:    meeb %f1, 16(%r2)
; CHECK-NEXT:    meeb %f1, 24(%r2)
; CHECK-NEXT:    meebr %f0, %f1
; CHECK-NEXT:    meeb %f0, 28(%r2)
; CHECK-NEXT:    br %r14
entry:
  %0 = load float, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds float, ptr %x, i64 1
  %1 = load float, ptr %arrayidx1, align 8
  %mul = fmul reassoc nsz arcp contract afn float %0, %1
  %arrayidx2 = getelementptr inbounds float, ptr %x, i64 2
  %2 = load float, ptr %arrayidx2, align 8
  %mul3 = fmul reassoc nsz arcp contract afn float %mul, %2
  %arrayidx4 = getelementptr inbounds float, ptr %x, i64 3
  %3 = load float, ptr %arrayidx4, align 8
  %mul5 = fmul reassoc nsz arcp contract afn float %mul3, %3
  %arrayidx6 = getelementptr inbounds float, ptr %x, i64 4
  %4 = load float, ptr %arrayidx6, align 8
  %mul7 = fmul reassoc nsz arcp contract afn float %mul5, %4
  %arrayidx8 = getelementptr inbounds float, ptr %x, i64 5
  %5 = load float, ptr %arrayidx8, align 8
  %mul9 = fmul reassoc nsz arcp contract afn float %mul7, %5
  %arrayidx10 = getelementptr inbounds float, ptr %x, i64 6
  %6 = load float, ptr %arrayidx10, align 8
  %mul11 = fmul reassoc nsz arcp contract afn float %mul9, %6
  %arrayidx12 = getelementptr inbounds float, ptr %x, i64 7
  %7 = load float, ptr %arrayidx12, align 8
  %mul13 = fmul reassoc nsz arcp contract afn float %mul11, %7
  ret float %mul13
}

define fp128 @fun12_fmul(ptr %x) {
; CHECK-LABEL: fun12_fmul:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v0, 0(%r3), 3
; CHECK-NEXT:    vl %v1, 16(%r3), 3
; CHECK-NEXT:    wfmxb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 32(%r3), 3
; CHECK-NEXT:    vl %v2, 48(%r3), 3
; CHECK-NEXT:    wfmxb %v1, %v1, %v2
; CHECK-NEXT:    wfmxb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 64(%r3), 3
; CHECK-NEXT:    vl %v2, 80(%r3), 3
; CHECK-NEXT:    wfmxb %v1, %v1, %v2
; CHECK-NEXT:    vl %v2, 96(%r3), 3
; CHECK-NEXT:    wfmxb %v1, %v1, %v2
; CHECK-NEXT:    wfmxb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 112(%r3), 3
; CHECK-NEXT:    wfmxb %v0, %v0, %v1
; CHECK-NEXT:    vst %v0, 0(%r2), 3
; CHECK-NEXT:    br %r14
entry:
  %0 = load fp128, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds fp128, ptr %x, i64 1
  %1 = load fp128, ptr %arrayidx1, align 8
  %mul = fmul reassoc nsz arcp contract afn fp128 %0, %1
  %arrayidx2 = getelementptr inbounds fp128, ptr %x, i64 2
  %2 = load fp128, ptr %arrayidx2, align 8
  %mul3 = fmul reassoc nsz arcp contract afn fp128 %mul, %2
  %arrayidx4 = getelementptr inbounds fp128, ptr %x, i64 3
  %3 = load fp128, ptr %arrayidx4, align 8
  %mul5 = fmul reassoc nsz arcp contract afn fp128 %mul3, %3
  %arrayidx6 = getelementptr inbounds fp128, ptr %x, i64 4
  %4 = load fp128, ptr %arrayidx6, align 8
  %mul7 = fmul reassoc nsz arcp contract afn fp128 %mul5, %4
  %arrayidx8 = getelementptr inbounds fp128, ptr %x, i64 5
  %5 = load fp128, ptr %arrayidx8, align 8
  %mul9 = fmul reassoc nsz arcp contract afn fp128 %mul7, %5
  %arrayidx10 = getelementptr inbounds fp128, ptr %x, i64 6
  %6 = load fp128, ptr %arrayidx10, align 8
  %mul11 = fmul reassoc nsz arcp contract afn fp128 %mul9, %6
  %arrayidx12 = getelementptr inbounds fp128, ptr %x, i64 7
  %7 = load fp128, ptr %arrayidx12, align 8
  %mul13 = fmul reassoc nsz arcp contract afn fp128 %mul11, %7
  ret fp128 %mul13
}

define <2 x double> @fun13_fmul(ptr %x) {
; CHECK-LABEL: fun13_fmul:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v0, 0(%r2), 3
; CHECK-NEXT:    vl %v1, 16(%r2), 3
; CHECK-NEXT:    vfmdb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 32(%r2), 3
; CHECK-NEXT:    vl %v2, 48(%r2), 3
; CHECK-NEXT:    vfmdb %v1, %v1, %v2
; CHECK-NEXT:    vfmdb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 64(%r2), 3
; CHECK-NEXT:    vl %v2, 80(%r2), 3
; CHECK-NEXT:    vfmdb %v1, %v1, %v2
; CHECK-NEXT:    vl %v2, 96(%r2), 3
; CHECK-NEXT:    vfmdb %v1, %v1, %v2
; CHECK-NEXT:    vfmdb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 112(%r2), 3
; CHECK-NEXT:    vfmdb %v24, %v0, %v1
; CHECK-NEXT:    br %r14
entry:
  %0 = load <2 x double>, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds <2 x double>, ptr %x, i64 1
  %1 = load <2 x double>, ptr %arrayidx1, align 8
  %mul = fmul reassoc nsz arcp contract afn <2 x double> %0, %1
  %arrayidx2 = getelementptr inbounds <2 x double>, ptr %x, i64 2
  %2 = load <2 x double>, ptr %arrayidx2, align 8
  %mul3 = fmul reassoc nsz arcp contract afn <2 x double> %mul, %2
  %arrayidx4 = getelementptr inbounds <2 x double>, ptr %x, i64 3
  %3 = load <2 x double>, ptr %arrayidx4, align 8
  %mul5 = fmul reassoc nsz arcp contract afn <2 x double> %mul3, %3
  %arrayidx6 = getelementptr inbounds <2 x double>, ptr %x, i64 4
  %4 = load <2 x double>, ptr %arrayidx6, align 8
  %mul7 = fmul reassoc nsz arcp contract afn <2 x double> %mul5, %4
  %arrayidx8 = getelementptr inbounds <2 x double>, ptr %x, i64 5
  %5 = load <2 x double>, ptr %arrayidx8, align 8
  %mul9 = fmul reassoc nsz arcp contract afn <2 x double> %mul7, %5
  %arrayidx10 = getelementptr inbounds <2 x double>, ptr %x, i64 6
  %6 = load <2 x double>, ptr %arrayidx10, align 8
  %mul11 = fmul reassoc nsz arcp contract afn <2 x double> %mul9, %6
  %arrayidx12 = getelementptr inbounds <2 x double>, ptr %x, i64 7
  %7 = load <2 x double>, ptr %arrayidx12, align 8
  %mul13 = fmul reassoc nsz arcp contract afn <2 x double> %mul11, %7
  ret <2 x double> %mul13
}

define <4 x float> @fun14_fmul(ptr %x) {
; CHECK-LABEL: fun14_fmul:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl %v0, 0(%r2), 3
; CHECK-NEXT:    vl %v1, 16(%r2), 3
; CHECK-NEXT:    vfmsb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 32(%r2), 3
; CHECK-NEXT:    vl %v2, 48(%r2), 3
; CHECK-NEXT:    vfmsb %v1, %v1, %v2
; CHECK-NEXT:    vfmsb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 64(%r2), 3
; CHECK-NEXT:    vl %v2, 80(%r2), 3
; CHECK-NEXT:    vfmsb %v1, %v1, %v2
; CHECK-NEXT:    vl %v2, 96(%r2), 3
; CHECK-NEXT:    vfmsb %v1, %v1, %v2
; CHECK-NEXT:    vfmsb %v0, %v0, %v1
; CHECK-NEXT:    vl %v1, 112(%r2), 3
; CHECK-NEXT:    vfmsb %v24, %v0, %v1
; CHECK-NEXT:    br %r14
entry:
  %0 = load <4 x float>, ptr %x, align 8
  %arrayidx1 = getelementptr inbounds <4 x float>, ptr %x, i64 1
  %1 = load <4 x float>, ptr %arrayidx1, align 8
  %mul = fmul reassoc nsz arcp contract afn <4 x float> %0, %1
  %arrayidx2 = getelementptr inbounds <4 x float>, ptr %x, i64 2
  %2 = load <4 x float>, ptr %arrayidx2, align 8
  %mul3 = fmul reassoc nsz arcp contract afn <4 x float> %mul, %2
  %arrayidx4 = getelementptr inbounds <4 x float>, ptr %x, i64 3
  %3 = load <4 x float>, ptr %arrayidx4, align 8
  %mul5 = fmul reassoc nsz arcp contract afn <4 x float> %mul3, %3
  %arrayidx6 = getelementptr inbounds <4 x float>, ptr %x, i64 4
  %4 = load <4 x float>, ptr %arrayidx6, align 8
  %mul7 = fmul reassoc nsz arcp contract afn <4 x float> %mul5, %4
  %arrayidx8 = getelementptr inbounds <4 x float>, ptr %x, i64 5
  %5 = load <4 x float>, ptr %arrayidx8, align 8
  %mul9 = fmul reassoc nsz arcp contract afn <4 x float> %mul7, %5
  %arrayidx10 = getelementptr inbounds <4 x float>, ptr %x, i64 6
  %6 = load <4 x float>, ptr %arrayidx10, align 8
  %mul11 = fmul reassoc nsz arcp contract afn <4 x float> %mul9, %6
  %arrayidx12 = getelementptr inbounds <4 x float>, ptr %x, i64 7
  %7 = load <4 x float>, ptr %arrayidx12, align 8
  %mul13 = fmul reassoc nsz arcp contract afn <4 x float> %mul11, %7
  ret <4 x float> %mul13
}
