; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+vpu | FileCheck %s

; Function Attrs: nounwind readnone speculatable willreturn
declare <253 x double> @llvm.sqrt.v253f64(<253 x double>)

; Function Attrs: nounwind
define fastcc <253 x double> @vec_sqrt_v253f64(<253 x double> %a) {
; CHECK-LABEL: vec_sqrt_v253f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 253
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfsqrt.d %v0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call <253 x double> @llvm.sqrt.v253f64(<253 x double> %a)
  ret <253 x double> %r
}
