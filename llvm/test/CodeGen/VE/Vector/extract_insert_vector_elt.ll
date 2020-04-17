; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

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
; CHECK-NEXT:    lsv %v0(0),%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = insertelement <512 x i32> %0, i32 2, i32 0
  ret <512 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_v512i32(<512 x i32>) {
; CHECK-LABEL: __regcall3__extract_v512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lvs %s0,%v0(3)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = extractelement <512 x i32> %0, i32 3
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__insert_v512f32(<512 x float>) {
; CHECK-LABEL: __regcall3__insert_v512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea.sl %s0, 1065353216
; CHECK-NEXT:    or %s0, 0, %s0
; CHECK-NEXT:    lsv %v0(2),%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = insertelement <512 x float> %0, float 1.0, i32 2
  ret <512 x float> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc float @__regcall3__extract_v512f32(<512 x float>) {
; CHECK-LABEL: __regcall3__extract_v512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lvs %s0,%v0(3)
; CHECK-NEXT:    # kill: def $sf0 killed $sf0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = extractelement <512 x float> %0, i32 3
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i32> @__regcall3__insert_v512i32r(<512 x i32>, i32) {
; CHECK-LABEL: __regcall3__insert_v512i32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2, 176(, %s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vstl %v0,4,%s2
; CHECK-NEXT:    lea %s3, 1024(, %s2)
; CHECK-NEXT:    vstl %v1,4,%s3
; CHECK-NEXT:    lea %s4, 511
; CHECK-NEXT:    and %s0, %s0, %s4
; CHECK-NEXT:    sll %s0, %s0, 2
; CHECK-NEXT:    or %s4, 2, (0)1
; CHECK-NEXT:    stl %s4, 176(%s0, %s11)
; CHECK-NEXT:    vldl.zx %v0,4,%s2
; CHECK-NEXT:    vldl.zx %v1,4,%s3
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = insertelement <512 x i32> %0, i32 2, i32 %1
  ret <512 x i32> %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_v512i32r(<512 x i32>, i32) {
; CHECK-LABEL: __regcall3__extract_v512i32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2, 176(, %s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vstl %v0,4,%s2
; CHECK-NEXT:    lea %s2, 1024(, %s2)
; CHECK-NEXT:    vstl %v1,4,%s2
; CHECK-NEXT:    lea %s1, 511
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 2
; CHECK-NEXT:    ldl.sx %s0, 176(%s0, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = extractelement <512 x i32> %0, i32 %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__insert_v512f32r(<512 x float>, i32) {
; CHECK-LABEL: __regcall3__insert_v512f32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2, 176(, %s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vstu %v0,4,%s2
; CHECK-NEXT:    lea %s3, 1024(, %s2)
; CHECK-NEXT:    vstu %v1,4,%s3
; CHECK-NEXT:    lea %s4, 511
; CHECK-NEXT:    and %s0, %s0, %s4
; CHECK-NEXT:    sll %s0, %s0, 2
; CHECK-NEXT:    lea %s4, 1065353216
; CHECK-NEXT:    stl %s4, 176(%s0, %s11)
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    vldu %v1,4,%s3
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = insertelement <512 x float> %0, float 1.0, i32 %1
  ret <512 x float> %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc float @__regcall3__extract_v512f32r(<512 x float>, i32) {
; CHECK-LABEL: __regcall3__extract_v512f32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2, 176(, %s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vstu %v0,4,%s2
; CHECK-NEXT:    lea %s2, 1024(, %s2)
; CHECK-NEXT:    vstu %v1,4,%s2
; CHECK-NEXT:    lea %s1, 511
; CHECK-NEXT:    and %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 2
; CHECK-NEXT:    ldu %s0, 176(%s0, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = extractelement <512 x float> %0, i32 %1
  ret float %3
}

