; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

define <1 x i1> @vec_trunc_v1_i32_to_i1(<1 x i32> %a) {
; CHECK-LABEL: vec_trunc_v1_i32_to_i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %r = trunc <1 x i32> %a to <1 x i1>
  ret <1 x i1> %r
}

define <1 x i1> @vec_trunc_v1_i64_to_i1(<1 x i64> %a) {
; CHECK-LABEL: vec_trunc_v1_i64_to_i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = trunc <1 x i64> %a to <1 x i1>
  ret <1 x i1> %r
}

define <256 x i32> @vec_trunc_v256_i64_to_i32(<256 x i64> %a) {
; CHECK-LABEL: vec_trunc_v256_i64_to_i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s11, 0, %s9
  %r = trunc <256 x i64> %a to <256 x i32>
  ret <256 x i32> %r
}

define <256 x i1> @vec_trunc_v256_i32_to_i1(<256 x i32> %a) {
; CHECK-LABEL: vec_trunc_v256_i32_to_i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvand.lo %v0,%s0,%v0
; CHECK-NEXT:    pvfmk.w.lo.ne %vm1,%v0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = trunc <256 x i32> %a to <256 x i1>
  ret <256 x i1> %r
}

define <256 x i1> @vec_trunc_v256_i64_to_i1(<256 x i64> %a) {
; CHECK-LABEL: vec_trunc_v256_i64_to_i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 1
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vand %v0,%s0,%v0
; CHECK-NEXT:    vfmk.l.ne %vm1,%v0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = trunc <256 x i64> %a to <256 x i1>
  ret <256 x i1> %r
}
