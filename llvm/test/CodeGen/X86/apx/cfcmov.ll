; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+cf -verify-machineinstrs | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+cf -x86-cmov-converter=false -verify-machineinstrs | FileCheck %s

define i8 @cfcmov8rr(i8 %0) {
; CHECK-LABEL: cfcmov8rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpb $1, %dil
; CHECK-NEXT:    cfcmovel %edi, %eax
; CHECK-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NEXT:    retq
  %2 = icmp eq i8 %0, 1
  %3 = select i1 %2, i8 %0, i8 0
  ret i8 %3
}

define i16 @cfcmov16rr(i16 %0) {
; CHECK-LABEL: cfcmov16rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpw $1, %di
; CHECK-NEXT:    cfcmovnel %edi, %eax
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq
  %2 = icmp ne i16 %0, 1
  %3 = select i1 %2, i16 %0, i16 0
  ret i16 %3
}

define i32 @cfcmov32rr(i32 %0) {
; CHECK-LABEL: cfcmov32rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpl $2, %edi
; CHECK-NEXT:    cfcmovael %edi, %eax
; CHECK-NEXT:    retq
  %2 = icmp ugt i32 %0, 1
  %3 = select i1 %2, i32 %0, i32 0
  ret i32 %3
}

define i64 @cfcmov64rr(i64 %0) {
; CHECK-LABEL: cfcmov64rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    testq %rdi, %rdi
; CHECK-NEXT:    cfcmoveq %rdi, %rax
; CHECK-NEXT:    retq
  %2 = icmp ult i64 %0, 1
  %3 = select i1 %2, i64 %0, i64 0
  ret i64 %3
}

define i8 @cfcmov8rr_inv(i8 %0) {
; CHECK-LABEL: cfcmov8rr_inv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpb $1, %dil
; CHECK-NEXT:    cfcmovnel %edi, %eax
; CHECK-NEXT:    # kill: def $al killed $al killed $eax
; CHECK-NEXT:    retq
  %2 = icmp eq i8 %0, 1
  %3 = select i1 %2, i8 0, i8 %0
  ret i8 %3
}

define i16 @cfcmov16rr_inv(i16 %0) {
; CHECK-LABEL: cfcmov16rr_inv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpw $1, %di
; CHECK-NEXT:    cfcmovel %edi, %eax
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq
  %2 = icmp ne i16 %0, 1
  %3 = select i1 %2, i16 0, i16 %0
  ret i16 %3
}

define i32 @cfcmov32rr_inv(i32 %0) {
; CHECK-LABEL: cfcmov32rr_inv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpl $2, %edi
; CHECK-NEXT:    cfcmovbl %edi, %eax
; CHECK-NEXT:    retq
  %2 = icmp ugt i32 %0, 1
  %3 = select i1 %2, i32 0, i32 %0
  ret i32 %3
}

define i64 @cfcmov64rr_inv(i64 %0) {
; CHECK-LABEL: cfcmov64rr_inv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpq $2, %rdi
; CHECK-NEXT:    cfcmovaeq %rdi, %rax
; CHECK-NEXT:    retq
  %2 = icmp ule i64 %0, 1
  %3 = select i1 %2, i64 0, i64 %0
  ret i64 %3
}
