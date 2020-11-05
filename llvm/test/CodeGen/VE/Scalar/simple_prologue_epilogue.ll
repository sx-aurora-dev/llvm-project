; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define void @func() {
; CHECK-LABEL: func:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  ret void
}

define i64 @func1(i64) {
; CHECK-LABEL: func1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  ret i64 %0
}

define i64 @func2(i64, i64, i64, i64, i64) {
; CHECK-LABEL: func2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s0, 0, %s4
; CHECK-NEXT:    b.l.t (, %s10)
  ret i64 %4
}
