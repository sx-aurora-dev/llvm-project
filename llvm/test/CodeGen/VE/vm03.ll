; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: noinline nounwind optnone
define dso_local <4 x i64> @_Z4funcv() local_unnamed_addr #0 {
; CHECK:       lvm %vm1,0,%s34
; CHECK-NEXT:  lvm %vm1,1,%s34
; CHECK-NEXT:  lvm %vm1,2,%s34
; CHECK-NEXT:  lvm %vm1,3,%s34
; CHECK-NEXT:  svm %s34,%vm1,3
; CHECK-NEXT:  st %s34, 24(,%s0)
; CHECK-NEXT:  svm %s34,%vm1,2
; CHECK-NEXT:  st %s34, 16(,%s0)
; CHECK-NEXT:  svm %s34,%vm1,1
; CHECK-NEXT:  st %s34, 8(,%s0)
; CHECK-NEXT:  svm %s34,%vm1,0
; CHECK-NEXT:  st %s34, (,%s0)
  ret <4 x i64> zeroinitializer
}
