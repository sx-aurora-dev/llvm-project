; RUN: llc < %s -mtriple=ve | FileCheck %s

@A = dso_local global i64 0, align 8

; CHECK-LABEL: leam:
; CHECK: lea %s0, (%s0)
define i64 @leam(i64 %x) nounwind {
  %asmtmp = tail call i64 asm "lea $0, $1", "=r,*m"(i64* @A) nounwind
  ret i64 %asmtmp
}
