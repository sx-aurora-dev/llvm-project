; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: noinline nounwind readnone
define dso_local <256 x double> @_Z4funcDv256_dS_S_Dv4_m(<256 x double> %0, <256 x double> %1, <256 x double> %2, <4 x i64> %3) local_unnamed_addr #0 {
; CHECK:      ld %s36, (,%s35)
; CHECK-NEXT: ld %s37, 8(,%s35)
; CHECK-NEXT: ld %s38, 16(,%s35)
; CHECK-NEXT: ld %s35, 24(,%s35)
; CHECK-NEXT: lvm %vm1,0,%s36
; CHECK-NEXT: lvm %vm1,1,%s37
; CHECK-NEXT: lvm %vm1,2,%s38
; CHECK-NEXT: lvm %vm1,3,%s35
  %5 = tail call <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double> %1, <256 x double> %2, <4 x i64> %3, <256 x double> %0, i32 256)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double>, <256 x double>, <4 x i64>, <256 x double>, i32) #1
