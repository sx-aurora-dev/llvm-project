; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+velintrin | FileCheck %s

; Function Attrs: nounwind readnone
define dso_local <256 x double> @_Z4funcDv256_dS_S_(<256 x double> %0, <256 x double> %1, <256 x double> %2) local_unnamed_addr #0 {
; CHECK:      lvm %vm1,0,%s2
; CHECK-NEXT: lvm %vm1,1,%s2
; CHECK-NEXT: lvm %vm1,2,%s2
; CHECK-NEXT: lvm %vm1,3,%s2
  %4 = tail call <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double> %1, <256 x double> %2, <4 x i64> zeroinitializer, <256 x double> %0, i32 256)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double>, <256 x double>, <4 x i64>, <256 x double>, i32) #1
