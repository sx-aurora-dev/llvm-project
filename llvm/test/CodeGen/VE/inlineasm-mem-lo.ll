; RUN: llc < %s -mtriple=ve | FileCheck %s

define i64 @leam(i64 %x) nounwind {
; CHECK-LABEL: leam:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    #APP
; CHECK-NEXT:    lea %s0, 184(%s11)
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    or %s11, 0, %s9
  %z = alloca i64, align 8
  %asmtmp = tail call i64 asm "lea $0, $1", "=r,*m"(i64* %z) nounwind
  ret i64 %asmtmp
}
