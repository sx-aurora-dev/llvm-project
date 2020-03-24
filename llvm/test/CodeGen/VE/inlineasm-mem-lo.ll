; RUN: llc < %s -mtriple=ve | FileCheck %s

; CHECK-LABEL: leam:
; CHECK: lea %s0, 184(%s11)
define i64 @leam(i64 %x) nounwind {
  %z = alloca i64, align 8
  %asmtmp = tail call i64 asm "lea $0, $1", "=r,*m"(i64* %z) nounwind
  ret i64 %asmtmp
}
