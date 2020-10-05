; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

declare <256 x i64> @llvm.ctpop.v256i64(<256 x i64>)
declare <256 x i32> @llvm.ctpop.v256i32(<256 x i32>)
declare <256 x i16> @llvm.ctpop.v256i16(<256 x i16>)

define <256 x i64> @vec_ctpopv256i64(<256 x i64> %a) {
; CHECK-LABEL: vec_ctpopv256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vpcnt %v0, %v0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call <256 x i64> @llvm.ctpop.v256i64(<256 x i64> %a)
  ret <256 x i64> %r
}

define <256 x i32> @vec_ctpopv256i32(<256 x i32> %a) {
; CHECK-LABEL: vec_ctpopv256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvpcnt.lo %v0, %v0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call <256 x i32> @llvm.ctpop.v256i32(<256 x i32> %a)
  ret <256 x i32> %r
}

define <256 x i16> @vec_ctpopv256i16(<256 x i16> %a) {
; CHECK-LABEL: vec_ctpopv256i16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea %s1, 65535
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrdl %v1,%s1
; CHECK-NEXT:    pvand.lo %v0, %v0, %v1
; CHECK-NEXT:    pvpcnt.lo %v0, %v0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = call <256 x i16> @llvm.ctpop.v256i16(<256 x i16> %a)
  ret <256 x i16> %r
}


