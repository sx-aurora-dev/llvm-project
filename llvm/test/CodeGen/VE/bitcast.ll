; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: noinline nounwind optnone
define dso_local i64 @bitcastd2l(double) {
; CHECK-LABEL: bitcastd2l:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:   or %s11, 0, %s9
; CHECK-NEXT:   ld %s16, 32(,%s11)
; CHECK-NEXT:   ld %s15, 24(,%s11)
; CHECK-NEXT:   ld %s10, 8(,%s11)
; CHECK-NEXT:   ld %s9, (,%s11)
; CHECK-NEXT:   b.l (,%lr)
  %2 = bitcast double %0 to i64
  ret i64 %2
}

; Function Attrs: noinline nounwind optnone
define dso_local double @bitcastl2d(i64) {
; CHECK-LABEL: bitcastl2d:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:   or %s11, 0, %s9
; CHECK-NEXT:   ld %s16, 32(,%s11)
; CHECK-NEXT:   ld %s15, 24(,%s11)
; CHECK-NEXT:   ld %s10, 8(,%s11)
; CHECK-NEXT:   ld %s9, (,%s11)
; CHECK-NEXT:   b.l (,%lr)
  %2 = bitcast i64 %0 to double
  ret double %2
}
