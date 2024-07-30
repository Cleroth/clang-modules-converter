# RUN: llvm-mc -triple x86_64 -show-encoding %s | FileCheck %s

# CHECK: {evex}	shlb	%al
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd0,0xe0]
         {evex}	shlb	$1, %al
# CHECK: {evex}	shlw	%ax
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0xd1,0xe0]
         {evex}	shlw	$1, %ax
# CHECK: {evex}	shll	%eax
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0xd1,0xe0]
         {evex}	shll	$1, %eax
# CHECK: {evex}	shlq	%rax
# CHECK: encoding: [0x62,0xf4,0xfc,0x08,0xd1,0xe0]
         {evex}	shlq	$1, %rax
# CHECK: {nf}	shlb	%al
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd0,0xe0]
         {nf}	shlb	$1, %al
# CHECK: {nf}	shlw	%ax
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0xd1,0xe0]
         {nf}	shlw	$1, %ax
# CHECK: {nf}	shll	%eax
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0xd1,0xe0]
         {nf}	shll	$1, %eax
# CHECK: {nf}	shlq	%rax
# CHECK: encoding: [0x62,0xf4,0xfc,0x0c,0xd1,0xe0]
         {nf}	shlq	$1, %rax
# CHECK: shlb	%al, %bl
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xd0,0xe0]
         shlb	$1, %al, %bl
# CHECK: shlw	%ax, %bx
# CHECK: encoding: [0x62,0xf4,0x65,0x18,0xd1,0xe0]
         shlw	$1, %ax, %bx
# CHECK: shll	%eax, %ebx
# CHECK: encoding: [0x62,0xf4,0x64,0x18,0xd1,0xe0]
         shll	%eax, %ebx
# CHECK: shlq	%rax, %rbx
# CHECK: encoding: [0x62,0xf4,0xe4,0x18,0xd1,0xe0]
         shlq	$1, %rax, %rbx
# CHECK: {nf}	shlb	%al, %bl
# CHECK: encoding: [0x62,0xf4,0x64,0x1c,0xd0,0xe0]
         {nf}	shlb	$1, %al, %bl
# CHECK: {nf}	shlw	%ax, %bx
# CHECK: encoding: [0x62,0xf4,0x65,0x1c,0xd1,0xe0]
         {nf}	shlw	$1, %ax, %bx
# CHECK: {nf}	shll	%eax, %ebx
# CHECK: encoding: [0x62,0xf4,0x64,0x1c,0xd1,0xe0]
         {nf}	shll	$1, %eax, %ebx
# CHECK: {nf}	shlq	%rax, %rbx
# CHECK: encoding: [0x62,0xf4,0xe4,0x1c,0xd1,0xe0]
         {nf}	shlq	$1, %rax, %rbx
# CHECK: {evex}	shlb	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd0,0x64,0x80,0x7b]
         {evex}	shlb	$1, 123(%r8,%rax,4)
# CHECK: {evex}	shlw	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0xd1,0x64,0x80,0x7b]
         {evex}	shlw	$1, 123(%r8,%rax,4)
# CHECK: {evex}	shll	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0xd1,0x64,0x80,0x7b]
         {evex}	shll	$1, 123(%r8,%rax,4)
# CHECK: {evex}	shlq	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0xd1,0x64,0x80,0x7b]
         {evex}	shlq	$1, 123(%r8,%rax,4)
# CHECK: {nf}	shlb	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd0,0x64,0x80,0x7b]
         {nf}	shlb	$1, 123(%r8,%rax,4)
# CHECK: {nf}	shlw	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0xd1,0x64,0x80,0x7b]
         {nf}	shlw	$1, 123(%r8,%rax,4)
# CHECK: {nf}	shll	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0xd1,0x64,0x80,0x7b]
         {nf}	shll	$1, 123(%r8,%rax,4)
# CHECK: {nf}	shlq	123(%r8,%rax,4)
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0xd1,0x64,0x80,0x7b]
         {nf}	shlq	$1, 123(%r8,%rax,4)
# CHECK: shlb	123(%r8,%rax,4), %bl
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd0,0x64,0x80,0x7b]
         shlb	$1, 123(%r8,%rax,4), %bl
# CHECK: shlw	123(%r8,%rax,4), %bx
# CHECK: encoding: [0x62,0xd4,0x65,0x18,0xd1,0x64,0x80,0x7b]
         shlw	$1, 123(%r8,%rax,4), %bx
# CHECK: shll	123(%r8,%rax,4), %ebx
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0xd1,0x64,0x80,0x7b]
         shll	$1, 123(%r8,%rax,4), %ebx
# CHECK: shlq	123(%r8,%rax,4), %rbx
# CHECK: encoding: [0x62,0xd4,0xe4,0x18,0xd1,0x64,0x80,0x7b]
         shlq	$1, 123(%r8,%rax,4), %rbx
# CHECK: {nf}	shlb	123(%r8,%rax,4), %bl
# CHECK: encoding: [0x62,0xd4,0x64,0x1c,0xd0,0x64,0x80,0x7b]
         {nf}	shlb	$1, 123(%r8,%rax,4), %bl
# CHECK: {nf}	shlw	123(%r8,%rax,4), %bx
# CHECK: encoding: [0x62,0xd4,0x65,0x1c,0xd1,0x64,0x80,0x7b]
         {nf}	shlw	$1, 123(%r8,%rax,4), %bx
# CHECK: {nf}	shll	123(%r8,%rax,4), %ebx
# CHECK: encoding: [0x62,0xd4,0x64,0x1c,0xd1,0x64,0x80,0x7b]
         {nf}	shll	$1, 123(%r8,%rax,4), %ebx
# CHECK: {nf}	shlq	123(%r8,%rax,4), %rbx
# CHECK: encoding: [0x62,0xd4,0xe4,0x1c,0xd1,0x64,0x80,0x7b]
         {nf}	shlq	$1, 123(%r8,%rax,4), %rbx
