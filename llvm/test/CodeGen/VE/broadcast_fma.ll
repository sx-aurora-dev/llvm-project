; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x float> @fmadrvv512f32(<512 x float>, float) {
; CHECK-LABEL: fmadrvv512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sf0 killed $sf0 def $sx0
; CHECK-NEXT:  srl %s34, %s0, 32
; CHECK-NEXT:  or %s34, %s0, %s34
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvfmad %v0,%v0,%s34,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x float> undef, float %1, i32 0
  %vec = shufflevector <512 x float> %vec0, <512 x float> undef, <512 x i32> zeroinitializer
  %ret = fmul fast <512 x float> %vec, %0
  %ret2 = fadd fast <512 x float> %ret, %0
  ret <512 x float> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x float> @fmadrvv512f32s(<512 x float>, float) {
; CHECK-LABEL: fmadrvv512f32s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sf0 killed $sf0 def $sx0
; CHECK-NEXT:  srl %s34, %s0, 32
; CHECK-NEXT:  or %s34, %s0, %s34
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvfmad %v0,%v0,%s34,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x float> undef, float %1, i32 0
  %vec = shufflevector <512 x float> %vec0, <512 x float> undef, <512 x i32> zeroinitializer
  %ret = fmul fast <512 x float> %0, %vec
  %ret2 = fadd fast <512 x float> %ret, %0
  ret <512 x float> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x float> @fmadrvv512f32s2(<512 x float>, float) {
; CHECK-LABEL: fmadrvv512f32s2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sf0 killed $sf0 def $sx0
; CHECK-NEXT:  srl %s34, %s0, 32
; CHECK-NEXT:  or %s34, %s0, %s34
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvfmad %v0,%s34,%v0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x float> undef, float %1, i32 0
  %vec = shufflevector <512 x float> %vec0, <512 x float> undef, <512 x i32> zeroinitializer
  %ret = fmul fast <512 x float> %0, %0
  %ret2 = fadd fast <512 x float> %ret, %vec
  ret <512 x float> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x double> @fmadrvv256f64(<256 x double>, double) {
; CHECK-LABEL: fmadrvv256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x double> undef, double %1, i32 0
  %vec = shufflevector <256 x double> %vec0, <256 x double> undef, <256 x i32> zeroinitializer
  %ret = fmul fast <256 x double> %vec, %0
  %ret2 = fadd fast <256 x double> %ret, %0
  ret <256 x double> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x double> @fmadrvv256f64s(<256 x double>, double) {
; CHECK-LABEL: fmadrvv256f64s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x double> undef, double %1, i32 0
  %vec = shufflevector <256 x double> %vec0, <256 x double> undef, <256 x i32> zeroinitializer
  %ret = fmul fast <256 x double> %0, %vec
  %ret2 = fadd fast <256 x double> %ret, %0
  ret <256 x double> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x double> @fmadrvv256f64s2(<256 x double>, double) {
; CHECK-LABEL: fmadrvv256f64s2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%s0,%v0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x double> undef, double %1, i32 0
  %vec = shufflevector <256 x double> %vec0, <256 x double> undef, <256 x i32> zeroinitializer
  %ret = fmul fast <256 x double> %0, %0
  %ret2 = fadd fast <256 x double> %ret, %vec
  ret <256 x double> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x float> @fmadrvv256f32(<256 x float>, float) {
; CHECK-LABEL: fmadrvv256f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.s %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x float> undef, float %1, i32 0
  %vec = shufflevector <256 x float> %vec0, <256 x float> undef, <256 x i32> zeroinitializer
  %ret = fmul fast <256 x float> %vec, %0
  %ret2 = fadd fast <256 x float> %ret, %0
  ret <256 x float> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x float> @fmadrvv256f32s(<256 x float>, float) {
; CHECK-LABEL: fmadrvv256f32s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.s %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x float> undef, float %1, i32 0
  %vec = shufflevector <256 x float> %vec0, <256 x float> undef, <256 x i32> zeroinitializer
  %ret = fmul fast <256 x float> %0, %vec
  %ret2 = fadd fast <256 x float> %ret, %0
  ret <256 x float> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x float> @fmadrvv256f32s2(<256 x float>, float) {
; CHECK-LABEL: fmadrvv256f32s2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.s %v0,%s0,%v0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x float> undef, float %1, i32 0
  %vec = shufflevector <256 x float> %vec0, <256 x float> undef, <256 x i32> zeroinitializer
  %ret = fmul fast <256 x float> %0, %0
  %ret2 = fadd fast <256 x float> %ret, %vec
  ret <256 x float> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <128 x double> @fmadrvv128f64(<128 x double>, double) {
; CHECK-LABEL: fmadrvv128f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 128
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <128 x double> undef, double %1, i32 0
  %vec = shufflevector <128 x double> %vec0, <128 x double> undef, <128 x i32> zeroinitializer
  %ret = fmul fast <128 x double> %vec, %0
  %ret2 = fadd fast <128 x double> %ret, %0
  ret <128 x double> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <64 x double> @fmadrvv64f64(<64 x double>, double) {
; CHECK-LABEL: fmadrvv64f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 64
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <64 x double> undef, double %1, i32 0
  %vec = shufflevector <64 x double> %vec0, <64 x double> undef, <64 x i32> zeroinitializer
  %ret = fmul fast <64 x double> %vec, %0
  %ret2 = fadd fast <64 x double> %ret, %0
  ret <64 x double> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <32 x double> @fmadrvv32f64(<32 x double>, double) {
; CHECK-LABEL: fmadrvv32f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 32
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <32 x double> undef, double %1, i32 0
  %vec = shufflevector <32 x double> %vec0, <32 x double> undef, <32 x i32> zeroinitializer
  %ret = fmul fast <32 x double> %vec, %0
  %ret2 = fadd fast <32 x double> %ret, %0
  ret <32 x double> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <16 x double> @fmadrvv16f64(<16 x double>, double) {
; CHECK-LABEL: fmadrvv16f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 16
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <16 x double> undef, double %1, i32 0
  %vec = shufflevector <16 x double> %vec0, <16 x double> undef, <16 x i32> zeroinitializer
  %ret = fmul fast <16 x double> %vec, %0
  %ret2 = fadd fast <16 x double> %ret, %0
  ret <16 x double> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x double> @fmadrvv8f64(<8 x double>, double) {
; CHECK-LABEL: fmadrvv8f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 8
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <8 x double> undef, double %1, i32 0
  %vec = shufflevector <8 x double> %vec0, <8 x double> undef, <8 x i32> zeroinitializer
  %ret = fmul fast <8 x double> %vec, %0
  %ret2 = fadd fast <8 x double> %ret, %0
  ret <8 x double> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x double> @fmadrvv4f64(<4 x double>, double) {
; CHECK-LABEL: fmadrvv4f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <4 x double> undef, double %1, i32 0
  %vec = shufflevector <4 x double> %vec0, <4 x double> undef, <4 x i32> zeroinitializer
  %ret = fmul fast <4 x double> %vec, %0
  %ret2 = fadd fast <4 x double> %ret, %0
  ret <4 x double> %ret2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <2 x double> @fmadrvv2f64(<2 x double>, double) {
; CHECK-LABEL: fmadrvv2f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfmad.d %v0,%v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <2 x double> undef, double %1, i32 0
  %vec = shufflevector <2 x double> %vec0, <2 x double> undef, <2 x i32> zeroinitializer
  %ret = fmul fast <2 x double> %vec, %0
  %ret2 = fadd fast <2 x double> %ret, %0
  ret <2 x double> %ret2
}

