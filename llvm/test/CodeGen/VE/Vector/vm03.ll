; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+intrin | FileCheck %s

; Function Attrs: noinline nounwind optnone
define <256 x i1> @_Z4funcv() {
; CHECK-LABEL: _Z4funcv:
; CHECK:       # %bb.0:
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
; CHECK-NEXT:    b.l.t (, %s10)
  ret <256 x i1> zeroinitializer
}
