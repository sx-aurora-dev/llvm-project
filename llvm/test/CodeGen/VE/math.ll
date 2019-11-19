; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind readnone
define double @fabs_test(double) {
; CHECK-LABEL: fabs_test:           
; CHECK:       .LBB{{[0-9]+}}_2:              
; CHECK-NEXT:  lea %s34, -1
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, 2147483647(%s34)
; CHECK-NEXT:  and %s0, %s0, %s34
  %2 = tail call double @llvm.fabs.f64(double %0)
  ret double %2
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.fabs.f64(double)

; Function Attrs: nounwind readnone
define double @sin_test(double) {
; CHECK-LABEL: sin_test:           
; CHECK:       .LBB{{[0-9]+}}_2:              
; CHECK-NEXT:  lea %s34, sin@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, sin@hi(%s34)
; CHECK-NEXT:  bsic %lr, (,%s12)
  %2 = tail call double @llvm.sin.f64(double %0)
  ret double %2
}

; Function Attrs: nounwind readnone speculatable
declare double @llvm.sin.f64(double)
