; RUN: llc < %s -mtriple=ve -mattr=+intrin | FileCheck %s

define x86_regcallcc <256 x i32> @__regcall3__calc1(<256 x i32>, <256 x i32>) {
; CHECK-LABEL: __regcall3__calc1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  ret <256 x i32> %1
}

define <256 x i32> @calc2(<256 x i32>, <256 x i32>) {
; CHECK-LABEL: calc2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lea %s2, 1264(, %s11)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vldl.sx %v0, 4, %s2
; CHECK-NEXT:    vstl %v0, 4, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  ret <256 x i32> %1
}

define x86_regcallcc <256 x i32> @__regcall3__calc3(<256 x i32>, <256 x i32>, <256 x i32>, <256 x i32>, <256 x i32>, <256 x i32>, <256 x i32>, <256 x i32>, <256 x i32>) {
; CHECK-LABEL: __regcall3__calc3:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lea %s1, 240(, %s9)
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vldl.sx %v0, 4, %s1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v1, (0)1, %v2
; CHECK-NEXT:    lea %s0, __regcall3__calc1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __regcall3__calc1@hi(, %s0)
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
  %10 = tail call x86_regcallcc <256 x i32> @__regcall3__calc1(<256 x i32> %8, <256 x i32> %2)
  ret <256 x i32> %10
}

define x86_regcallcc <256 x i32> @__regcall3__calc4(<256 x i32>, <256 x i32>, <256 x i32>) {
; CHECK-LABEL: __regcall3__calc4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    st %s18, 48(, %s9) # 8-byte Folded Spill
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lea %s0, -2048(, %s9)
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vst %v18, 8, %s0 # 2048-byte Folded Spill
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v18, (0)1, %v0
; CHECK-NEXT:    lea %s0, __regcall3__calc1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s18, __regcall3__calc1@hi(, %s0)
; CHECK-NEXT:    or %s12, 0, %s18
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v1, (0)1, %v2
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s12, 0, %s18
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v1, (0)1, %v18
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lea %s0, -2048(, %s9)
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vld %v18, 8, %s0 # 2048-byte Folded Reload
; CHECK-NEXT:    ld %s18, 48(, %s9) # 8-byte Folded Reload
; CHECK-NEXT:    or %s11, 0, %s9
  %4 = tail call x86_regcallcc <256 x i32> @__regcall3__calc1(<256 x i32> %1, <256 x i32> %2)
  %5 = tail call x86_regcallcc <256 x i32> @__regcall3__calc1(<256 x i32> %4, <256 x i32> %0)
  ret <256 x i32> %5
}
