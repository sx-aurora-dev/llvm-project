; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

declare <32 x i8> @llvm.loongarch.lasx.xvldrepl.b(ptr, i32)

define <32 x i8> @lasx_xvldrepl_b(ptr %p) nounwind {
; CHECK-LABEL: lasx_xvldrepl_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvldrepl.b $xr0, $a0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvldrepl.b(ptr %p, i32 1)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvldrepl.h(ptr, i32)

define <16 x i16> @lasx_xvldrepl_h(ptr %p) nounwind {
; CHECK-LABEL: lasx_xvldrepl_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvldrepl.h $xr0, $a0, 2
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvldrepl.h(ptr %p, i32 2)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvldrepl.w(ptr, i32)

define <8 x i32> @lasx_xvldrepl_w(ptr %p) nounwind {
; CHECK-LABEL: lasx_xvldrepl_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvldrepl.w $xr0, $a0, 4
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvldrepl.w(ptr %p, i32 4)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvldrepl.d(ptr, i32)

define <4 x i64> @lasx_xvldrepl_d(ptr %p) nounwind {
; CHECK-LABEL: lasx_xvldrepl_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvldrepl.d $xr0, $a0, 8
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvldrepl.d(ptr %p, i32 8)
  ret <4 x i64> %res
}
