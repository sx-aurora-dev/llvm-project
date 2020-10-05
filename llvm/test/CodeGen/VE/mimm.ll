;; Test that a backend correctly handles mimm.

; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define i64 @mimm_0000000000000000(i64 %a) {
; CHECK-LABEL: mimm_0000000000000000:
; CHECK:       # %bb.0:
; CHECK-NEXT:    b.l.t (, %s10)
  %res = sub i64 %a, 0
  ret i64 %res
}

define i32 @mimm_0000000000000001(i32 %a) {
; CHECK-LABEL: mimm_0000000000000001:
; CHECK:       # %bb.0:
; CHECK-NEXT:    adds.w.sx %s0, -1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = sub i32 %a, 1
  ret i32 %res
}

define i32 @mimm_0000000000000003(i32 %a) {
; CHECK-LABEL: mimm_0000000000000003:
; CHECK:       # %bb.0:
; CHECK-NEXT:    adds.w.sx %s0, -3, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = sub i32 %a, 3
  ret i32 %res
}

define i64 @mimm_000000000000007F(i64 %a) {
; CHECK-LABEL: mimm_000000000000007F:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (57)0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 127
  ret i64 %res
}

define i64 @mimm_00000000000000FF(i64 %a) {
; CHECK-LABEL: mimm_00000000000000FF:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 255
  ret i64 %res
}

define i64 @mimm_000000000000FFFF(i64 %a) {
; CHECK-LABEL: mimm_000000000000FFFF:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 65535
  ret i64 %res
}

define i64 @mimm_000000FFFFFFFFFF(i64 %a) {
; CHECK-LABEL: mimm_000000FFFFFFFFFF:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (24)0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 1099511627775
  ret i64 %res
}

define i64 @mimm_7FFFFFFFFFFFFFFF(i64 %a) {
; CHECK-LABEL: mimm_7FFFFFFFFFFFFFFF:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (1)0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 9223372036854775807
  ret i64 %res
}

define i64 @mimm_FFFFFFFFFFFFFFFF(i64 %a) {
; CHECK-LABEL: mimm_FFFFFFFFFFFFFFFF:
; CHECK:       # %bb.0:
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = xor i64 %a, 18446744073709551615
  ret i64 %res
}

define i64 @mimm_FFFFFFFFFFFFFFFE(i64 %a) {
; CHECK-LABEL: mimm_FFFFFFFFFFFFFFFE:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, -2, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 18446744073709551614
  ret i64 %res
}

define i64 @mimm_FFFFFFFFFFFFFFFC(i64 %a) {
; CHECK-LABEL: mimm_FFFFFFFFFFFFFFFC:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, -4, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 18446744073709551612
  ret i64 %res
}

define i64 @mimm_FFFFFFFFFFFFFF80(i64 %a) {
; CHECK-LABEL: mimm_FFFFFFFFFFFFFF80:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (57)1
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 18446744073709551488
  ret i64 %res
}

define i32 @mimm_FFFFFFFFFFFFFF00_i32(i32 %a) {
; CHECK-LABEL: mimm_FFFFFFFFFFFFFF00_i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, -256
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i32 %a, -256
  ret i32 %res
}

define i64 @mimm_FFFFFFF000000000(i64 %a) {
; CHECK-LABEL: mimm_FFFFFFF000000000:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (28)1
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 18446744004990074880
  ret i64 %res
}

define i64 @mimm_8000000000000000(i64 %a) {
; CHECK-LABEL: mimm_8000000000000000:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (1)1
; CHECK-NEXT:    b.l.t (, %s10)
  %res = and i64 %a, 9223372036854775808
  ret i64 %res
}
