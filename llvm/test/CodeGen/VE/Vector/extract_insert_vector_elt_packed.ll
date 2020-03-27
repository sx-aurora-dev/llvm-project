; RUN: llc -mattr=+packed < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <16 x i32> @__regcall3__insert_test(<16 x i32>) {
; CHECK-LABEL: __regcall3__insert_test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lvs %s0,%v0(1)
; CHECK-NEXT:    lvs %s1,%v0(2)
; CHECK-NEXT:    lvs %s2,%v0(3)
; CHECK-NEXT:    lvs %s3,%v0(4)
; CHECK-NEXT:    lvs %s4,%v0(5)
; CHECK-NEXT:    lvs %s5,%v0(6)
; CHECK-NEXT:    lvs %s6,%v0(7)
; CHECK-NEXT:    lvs %s7,%v0(8)
; CHECK-NEXT:    lvs %s34,%v0(9)
; CHECK-NEXT:    lvs %s35,%v0(10)
; CHECK-NEXT:    lvs %s36,%v0(11)
; CHECK-NEXT:    lvs %s37,%v0(12)
; CHECK-NEXT:    lvs %s38,%v0(13)
; CHECK-NEXT:    lvs %s39,%v0(14)
; CHECK-NEXT:    lvs %s40,%v0(15)
; CHECK-NEXT:    or %s41, 2, (0)1
; CHECK-NEXT:    stl %s41, 176(,%s11)
; CHECK-NEXT:    stl %s40, 236(,%s11)
; CHECK-NEXT:    stl %s39, 232(,%s11)
; CHECK-NEXT:    stl %s38, 228(,%s11)
; CHECK-NEXT:    stl %s37, 224(,%s11)
; CHECK-NEXT:    stl %s36, 220(,%s11)
; CHECK-NEXT:    stl %s35, 216(,%s11)
; CHECK-NEXT:    stl %s34, 212(,%s11)
; CHECK-NEXT:    stl %s7, 208(,%s11)
; CHECK-NEXT:    stl %s6, 204(,%s11)
; CHECK-NEXT:    stl %s5, 200(,%s11)
; CHECK-NEXT:    stl %s4, 196(,%s11)
; CHECK-NEXT:    stl %s3, 192(,%s11)
; CHECK-NEXT:    stl %s2, 188(,%s11)
; CHECK-NEXT:    stl %s1, 184(,%s11)
; CHECK-NEXT:    stl %s0, 180(,%s11)
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea %s1,176(,%s11)
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vldl.zx %v0,4,%s1
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = insertelement <16 x i32> %0, i32 2, i32 0
  ret <16 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_test(<16 x i32>) {
; CHECK-LABEL: __regcall3__extract_test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lvs %s0,%v0(0)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    lvs %s2,%v0(%s1)
; CHECK-NEXT:    lea.sl %s3, -1
; CHECK-NEXT:    and %s2, %s2, %s3
; CHECK-NEXT:    or %s0, %s0, %s2
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = insertelement <512 x i32> %0, i32 2, i32 0
  ret <512 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_v512i32(<512 x i32>) {
; CHECK-LABEL: __regcall3__extract_v512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    lvs %s0,%v0(%s0)
; CHECK-NEXT:    srl %s0, %s0, 32
; CHECK-NEXT:    lea %s1, -1
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    lvs %s2,%v0(%s1)
; CHECK-NEXT:    lea.sl %s3, -1
; CHECK-NEXT:    and %s2, %s2, %s3
; CHECK-NEXT:    or %s0, %s0, %s2
; CHECK-NEXT:    lsv %v0(%s1),%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = insertelement <512 x float> %0, float 1.0, i32 2
  ret <512 x float> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc float @__regcall3__extract_v512f32(<512 x float>) {
; CHECK-LABEL: __regcall3__extract_v512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s0, 1, (0)1
; CHECK-NEXT:    lvs %s0,%v0(%s0)
; CHECK-NEXT:    srl %s0, %s0, 32
; CHECK-NEXT:    lea %s1, -1
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    # kill: def $sf0 killed $sf0 killed $sx0
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
; CHECK-NEXT:    adds.w.sx %s2, %s2, (0)1
; CHECK-NEXT:    sll %s1, %s1, %s2
; CHECK-NEXT:    srl %s0, %s0, 1
; CHECK-NEXT:    lvs %s3,%v0(%s0)
; CHECK-NEXT:    lea.sl %s4, -1
; CHECK-NEXT:    srl %s2, %s4, %s2
; CHECK-NEXT:    and %s2, %s3, %s2
; CHECK-NEXT:    or %s1, %s1, %s2
; CHECK-NEXT:    lsv %v0(%s0),%s1
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
; CHECK-NEXT:    lvs %s1,%v0(%s1)
; CHECK-NEXT:    sll %s0, %s0, 63
; CHECK-NEXT:    srl %s0, %s0, 58
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    srl %s0, %s1, %s0
; CHECK-NEXT:    lea %s1, -1
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
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
; CHECK-NEXT:    adds.w.sx %s2, %s2, (0)1
; CHECK-NEXT:    sll %s1, %s1, %s2
; CHECK-NEXT:    srl %s0, %s0, 1
; CHECK-NEXT:    lvs %s3,%v0(%s0)
; CHECK-NEXT:    lea.sl %s4, -1
; CHECK-NEXT:    srl %s2, %s4, %s2
; CHECK-NEXT:    and %s2, %s3, %s2
; CHECK-NEXT:    or %s1, %s1, %s2
; CHECK-NEXT:    lsv %v0(%s0),%s1
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
; CHECK-NEXT:    lvs %s1,%v0(%s1)
; CHECK-NEXT:    sll %s0, %s0, 63
; CHECK-NEXT:    srl %s0, %s0, 58
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    srl %s0, %s1, %s0
; CHECK-NEXT:    lea %s1, -1
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 32
; CHECK-NEXT:    # kill: def $sf0 killed $sf0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = extractelement <512 x float> %0, i32 %1
  ret float %3
}

