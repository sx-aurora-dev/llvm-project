; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

declare <256 x double> @llvm.ve.vl.vld.vssl(i64, i8*, i32)
declare <256 x double> @llvm.ve.vl.vfaddd.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32)

; Function Attrs: noinline nounwind readnone
define <256 x double> @test(i8* %p) {
; CHECK-LABEL: test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 64
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v1, 8, %s0
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v2, 8, %s0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0, 8, %s0
; CHECK-NEXT:    vfadd.d %v0, %v1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %v1 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %p, i32 64)
  %v2 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %p, i32 128)
  %v3 = tail call <256 x double> @llvm.ve.vl.vld.vssl(i64 8, i8* %p, i32 256)
  %vr = tail call <256 x double> @llvm.ve.vl.vfaddd.vvvvl(<256 x double> %v1, <256 x double> %v2, <256 x double> %v3, i32 256)
  ret <256 x double> %vr
}
