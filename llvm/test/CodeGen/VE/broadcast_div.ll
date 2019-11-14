; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i32> @sdivbrdv512i32(<512 x i32>, i32) {
; FIXME: mul <512 x i32> is expanded completely with more than 512
; FIXME: isntructions, so we don't check it atm.  Need to implement
; FIXME: better code.
; FIXME-CHECK-LABEL: sdivbrdv512i32:
; FIXME-CHECK:       .LBB{{[0-9]+}}_2:
; FIXME-CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; FIXME-CHECK-NEXT:  and %s34, %s0, (32)0
; FIXME-CHECK-NEXT:  sll %s35, %s0, 32
; FIXME-CHECK-NEXT:  lea %s36, 256
; FIXME-CHECK-NEXT:  or %s34, %s35, %s34
; FIXME-CHECK-NEXT:  lvl %s36
; FIXME-CHECK-NEXT:  pvdivs %v0,%s34,%v0
; FIXME-CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <512 x i32> %vec0, <512 x i32> undef, <512 x i32> zeroinitializer
  %ret = sdiv <512 x i32> %vec, %0
  ret <512 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i32> @udivbrdv512i32(<512 x i32>, i32) {
; FIXME: mul <512 x i32> is expanded completely with more than 512
; FIXME: isntructions, so we don't check it atm.  Need to implement
; FIXME: better code.
; FIXME-CHECK-LABEL: udivbrdv512i32:
; FIXME-CHECK:       .LBB{{[0-9]+}}_2:
; FIXME-CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; FIXME-CHECK-NEXT:  and %s34, %s0, (32)0
; FIXME-CHECK-NEXT:  sll %s35, %s0, 32
; FIXME-CHECK-NEXT:  lea %s36, 256
; FIXME-CHECK-NEXT:  or %s34, %s35, %s34
; FIXME-CHECK-NEXT:  lvl %s36
; FIXME-CHECK-NEXT:  pvdivs %v0,%s34,%v0
; FIXME-CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <512 x i32> %vec0, <512 x i32> undef, <512 x i32> zeroinitializer
  %ret = udiv <512 x i32> %vec, %0
  ret <512 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @sdivbrdv256i64(<256 x i64>, i64) {
; CHECK-LABEL: sdivbrdv256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <256 x i64> %vec0, <256 x i64> undef, <256 x i32> zeroinitializer
  %ret = sdiv <256 x i64> %vec, %0
  ret <256 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @udivbrdv256i64(<256 x i64>, i64) {
; CHECK-LABEL: udivbrdv256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivu.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <256 x i64> %vec0, <256 x i64> undef, <256 x i32> zeroinitializer
  %ret = udiv <256 x i64> %vec, %0
  ret <256 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i32> @sdivbrdv256i32(<256 x i32>, i32) {
; CHECK-LABEL: sdivbrdv256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivs.w.sx %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <256 x i32> %vec0, <256 x i32> undef, <256 x i32> zeroinitializer
  %ret = sdiv <256 x i32> %vec, %0
  ret <256 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i32> @udivbrdv256i32(<256 x i32>, i32) {
; CHECK-LABEL: udivbrdv256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivu.w %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <256 x i32> %vec0, <256 x i32> undef, <256 x i32> zeroinitializer
  %ret = udiv <256 x i32> %vec, %0
  ret <256 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x double> @divbrdv256f64(<256 x double>, double) {
; CHECK-LABEL: divbrdv256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfdiv.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x double> undef, double %1, i32 0
  %vec = shufflevector <256 x double> %vec0, <256 x double> undef, <256 x i32> zeroinitializer
  %ret = fdiv <256 x double> %vec, %0
  ret <256 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x float> @divbrdv256f32(<256 x float>, float) {
; CHECK-LABEL: divbrdv256f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfdiv.s %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x float> undef, float %1, i32 0
  %vec = shufflevector <256 x float> %vec0, <256 x float> undef, <256 x i32> zeroinitializer
  %ret = fdiv <256 x float> %vec, %0
  ret <256 x float> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <128 x i64> @sdivbrdv128i64(<128 x i64>, i64) {
; CHECK-LABEL: sdivbrdv128i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 128
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <128 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <128 x i64> %vec0, <128 x i64> undef, <128 x i32> zeroinitializer
  %ret = sdiv <128 x i64> %vec, %0
  ret <128 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <64 x i64> @sdivbrdv64i64(<64 x i64>, i64) {
; CHECK-LABEL: sdivbrdv64i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 64
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <64 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <64 x i64> %vec0, <64 x i64> undef, <64 x i32> zeroinitializer
  %ret = sdiv <64 x i64> %vec, %0
  ret <64 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <32 x i64> @sdivbrdv32i64(<32 x i64>, i64) {
; CHECK-LABEL: sdivbrdv32i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 32
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <32 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <32 x i64> %vec0, <32 x i64> undef, <32 x i32> zeroinitializer
  %ret = sdiv <32 x i64> %vec, %0
  ret <32 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <16 x i64> @sdivbrdv16i64(<16 x i64>, i64) {
; CHECK-LABEL: sdivbrdv16i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 16
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <16 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <16 x i64> %vec0, <16 x i64> undef, <16 x i32> zeroinitializer
  %ret = sdiv <16 x i64> %vec, %0
  ret <16 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x i64> @sdivbrdv8i64(<8 x i64>, i64) {
; CHECK-LABEL: sdivbrdv8i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 8
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <8 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <8 x i64> %vec0, <8 x i64> undef, <8 x i32> zeroinitializer
  %ret = sdiv <8 x i64> %vec, %0
  ret <8 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x i64> @sdivbrdv4i64(<4 x i64>, i64) {
; CHECK-LABEL: sdivbrdv4i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <4 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <4 x i64> %vec0, <4 x i64> undef, <4 x i32> zeroinitializer
  %ret = sdiv <4 x i64> %vec, %0
  ret <4 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <2 x i64> @sdivbrdv2i64(<2 x i64>, i64) {
; CHECK-LABEL: sdivbrdv2i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vdivs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <2 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <2 x i64> %vec0, <2 x i64> undef, <2 x i32> zeroinitializer
  %ret = sdiv <2 x i64> %vec, %0
  ret <2 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <128 x double> @divbrdv128f64(<128 x double>, double) {
; CHECK-LABEL: divbrdv128f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 128
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfdiv.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <128 x double> undef, double %1, i32 0
  %vec = shufflevector <128 x double> %vec0, <128 x double> undef, <128 x i32> zeroinitializer
  %ret = fdiv <128 x double> %vec, %0
  ret <128 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <64 x double> @divbrdv64f64(<64 x double>, double) {
; CHECK-LABEL: divbrdv64f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 64
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfdiv.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <64 x double> undef, double %1, i32 0
  %vec = shufflevector <64 x double> %vec0, <64 x double> undef, <64 x i32> zeroinitializer
  %ret = fdiv <64 x double> %vec, %0
  ret <64 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <32 x double> @divbrdv32f64(<32 x double>, double) {
; CHECK-LABEL: divbrdv32f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 32
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfdiv.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <32 x double> undef, double %1, i32 0
  %vec = shufflevector <32 x double> %vec0, <32 x double> undef, <32 x i32> zeroinitializer
  %ret = fdiv <32 x double> %vec, %0
  ret <32 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <16 x double> @divbrdv16f64(<16 x double>, double) {
; CHECK-LABEL: divbrdv16f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 16
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfdiv.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <16 x double> undef, double %1, i32 0
  %vec = shufflevector <16 x double> %vec0, <16 x double> undef, <16 x i32> zeroinitializer
  %ret = fdiv <16 x double> %vec, %0
  ret <16 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x double> @divbrdv8f64(<8 x double>, double) {
; CHECK-LABEL: divbrdv8f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 8
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfdiv.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <8 x double> undef, double %1, i32 0
  %vec = shufflevector <8 x double> %vec0, <8 x double> undef, <8 x i32> zeroinitializer
  %ret = fdiv <8 x double> %vec, %0
  ret <8 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x double> @divbrdv4f64(<4 x double>, double) {
; CHECK-LABEL: divbrdv4f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfdiv.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <4 x double> undef, double %1, i32 0
  %vec = shufflevector <4 x double> %vec0, <4 x double> undef, <4 x i32> zeroinitializer
  %ret = fdiv <4 x double> %vec, %0
  ret <4 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <2 x double> @divbrdv2f64(<2 x double>, double) {
; CHECK-LABEL: divbrdv2f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfdiv.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <2 x double> undef, double %1, i32 0
  %vec = shufflevector <2 x double> %vec0, <2 x double> undef, <2 x i32> zeroinitializer
  %ret = fdiv <2 x double> %vec, %0
  ret <2 x double> %ret
}

