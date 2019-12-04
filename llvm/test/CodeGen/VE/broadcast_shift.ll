; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i32> @brd_shl_v512i32(<512 x i32>, i32) {
; CHECK-LABEL: brd_shl_v512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:  and %s34, %s0, (32)0
; CHECK-NEXT:  sll %s35, %s0, 32
; CHECK-NEXT:  or %s34, %s35, %s34
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvsll %v0,%v0,%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <512 x i32> %vec0, <512 x i32> undef, <512 x i32> zeroinitializer
  %ret = shl <512 x i32> %0, %vec
  ret <512 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i32> @brd_lshr_v512i32(<512 x i32>, i32) {
; CHECK-LABEL: brd_lshr_v512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:  and %s34, %s0, (32)0
; CHECK-NEXT:  sll %s35, %s0, 32
; CHECK-NEXT:  or %s34, %s35, %s34
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvsrl %v0,%v0,%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <512 x i32> %vec0, <512 x i32> undef, <512 x i32> zeroinitializer
  %ret = lshr <512 x i32> %0, %vec
  ret <512 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i32> @brd_ashr_v512i32(<512 x i32>, i32) {
; CHECK-LABEL: brd_ashr_v512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:  and %s34, %s0, (32)0
; CHECK-NEXT:  sll %s35, %s0, 32
; CHECK-NEXT:  or %s34, %s35, %s34
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvsra %v0,%v0,%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <512 x i32> %vec0, <512 x i32> undef, <512 x i32> zeroinitializer
  %ret = ashr <512 x i32> %0, %vec
  ret <512 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @brd_shl_v256i64(<256 x i64>, i64) {
; CHECK-LABEL: brd_shl_v256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsla.l %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <256 x i64> %vec0, <256 x i64> undef, <256 x i32> zeroinitializer
  %ret = shl <256 x i64> %0, %vec
  ret <256 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @brd_lshr_v256i64(<256 x i64>, i64) {
; CHECK-LABEL: brd_lshr_v256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsrl %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <256 x i64> %vec0, <256 x i64> undef, <256 x i32> zeroinitializer
  %ret = lshr <256 x i64> %0, %vec
  ret <256 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @brd_ashr_v256i64(<256 x i64>, i64) {
; CHECK-LABEL: brd_ashr_v256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsra.l %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <256 x i64> %vec0, <256 x i64> undef, <256 x i32> zeroinitializer
  %ret = ashr <256 x i64> %0, %vec
  ret <256 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i32> @brd_shl_v256i32(<256 x i32>, i32) {
; CHECK-LABEL: brd_shl_v256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  pvsla.lo %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <256 x i32> %vec0, <256 x i32> undef, <256 x i32> zeroinitializer
  %ret = shl <256 x i32> %0, %vec
  ret <256 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i32> @brd_lshr_v256i32(<256 x i32>, i32) {
; CHECK-LABEL: brd_lshr_v256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  pvsrl.lo %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <256 x i32> %vec0, <256 x i32> undef, <256 x i32> zeroinitializer
  %ret = lshr <256 x i32> %0, %vec
  ret <256 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i32> @brd_ashr_v256i32(<256 x i32>, i32) {
; CHECK-LABEL: brd_ashr_v256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  pvsra.lo %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <256 x i32> %vec0, <256 x i32> undef, <256 x i32> zeroinitializer
  %ret = ashr <256 x i32> %0, %vec
  ret <256 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <128 x i64> @brd_shl_v128i64(<128 x i64>, i64) {
; CHECK-LABEL: brd_shl_v128i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 128
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsla.l %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <128 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <128 x i64> %vec0, <128 x i64> undef, <128 x i32> zeroinitializer
  %ret = shl <128 x i64> %0, %vec
  ret <128 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <64 x i64> @brd_shl_v64i64(<64 x i64>, i64) {
; CHECK-LABEL: brd_shl_v64i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 64
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsla.l %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <64 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <64 x i64> %vec0, <64 x i64> undef, <64 x i32> zeroinitializer
  %ret = shl <64 x i64> %0, %vec
  ret <64 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <32 x i64> @brd_shl_v32i64(<32 x i64>, i64) {
; CHECK-LABEL: brd_shl_v32i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 32
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsla.l %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <32 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <32 x i64> %vec0, <32 x i64> undef, <32 x i32> zeroinitializer
  %ret = shl <32 x i64> %0, %vec
  ret <32 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <16 x i64> @brd_shl_v16i64(<16 x i64>, i64) {
; CHECK-LABEL: brd_shl_v16i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 16
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsla.l %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <16 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <16 x i64> %vec0, <16 x i64> undef, <16 x i32> zeroinitializer
  %ret = shl <16 x i64> %0, %vec
  ret <16 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x i64> @brd_shl_v8i64(<8 x i64>, i64) {
; CHECK-LABEL: brd_shl_v8i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 8
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsla.l %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <8 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <8 x i64> %vec0, <8 x i64> undef, <8 x i32> zeroinitializer
  %ret = shl <8 x i64> %0, %vec
  ret <8 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x i64> @brd_shl_v4i64(<4 x i64>, i64) {
; CHECK-LABEL: brd_shl_v4i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsla.l %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <4 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <4 x i64> %vec0, <4 x i64> undef, <4 x i32> zeroinitializer
  %ret = shl <4 x i64> %0, %vec
  ret <4 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <2 x i64> @brd_shl_v2i64(<2 x i64>, i64) {
; CHECK-LABEL: brd_shl_v2i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsla.l %v0,%v0,%s0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <2 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <2 x i64> %vec0, <2 x i64> undef, <2 x i32> zeroinitializer
  %ret = shl <2 x i64> %0, %vec
  ret <2 x i64> %ret
}

