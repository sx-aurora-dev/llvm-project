; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define signext i8 @copyi8(i8 signext, i8 returned signext) {
; CHECK-LABEL: copyi8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  ret i8 %1
}

; Function Attrs: norecurse nounwind readnone
define signext i16 @copyi16(i16 signext, i16 returned signext) {
; CHECK-LABEL: copyi16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  ret i16 %1
}

; Function Attrs: norecurse nounwind readnone
define i32 @copyi32(i32, i32 returned) {
; CHECK-LABEL: copyi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  ret i32 %1
}

; Function Attrs: norecurse nounwind readnone
define i64 @copyi64(i64, i64 returned) {
; CHECK-LABEL: copyi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  ret i64 %1
}

; Function Attrs: norecurse nounwind readnone
define i128 @copyi128(i128, i128 returned) {
; CHECK-LABEL: copyi128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s11, 0, %s9
  ret i128 %1
}

; Function Attrs: norecurse nounwind readnone
define float @copyf32(float, float returned) {
; CHECK-LABEL: copyf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  ret float %1
}

; Function Attrs: norecurse nounwind readnone
define double @copyf64(double, double returned) {
; CHECK-LABEL: copyf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  ret double %1
}

; Function Attrs: norecurse nounwind readnone
define fp128 @copyf128(fp128, fp128 returned) {
; CHECK-LABEL: copyf128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  ret fp128 %1
}
