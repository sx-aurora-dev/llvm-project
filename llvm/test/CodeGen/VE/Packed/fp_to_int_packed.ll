; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define <512 x i32> @d2ui(<512 x double> %a) {
; CHECK-LABEL: d2ui:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcvt.l.d.rz %v0,%v0,%vm0
; CHECK-NEXT:    vcvt.l.d.rz %v1,%v1,%vm0
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %conv = fptoui <512 x double> %a to <512 x i32>
  ret <512 x i32> %conv
}
