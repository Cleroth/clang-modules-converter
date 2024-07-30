# RUN: llvm-mc -triple x86_64 -show-encoding -x86-asm-syntax=intel -output-asm-variant=1 %s | FileCheck %s

# CHECK: jmpabs	1
# CHECK: encoding: [0xd5,0x00,0xa1,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
         jmpabs	1
# CHECK: jmpabs	72623859790382856
# CHECK: encoding: [0xd5,0x00,0xa1,0x08,0x07,0x06,0x05,0x04,0x03,0x02,0x01]
         jmpabs	72623859790382856
