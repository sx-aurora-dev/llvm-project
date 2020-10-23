; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s

; Function Attrs: norecurse nounwind readonly
define <512 x i1> @brdv512i32x2(i1 %B) {
; CHECK-LABEL: brdv512i32x2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    or %s0, 0, %s0
; CHECK-NEXT:    srl %s1, %s0, 32
; CHECK-NEXT:    or %s0, %s0, %s1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvbrd %v0, %s0
; CHECK-NEXT:    lea %s0, 512
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vshf %v1, %v0, %v0, 0
; CHECK-NEXT:    vfmk.w.ne %vm3, %v1
; CHECK-NEXT:    vfmk.w.ne %vm2, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %first = insertelement <512 x i1> undef, i1 %B, i32 0
  %all = shufflevector <512 x i1> %first, <512 x i1> undef, <512 x i32> zeroinitializer
  ret <512 x i1> %all
}
