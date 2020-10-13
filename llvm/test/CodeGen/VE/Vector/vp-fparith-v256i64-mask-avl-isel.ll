; RUN: llc -O0 --march=ve %s -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<256 x i64>* %Out, <256 x i64> %i0) {
; CHECK-LABEL: test_vp_harness:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  store <256 x i64> %i0, <256 x i64>* %Out
  ret void
}

define void @test_vp_fadd_fsub_fmul_fneg_fma(<256 x double>* %Out, <256 x double> %f0, <256 x double> %f1, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_fadd_fsub_fmul_fneg_fma:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfadd.d %v2, %v0, %v1, %vm1
; CHECK-NEXT:    vfsub.d %v3, %v0, %v1, %vm1
; CHECK-NEXT:    vfmul.d %v2, %v2, %v3, %vm1
; CHECK-NEXT:    vfmad.d %v0, %v2, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %r0 = call <256 x double> @llvm.vp.fadd.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  %r1 = call <256 x double> @llvm.vp.fsub.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  %r2 = call <256 x double> @llvm.vp.fmul.v256f64(<256 x double> %r0, <256 x double> %r1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  ; %r3 = call <256 x double> @llvm.vp.fneg.v256f64(<256 x double> %r2, metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  %r4 = call <256 x double> @llvm.vp.fma.v256f64(<256 x double> %f0, <256 x double> %f1, <256 x double> %r2, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  store <256 x double> %r4, <256 x double>* %Out
  ret void
}

define void @test_vp_fdiv(<256 x double>* %Out, <256 x double> %f0, <256 x double> %f1, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_fdiv:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfdiv.d %v0, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %r0 = call <256 x double> @llvm.vp.fdiv.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  store <256 x double> %r0, <256 x double>* %Out
  ret void
}

define void @test_vp_fmin_fmax(<256 x double>* %O1, <256 x double>* %O2, <256 x double> %f0, <256 x double> %f1, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_fmin_fmax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vfmin.d %v2, %v0, %v1, %vm1
; CHECK-NEXT:    vfmax.d %v0, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s2, 256
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vst %v2, 8, %s0
; CHECK-NEXT:    vst %v0, 8, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %r0 = call <256 x double> @llvm.vp.minnum.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
  %r1 = call <256 x double> @llvm.vp.maxnum.v256f64(<256 x double> %f0, <256 x double> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <256 x i1> %m, i32 %n)
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
