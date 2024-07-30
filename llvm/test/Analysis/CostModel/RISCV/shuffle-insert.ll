; NOTE: Assertions have been autogenerated by utils/update_analyze_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=riscv32 -mattr=+v | FileCheck %s -check-prefixes=CHECK,RV32
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=riscv64 -mattr=+v | FileCheck %s -check-prefixes=CHECK,RV64
; RUN: opt < %s -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=riscv32 -mattr=+v | FileCheck %s -check-prefixes=CHECK-SIZE,RV32-SIZE
; RUN: opt < %s -passes="print<cost-model>" -cost-kind=code-size 2>&1 -disable-output -mtriple=riscv64 -mattr=+v | FileCheck %s -check-prefixes=CHECK-SIZE,RV64-SIZE

define <8 x i8> @insert_subvector_middle_v8i8(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: 'insert_subvector_middle_v8i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 10, i32 11, i32 6, i32 7>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i8> %res
;
; CHECK-SIZE-LABEL: 'insert_subvector_middle_v8i8'
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 10, i32 11, i32 6, i32 7>
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret <8 x i8> %res
;
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 8, i32 9, i32 10, i32 11, i32 6, i32 7>
  ret <8 x i8> %res
}

define <8 x i8> @insert_subvector_end_v8i8(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: 'insert_subvector_end_v8i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i8> %res
;
; CHECK-SIZE-LABEL: 'insert_subvector_end_v8i8'
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret <8 x i8> %res
;
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 10, i32 11>
  ret <8 x i8> %res
}

define <8 x i8> @insert_subvector_end_swapped_v8i8(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: 'insert_subvector_end_swapped_v8i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 0, i32 1, i32 2, i32 3>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i8> %res
;
; CHECK-SIZE-LABEL: 'insert_subvector_end_swapped_v8i8'
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 0, i32 1, i32 2, i32 3>
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret <8 x i8> %res
;
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 8, i32 9, i32 10, i32 11, i32 0, i32 1, i32 2, i32 3>
  ret <8 x i8> %res
}

define <8 x i8> @insert_subvector_short_v8i8(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: 'insert_subvector_short_v8i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i8> %res
;
; CHECK-SIZE-LABEL: 'insert_subvector_short_v8i8'
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret <8 x i8> %res
;
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 8, i32 9, i32 6, i32 7>
  ret <8 x i8> %res
}

define <8 x i8> @insert_subvector_offset_1_v8i8(<8 x i8> %v, <8 x i8> %w) {
; CHECK-LABEL: 'insert_subvector_offset_1_v8i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 8, i32 9, i32 10, i32 11, i32 5, i32 6, i32 7>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i8> %res
;
; CHECK-SIZE-LABEL: 'insert_subvector_offset_1_v8i8'
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 8, i32 9, i32 10, i32 11, i32 5, i32 6, i32 7>
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret <8 x i8> %res
;
  %res = shufflevector <8 x i8> %v, <8 x i8> %w, <8 x i32> <i32 0, i32 8, i32 9, i32 10, i32 11, i32 5, i32 6, i32 7>
  ret <8 x i8> %res
}

define <8 x i64> @insert_subvector_offset_1_v8i64(<8 x i64> %v, <8 x i64> %w) {
; CHECK-LABEL: 'insert_subvector_offset_1_v8i64'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 4 for instruction: %res = shufflevector <8 x i64> %v, <8 x i64> %w, <8 x i32> <i32 0, i32 8, i32 9, i32 10, i32 11, i32 5, i32 6, i32 7>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i64> %res
;
; CHECK-SIZE-LABEL: 'insert_subvector_offset_1_v8i64'
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %res = shufflevector <8 x i64> %v, <8 x i64> %w, <8 x i32> <i32 0, i32 8, i32 9, i32 10, i32 11, i32 5, i32 6, i32 7>
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret <8 x i64> %res
;
  %res = shufflevector <8 x i64> %v, <8 x i64> %w, <8 x i32> <i32 0, i32 8, i32 9, i32 10, i32 11, i32 5, i32 6, i32 7>
  ret <8 x i64> %res
}

; FIXME: This is expensive and involves vrgathers and vslideups
define <12 x i8> @insert_subvector_concat_v6i8(<6 x i8> %x, <6 x i8> %y) {
; CHECK-LABEL: 'insert_subvector_concat_v6i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = shufflevector <6 x i8> %x, <6 x i8> %y, <12 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <12 x i8> %a
;
; CHECK-SIZE-LABEL: 'insert_subvector_concat_v6i8'
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = shufflevector <6 x i8> %x, <6 x i8> %y, <12 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret <12 x i8> %a
;
  %a = shufflevector <6 x i8> %x, <6 x i8> %y, <12 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11>
  ret <12 x i8> %a
}

; FIXME: This is a concat is emitted as one vslideup
define <8 x i8> @insert_subvector_concat_v8i8(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: 'insert_subvector_concat_v8i8'
; CHECK-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = shufflevector <4 x i8> %x, <4 x i8> %y, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:  Cost Model: Found an estimated cost of 0 for instruction: ret <8 x i8> %a
;
; CHECK-SIZE-LABEL: 'insert_subvector_concat_v8i8'
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: %a = shufflevector <4 x i8> %x, <4 x i8> %y, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-SIZE-NEXT:  Cost Model: Found an estimated cost of 1 for instruction: ret <8 x i8> %a
;
  %a = shufflevector <4 x i8> %x, <4 x i8> %y, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  ret <8 x i8> %a
}

;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; RV32: {{.*}}
; RV32-SIZE: {{.*}}
; RV64: {{.*}}
; RV64-SIZE: {{.*}}
