; RUN: llc < %s -mtriple=ve | FileCheck %s

@v4i64 = common dso_local local_unnamed_addr global <4 x i64> zeroinitializer, align 4
@v8i64 = common dso_local local_unnamed_addr global <8 x i64> zeroinitializer, align 4

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev4i64(<4 x i64>* nocapture, <4 x i64>) {
; CHECK-LABEL: storev4i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s1, %vm1, 3
; CHECK-NEXT:    st %s1, 24(, %s0)
; CHECK-NEXT:    svm %s1, %vm1, 2
; CHECK-NEXT:    st %s1, 16(, %s0)
; CHECK-NEXT:    svm %s1, %vm1, 1
; CHECK-NEXT:    st %s1, 8(, %s0)
; CHECK-NEXT:    svm %s1, %vm1, 0
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:    or %s11, 0, %s9
  store <4 x i64> %1, <4 x i64>* %0, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev4i64stk(<4 x i64>) {
; CHECK-LABEL: storev4i64stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s16, %vm1, 0
; CHECK-NEXT:    st %s16, 176(, %s11)
; CHECK-NEXT:    svm %s16, %vm1, 1
; CHECK-NEXT:    st %s16, 184(, %s11)
; CHECK-NEXT:    svm %s16, %vm1, 2
; CHECK-NEXT:    st %s16, 192(, %s11)
; CHECK-NEXT:    svm %s16, %vm1, 3
; CHECK-NEXT:    st %s16, 200(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %addr = alloca <4 x i64>, align 16
  store <4 x i64> %0, <4 x i64>* %addr, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev4i64com(<4 x i64>) {
; CHECK-LABEL: storev4i64com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s0, %vm1, 3
; CHECK-NEXT:    lea %s1, v4i64@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, v4i64@hi(, %s1)
; CHECK-NEXT:    st %s0, 24(, %s1)
; CHECK-NEXT:    svm %s0, %vm1, 2
; CHECK-NEXT:    st %s0, 16(, %s1)
; CHECK-NEXT:    svm %s0, %vm1, 1
; CHECK-NEXT:    st %s0, 8(, %s1)
; CHECK-NEXT:    svm %s0, %vm1, 0
; CHECK-NEXT:    st %s0, (, %s1)
; CHECK-NEXT:    or %s11, 0, %s9
  store <4 x i64> %0, <4 x i64>* @v4i64, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev8i64(<8 x i64>* nocapture, <8 x i64>) {
; CHECK-LABEL: storev8i64:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s1, %vm2, 3
; CHECK-NEXT:    st %s1, 56(, %s0)
; CHECK-NEXT:    svm %s1, %vm2, 2
; CHECK-NEXT:    st %s1, 48(, %s0)
; CHECK-NEXT:    svm %s1, %vm2, 1
; CHECK-NEXT:    st %s1, 40(, %s0)
; CHECK-NEXT:    svm %s1, %vm2, 0
; CHECK-NEXT:    st %s1, 32(, %s0)
; CHECK-NEXT:    svm %s1, %vm3, 3
; CHECK-NEXT:    st %s1, 24(, %s0)
; CHECK-NEXT:    svm %s1, %vm3, 2
; CHECK-NEXT:    st %s1, 16(, %s0)
; CHECK-NEXT:    svm %s1, %vm3, 1
; CHECK-NEXT:    st %s1, 8(, %s0)
; CHECK-NEXT:    svm %s1, %vm3, 0
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:    or %s11, 0, %s9
  store <8 x i64> %1, <8 x i64>* %0, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev8i64stk(<8 x i64>) {
; CHECK-LABEL: storev8i64stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s16, %vm3, 0
; CHECK-NEXT:    st %s16, 176(, %s11)
; CHECK-NEXT:    svm %s16, %vm3, 1
; CHECK-NEXT:    st %s16, 184(, %s11)
; CHECK-NEXT:    svm %s16, %vm3, 2
; CHECK-NEXT:    st %s16, 192(, %s11)
; CHECK-NEXT:    svm %s16, %vm3, 3
; CHECK-NEXT:    st %s16, 200(, %s11)
; CHECK-NEXT:    svm %s16, %vm2, 0
; CHECK-NEXT:    st %s16, 208(, %s11)
; CHECK-NEXT:    svm %s16, %vm2, 1
; CHECK-NEXT:    st %s16, 216(, %s11)
; CHECK-NEXT:    svm %s16, %vm2, 2
; CHECK-NEXT:    st %s16, 224(, %s11)
; CHECK-NEXT:    svm %s16, %vm2, 3
; CHECK-NEXT:    st %s16, 232(, %s11)
; CHECK-NEXT:    or %s11, 0, %s9
  %addr = alloca <8 x i64>, align 16
  store <8 x i64> %0, <8 x i64>* %addr, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define x86_regcallcc void @storev8i64com(<8 x i64>) {
; CHECK-LABEL: storev8i64com:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    svm %s0, %vm2, 3
; CHECK-NEXT:    lea %s1, v8i64@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, v8i64@hi(, %s1)
; CHECK-NEXT:    st %s0, 56(, %s1)
; CHECK-NEXT:    svm %s0, %vm2, 2
; CHECK-NEXT:    st %s0, 48(, %s1)
; CHECK-NEXT:    svm %s0, %vm2, 1
; CHECK-NEXT:    st %s0, 40(, %s1)
; CHECK-NEXT:    svm %s0, %vm2, 0
; CHECK-NEXT:    st %s0, 32(, %s1)
; CHECK-NEXT:    svm %s0, %vm3, 3
; CHECK-NEXT:    st %s0, 24(, %s1)
; CHECK-NEXT:    svm %s0, %vm3, 2
; CHECK-NEXT:    st %s0, 16(, %s1)
; CHECK-NEXT:    svm %s0, %vm3, 1
; CHECK-NEXT:    st %s0, 8(, %s1)
; CHECK-NEXT:    svm %s0, %vm3, 0
; CHECK-NEXT:    st %s0, (, %s1)
; CHECK-NEXT:    or %s11, 0, %s9
  store <8 x i64> %0, <8 x i64>* @v8i64, align 16
  ret void
}

