; RUN: llc < %s -mtriple=ve -mattr=+simd | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <16 x i32> @__regcall3__insert_test(<16 x i32>) {
; CHECK-LABEL: __regcall3__insert_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    lsv %v0(0), %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = insertelement <16 x i32> %0, i32 2, i32 0
  ret <16 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_test(<16 x i32>) {
; CHECK-LABEL: __regcall3__extract_test:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = extractelement <16 x i32> %0, i32 0
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i32> @__regcall3__insert_v512i32(<512 x i32>) {
; CHECK-LABEL: __regcall3__insert_v512i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    lvs %s1, %v0(%s0)
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s2, 2
; CHECK-NEXT:    or %s1, %s1, %s2
; CHECK-NEXT:    lsv %v0(%s0), %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = insertelement <512 x i32> %0, i32 2, i32 0
  ret <512 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_v512i32(<512 x i32>) {
; CHECK-LABEL: __regcall3__extract_v512i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    lvs %s0, %v0(%s0)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = extractelement <512 x i32> %0, i32 3
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__insert_v512f32(<512 x float>) {
; CHECK-LABEL: __regcall3__insert_v512f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    lvs %s1, %v0(%s0)
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s2, 1065353216
; CHECK-NEXT:    or %s1, %s1, %s2
; CHECK-NEXT:    lsv %v0(%s0), %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = insertelement <512 x float> %0, float 1.0, i32 2
  ret <512 x float> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc float @__regcall3__extract_v512f32(<512 x float>) {
; CHECK-LABEL: __regcall3__extract_v512f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    lvs %s0, %v0(%s0)
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = extractelement <512 x float> %0, i32 3
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i32> @__regcall3__insert_v512i32r(<512 x i32>, i32) {
; CHECK-LABEL: __regcall3__insert_v512i32r:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nnd %s1, %s0, (63)0
; CHECK-NEXT:    sla.w.sx %s1, %s1, 5
; CHECK-NEXT:    or %s2, 2, (0)1
; CHECK-NEXT:    sll %s2, %s2, %s1
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    srl %s0, %s0, 1
; CHECK-NEXT:    lvs %s3, %v0(%s0)
; CHECK-NEXT:    srl %s1, (32)1, %s1
; CHECK-NEXT:    and %s1, %s3, %s1
; CHECK-NEXT:    or %s1, %s1, %s2
; CHECK-NEXT:    lsv %v0(%s0), %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = insertelement <512 x i32> %0, i32 2, i32 %1
  ret <512 x i32> %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_v512i32r(<512 x i32>, i32) {
; CHECK-LABEL: __regcall3__extract_v512i32r:
; CHECK:       # %bb.0:
; CHECK-NEXT:    adds.w.sx %s1, %s0, (0)1
; CHECK-NEXT:    srl %s1, %s1, 1
; CHECK-NEXT:    lvs %s1, %v0(%s1)
; CHECK-NEXT:    nnd %s0, %s0, (63)0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 5
; CHECK-NEXT:    srl %s0, %s1, %s0
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = extractelement <512 x i32> %0, i32 %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__insert_v512f32r(<512 x float>, i32) {
; CHECK-LABEL: __regcall3__insert_v512f32r:
; CHECK:       # %bb.0:
; CHECK-NEXT:    nnd %s1, %s0, (63)0
; CHECK-NEXT:    sla.w.sx %s1, %s1, 5
; CHECK-NEXT:    lea %s2, 1065353216
; CHECK-NEXT:    sll %s2, %s2, %s1
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    srl %s0, %s0, 1
; CHECK-NEXT:    lvs %s3, %v0(%s0)
; CHECK-NEXT:    srl %s1, (32)1, %s1
; CHECK-NEXT:    and %s1, %s3, %s1
; CHECK-NEXT:    or %s1, %s1, %s2
; CHECK-NEXT:    lsv %v0(%s0), %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = insertelement <512 x float> %0, float 1.0, i32 %1
  ret <512 x float> %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc float @__regcall3__extract_v512f32r(<512 x float>, i32) {
; CHECK-LABEL: __regcall3__extract_v512f32r:
; CHECK:       # %bb.0:
; CHECK-NEXT:    adds.w.sx %s1, %s0, (0)1
; CHECK-NEXT:    srl %s1, %s1, 1
; CHECK-NEXT:    lvs %s1, %v0(%s1)
; CHECK-NEXT:    nnd %s0, %s0, (63)0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 5
; CHECK-NEXT:    srl %s0, %s1, %s0
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = extractelement <512 x float> %0, i32 %1
  ret float %3
}

