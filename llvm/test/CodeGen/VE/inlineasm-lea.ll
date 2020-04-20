; RUN: llc < %s -mtriple=ve | FileCheck %s

; CHECK-LABEL: lea1a:
; CHECK: lea %s0, (%s0)
define i64 @lea1a(i64 %x) nounwind {
  %asmtmp = tail call i64 asm "lea $0, ($1)", "=r,r"(i64 %x) nounwind
  ret i64 %asmtmp
}

; CHECK-LABEL: lea1b:
; CHECK: lea %s0, (, %s0)
define i64 @lea1b(i64 %x) nounwind {
  %asmtmp = tail call i64 asm "lea $0, (, $1)", "=r,r"(i64 %x) nounwind
  ret i64 %asmtmp
}

; CHECK-LABEL: lea2:
; CHECK: lea %s0, (%s0, %s1)
define i64 @lea2(i64 %x, i64 %y) nounwind {
  %asmtmp = tail call i64 asm "lea $0, ($1, $2)", "=r,r,r"(i64 %x, i64 %y) nounwind
  ret i64 %asmtmp
}

; CHECK-LABEL: lea3:
; CHECK: lea %s0, 2048(%s0, %s1)
define i64 @lea3(i64 %x, i64 %y) nounwind {
  %asmtmp = tail call i64 asm "lea $0, 2048($1, $2)", "=r,r,r"(i64 %x, i64 %y) nounwind
  ret i64 %asmtmp
}

; CHECK-LABEL: leasl3:
; CHECK: lea.sl %s0, 2048(%s1, %s0)
define i64 @leasl3(i64 %x, i64 %y) nounwind {
  %asmtmp = tail call i64 asm "lea.sl $0, 2048($1, $2)", "=r,r,r"(i64 %y, i64 %x) nounwind
  ret i64 %asmtmp
}

; CHECK-LABEL: leam:
; CHECK: lea %s0, 184(%s11)
define i64 @leam(i64 %x) nounwind {
  %asmtmp = tail call i64 asm "lea $0, $1", "=r,m"(i64 %x) nounwind
  ret i64 %asmtmp
}
