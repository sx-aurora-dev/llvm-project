; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <16 x i32> @__regcall3__insert_test(<16 x i32>) {
; CHECK-LABEL: insert_test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s34, 2, (0)1
; CHECK-NEXT:  lsv %v0(0),%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = insertelement <16 x i32> %0, i32 2, i32 0
  ret <16 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_test(<16 x i32>) {
; CHECK-LABEL: extract_test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lvs %s0,%v0(0)
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = extractelement <16 x i32> %0, i32 0
  ret i32 %2
}

