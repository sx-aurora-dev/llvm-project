; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s

; Function Attrs: nounwind
define <1 x double> @vec_add_v1f64(<1 x double> %a, <1 x double> %b) {
  %r = fadd <1 x double> %a, %b
  ret <1 x double> %r
}

; Function Attrs: nounwind
define <2 x double> @vec_add_v2f64(<2 x double> %a, <2 x double> %b) {
  %r = fadd <2 x double> %a, %b
  ret <2 x double> %r
}

; Function Attrs: nounwind
define <3 x double> @vec_add_v3f64(<3 x double> %a, <3 x double> %b) {
  %r = fadd <3 x double> %a, %b
  ret <3 x double> %r
}

; Function Attrs: nounwind
define <4 x double> @vec_add_v4f64(<4 x double> %a, <4 x double> %b) {
  %r = fadd <4 x double> %a, %b
  ret <4 x double> %r
}

; Function Attrs: nounwind
define <8 x double> @vec_add_v8f64(<8 x double> %a, <8 x double> %b) {
  %r = fadd <8 x double> %a, %b
  ret <8 x double> %r
}

; Function Attrs: nounwind
define <16 x double> @vec_add_v16f64(<16 x double> %a, <16 x double> %b) {
  %r = fadd <16 x double> %a, %b
  ret <16 x double> %r
}

; Function Attrs: nounwind
define <32 x double> @vec_add_v32f64(<32 x double> %a, <32 x double> %b) {
  %r = fadd <32 x double> %a, %b
  ret <32 x double> %r
}

; Function Attrs: nounwind
define <64 x double> @vec_add_v64f64(<64 x double> %a, <64 x double> %b) {
  %r = fadd <64 x double> %a, %b
  ret <64 x double> %r
}

; Function Attrs: nounwind
define <128 x double> @vec_add_v128f64(<128 x double> %a, <128 x double> %b) {
  %r = fadd <128 x double> %a, %b
  ret <128 x double> %r
}

; Function Attrs: nounwind
define <253 x double> @vec_add_v253f64(<253 x double> %a, <253 x double> %b) {
  %r = fadd <253 x double> %a, %b
  ret <253 x double> %r
}

; Function Attrs: nounwind
define <256 x double> @vec_add_v256f64(<256 x double> %a, <256 x double> %b) {
  %r = fadd <256 x double> %a, %b
  ret <256 x double> %r
}

; Function Attrs: nounwind
define <512 x double> @vec_add_v512f64(<512 x double> %a, <512 x double> %b) {
  %r = fadd <512 x double> %a, %b
  ret <512 x double> %r
}

; Function Attrs: nounwind
define <1024 x double> @vec_add_v1024f64(<1024 x double> %a, <1024 x double> %b) {
  %r = fadd <1024 x double> %a, %b
  ret <1024 x double> %r
}


; Function Attrs: nounwind
define <1 x float> @vec_add_v1f32(<1 x float> %a, <1 x float> %b) {
  %r = fadd <1 x float> %a, %b
  ret <1 x float> %r
}

; Function Attrs: nounwind
define <2 x float> @vec_add_v2f32(<2 x float> %a, <2 x float> %b) {
  %r = fadd <2 x float> %a, %b
  ret <2 x float> %r
}

; Function Attrs: nounwind
define <3 x float> @vec_add_v3f32(<3 x float> %a, <3 x float> %b) {
  %r = fadd <3 x float> %a, %b
  ret <3 x float> %r
}

; Function Attrs: nounwind
define <4 x float> @vec_add_v4f32(<4 x float> %a, <4 x float> %b) {
  %r = fadd <4 x float> %a, %b
  ret <4 x float> %r
}

; Function Attrs: nounwind
define <8 x float> @vec_add_v8f32(<8 x float> %a, <8 x float> %b) {
  %r = fadd <8 x float> %a, %b
  ret <8 x float> %r
}

; Function Attrs: nounwind
define <16 x float> @vec_add_v16f32(<16 x float> %a, <16 x float> %b) {
  %r = fadd <16 x float> %a, %b
  ret <16 x float> %r
}

; Function Attrs: nounwind
define <32 x float> @vec_add_v32f32(<32 x float> %a, <32 x float> %b) {
  %r = fadd <32 x float> %a, %b
  ret <32 x float> %r
}

; Function Attrs: nounwind
define <64 x float> @vec_add_v64f32(<64 x float> %a, <64 x float> %b) {
  %r = fadd <64 x float> %a, %b
  ret <64 x float> %r
}

; Function Attrs: nounwind
define <128 x float> @vec_add_v128f32(<128 x float> %a, <128 x float> %b) {
  %r = fadd <128 x float> %a, %b
  ret <128 x float> %r
}

; Function Attrs: nounwind
define <253 x float> @vec_add_v253f32(<253 x float> %a, <253 x float> %b) {
  %r = fadd <253 x float> %a, %b
  ret <253 x float> %r
}

; Function Attrs: nounwind
define <256 x float> @vec_add_v256f32(<256 x float> %a, <256 x float> %b) {
  %r = fadd <256 x float> %a, %b
  ret <256 x float> %r
}

; Function Attrs: nounwind
define <512 x float> @vec_add_v512f32(<512 x float> %a, <512 x float> %b) {
  %r = fadd <512 x float> %a, %b
  ret <512 x float> %r
}

; Function Attrs: nounwind
define <1024 x float> @vec_add_v1024f32(<1024 x float> %a, <1024 x float> %b) {
  %r = fadd <1024 x float> %a, %b
  ret <1024 x float> %r
}
