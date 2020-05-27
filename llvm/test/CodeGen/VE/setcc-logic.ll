; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i64 @setcc_logic(i64 %a, i64 %b, i64 %c, i64 %d, i64 %t, i64 %f) {
; CHECK-LABEL: setcc_logic:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    xor %s0, %s0, %s1
; CHECK-NEXT:    xor %s1, %s2, %s3
; CHECK-NEXT:    or %s0, %s0, %s1
; CHECK-NEXT:    cmov.l.eq %s5, %s4, %s0
; CHECK-NEXT:    or %s0, 0, %s5
; CHECK-NEXT:    or %s11, 0, %s9
  %l = icmp eq i64 %a, %b
  %r = icmp eq i64 %c, %d
  %cmp = and i1 %l, %r
  %ret = select i1 %cmp, i64 %t, i64 %f
  ret i64 %ret
}
