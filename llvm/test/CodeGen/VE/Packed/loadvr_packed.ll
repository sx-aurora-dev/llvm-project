; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s

@v256i64 = common dso_local local_unnamed_addr global <256 x i64> zeroinitializer, align 16

; Function Attrs: norecurse nounwind readonly
define fastcc <345 x i32> @loadv345i32(<345 x i32>* nocapture readonly) {
; CHECK-LABEL: loadv345i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 4(, %s0)
; CHECK-NEXT:    lea %s2, 172
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vldl.zx %v0, 8, %s1
; CHECK-NEXT:    lea %s1, 173
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldl.zx %v1, 8, %s0
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vshf %v0, %v1, %v0, 3
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <345 x i32>, <345 x i32>* %0, align 16
  ret <345 x i32> %2
}

; Function Attrs: norecurse nounwind readonly
define fastcc <512 x i32> @loadv512i32(<512 x i32>* nocapture readonly) {
; CHECK-LABEL: loadv512i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <512 x i32>, <512 x i32>* %0, align 16
  ret <512 x i32> %2
}

; Function Attrs: norecurse nounwind readonly
define fastcc <345 x float> @loadv345f32(<345 x float>* nocapture readonly) {
; CHECK-LABEL: loadv345f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 4(, %s0)
; CHECK-NEXT:    lea %s2, 172
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vldu %v0, 8, %s1
; CHECK-NEXT:    lea %s1, 173
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v1, 8, %s0
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vshf %v0, %v1, %v0, 2
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <345 x float>, <345 x float>* %0, align 16
  ret <345 x float> %2
}

; Function Attrs: norecurse nounwind readonly
define fastcc <512 x float> @loadv512f32(<512 x float>* nocapture readonly) {
; CHECK-LABEL: loadv512f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <512 x float>, <512 x float>* %0, align 16
  ret <512 x float> %2
}

