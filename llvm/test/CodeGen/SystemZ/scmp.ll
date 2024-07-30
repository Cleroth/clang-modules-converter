; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=s390x-linux-gnu -mcpu=z13 | FileCheck %s

define i8 @scmp.8.8(i8 signext %x, i8 signext %y) nounwind {
; CHECK-LABEL: scmp.8.8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cr %r2, %r3
; CHECK-NEXT:    lhi %r2, 0
; CHECK-NEXT:    lochih %r2, 1
; CHECK-NEXT:    lochil %r2, -1
; CHECK-NEXT:    br %r14
  %1 = call i8 @llvm.scmp(i8 %x, i8 %y)
  ret i8 %1
}

define i8 @scmp.8.16(i16 signext %x, i16 signext %y) nounwind {
; CHECK-LABEL: scmp.8.16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cr %r2, %r3
; CHECK-NEXT:    lhi %r2, 0
; CHECK-NEXT:    lochih %r2, 1
; CHECK-NEXT:    lochil %r2, -1
; CHECK-NEXT:    br %r14
  %1 = call i8 @llvm.scmp(i16 %x, i16 %y)
  ret i8 %1
}

define i8 @scmp.8.32(i32 %x, i32 %y) nounwind {
; CHECK-LABEL: scmp.8.32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cr %r2, %r3
; CHECK-NEXT:    lhi %r2, 0
; CHECK-NEXT:    lochih %r2, 1
; CHECK-NEXT:    lochil %r2, -1
; CHECK-NEXT:    br %r14
  %1 = call i8 @llvm.scmp(i32 %x, i32 %y)
  ret i8 %1
}

define i8 @scmp.8.64(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: scmp.8.64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cgr %r2, %r3
; CHECK-NEXT:    lhi %r2, 0
; CHECK-NEXT:    lochih %r2, 1
; CHECK-NEXT:    lochil %r2, -1
; CHECK-NEXT:    br %r14
  %1 = call i8 @llvm.scmp(i64 %x, i64 %y)
  ret i8 %1
}

define i8 @scmp.8.128(i128 %x, i128 %y) nounwind {
; CHECK-LABEL: scmp.8.128:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl %v0, 0(%r3), 3
; CHECK-NEXT:    vl %v1, 0(%r2), 3
; CHECK-NEXT:    vecg %v0, %v1
; CHECK-NEXT:    jlh .LBB4_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    vchlgs %v2, %v1, %v0
; CHECK-NEXT:  .LBB4_2:
; CHECK-NEXT:    lhi %r2, 0
; CHECK-NEXT:    lochil %r2, 1
; CHECK-NEXT:    vecg %v1, %v0
; CHECK-NEXT:    jlh .LBB4_4
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    vchlgs %v0, %v0, %v1
; CHECK-NEXT:  .LBB4_4:
; CHECK-NEXT:    lochil %r2, -1
; CHECK-NEXT:    br %r14
  %1 = call i8 @llvm.scmp(i128 %x, i128 %y)
  ret i8 %1
}

define i32 @scmp.32.32(i32 %x, i32 %y) nounwind {
; CHECK-LABEL: scmp.32.32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cr %r2, %r3
; CHECK-NEXT:    lhi %r2, 0
; CHECK-NEXT:    lochih %r2, 1
; CHECK-NEXT:    lochil %r2, -1
; CHECK-NEXT:    br %r14
  %1 = call i32 @llvm.scmp(i32 %x, i32 %y)
  ret i32 %1
}

define i32 @scmp.32.64(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: scmp.32.64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cgr %r2, %r3
; CHECK-NEXT:    lhi %r2, 0
; CHECK-NEXT:    lochih %r2, 1
; CHECK-NEXT:    lochil %r2, -1
; CHECK-NEXT:    br %r14
  %1 = call i32 @llvm.scmp(i64 %x, i64 %y)
  ret i32 %1
}

define i64 @scmp.64.64(i64 %x, i64 %y) nounwind {
; CHECK-LABEL: scmp.64.64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cgr %r2, %r3
; CHECK-NEXT:    lghi %r2, 0
; CHECK-NEXT:    locghih %r2, 1
; CHECK-NEXT:    locghil %r2, -1
; CHECK-NEXT:    br %r14
  %1 = call i64 @llvm.scmp(i64 %x, i64 %y)
  ret i64 %1
}
