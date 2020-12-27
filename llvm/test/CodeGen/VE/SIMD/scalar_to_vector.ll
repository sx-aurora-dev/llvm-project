; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+simd | FileCheck %s

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i32> @s2vv512i32(i32) {
; CHECK-LABEL: s2vv512i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <512 x i32> undef, i32 %0, i32 0
  ret <512 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x float> @s2vv512f32(float) {
; CHECK-LABEL: s2vv512f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
  %ret = insertelement <512 x float> undef, float %0, i32 0
  ret <512 x float> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @s2vv256i64(i64) {
; CHECK-LABEL: s2vv256i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <256 x i64> undef, i64 %0, i32 0
  ret <256 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i32> @s2vv256i32(i32) {
; CHECK-LABEL: s2vv256i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <256 x i32> undef, i32 %0, i32 0
  ret <256 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x double> @s2vv256f64(double) {
; CHECK-LABEL: s2vv256f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <256 x double> undef, double %0, i32 0
  ret <256 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x float> @s2vv256f32(float) {
; CHECK-LABEL: s2vv256f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <256 x float> undef, float %0, i32 0
  ret <256 x float> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <128 x i64> @s2vv128i64(i64) {
; CHECK-LABEL: s2vv128i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <128 x i64> undef, i64 %0, i32 0
  ret <128 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <64 x i64> @s2vv64i64(i64) {
; CHECK-LABEL: s2vv64i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <64 x i64> undef, i64 %0, i32 0
  ret <64 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <32 x i64> @s2vv32i64(i64) {
; CHECK-LABEL: s2vv32i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <32 x i64> undef, i64 %0, i32 0
  ret <32 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <16 x i64> @s2vv16i64(i64) {
; CHECK-LABEL: s2vv16i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <16 x i64> undef, i64 %0, i32 0
  ret <16 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x i64> @s2vv8i64(i64) {
; CHECK-LABEL: s2vv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <8 x i64> undef, i64 %0, i32 0
  ret <8 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x i64> @s2vv4i64(i64) {
; CHECK-LABEL: s2vv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <4 x i64> undef, i64 %0, i32 0
  ret <4 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <2 x i64> @s2vv2i64(i64) {
; CHECK-LABEL: s2vv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %ret = insertelement <2 x i64> undef, i64 %0, i32 0
  ret <2 x i64> %ret
}

