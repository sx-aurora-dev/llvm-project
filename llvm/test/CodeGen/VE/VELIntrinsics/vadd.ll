; RUN: llc < %s -mtriple=ve -mattr=+vpu | FileCheck %s

;;; Test vector add intrinsic instructions
;;;
;;; Note:
;;;   We test VADD*ivl, VADD*ivl_v, VADD*ivml_v, VADD*rvl, VADD*rvl_v,
;;;   VADD*rvml_v, VADD*vvl, VADD*vvl_v, VADD*vvml_v PVADD*vvl, PVADD*vvl_v,
;;;   PVADD*rvl, PVADD*rvl_v, PVADD*vvml_v and PVADD*rvml_v instructions.

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddsl_vsvl(i64 %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddsl_vsvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.l %v0, %s0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddsl.vsvl(i64 %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddsl.vsvl(i64, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddsl_vsvl_imm(<256 x double> %0) {
; CHECK-LABEL: __regcall3__vaddsl_vsvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.l %v0, 8, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call fast <256 x double> @llvm.ve.vl.vaddsl.vsvl(i64 8, <256 x double> %0, i32 256)
  ret <256 x double> %2
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddsl_vsvmvl(i64 %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vaddsl_vsvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.l %v1, %s0, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vaddsl.vsvmvl(i64 %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddsl.vsvmvl(i64, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddsl_vsvmvl_imm(<256 x double> %0, <256 x i1> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddsl_vsvmvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.l %v1, 8, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddsl.vsvmvl(i64 8, <256 x double> %0, <256 x i1> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddsl_vsvvl(i64 %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddsl_vsvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.l %v1, %s0, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddsl.vsvvl(i64 %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddsl.vsvvl(i64, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddsl_vsvvl_imm(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddsl_vsvvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.l %v1, 8, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddsl.vsvvl(i64 8, <256 x double> %0, <256 x double> %1, i32 128)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddsl_vvvl(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddsl_vvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.l %v0, %v0, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddsl.vvvl(<256 x double> %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddsl.vvvl(<256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddsl_vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vaddsl_vvvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.l %v2, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vaddsl.vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddsl.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddsl_vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddsl_vvvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.l %v2, %v0, %v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddsl.vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddsl.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswsx_vsvl(i32 signext %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddswsx_vsvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.w.sx %v0, %s0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddswsx.vsvl(i32 %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswsx.vsvl(i32, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswsx_vsvl_imm(<256 x double> %0) {
; CHECK-LABEL: __regcall3__vaddswsx_vsvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.sx %v0, 8, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call fast <256 x double> @llvm.ve.vl.vaddswsx.vsvl(i32 8, <256 x double> %0, i32 256)
  ret <256 x double> %2
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswsx_vsvmvl(i32 signext %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vaddswsx_vsvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.w.sx %v1, %s0, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vaddswsx.vsvmvl(i32 %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswsx.vsvmvl(i32, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswsx_vsvmvl_imm(<256 x double> %0, <256 x i1> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddswsx_vsvmvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.sx %v1, 8, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddswsx.vsvmvl(i32 8, <256 x double> %0, <256 x i1> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswsx_vsvvl(i32 signext %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddswsx_vsvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.w.sx %v1, %s0, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddswsx.vsvvl(i32 %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswsx.vsvvl(i32, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswsx_vsvvl_imm(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddswsx_vsvvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.sx %v1, 8, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddswsx.vsvvl(i32 8, <256 x double> %0, <256 x double> %1, i32 128)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswsx_vvvl(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddswsx_vvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.sx %v0, %v0, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddswsx.vvvl(<256 x double> %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswsx.vvvl(<256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswsx_vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vaddswsx_vvvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.sx %v2, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vaddswsx.vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswsx.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswsx_vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddswsx_vvvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.sx %v2, %v0, %v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddswsx.vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswsx.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswzx_vsvl(i32 signext %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddswzx_vsvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.w.zx %v0, %s0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddswzx.vsvl(i32 %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswzx.vsvl(i32, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswzx_vsvl_imm(<256 x double> %0) {
; CHECK-LABEL: __regcall3__vaddswzx_vsvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.zx %v0, 8, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call fast <256 x double> @llvm.ve.vl.vaddswzx.vsvl(i32 8, <256 x double> %0, i32 256)
  ret <256 x double> %2
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswzx_vsvmvl(i32 signext %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vaddswzx_vsvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.w.zx %v1, %s0, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vaddswzx.vsvmvl(i32 %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswzx.vsvmvl(i32, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswzx_vsvmvl_imm(<256 x double> %0, <256 x i1> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddswzx_vsvmvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.zx %v1, 8, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddswzx.vsvmvl(i32 8, <256 x double> %0, <256 x i1> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswzx_vsvvl(i32 signext %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddswzx_vsvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vadds.w.zx %v1, %s0, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddswzx.vsvvl(i32 %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswzx.vsvvl(i32, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswzx_vsvvl_imm(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddswzx_vsvvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.zx %v1, 8, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddswzx.vsvvl(i32 8, <256 x double> %0, <256 x double> %1, i32 128)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswzx_vvvl(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddswzx_vvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.zx %v0, %v0, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddswzx.vvvl(<256 x double> %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswzx.vvvl(<256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswzx_vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vaddswzx_vvvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.zx %v2, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vaddswzx.vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswzx.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddswzx_vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddswzx_vvvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vadds.w.zx %v2, %v0, %v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddswzx.vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddswzx.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddul_vsvl(i64 %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddul_vsvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vaddu.l %v0, %s0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddul.vsvl(i64 %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddul.vsvl(i64, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddul_vsvl_imm(<256 x double> %0) {
; CHECK-LABEL: __regcall3__vaddul_vsvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.l %v0, 8, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call fast <256 x double> @llvm.ve.vl.vaddul.vsvl(i64 8, <256 x double> %0, i32 256)
  ret <256 x double> %2
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddul_vsvmvl(i64 %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vaddul_vsvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vaddu.l %v1, %s0, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vaddul.vsvmvl(i64 %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddul.vsvmvl(i64, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddul_vsvmvl_imm(<256 x double> %0, <256 x i1> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddul_vsvmvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.l %v1, 8, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddul.vsvmvl(i64 8, <256 x double> %0, <256 x i1> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddul_vsvvl(i64 %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddul_vsvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vaddu.l %v1, %s0, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddul.vsvvl(i64 %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddul.vsvvl(i64, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddul_vsvvl_imm(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddul_vsvvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.l %v1, 8, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddul.vsvvl(i64 8, <256 x double> %0, <256 x double> %1, i32 128)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddul_vvvl(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vaddul_vvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.l %v0, %v0, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vaddul.vvvl(<256 x double> %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddul.vvvl(<256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddul_vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vaddul_vvvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.l %v2, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vaddul.vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddul.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vaddul_vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vaddul_vvvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.l %v2, %v0, %v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vaddul.vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vaddul.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vadduw_vsvl(i32 signext %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vadduw_vsvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vaddu.w %v0, %s0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vadduw.vsvl(i32 %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vadduw.vsvl(i32, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vadduw_vsvl_imm(<256 x double> %0) {
; CHECK-LABEL: __regcall3__vadduw_vsvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.w %v0, 8, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = tail call fast <256 x double> @llvm.ve.vl.vadduw.vsvl(i32 8, <256 x double> %0, i32 256)
  ret <256 x double> %2
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vadduw_vsvmvl(i32 signext %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vadduw_vsvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vaddu.w %v1, %s0, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vadduw.vsvmvl(i32 %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vadduw.vsvmvl(i32, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vadduw_vsvmvl_imm(<256 x double> %0, <256 x i1> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vadduw_vsvmvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.w %v1, 8, %v0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vadduw.vsvmvl(i32 8, <256 x double> %0, <256 x i1> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vadduw_vsvvl(i32 signext %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vadduw_vsvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vaddu.w %v1, %s0, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vadduw.vsvvl(i32 %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vadduw.vsvvl(i32, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vadduw_vsvvl_imm(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vadduw_vsvvl_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.w %v1, 8, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vadduw.vsvvl(i32 8, <256 x double> %0, <256 x double> %1, i32 128)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vadduw_vvvl(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__vadduw_vvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.w %v0, %v0, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.vadduw.vvvl(<256 x double> %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vadduw.vvvl(<256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vadduw_vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__vadduw_vvvmvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.w %v2, %v0, %v1, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.vadduw.vvvmvl(<256 x double> %0, <256 x double> %1, <256 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vadduw.vvvmvl(<256 x double>, <256 x double>, <256 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__vadduw_vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__vadduw_vvvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vaddu.w %v2, %v0, %v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.vadduw.vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.vadduw.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvaddu_vvvl(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__pvaddu_vvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvaddu %v0, %v0, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.pvaddu.vvvl(<256 x double> %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvaddu.vvvl(<256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvaddu_vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__pvaddu_vvvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvaddu %v2, %v0, %v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.pvaddu.vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvaddu.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvaddu_vsvl(i64 %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__pvaddu_vsvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvaddu %v0, %s0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.pvaddu.vsvl(i64 %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvaddu.vsvl(i64, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvaddu_vsvvl(i64 %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__pvaddu_vsvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvaddu %v1, %s0, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.pvaddu.vsvvl(i64 %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvaddu.vsvvl(i64, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvaddu_vvvMvl(<256 x double> %0, <256 x double> %1, <512 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__pvaddu_vvvMvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $vm2 killed $vm2 killed $vmp1 def $vmp1
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    # kill: def $vm3 killed $vm3 killed $vmp1 def $vmp1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvaddu %v2, %v0, %v1, %vm2
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.pvaddu.vvvMvl(<256 x double> %0, <256 x double> %1, <512 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvaddu.vvvMvl(<256 x double>, <256 x double>, <512 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvaddu_vsvMvl(i64 %0, <256 x double> %1, <512 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__pvaddu_vsvMvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $vm2 killed $vm2 killed $vmp1 def $vmp1
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    # kill: def $vm3 killed $vm3 killed $vmp1 def $vmp1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvaddu %v1, %s0, %v0, %vm2
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.pvaddu.vsvMvl(i64 %0, <256 x double> %1, <512 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvaddu.vsvMvl(i64, <256 x double>, <512 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvadds_vvvl(<256 x double> %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__pvadds_vvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvadds %v0, %v0, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.pvadds.vvvl(<256 x double> %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvadds.vvvl(<256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvadds_vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__pvadds_vvvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvadds %v2, %v0, %v1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.pvadds.vvvvl(<256 x double> %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvadds.vvvvl(<256 x double>, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvadds_vsvl(i64 %0, <256 x double> %1) {
; CHECK-LABEL: __regcall3__pvadds_vsvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvadds %v0, %s0, %v0
; CHECK-NEXT:    b.l.t (, %s10)
  %3 = tail call fast <256 x double> @llvm.ve.vl.pvadds.vsvl(i64 %0, <256 x double> %1, i32 256)
  ret <256 x double> %3
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvadds.vsvl(i64, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvadds_vsvvl(i64 %0, <256 x double> %1, <256 x double> %2) {
; CHECK-LABEL: __regcall3__pvadds_vsvvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvadds %v1, %s0, %v0
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %4 = tail call fast <256 x double> @llvm.ve.vl.pvadds.vsvvl(i64 %0, <256 x double> %1, <256 x double> %2, i32 128)
  ret <256 x double> %4
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvadds.vsvvl(i64, <256 x double>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvadds_vvvMvl(<256 x double> %0, <256 x double> %1, <512 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__pvadds_vvvMvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $vm2 killed $vm2 killed $vmp1 def $vmp1
; CHECK-NEXT:    lea %s0, 128
; CHECK-NEXT:    # kill: def $vm3 killed $vm3 killed $vmp1 def $vmp1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    pvadds %v2, %v0, %v1, %vm2
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v2
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.pvadds.vvvMvl(<256 x double> %0, <256 x double> %1, <512 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvadds.vvvMvl(<256 x double>, <256 x double>, <512 x i1>, <256 x double>, i32)

; Function Attrs: nounwind readnone
define x86_regcallcc <256 x double> @__regcall3__pvadds_vsvMvl(i64 %0, <256 x double> %1, <512 x i1> %2, <256 x double> %3) {
; CHECK-LABEL: __regcall3__pvadds_vsvMvl:
; CHECK:       # %bb.0:
; CHECK-NEXT:    # kill: def $vm2 killed $vm2 killed $vmp1 def $vmp1
; CHECK-NEXT:    lea %s1, 128
; CHECK-NEXT:    # kill: def $vm3 killed $vm3 killed $vmp1 def $vmp1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    pvadds %v1, %s0, %v0, %vm2
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v0, (0)1, %v1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = tail call fast <256 x double> @llvm.ve.vl.pvadds.vsvMvl(i64 %0, <256 x double> %1, <512 x i1> %2, <256 x double> %3, i32 128)
  ret <256 x double> %5
}

; Function Attrs: nounwind readnone
declare <256 x double> @llvm.ve.vl.pvadds.vsvMvl(i64, <256 x double>, <512 x i1>, <256 x double>, i32)
