; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@v256i1 = common dso_local local_unnamed_addr global <256 x i1> zeroinitializer, align 4
@v512i1 = common dso_local local_unnamed_addr global <512 x i1> zeroinitializer, align 4

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i1> @loadv256i1(<256 x i1>* nocapture readonly) {
; CHECK-LABEL: loadv256i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld %s34, (,%s0)
; CHECK-NEXT:  ld %s35, 8(,%s0)
; CHECK-NEXT:  ld %s36, 16(,%s0)
; CHECK-NEXT:  ld %s37, 24(,%s0)
; CHECK-NEXT:  lvm %vm1,0,%s34
; CHECK-NEXT:  lvm %vm1,1,%s35
; CHECK-NEXT:  lvm %vm1,2,%s36
; CHECK-NEXT:  lvm %vm1,3,%s37
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load <256 x i1>, <256 x i1>* %0, align 16
  ret <256 x i1> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i1> @loadv256i1stk() {
; CHECK-LABEL: loadv256i1stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34,176(,%s11)
; CHECK-NEXT:  ld %s35, (,%s34)
; CHECK-NEXT:  ld %s36, 8(,%s34)
; CHECK-NEXT:  ld %s37, 16(,%s34)
; CHECK-NEXT:  ld %s34, 24(,%s34)
; CHECK-NEXT:  lvm %vm1,0,%s35
; CHECK-NEXT:  lvm %vm1,1,%s36
; CHECK-NEXT:  lvm %vm1,2,%s37
; CHECK-NEXT:  lvm %vm1,3,%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca <256 x i1>, align 16
  %1 = load <256 x i1>, <256 x i1>* %addr, align 16
  ret <256 x i1> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <256 x i1> @loadv256i1com() {
; CHECK-LABEL: loadv256i1com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, v256i1@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, v256i1@hi(%s34)
; CHECK-NEXT:  ld %s35, (,%s34)
; CHECK-NEXT:  ld %s36, 8(,%s34)
; CHECK-NEXT:  ld %s37, 16(,%s34)
; CHECK-NEXT:  ld %s34, 24(,%s34)
; CHECK-NEXT:  lvm %vm1,0,%s35
; CHECK-NEXT:  lvm %vm1,1,%s36
; CHECK-NEXT:  lvm %vm1,2,%s37
; CHECK-NEXT:  lvm %vm1,3,%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load <256 x i1>, <256 x i1>* @v256i1, align 16
  ret <256 x i1> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i1> @loadv512i1(<512 x i1>* nocapture readonly) {
; CHECK-LABEL: loadv512i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  ld %s34, (,%s0)
; CHECK-NEXT:  ld %s35, 8(,%s0)
; CHECK-NEXT:  ld %s36, 16(,%s0)
; CHECK-NEXT:  ld %s37, 24(,%s0)
; CHECK-NEXT:  lvm %vm3,0,%s34
; CHECK-NEXT:  lvm %vm3,1,%s35
; CHECK-NEXT:  lvm %vm3,2,%s36
; CHECK-NEXT:  lvm %vm3,3,%s37
; CHECK-NEXT:  ld %s34, 32(,%s0)
; CHECK-NEXT:  ld %s35, 40(,%s0)
; CHECK-NEXT:  ld %s36, 48(,%s0)
; CHECK-NEXT:  ld %s37, 56(,%s0)
; CHECK-NEXT:  lvm %vm2,0,%s34
; CHECK-NEXT:  lvm %vm2,1,%s35
; CHECK-NEXT:  lvm %vm2,2,%s36
; CHECK-NEXT:  lvm %vm2,3,%s37
; CHECK-NEXT:  or %s11, 0, %s9
  %2 = load <512 x i1>, <512 x i1>* %0, align 16
  ret <512 x i1> %2
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i1> @loadv512i1stk() {
; CHECK-LABEL: loadv512i1stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34,176(,%s11)
; CHECK-NEXT:  ld %s35, (,%s34)
; CHECK-NEXT:  ld %s36, 8(,%s34)
; CHECK-NEXT:  ld %s37, 16(,%s34)
; CHECK-NEXT:  ld %s38, 24(,%s34)
; CHECK-NEXT:  lvm %vm3,0,%s35
; CHECK-NEXT:  lvm %vm3,1,%s36
; CHECK-NEXT:  lvm %vm3,2,%s37
; CHECK-NEXT:  lvm %vm3,3,%s38
; CHECK-NEXT:  ld %s35, 32(,%s34)
; CHECK-NEXT:  ld %s36, 40(,%s34)
; CHECK-NEXT:  ld %s37, 48(,%s34)
; CHECK-NEXT:  ld %s34, 56(,%s34)
; CHECK-NEXT:  lvm %vm2,0,%s35
; CHECK-NEXT:  lvm %vm2,1,%s36
; CHECK-NEXT:  lvm %vm2,2,%s37
; CHECK-NEXT:  lvm %vm2,3,%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca <512 x i1>, align 16
  %1 = load <512 x i1>, <512 x i1>* %addr, align 16
  ret <512 x i1> %1
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc <512 x i1> @loadv512i1com() {
; CHECK-LABEL: loadv512i1com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, v512i1@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, v512i1@hi(%s34)
; CHECK-NEXT:  ld %s35, (,%s34)
; CHECK-NEXT:  ld %s36, 8(,%s34)
; CHECK-NEXT:  ld %s37, 16(,%s34)
; CHECK-NEXT:  ld %s38, 24(,%s34)
; CHECK-NEXT:  lvm %vm3,0,%s35
; CHECK-NEXT:  lvm %vm3,1,%s36
; CHECK-NEXT:  lvm %vm3,2,%s37
; CHECK-NEXT:  lvm %vm3,3,%s38
; CHECK-NEXT:  ld %s35, 32(,%s34)
; CHECK-NEXT:  ld %s36, 40(,%s34)
; CHECK-NEXT:  ld %s37, 48(,%s34)
; CHECK-NEXT:  ld %s34, 56(,%s34)
; CHECK-NEXT:  lvm %vm2,0,%s35
; CHECK-NEXT:  lvm %vm2,1,%s36
; CHECK-NEXT:  lvm %vm2,2,%s37
; CHECK-NEXT:  lvm %vm2,3,%s34
; CHECK-NEXT:  or %s11, 0, %s9
  %1 = load <512 x i1>, <512 x i1>* @v512i1, align 16
  ret <512 x i1> %1
}

