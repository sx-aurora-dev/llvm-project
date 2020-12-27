; RUN: llc < %s -mtriple=ve -mattr=+simd | FileCheck %s

@v256i64 = common dso_local local_unnamed_addr global <256 x i64> zeroinitializer, align 16

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @loadv256i64(<256 x i64>* nocapture readonly) {
; CHECK-LABEL: loadv256i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <256 x i64>, <256 x i64>* %0, align 16
  ret <256 x i64> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x double> @loadv256f64(<256 x double>* nocapture readonly) {
; CHECK-LABEL: loadv256f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <256 x double>, <256 x double>* %0, align 16
  ret <256 x double> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i32> @loadv256i32(<256 x i32>* nocapture readonly) {
; CHECK-LABEL: loadv256i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldl.sx %v0, 4, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <256 x i32>, <256 x i32>* %0, align 16
  ret <256 x i32> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @loadv256i32sext(<256 x i32>* nocapture readonly) {
; CHECK-LABEL: loadv256i32sext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldl.sx %v0, 4, %s0
; CHECK-NEXT:    vadds.w.sx %v0, 0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <256 x i32>, <256 x i32>* %0, align 16
  %3 = sext <256 x i32> %2 to <256 x i64>
  ret <256 x i64> %3
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @loadv256i32zext(<256 x i32>* nocapture readonly) {
; CHECK-LABEL: loadv256i32zext:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldl.sx %v0, 4, %s0
; CHECK-NEXT:    vadds.w.zx %v0, 0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <256 x i32>, <256 x i32>* %0, align 16
  %3 = zext <256 x i32> %2 to <256 x i64>
  ret <256 x i64> %3
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x float> @loadv256f32(<256 x float>* nocapture readonly) {
; CHECK-LABEL: loadv256f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0, 4, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <256 x float>, <256 x float>* %0, align 16
  ret <256 x float> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @loadv256i64stk() {
; CHECK-LABEL: loadv256i64stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea %s1, (, %s11)
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vld %v0, 8, %s1
; CHECK-NEXT:    lea %s11, 2048(, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %addr = alloca <256 x i64>, align 16
  %1 = load <256 x i64>, <256 x i64>* %addr, align 16
  ret <256 x i64> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @loadv256i64com() {
; CHECK-LABEL: loadv256i64com:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea %s1, v256i64@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, v256i64@hi(, %s1)
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vld %v0, 8, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load <256 x i64>, <256 x i64>* @v256i64, align 16
  ret <256 x i64> %1
}
