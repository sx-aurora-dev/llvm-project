; RUN: llc < %s -mtriple=ve | FileCheck %s
; RUN: llc < %s -mtriple=ve -relocation-model=pic \
; RUN:     | FileCheck -check-prefix=PIC %s

; Test CFI directive emission for VE prologue/epilogue.

declare void @external()

; Non-leaf function: should have CFI for FP/LR save/restore.
define void @non_leaf() #0 {
; CHECK-LABEL: non_leaf:
; CHECK:         st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    .cfi_offset %s9, 0
; CHECK-NEXT:    .cfi_offset %s10, 8
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    .cfi_def_cfa_register %s9
; CHECK:         or %s11, 0, %s9
; CHECK-NEXT:    .cfi_def_cfa %s11, 0
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    .cfi_restore %s10
; CHECK-NEXT:    .cfi_restore %s9
; CHECK-NEXT:    b.l.t (, %s10)
;
; PIC-LABEL: non_leaf:
; PIC:         st %s9, (, %s11)
; PIC-NEXT:    st %s10, 8(, %s11)
; PIC-NEXT:    st %s15, 24(, %s11)
; PIC-NEXT:    st %s16, 32(, %s11)
; PIC-NEXT:    .cfi_offset %s9, 0
; PIC-NEXT:    .cfi_offset %s10, 8
; PIC-NEXT:    .cfi_offset %s15, 24
; PIC-NEXT:    .cfi_offset %s16, 32
; PIC-NEXT:    or %s9, 0, %s11
; PIC-NEXT:    .cfi_def_cfa_register %s9
; PIC:         or %s11, 0, %s9
; PIC-NEXT:    .cfi_def_cfa %s11, 0
; PIC-NEXT:    ld %s16, 32(, %s11)
; PIC-NEXT:    ld %s15, 24(, %s11)
; PIC-NEXT:    ld %s10, 8(, %s11)
; PIC-NEXT:    ld %s9, (, %s11)
; PIC-NEXT:    .cfi_restore %s16
; PIC-NEXT:    .cfi_restore %s15
; PIC-NEXT:    .cfi_restore %s10
; PIC-NEXT:    .cfi_restore %s9
; PIC-NEXT:    b.l.t (, %s10)
  call void @external()
  ret void
}

; Function with CSR usage: value live across call needs callee-saved register.
define i64 @csr_usage(i64 %a) #0 {
; CHECK-LABEL: csr_usage:
; CHECK:         st %s9, (, %s11)
; CHECK-NEXT:    st %s10, 8(, %s11)
; CHECK-NEXT:    .cfi_offset %s9, 0
; CHECK-NEXT:    .cfi_offset %s10, 8
; CHECK-NEXT:    or %s9, 0, %s11
; CHECK-NEXT:    .cfi_def_cfa_register %s9
; CHECK:         st %s18, 48(, %s9)
; CHECK-NEXT:    .cfi_offset %s18, 48
; CHECK:         ld %s18, 48(, %s9)
; CHECK-NEXT:    .cfi_restore %s18
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    .cfi_def_cfa %s11, 0
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    .cfi_restore %s10
; CHECK-NEXT:    .cfi_restore %s9
; CHECK-NEXT:    b.l.t (, %s10)
  call void @external()
  ret i64 %a
}

; Leaf function: no CFI expected.
define i64 @leaf(i64 %a) {
; CHECK-LABEL: leaf:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 1(, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
; CHECK-NOT:     .cfi_
  %b = add i64 %a, 1
  ret i64 %b
}

attributes #0 = { uwtable }
