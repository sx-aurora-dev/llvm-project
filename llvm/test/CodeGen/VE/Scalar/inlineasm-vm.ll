; RUN: llc < %s -mtriple=ve -mattr=+vpu | FileCheck %s

define void @lvm_svm(ptr %p) nounwind {
; CHECK-LABEL: lvm_svm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    #APP
; CHECK-NEXT:    lvm %vm1, 0, %s0
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    #APP
; CHECK-NEXT:    svm %s0, %vm1, 0
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = tail call <256 x i1> asm sideeffect "lvm $0, 0, $1", "=v,r"(ptr %p) nounwind
  %2 = tail call i64 asm sideeffect "svm $0, $1, 0", "=r,v"(<256 x i1> %1) nounwind
  ret void
}
