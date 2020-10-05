; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

declare <256 x i64> @llvm.ctpop.v256i64(<256 x i64>)
declare <256 x i32> @llvm.ctpop.v256i32(<256 x i32>)
declare <256 x i16> @llvm.ctpop.v256i16(<256 x i16>)

define <256 x i64> @vec_ctpopv256i64(<256 x i64> %a) {
  %r = call <256 x i64> @llvm.ctpop.v256i64(<256 x i64> %a)
  ret <256 x i64> %r
}

define <256 x i32> @vec_ctpopv256i32(<256 x i32> %a) {
  %r = call <256 x i32> @llvm.ctpop.v256i32(<256 x i32> %a)
  ret <256 x i32> %r
}

define <256 x i16> @vec_ctpopv256i16(<256 x i16> %a) {
  %r = call <256 x i16> @llvm.ctpop.v256i16(<256 x i16> %a)
  ret <256 x i16> %r
}


