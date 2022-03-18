; RUN: opt < %s -instcombine -S | FileCheck %s

; PR4374

define <4 x float> @test1_vp(<4 x float> %x, <4 x float> %y, <4 x i1> %M, i32 %L) {
; CHECK-LABEL: @test1_vp(
;
  %t1 = call <4 x float> @llvm.vp.fsub.v4f32(<4 x float> %x, <4 x float> %y, <4 x i1> %M, i32 %L) #0
  %t2 = call <4 x float> @llvm.vp.fsub.v4f32(<4 x float> <float -0.0, float -0.0, float -0.0, float -0.0>, <4 x float> %t1, <4 x i1> %M, i32 %L) #0
  ret <4 x float> %t2
}

; Can't do anything with the test above because -0.0 - 0.0 = -0.0, but if we have nsz:
; -(X - Y) --> Y - X

; TODO predicated FAdd folding
define <4 x float> @neg_sub_nsz_vp(<4 x float> %x, <4 x float> %y, <4 x i1> %M, i32 %L) {
; CH***-LABEL: @neg_sub_nsz_vp(
;
  %t1 = call <4 x float> @llvm.vp.fsub.v4f32(<4 x float> %x, <4 x float> %y, <4 x i1> %M, i32 %L) #0
  %t2 = call nsz <4 x float> @llvm.vp.fsub.v4f32(<4 x float> <float -0.0, float -0.0, float -0.0, float -0.0>, <4 x float> %t1, <4 x i1> %M, i32 %L) #0
  ret <4 x float> %t2
}

; With nsz: Z - (X - Y) --> Z + (Y - X)

define <4 x float> @sub_sub_nsz_vp(<4 x float> %x, <4 x float> %y, <4 x float> %z, <4 x i1> %M, i32 %L) {
; CHECK-LABEL: @sub_sub_nsz_vp(
;  CHECK-NEXT:   %1 = call nsz <4 x float> @llvm.vp.fsub.v4f32(<4 x float> %y, <4 x float> %x, <4 x i1> %M, i32 %L) #
;  CHECK-NEXT:   %t2 = call nsz <4 x float> @llvm.vp.fadd.v4f32(<4 x float> %z, <4 x float> %1, <4 x i1> %M, i32 %L) #
;  CHECK-NEXT:   ret <4 x float> %t2
  %t1 = call <4 x float> @llvm.vp.fsub.v4f32(<4 x float> %x, <4 x float> %y, <4 x i1> %M, i32 %L) #0
  %t2 = call nsz <4 x float> @llvm.vp.fsub.v4f32(<4 x float> %z, <4 x float> %t1, <4 x i1> %M, i32 %L) #0
  ret <4 x float> %t2
}



; Function Attrs: nounwind readnone
declare <4 x float> @llvm.vp.fadd.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

; Function Attrs: nounwind readnone
declare <4 x float> @llvm.vp.fsub.v4f32(<4 x float>, <4 x float>, <4 x i1>, i32)

attributes #0 = { readnone }
