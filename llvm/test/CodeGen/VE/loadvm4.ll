; RUN: llc < %s -mtriple=ve | FileCheck %s

@v4i64 = common dso_local local_unnamed_addr global <4 x i64> zeroinitializer, align 4
@v8i64 = common dso_local local_unnamed_addr global <8 x i64> zeroinitializer, align 4

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x i64> @loadv4i64(<4 x i64>* nocapture readonly) {
; CHECK-LABEL: loadv4i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s1, (, %s0)
; CHECK-NEXT:    ld %s2, 8(, %s0)
; CHECK-NEXT:    ld %s3, 16(, %s0)
; CHECK-NEXT:    ld %s0, 24(, %s0)
; CHECK-NEXT:    lvm %vm1, 0, %s1
; CHECK-NEXT:    lvm %vm1, 1, %s2
; CHECK-NEXT:    lvm %vm1, 2, %s3
; CHECK-NEXT:    lvm %vm1, 3, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = load <4 x i64>, <4 x i64>* %0, align 16
  ret <4 x i64> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x i64> @loadv4i64stk() {
; CHECK-LABEL: loadv4i64stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s16, 176(, %s11)
; CHECK-NEXT:    lvm %vm1, 0, %s16
; CHECK-NEXT:    ld %s16, 184(, %s11)
; CHECK-NEXT:    lvm %vm1, 1, %s16
; CHECK-NEXT:    ld %s16, 192(, %s11)
; CHECK-NEXT:    lvm %vm1, 2, %s16
; CHECK-NEXT:    ld %s16, 200(, %s11)
; CHECK-NEXT:    lvm %vm1, 3, %s16
; CHECK-NEXT:    or %s11, 0, %s9
  %addr = alloca <4 x i64>, align 16
  %1 = load <4 x i64>, <4 x i64>* %addr, align 16
  ret <4 x i64> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <4 x i64> @loadv4i64com() {
; CHECK-LABEL: loadv4i64com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, v4i64@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, v4i64@hi(, %s0)
; CHECK-NEXT:    ld %s1, (, %s0)
; CHECK-NEXT:    ld %s2, 8(, %s0)
; CHECK-NEXT:    ld %s3, 16(, %s0)
; CHECK-NEXT:    ld %s0, 24(, %s0)
; CHECK-NEXT:    lvm %vm1, 0, %s1
; CHECK-NEXT:    lvm %vm1, 1, %s2
; CHECK-NEXT:    lvm %vm1, 2, %s3
; CHECK-NEXT:    lvm %vm1, 3, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = load <4 x i64>, <4 x i64>* @v4i64, align 16
  ret <4 x i64> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x i64> @loadv8i64(<8 x i64>* nocapture readonly) {
; CHECK-LABEL: loadv8i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s1, (, %s0)
; CHECK-NEXT:    ld %s2, 8(, %s0)
; CHECK-NEXT:    ld %s3, 16(, %s0)
; CHECK-NEXT:    ld %s4, 24(, %s0)
; CHECK-NEXT:    lvm %vm3, 0, %s1
; CHECK-NEXT:    lvm %vm3, 1, %s2
; CHECK-NEXT:    lvm %vm3, 2, %s3
; CHECK-NEXT:    lvm %vm3, 3, %s4
; CHECK-NEXT:    ld %s1, 32(, %s0)
; CHECK-NEXT:    ld %s2, 40(, %s0)
; CHECK-NEXT:    ld %s3, 48(, %s0)
; CHECK-NEXT:    ld %s0, 56(, %s0)
; CHECK-NEXT:    lvm %vm2, 0, %s1
; CHECK-NEXT:    lvm %vm2, 1, %s2
; CHECK-NEXT:    lvm %vm2, 2, %s3
; CHECK-NEXT:    lvm %vm2, 3, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %2 = load <8 x i64>, <8 x i64>* %0, align 16
  ret <8 x i64> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x i64> @loadv8i64stk() {
; CHECK-LABEL: loadv8i64stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # implicit-def: $vmp1
; CHECK-NEXT:    ld %s16, 176(, %s11)
; CHECK-NEXT:    lvm %vm3, 0, %s16
; CHECK-NEXT:    ld %s16, 184(, %s11)
; CHECK-NEXT:    lvm %vm3, 1, %s16
; CHECK-NEXT:    ld %s16, 192(, %s11)
; CHECK-NEXT:    lvm %vm3, 2, %s16
; CHECK-NEXT:    ld %s16, 200(, %s11)
; CHECK-NEXT:    lvm %vm3, 3, %s16
; CHECK-NEXT:    ld %s16, 208(, %s11)
; CHECK-NEXT:    lvm %vm2, 0, %s16
; CHECK-NEXT:    ld %s16, 216(, %s11)
; CHECK-NEXT:    lvm %vm2, 1, %s16
; CHECK-NEXT:    ld %s16, 224(, %s11)
; CHECK-NEXT:    lvm %vm2, 2, %s16
; CHECK-NEXT:    ld %s16, 232(, %s11)
; CHECK-NEXT:    lvm %vm2, 3, %s16
; CHECK-NEXT:    or %s11, 0, %s9
  %addr = alloca <8 x i64>, align 16
  %1 = load <8 x i64>, <8 x i64>* %addr, align 16
  ret <8 x i64> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <8 x i64> @loadv8i64com() {
; CHECK-LABEL: loadv8i64com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    lea %s0, v8i64@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, v8i64@hi(, %s0)
; CHECK-NEXT:    ld %s1, (, %s0)
; CHECK-NEXT:    ld %s2, 8(, %s0)
; CHECK-NEXT:    ld %s3, 16(, %s0)
; CHECK-NEXT:    ld %s4, 24(, %s0)
; CHECK-NEXT:    lvm %vm3, 0, %s1
; CHECK-NEXT:    lvm %vm3, 1, %s2
; CHECK-NEXT:    lvm %vm3, 2, %s3
; CHECK-NEXT:    lvm %vm3, 3, %s4
; CHECK-NEXT:    ld %s1, 32(, %s0)
; CHECK-NEXT:    ld %s2, 40(, %s0)
; CHECK-NEXT:    ld %s3, 48(, %s0)
; CHECK-NEXT:    ld %s0, 56(, %s0)
; CHECK-NEXT:    lvm %vm2, 0, %s1
; CHECK-NEXT:    lvm %vm2, 1, %s2
; CHECK-NEXT:    lvm %vm2, 2, %s3
; CHECK-NEXT:    lvm %vm2, 3, %s0
; CHECK-NEXT:    or %s11, 0, %s9
  %1 = load <8 x i64>, <8 x i64>* @v8i64, align 16
  ret <8 x i64> %1
}

