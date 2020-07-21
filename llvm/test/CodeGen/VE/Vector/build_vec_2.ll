; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: nounwind
define i32 @bv_v2i32() {
; CHECK-LABEL: bv_v2i32:
entry:
  %call = tail call <2 x i32> @calc_v2i32(<2 x i32> <i32 3, i32 2>)
  %elems.sroa.0.8.vec.extract = extractelement <2 x i32> %call, i32 0
  ret i32 %elems.sroa.0.8.vec.extract
}

declare <2 x i32> @calc_v2i32(<2 x i32>)

; Function Attrs: nounwind
define i32 @brd_v4i32() {
; CHECK-LABEL: brd_v4i32:
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 2, i32 2, i32 2, i32 2>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

declare <4 x i32> @calc_v4i32(<4 x i32>)

; Function Attrs: nounwind
define i32 @vseq_v4i32() {
; CHECK-LABEL: vseq_v4i32:
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 1, i32 2, i32 3>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseq_bad_v4i32() {
; CHECK-LABEL: vseq_bad_v4i32:
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 2, i32 3, i32 4, i32 5>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqmul_v4i32() {
; CHECK-LABEL: vseqmul_v4i32:
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 3, i32 6, i32 9>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqsrl_v4i32() {
; CHECK-LABEL: vseqsrl_v4i32:
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 0, i32 1, i32 1>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

; Function Attrs: nounwind
define i32 @vseqsrl_v8i32() {
; CHECK-LABEL: vseqsrl_v8i32:
entry:
  %call = tail call <8 x i32> @calc_v8i32(<8 x i32> <i32 0, i32 0, i32 1, i32 1, i32 2, i32 2, i32 3, i32 3>)
  %elems.sroa.0.8.vec.extract = extractelement <8 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

declare <8 x i32> @calc_v8i32(<8 x i32>)

; Function Attrs: nounwind
define i32 @vseqand_v4i32() {
; CHECK-LABEL: vseqand_v4i32:
entry:
  %call = tail call <4 x i32> @calc_v4i32(<4 x i32> <i32 0, i32 1, i32 0, i32 1>)
  %elems.sroa.0.8.vec.extract = extractelement <4 x i32> %call, i32 2
  ret i32 %elems.sroa.0.8.vec.extract
}

