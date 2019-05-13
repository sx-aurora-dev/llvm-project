; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@vi8 = common dso_local local_unnamed_addr global i8 0, align 1
@vi16 = common dso_local local_unnamed_addr global i16 0, align 2
@vi32 = common dso_local local_unnamed_addr global i32 0, align 4
@vi64 = common dso_local local_unnamed_addr global i64 0, align 8
@vi128 = common dso_local local_unnamed_addr global i128 0, align 16
@vf32 = common dso_local local_unnamed_addr global float 0.000000e+00, align 4
@vf64 = common dso_local local_unnamed_addr global double 0.000000e+00, align 8
@vf128 = common dso_local local_unnamed_addr global fp128 0xL00000000000000000000000000000000, align 16

; Function Attrs: norecurse nounwind readonly
define fp128 @loadf128(fp128* nocapture readonly) {
; CHECK-LABEL: loadf128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld %s34, 8(,%s0)
; CHECK-NEXT:  ld %s35, (,%s0)
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s1, 0, %s35
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load fp128, fp128* %0, align 16
  ret fp128 %2
}

; Function Attrs: norecurse nounwind readonly
define double @loadf64(double* nocapture readonly) {
; CHECK-LABEL: loadf64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld %s0, (,%s0)
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load double, double* %0, align 16
  ret double %2
}

; Function Attrs: norecurse nounwind readonly
define float @loadf32(float* nocapture readonly) {
; CHECK-LABEL: loadf32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ldu %s0, (,%s0)
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load float, float* %0, align 16
  ret float %2
}

; Function Attrs: norecurse nounwind readonly
define i128 @loadi128(i128* nocapture readonly) {
; CHECK-LABEL: loadi128:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld %s34, (,%s0)
; CHECK-NEXT:  ld %s1, 8(,%s0)
; CHECK-NEXT:  or %s0, 0, %s34
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load i128, i128* %0, align 16
  ret i128 %2
}

; Function Attrs: norecurse nounwind readonly
define i64 @loadi64(i64* nocapture readonly) {
; CHECK-LABEL: loadi64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld %s0, (,%s0)
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load i64, i64* %0, align 16
  ret i64 %2
}

; Function Attrs: norecurse nounwind readonly
define i32 @loadi32(i32* nocapture readonly) {
; CHECK-LABEL: loadi32:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ldl.sx %s0, (,%s0)
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load i32, i32* %0, align 16
  ret i32 %2
}

; Function Attrs: norecurse nounwind readonly
define i16 @loadi16(i16* nocapture readonly) {
; CHECK-LABEL: loadi16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld2b.zx %s0, (,%s0)
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load i16, i16* %0, align 16
  ret i16 %2
}

; Function Attrs: norecurse nounwind readonly
define i8 @loadi8(i8* nocapture readonly) {
; CHECK-LABEL: loadi8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld1b.zx %s0, (,%s0)
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load i8, i8* %0, align 16
  ret i8 %2
}

; Function Attrs: norecurse nounwind readonly
define fp128 @loadf128stk() {
; CHECK-LABEL: loadf128stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld %s1, {{[0-9]+}}(,%s11)
; CHECK-NEXT:  ld %s0, {{[0-9]+}}(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca fp128, align 16
  %1 = load fp128, fp128* %addr, align 16
  ret fp128 %1
}

; Function Attrs: norecurse nounwind readonly
define double @loadf64stk() {
; CHECK-LABEL: loadf64stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld %s0, {{[0-9]+}}(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca double, align 16
  %1 = load double, double* %addr, align 16
  ret double %1
}

; Function Attrs: norecurse nounwind readonly
define float @loadf32stk() {
; CHECK-LABEL: loadf32stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ldu %s0, {{[0-9]+}}(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca float, align 16
  %1 = load float, float* %addr, align 16
  ret float %1
}

; Function Attrs: norecurse nounwind readonly
define i128 @loadi128stk() {
; CHECK-LABEL: loadi128stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34,{{[0-9]+}}(,%s11)
; CHECK-NEXT:  or %s34, 8, %s34
; CHECK-NEXT:  ld %s1, (,%s34)
; CHECK-NEXT:  ld %s0, {{[0-9]+}}(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca i128, align 16
  %1 = load i128, i128* %addr, align 16
  ret i128 %1
}

; Function Attrs: norecurse nounwind readonly
define i64 @loadi64stk() {
; CHECK-LABEL: loadi64stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld %s0, {{[0-9]+}}(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca i64, align 16
  %1 = load i64, i64* %addr, align 16
  ret i64 %1
}

; Function Attrs: norecurse nounwind readonly
define i32 @loadi32stk() {
; CHECK-LABEL: loadi32stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ldl.sx %s0, {{[0-9]+}}(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca i32, align 16
  %1 = load i32, i32* %addr, align 16
  ret i32 %1
}

; Function Attrs: norecurse nounwind readonly
define i16 @loadi16stk() {
; CHECK-LABEL: loadi16stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld2b.zx %s0, {{[0-9]+}}(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca i16, align 16
  %1 = load i16, i16* %addr, align 16
  ret i16 %1
}

; Function Attrs: norecurse nounwind readonly
define i8 @loadi8stk() {
; CHECK-LABEL: loadi8stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld1b.zx %s0, {{[0-9]+}}(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca i8, align 16
  %1 = load i8, i8* %addr, align 16
  ret i8 %1
}

; Function Attrs: norecurse nounwind readonly
define fp128 @loadf128com() {
; CHECK-LABEL: loadf128com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, vf128@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, vf128@hi(%s34)
; CHECK-NEXT:  ld %s0, 8(,%s34)
; CHECK-NEXT:  ld %s1, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load fp128, fp128* @vf128, align 16
  ret fp128 %1
}

; Function Attrs: norecurse nounwind readonly
define double @loadf64com() {
; CHECK-LABEL: loadf64com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, vf64@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, vf64@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load double, double* @vf64, align 8
  ret double %1
}

; Function Attrs: norecurse nounwind readonly
define float @loadf32com() {
; CHECK-LABEL: loadf32com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, vf32@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, vf32@hi(%s34)
; CHECK-NEXT:  ldu %s0, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load float, float* @vf32, align 4
  ret float %1
}

; Function Attrs: norecurse nounwind readonly
define i128 @loadi128com() {
; CHECK-LABEL: loadi128com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, vi128@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, vi128@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  ld %s1, 8(,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load i128, i128* @vi128, align 16
  ret i128 %1
}

; Function Attrs: norecurse nounwind readonly
define i64 @loadi64com() {
; CHECK-LABEL: loadi64com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, vi64@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, vi64@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load i64, i64* @vi64, align 8
  ret i64 %1
}

; Function Attrs: norecurse nounwind readonly
define i32 @loadi32com() {
; CHECK-LABEL: loadi32com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, vi32@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, vi32@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load i32, i32* @vi32, align 4
  ret i32 %1
}

; Function Attrs: norecurse nounwind readonly
define i16 @loadi16com() {
; CHECK-LABEL: loadi16com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, vi16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, vi16@hi(%s34)
; CHECK-NEXT:  ld2b.zx %s0, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load i16, i16* @vi16, align 2
  ret i16 %1
}

; Function Attrs: norecurse nounwind readonly
define i8 @loadi8com() {
; CHECK-LABEL: loadi8com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, vi8@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, vi8@hi(%s34)
; CHECK-NEXT:  ld1b.zx %s0, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load i8, i8* @vi8, align 1
  ret i8 %1
}

