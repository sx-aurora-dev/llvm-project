; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@v256i1 = common dso_local local_unnamed_addr global <256 x i1> zeroinitializer, align 4
@v512i1 = common dso_local local_unnamed_addr global <512 x i1> zeroinitializer, align 4

; Function Attrs: norecurse nounwind readonly
define void @storev256i1(<256 x i1>* nocapture %mp, <256 x i1> %m) {
; CHECK-LABEL: storev256i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s1,%vm1,3
; CHECK-NEXT:    st %s1, 24(, %s0)
; CHECK-NEXT:    svm %s1,%vm1,2
; CHECK-NEXT:    st %s1, 16(, %s0)
; CHECK-NEXT:    svm %s1,%vm1,1
; CHECK-NEXT:    st %s1, 8(, %s0)
; CHECK-NEXT:    svm %s1,%vm1,0
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:    or %s11, 0, %s9
  store <256 x i1> %m, <256 x i1>* %mp, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define void @storev256i1stk(<256 x i1> %m) {
; CHECK-LABEL: storev256i1stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s16,%vm1,0
; CHECK-NEXT:    st %s16, 176(, %s11)
; CHECK-NEXT:    svm %s16,%vm1,1
; CHECK-NEXT:    st %s16, 184(, %s11)
; CHECK-NEXT:    svm %s16,%vm1,2
; CHECK-NEXT:    st %s16, 192(, %s11)
; CHECK-NEXT:    svm %s16,%vm1,3
; CHECK-NEXT:    st %s16, 200(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %addr = alloca <256 x i1>, align 16
  store <256 x i1> %m, <256 x i1>* %addr, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define void @storev256i1com(<256 x i1> %m) {
; CHECK-LABEL: storev256i1com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s0,%vm1,3
; CHECK-NEXT:    lea %s1, v256i1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, v256i1@hi(, %s1)
; CHECK-NEXT:    st %s0, 24(, %s1)
; CHECK-NEXT:    svm %s0,%vm1,2
; CHECK-NEXT:    st %s0, 16(, %s1)
; CHECK-NEXT:    svm %s0,%vm1,1
; CHECK-NEXT:    st %s0, 8(, %s1)
; CHECK-NEXT:    svm %s0,%vm1,0
; CHECK-NEXT:    st %s0, (, %s1)
; CHECK-NEXT:    or %s11, 0, %s9
  store <256 x i1> %m, <256 x i1>* @v256i1, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define void @storev512i1(<512 x i1>* nocapture %mp, <512 x i1> %m) {
; CHECK-LABEL: storev512i1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s1,%vm2,3
; CHECK-NEXT:    st %s1, 56(, %s0)
; CHECK-NEXT:    svm %s1,%vm2,2
; CHECK-NEXT:    st %s1, 48(, %s0)
; CHECK-NEXT:    svm %s1,%vm2,1
; CHECK-NEXT:    st %s1, 40(, %s0)
; CHECK-NEXT:    svm %s1,%vm2,0
; CHECK-NEXT:    st %s1, 32(, %s0)
; CHECK-NEXT:    svm %s1,%vm1,3
; CHECK-NEXT:    st %s1, 24(, %s0)
; CHECK-NEXT:    svm %s1,%vm1,2
; CHECK-NEXT:    st %s1, 16(, %s0)
; CHECK-NEXT:    svm %s1,%vm1,1
; CHECK-NEXT:    st %s1, 8(, %s0)
; CHECK-NEXT:    svm %s1,%vm1,0
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:    or %s11, 0, %s9
  store <512 x i1> %m, <512 x i1>* %mp, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define void @storev512i1stk(<512 x i1> %m) {
; CHECK-LABEL: storev512i1stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s16,%vm1,0
; CHECK-NEXT:    st %s16, 176(, %s11)
; CHECK-NEXT:    svm %s16,%vm1,1
; CHECK-NEXT:    st %s16, 184(, %s11)
; CHECK-NEXT:    svm %s16,%vm1,2
; CHECK-NEXT:    st %s16, 192(, %s11)
; CHECK-NEXT:    svm %s16,%vm1,3
; CHECK-NEXT:    st %s16, 200(, %s11)
; CHECK-NEXT:    svm %s0,%vm2,3
; CHECK-NEXT:    st %s0, 232(, %s11)
; CHECK-NEXT:    svm %s0,%vm2,2
; CHECK-NEXT:    st %s0, 224(, %s11)
; CHECK-NEXT:    svm %s0,%vm2,1
; CHECK-NEXT:    st %s0, 216(, %s11)
; CHECK-NEXT:    svm %s0,%vm2,0
; CHECK-NEXT:    st %s0, 208(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %addr = alloca <512 x i1>, align 16
  store <512 x i1> %m, <512 x i1>* %addr, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define void @storev512i1com(<512 x i1> %m) {
; CHECK-LABEL: storev512i1com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s0,%vm2,3
; CHECK-NEXT:    lea %s1, v512i1@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, v512i1@hi(, %s1)
; CHECK-NEXT:    st %s0, 56(, %s1)
; CHECK-NEXT:    svm %s0,%vm2,2
; CHECK-NEXT:    st %s0, 48(, %s1)
; CHECK-NEXT:    svm %s0,%vm2,1
; CHECK-NEXT:    st %s0, 40(, %s1)
; CHECK-NEXT:    svm %s0,%vm2,0
; CHECK-NEXT:    st %s0, 32(, %s1)
; CHECK-NEXT:    svm %s0,%vm1,3
; CHECK-NEXT:    st %s0, 24(, %s1)
; CHECK-NEXT:    svm %s0,%vm1,2
; CHECK-NEXT:    st %s0, 16(, %s1)
; CHECK-NEXT:    svm %s0,%vm1,1
; CHECK-NEXT:    st %s0, 8(, %s1)
; CHECK-NEXT:    svm %s0,%vm1,0
; CHECK-NEXT:    st %s0, (, %s1)
; CHECK-NEXT:    or %s11, 0, %s9
  store <512 x i1> %m, <512 x i1>* @v512i1, align 16
  ret void
}

