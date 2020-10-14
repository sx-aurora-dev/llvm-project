; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s

define <1 x i1> @vec_trunc_v1_i32_to_i1(<1 x i32> %a) {
; CHECK-LABEL: vec_trunc_v1_i32_to_i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  %r = trunc <1 x i32> %a to <1 x i1>
  ret <1 x i1> %r
}

define <1 x i1> @vec_trunc_v1_i64_to_i1(<1 x i64> %a) {
; CHECK-LABEL: vec_trunc_v1_i64_to_i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  %r = trunc <1 x i64> %a to <1 x i1>
  ret <1 x i1> %r
}

define <512 x i32> @vec_trunc_v512_i64_to_i32(<512 x i64> %a) {
; CHECK-LABEL: vec_trunc_v512_i64_to_i32:
; CHECK:         lea %s0, -2048(, %s9)
; CHECK-NEXT:    lea %s1, 1024(, %s0)
; CHECK-NEXT:    lea %s2, 256
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vstl %v1, 4, %s1
; CHECK-NEXT:    vstl %v0, 4, %s0
; CHECK-NEXT:    vld %v0, 8, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = trunc <512 x i64> %a to <512 x i32>
  ret <512 x i32> %r
}

define <512 x i1> @vec_trunc_v512_i32_to_i1(<512 x i32> %a) {
; CHECK-LABEL: vec_trunc_v512_i32_to_i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvand.lo %v1, %s0, %v0
; CHECK-NEXT:    vfmk.w.ne %vm2, %v1
; CHECK-NEXT:    vshf %v0, %v0, %v0, 0
; CHECK-NEXT:    pvand.lo %v0, %s0, %v0
; CHECK-NEXT:    vfmk.w.ne %vm3, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = trunc <512 x i32> %a to <512 x i1>
  ret <512 x i1> %r
}

define <512 x i1> @vec_trunc_v512_i64_to_i1(<512 x i64> %a) {
; CHECK-LABEL: vec_trunc_v512_i64_to_i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vand %v1, %s0, %v1
; CHECK-NEXT:    vfmk.l.ne %vm3, %v1
; CHECK-NEXT:    vand %v0, %s0, %v0
; CHECK-NEXT:    vfmk.l.ne %vm2, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %r = trunc <512 x i64> %a to <512 x i1>
  ret <512 x i1> %r
}
