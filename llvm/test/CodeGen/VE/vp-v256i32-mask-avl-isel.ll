; RUN: llc -O0 --march=ve %s -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<256 x i32>* %Out, <256 x i32> %i0) {
  store <256 x i32> %i0, <256 x i32>* %Out
; CHECK: test_vp_harness:
  ret void
}

define void @test_vp_add_sub_mul(<256 x i32>* %Out, <256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x i32> @llvm.vp.add.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i32> @llvm.vp.sub.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r2 = call <256 x i32> @llvm.vp.mul.v256i32(<256 x i32> %r0, <256 x i32> %r1, <256 x i1> %m, i32 %n)
; CHECK: test_vp_add_sub_mul:
; CHECK: vadd
; CHECK: vsub
; CHECK: vmul
; CHECK: vst
  store <256 x i32> %r2, <256 x i32>* %Out
  ret void
}

define void @test_vp_su_div(<256 x i32>* %Out, <256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x i32> @llvm.vp.sdiv.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i32> @llvm.vp.udiv.v256i32(<256 x i32> %r0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
; CHECK: test_vp_su_div
; CHECK: vdivs
; CHECK: vdivu
; CHECK: vst
  store <256 x i32> %r1, <256 x i32>* %Out
  ret void
}


define void @test_vp_bitarith(<256 x i32>* %Out, <256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x i32> @llvm.vp.and.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i32> @llvm.vp.or.v256i32(<256 x i32> %r0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r2 = call <256 x i32> @llvm.vp.xor.v256i32(<256 x i32> %i0, <256 x i32> %r1, <256 x i1> %m, i32 %n)
  %r3 = call <256 x i32> @llvm.vp.ashr.v256i32(<256 x i32> %r2, <256 x i32> %i1, <256 x i1> %m, i32 %n) 
  %r4 = call <256 x i32> @llvm.vp.lshr.v256i32(<256 x i32> %r3, <256 x i32> %r0, <256 x i1> %m, i32 %n) 
  %r5 = call <256 x i32> @llvm.vp.shl.v256i32(<256 x i32> %r4, <256 x i32> %r3, <256 x i1> %m, i32 %n)
; CHECK: test_vp_bitarith
; CHECK: vand
; CHECK: vor
; CHECK: vxor
; CHECK: pvsra
; CHECK: pvsrl
; CHECK: pvsl
; CHECK: vst
  store <256 x i32> %r5, <256 x i32>* %Out
  ret void
}

define void @test_vp_memory(<256 x i32>* %VecPtr, <256 x i32*> %PtrVec, <256 x i32> %i0, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x i32> @llvm.vp.load.v256i32.p0v256i32(<256 x i32>* %VecPtr, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i32> @llvm.vp.gather.v256i32.v256p0i32(<256 x i32*> %PtrVec, <256 x i1> %m, i32 %n)
  call void @llvm.vp.scatter.v256i32.v256p0i32(<256 x i32> %r0, <256 x i32*> %PtrVec, <256 x i1> %m, i32 %n)
  call void @llvm.vp.store.v256i32.p0v256i32(<256 x i32> %r1, <256 x i32>* %VecPtr, <256 x i1> %m, i32 %n)
; CHECK: test_vp_memory
; CHECK: vgt
; CHECK: vgt
; CHECK: vsc
; CHECK: vst
  ret void
}

; integer arith
declare <256 x i32> @llvm.vp.add.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen)
declare <256 x i32> @llvm.vp.sub.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen)
declare <256 x i32> @llvm.vp.mul.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen)
declare <256 x i32> @llvm.vp.sdiv.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen)
declare <256 x i32> @llvm.vp.udiv.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen)
; bit arith
declare <256 x i32> @llvm.vp.and.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen)
declare <256 x i32> @llvm.vp.xor.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen)
declare <256 x i32> @llvm.vp.or.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen)
declare <256 x i32> @llvm.vp.ashr.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen) 
declare <256 x i32> @llvm.vp.lshr.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen) 
declare <256 x i32> @llvm.vp.shl.v256i32(<256 x i32>, <256 x i32>, <256 x i1> mask, i32 vlen)

; memory
declare void @llvm.vp.store.v256i32.p0v256i32(<256 x i32>, <256 x i32>*, <256 x i1> mask, i32 vlen)
declare <256 x i32> @llvm.vp.load.v256i32.p0v256i32(<256 x i32>*, <256 x i1> mask, i32 vlen)
declare void @llvm.vp.scatter.v256i32.v256p0i32(<256 x i32>, <256 x i32*>, <256 x i1> mask, i32 vlen)
declare <256 x i32> @llvm.vp.gather.v256i32.v256p0i32(<256 x i32*>, <256 x i1> mask, i32 vlen)
