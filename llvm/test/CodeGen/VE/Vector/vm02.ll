; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+intrin | FileCheck %s

; Function Attrs: noinline nounwind readnone
define <256 x double> @_Z4funcDv256_dS_S_Dv4_m(<256 x double> %0, <256 x double> %1, <256 x double> %2, <256 x i1> %3) {
; CHECK-LABEL: _Z4funcDv256_dS_S_Dv4_m:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2, 240(, %s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0, 8, %s2
; CHECK-NEXT:    lea %s2, 4336(, %s11)
; CHECK-NEXT:    vld %v1, 8, %s2
; CHECK-NEXT:    lea %s2, 2288(, %s11)
; CHECK-NEXT:    vld %v2, 8, %s2
; CHECK-NEXT:    ld %s16, 6384(, %s11)
; CHECK-NEXT:    lvm %vm1, 0, %s16
; CHECK-NEXT:    ld %s16, 6392(, %s11)
; CHECK-NEXT:    lvm %vm1, 1, %s16
; CHECK-NEXT:    ld %s16, 6400(, %s11)
; CHECK-NEXT:    lvm %vm1, 2, %s16
; CHECK-NEXT:    ld %s16, 6408(, %s11)
; CHECK-NEXT:    lvm %vm1, 3, %s16
; CHECK-NEXT:    vfadd.d %v0, %v2, %v1, %vm1
; CHECK-NEXT:    vst %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double> %1, <256 x double> %2, <256 x i1> %3, <256 x double> %0, i32 256)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vfaddd.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)
