; RUN: llc -mattr=+packed < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <16 x i32> @__regcall3__insert_test(<16 x i32>) {
; CHECK-LABEL: __regcall3__insert_test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lvs %s0,%v0(15)
; CHECK-NEXT:    lvs %s1,%v0(14)
; CHECK-NEXT:    lvs %s2,%v0(13)
; CHECK-NEXT:    lvs %s3,%v0(12)
; CHECK-NEXT:    lvs %s4,%v0(11)
; CHECK-NEXT:    lvs %s5,%v0(10)
; CHECK-NEXT:    lvs %s6,%v0(9)
; CHECK-NEXT:    lvs %s7,%v0(8)
; CHECK-NEXT:    lvs %s34,%v0(7)
; CHECK-NEXT:    lvs %s35,%v0(6)
; CHECK-NEXT:    lvs %s36,%v0(5)
; CHECK-NEXT:    lvs %s37,%v0(4)
; CHECK-NEXT:    lvs %s38,%v0(3)
; CHECK-NEXT:    lvs %s39,%v0(2)
; CHECK-NEXT:    lvs %s40,%v0(1)
; CHECK-NEXT:    or %s41, 2, (0)1
; CHECK-NEXT:    lsv %v0(0),%s41
; CHECK-NEXT:    lsv %v0(1),%s40
; CHECK-NEXT:    lsv %v0(2),%s39
; CHECK-NEXT:    lsv %v0(3),%s38
; CHECK-NEXT:    lsv %v0(4),%s37
; CHECK-NEXT:    lsv %v0(5),%s36
; CHECK-NEXT:    lsv %v0(6),%s35
; CHECK-NEXT:    lsv %v0(7),%s34
; CHECK-NEXT:    lsv %v0(8),%s7
; CHECK-NEXT:    lsv %v0(9),%s6
; CHECK-NEXT:    lsv %v0(10),%s5
; CHECK-NEXT:    lsv %v0(11),%s4
; CHECK-NEXT:    lsv %v0(12),%s3
; CHECK-NEXT:    lsv %v0(13),%s2
; CHECK-NEXT:    lsv %v0(14),%s1
; CHECK-NEXT:    lsv %v0(15),%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = insertelement <16 x i32> %0, i32 2, i32 0
  ret <16 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_test(<16 x i32>) {
; CHECK-LABEL: __regcall3__extract_test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lvs %s0,%v0(0)
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = extractelement <16 x i32> %0, i32 0
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i32> @__regcall3__insert_v512i32(<512 x i32>) {
; CHECK-LABEL: __regcall3__insert_v512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 2, (0)1
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    lvs %s2, %v0(%s1)
; CHECK-NEXT:    and %s2, %s2, (32)1
; CHECK-NEXT:    or %s0, %s0, %s2
; CHECK-NEXT:    lsv %v0(%s1), %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = insertelement <512 x i32> %0, i32 2, i32 0
  ret <512 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_v512i32(<512 x i32>) {
; CHECK-LABEL: __regcall3__extract_v512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    lvs %s0, %v0(%s0)
; CHECK-NEXT:    srl %s0, %s0, 32
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = extractelement <512 x i32> %0, i32 3
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__insert_v512f32(<512 x float>) {
; CHECK-LABEL: __regcall3__insert_v512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 1065353216
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    lvs %s2, %v0(%s1)
; CHECK-NEXT:    and %s2, %s2, (32)1
; CHECK-NEXT:    or %s0, %s0, %s2
; CHECK-NEXT:    lsv %v0(%s1), %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = insertelement <512 x float> %0, float 1.0, i32 2
  ret <512 x float> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc float @__regcall3__extract_v512f32(<512 x float>) {
; CHECK-LABEL: __regcall3__extract_v512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    lvs %s0, %v0(%s0)
; CHECK-NEXT:    srl %s0, %s0, 32
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = extractelement <512 x float> %0, i32 3
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i32> @__regcall3__insert_v512i32r(<512 x i32>, i32) {
; CHECK-LABEL: __regcall3__insert_v512i32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    sll %s2, %s0, 63
; CHECK-NEXT:    srl %s2, %s2, 58
; CHECK-NEXT:    sll %s1, %s1, %s2
; CHECK-NEXT:    srl %s0, %s0, 1
; CHECK-NEXT:    lvs %s3, %v0(%s0)
; CHECK-NEXT:    srl %s2, (32)1, %s2
; CHECK-NEXT:    and %s2, %s3, %s2
; CHECK-NEXT:    or %s1, %s1, %s2
; CHECK-NEXT:    lsv %v0(%s0), %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = insertelement <512 x i32> %0, i32 2, i32 %1
  ret <512 x i32> %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_v512i32r(<512 x i32>, i32) {
; CHECK-LABEL: __regcall3__extract_v512i32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    srl %s1, %s0, 1
; CHECK-NEXT:    lvs %s1, %v0(%s1)
; CHECK-NEXT:    sll %s0, %s0, 63
; CHECK-NEXT:    srl %s0, %s0, 58
; CHECK-NEXT:    srl %s0, %s1, %s0
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = extractelement <512 x i32> %0, i32 %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__insert_v512f32r(<512 x float>, i32) {
; CHECK-LABEL: __regcall3__insert_v512f32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 1065353216
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    sll %s2, %s0, 63
; CHECK-NEXT:    srl %s2, %s2, 58
; CHECK-NEXT:    sll %s1, %s1, %s2
; CHECK-NEXT:    srl %s0, %s0, 1
; CHECK-NEXT:    lvs %s3, %v0(%s0)
; CHECK-NEXT:    srl %s2, (32)1, %s2
; CHECK-NEXT:    and %s2, %s3, %s2
; CHECK-NEXT:    or %s1, %s1, %s2
; CHECK-NEXT:    lsv %v0(%s0), %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = insertelement <512 x float> %0, float 1.0, i32 %1
  ret <512 x float> %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc float @__regcall3__extract_v512f32r(<512 x float>, i32) {
; CHECK-LABEL: __regcall3__extract_v512f32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    srl %s1, %s0, 1
; CHECK-NEXT:    lvs %s1, %v0(%s1)
; CHECK-NEXT:    sll %s0, %s0, 63
; CHECK-NEXT:    srl %s0, %s0, 58
; CHECK-NEXT:    srl %s0, %s1, %s0
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = extractelement <512 x float> %0, i32 %1
  ret float %3
}

