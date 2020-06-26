; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: noinline nounwind readnone
define <256 x double> @_Z4funcDv256_dS_S_Dv4_m(<256 x double> %0, <256 x double> %1, <256 x double> %2, <256 x i1> %3) {
; CHECK-LABEL: _Z4funcDv256_dS_S_Dv4_m:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2, 416(, %s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0, 8, %s2
; CHECK-NEXT:    lea %s2, 4512(, %s11)
; CHECK-NEXT:    vld %v1, 8, %s2
; CHECK-NEXT:    lea %s2, 2464(, %s11)
; CHECK-NEXT:    vld %v2, 8, %s2
; CHECK-NEXT:    ld %s16, 6560(, %s11)
; CHECK-NEXT:    lvm %vm1, 0, %s16
; CHECK-NEXT:    ld %s16, 6568(, %s11)
; CHECK-NEXT:    lvm %vm1, 1, %s16
; CHECK-NEXT:    ld %s16, 6576(, %s11)
; CHECK-NEXT:    lvm %vm1, 2, %s16
; CHECK-NEXT:    ld %s16, 6584(, %s11)
; CHECK-NEXT:    lvm %vm1, 3, %s16
; CHECK-NEXT:    vfadd.d %v0, %v2, %v1, %vm1
; CHECK-NEXT:    vst %v0, 8, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = tail call <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double> %1, <256 x double> %2, <256 x i1> %3, <256 x double> %0, i32 256)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)
