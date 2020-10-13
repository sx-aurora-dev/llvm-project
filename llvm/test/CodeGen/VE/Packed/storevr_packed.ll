; RUN: llc < %s -mtriple=ve-unknown-unknown -mattr=+packed | FileCheck %s

@v512i32 = common dso_local local_unnamed_addr global <512 x i32> zeroinitializer, align 16

; Function Attrs: norecurse nounwind readonly
define fastcc void @storev512i32(<512 x i32>* nocapture, <512 x i32>) {
; CHECK-LABEL: storev512i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  store <512 x i32> %1, <512 x i32>* %0, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define fastcc void @storev512i32stk(<512 x i32>) {
; CHECK-LABEL: storev512i32stk:
; CHECK:         lea %s0, 256
; CHECK-NEXT:    lea %s1, -2048(, %s9)
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vst %v0, 8, %s1
; CHECK-NEXT:    or %s11, 0, %s9
; CHECK-NEXT:    ld %s16, 32(, %s11)
; CHECK-NEXT:    ld %s15, 24(, %s11)
; CHECK-NEXT:    ld %s10, 8(, %s11)
; CHECK-NEXT:    ld %s9, (, %s11)
; CHECK-NEXT:    b.l.t (, %s10)
  %addr = alloca <512 x i32>, align 16
  store <512 x i32> %0, <512 x i32>* %addr, align 16
  ret void
}

; Function Attrs: norecurse nounwind readonly
define fastcc void @storev512i32com(<512 x i32>) {
; CHECK-LABEL: storev512i32com:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s0, v512i32@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, v512i32@hi(, %s0)
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  store <512 x i32> %0, <512 x i32>* @v512i32, align 16
  ret void
}
