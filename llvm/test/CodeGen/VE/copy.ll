; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define signext i8 @copyi8(i8 signext, i8 returned signext) {
; CHECK-LABEL: copyi8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, %s1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i8 %1
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @copyi16(i16 signext, i16 returned signext) {
; CHECK-LABEL: copyi16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, %s1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i16 %1
}

; Function Attrs: norecurse nounwind readnone
define i32 @copyi32(i32, i32 returned) {
; CHECK-LABEL: copyi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, %s1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i32 %1
}

; Function Attrs: norecurse nounwind readnone
define i64 @copyi64(i64, i64 returned) {
; CHECK-LABEL: copyi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, %s1
; CHECK-NEXT:  or %s11, 0, %s9
  ret i64 %1
}

; Function Attrs: norecurse nounwind readnone
define i128 @copyi128(i128, i128 returned) {
; CHECK-LABEL: copyi128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s1, 0, %s3
; CHECK-NEXT:  or %s0, 0, %s2
; CHECK-NEXT:  or %s11, 0, %s9
  ret i128 %1
}

; Function Attrs: norecurse nounwind readnone
define float @copyf32(float, float returned) {
; CHECK-LABEL: copyf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, %s1
; CHECK-NEXT:  or %s11, 0, %s9
  ret float %1
}

; Function Attrs: norecurse nounwind readnone
define double @copyf64(double, double returned) {
; CHECK-LABEL: copyf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, %s1
; CHECK-NEXT:  or %s11, 0, %s9
  ret double %1
}

; Function Attrs: norecurse nounwind readnone
define fp128 @copyf128(fp128, fp128 returned) {
; CHECK-LABEL: copyf128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s0, 0, %s2
; CHECK-NEXT:  or %s1, 0, %s3
; CHECK-NEXT:  or %s11, 0, %s9
  ret fp128 %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x i32> @__regcall3__copyv256i32(<256 x i32>, <256 x i32> returned) {
; CHECK-LABEL: copyv256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svl %s16
; CHECK-NEXT:  lea %s12, 256
; CHECK-NEXT:  lvl %s12
; CHECK-NEXT:  vor %v0,(0)1,%v1
; CHECK-NEXT:  lvl %s16
; CHECK-NEXT:  or %s11, 0, %s9
  ret <256 x i32> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x i64> @__regcall3__copyv256i64(<256 x i64>, <256 x i64> returned) {
; CHECK-LABEL: copyv256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svl %s16
; CHECK-NEXT:  lea %s12, 256
; CHECK-NEXT:  lvl %s12
; CHECK-NEXT:  vor %v0,(0)1,%v1
; CHECK-NEXT:  lvl %s16
; CHECK-NEXT:  or %s11, 0, %s9
  ret <256 x i64> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x float> @__regcall3__copyv256f32(<256 x float>, <256 x float> returned) {
; CHECK-LABEL: copyv256f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svl %s16
; CHECK-NEXT:  lea %s12, 256
; CHECK-NEXT:  lvl %s12
; CHECK-NEXT:  vor %v0,(0)1,%v1
; CHECK-NEXT:  lvl %s16
; CHECK-NEXT:  or %s11, 0, %s9
  ret <256 x float> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__copyv256f64(<256 x double>, <256 x double> returned) {
; CHECK-LABEL: copyv256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svl %s16
; CHECK-NEXT:  lea %s12, 256
; CHECK-NEXT:  lvl %s12
; CHECK-NEXT:  vor %v0,(0)1,%v1
; CHECK-NEXT:  lvl %s16
; CHECK-NEXT:  or %s11, 0, %s9
  ret <256 x double> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i32> @__regcall3__copyv512i32(<512 x i32>, <512 x i32> returned) {
; CHECK-LABEL: copyv512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svl %s16
; CHECK-NEXT:  lea %s12, 256
; CHECK-NEXT:  lvl %s12
; CHECK-NEXT:  vor %v0,(0)1,%v1
; CHECK-NEXT:  lvl %s16
; CHECK-NEXT:  or %s11, 0, %s9
  ret <512 x i32> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__copyv512f32(<512 x float>, <512 x float> returned) {
; CHECK-LABEL: copyv512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svl %s16
; CHECK-NEXT:  lea %s12, 256
; CHECK-NEXT:  lvl %s12
; CHECK-NEXT:  vor %v0,(0)1,%v1
; CHECK-NEXT:  lvl %s16
; CHECK-NEXT:  or %s11, 0, %s9
  ret <512 x float> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x i1> @__regcall3__copyv256i1(<256 x i1>, <256 x i1> returned) {
; CHECK-LABEL: copyv256i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  andm %vm1,%vm0,%vm2
; CHECK-NEXT:  or %s11, 0, %s9
  ret <256 x i1> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i1> @__regcall3__copyv512i1(<512 x i1>, <512 x i1> returned) {
; CHECK-LABEL: copyv512i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  andm %vm2,%vm0,%vm4
; CHECK-NEXT:  andm %vm3,%vm0,%vm5
; CHECK-NEXT:  or %s11, 0, %s9
  ret <512 x i1> %1
}

