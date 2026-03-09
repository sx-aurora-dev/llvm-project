; RUN: llc < %s -mtriple=ve | FileCheck %s

; Test that CFI directives are NOT emitted for vector (V0-V63) and vector
; mask (VM0-VM15) registers, even when they are callee-saved under the
; fastcc calling convention (CSR_RegCall).
;
; The compiler correctly spills and restores these registers in the
; prologue/epilogue, but .cfi_offset directives for them must be omitted
; because libunwind's Registers_ve cannot store vector register values
; (each VE vector register is 2048 bytes).  Emitting CFI for them would
; cause UNW_EBADREG during DWARF unwinding, making exceptions uncatchable.

; A fastcc function that uses a callee-saved vector register across a call.
; Vector spills should be present in codegen but NOT in CFI.
define fastcc void @fastcc_with_vec(<256 x double> %v) #0 {
; CHECK-LABEL: fastcc_with_vec:
; CHECK:         .cfi_offset %s9, 0
; CHECK:         .cfi_offset %s10, 8
; CHECK-NOT:     .cfi_offset %v
; CHECK-NOT:     .cfi_offset %vm
; CHECK:         vst %v18, 8,
; CHECK:         vst %v19, 8,
; CHECK:         .cfi_restore %s10
; CHECK:         .cfi_restore %s9
; CHECK-NOT:     .cfi_restore %v
; CHECK-NOT:     .cfi_restore %vm
  call void @external()
  call void @use_vec(<256 x double> %v)
  ret void
}

declare void @external()
declare void @use_vec(<256 x double>)

attributes #0 = { uwtable }
