; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i32> @addbrdv512i32(<512 x i32>, i32) {
; CHECK-LABEL: addbrdv512i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 def $sx0
; CHECK-NEXT:  and %s34, %s0, (32)0
; CHECK-NEXT:  sll %s35, %s0, 32
; CHECK-NEXT:  or %s34, %s35, %s34
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvadds %v0,%s34,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <512 x i32> %vec0, <512 x i32> undef, <512 x i32> zeroinitializer
  %ret = add <512 x i32> %vec, %0
  ret <512 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x float> @addbrdv512f32(<512 x float>, float) {
; CHECK-LABEL: addbrdv512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  # kill: def $sf0 killed $sf0 def $sx0
; CHECK-NEXT:  srl %s34, %s0, 32
; CHECK-NEXT:  lea %s35, 256
; CHECK-NEXT:  or %s34, %s0, %s34
; CHECK-NEXT:  lvl %s35
; CHECK-NEXT:  pvfadd %v0,%s34,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <512 x float> undef, float %1, i32 0
  %vec = shufflevector <512 x float> %vec0, <512 x float> undef, <512 x i32> zeroinitializer
  %ret = fadd <512 x float> %vec, %0
  ret <512 x float> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @addbrdv256i64(<256 x i64>, i64) {
; CHECK-LABEL: addbrdv256i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <256 x i64> %vec0, <256 x i64> undef, <256 x i32> zeroinitializer
  %ret = add <256 x i64> %vec, %0
  ret <256 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i64> @addbrdv256i64s(<256 x i64>, i64) {
; CHECK-LABEL: addbrdv256i64s:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <256 x i64> %vec0, <256 x i64> undef, <256 x i32> zeroinitializer
  %ret = add <256 x i64> %0, %vec
  ret <256 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i32> @addbrdv256i32(<256 x i32>, i32) {
; CHECK-LABEL: addbrdv256i32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.w.sx %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x i32> undef, i32 %1, i32 0
  %vec = shufflevector <256 x i32> %vec0, <256 x i32> undef, <256 x i32> zeroinitializer
  %ret = add <256 x i32> %vec, %0
  ret <256 x i32> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x double> @addbrdv256f64(<256 x double>, double) {
; CHECK-LABEL: addbrdv256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfadd.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x double> undef, double %1, i32 0
  %vec = shufflevector <256 x double> %vec0, <256 x double> undef, <256 x i32> zeroinitializer
  %ret = fadd <256 x double> %vec, %0
  ret <256 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x float> @addbrdv256f32(<256 x float>, float) {
; CHECK-LABEL: addbrdv256f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 256
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfadd.s %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <256 x float> undef, float %1, i32 0
  %vec = shufflevector <256 x float> %vec0, <256 x float> undef, <256 x i32> zeroinitializer
  %ret = fadd <256 x float> %vec, %0
  ret <256 x float> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <128 x i64> @addbrdv128i64(<128 x i64>, i64) {
; CHECK-LABEL: addbrdv128i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 128
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <128 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <128 x i64> %vec0, <128 x i64> undef, <128 x i32> zeroinitializer
  %ret = add <128 x i64> %vec, %0
  ret <128 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <64 x i64> @addbrdv64i64(<64 x i64>, i64) {
; CHECK-LABEL: addbrdv64i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 64
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <64 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <64 x i64> %vec0, <64 x i64> undef, <64 x i32> zeroinitializer
  %ret = add <64 x i64> %vec, %0
  ret <64 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <32 x i64> @addbrdv32i64(<32 x i64>, i64) {
; CHECK-LABEL: addbrdv32i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 32
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <32 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <32 x i64> %vec0, <32 x i64> undef, <32 x i32> zeroinitializer
  %ret = add <32 x i64> %vec, %0
  ret <32 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <16 x i64> @addbrdv16i64(<16 x i64>, i64) {
; CHECK-LABEL: addbrdv16i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 16
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <16 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <16 x i64> %vec0, <16 x i64> undef, <16 x i32> zeroinitializer
  %ret = add <16 x i64> %vec, %0
  ret <16 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x i64> @addbrdv8i64(<8 x i64>, i64) {
; CHECK-LABEL: addbrdv8i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 8
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <8 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <8 x i64> %vec0, <8 x i64> undef, <8 x i32> zeroinitializer
  %ret = add <8 x i64> %vec, %0
  ret <8 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x i64> @addbrdv4i64(<4 x i64>, i64) {
; CHECK-LABEL: addbrdv4i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <4 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <4 x i64> %vec0, <4 x i64> undef, <4 x i32> zeroinitializer
  %ret = add <4 x i64> %vec, %0
  ret <4 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <2 x i64> @addbrdv2i64(<2 x i64>, i64) {
; CHECK-LABEL: addbrdv2i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vadds.l %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <2 x i64> undef, i64 %1, i32 0
  %vec = shufflevector <2 x i64> %vec0, <2 x i64> undef, <2 x i32> zeroinitializer
  %ret = add <2 x i64> %vec, %0
  ret <2 x i64> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <128 x double> @addbrdv128f64(<128 x double>, double) {
; CHECK-LABEL: addbrdv128f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 128
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfadd.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <128 x double> undef, double %1, i32 0
  %vec = shufflevector <128 x double> %vec0, <128 x double> undef, <128 x i32> zeroinitializer
  %ret = fadd <128 x double> %vec, %0
  ret <128 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <64 x double> @addbrdv64f64(<64 x double>, double) {
; CHECK-LABEL: addbrdv64f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 64
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfadd.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <64 x double> undef, double %1, i32 0
  %vec = shufflevector <64 x double> %vec0, <64 x double> undef, <64 x i32> zeroinitializer
  %ret = fadd <64 x double> %vec, %0
  ret <64 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <32 x double> @addbrdv32f64(<32 x double>, double) {
; CHECK-LABEL: addbrdv32f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 32
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfadd.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <32 x double> undef, double %1, i32 0
  %vec = shufflevector <32 x double> %vec0, <32 x double> undef, <32 x i32> zeroinitializer
  %ret = fadd <32 x double> %vec, %0
  ret <32 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <16 x double> @addbrdv16f64(<16 x double>, double) {
; CHECK-LABEL: addbrdv16f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 16
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfadd.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <16 x double> undef, double %1, i32 0
  %vec = shufflevector <16 x double> %vec0, <16 x double> undef, <16 x i32> zeroinitializer
  %ret = fadd <16 x double> %vec, %0
  ret <16 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x double> @addbrdv8f64(<8 x double>, double) {
; CHECK-LABEL: addbrdv8f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 8
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfadd.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <8 x double> undef, double %1, i32 0
  %vec = shufflevector <8 x double> %vec0, <8 x double> undef, <8 x i32> zeroinitializer
  %ret = fadd <8 x double> %vec, %0
  ret <8 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x double> @addbrdv4f64(<4 x double>, double) {
; CHECK-LABEL: addbrdv4f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 4
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfadd.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <4 x double> undef, double %1, i32 0
  %vec = shufflevector <4 x double> %vec0, <4 x double> undef, <4 x i32> zeroinitializer
  %ret = fadd <4 x double> %vec, %0
  ret <4 x double> %ret
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <2 x double> @addbrdv2f64(<2 x double>, double) {
; CHECK-LABEL: addbrdv2f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, 2
; CHECK-NEXT:  lvl %s34
; CHECK-NEXT:  vfadd.d %v0,%s0,%v0
; CHECK-NEXT:  or %s11, 0, %s9
  %vec0 = insertelement <2 x double> undef, double %1, i32 0
  %vec = shufflevector <2 x double> %vec0, <2 x double> undef, <2 x i32> zeroinitializer
  %ret = fadd <2 x double> %vec, %0
  ret <2 x double> %ret
}

