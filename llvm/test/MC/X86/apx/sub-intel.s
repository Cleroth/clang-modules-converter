# RUN: llvm-mc -triple x86_64 -show-encoding -x86-asm-syntax=intel -output-asm-variant=1 %s | FileCheck %s

# CHECK: {evex}	sub	bl, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x80,0xeb,0x7b]
         {evex}	sub	bl, 123
# CHECK: {nf}	sub	bl, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0x80,0xeb,0x7b]
         {nf}	sub	bl, 123
# CHECK: sub	cl, bl, 123
# CHECK: encoding: [0x62,0xf4,0x74,0x18,0x80,0xeb,0x7b]
         sub	cl, bl, 123
# CHECK: {nf}	sub	cl, bl, 123
# CHECK: encoding: [0x62,0xf4,0x74,0x1c,0x80,0xeb,0x7b]
         {nf}	sub	cl, bl, 123
# CHECK: {evex}	sub	dx, 123
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0x83,0xea,0x7b]
         {evex}	sub	dx, 123
# CHECK: {nf}	sub	dx, 123
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0x83,0xea,0x7b]
         {nf}	sub	dx, 123
# CHECK: sub	ax, dx, 123
# CHECK: encoding: [0x62,0xf4,0x7d,0x18,0x83,0xea,0x7b]
         sub	ax, dx, 123
# CHECK: {nf}	sub	ax, dx, 123
# CHECK: encoding: [0x62,0xf4,0x7d,0x1c,0x83,0xea,0x7b]
         {nf}	sub	ax, dx, 123
# CHECK: {evex}	sub	ecx, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x83,0xe9,0x7b]
         {evex}	sub	ecx, 123
# CHECK: {nf}	sub	ecx, 123
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0x83,0xe9,0x7b]
         {nf}	sub	ecx, 123
# CHECK: sub	edx, ecx, 123
# CHECK: encoding: [0x62,0xf4,0x6c,0x18,0x83,0xe9,0x7b]
         sub	edx, ecx, 123
# CHECK: {nf}	sub	edx, ecx, 123
# CHECK: encoding: [0x62,0xf4,0x6c,0x1c,0x83,0xe9,0x7b]
         {nf}	sub	edx, ecx, 123
# CHECK: {evex}	sub	r9, 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0x83,0xe9,0x7b]
         {evex}	sub	r9, 123
# CHECK: {nf}	sub	r9, 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0x83,0xe9,0x7b]
         {nf}	sub	r9, 123
# CHECK: sub	r15, r9, 123
# CHECK: encoding: [0x62,0xd4,0x84,0x18,0x83,0xe9,0x7b]
         sub	r15, r9, 123
# CHECK: {nf}	sub	r15, r9, 123
# CHECK: encoding: [0x62,0xd4,0x84,0x1c,0x83,0xe9,0x7b]
         {nf}	sub	r15, r9, 123
# CHECK: {evex}	sub	byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x80,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	sub	byte ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	sub	byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0x80,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	sub	byte ptr [r8 + 4*rax + 291], 123
# CHECK: sub	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x64,0x18,0x80,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         sub	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	sub	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x64,0x1c,0x80,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	sub	bl, byte ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	sub	word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	sub	word ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	sub	word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	sub	word ptr [r8 + 4*rax + 291], 123
# CHECK: sub	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         sub	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	sub	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x6d,0x1c,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	sub	dx, word ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	sub	dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	sub	dword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	sub	dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	sub	dword ptr [r8 + 4*rax + 291], 123
# CHECK: sub	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         sub	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	sub	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	sub	ecx, dword ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	sub	qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {evex}	sub	qword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	sub	qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	sub	qword ptr [r8 + 4*rax + 291], 123
# CHECK: sub	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         sub	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: {nf}	sub	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0x83,0xac,0x80,0x23,0x01,0x00,0x00,0x7b]
         {nf}	sub	r9, qword ptr [r8 + 4*rax + 291], 123
# CHECK: {evex}	sub	dx, 1234
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0x81,0xea,0xd2,0x04]
         {evex}	sub	dx, 1234
# CHECK: {nf}	sub	dx, 1234
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0x81,0xea,0xd2,0x04]
         {nf}	sub	dx, 1234
# CHECK: sub	ax, dx, 1234
# CHECK: encoding: [0x62,0xf4,0x7d,0x18,0x81,0xea,0xd2,0x04]
         sub	ax, dx, 1234
# CHECK: {nf}	sub	ax, dx, 1234
# CHECK: encoding: [0x62,0xf4,0x7d,0x1c,0x81,0xea,0xd2,0x04]
         {nf}	sub	ax, dx, 1234
# CHECK: {evex}	sub	word ptr [r8 + 4*rax + 291], 1234
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0xd2,0x04]
         {evex}	sub	word ptr [r8 + 4*rax + 291], 1234
# CHECK: {nf}	sub	word ptr [r8 + 4*rax + 291], 1234
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0xd2,0x04]
         {nf}	sub	word ptr [r8 + 4*rax + 291], 1234
# CHECK: sub	dx, word ptr [r8 + 4*rax + 291], 1234
# CHECK: encoding: [0x62,0xd4,0x6d,0x18,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0xd2,0x04]
         sub	dx, word ptr [r8 + 4*rax + 291], 1234
# CHECK: {nf}	sub	dx, word ptr [r8 + 4*rax + 291], 1234
# CHECK: encoding: [0x62,0xd4,0x6d,0x1c,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0xd2,0x04]
         {nf}	sub	dx, word ptr [r8 + 4*rax + 291], 1234
# CHECK: {evex}	sub	ecx, 123456
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x81,0xe9,0x40,0xe2,0x01,0x00]
         {evex}	sub	ecx, 123456
# CHECK: {nf}	sub	ecx, 123456
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0x81,0xe9,0x40,0xe2,0x01,0x00]
         {nf}	sub	ecx, 123456
# CHECK: sub	edx, ecx, 123456
# CHECK: encoding: [0x62,0xf4,0x6c,0x18,0x81,0xe9,0x40,0xe2,0x01,0x00]
         sub	edx, ecx, 123456
# CHECK: {nf}	sub	edx, ecx, 123456
# CHECK: encoding: [0x62,0xf4,0x6c,0x1c,0x81,0xe9,0x40,0xe2,0x01,0x00]
         {nf}	sub	edx, ecx, 123456
# CHECK: {evex}	sub	r9, 123456
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0x81,0xe9,0x40,0xe2,0x01,0x00]
         {evex}	sub	r9, 123456
# CHECK: {nf}	sub	r9, 123456
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0x81,0xe9,0x40,0xe2,0x01,0x00]
         {nf}	sub	r9, 123456
# CHECK: sub	r15, r9, 123456
# CHECK: encoding: [0x62,0xd4,0x84,0x18,0x81,0xe9,0x40,0xe2,0x01,0x00]
         sub	r15, r9, 123456
# CHECK: {nf}	sub	r15, r9, 123456
# CHECK: encoding: [0x62,0xd4,0x84,0x1c,0x81,0xe9,0x40,0xe2,0x01,0x00]
         {nf}	sub	r15, r9, 123456
# CHECK: {evex}	sub	dword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         {evex}	sub	dword ptr [r8 + 4*rax + 291], 123456
# CHECK: {nf}	sub	dword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         {nf}	sub	dword ptr [r8 + 4*rax + 291], 123456
# CHECK: sub	ecx, dword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         sub	ecx, dword ptr [r8 + 4*rax + 291], 123456
# CHECK: {nf}	sub	ecx, dword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         {nf}	sub	ecx, dword ptr [r8 + 4*rax + 291], 123456
# CHECK: {evex}	sub	qword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0xd4,0xfc,0x08,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         {evex}	sub	qword ptr [r8 + 4*rax + 291], 123456
# CHECK: {nf}	sub	qword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0xd4,0xfc,0x0c,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         {nf}	sub	qword ptr [r8 + 4*rax + 291], 123456
# CHECK: sub	r9, qword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0xd4,0xb4,0x18,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         sub	r9, qword ptr [r8 + 4*rax + 291], 123456
# CHECK: {nf}	sub	r9, qword ptr [r8 + 4*rax + 291], 123456
# CHECK: encoding: [0x62,0xd4,0xb4,0x1c,0x81,0xac,0x80,0x23,0x01,0x00,0x00,0x40,0xe2,0x01,0x00]
         {nf}	sub	r9, qword ptr [r8 + 4*rax + 291], 123456
# CHECK: {evex}	sub	cl, bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x28,0xd9]
         {evex}	sub	cl, bl
# CHECK: {nf}	sub	cl, bl
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0x28,0xd9]
         {nf}	sub	cl, bl
# CHECK: sub	r8b, cl, bl
# CHECK: encoding: [0x62,0xf4,0x3c,0x18,0x28,0xd9]
         sub	r8b, cl, bl
# CHECK: {nf}	sub	r8b, cl, bl
# CHECK: encoding: [0x62,0xf4,0x3c,0x1c,0x28,0xd9]
         {nf}	sub	r8b, cl, bl
# CHECK: {evex}	sub	byte ptr [r8 + 4*rax + 291], bl
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x28,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	sub	byte ptr [r8 + 4*rax + 291], bl
# CHECK: {nf}	sub	byte ptr [r8 + 4*rax + 291], bl
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0x28,0x9c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	byte ptr [r8 + 4*rax + 291], bl
# CHECK: sub	cl, byte ptr [r8 + 4*rax + 291], bl
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0x28,0x9c,0x80,0x23,0x01,0x00,0x00]
         sub	cl, byte ptr [r8 + 4*rax + 291], bl
# CHECK: {nf}	sub	cl, byte ptr [r8 + 4*rax + 291], bl
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0x28,0x9c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	cl, byte ptr [r8 + 4*rax + 291], bl
# CHECK: {evex}	sub	ax, dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x08,0x29,0xd0]
         {evex}	sub	ax, dx
# CHECK: {nf}	sub	ax, dx
# CHECK: encoding: [0x62,0xf4,0x7d,0x0c,0x29,0xd0]
         {nf}	sub	ax, dx
# CHECK: sub	r9w, ax, dx
# CHECK: encoding: [0x62,0xf4,0x35,0x18,0x29,0xd0]
         sub	r9w, ax, dx
# CHECK: {nf}	sub	r9w, ax, dx
# CHECK: encoding: [0x62,0xf4,0x35,0x1c,0x29,0xd0]
         {nf}	sub	r9w, ax, dx
# CHECK: {evex}	sub	word ptr [r8 + 4*rax + 291], dx
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0x29,0x94,0x80,0x23,0x01,0x00,0x00]
         {evex}	sub	word ptr [r8 + 4*rax + 291], dx
# CHECK: {nf}	sub	word ptr [r8 + 4*rax + 291], dx
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0x29,0x94,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	word ptr [r8 + 4*rax + 291], dx
# CHECK: sub	ax, word ptr [r8 + 4*rax + 291], dx
# CHECK: encoding: [0x62,0xd4,0x7d,0x18,0x29,0x94,0x80,0x23,0x01,0x00,0x00]
         sub	ax, word ptr [r8 + 4*rax + 291], dx
# CHECK: {nf}	sub	ax, word ptr [r8 + 4*rax + 291], dx
# CHECK: encoding: [0x62,0xd4,0x7d,0x1c,0x29,0x94,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	ax, word ptr [r8 + 4*rax + 291], dx
# CHECK: {evex}	sub	edx, ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x08,0x29,0xca]
         {evex}	sub	edx, ecx
# CHECK: {nf}	sub	edx, ecx
# CHECK: encoding: [0x62,0xf4,0x7c,0x0c,0x29,0xca]
         {nf}	sub	edx, ecx
# CHECK: sub	r10d, edx, ecx
# CHECK: encoding: [0x62,0xf4,0x2c,0x18,0x29,0xca]
         sub	r10d, edx, ecx
# CHECK: {nf}	sub	r10d, edx, ecx
# CHECK: encoding: [0x62,0xf4,0x2c,0x1c,0x29,0xca]
         {nf}	sub	r10d, edx, ecx
# CHECK: {evex}	sub	dword ptr [r8 + 4*rax + 291], ecx
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x29,0x8c,0x80,0x23,0x01,0x00,0x00]
         {evex}	sub	dword ptr [r8 + 4*rax + 291], ecx
# CHECK: {nf}	sub	dword ptr [r8 + 4*rax + 291], ecx
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0x29,0x8c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	dword ptr [r8 + 4*rax + 291], ecx
# CHECK: sub	edx, dword ptr [r8 + 4*rax + 291], ecx
# CHECK: encoding: [0x62,0xd4,0x6c,0x18,0x29,0x8c,0x80,0x23,0x01,0x00,0x00]
         sub	edx, dword ptr [r8 + 4*rax + 291], ecx
# CHECK: {nf}	sub	edx, dword ptr [r8 + 4*rax + 291], ecx
# CHECK: encoding: [0x62,0xd4,0x6c,0x1c,0x29,0x8c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	edx, dword ptr [r8 + 4*rax + 291], ecx
# CHECK: {evex}	sub	r15, r9
# CHECK: encoding: [0x62,0x54,0xfc,0x08,0x29,0xcf]
         {evex}	sub	r15, r9
# CHECK: {nf}	sub	r15, r9
# CHECK: encoding: [0x62,0x54,0xfc,0x0c,0x29,0xcf]
         {nf}	sub	r15, r9
# CHECK: sub	r11, r15, r9
# CHECK: encoding: [0x62,0x54,0xa4,0x18,0x29,0xcf]
         sub	r11, r15, r9
# CHECK: {nf}	sub	r11, r15, r9
# CHECK: encoding: [0x62,0x54,0xa4,0x1c,0x29,0xcf]
         {nf}	sub	r11, r15, r9
# CHECK: {evex}	sub	qword ptr [r8 + 4*rax + 291], r9
# CHECK: encoding: [0x62,0x54,0xfc,0x08,0x29,0x8c,0x80,0x23,0x01,0x00,0x00]
         {evex}	sub	qword ptr [r8 + 4*rax + 291], r9
# CHECK: {nf}	sub	qword ptr [r8 + 4*rax + 291], r9
# CHECK: encoding: [0x62,0x54,0xfc,0x0c,0x29,0x8c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	qword ptr [r8 + 4*rax + 291], r9
# CHECK: sub	r15, qword ptr [r8 + 4*rax + 291], r9
# CHECK: encoding: [0x62,0x54,0x84,0x18,0x29,0x8c,0x80,0x23,0x01,0x00,0x00]
         sub	r15, qword ptr [r8 + 4*rax + 291], r9
# CHECK: {nf}	sub	r15, qword ptr [r8 + 4*rax + 291], r9
# CHECK: encoding: [0x62,0x54,0x84,0x1c,0x29,0x8c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	r15, qword ptr [r8 + 4*rax + 291], r9
# CHECK: {evex}	sub	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x2a,0x9c,0x80,0x23,0x01,0x00,0x00]
         {evex}	sub	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: {nf}	sub	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0x2a,0x9c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	bl, byte ptr [r8 + 4*rax + 291]
# CHECK: sub	cl, bl, byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x74,0x18,0x2a,0x9c,0x80,0x23,0x01,0x00,0x00]
         sub	cl, bl, byte ptr [r8 + 4*rax + 291]
# CHECK: {nf}	sub	cl, bl, byte ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x74,0x1c,0x2a,0x9c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	cl, bl, byte ptr [r8 + 4*rax + 291]
# CHECK: {evex}	sub	dx, word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7d,0x08,0x2b,0x94,0x80,0x23,0x01,0x00,0x00]
         {evex}	sub	dx, word ptr [r8 + 4*rax + 291]
# CHECK: {nf}	sub	dx, word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7d,0x0c,0x2b,0x94,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	dx, word ptr [r8 + 4*rax + 291]
# CHECK: sub	ax, dx, word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7d,0x18,0x2b,0x94,0x80,0x23,0x01,0x00,0x00]
         sub	ax, dx, word ptr [r8 + 4*rax + 291]
# CHECK: {nf}	sub	ax, dx, word ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7d,0x1c,0x2b,0x94,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	ax, dx, word ptr [r8 + 4*rax + 291]
# CHECK: {evex}	sub	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x08,0x2b,0x8c,0x80,0x23,0x01,0x00,0x00]
         {evex}	sub	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	sub	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x7c,0x0c,0x2b,0x8c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: sub	edx, ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x6c,0x18,0x2b,0x8c,0x80,0x23,0x01,0x00,0x00]
         sub	edx, ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	sub	edx, ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0xd4,0x6c,0x1c,0x2b,0x8c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	edx, ecx, dword ptr [r8 + 4*rax + 291]
# CHECK: {evex}	sub	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0x54,0xfc,0x08,0x2b,0x8c,0x80,0x23,0x01,0x00,0x00]
         {evex}	sub	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	sub	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0x54,0xfc,0x0c,0x2b,0x8c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	r9, qword ptr [r8 + 4*rax + 291]
# CHECK: sub	r15, r9, qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0x54,0x84,0x18,0x2b,0x8c,0x80,0x23,0x01,0x00,0x00]
         sub	r15, r9, qword ptr [r8 + 4*rax + 291]
# CHECK: {nf}	sub	r15, r9, qword ptr [r8 + 4*rax + 291]
# CHECK: encoding: [0x62,0x54,0x84,0x1c,0x2b,0x8c,0x80,0x23,0x01,0x00,0x00]
         {nf}	sub	r15, r9, qword ptr [r8 + 4*rax + 291]
