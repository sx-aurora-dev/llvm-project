; RUN: llc -O0 --march=ve %s -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<256 x i64>* %Out, <256 x i64> %i0) {
  store <256 x i64> %i0, <256 x i64>* %Out
; CHECK: test_vp_harness:
  ret void
}

define void @test_vp_add_sub_mul(<256 x i64>* %Out, <256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x i64> @llvm.vp.add.v256i64(<256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i64> @llvm.vp.sub.v256i64(<256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n)
  %r2 = call <256 x i64> @llvm.vp.mul.v256i64(<256 x i64> %r0, <256 x i64> %r1, <256 x i1> %m, i32 %n)
; CHECK: test_vp_add_sub_mul:
; CHECK: vadd{{.}}.l
; CHECK: vsub{{.}}.l
; CHECK: vmul{{.}}.l
; CHECK: vst
  store <256 x i64> %r2, <256 x i64>* %Out
  ret void
}

define void @test_vp_su_div(<256 x i64>* %Out, <256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x i64> @llvm.vp.sdiv.v256i64(<256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i64> @llvm.vp.udiv.v256i64(<256 x i64> %r0, <256 x i64> %i1, <256 x i1> %m, i32 %n)
; CHECK: test_vp_su_div
; CHECK: vdivs.l
; CHECK: vdivu.l
; CHECK: vst
  store <256 x i64> %r1, <256 x i64>* %Out
  ret void
}

define void @test_vp_bitarith(<256 x i64>* %Out, <256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x i64> @llvm.vp.and.v256i64(<256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n)
  %r1 = call <256 x i64> @llvm.vp.or.v256i64(<256 x i64> %r0, <256 x i64> %i1, <256 x i1> %m, i32 %n)
  %r2 = call <256 x i64> @llvm.vp.xor.v256i64(<256 x i64> %i0, <256 x i64> %r1, <256 x i1> %m, i32 %n)
  %r3 = call <256 x i64> @llvm.vp.ashr.v256i64(<256 x i64> %r2, <256 x i64> %i1, <256 x i1> %m, i32 %n) 
  %r4 = call <256 x i64> @llvm.vp.lshr.v256i64(<256 x i64> %r3, <256 x i64> %r0, <256 x i1> %m, i32 %n) 
  %r5 = call <256 x i64> @llvm.vp.shl.v256i64(<256 x i64> %r4, <256 x i64> %r3, <256 x i1> %m, i32 %n)
; CHECK: test_vp_bitarith
; CHECK: vand
; CHECK: vor
; CHECK: vxor
; CHECK: vsra.l
; CHECK: vsrl
; CHECK: vsll
; CHECK: vst
  store <256 x i64> %r5, <256 x i64>* %Out
  ret void
}

; define void @test_vp_su_rem(<256 x i64>* %Out, <256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n) {
;   %r0 = call <256 x i64> @llvm.vp.srem.v256i64(<256 x i64> %i0, <256 x i64> %i1, <256 x i1> %m, i32 %n)
;   %r1 = call <256 x i64> @llvm.vp.urem.v256i64(<256 x i64> %r0, <256 x i64> %i1, <256 x i1> %m, i32 %n)
; ; *HECK: test_vp_su_rem
; ; *HECK: vdivs.l
; ; *HECK: vdivu.l
; ; *HECK: vst
;   store <256 x i64> %r1, <256 x i64>* %Out
;   ret void
; }


; integer arith
declare <256 x i64> @llvm.vp.add.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen)
declare <256 x i64> @llvm.vp.sub.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen)
declare <256 x i64> @llvm.vp.mul.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen)
declare <256 x i64> @llvm.vp.sdiv.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen)
declare <256 x i64> @llvm.vp.udiv.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen)
; declare <256 x i64> @llvm.vp.srem.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen) ; TODO
; declare <256 x i64> @llvm.vp.urem.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen) ; TODO
; bit arith
declare <256 x i64> @llvm.vp.and.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen)
declare <256 x i64> @llvm.vp.xor.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen)
declare <256 x i64> @llvm.vp.or.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen)
declare <256 x i64> @llvm.vp.ashr.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen) 
declare <256 x i64> @llvm.vp.lshr.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen) 
declare <256 x i64> @llvm.vp.shl.v256i64(<256 x i64>, <256 x i64>, <256 x i1> mask, i32 vlen)
