; RUN: llc -O0 --march=ve %s -mattr=+packed -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<512 x i32>* %Out, <512 x i32> %i0) {
; CHECK-LABEL: test_vp_harness:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  store <512 x i32> %i0, <512 x i32>* %Out
  ret void
}

define void @test_vp_fadd_fsub_fmul_fneg_fma(<512 x float>* %Out, <512 x float> %f0, <512 x float> %f1, <512 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_fadd_fsub_fmul_fneg_fma:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvfadd %v2, %v0, %v1, %vm2
; CHECK-NEXT:    pvfsub %v3, %v0, %v1, %vm2
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v4,(0)1,%v3
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v5,(0)1,%v2
; CHECK-NEXT:    andm %vm1,%vm0,%vm3
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvfmul.up %v4, %v5, %v4, %vm1
; CHECK-NEXT:    vshf %v3,%v3,%v3,15
; CHECK-NEXT:    vshf %v2,%v2,%v2,15
; CHECK-NEXT:    andm %vm1,%vm0,%vm2
; CHECK-NEXT:    pvfmul.up %v2, %v2, %v3, %vm1
; CHECK-NEXT:    vshf %v2,%v2,%v4,2
; CHECK-NEXT:    pvfmad %v0, %v2, %v0, %v1, %vm2
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r0 = call <512 x float> @llvm.vp.fadd.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  %r1 = call <512 x float> @llvm.vp.fsub.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  %r2 = call <512 x float> @llvm.vp.fmul.v512f32(<512 x float> %r0, <512 x float> %r1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  ; %r3 = call <512 x float> @llvm.vp.fneg.v512f32(<512 x float> %r2, metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  %r4 = call <512 x float> @llvm.vp.fma.v512f32(<512 x float> %f0, <512 x float> %f1, <512 x float> %r2, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  store <512 x float> %r4, <512 x float>* %Out
  ret void
}

define void @test_vp_fdiv(<512 x float>* %Out, <512 x float> %f0, <512 x float> %f1, <512 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_fdiv:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    andm %vm1,%vm0,%vm3
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v2,(0)1,%v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v3,(0)1,%v0
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfdiv.s %v2, %v3, %v2, %vm1
; CHECK-NEXT:    vshf %v1,%v1,%v1,15
; CHECK-NEXT:    vshf %v0,%v0,%v0,15
; CHECK-NEXT:    # kill: def $vm2 killed $vm2 killed $vmp1
; CHECK-NEXT:    vfdiv.s %v0, %v0, %v1, %vm2
; CHECK-NEXT:    vshf %v0,%v0,%v2,2
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r0 = call <512 x float> @llvm.vp.fdiv.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  store <512 x float> %r0, <512 x float>* %Out
  ret void
}

define void @test_vp_fmin_fmax(<512 x float>* %O1, <512 x float>* %O2, <512 x float> %f0, <512 x float> %f1, <512 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_fmin_fmax:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    andm %vm1,%vm0,%vm3
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v2,(0)1,%v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v3,(0)1,%v0
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    pvfmin.up %v4, %v3, %v2, %vm1
; CHECK-NEXT:    vshf %v1,%v1,%v1,15
; CHECK-NEXT:    vshf %v0,%v0,%v0,15
; CHECK-NEXT:    # kill: def $vm2 killed $vm2 killed $vmp1
; CHECK-NEXT:    pvfmin.up %v5, %v0, %v1, %vm2
; CHECK-NEXT:    vshf %v4,%v5,%v4,2
; CHECK-NEXT:    pvfmax.up %v2, %v3, %v2, %vm1
; CHECK-NEXT:    pvfmax.up %v0, %v0, %v1, %vm2
; CHECK-NEXT:    vshf %v0,%v0,%v2,2
; CHECK-NEXT:    lea %s2, 256
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vst %v4,8,%s0
; CHECK-NEXT:    vst %v0,8,%s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r0 = call <512 x float> @llvm.vp.minnum.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
  %r1 = call <512 x float> @llvm.vp.maxnum.v512f32(<512 x float> %f0, <512 x float> %f1, metadata !"round.tonearest", metadata !"fpexcept.ignore", <512 x i1> %m, i32 %n)
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
