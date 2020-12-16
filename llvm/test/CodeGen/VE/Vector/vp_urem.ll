; RUN: llc < %s -march=ve -mattr=+vpu | FileCheck %s

define <256 x i32> @test_vp_int(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n) {
  %r0 = call <256 x i32> @llvm.vp.urem.v256i32(<256 x i32> %i0, <256 x i32> %i1, <256 x i1> %m, i32 %n)
  ret <256 x i32> %r0
}

; integer arith
declare <256 x i32> @llvm.vp.urem.v256i32(<256 x i32>, <256 x i32>, <256 x i1>, i32)
