; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i32 @selectcceq(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectcceq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.sx %s0, 12, %s0
; CHECK-NEXT:    cmov.w.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp eq i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccne(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccne:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.sx %s0, 12, %s0
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp ne i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccsgt(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccsgt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.sx %s0, 12, %s0
; CHECK-NEXT:    cmov.w.lt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sgt i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccsge(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccsge:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.sx %s0, 11, %s0
; CHECK-NEXT:    cmov.w.lt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sge i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccslt(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccslt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.sx %s0, 12, %s0
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp slt i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccsle(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccsle:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmps.w.sx %s0, 13, %s0
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp sle i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccugt(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccugt:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, 12, %s0
; CHECK-NEXT:    cmov.w.lt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp ugt i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccuge(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccuge:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, 11, %s0
; CHECK-NEXT:    cmov.w.lt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp uge i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccult(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccult:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, 12, %s0
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp ult i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccule(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccule:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, 13, %s0
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp ule i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccugt2(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccugt2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, 12, %s0
; CHECK-NEXT:    cmov.w.lt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp ugt i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccuge2(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccuge2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, 11, %s0
; CHECK-NEXT:    cmov.w.lt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp uge i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccult2(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccult2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, 12, %s0
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp ult i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccule2(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccule2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:    cmpu.w %s0, 13, %s0
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
  %5 = icmp ule i32 %0, 12
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}
