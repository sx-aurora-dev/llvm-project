; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define <512 x i32> @d2ui(<512 x double> %a) {
; CHECK-LABEL: d2ui:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcvt.l.d.rz %v0, %v0, %vm0
; CHECK-NEXT:    vcvt.l.d.rz %v1, %v1, %vm0
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %conv = fptoui <512 x double> %a to <512 x i32>
  ret <512 x i32> %conv
}
