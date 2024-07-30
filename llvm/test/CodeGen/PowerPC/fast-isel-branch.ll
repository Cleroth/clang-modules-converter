; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=powerpc64le-unknown-linux-gnu < %s | FileCheck %s -check-prefix=ELF64
; RUN: llc -mtriple=powerpc64-ibm-aix-xcoff < %s | FileCheck %s -check-prefix=AIX64

@x = global i32 1000, align 4

define signext i32 @bar() #0 {
; ELF64-LABEL: bar:
; ELF64:       # %bb.0: # %entry
; ELF64-NEXT:    mflr 0
; ELF64-NEXT:    stdu 1, -112(1)
; ELF64-NEXT:    std 0, 128(1)
; ELF64-NEXT:    .cfi_def_cfa_offset 112
; ELF64-NEXT:    .cfi_offset lr, 16
; ELF64-NEXT:    li 3, 0
; ELF64-NEXT:    stw 3, 108(1)
; ELF64-NEXT:    li 3, 0
; ELF64-NEXT:    stw 3, 104(1)
; ELF64-NEXT:  .LBB0_1: # %for.cond
; ELF64-NEXT:    #
; ELF64-NEXT:    lwz 3, 104(1)
; ELF64-NEXT:    addis 4, 2, .LC0@toc@ha
; ELF64-NEXT:    ld 4, .LC0@toc@l(4)
; ELF64-NEXT:    lwz 4, 0(4)
; ELF64-NEXT:    cmpw 3, 4
; ELF64-NEXT:    bge 0, .LBB0_4
; ELF64-NEXT:  # %bb.2: # %for.body
; ELF64-NEXT:    #
; ELF64-NEXT:    bl foo
; ELF64-NEXT:    nop
; ELF64-NEXT:  # %bb.3: # %for.inc
; ELF64-NEXT:    #
; ELF64-NEXT:    lwz 3, 104(1)
; ELF64-NEXT:    addi 3, 3, 1
; ELF64-NEXT:    stw 3, 104(1)
; ELF64-NEXT:    b .LBB0_1
; ELF64-NEXT:  .LBB0_4: # %for.end
; ELF64-NEXT:    li 3, 0
; ELF64-NEXT:    addi 1, 1, 112
; ELF64-NEXT:    ld 0, 16(1)
; ELF64-NEXT:    mtlr 0
; ELF64-NEXT:    blr
;
; AIX64-LABEL: bar:
; AIX64:       # %bb.0: # %entry
; AIX64-NEXT:    mflr 0
; AIX64-NEXT:    stdu 1, -128(1)
; AIX64-NEXT:    std 0, 144(1)
; AIX64-NEXT:    li 3, 0
; AIX64-NEXT:    stw 3, 124(1)
; AIX64-NEXT:    li 3, 0
; AIX64-NEXT:    stw 3, 120(1)
; AIX64-NEXT:  L..BB0_1: # %for.cond
; AIX64-NEXT:    #
; AIX64-NEXT:    lwz 3, 120(1)
; AIX64-NEXT:    ld 4, L..C0(2) # @x
; AIX64-NEXT:    lwz 4, 0(4)
; AIX64-NEXT:    cmpw 3, 4
; AIX64-NEXT:    bge 0, L..BB0_4
; AIX64-NEXT:  # %bb.2: # %for.body
; AIX64-NEXT:    #
; AIX64-NEXT:    bl .foo[PR]
; AIX64-NEXT:    nop
; AIX64-NEXT:  # %bb.3: # %for.inc
; AIX64-NEXT:    #
; AIX64-NEXT:    lwz 3, 120(1)
; AIX64-NEXT:    addi 3, 3, 1
; AIX64-NEXT:    stw 3, 120(1)
; AIX64-NEXT:    b L..BB0_1
; AIX64-NEXT:  L..BB0_4: # %for.end
; AIX64-NEXT:    li 3, 0
; AIX64-NEXT:    addi 1, 1, 128
; AIX64-NEXT:    ld 0, 16(1)
; AIX64-NEXT:    mtlr 0
; AIX64-NEXT:    blr
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:
  %0 = load i32, ptr %i, align 4
  %1 = load i32, ptr @x, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:
  call void @foo()
  br label %for.inc

for.inc:
  %2 = load i32, ptr %i, align 4
  %inc = add nsw i32 %2, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond

for.end:
  ret i32 0
}

declare void @foo(...)

attributes #0 = { optnone noinline }
