; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

define void @mul_v32i8(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mul_v32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvmul.b $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %v2 = mul <32 x i8> %v0, %v1
  store <32 x i8> %v2, ptr %res
  ret void
}

define void @mul_v16i16(ptr %res, ptr %a0, ptr %a1)  nounwind {
; CHECK-LABEL: mul_v16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvmul.h $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %v2 = mul <16 x i16> %v0, %v1
  store <16 x i16> %v2, ptr %res
  ret void
}

define void @mul_v8i32(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mul_v8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvmul.w $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %v2 = mul <8 x i32> %v0, %v1
  store <8 x i32> %v2, ptr %res
  ret void
}

define void @mul_v4i64(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mul_v4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvld $xr1, $a2, 0
; CHECK-NEXT:    xvmul.d $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %v2 = mul <4 x i64> %v0, %v1
  store <4 x i64> %v2, ptr %res
  ret void
}

define void @mul_square_v32i8(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_square_v32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvmul.b $xr0, $xr0, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <32 x i8>, ptr %a0
  %v1 = mul <32 x i8> %v0, %v0
  store <32 x i8> %v1, ptr %res
  ret void
}

define void @mul_square_v16i16(ptr %res, ptr %a0)  nounwind {
; CHECK-LABEL: mul_square_v16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvmul.h $xr0, $xr0, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i16>, ptr %a0
  %v1 = mul <16 x i16> %v0, %v0
  store <16 x i16> %v1, ptr %res
  ret void
}

define void @mul_square_v8i32(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_square_v8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvmul.w $xr0, $xr0, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i32>, ptr %a0
  %v1 = mul <8 x i32> %v0, %v0
  store <8 x i32> %v1, ptr %res
  ret void
}

define void @mul_square_v4i64(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_square_v4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvmul.d $xr0, $xr0, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i64>, ptr %a0
  %v1 = mul <4 x i64> %v0, %v0
  store <4 x i64> %v1, ptr %res
  ret void
}

define void @mul_v32i8_8(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v32i8_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslli.b $xr0, $xr0, 3
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <32 x i8>, ptr %a0
  %v1 = mul <32 x i8> %v0, <i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8, i8 8>
  store <32 x i8> %v1, ptr %res
  ret void
}

define void @mul_v16i16_8(ptr %res, ptr %a0)  nounwind {
; CHECK-LABEL: mul_v16i16_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslli.h $xr0, $xr0, 3
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i16>, ptr %a0
  %v1 = mul <16 x i16> %v0, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  store <16 x i16> %v1, ptr %res
  ret void
}

define void @mul_v8i32_8(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v8i32_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslli.w $xr0, $xr0, 3
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i32>, ptr %a0
  %v1 = mul <8 x i32> %v0, <i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8>
  store <8 x i32> %v1, ptr %res
  ret void
}

define void @mul_v4i64_8(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v4i64_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvslli.d $xr0, $xr0, 3
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i64>, ptr %a0
  %v1 = mul <4 x i64> %v0, <i64 8, i64 8, i64 8, i64 8>
  store <4 x i64> %v1, ptr %res
  ret void
}

define void @mul_v32i8_17(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v32i8_17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvrepli.b $xr1, 17
; CHECK-NEXT:    xvmul.b $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <32 x i8>, ptr %a0
  %v1 = mul <32 x i8> %v0, <i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17, i8 17>
  store <32 x i8> %v1, ptr %res
  ret void
}

define void @mul_v16i16_17(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v16i16_17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvrepli.h $xr1, 17
; CHECK-NEXT:    xvmul.h $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i16>, ptr %a0
  %v1 = mul <16 x i16> %v0, <i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17, i16 17>
  store <16 x i16> %v1, ptr %res
  ret void
}

define void @mul_v8i32_17(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v8i32_17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvrepli.w $xr1, 17
; CHECK-NEXT:    xvmul.w $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i32>, ptr %a0
  %v1 = mul <8 x i32> %v0, <i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17, i32 17>
  store <8 x i32> %v1, ptr %res
  ret void
}

define void @mul_v4i64_17(ptr %res, ptr %a0) nounwind {
; CHECK-LABEL: mul_v4i64_17:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a1, 0
; CHECK-NEXT:    xvrepli.d $xr1, 17
; CHECK-NEXT:    xvmul.d $xr0, $xr0, $xr1
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i64>, ptr %a0
  %v1 = mul <4 x i64> %v0, <i64 17, i64 17, i64 17, i64 17>
  store <4 x i64> %v1, ptr %res
  ret void
}
