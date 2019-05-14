; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@v256i64 = common dso_local local_unnamed_addr global <256 x i64> zeroinitializer, align 16

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @loadv256i64(<256 x i64>* nocapture readonly) {
; CHECK-LABEL: loadv256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vld %v0,8,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load <256 x i64>, <256 x i64>* %0, align 16
  ret <256 x i64> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @loadv256i64stk() {
; CHECK-LABEL: loadv256i64stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  lea %s34,{{[0-9]+}}(,%s11)
; CHECK-NEXT:  vld %v0,8,%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca <256 x i64>, align 16
  %1 = load <256 x i64>, <256 x i64>* %addr, align 16
  ret <256 x i64> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @loadv256i64com() {
; CHECK-LABEL: loadv256i64com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  lea %s34, v256i64@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, v256i64@hi(%s34)
; CHECK-NEXT:  vld %v0,8,%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load <256 x i64>, <256 x i64>* @v256i64, align 16
  ret <256 x i64> %1
}
