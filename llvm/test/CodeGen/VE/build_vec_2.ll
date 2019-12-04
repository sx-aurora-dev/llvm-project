; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define i32 @bv_v2i32() {
; CHECK-LABEL: bv_v2i32:
; CHECK:       or %s34, 2, (0)1
; CHECK-NEXT:  or %s35, 3, (0)1
; CHECK-NEXT:  lsv %v0(0),%s35
; CHECK-NEXT:  lsv %v0(1),%s34
entry:
  %call = tail call <2 x i32> @calc_v2i32(<2 x i32> <i32 3, i32 2>)
  %elems.sroa.0.8.vec.extract = extractelement <2 x i32> %call, i32 0
  ret i32 %elems.sroa.0.8.vec.extract
}

declare <2 x i32> @calc_v2i32(<2 x i32>)

; Function Attrs: nounwind
define i32 @brd_v4i32() {
; CHECK-LABEL: brd_v4i32:
; CHECK:       lea %s34, 4
; CHECK:       or %s35, 2, (0)1
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vbrdl %v0,%s35
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 2, i32 2, i32 2, i32 2>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

declare <4 x i32> @calc_v4i32(<4 x i32>)

; Function Attrs: nounwind
define i32 @vseq_v4i32() {
; CHECK-LABEL: vseq_v4i32:
; CHECK:       lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK:       pvseq.lo %v0
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 1, i32 2, i32 3>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseq_bad_v4i32() {
; CHECK-LABEL: vseq_bad_v4i32:
; CHECK-NOT:   pvseq.lo
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 2, i32 3, i32 4, i32 5>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqmul_v4i32() {
; CHECK-LABEL: vseqmul_v4i32:
; CHECK:        lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  pvseq.lo %v0
; CHECK-NEXT:  or %s35, 3, (0)1
; CHECK-NEXT:  vmuls.w.sx %v0,%s35,%v0
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 3, i32 6, i32 9>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqsrl_v4i32() {
; CHECK-LABEL: vseqsrl_v4i32:
; CHECK:       or %s34, 1, (0)1
; CHECK-NEXT:  lea %s35, 4
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvseq.lo %v0
; CHECK-NEXT:  pvsrl.lo %v0,%v0,%s34
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 0, i32 1, i32 1>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqsrl_v8i32() {
; CHECK-LABEL: vseqsrl_v8i32:
; CHECK:       or %s34, 1, (0)1
; CHECK-NEXT:  lea %s35, 8
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvseq.lo %v0
; CHECK-NEXT:  pvsrl.lo %v0,%v0,%s34
entry:
  %call = tail call <8 x i32> @calc_v8i32(<8 x i32> <i32 0, i32 0, i32 1, i32 1, i32 2, i32 2, i32 3, i32 3>)
  %elems.sroa.0.8.vec.extract = extractelement <8 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

declare <8 x i32> @calc_v8i32(<8 x i32>)

; Function Attrs: nounwind
define i32 @vseqand_v4i32() {
; CHECK-LABEL: vseqand_v4i32:
; CHECK:       lea %s34, 4
; CHECK:       or %s35, 1, (0)1
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vbrdl %v0,%s35
; CHECK-NEXT:  pvseq.lo %v1
; CHECK-NEXT:  pvand.lo %v0,%v1,%v0
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 1, i32 0, i32 1>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

