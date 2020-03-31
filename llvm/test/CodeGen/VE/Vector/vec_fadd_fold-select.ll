; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

; Function Attrs: nounwind
define <256 x float> @vec_add_fold_v256f32(<256 x float> %a, <256 x float> %b, <256 x i1> %m) {
; CHECK-LABEL: vec_add_fold_v256f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfadd.s %v1,%v0,%v1,%vm1
; CHECK-NEXT:    lea %s12, 256
; CHECK-NEXT:    lvl %s12
; CHECK-NEXT:    vor %v0,(0)1,%v1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <256 x float> %a, %b
  %f = select <256 x i1> %m, <256 x float> %r, <256 x float> %b
  ret <256 x float> %f
}

