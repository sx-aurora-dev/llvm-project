; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

define signext i32 @selectcceq(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectcceq:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.eq %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp eq i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccne(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccne:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ne %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp ne i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccsgt(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccsgt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccsge(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccsge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ge %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sge i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccslt(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccslt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.lt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp slt i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccsle(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccsle:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmps.w.zx %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.le %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp sle i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccugt(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccugt:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp ugt i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccuge(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccuge:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ge %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp uge i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccult(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccult:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.lt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp ult i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccule(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccule:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.le %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp ule i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccugt2(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccugt2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.gt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp ugt i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccuge2(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccuge2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.ge %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp uge i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccult2(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccult2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.lt %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp ult i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}

define signext i32 @selectccule2(i32 signext, i32 signext, i32 signext, i32 signext) {
; CHECK-LABEL: selectccule2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    cmpu.w %s0, %s0, %s1
; CHECK-NEXT:    cmov.w.le %s3, %s2, %s0
; CHECK-NEXT:    adds.w.sx %s0, %s3, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
  %5 = icmp ule i32 %0, %1
  %6 = select i1 %5, i32 %2, i32 %3
  ret i32 %6
}
