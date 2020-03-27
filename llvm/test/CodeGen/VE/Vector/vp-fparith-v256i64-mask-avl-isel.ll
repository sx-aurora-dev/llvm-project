; RUN: llc -O0 --march=ve %s -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<256 x i64>* %Out, <256 x i64> %i0) {
  store <256 x i64> %i0, <256 x i64>* %Out
; CHECK: test_vp_harness:
  ret void
}

define void @test_vp_fadd_fsub_fmul_fneg_fma(<256 x double>* %Out, <256 x double> %f0, <256 x double> %f1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x double> @llvm.vp.fadd.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  %r1 = call <256 x double> @llvm.vp.fsub.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  %r2 = call <256 x double> @llvm.vp.fmul.v256f64(<256 x double> %r0, <256 x double> %r1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  ; %r3 = call <256 x double> @llvm.vp.fneg.v256f64(<256 x double> %r2, metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  %r4 = call <256 x double> @llvm.vp.fma.v256f64(<256 x double> %f0, <256 x double> %f1, <256 x double> %r2, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
; CHECK: test_vp_fadd_fsub_fmul_fneg_fma:
; CHECK: vfadd
; CHECK: vfsub
; CHECK: vfmul
; CHECK: vfma
; CHECK: vst
  store <256 x double> %r4, <256 x double>* %Out
  ret void
}

define void @test_vp_fdiv(<256 x double>* %Out, <256 x double> %f0, <256 x double> %f1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x double> @llvm.vp.fdiv.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
; CHECK: test_vp_fdiv
; CHECK: vfdiv
  store <256 x double> %r0, <256 x double>* %Out
  ret void
}

define void @test_vp_fmin_fmax(<256 x double>* %O1, <256 x double>* %O2, <256 x double> %f0, <256 x double> %f1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x double> @llvm.vp.minnum.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  %r1 = call <256 x double> @llvm.vp.maxnum.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
; CHECK: test_vp_fmin_fmax:
  store <256 x double> %r0, <256 x double>* %O1
  store <256 x double> %r1, <256 x double>* %O2
  ret void
}

; define void @test_vp_frem(<256 x double>* %Out, <256 x double> %f0, <256 x double> %f1, <256 x i1> %m, i32 %n) {
;   %r0 = call <256 x double> @llvm.vp.frem.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
;   store <256 x double> %r0, <256 x double>* %Out
;   ret void
; }

; fp arithmetic
declare <256 x double> @llvm.vp.fadd.v256f64(<256 x double>, <256 x double>, metadata, metadata, <256 x i1> mask, i32 vlen)
declare <256 x double> @llvm.vp.fsub.v256f64(<256 x double>, <256 x double>, metadata, metadata, <256 x i1> mask, i32 vlen)
declare <256 x double> @llvm.vp.fmul.v256f64(<256 x double>, <256 x double>, metadata, metadata, <256 x i1> mask, i32 vlen)
declare <256 x double> @llvm.vp.fdiv.v256f64(<256 x double>, <256 x double>, metadata, metadata, <256 x i1> mask, i32 vlen)
declare <256 x double> @llvm.vp.fma.v256f64(<256 x double>, <256 x double>, <256 x double>, metadata, metadata, <256 x i1> mask, i32 vlen)
; TODO
; declare <256 x double> @llvm.vp.frem.v256f64(<256 x double>, <256 x double>, metadata, metadata, <256 x i1> mask, i32 vlen)
; declare <256 x double> @llvm.vp.fneg.v256f64(<256 x double>, metadata, <256 x i1> mask, i32 vlen)
declare <256 x double> @llvm.vp.minnum.v256f64(<256 x double>, <256 x double>, metadata, metadata, <256 x i1> mask, i32 vlen)
declare <256 x double> @llvm.vp.maxnum.v256f64(<256 x double>, <256 x double>, metadata, metadata, <256 x i1> mask, i32 vlen)
