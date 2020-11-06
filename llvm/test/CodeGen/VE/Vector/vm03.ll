; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: noinline nounwind optnone
define <256 x i1> @_Z4funcv() {
; CHECK-LABEL: _Z4funcv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xorm %vm1, %vm0, %vm0
; CHECK-NEXT:    b.l.t (, %s10)
  ret <256 x i1> zeroinitializer
}
