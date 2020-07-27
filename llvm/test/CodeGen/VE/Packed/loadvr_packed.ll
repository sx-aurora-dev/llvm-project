; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s

@v256i64 = common dso_local local_unnamed_addr global <256 x i64> zeroinitializer, align 16

; Function Attrs: norecurse nounwind readonly
define fastcc <345 x i32> @loadv345i32(<345 x i32>* nocapture readonly) {
; CHECK-LABEL: loadv345i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 345
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = load <345 x i32>, <345 x i32>* %0, align 16
  ret <345 x i32> %2
}

; Function Attrs: norecurse nounwind readonly
define fastcc <512 x i32> @loadv512i32(<512 x i32>* nocapture readonly) {
; CHECK-LABEL: loadv512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 512
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = load <512 x i32>, <512 x i32>* %0, align 16
  ret <512 x i32> %2
}

; Function Attrs: norecurse nounwind readonly
define fastcc <345 x float> @loadv345f32(<345 x float>* nocapture readonly) {
; CHECK-LABEL: loadv345f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 345
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = load <345 x float>, <345 x float>* %0, align 16
  ret <345 x float> %2
}

; Function Attrs: norecurse nounwind readonly
define fastcc <512 x float> @loadv512f32(<512 x float>* nocapture readonly) {
; CHECK-LABEL: loadv512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 512
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = load <512 x float>, <512 x float>* %0, align 16
  ret <512 x float> %2
}

