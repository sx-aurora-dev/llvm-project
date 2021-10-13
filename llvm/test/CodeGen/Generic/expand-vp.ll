; RUN: opt --expand-vec-pred --enable-new-pm=0 -S < %s | FileCheck %s

define void @test_vp_int(<8 x i32> %i0, <8 x i32> %i1, <8 x i32> %i2, <8 x i32> %f3, <8 x i1> %m, i32 %n) {
; CHECK-NOT: {{call.* @llvm.vp.add}}
; CHECK-NOT: {{call.* @llvm.vp.sub}}
; CHECK-NOT: {{call.* @llvm.vp.mul}}
; CHECK-NOT: {{call.* @llvm.vp.sdiv}}
; CHECK-NOT: {{call.* @llvm.vp.srem}}
; CHECK-NOT: {{call.* @llvm.vp.udiv}}
; CHECK-NOT: {{call.* @llvm.vp.urem}}
; CHECK-NOT: {{call.* @llvm.vp.and}}
; CHECK-NOT: {{call.* @llvm.vp.or}}
; CHECK-NOT: {{call.* @llvm.vp.xor}}
; CHECK-NOT: {{call.* @llvm.vp.ashr}}
; CHECK-NOT: {{call.* @llvm.vp.lshr}}
; CHECK-NOT: {{call.* @llvm.vp.shl}}
  %r0 = call <8 x i32> @llvm.vp.add.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %r1 = call <8 x i32> @llvm.vp.sub.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %r2 = call <8 x i32> @llvm.vp.mul.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %r3 = call <8 x i32> @llvm.vp.sdiv.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %r4 = call <8 x i32> @llvm.vp.srem.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %r5 = call <8 x i32> @llvm.vp.udiv.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %r6 = call <8 x i32> @llvm.vp.urem.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %r7 = call <8 x i32> @llvm.vp.and.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %r8 = call <8 x i32> @llvm.vp.or.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %r9 = call <8 x i32> @llvm.vp.xor.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  %rA = call <8 x i32> @llvm.vp.ashr.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n) 
  %rB = call <8 x i32> @llvm.vp.lshr.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n) 
  %rC = call <8 x i32> @llvm.vp.shl.v8i32(<8 x i32> %i0, <8 x i32> %i1, <8 x i1> %m, i32 %n)
  ret void
}

define void @test_vp_constrainedfp(<8 x double> %f0, <8 x double> %f1, <8 x double> %f2, <8 x double> %f3, <8 x i1> %m, i32 %n) {
; CHECK-NOT: {{call.* @llvm.vp.reduce}}
; CHECK-NOT: {{call.* @llvm.vp.fadd}}
; CHECK-NOT: {{call.* @llvm.vp.fsub}}
; CHECK-NOT: {{call.* @llvm.vp.fmul}}
; CHECK-NOT: {{call.* @llvm.vp.frem}}
; CHECK-NOT: {{call.* @llvm.vp.fma}}
; CHECK-NOT: {{call.* @llvm.vp.fneg}}
  %r0 = call <8 x double> @llvm.vp.fadd.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x i1> %m, i32 %n)
  %r1 = call <8 x double> @llvm.vp.fsub.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x i1> %m, i32 %n)
  %r2 = call <8 x double> @llvm.vp.fmul.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x i1> %m, i32 %n)
  %r3 = call <8 x double> @llvm.vp.fdiv.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x i1> %m, i32 %n)
  %r4 = call <8 x double> @llvm.vp.frem.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x i1> %m, i32 %n)
  %r5 = call <8 x double> @llvm.vp.fma.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x double> %f2, <8 x i1> %m, i32 %n)
  %r6 = call <8 x double> @llvm.vp.fneg.v8f64(<8 x double> %f2, <8 x i1> %m, i32 %n)
  %r7 = call <8 x double> @llvm.vp.minnum.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x i1> %m, i32 %n)
  %r8 = call <8 x double> @llvm.vp.maxnum.v8f64(<8 x double> %f0, <8 x double> %f1, <8 x i1> %m, i32 %n)
  ret void
}

define void @test_vp_fpcast(<8 x double> %x, <8 x i64> %y, <8 x float> %z, <8 x i1> %m, i32 %n) {
; CHECK-NOT: {{call.* @llvm.vp.fptosi}}
; CHECK-NOT: {{call.* @llvm.vp.fptoui}}
; CHECK-NOT: {{call.* @llvm.vp.sitofp}}
; CHECK-NOT: {{call.* @llvm.vp.uitofp}}
; CHECK-NOT: {{call.* @llvm.vp.rint}}
; CHECK-NOT: {{call.* @llvm.vp.round}}
; CHECK-NOT: {{call.* @llvm.vp.nearbyint}}
; CHECK-NOT: {{call.* @llvm.vp.ceil}}
; CHECK-NOT: {{call.* @llvm.vp.floor}}
; CHECK-NOT: {{call.* @llvm.vp.trunc}}
; CHECK-NOT: {{call.* @llvm.vp.fptrunc}}
; CHECK-NOT: {{call.* @llvm.vp.fpext}}
  %r0 = call <8 x i64> @llvm.vp.fptosi.v8i64v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r1 = call <8 x i64> @llvm.vp.fptoui.v8i64v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r2 = call <8 x double> @llvm.vp.sitofp.v8f64v8i64(<8 x i64> %y, <8 x i1> %m, i32 %n)
  %r3 = call <8 x double> @llvm.vp.uitofp.v8f64v8i64(<8 x i64> %y, <8 x i1> %m, i32 %n)
  %r4 = call <8 x double> @llvm.vp.rint.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r7 = call <8 x double> @llvm.vp.round.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %rA = call <8 x double> @llvm.vp.nearbyint.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %rB = call <8 x double> @llvm.vp.ceil.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %rC = call <8 x double> @llvm.vp.floor.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %rD = call <8 x double> @llvm.vp.trunc.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %rE = call <8 x float> @llvm.vp.fptrunc.v8f32v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %rF = call <8 x double> @llvm.vp.fpext.v8f64v8f32(<8 x float> %z, <8 x i1> %m, i32 %n)
  ret void
}

define void @test_vp_fpfuncs(<8 x double> %x, <8 x double> %y, <8 x i1> %m, i32 %n) {
; CHECK-NOT: {{call.* @llvm.vp.pow}}
; CHECK-NOT: {{call.* @llvm.vp.sqrt}}
; CHECK-NOT: {{call.* @llvm.vp.sin}}
; CHECK-NOT: {{call.* @llvm.vp.cos}}
; CHECK-NOT: {{call.* @llvm.vp.log}}
; CHECK-NOT: {{call.* @llvm.vp.exp\.}}
; CHECK-NOT: {{call.* @llvm.vp.exp2}}
  %r0 = call <8 x double> @llvm.vp.pow.v8f64(<8 x double> %x, <8 x double> %y, <8 x i1> %m, i32 %n)
  %r1 = call <8 x double> @llvm.vp.powi.v8f64(<8 x double> %x, i32 %n, <8 x i1> %m, i32 %n)
  %r2 = call <8 x double> @llvm.vp.sqrt.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r3 = call <8 x double> @llvm.vp.sin.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r4 = call <8 x double> @llvm.vp.cos.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r5 = call <8 x double> @llvm.vp.log.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r6 = call <8 x double> @llvm.vp.log10.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r7 = call <8 x double> @llvm.vp.log2.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r8 = call <8 x double> @llvm.vp.exp.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  %r9 = call <8 x double> @llvm.vp.exp2.v8f64(<8 x double> %x, <8 x i1> %m, i32 %n)
  ret void
}

define void @test_mem(<16 x i32*> %p0, <16 x i32>* %p1, <16 x i32> %i0, <16 x i1> %m, i32 %n) {
; CHECK-NOT: {{call.* @llvm.vp.load}}
; CHECK-NOT: {{call.* @llvm.vp.store}}
; CHECK-NOT: {{call.* @llvm.vp.gather}}
; CHECK-NOT: {{call.* @llvm.vp.scatter}}
  call void @llvm.vp.store.v16i32.p0v16i32(<16 x i32> %i0, <16 x i32>* %p1, <16 x i1> %m, i32 %n)
  call void @llvm.vp.scatter.v16i32.v16p0i32(<16 x i32> %i0 , <16 x i32*> %p0, <16 x i1> %m, i32 %n)
  %l0 = call <16 x i32> @llvm.vp.load.v16i32.p0v16i32(<16 x i32>* %p1, <16 x i1> %m, i32 %n)
  %l1 = call <16 x i32> @llvm.vp.gather.v16i32.v16p0i32(<16 x i32*> %p0, <16 x i1> %m, i32 %n)
  ret void
}

define void @test_reduce_fp(<16 x float> %v, <16 x i1> %m, i32 %n) {
; CHECK-NOT: {{call.* @llvm.vp.reduce.fadd}}
; CHECK-NOT: {{call.* @llvm.vp.reduce.fmul}}
; CHECK-NOT: {{call.* @llvm.vp.reduce.fmin}}
; CHECK-NOT: {{call.* @llvm.vp.reduce.fmax}}
  %r0 = call float @llvm.vp.reduce.fadd.v16f32(float 0.0, <16 x float> %v, <16 x i1> %m, i32 %n)
  %r1 = call float @llvm.vp.reduce.fmul.v16f32(float 42.0, <16 x float> %v, <16 x i1> %m, i32 %n)
  %r2 = call float @llvm.vp.reduce.fmin.v16f32(<16 x float> %v, <16 x i1> %m, i32 %n)
  %r3 = call float @llvm.vp.reduce.fmax.v16f32(<16 x float> %v, <16 x i1> %m, i32 %n)
  ret void
}

define void @test_reduce_int(<16 x i32> %v, <16 x i1> %m, i32 %n) {
; CHECK-NOT: {{call.* @llvm.vp.reduce}}
  %r0 = call i32 @llvm.vp.reduce.add.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
  %r1 = call i32 @llvm.vp.reduce.mul.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
  %r2 = call i32 @llvm.vp.reduce.and.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
  %r3 = call i32 @llvm.vp.reduce.xor.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
  %r4 = call i32 @llvm.vp.reduce.or.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
  %r5 = call i32 @llvm.vp.reduce.smin.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
  %r6 = call i32 @llvm.vp.reduce.smax.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
  %r7 = call i32 @llvm.vp.reduce.umin.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
  %r8 = call i32 @llvm.vp.reduce.umax.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
  ret void
}

define void @test_shuffle(<16 x float> %v0, <16 x float> %v1, <16 x i1> %m, i32 %k, i32 %n) {
; CHECK-NOT: {{call.* @llvm.vp.select}}
; no generic lowering available: {{call.* @llvm.vp.compress}}
; no generic lowering available: {{call.* @llvm.vp.expand}}
; CHECK-NOT: {{call.* @llvm.vp.vshift}}
  %r0 = call <16 x float> @llvm.vp.select.v16f32(<16 x float> %v0, <16 x float> %v1, <16 x i1> %m, i32 %k, i32 %n)
  %r2 = call <16 x float> @llvm.vp.vshift.v16f32(<16 x float> %v0, i32 7, <16 x i1> %m, i32 %n)
  %r3 = call <16 x float> @llvm.vp.compress.v16f32(<16 x float> %v0, <16 x i1> %m, i32 %n)
  %r4 = call <16 x float> @llvm.vp.expand.v16f32(<16 x float> %v0, <16 x i1> %m, i32 %n)
  ret void
}

define void @test_xcmp(<16 x i32> %i0, <16 x i32> %i1, <16 x float> %f0, <16 x float> %f1, <16 x i1> %m, i32 %n) {
; CHECK-NOT: {{call.* @llvm.vp.icmp}}
; CHECK-NOT: {{call.* @llvm.vp.fcmp}}
  %r0 = call <16 x i1> @llvm.vp.icmp.v16i32(<16 x i32> %i0, <16 x i32> %i1, i8 38, <16 x i1> %m, i32 %n)
  %r1 = call <16 x i1> @llvm.vp.fcmp.v16f32(<16 x float> %f0, <16 x float> %f1, i8 10, <16 x i1> %m, i32 %n)
  ret void
}

; integer arith
declare <8 x i32> @llvm.vp.add.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
declare <8 x i32> @llvm.vp.sub.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
declare <8 x i32> @llvm.vp.mul.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
declare <8 x i32> @llvm.vp.sdiv.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
declare <8 x i32> @llvm.vp.srem.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
declare <8 x i32> @llvm.vp.udiv.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
declare <8 x i32> @llvm.vp.urem.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
; bit arith
declare <8 x i32> @llvm.vp.and.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
declare <8 x i32> @llvm.vp.xor.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
declare <8 x i32> @llvm.vp.or.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)
declare <8 x i32> @llvm.vp.ashr.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen) 
declare <8 x i32> @llvm.vp.lshr.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen) 
declare <8 x i32> @llvm.vp.shl.v8i32(<8 x i32>, <8 x i32>, <8 x i1> mask, i32 vlen)

; floating point arith
declare <8 x double> @llvm.vp.fadd.v8f64(<8 x double>, <8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.fsub.v8f64(<8 x double>, <8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.fmul.v8f64(<8 x double>, <8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.fdiv.v8f64(<8 x double>, <8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.frem.v8f64(<8 x double>, <8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.fma.v8f64(<8 x double>, <8 x double>, <8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.fneg.v8f64(<8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.minnum.v8f64(<8 x double>, <8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.maxnum.v8f64(<8 x double>, <8 x double>, <8 x i1> mask, i32 vlen)

; cast & conversions
declare <8 x i64> @llvm.vp.fptosi.v8i64v8f64(<8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x i64> @llvm.vp.fptoui.v8i64v8f64(<8 x double>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.sitofp.v8f64v8i64(<8 x i64>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.uitofp.v8f64v8i64(<8 x i64>, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.rint.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.round.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.nearbyint.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.ceil.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.floor.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.trunc.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x float> @llvm.vp.fptrunc.v8f32v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.fpext.v8f64v8f32(<8 x float> %x, <8 x i1> mask, i32 vlen)

; math ops
declare <8 x double> @llvm.vp.pow.v8f64(<8 x double> %x, <8 x double> %y, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.powi.v8f64(<8 x double> %x, i32 %y, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.sqrt.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.sin.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.cos.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.log.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.log10.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.log2.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.exp.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)
declare <8 x double> @llvm.vp.exp2.v8f64(<8 x double> %x, <8 x i1> mask, i32 vlen)

; memory
declare void @llvm.vp.store.v16i32.p0v16i32(<16 x i32>, <16 x i32>*, <16 x i1> mask, i32 vlen)
declare <16 x i32> @llvm.vp.load.v16i32.p0v16i32(<16 x i32>*, <16 x i1> mask, i32 vlen)
declare void @llvm.vp.scatter.v16i32.v16p0i32(<16 x i32>, <16 x i32*>, <16 x i1> mask, i32 vlen)
declare <16 x i32> @llvm.vp.gather.v16i32.v16p0i32(<16 x i32*>, <16 x i1> mask, i32 vlen)

; reductions
declare float @llvm.vp.reduce.fadd.v16f32(float, <16 x float>, <16 x i1> mask, i32 vlen) 
declare float @llvm.vp.reduce.fmul.v16f32(float, <16 x float>, <16 x i1> mask, i32 vlen)
declare float @llvm.vp.reduce.fmin.v16f32(<16 x float>, <16 x i1> mask, i32 vlen)
declare float @llvm.vp.reduce.fmax.v16f32(<16 x float>, <16 x i1> mask, i32 vlen)
declare i32 @llvm.vp.reduce.add.v16i32(<16 x i32>, <16 x i1> mask, i32 vlen)
declare i32 @llvm.vp.reduce.mul.v16i32(<16 x i32>, <16 x i1> mask, i32 vlen)
declare i32 @llvm.vp.reduce.and.v16i32(<16 x i32>, <16 x i1> mask, i32 vlen)
declare i32 @llvm.vp.reduce.xor.v16i32(<16 x i32>, <16 x i1> mask, i32 vlen)
declare i32 @llvm.vp.reduce.or.v16i32(<16 x i32>, <16 x i1> mask, i32 vlen)
declare i32 @llvm.vp.reduce.smax.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
declare i32 @llvm.vp.reduce.smin.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
declare i32 @llvm.vp.reduce.umax.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)
declare i32 @llvm.vp.reduce.umin.v16i32(<16 x i32> %v, <16 x i1> %m, i32 %n)

; shuffles
declare <16 x float> @llvm.vp.select.v16f32(<16 x float>, <16 x float>, <16 x i1>, i32, i32 vlen)
declare <16 x float> @llvm.vp.vshift.v16f32(<16 x float>, i32, <16 x i1>, i32 vlen)
declare <16 x float> @llvm.vp.compress.v16f32(<16 x float>, <16 x i1>, i32 vlen)
declare <16 x float> @llvm.vp.expand.v16f32(<16 x float>, <16 x i1> mask, i32 vlen)

; icmp , fcmp
declare <16 x i1> @llvm.vp.icmp.v16i32(<16 x i32>, <16 x i32>, i8, <16 x i1> mask, i32 vlen)
declare <16 x i1> @llvm.vp.fcmp.v16f32(<16 x float>, <16 x float>, i8, <16 x i1> mask, i32 vlen)
