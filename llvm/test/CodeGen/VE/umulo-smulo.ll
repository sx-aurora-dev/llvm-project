; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i64 @smulo(i64, i64) {
; CHECK-LABEL: smulo:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    sra.l %s1, %s1, 63
; CHECK-NEXT:    sra.l %s3, %s0, 63
; CHECK-NEXT:    lea %s35, __multi3@lo
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(%s35)
; CHECK-NEXT:    or %s0, 0, %s34
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    sra.l %s34, %s0, 63
; CHECK-NEXT:    cmps.l %s34, %s1, %s34
; CHECK-NEXT:    or %s35, -1, (0)1
; CHECK-NEXT:    cmov.l.ne %s0, %s35, %s34
  %3 = tail call { i64, i1 } @llvm.smul.with.overflow.i64(i64 %1, i64 %0)
  %4 = extractvalue { i64, i1 } %3, 1
  %5 = extractvalue { i64, i1 } %3, 0
  %6 = select i1 %4, i64 -1, i64 %5
  ret i64 %6
}

define i64 @umulo(i64, i64) {
; CHECK-LABEL: umulo:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s34, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    sra.l %s1, %s1, 63
; CHECK-NEXT:    sra.l %s3, %s0, 63
; CHECK-NEXT:    lea %s35, __multi3@lo
; CHECK-NEXT:    and %s35, %s35, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(%s35)
; CHECK-NEXT:    or %s0, 0, %s34
; CHECK-NEXT:    bsic %lr, (,%s12)
; CHECK-NEXT:    or %s34, 0, (0)1
; CHECK-NEXT:    cmps.l %s34, %s1, %s34
; CHECK-NEXT:    or %s35, -1, (0)1
; CHECK-NEXT:    cmov.l.ne %s0, %s35, %s34
  %3 = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %1, i64 %0)
  %4 = extractvalue { i64, i1 } %3, 1
  %5 = extractvalue { i64, i1 } %3, 0
  %6 = select i1 %4, i64 -1, i64 %5
  ret i64 %6
}

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64)
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64)
