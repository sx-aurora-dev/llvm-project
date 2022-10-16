; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+vpu | FileCheck %s

; Function Attrs: nounwind
define fastcc <256 x float> @vec_add_fold_v256f32(<256 x float> %a, <256 x float> %b, <256 x i1> %m) {
; CHECK-LABEL: vec_add_fold_v256f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvfadd.up %v1, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = fadd <256 x float> %a, %b
  %f = select <256 x i1> %m, <256 x float> %r, <256 x float> %b
  ret <256 x float> %f
}

