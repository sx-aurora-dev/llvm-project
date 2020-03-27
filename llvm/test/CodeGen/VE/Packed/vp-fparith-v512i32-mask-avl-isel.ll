; RUN: llc -O0 --march=ve %s -mattr=+packed -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<512 x i32>* %Out, <512 x i32> %i0) {
  store <512 x i32> %i0, <512 x i32>* %Out
; CHECK: test_vp_harness:
  ret void
}

define void @test_vp_fadd_fsub_fmul_fneg_fma(<512 x float>* %Out, <512 x float> %f0, <512 x float> %f1, <512 x i1> %m, i32 %n) {
  %r0 = call <512 x float> @llvm.vp.fadd.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  %r1 = call <512 x float> @llvm.vp.fsub.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  %r2 = call <512 x float> @llvm.vp.fmul.v512f32(<512 x float> %r0, <512 x float> %r1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  ; %r3 = call <512 x float> @llvm.vp.fneg.v512f32(<512 x float> %r2, metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  %r4 = call <512 x float> @llvm.vp.fma.v512f32(<512 x float> %f0, <512 x float> %f1, <512 x float> %r2, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
; CHECK: test_vp_fadd_fsub_fmul_fneg_fma:
; CHECK: pvfadd
; CHECK: pvfsub
; CHECK: pvfmul
; CHECK: pvfma
; CHECK: vst
  store <512 x float> %r4, <512 x float>* %Out
  ret void
}

define void @test_vp_fdiv(<512 x float>* %Out, <512 x float> %f0, <512 x float> %f1, <512 x i1> %m, i32 %n) {
  %r0 = call <512 x float> @llvm.vp.fdiv.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
; CHECK: test_vp_fdiv
; CHECK: vfdiv
; CHECK: vfdiv
  store <512 x float> %r0, <512 x float>* %Out
  ret void
}

define void @test_vp_fmin_fmax(<512 x float>* %O1, <512 x float>* %O2, <512 x float> %f0, <512 x float> %f1, <512 x i1> %m, i32 %n) {
  %r0 = call <512 x float> @llvm.vp.minnum.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  %r1 = call <512 x float> @llvm.vp.maxnum.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
; CHECK: test_vp_fmin_fmax:
  store <512 x float> %r0, <512 x float>* %O1
  store <512 x float> %r1, <512 x float>* %O2
  ret void
}

; define void @test_vp_frem(<512 x float>* %Out, <512 x float> %f0, <512 x float> %f1, <512 x i1> %m, i32 %n) {
;   %r0 = call <512 x float> @llvm.vp.frem.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
;   store <512 x float> %r0, <512 x float>* %Out
;   ret void
; }

; fp arithmetic
declare <512 x float> @llvm.vp.fadd.v512f32(<512 x float>, <512 x float>, metadata, metadata, <512 x i1> mask, i32 vlen)
declare <512 x float> @llvm.vp.fsub.v512f32(<512 x float>, <512 x float>, metadata, metadata, <512 x i1> mask, i32 vlen)
declare <512 x float> @llvm.vp.fmul.v512f32(<512 x float>, <512 x float>, metadata, metadata, <512 x i1> mask, i32 vlen)
declare <512 x float> @llvm.vp.fdiv.v512f32(<512 x float>, <512 x float>, metadata, metadata, <512 x i1> mask, i32 vlen)
declare <512 x float> @llvm.vp.fma.v512f32(<512 x float>, <512 x float>, <512 x float>, metadata, metadata, <512 x i1> mask, i32 vlen)
; TODO
; declare <512 x float> @llvm.vp.frem.v512f32(<512 x float>, <512 x float>, metadata, metadata, <512 x i1> mask, i32 vlen)
; declare <512 x float> @llvm.vp.fneg.v512f32(<512 x float>, metadata, <512 x i1> mask, i32 vlen)
declare <512 x float> @llvm.vp.minnum.v512f32(<512 x float>, <512 x float>, metadata, metadata, <512 x i1> mask, i32 vlen)
declare <512 x float> @llvm.vp.maxnum.v512f32(<512 x float>, <512 x float>, metadata, metadata, <512 x i1> mask, i32 vlen)
