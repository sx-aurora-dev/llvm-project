; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+intrin | FileCheck %s

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @_Z4funcDv256_dS_S_(<256 x double> %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: _Z4funcDv256_dS_S_:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lvm %vm1, 0, (0)1
; CHECK-NEXT:    lvm %vm1, 1, (0)1
; CHECK-NEXT:    lvm %vm1, 2, (0)1
; CHECK-NEXT:    lvm %vm1, 3, (0)1
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfadd.d %v0, %v1, %v2, %vm1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double> %1, <256 x double> %2, <256 x i1> zeroinitializer, <256 x double> %0, i32 256)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)
