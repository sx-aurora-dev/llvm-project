; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+velintrin | FileCheck %s

; Function Attrs: noinline nounwind readnone
define dso_local <256 x double> @_Z4funcDv256_dS_S_Dv4_m(<256 x double> %0, <256 x double> %1, <256 x double> %2, <4 x i64> %3) local_unnamed_addr #0 {
; CHECK:      ld %s3, (, %s2)
; CHECK-NEXT: ld %s4, 8(, %s2)
; CHECK-NEXT: ld %s5, 16(, %s2)
; CHECK-NEXT: ld %s2, 24(, %s2)
; CHECK-NEXT: lvm %vm1,0,%s3
; CHECK-NEXT: lvm %vm1,1,%s4
; CHECK-NEXT: lvm %vm1,2,%s5
; CHECK-NEXT: lvm %vm1,3,%s2
  %5 = tail call <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double> %1, <256 x double> %2, <4 x i64> %3, <256 x double> %0, i32 256)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double>, <256 x double>, <4 x i64>, <256 x double>, i32) #1
