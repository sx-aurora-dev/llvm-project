; RUN: llc < %s -mtriple=ve -mattr=+intrin | FileCheck %s

@v256i1 = common dso_local local_unnamed_addr global <256 x i1> zeroinitializer, align 4
@v512i1 = common dso_local local_unnamed_addr global <512 x i1> zeroinitializer, align 4

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i1> @loadv256i1(<256 x i1>* nocapture readonly) {
; CHECK-LABEL: loadv256i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    ld %s1, (, %s0)
; CHECK-NEXT:    ld %s2, 8(, %s0)
; CHECK-NEXT:    ld %s3, 16(, %s0)
; CHECK-NEXT:    ld %s0, 24(, %s0)
; CHECK-NEXT:    lvm %vm1, 0, %s1
; CHECK-NEXT:    lvm %vm1, 1, %s2
; CHECK-NEXT:    lvm %vm1, 2, %s3
; CHECK-NEXT:    lvm %vm1, 3, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <256 x i1>, <256 x i1>* %0, align 16
  ret <256 x i1> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i1> @loadv256i1stk() {
; CHECK-LABEL: loadv256i1stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    ld %s16, (, %s11)
; CHECK-NEXT:    lvm %vm1, 0, %s16
; CHECK-NEXT:    ld %s16, 8(, %s11)
; CHECK-NEXT:    lvm %vm1, 1, %s16
; CHECK-NEXT:    ld %s16, 16(, %s11)
; CHECK-NEXT:    lvm %vm1, 2, %s16
; CHECK-NEXT:    ld %s16, 24(, %s11)
; CHECK-NEXT:    lvm %vm1, 3, %s16
; CHECK-NEXT:    adds.l %s11, 32, %s11
; CHECK-NEXT:    b.l.t (, %s10)
  %addr = alloca <256 x i1>, align 16
  %1 = load <256 x i1>, <256 x i1>* %addr, align 16
  ret <256 x i1> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i1> @loadv256i1com() {
; CHECK-LABEL: loadv256i1com:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, v256i1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, v256i1@hi(, %s0)
; CHECK-NEXT:    ld %s1, (, %s0)
; CHECK-NEXT:    ld %s2, 8(, %s0)
; CHECK-NEXT:    ld %s3, 16(, %s0)
; CHECK-NEXT:    ld %s0, 24(, %s0)
; CHECK-NEXT:    lvm %vm1, 0, %s1
; CHECK-NEXT:    lvm %vm1, 1, %s2
; CHECK-NEXT:    lvm %vm1, 2, %s3
; CHECK-NEXT:    lvm %vm1, 3, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load <256 x i1>, <256 x i1>* @v256i1, align 16
  ret <256 x i1> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i1> @loadv512i1(<512 x i1>* nocapture readonly) {
; CHECK-LABEL: loadv512i1:
; CHECK:       # %bb.0:
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
; CHECK-NEXT:    b.l.t (, %s10)
  %2 = load <512 x i1>, <512 x i1>* %0, align 16
  ret <512 x i1> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i1> @loadv512i1stk() {
; CHECK-LABEL: loadv512i1stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    # implicit-def: $vmp1
; CHECK-NEXT:    ld %s16, (, %s11)
; CHECK-NEXT:    lvm %vm3, 0, %s16
; CHECK-NEXT:    ld %s16, 8(, %s11)
; CHECK-NEXT:    lvm %vm3, 1, %s16
; CHECK-NEXT:    ld %s16, 16(, %s11)
; CHECK-NEXT:    lvm %vm3, 2, %s16
; CHECK-NEXT:    ld %s16, 24(, %s11)
; CHECK-NEXT:    lvm %vm3, 3, %s16
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    lvm %vm2, 0, %s16
; CHECK-NEXT:    ld %s16, 40(, %s11)
; CHECK-NEXT:    lvm %vm2, 1, %s16
; CHECK-NEXT:    ld %s16, 48(, %s11)
; CHECK-NEXT:    lvm %vm2, 2, %s16
; CHECK-NEXT:    ld %s16, 56(, %s11)
; CHECK-NEXT:    lvm %vm2, 3, %s16
; CHECK-NEXT:    lea %s11, 64(, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %addr = alloca <512 x i1>, align 16
  %1 = load <512 x i1>, <512 x i1>* %addr, align 16
  ret <512 x i1> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i1> @loadv512i1com() {
; CHECK-LABEL: loadv512i1com:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, v512i1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, v512i1@hi(, %s0)
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
; CHECK-NEXT:    b.l.t (, %s10)
  %1 = load <512 x i1>, <512 x i1>* @v512i1, align 16
  ret <512 x i1> %1
}
