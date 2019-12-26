; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@v256i1 = common dso_local local_unnamed_addr global <256 x i1> zeroinitializer, align 4
@v512i1 = common dso_local local_unnamed_addr global <512 x i1> zeroinitializer, align 4

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev256i1(<256 x i1>* nocapture, <256 x i1>) {
; CHECK-LABEL: storev256i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svm %s34,%vm1,3
; CHECK-NEXT:  st %s34, 24(,%s0)
; CHECK-NEXT:  svm %s34,%vm1,2
; CHECK-NEXT:  st %s34, 16(,%s0)
; CHECK-NEXT:  svm %s34,%vm1,1
; CHECK-NEXT:  st %s34, 8(,%s0)
; CHECK-NEXT:  svm %s34,%vm1,0
; CHECK-NEXT:  st %s34, (,%s0)
; CHECK-NEXT:  or %s11, 0, %s9
  store <256 x i1> %1, <256 x i1>* %0, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev256i1stk(<256 x i1>) {
; CHECK-LABEL: storev256i1stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svm %s16,%vm1,0
; CHECK-NEXT:  st %s16, 176(,%s11)
; CHECK-NEXT:  svm %s16,%vm1,1
; CHECK-NEXT:  st %s16, 184(,%s11)
; CHECK-NEXT:  svm %s16,%vm1,2
; CHECK-NEXT:  st %s16, 192(,%s11)
; CHECK-NEXT:  svm %s16,%vm1,3
; CHECK-NEXT:  st %s16, 200(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca <256 x i1>, align 16
  store <256 x i1> %0, <256 x i1>* %addr, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev256i1com(<256 x i1>) {
; CHECK-LABEL: storev256i1com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svm %s34,%vm1,3
; CHECK-NEXT:  lea %s35, v256i1@lo
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s35, v256i1@hi(%s35)
; CHECK-NEXT:  st %s34, 24(,%s35)
; CHECK-NEXT:  svm %s34,%vm1,2
; CHECK-NEXT:  st %s34, 16(,%s35)
; CHECK-NEXT:  svm %s34,%vm1,1
; CHECK-NEXT:  st %s34, 8(,%s35)
; CHECK-NEXT:  svm %s34,%vm1,0
; CHECK-NEXT:  st %s34, (,%s35)
; CHECK-NEXT:  or %s11, 0, %s9
  store <256 x i1> %0, <256 x i1>* @v256i1, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev512i1(<512 x i1>* nocapture, <512 x i1>) {
; CHECK-LABEL: storev512i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svm %s34,%vm2,3
; CHECK-NEXT:  st %s34, 56(,%s0)
; CHECK-NEXT:  svm %s34,%vm2,2
; CHECK-NEXT:  st %s34, 48(,%s0)
; CHECK-NEXT:  svm %s34,%vm2,1
; CHECK-NEXT:  st %s34, 40(,%s0)
; CHECK-NEXT:  svm %s34,%vm2,0
; CHECK-NEXT:  st %s34, 32(,%s0)
; CHECK-NEXT:  svm %s34,%vm3,3
; CHECK-NEXT:  st %s34, 24(,%s0)
; CHECK-NEXT:  svm %s34,%vm3,2
; CHECK-NEXT:  st %s34, 16(,%s0)
; CHECK-NEXT:  svm %s34,%vm3,1
; CHECK-NEXT:  st %s34, 8(,%s0)
; CHECK-NEXT:  svm %s34,%vm3,0
; CHECK-NEXT:  st %s34, (,%s0)
; CHECK-NEXT:  or %s11, 0, %s9
  store <512 x i1> %1, <512 x i1>* %0, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev512i1stk(<512 x i1>) {
; CHECK-LABEL: storev512i1stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svm %s16,%vm3,0
; CHECK-NEXT:  st %s16, 176(,%s11)
; CHECK-NEXT:  svm %s16,%vm3,1
; CHECK-NEXT:  st %s16, 184(,%s11)
; CHECK-NEXT:  svm %s16,%vm3,2
; CHECK-NEXT:  st %s16, 192(,%s11)
; CHECK-NEXT:  svm %s16,%vm3,3
; CHECK-NEXT:  st %s16, 200(,%s11)
; CHECK-NEXT:  svm %s16,%vm2,0
; CHECK-NEXT:  st %s16, 208(,%s11)
; CHECK-NEXT:  svm %s16,%vm2,1
; CHECK-NEXT:  st %s16, 216(,%s11)
; CHECK-NEXT:  svm %s16,%vm2,2
; CHECK-NEXT:  st %s16, 224(,%s11)
; CHECK-NEXT:  svm %s16,%vm2,3
; CHECK-NEXT:  st %s16, 232(,%s11)
; CHECK-NEXT:  or %s11, 0, %s9
  %addr = alloca <512 x i1>, align 16
  store <512 x i1> %0, <512 x i1>* %addr, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev512i1com(<512 x i1>) {
; CHECK-LABEL: storev512i1com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  svm %s34,%vm2,3
; CHECK-NEXT:  lea %s35, v512i1@lo
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s35, v512i1@hi(%s35)
; CHECK-NEXT:  st %s34, 56(,%s35)
; CHECK-NEXT:  svm %s34,%vm2,2
; CHECK-NEXT:  st %s34, 48(,%s35)
; CHECK-NEXT:  svm %s34,%vm2,1
; CHECK-NEXT:  st %s34, 40(,%s35)
; CHECK-NEXT:  svm %s34,%vm2,0
; CHECK-NEXT:  st %s34, 32(,%s35)
; CHECK-NEXT:  svm %s34,%vm3,3
; CHECK-NEXT:  st %s34, 24(,%s35)
; CHECK-NEXT:  svm %s34,%vm3,2
; CHECK-NEXT:  st %s34, 16(,%s35)
; CHECK-NEXT:  svm %s34,%vm3,1
; CHECK-NEXT:  st %s34, 8(,%s35)
; CHECK-NEXT:  svm %s34,%vm3,0
; CHECK-NEXT:  st %s34, (,%s35)
; CHECK-NEXT:  or %s11, 0, %s9
  store <512 x i1> %0, <512 x i1>* @v512i1, align 16
  ret void
}

