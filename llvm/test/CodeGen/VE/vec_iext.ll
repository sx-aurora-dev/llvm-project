; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

define <1 x i64> @vec_sext_v1_i32_to_i64(<1 x i32> %a) {
; CHECK-LABEL: vec_sext_v1_i32_to_i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = sext <1 x i32> %a to <1 x i64>
  ret <1 x i64> %r
}

define <1 x i64> @vec_zext_v1_i32_to_i64(<1 x i32> %a) {
; CHECK-LABEL: vec_zext_v1_i32_to_i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = zext <1 x i32> %a to <1 x i64>
  ret <1 x i64> %r
}

; TODO implement a proper v17i1 mapping -,-
;; define <17 x i64> @vec_zext_v17_i32_to_i64(<17 x i32> %a) {
;;   %r = zext <17 x i32> %a to <17 x i64>
;;   ret <17 x i64> %r
;; }
;;
;; define <17 x i64> @vec_sext_v17_i32_to_i64(<17 x i32> %a) {
;;   %r = sext <17 x i32> %a to <17 x i64>
;;   ret <17 x i64> %r
;; }
;;
;; define <17 x i64> @vec_sext_v17_i1_to_i64(<17 x i1> %a) {
;;   %r = sext <17 x i1> %a to <17 x i64>
;;   ret <17 x i64> %r
;; }
;;
;; define <17 x i64> @vec_zext_v17_i1_to_i64(<17 x i1> %a) {
;;   %r = zext <17 x i1> %a to <17 x i64>
;;   ret <17 x i64> %r
;; }

define <512 x i64> @vec_zext_v512_i32_to_i64(<512 x i32> %a) {
; CHECK-LABEL: vec_zext_v512_i32_to_i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.zx %v0,0,%v0,%vm0
; CHECK-NEXT:    vadds.w.zx %v1,0,%v1,%vm0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = zext <512 x i32> %a to <512 x i64>
  ret <512 x i64> %r
}

define <512 x i64> @vec_sext_v512_i32_to_i64(<512 x i32> %a) {
; CHECK-LABEL: vec_sext_v512_i32_to_i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.sx %v0,0,%v0,%vm0
; CHECK-NEXT:    vadds.w.sx %v1,0,%v1,%vm0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = sext <512 x i32> %a to <512 x i64>
  ret <512 x i64> %r
}

define <512 x i64> @vec_sext_v512_i1_to_i64(<512 x i1> %a) {
; CHECK-LABEL: vec_sext_v512_i1_to_i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrd %v1,0
; CHECK-NEXT:    vmrg %v0,-1,%v1,%vm1
; CHECK-NEXT:    vmrg %v1,-1,%v1,%vm2
; CHECK-NEXT:    or %s11, 0, %s9
  %r = sext <512 x i1> %a to <512 x i64>
  ret <512 x i64> %r
}

define <512 x i64> @vec_zext_v512_i1_to_i64(<512 x i1> %a) {
; CHECK-LABEL: vec_zext_v512_i1_to_i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrd %v1,0
; CHECK-NEXT:    vmrg %v0,1,%v1,%vm1
; CHECK-NEXT:    vmrg %v1,1,%v1,%vm2
; CHECK-NEXT:    or %s11, 0, %s9
  %r = zext <512 x i1> %a to <512 x i64>
  ret <512 x i64> %r
}
