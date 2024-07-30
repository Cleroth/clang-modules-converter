; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+avx512vl | FileCheck %s --check-prefixes=CHECK,EVEX512
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+avx512vl,-evex512 | FileCheck %s --check-prefixes=CHECK,EVEX256

; 256-bit

define <32 x i8> @vpaddb256_test(<32 x i8> %i, <32 x i8> %j) nounwind readnone {
; CHECK-LABEL: vpaddb256_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpaddb %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    retq
  %x = add <32 x i8> %i, %j
  ret <32 x i8> %x
}

define <32 x i8> @vpaddb256_fold_test(<32 x i8> %i, ptr %j) nounwind {
; CHECK-LABEL: vpaddb256_fold_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpaddb (%rdi), %ymm0, %ymm0
; CHECK-NEXT:    retq
  %tmp = load <32 x i8>, ptr %j, align 4
  %x = add <32 x i8> %i, %tmp
  ret <32 x i8> %x
}

define <16 x i16> @vpaddw256_test(<16 x i16> %i, <16 x i16> %j) nounwind readnone {
; CHECK-LABEL: vpaddw256_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpaddw %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    retq
  %x = add <16 x i16> %i, %j
  ret <16 x i16> %x
}

define <16 x i16> @vpaddw256_fold_test(<16 x i16> %i, ptr %j) nounwind {
; CHECK-LABEL: vpaddw256_fold_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpaddw (%rdi), %ymm0, %ymm0
; CHECK-NEXT:    retq
  %tmp = load <16 x i16>, ptr %j, align 4
  %x = add <16 x i16> %i, %tmp
  ret <16 x i16> %x
}

define <16 x i16> @vpaddw256_mask_test(<16 x i16> %i, <16 x i16> %j, <16 x i16> %mask1) nounwind readnone {
; CHECK-LABEL: vpaddw256_mask_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmw %ymm2, %ymm2, %k1
; CHECK-NEXT:    vpaddw %ymm1, %ymm0, %ymm0 {%k1}
; CHECK-NEXT:    retq
  %mask = icmp ne <16 x i16> %mask1, zeroinitializer
  %x = add <16 x i16> %i, %j
  %r = select <16 x i1> %mask, <16 x i16> %x, <16 x i16> %i
  ret <16 x i16> %r
}

define <16 x i16> @vpaddw256_maskz_test(<16 x i16> %i, <16 x i16> %j, <16 x i16> %mask1) nounwind readnone {
; CHECK-LABEL: vpaddw256_maskz_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmw %ymm2, %ymm2, %k1
; CHECK-NEXT:    vpaddw %ymm1, %ymm0, %ymm0 {%k1} {z}
; CHECK-NEXT:    retq
  %mask = icmp ne <16 x i16> %mask1, zeroinitializer
  %x = add <16 x i16> %i, %j
  %r = select <16 x i1> %mask, <16 x i16> %x, <16 x i16> zeroinitializer
  ret <16 x i16> %r
}

define <16 x i16> @vpaddw256_mask_fold_test(<16 x i16> %i, ptr %j.ptr, <16 x i16> %mask1) nounwind readnone {
; CHECK-LABEL: vpaddw256_mask_fold_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmw %ymm1, %ymm1, %k1
; CHECK-NEXT:    vpaddw (%rdi), %ymm0, %ymm0 {%k1}
; CHECK-NEXT:    retq
  %mask = icmp ne <16 x i16> %mask1, zeroinitializer
  %j = load <16 x i16>, ptr %j.ptr
  %x = add <16 x i16> %i, %j
  %r = select <16 x i1> %mask, <16 x i16> %x, <16 x i16> %i
  ret <16 x i16> %r
}

define <16 x i16> @vpaddw256_maskz_fold_test(<16 x i16> %i, ptr %j.ptr, <16 x i16> %mask1) nounwind readnone {
; CHECK-LABEL: vpaddw256_maskz_fold_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmw %ymm1, %ymm1, %k1
; CHECK-NEXT:    vpaddw (%rdi), %ymm0, %ymm0 {%k1} {z}
; CHECK-NEXT:    retq
  %mask = icmp ne <16 x i16> %mask1, zeroinitializer
  %j = load <16 x i16>, ptr %j.ptr
  %x = add <16 x i16> %i, %j
  %r = select <16 x i1> %mask, <16 x i16> %x, <16 x i16> zeroinitializer
  ret <16 x i16> %r
}

define <32 x i8> @vpsubb256_test(<32 x i8> %i, <32 x i8> %j) nounwind readnone {
; CHECK-LABEL: vpsubb256_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpsubb %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    retq
  %x = sub <32 x i8> %i, %j
  ret <32 x i8> %x
}

define <16 x i16> @vpsubw256_test(<16 x i16> %i, <16 x i16> %j) nounwind readnone {
; CHECK-LABEL: vpsubw256_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpsubw %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    retq
  %x = sub <16 x i16> %i, %j
  ret <16 x i16> %x
}

define <16 x i16> @vpmullw256_test(<16 x i16> %i, <16 x i16> %j) {
; CHECK-LABEL: vpmullw256_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpmullw %ymm1, %ymm0, %ymm0
; CHECK-NEXT:    retq
  %x = mul <16 x i16> %i, %j
  ret <16 x i16> %x
}

; 128-bit

define <16 x i8> @vpaddb128_test(<16 x i8> %i, <16 x i8> %j) nounwind readnone {
; CHECK-LABEL: vpaddb128_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpaddb %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %x = add <16 x i8> %i, %j
  ret <16 x i8> %x
}

define <16 x i8> @vpaddb128_fold_test(<16 x i8> %i, ptr %j) nounwind {
; CHECK-LABEL: vpaddb128_fold_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpaddb (%rdi), %xmm0, %xmm0
; CHECK-NEXT:    retq
  %tmp = load <16 x i8>, ptr %j, align 4
  %x = add <16 x i8> %i, %tmp
  ret <16 x i8> %x
}

define <8 x i16> @vpaddw128_test(<8 x i16> %i, <8 x i16> %j) nounwind readnone {
; CHECK-LABEL: vpaddw128_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpaddw %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %x = add <8 x i16> %i, %j
  ret <8 x i16> %x
}

define <8 x i16> @vpaddw128_fold_test(<8 x i16> %i, ptr %j) nounwind {
; CHECK-LABEL: vpaddw128_fold_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpaddw (%rdi), %xmm0, %xmm0
; CHECK-NEXT:    retq
  %tmp = load <8 x i16>, ptr %j, align 4
  %x = add <8 x i16> %i, %tmp
  ret <8 x i16> %x
}

define <8 x i16> @vpaddw128_mask_test(<8 x i16> %i, <8 x i16> %j, <8 x i16> %mask1) nounwind readnone {
; CHECK-LABEL: vpaddw128_mask_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmw %xmm2, %xmm2, %k1
; CHECK-NEXT:    vpaddw %xmm1, %xmm0, %xmm0 {%k1}
; CHECK-NEXT:    retq
  %mask = icmp ne <8 x i16> %mask1, zeroinitializer
  %x = add <8 x i16> %i, %j
  %r = select <8 x i1> %mask, <8 x i16> %x, <8 x i16> %i
  ret <8 x i16> %r
}

define <8 x i16> @vpaddw128_maskz_test(<8 x i16> %i, <8 x i16> %j, <8 x i16> %mask1) nounwind readnone {
; CHECK-LABEL: vpaddw128_maskz_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmw %xmm2, %xmm2, %k1
; CHECK-NEXT:    vpaddw %xmm1, %xmm0, %xmm0 {%k1} {z}
; CHECK-NEXT:    retq
  %mask = icmp ne <8 x i16> %mask1, zeroinitializer
  %x = add <8 x i16> %i, %j
  %r = select <8 x i1> %mask, <8 x i16> %x, <8 x i16> zeroinitializer
  ret <8 x i16> %r
}

define <8 x i16> @vpaddw128_mask_fold_test(<8 x i16> %i, ptr %j.ptr, <8 x i16> %mask1) nounwind readnone {
; CHECK-LABEL: vpaddw128_mask_fold_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmw %xmm1, %xmm1, %k1
; CHECK-NEXT:    vpaddw (%rdi), %xmm0, %xmm0 {%k1}
; CHECK-NEXT:    retq
  %mask = icmp ne <8 x i16> %mask1, zeroinitializer
  %j = load <8 x i16>, ptr %j.ptr
  %x = add <8 x i16> %i, %j
  %r = select <8 x i1> %mask, <8 x i16> %x, <8 x i16> %i
  ret <8 x i16> %r
}

define <8 x i16> @vpaddw128_maskz_fold_test(<8 x i16> %i, ptr %j.ptr, <8 x i16> %mask1) nounwind readnone {
; CHECK-LABEL: vpaddw128_maskz_fold_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vptestmw %xmm1, %xmm1, %k1
; CHECK-NEXT:    vpaddw (%rdi), %xmm0, %xmm0 {%k1} {z}
; CHECK-NEXT:    retq
  %mask = icmp ne <8 x i16> %mask1, zeroinitializer
  %j = load <8 x i16>, ptr %j.ptr
  %x = add <8 x i16> %i, %j
  %r = select <8 x i1> %mask, <8 x i16> %x, <8 x i16> zeroinitializer
  ret <8 x i16> %r
}

define <16 x i8> @vpsubb128_test(<16 x i8> %i, <16 x i8> %j) nounwind readnone {
; CHECK-LABEL: vpsubb128_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpsubb %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %x = sub <16 x i8> %i, %j
  ret <16 x i8> %x
}

define <8 x i16> @vpsubw128_test(<8 x i16> %i, <8 x i16> %j) nounwind readnone {
; CHECK-LABEL: vpsubw128_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpsubw %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %x = sub <8 x i16> %i, %j
  ret <8 x i16> %x
}

define <8 x i16> @vpmullw128_test(<8 x i16> %i, <8 x i16> %j) {
; CHECK-LABEL: vpmullw128_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpmullw %xmm1, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %x = mul <8 x i16> %i, %j
  ret <8 x i16> %x
}

define i16 @PR90356(<16 x i1> %a) {
; EVEX512-LABEL: PR90356:
; EVEX512:       # %bb.0:
; EVEX512-NEXT:    vpsllw $7, %xmm0, %xmm0
; EVEX512-NEXT:    vpmovb2m %xmm0, %k1
; EVEX512-NEXT:    vpternlogd $255, %zmm0, %zmm0, %zmm0 {%k1} {z}
; EVEX512-NEXT:    movb $63, %al
; EVEX512-NEXT:    kmovd %eax, %k1
; EVEX512-NEXT:    vpexpandq %zmm0, %zmm0 {%k1} {z}
; EVEX512-NEXT:    vptestmd %zmm0, %zmm0, %k0
; EVEX512-NEXT:    kmovd %k0, %eax
; EVEX512-NEXT:    # kill: def $ax killed $ax killed $eax
; EVEX512-NEXT:    vzeroupper
; EVEX512-NEXT:    retq
;
; EVEX256-LABEL: PR90356:
; EVEX256:       # %bb.0:
; EVEX256-NEXT:    vpsllw $7, %xmm0, %xmm0
; EVEX256-NEXT:    vpmovb2m %xmm0, %k0
; EVEX256-NEXT:    vpmovm2w %k0, %ymm0
; EVEX256-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; EVEX256-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1,2,3,4,5],ymm1[6,7]
; EVEX256-NEXT:    vpmovw2m %ymm0, %k0
; EVEX256-NEXT:    kmovd %k0, %eax
; EVEX256-NEXT:    # kill: def $ax killed $ax killed $eax
; EVEX256-NEXT:    vzeroupper
; EVEX256-NEXT:    retq
  %1 = shufflevector <16 x i1> %a, <16 x i1> zeroinitializer, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 28, i32 29, i32 30, i32 31>
  %2 = bitcast <16 x i1> %1 to i16
  ret i16 %2
}
