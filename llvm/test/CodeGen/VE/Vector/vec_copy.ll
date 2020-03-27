; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x i32> @__regcall3__copyv256i32(<256 x i32>, <256 x i32> returned) {
; CHECK-LABEL: __regcall3__copyv256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s12, 256
; CHECK-NEXT:    lvl %s12
; CHECK-NEXT:    vor %v0,(0)1,%v1
; CHECK-NEXT:    or %s11, 0, %s9
  ret <256 x i32> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x i64> @__regcall3__copyv256i64(<256 x i64>, <256 x i64> returned) {
; CHECK-LABEL: __regcall3__copyv256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s12, 256
; CHECK-NEXT:    lvl %s12
; CHECK-NEXT:    vor %v0,(0)1,%v1
; CHECK-NEXT:    or %s11, 0, %s9
  ret <256 x i64> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x float> @__regcall3__copyv256f32(<256 x float>, <256 x float> returned) {
; CHECK-LABEL: __regcall3__copyv256f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s12, 256
; CHECK-NEXT:    lvl %s12
; CHECK-NEXT:    vor %v0,(0)1,%v1
; CHECK-NEXT:    or %s11, 0, %s9
  ret <256 x float> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__copyv256f64(<256 x double>, <256 x double> returned) {
; CHECK-LABEL: __regcall3__copyv256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s12, 256
; CHECK-NEXT:    lvl %s12
; CHECK-NEXT:    vor %v0,(0)1,%v1
; CHECK-NEXT:    or %s11, 0, %s9
  ret <256 x double> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i32> @__regcall3__copyv512i32(<512 x i32>, <512 x i32> returned) {
; CHECK-LABEL: __regcall3__copyv512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s12, 256
; CHECK-NEXT:    lvl %s12
; CHECK-NEXT:    vor %v1,(0)1,%v3
; CHECK-NEXT:    lea %s12, 256
; CHECK-NEXT:    lvl %s12
; CHECK-NEXT:    vor %v0,(0)1,%v2
; CHECK-NEXT:    or %s11, 0, %s9
  ret <512 x i32> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__copyv512f32(<512 x float>, <512 x float> returned) {
; CHECK-LABEL: __regcall3__copyv512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s12, 256
; CHECK-NEXT:    lvl %s12
; CHECK-NEXT:    vor %v1,(0)1,%v3
; CHECK-NEXT:    lea %s12, 256
; CHECK-NEXT:    lvl %s12
; CHECK-NEXT:    vor %v0,(0)1,%v2
; CHECK-NEXT:    or %s11, 0, %s9
  ret <512 x float> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <256 x i1> @__regcall3__copyv256i1(<256 x i1>, <256 x i1> returned) {
; CHECK-LABEL: __regcall3__copyv256i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    andm %vm1,%vm0,%vm2
; CHECK-NEXT:    or %s11, 0, %s9
  ret <256 x i1> %1
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i1> @__regcall3__copyv512i1(<512 x i1>, <512 x i1> returned) {
; CHECK-LABEL: __regcall3__copyv512i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    andm %vm2,%vm0,%vm4
; CHECK-NEXT:    andm %vm1,%vm0,%vm3
; CHECK-NEXT:    or %s11, 0, %s9
  ret <512 x i1> %1
}

