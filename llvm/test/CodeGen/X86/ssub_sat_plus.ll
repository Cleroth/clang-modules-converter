; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686 -mattr=cmov | FileCheck %s --check-prefix=X86
; RUN: llc < %s -mtriple=x86_64-linux | FileCheck %s --check-prefix=X64

declare i4 @llvm.ssub.sat.i4(i4, i4)
declare i8 @llvm.ssub.sat.i8(i8, i8)
declare i16 @llvm.ssub.sat.i16(i16, i16)
declare i32 @llvm.ssub.sat.i32(i32, i32)
declare i64 @llvm.ssub.sat.i64(i64, i64)

define i32 @func32(i32 %x, i32 %y, i32 %z) nounwind {
; X86-LABEL: func32:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    imull {{[0-9]+}}(%esp), %edx
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    cmpl %edx, %eax
; X86-NEXT:    setns %cl
; X86-NEXT:    addl $2147483647, %ecx # imm = 0x7FFFFFFF
; X86-NEXT:    subl %edx, %eax
; X86-NEXT:    cmovol %ecx, %eax
; X86-NEXT:    retl
;
; X64-LABEL: func32:
; X64:       # %bb.0:
; X64-NEXT:    imull %edx, %esi
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpl %esi, %edi
; X64-NEXT:    setns %al
; X64-NEXT:    addl $2147483647, %eax # imm = 0x7FFFFFFF
; X64-NEXT:    subl %esi, %edi
; X64-NEXT:    cmovnol %edi, %eax
; X64-NEXT:    retq
  %a = mul i32 %y, %z
  %tmp = call i32 @llvm.ssub.sat.i32(i32 %x, i32 %a)
  ret i32 %tmp
}

define i64 @func64(i64 %x, i64 %y, i64 %z) nounwind {
; X86-LABEL: func64:
; X86:       # %bb.0:
; X86-NEXT:    pushl %ebx
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    subl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    sbbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    seto %bl
; X86-NEXT:    movl %ecx, %edx
; X86-NEXT:    sarl $31, %edx
; X86-NEXT:    testb %bl, %bl
; X86-NEXT:    cmovnel %edx, %eax
; X86-NEXT:    addl $-2147483648, %edx # imm = 0x80000000
; X86-NEXT:    testb %bl, %bl
; X86-NEXT:    cmovel %ecx, %edx
; X86-NEXT:    popl %ebx
; X86-NEXT:    retl
;
; X64-LABEL: func64:
; X64:       # %bb.0:
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    cmpq %rdx, %rdi
; X64-NEXT:    setns %cl
; X64-NEXT:    movabsq $9223372036854775807, %rax # imm = 0x7FFFFFFFFFFFFFFF
; X64-NEXT:    addq %rcx, %rax
; X64-NEXT:    subq %rdx, %rdi
; X64-NEXT:    cmovnoq %rdi, %rax
; X64-NEXT:    retq
  %a = mul i64 %y, %z
  %tmp = call i64 @llvm.ssub.sat.i64(i64 %x, i64 %z)
  ret i64 %tmp
}

define signext i16 @func16(i16 signext %x, i16 signext %y, i16 signext %z) nounwind {
; X86-LABEL: func16:
; X86:       # %bb.0:
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    movzwl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    imulw {{[0-9]+}}(%esp), %dx
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    cmpw %dx, %ax
; X86-NEXT:    setns %cl
; X86-NEXT:    addl $32767, %ecx # imm = 0x7FFF
; X86-NEXT:    subw %dx, %ax
; X86-NEXT:    cmovol %ecx, %eax
; X86-NEXT:    # kill: def $ax killed $ax killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: func16:
; X64:       # %bb.0:
; X64-NEXT:    imull %edx, %esi
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    cmpw %si, %di
; X64-NEXT:    setns %al
; X64-NEXT:    addl $32767, %eax # imm = 0x7FFF
; X64-NEXT:    subw %si, %di
; X64-NEXT:    cmovnol %edi, %eax
; X64-NEXT:    # kill: def $ax killed $ax killed $eax
; X64-NEXT:    retq
  %a = mul i16 %y, %z
  %tmp = call i16 @llvm.ssub.sat.i16(i16 %x, i16 %a)
  ret i16 %tmp
}

define signext i8 @func8(i8 signext %x, i8 signext %y, i8 signext %z) nounwind {
; X86-LABEL: func8:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %edx
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    mulb {{[0-9]+}}(%esp)
; X86-NEXT:    xorl %ecx, %ecx
; X86-NEXT:    cmpb %al, %dl
; X86-NEXT:    setns %cl
; X86-NEXT:    addl $127, %ecx
; X86-NEXT:    subb %al, %dl
; X86-NEXT:    movzbl %dl, %eax
; X86-NEXT:    cmovol %ecx, %eax
; X86-NEXT:    # kill: def $al killed $al killed $eax
; X86-NEXT:    retl
;
; X64-LABEL: func8:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    mulb %dl
; X64-NEXT:    xorl %ecx, %ecx
; X64-NEXT:    cmpb %al, %dil
; X64-NEXT:    setns %cl
; X64-NEXT:    addl $127, %ecx
; X64-NEXT:    subb %al, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    cmovol %ecx, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    retq
  %a = mul i8 %y, %z
  %tmp = call i8 @llvm.ssub.sat.i8(i8 %x, i8 %a)
  ret i8 %tmp
}

define signext i4 @func4(i4 signext %x, i4 signext %y, i4 signext %z) nounwind {
; X86-LABEL: func4:
; X86:       # %bb.0:
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X86-NEXT:    movzbl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    mulb {{[0-9]+}}(%esp)
; X86-NEXT:    shlb $4, %al
; X86-NEXT:    sarb $4, %al
; X86-NEXT:    subb %al, %cl
; X86-NEXT:    movzbl %cl, %eax
; X86-NEXT:    cmpb $7, %cl
; X86-NEXT:    movl $7, %ecx
; X86-NEXT:    cmovll %eax, %ecx
; X86-NEXT:    cmpb $-7, %cl
; X86-NEXT:    movl $248, %eax
; X86-NEXT:    cmovgel %ecx, %eax
; X86-NEXT:    movsbl %al, %eax
; X86-NEXT:    retl
;
; X64-LABEL: func4:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    # kill: def $al killed $al killed $eax
; X64-NEXT:    mulb %dl
; X64-NEXT:    shlb $4, %al
; X64-NEXT:    sarb $4, %al
; X64-NEXT:    subb %al, %dil
; X64-NEXT:    movzbl %dil, %eax
; X64-NEXT:    cmpb $7, %al
; X64-NEXT:    movl $7, %ecx
; X64-NEXT:    cmovll %eax, %ecx
; X64-NEXT:    cmpb $-7, %cl
; X64-NEXT:    movl $248, %eax
; X64-NEXT:    cmovgel %ecx, %eax
; X64-NEXT:    movsbl %al, %eax
; X64-NEXT:    retq
  %a = mul i4 %y, %z
  %tmp = call i4 @llvm.ssub.sat.i4(i4 %x, i4 %a)
  ret i4 %tmp
}
