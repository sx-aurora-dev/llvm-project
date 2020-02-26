; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=-packed | FileCheck %s

; Function Attrs: nounwind
define <1 x double> @vec_add_v1f64(<1 x double> %a, <1 x double> %b) {
; CHECK-LABEL: vec_add_v1f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <1 x double> %a, %b
  ret <1 x double> %r
}

; Function Attrs: nounwind
define <2 x double> @vec_add_v2f64(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: vec_add_v2f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <2 x double> %a, %b
  ret <2 x double> %r
}

; Function Attrs: nounwind
define <3 x double> @vec_add_v3f64(<3 x double> %a, <3 x double> %b) {
; CHECK-LABEL: vec_add_v3f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 3, (0)1
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <3 x double> %a, %b
  ret <3 x double> %r
}

; Function Attrs: nounwind
define <4 x double> @vec_add_v4f64(<4 x double> %a, <4 x double> %b) {
; CHECK-LABEL: vec_add_v4f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 4, (0)1
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <4 x double> %a, %b
  ret <4 x double> %r
}

; Function Attrs: nounwind
define <8 x double> @vec_add_v8f64(<8 x double> %a, <8 x double> %b) {
; CHECK-LABEL: vec_add_v8f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 8, (0)1
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <8 x double> %a, %b
  ret <8 x double> %r
}

; Function Attrs: nounwind
define <16 x double> @vec_add_v16f64(<16 x double> %a, <16 x double> %b) {
; CHECK-LABEL: vec_add_v16f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 16, (0)1
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <16 x double> %a, %b
  ret <16 x double> %r
}

; Function Attrs: nounwind
define <32 x double> @vec_add_v32f64(<32 x double> %a, <32 x double> %b) {
; CHECK-LABEL: vec_add_v32f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 32, (0)1
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <32 x double> %a, %b
  ret <32 x double> %r
}

; Function Attrs: nounwind
define <64 x double> @vec_add_v64f64(<64 x double> %a, <64 x double> %b) {
; CHECK-LABEL: vec_add_v64f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 64
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <64 x double> %a, %b
  ret <64 x double> %r
}

; Function Attrs: nounwind
define <128 x double> @vec_add_v128f64(<128 x double> %a, <128 x double> %b) {
; CHECK-LABEL: vec_add_v128f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <128 x double> %a, %b
  ret <128 x double> %r
}

; Function Attrs: nounwind
define <253 x double> @vec_add_v253f64(<253 x double> %a, <253 x double> %b) {
; CHECK-LABEL: vec_add_v253f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 253
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <253 x double> %a, %b
  ret <253 x double> %r
}

; Function Attrs: nounwind
define <256 x double> @vec_add_v256f64(<256 x double> %a, <256 x double> %b) {
; CHECK-LABEL: vec_add_v256f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    vst %v0,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <256 x double> %a, %b
  ret <256 x double> %r
}

; Function Attrs: nounwind
define <512 x double> @vec_add_v512f64(<512 x double> %a, <512 x double> %b) {
; CHECK-LABEL: vec_add_v512f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2,6560(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    lea %s2,4512(,%s11)
; CHECK-NEXT:    vld %v2,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v3,8,%s2
; CHECK-NEXT:    vfadd.d %v2,%v3,%v2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    lea %s2, 2048(%s0)
; CHECK-NEXT:    vst %v0,8,%s2
; CHECK-NEXT:    vst %v2,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <512 x double> %a, %b
  ret <512 x double> %r
}

; Function Attrs: nounwind
define <1024 x double> @vec_add_v1024f64(<1024 x double> %a, <1024 x double> %b) {
; CHECK-LABEL: vec_add_v1024f64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2,14752(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vld %v0,8,%s2
; CHECK-NEXT:    lea %s2,6560(,%s11)
; CHECK-NEXT:    vld %v1,8,%s2
; CHECK-NEXT:    lea %s2,12704(,%s11)
; CHECK-NEXT:    vld %v2,8,%s2
; CHECK-NEXT:    lea %s2,4512(,%s11)
; CHECK-NEXT:    vld %v3,8,%s2
; CHECK-NEXT:    lea %s2,10656(,%s11)
; CHECK-NEXT:    vld %v4,8,%s2
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    vld %v5,8,%s2
; CHECK-NEXT:    lea %s2,8608(,%s11)
; CHECK-NEXT:    vld %v6,8,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vld %v7,8,%s2
; CHECK-NEXT:    vfadd.d %v6,%v7,%v6
; CHECK-NEXT:    vfadd.d %v4,%v5,%v4
; CHECK-NEXT:    vfadd.d %v2,%v3,%v2
; CHECK-NEXT:    vfadd.d %v0,%v1,%v0
; CHECK-NEXT:    lea %s2, 6144(%s0)
; CHECK-NEXT:    vst %v0,8,%s2
; CHECK-NEXT:    lea %s2, 4096(%s0)
; CHECK-NEXT:    vst %v2,8,%s2
; CHECK-NEXT:    lea %s2, 2048(%s0)
; CHECK-NEXT:    vst %v4,8,%s2
; CHECK-NEXT:    vst %v6,8,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <1024 x double> %a, %b
  ret <1024 x double> %r
}


; Function Attrs: nounwind
define <1 x float> @vec_add_v1f32(<1 x float> %a, <1 x float> %b) {
; CHECK-LABEL: vec_add_v1f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    fadd.s %s0, %s0, %s1
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <1 x float> %a, %b
  ret <1 x float> %r
}

; Function Attrs: nounwind
define <2 x float> @vec_add_v2f32(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: vec_add_v2f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    vstu %v0,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <2 x float> %a, %b
  ret <2 x float> %r
}

; Function Attrs: nounwind
define <3 x float> @vec_add_v3f32(<3 x float> %a, <3 x float> %b) {
; CHECK-LABEL: vec_add_v3f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    stu %s5, 1208(,%s11)
; CHECK-NEXT:    stu %s4, 1204(,%s11)
; CHECK-NEXT:    stu %s3, 1200(,%s11)
; CHECK-NEXT:    stu %s2, 184(,%s11)
; CHECK-NEXT:    stu %s1, 180(,%s11)
; CHECK-NEXT:    stu %s0, 176(,%s11)
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea %s1,1200(,%s11)
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vldu %v0,4,%s1
; CHECK-NEXT:    lea %s1,176(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s1
; CHECK-NEXT:    or %s0, 3, (0)1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    lvs %s0,%v0(0)
; CHECK-NEXT:    lvs %s1,%v0(1)
; CHECK-NEXT:    lvs %s2,%v0(2)
; CHECK-NEXT:    # kill: def $sf0 killed $sf0 killed $sx0
; CHECK-NEXT:    # kill: def $sf1 killed $sf1 killed $sx1
; CHECK-NEXT:    # kill: def $sf2 killed $sf2 killed $sx2
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <3 x float> %a, %b
  ret <3 x float> %r
}

; Function Attrs: nounwind
define <4 x float> @vec_add_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: vec_add_v4f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 4, (0)1
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    vstu %v0,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <4 x float> %a, %b
  ret <4 x float> %r
}

; Function Attrs: nounwind
define <8 x float> @vec_add_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: vec_add_v8f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 8, (0)1
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    vstu %v0,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <8 x float> %a, %b
  ret <8 x float> %r
}

; Function Attrs: nounwind
define <16 x float> @vec_add_v16f32(<16 x float> %a, <16 x float> %b) {
; CHECK-LABEL: vec_add_v16f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 16, (0)1
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    vstu %v0,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <16 x float> %a, %b
  ret <16 x float> %r
}

; Function Attrs: nounwind
define <32 x float> @vec_add_v32f32(<32 x float> %a, <32 x float> %b) {
; CHECK-LABEL: vec_add_v32f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    or %s1, 32, (0)1
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    vstu %v0,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <32 x float> %a, %b
  ret <32 x float> %r
}

; Function Attrs: nounwind
define <64 x float> @vec_add_v64f32(<64 x float> %a, <64 x float> %b) {
; CHECK-LABEL: vec_add_v64f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 64
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    vstu %v0,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <64 x float> %a, %b
  ret <64 x float> %r
}

; Function Attrs: nounwind
define <128 x float> @vec_add_v128f32(<128 x float> %a, <128 x float> %b) {
; CHECK-LABEL: vec_add_v128f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    vstu %v0,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <128 x float> %a, %b
  ret <128 x float> %r
}

; Function Attrs: nounwind
define <253 x float> @vec_add_v253f32(<253 x float> %a, <253 x float> %b) {
; CHECK-LABEL: vec_add_v253f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 253
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    vstu %v0,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <253 x float> %a, %b
  ret <253 x float> %r
}

; Function Attrs: nounwind
define <256 x float> @vec_add_v256f32(<256 x float> %a, <256 x float> %b) {
; CHECK-LABEL: vec_add_v256f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    vstu %v0,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <256 x float> %a, %b
  ret <256 x float> %r
}

; Function Attrs: nounwind
define <512 x float> @vec_add_v512f32(<512 x float> %a, <512 x float> %b) {
; CHECK-LABEL: vec_add_v512f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2,3488(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    vldu %v2,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v3,4,%s2
; CHECK-NEXT:    vfadd.s %v2,%v3,%v2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    lea %s2, 1024(%s0)
; CHECK-NEXT:    vstu %v0,4,%s2
; CHECK-NEXT:    vstu %v2,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <512 x float> %a, %b
  ret <512 x float> %r
}

; Function Attrs: nounwind
define <1024 x float> @vec_add_v1024f32(<1024 x float> %a, <1024 x float> %b) {
; CHECK-LABEL: vec_add_v1024f32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2,7584(,%s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldu %v0,4,%s2
; CHECK-NEXT:    lea %s2,3488(,%s11)
; CHECK-NEXT:    vldu %v1,4,%s2
; CHECK-NEXT:    lea %s2,6560(,%s11)
; CHECK-NEXT:    vldu %v2,4,%s2
; CHECK-NEXT:    lea %s2,2464(,%s11)
; CHECK-NEXT:    vldu %v3,4,%s2
; CHECK-NEXT:    lea %s2,5536(,%s11)
; CHECK-NEXT:    vldu %v4,4,%s2
; CHECK-NEXT:    lea %s2,1440(,%s11)
; CHECK-NEXT:    vldu %v5,4,%s2
; CHECK-NEXT:    lea %s2,4512(,%s11)
; CHECK-NEXT:    vldu %v6,4,%s2
; CHECK-NEXT:    lea %s2,416(,%s11)
; CHECK-NEXT:    vldu %v7,4,%s2
; CHECK-NEXT:    vfadd.s %v6,%v7,%v6
; CHECK-NEXT:    vfadd.s %v4,%v5,%v4
; CHECK-NEXT:    vfadd.s %v2,%v3,%v2
; CHECK-NEXT:    vfadd.s %v0,%v1,%v0
; CHECK-NEXT:    lea %s2, 3072(%s0)
; CHECK-NEXT:    vstu %v0,4,%s2
; CHECK-NEXT:    lea %s2, 2048(%s0)
; CHECK-NEXT:    vstu %v2,4,%s2
; CHECK-NEXT:    lea %s2, 1024(%s0)
; CHECK-NEXT:    vstu %v4,4,%s2
; CHECK-NEXT:    vstu %v6,4,%s0
; CHECK-NEXT:    or %s11, 0, %s9
  %r = fadd <1024 x float> %a, %b
  ret <1024 x float> %r
}
