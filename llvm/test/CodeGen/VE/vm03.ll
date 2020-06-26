; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: noinline nounwind optnone
define <256 x i1> @_Z4funcv() {
; CHECK-LABEL: _Z4funcv:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lvm %vm1, 0, (0)1
; CHECK-NEXT:    lvm %vm1, 1, (0)1
; CHECK-NEXT:    lvm %vm1, 2, (0)1
; CHECK-NEXT:    lvm %vm1, 3, (0)1
; CHECK-NEXT:    svm %s1, %vm1, 3
; CHECK-NEXT:    st %s1, 24(, %s0)
; CHECK-NEXT:    svm %s1, %vm1, 2
; CHECK-NEXT:    st %s1, 16(, %s0)
; CHECK-NEXT:    svm %s1, %vm1, 1
; CHECK-NEXT:    st %s1, 8(, %s0)
; CHECK-NEXT:    svm %s1, %vm1, 0
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:    or %s11, 0, %s9
  ret <256 x i1> zeroinitializer
}
