; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define fp128 @selectccaf(double, double, fp128, fp128) {
; CHECK-LABEL: selectccaf:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp false double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccat(double, double, fp128, fp128) {
; CHECK-LABEL: selectccat:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s1, 0, %s3
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp true double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccoeq(double, double, fp128, fp128) {
; CHECK-LABEL: selectccoeq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.eq %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.eq %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp oeq double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccone(double, double, fp128, fp128) {
; CHECK-LABEL: selectccone:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.ne %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.ne %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp one double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccogt(double, double, fp128, fp128) {
; CHECK-LABEL: selectccogt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.gt %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.gt %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ogt double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccoge(double, double, fp128, fp128) {
; CHECK-LABEL: selectccoge:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.ge %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.ge %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp oge double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccolt(double, double, fp128, fp128) {
; CHECK-LABEL: selectccolt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.lt %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.lt %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp olt double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccole(double, double, fp128, fp128) {
; CHECK-LABEL: selectccole:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.le %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.le %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ole double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccord(double, double, fp128, fp128) {
; CHECK-LABEL: selectccord:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.num %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.num %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ord double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccuno(double, double, fp128, fp128) {
; CHECK-LABEL: selectccuno:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.nan %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.nan %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp uno double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccueq(double, double, fp128, fp128) {
; CHECK-LABEL: selectccueq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.eqnan %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.eqnan %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ueq double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccune(double, double, fp128, fp128) {
; CHECK-LABEL: selectccune:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.nenan %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.nenan %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp une double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccugt(double, double, fp128, fp128) {
; CHECK-LABEL: selectccugt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.gtnan %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.gtnan %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ugt double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccuge(double, double, fp128, fp128) {
; CHECK-LABEL: selectccuge:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.genan %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.genan %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp uge double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccult(double, double, fp128, fp128) {
; CHECK-LABEL: selectccult:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.ltnan %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.ltnan %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ult double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}

define fp128 @selectccule(double, double, fp128, fp128) {
; CHECK-LABEL: selectccule:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fcmp.d %s34, %s0, %s1
; CHECK-NEXT:    cmov.d.lenan %s4, %s2, %s34
; CHECK-NEXT:    cmov.d.lenan %s5, %s3, %s34
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    or %s1, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = fcmp ule double %0, %1
  %6 = select i1 %5, fp128 %2, fp128 %3
  ret fp128 %6
}
