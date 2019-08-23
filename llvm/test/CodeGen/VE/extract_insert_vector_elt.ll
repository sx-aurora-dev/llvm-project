; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <16 x i32> @__regcall3__insert_test(<16 x i32>) {
; CHECK-LABEL: insert_test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s34, 2, (0)1
; CHECK-NEXT:  lsv %v0(0),%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = insertelement <16 x i32> %0, i32 2, i32 0
  ret <16 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_test(<16 x i32>) {
; CHECK-LABEL: extract_test:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lvs %s0,%v0(0)
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = extractelement <16 x i32> %0, i32 0
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i32> @__regcall3__insert_v512i32(<512 x i32>) {
; CHECK-LABEL: insert_v512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s34, 2, (0)1
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  lvs %s36,%v0(%s35)
; CHECK-NEXT:  lea.sl %s37, -1
; CHECK-NEXT:  and %s36, %s36, %s37
; CHECK-NEXT:  or %s34, %s34, %s36
; CHECK-NEXT:  lsv %v0(%s35),%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = insertelement <512 x i32> %0, i32 2, i32 0
  ret <512 x i32> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_v512i32(<512 x i32>) {
; CHECK-LABEL: extract_v512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s34, 1, (0)1
; CHECK-NEXT:  lvs %s34,%v0(%s34)
; CHECK-NEXT:  srl %s34, %s34, 32
; CHECK-NEXT:  lea %s35, -1
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  and %s0, %s34, %s35
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = extractelement <512 x i32> %0, i32 3
  ret i32 %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__insert_v512f32(<512 x float>) {
; CHECK-LABEL: insert_v512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 1065353216
; CHECK-NEXT:  or %s35, 1, (0)1
; CHECK-NEXT:  lvs %s36,%v0(%s35)
; CHECK-NEXT:  lea.sl %s37, -1
; CHECK-NEXT:  and %s36, %s36, %s37
; CHECK-NEXT:  or %s34, %s34, %s36
; CHECK-NEXT:  lsv %v0(%s35),%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = insertelement <512 x float> %0, float 1.0, i32 2
  ret <512 x float> %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc float @__regcall3__extract_v512f32(<512 x float>) {
; CHECK-LABEL: extract_v512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s34, 1, (0)1
; CHECK-NEXT:  lvs %s34,%v0(%s34)
; CHECK-NEXT:  srl %s34, %s34, 32
; CHECK-NEXT:  lea %s35, -1
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  and %s34, %s34, %s35
; CHECK-NEXT:  sll %s0, %s34, 32
; CHECK-NEXT:  # kill: def $sf0 killed $sf0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = extractelement <512 x float> %0, i32 3
  ret float %2
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x i32> @__regcall3__insert_v512i32r(<512 x i32>, i32) {
; CHECK-LABEL: insert_v512i32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s34, 2, (0)1
; CHECK-NEXT:  adds.w.sx %s35, %s0, (0)1
; CHECK-NEXT:  sll %s36, %s35, 63
; CHECK-NEXT:  srl %s36, %s36, 58
; CHECK-NEXT:  adds.w.sx %s36, %s36, (0)1
; CHECK-NEXT:  sll %s34, %s34, %s36
; CHECK-NEXT:  srl %s35, %s35, 1
; CHECK-NEXT:  lvs %s37,%v0(%s35)
; CHECK-NEXT:  lea.sl %s38, -1
; CHECK-NEXT:  srl %s36, %s38, %s36
; CHECK-NEXT:  and %s36, %s37, %s36
; CHECK-NEXT:  or %s34, %s34, %s36
; CHECK-NEXT:  lsv %v0(%s35),%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %3 = insertelement <512 x i32> %0, i32 2, i32 %1
  ret <512 x i32> %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc i32 @__regcall3__extract_v512i32r(<512 x i32>, i32) {
; CHECK-LABEL: extract_v512i32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:  srl %s35, %s34, 1
; CHECK-NEXT:  lvs %s35,%v0(%s35)
; CHECK-NEXT:  sll %s34, %s34, 63
; CHECK-NEXT:  srl %s34, %s34, 58
; CHECK-NEXT:  adds.w.sx %s34, %s34, (0)1
; CHECK-NEXT:  srl %s34, %s35, %s34
; CHECK-NEXT:  lea %s35, -1
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  and %s0, %s34, %s35
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
  %3 = extractelement <512 x i32> %0, i32 %1
  ret i32 %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc <512 x float> @__regcall3__insert_v512f32r(<512 x float>, i32) {
; CHECK-LABEL: insert_v512f32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 1065353216
; CHECK-NEXT:  adds.w.sx %s35, %s0, (0)1
; CHECK-NEXT:  sll %s36, %s35, 63
; CHECK-NEXT:  srl %s36, %s36, 58
; CHECK-NEXT:  adds.w.sx %s36, %s36, (0)1
; CHECK-NEXT:  sll %s34, %s34, %s36
; CHECK-NEXT:  srl %s35, %s35, 1
; CHECK-NEXT:  lvs %s37,%v0(%s35)
; CHECK-NEXT:  lea.sl %s38, -1
; CHECK-NEXT:  srl %s36, %s38, %s36
; CHECK-NEXT:  and %s36, %s37, %s36
; CHECK-NEXT:  or %s34, %s34, %s36
; CHECK-NEXT:  lsv %v0(%s35),%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %3 = insertelement <512 x float> %0, float 1.0, i32 %1
  ret <512 x float> %3
}

; Function Attrs: norecurse nounwind readnone
define x86_regcallcc float @__regcall3__extract_v512f32r(<512 x float>, i32) {
; CHECK-LABEL: extract_v512f32r:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  adds.w.sx %s34, %s0, (0)1
; CHECK-NEXT:  srl %s35, %s34, 1
; CHECK-NEXT:  lvs %s35,%v0(%s35)
; CHECK-NEXT:  sll %s34, %s34, 63
; CHECK-NEXT:  srl %s34, %s34, 58
; CHECK-NEXT:  adds.w.sx %s34, %s34, (0)1
; CHECK-NEXT:  srl %s34, %s35, %s34
; CHECK-NEXT:  lea %s35, -1
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  and %s34, %s34, %s35
; CHECK-NEXT:  sll %s0, %s34, 32
; CHECK-NEXT:  # kill: def $sf0 killed $sf0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
  %3 = extractelement <512 x float> %0, i32 %1
  ret float %3
}

