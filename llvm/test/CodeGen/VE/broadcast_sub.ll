; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i32> @subbrdv512i32(<512 x i32>, i32) {
; CHECK-LABEL: subbrdv512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:  and %s34, %s0, (32)0
; CHECK-NEXT:  sll %s35, %s0, 32
; CHECK-NEXT:  or %s34, %s35, %s34
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvsubs %v0,%s34,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <512 x i32> %vec0, <512 x i32> undef, <512 x i32> zeroinitializer
  %ret = sub <512 x i32> %vec, %0
  ret <512 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x float> @subbrdv512f32(<512 x float>, float) {
; CHECK-LABEL: subbrdv512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sf0 killed $sf0 def $sx0
; CHECK-NEXT:  srl %s34, %s0, 32
; CHECK-NEXT:  or %s34, %s0, %s34
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvfsub %v0,%s34,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x float> undef, float %1, i32 0
  %vec = shufflevector <512 x float> %vec0, <512 x float> undef, <512 x i32> zeroinitializer
  %ret = fsub <512 x float> %vec, %0
  ret <512 x float> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @subbrdv256i64(<256 x i64>, i64) {
; CHECK-LABEL: subbrdv256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsubs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <256 x i64> %vec0, <256 x i64> undef, <256 x i32> zeroinitializer
  %ret = sub <256 x i64> %vec, %0
  ret <256 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i32> @subbrdv256i32(<256 x i32>, i32) {
; CHECK-LABEL: subbrdv256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsubs.w.sx %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <256 x i32> %vec0, <256 x i32> undef, <256 x i32> zeroinitializer
  %ret = sub <256 x i32> %vec, %0
  ret <256 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x double> @subbrdv256f64(<256 x double>, double) {
; CHECK-LABEL: subbrdv256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfsub.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x double> undef, double %1, i32 0
  %vec = shufflevector <256 x double> %vec0, <256 x double> undef, <256 x i32> zeroinitializer
  %ret = fsub <256 x double> %vec, %0
  ret <256 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x float> @subbrdv256f32(<256 x float>, float) {
; CHECK-LABEL: subbrdv256f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfsub.s %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x float> undef, float %1, i32 0
  %vec = shufflevector <256 x float> %vec0, <256 x float> undef, <256 x i32> zeroinitializer
  %ret = fsub <256 x float> %vec, %0
  ret <256 x float> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <128 x i64> @subbrdv128i64(<128 x i64>, i64) {
; CHECK-LABEL: subbrdv128i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 128
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsubs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <128 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <128 x i64> %vec0, <128 x i64> undef, <128 x i32> zeroinitializer
  %ret = sub <128 x i64> %vec, %0
  ret <128 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <64 x i64> @subbrdv64i64(<64 x i64>, i64) {
; CHECK-LABEL: subbrdv64i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 64
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsubs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <64 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <64 x i64> %vec0, <64 x i64> undef, <64 x i32> zeroinitializer
  %ret = sub <64 x i64> %vec, %0
  ret <64 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <32 x i64> @subbrdv32i64(<32 x i64>, i64) {
; CHECK-LABEL: subbrdv32i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 32
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsubs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <32 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <32 x i64> %vec0, <32 x i64> undef, <32 x i32> zeroinitializer
  %ret = sub <32 x i64> %vec, %0
  ret <32 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <16 x i64> @subbrdv16i64(<16 x i64>, i64) {
; CHECK-LABEL: subbrdv16i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 16
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsubs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <16 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <16 x i64> %vec0, <16 x i64> undef, <16 x i32> zeroinitializer
  %ret = sub <16 x i64> %vec, %0
  ret <16 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x i64> @subbrdv8i64(<8 x i64>, i64) {
; CHECK-LABEL: subbrdv8i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 8
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsubs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <8 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <8 x i64> %vec0, <8 x i64> undef, <8 x i32> zeroinitializer
  %ret = sub <8 x i64> %vec, %0
  ret <8 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x i64> @subbrdv4i64(<4 x i64>, i64) {
; CHECK-LABEL: subbrdv4i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsubs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <4 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <4 x i64> %vec0, <4 x i64> undef, <4 x i32> zeroinitializer
  %ret = sub <4 x i64> %vec, %0
  ret <4 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <2 x i64> @subbrdv2i64(<2 x i64>, i64) {
; CHECK-LABEL: subbrdv2i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vsubs.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <2 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <2 x i64> %vec0, <2 x i64> undef, <2 x i32> zeroinitializer
  %ret = sub <2 x i64> %vec, %0
  ret <2 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <128 x double> @subbrdv128f64(<128 x double>, double) {
; CHECK-LABEL: subbrdv128f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 128
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfsub.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <128 x double> undef, double %1, i32 0
  %vec = shufflevector <128 x double> %vec0, <128 x double> undef, <128 x i32> zeroinitializer
  %ret = fsub <128 x double> %vec, %0
  ret <128 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <64 x double> @subbrdv64f64(<64 x double>, double) {
; CHECK-LABEL: subbrdv64f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 64
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfsub.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <64 x double> undef, double %1, i32 0
  %vec = shufflevector <64 x double> %vec0, <64 x double> undef, <64 x i32> zeroinitializer
  %ret = fsub <64 x double> %vec, %0
  ret <64 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <32 x double> @subbrdv32f64(<32 x double>, double) {
; CHECK-LABEL: subbrdv32f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 32
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfsub.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <32 x double> undef, double %1, i32 0
  %vec = shufflevector <32 x double> %vec0, <32 x double> undef, <32 x i32> zeroinitializer
  %ret = fsub <32 x double> %vec, %0
  ret <32 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <16 x double> @subbrdv16f64(<16 x double>, double) {
; CHECK-LABEL: subbrdv16f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 16
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfsub.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <16 x double> undef, double %1, i32 0
  %vec = shufflevector <16 x double> %vec0, <16 x double> undef, <16 x i32> zeroinitializer
  %ret = fsub <16 x double> %vec, %0
  ret <16 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x double> @subbrdv8f64(<8 x double>, double) {
; CHECK-LABEL: subbrdv8f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 8
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfsub.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <8 x double> undef, double %1, i32 0
  %vec = shufflevector <8 x double> %vec0, <8 x double> undef, <8 x i32> zeroinitializer
  %ret = fsub <8 x double> %vec, %0
  ret <8 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x double> @subbrdv4f64(<4 x double>, double) {
; CHECK-LABEL: subbrdv4f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfsub.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <4 x double> undef, double %1, i32 0
  %vec = shufflevector <4 x double> %vec0, <4 x double> undef, <4 x i32> zeroinitializer
  %ret = fsub <4 x double> %vec, %0
  ret <4 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <2 x double> @subbrdv2f64(<2 x double>, double) {
; CHECK-LABEL: subbrdv2f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfsub.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <2 x double> undef, double %1, i32 0
  %vec = shufflevector <2 x double> %vec0, <2 x double> undef, <2 x i32> zeroinitializer
  %ret = fsub <2 x double> %vec, %0
  ret <2 x double> %ret
}

