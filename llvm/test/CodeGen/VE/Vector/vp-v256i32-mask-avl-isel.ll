; RUN: llc -O0 --march=ve %s -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<256 x i32>* %Out, <256 x i32> %i0) {
; CHECK-LABEL: test_vp_harness:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vstl %v0, 4, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  store <256 x i32> %i0, <256 x i32>* %Out
  ret void
}

define void @test_vp_add_sub_mul(<256 x i32>* %Out, <256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_add_sub_mul:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.w.sx %v2, %v0, %v1, %vm1
; CHECK-NEXT:    vsubs.w.sx %v0, %v0, %v1, %vm1
; CHECK-NEXT:    vmuls.w.sx %v0, %v2, %v0, %vm1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vstl %v0, 4, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r0 = call <256 x i32> @llvm.vp.add.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i32> @llvm.vp.sub.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r2 = call <256 x i32> @llvm.vp.mul.v256i32(<256 x i32> %r0, <256 x i32> %r1, <256 x i1> %m, i32 %n)
  store <256 x i32> %r2, <256 x i32>* %Out
  ret void
}

define void @test_vp_su_div(<256 x i32>* %Out, <256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_su_div:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vdivs.w.sx %v0, %v0, %v1, %vm1
; CHECK-NEXT:    vdivu.w %v0, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vstl %v0, 4, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r0 = call <256 x i32> @llvm.vp.sdiv.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i32> @llvm.vp.udiv.v256i32(<256 x i32> %r0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  store <256 x i32> %r1, <256 x i32>* %Out
  ret void
}


define void @test_vp_bitarith(<256 x i32>* %Out, <256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_bitarith:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvand.lo %v2, %v0, %v1, %vm1
; CHECK-NEXT:    pvor.lo %v3, %v2, %v1, %vm1
; CHECK-NEXT:    pvxor.lo %v0, %v0, %v3, %vm1
; CHECK-NEXT:    pvsra.lo %v0, %v0, %v1, %vm1
; CHECK-NEXT:    pvsrl.lo %v1, %v0, %v2, %vm1
; CHECK-NEXT:    pvsll.lo %v0, %v1, %v0, %vm1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vstl %v0, 4, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r0 = call <256 x i32> @llvm.vp.and.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i32> @llvm.vp.or.v256i32(<256 x i32> %r0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r2 = call <256 x i32> @llvm.vp.xor.v256i32(<256 x i32> %i0, <256 x i32> %r1, <256 x i1> %m, i32 %n)
  %r3 = call <256 x i32> @llvm.vp.ashr.v256i32(<256 x i32> %r2, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  %r4 = call <256 x i32> @llvm.vp.lshr.v256i32(<256 x i32> %r3, <256 x i32> %r0, <256 x i1> %m, i32 %n)
  %r5 = call <256 x i32> @llvm.vp.shl.v256i32(<256 x i32> %r4, <256 x i32> %r3, <256 x i1> %m, i32 %n)
  store <256 x i32> %r5, <256 x i32>* %Out
  ret void
}

define void @test_vp_memory(<256 x i32>* %VecPtr, <256 x i32*> %PtrVec, <256 x i32> %i0, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_vp_memory:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vseq %v1
; CHECK-NEXT:    vmulu.l %v1, 4, %v1, %vm1
; CHECK-NEXT:    vaddu.l %v1, %s0, %v1, %vm1
; CHECK-NEXT:    vgtl.zx %v1, %v1, 0, 0, %vm1
; CHECK-NEXT:    vgtl.zx %v2, %v0, 0, 0, %vm1
; CHECK-NEXT:    vscl %v0, %v1, 0, 0, %vm1
; CHECK-NEXT:    vstl %v2, 4, %s0, %vm1
; CHECK-NEXT:    or %s11, 0, %s9
  %r0 = call <256 x i32> @llvm.vp.load.v256i32.p0v256i32(<256 x i32>* %VecPtr, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i32> @llvm.vp.gather.v256i32.v256p0i32(<256 x i32*> %PtrVec, <256 x i1> %m, i32 %n)
  call void @llvm.vp.scatter.v256i32.v256p0i32(<256 x i32> %r0, <256 x i32*> %PtrVec, <256 x i1> %m, i32 %n)
  call void @llvm.vp.store.v256i32.p0v256i32(<256 x i32> %r1, <256 x i32>* %VecPtr, <256 x i1> %m, i32 %n)
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
