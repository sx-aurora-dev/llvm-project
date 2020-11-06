; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: noinline nounwind readnone
define <256 x double> @_Z4funcDv256_dS_S_Dv4_m(<256 x double> %0, <256 x double> %1, <256 x double> %2, <256 x i1> %3) {
; CHECK-LABEL: _Z4funcDv256_dS_S_Dv4_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfadd.d %v0, %v1, %v2, %vm1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double> %1, <256 x double> %2, <256 x i1> %3, <256 x double> %0, i32 256)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)
