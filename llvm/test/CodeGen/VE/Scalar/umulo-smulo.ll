; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i64 @smulo(i64, i64) {
; CHECK-LABEL: smulo:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s4, 0, %s1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    sra.l %s1, %s1, 63
; CHECK-NEXT:    sra.l %s3, %s0, 63
; CHECK-NEXT:    lea %s0, __multi3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(, %s0)
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    sra.l %s2, %s0, 63
; CHECK-NEXT:    cmpu.l %s1, %s1, %s2
; CHECK-NEXT:    cmov.l.ne %s0, (0)0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = tail call { i64, i1 } @llvm.smul.with.overflow.i64(i64 %1, i64 %0)
  %4 = extractvalue { i64, i1 } %3, 1
  %5 = extractvalue { i64, i1 } %3, 0
  %6 = select i1 %4, i64 -1, i64 %5
  ret i64 %6
}

define i64 @umulo(i64, i64) {
; CHECK-LABEL: umulo:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s4, 0, %s0
; CHECK-NEXT:    lea %s0, __multi3@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __multi3@hi(, %s0)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s3, 0, (0)1
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    or %s2, 0, %s4
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    cmov.l.ne %s0, (0)0, %s1
; CHECK-NEXT:    or %s11, 0, %s9

  %3 = tail call { i64, i1 } @llvm.umul.with.overflow.i64(i64 %1, i64 %0)
  %4 = extractvalue { i64, i1 } %3, 1
  %5 = extractvalue { i64, i1 } %3, 0
  %6 = select i1 %4, i64 -1, i64 %5
  ret i64 %6
}

; Function Attrs: nounwind readnone speculatable
declare { i64, i1 } @llvm.umul.with.overflow.i64(i64, i64)
declare { i64, i1 } @llvm.smul.with.overflow.i64(i64, i64)
