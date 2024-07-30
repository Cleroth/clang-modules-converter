; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -O0 -mtriple=spirv32-unknown-unknown --spirv-ext=+SPV_INTEL_optnone %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-EXTENSION
; RUN: llc -O0 -mtriple=spirv32-unknown-unknown %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-NO-EXTENSION

; CHECK-EXTENSION: OpCapability OptNoneINTEL
; CHECK-EXTENSION: OpExtension "SPV_INTEL_optnone"
; CHECK-NO-EXTENSION-NOT: OpCapability OptNoneINTEL
; CHECK-NO-EXTENSION-NOT: OpExtension "SPV_INTEL_optnone"

; Function Attrs: nounwind optnone noinline
define spir_func void @_Z3foov() #0 {
; CHECK-LABEL: _Z3foov
; CHECK:       %4 = OpFunction %2 DontInline %3
; CHECK-NEXT:    %5 = OpLabel
; CHECK-NEXT:    OpReturn
; CHECK-NEXT:    OpFunctionEnd
entry:
  ret void
}

attributes #0 = { nounwind optnone noinline }

;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK-EXTENSION: {{.*}}
; CHECK-NO-EXTENSION: {{.*}}
