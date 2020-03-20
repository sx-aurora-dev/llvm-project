; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

define <1 x i1> @vec_trunc_v1_i32_to_i1(<1 x i32> %a) {
  %r = trunc <1 x i32> %a to <1 x i1>
  ret <1 x i1> %r
}

define <1 x i1> @vec_trunc_v1_i64_to_i1(<1 x i64> %a) {
  %r = trunc <1 x i64> %a to <1 x i1>
  ret <1 x i1> %r
}

define <256 x i32> @vec_trunc_v256_i64_to_i32(<256 x i64> %a) {
  %r = trunc <256 x i64> %a to <256 x i32>
  ret <256 x i32> %r
}

define <256 x i1> @vec_trunc_v256_i32_to_i1(<256 x i32> %a) {
  %r = trunc <256 x i32> %a to <256 x i1>
  ret <256 x i1> %r
}

define <256 x i1> @vec_trunc_v256_i64_to_i1(<256 x i64> %a) {
  %r = trunc <256 x i64> %a to <256 x i1>
  ret <256 x i1> %r
}
