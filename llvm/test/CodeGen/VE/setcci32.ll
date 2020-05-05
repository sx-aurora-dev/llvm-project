; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define zeroext i1 @setcceq(i32, i32) {
; CHECK-LABEL: setcceq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp eq i32 %0, %1
  ret i1 %3
}

define zeroext i1 @setccne(i32, i32) {
; CHECK-LABEL: setccne:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    xor %s0, 1, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp ne i32 %0, %1
  ret i1 %3
}

define zeroext i1 @setccugt(i32, i32) {
; CHECK-LABEL: setccugt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    srl %s0, %s0, 31
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp ugt i32 %0, %1
  ret i1 %3
}

define zeroext i1 @setccuge(i32, i32) {
; CHECK-LABEL: setccuge:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    srl %s0, %s0, 31
; CHECK-NEXT:    xor %s0, 1, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp uge i32 %0, %1
  ret i1 %3
}

define zeroext i1 @setccult(i32, i32) {
; CHECK-LABEL: setccult:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    srl %s0, %s0, 31
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp ult i32 %0, %1
  ret i1 %3
}

define zeroext i1 @setccule(i32, i32) {
; CHECK-LABEL: setccule:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    srl %s0, %s0, 31
; CHECK-NEXT:    xor %s0, 1, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp ule i32 %0, %1
  ret i1 %3
}

define zeroext i1 @setccsgt(i32, i32) {
; CHECK-LABEL: setccsgt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.zx %s0, %s1, %s0
; CHECK-NEXT:    srl %s0, %s0, 31
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp sgt i32 %0, %1
  ret i1 %3
}

define zeroext i1 @setccsge(i32, i32) {
; CHECK-LABEL: setccsge:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    srl %s0, %s0, 31
; CHECK-NEXT:    xor %s0, 1, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp sge i32 %0, %1
  ret i1 %3
}

define zeroext i1 @setccslt(i32, i32) {
; CHECK-LABEL: setccslt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    srl %s0, %s0, 31
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp slt i32 %0, %1
  ret i1 %3
}

define zeroext i1 @setccsle(i32, i32) {
; CHECK-LABEL: setccsle:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.zx %s0, %s1, %s0
; CHECK-NEXT:    srl %s0, %s0, 31
; CHECK-NEXT:    xor %s0, 1, %s0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    or %s11, 0, %s9
  %3 = icmp sle i32 %0, %1
  ret i1 %3
}
