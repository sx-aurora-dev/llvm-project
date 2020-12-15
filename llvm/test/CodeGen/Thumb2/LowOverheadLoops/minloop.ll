; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s

define void @arm_min_q31(i32* nocapture readonly %pSrc, i32 %blockSize, i32* nocapture %pResult, i32* nocapture %pIndex) {
; CHECK-LABEL: arm_min_q31:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r6, r7, r8, r9, r10, r11, lr}
; CHECK-NEXT:    push.w {r4, r5, r6, r7, r8, r9, r10, r11, lr}
; CHECK-NEXT:    ldr.w r12, [r0]
; CHECK-NEXT:    subs.w r9, r1, #1
; CHECK-NEXT:    beq .LBB0_3
; CHECK-NEXT:  @ %bb.1: @ %while.body.preheader
; CHECK-NEXT:    subs r7, r1, #2
; CHECK-NEXT:    and r8, r9, #3
; CHECK-NEXT:    cmp r7, #3
; CHECK-NEXT:    bhs .LBB0_4
; CHECK-NEXT:  @ %bb.2:
; CHECK-NEXT:    movs r6, #0
; CHECK-NEXT:    b .LBB0_6
; CHECK-NEXT:  .LBB0_3:
; CHECK-NEXT:    movs r6, #0
; CHECK-NEXT:    b .LBB0_10
; CHECK-NEXT:  .LBB0_4: @ %while.body.preheader.new
; CHECK-NEXT:    bic r7, r9, #3
; CHECK-NEXT:    movs r6, #1
; CHECK-NEXT:    subs r7, #4
; CHECK-NEXT:    add.w lr, r6, r7, lsr #2
; CHECK-NEXT:    movs r6, #0
; CHECK-NEXT:    dls lr, lr
; CHECK-NEXT:    movs r7, #4
; CHECK-NEXT:  .LBB0_5: @ %while.body
; CHECK-NEXT:    @ =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    ldr r10, [r0, #16]!
; CHECK-NEXT:    sub.w r9, r9, #4
; CHECK-NEXT:    ldrd r5, r4, [r0, #-12]
; CHECK-NEXT:    ldr r11, [r0, #-4]
; CHECK-NEXT:    cmp r12, r5
; CHECK-NEXT:    it gt
; CHECK-NEXT:    subgt r6, r7, #3
; CHECK-NEXT:    csel r5, r5, r12, gt
; CHECK-NEXT:    cmp r5, r4
; CHECK-NEXT:    it gt
; CHECK-NEXT:    subgt r6, r7, #2
; CHECK-NEXT:    csel r5, r4, r5, gt
; CHECK-NEXT:    cmp r5, r11
; CHECK-NEXT:    it gt
; CHECK-NEXT:    subgt r6, r7, #1
; CHECK-NEXT:    csel r5, r11, r5, gt
; CHECK-NEXT:    cmp r5, r10
; CHECK-NEXT:    csel r6, r7, r6, gt
; CHECK-NEXT:    add.w r7, r7, #4
; CHECK-NEXT:    csel r12, r10, r5, gt
; CHECK-NEXT:    le lr, .LBB0_5
; CHECK-NEXT:  .LBB0_6: @ %while.end.loopexit.unr-lcssa
; CHECK-NEXT:    cmp.w r8, #0
; CHECK-NEXT:    beq .LBB0_10
; CHECK-NEXT:  @ %bb.7: @ %while.body.epil
; CHECK-NEXT:    ldr r7, [r0, #4]
; CHECK-NEXT:    sub.w r1, r1, r9
; CHECK-NEXT:    cmp r12, r7
; CHECK-NEXT:    csel r6, r1, r6, gt
; CHECK-NEXT:    csel r12, r7, r12, gt
; CHECK-NEXT:    cmp.w r8, #1
; CHECK-NEXT:    beq .LBB0_10
; CHECK-NEXT:  @ %bb.8: @ %while.body.epil.1
; CHECK-NEXT:    ldr r7, [r0, #8]
; CHECK-NEXT:    cmp r12, r7
; CHECK-NEXT:    csinc r6, r6, r1, le
; CHECK-NEXT:    csel r12, r7, r12, gt
; CHECK-NEXT:    cmp.w r8, #2
; CHECK-NEXT:    beq .LBB0_10
; CHECK-NEXT:  @ %bb.9: @ %while.body.epil.2
; CHECK-NEXT:    ldr r0, [r0, #12]
; CHECK-NEXT:    cmp r12, r0
; CHECK-NEXT:    it gt
; CHECK-NEXT:    addgt r6, r1, #2
; CHECK-NEXT:    csel r12, r0, r12, gt
; CHECK-NEXT:  .LBB0_10: @ %while.end
; CHECK-NEXT:    str.w r12, [r2]
; CHECK-NEXT:    str r6, [r3]
; CHECK-NEXT:    pop.w {r4, r5, r6, r7, r8, r9, r10, r11, pc}
entry:
  %0 = load i32, i32* %pSrc, align 4
  %blkCnt.015 = add i32 %blockSize, -1
  %cmp.not17 = icmp eq i32 %blkCnt.015, 0
  br i1 %cmp.not17, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %entry
  %1 = add i32 %blockSize, -2
  %xtraiter = and i32 %blkCnt.015, 3
  %2 = icmp ult i32 %1, 3
  br i1 %2, label %while.end.loopexit.unr-lcssa, label %while.body.preheader.new

while.body.preheader.new:                         ; preds = %while.body.preheader
  %unroll_iter = and i32 %blkCnt.015, -4
  br label %while.body

while.body:                                       ; preds = %while.body, %while.body.preheader.new
  %pSrc.addr.021.pn = phi i32* [ %pSrc, %while.body.preheader.new ], [ %pSrc.addr.021.3, %while.body ]
  %blkCnt.020 = phi i32 [ %blkCnt.015, %while.body.preheader.new ], [ %blkCnt.0.3, %while.body ]
  %outIndex.019 = phi i32 [ 0, %while.body.preheader.new ], [ %spec.select14.3, %while.body ]
  %out.018 = phi i32 [ %0, %while.body.preheader.new ], [ %spec.select.3, %while.body ]
  %niter = phi i32 [ %unroll_iter, %while.body.preheader.new ], [ %niter.nsub.3, %while.body ]
  %pSrc.addr.021 = getelementptr inbounds i32, i32* %pSrc.addr.021.pn, i32 1
  %3 = load i32, i32* %pSrc.addr.021, align 4
  %cmp2 = icmp sgt i32 %out.018, %3
  %sub3 = sub i32 %blockSize, %blkCnt.020
  %spec.select = select i1 %cmp2, i32 %3, i32 %out.018
  %spec.select14 = select i1 %cmp2, i32 %sub3, i32 %outIndex.019
  %blkCnt.0 = add i32 %blkCnt.020, -1
  %pSrc.addr.021.1 = getelementptr inbounds i32, i32* %pSrc.addr.021.pn, i32 2
  %4 = load i32, i32* %pSrc.addr.021.1, align 4
  %cmp2.1 = icmp sgt i32 %spec.select, %4
  %sub3.1 = sub i32 %blockSize, %blkCnt.0
  %spec.select.1 = select i1 %cmp2.1, i32 %4, i32 %spec.select
  %spec.select14.1 = select i1 %cmp2.1, i32 %sub3.1, i32 %spec.select14
  %blkCnt.0.1 = add i32 %blkCnt.020, -2
  %pSrc.addr.021.2 = getelementptr inbounds i32, i32* %pSrc.addr.021.pn, i32 3
  %5 = load i32, i32* %pSrc.addr.021.2, align 4
  %cmp2.2 = icmp sgt i32 %spec.select.1, %5
  %sub3.2 = sub i32 %blockSize, %blkCnt.0.1
  %spec.select.2 = select i1 %cmp2.2, i32 %5, i32 %spec.select.1
  %spec.select14.2 = select i1 %cmp2.2, i32 %sub3.2, i32 %spec.select14.1
  %blkCnt.0.2 = add i32 %blkCnt.020, -3
  %pSrc.addr.021.3 = getelementptr inbounds i32, i32* %pSrc.addr.021.pn, i32 4
  %6 = load i32, i32* %pSrc.addr.021.3, align 4
  %cmp2.3 = icmp sgt i32 %spec.select.2, %6
  %sub3.3 = sub i32 %blockSize, %blkCnt.0.2
  %spec.select.3 = select i1 %cmp2.3, i32 %6, i32 %spec.select.2
  %spec.select14.3 = select i1 %cmp2.3, i32 %sub3.3, i32 %spec.select14.2
  %blkCnt.0.3 = add i32 %blkCnt.020, -4
  %niter.nsub.3 = add i32 %niter, -4
  %niter.ncmp.3 = icmp eq i32 %niter.nsub.3, 0
  br i1 %niter.ncmp.3, label %while.end.loopexit.unr-lcssa, label %while.body

while.end.loopexit.unr-lcssa:                     ; preds = %while.body, %while.body.preheader
  %spec.select.lcssa.ph = phi i32 [ undef, %while.body.preheader ], [ %spec.select.3, %while.body ]
  %spec.select14.lcssa.ph = phi i32 [ undef, %while.body.preheader ], [ %spec.select14.3, %while.body ]
  %pSrc.addr.021.pn.unr = phi i32* [ %pSrc, %while.body.preheader ], [ %pSrc.addr.021.3, %while.body ]
  %blkCnt.020.unr = phi i32 [ %blkCnt.015, %while.body.preheader ], [ %blkCnt.0.3, %while.body ]
  %outIndex.019.unr = phi i32 [ 0, %while.body.preheader ], [ %spec.select14.3, %while.body ]
  %out.018.unr = phi i32 [ %0, %while.body.preheader ], [ %spec.select.3, %while.body ]
  %lcmp.mod.not = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod.not, label %while.end, label %while.body.epil

while.body.epil:                                  ; preds = %while.end.loopexit.unr-lcssa
  %pSrc.addr.021.epil = getelementptr inbounds i32, i32* %pSrc.addr.021.pn.unr, i32 1
  %7 = load i32, i32* %pSrc.addr.021.epil, align 4
  %cmp2.epil = icmp sgt i32 %out.018.unr, %7
  %sub3.epil = sub i32 %blockSize, %blkCnt.020.unr
  %spec.select.epil = select i1 %cmp2.epil, i32 %7, i32 %out.018.unr
  %spec.select14.epil = select i1 %cmp2.epil, i32 %sub3.epil, i32 %outIndex.019.unr
  %epil.iter.cmp.not = icmp eq i32 %xtraiter, 1
  br i1 %epil.iter.cmp.not, label %while.end, label %while.body.epil.1

while.end:                                        ; preds = %while.end.loopexit.unr-lcssa, %while.body.epil.2, %while.body.epil.1, %while.body.epil, %entry
  %out.0.lcssa = phi i32 [ %0, %entry ], [ %spec.select.lcssa.ph, %while.end.loopexit.unr-lcssa ], [ %spec.select.epil, %while.body.epil ], [ %spec.select.epil.1, %while.body.epil.1 ], [ %spec.select.epil.2, %while.body.epil.2 ]
  %outIndex.0.lcssa = phi i32 [ 0, %entry ], [ %spec.select14.lcssa.ph, %while.end.loopexit.unr-lcssa ], [ %spec.select14.epil, %while.body.epil ], [ %spec.select14.epil.1, %while.body.epil.1 ], [ %spec.select14.epil.2, %while.body.epil.2 ]
  store i32 %out.0.lcssa, i32* %pResult, align 4
  store i32 %outIndex.0.lcssa, i32* %pIndex, align 4
  ret void

while.body.epil.1:                                ; preds = %while.body.epil
  %blkCnt.0.epil = add i32 %blkCnt.020.unr, -1
  %pSrc.addr.021.epil.1 = getelementptr inbounds i32, i32* %pSrc.addr.021.pn.unr, i32 2
  %8 = load i32, i32* %pSrc.addr.021.epil.1, align 4
  %cmp2.epil.1 = icmp sgt i32 %spec.select.epil, %8
  %sub3.epil.1 = sub i32 %blockSize, %blkCnt.0.epil
  %spec.select.epil.1 = select i1 %cmp2.epil.1, i32 %8, i32 %spec.select.epil
  %spec.select14.epil.1 = select i1 %cmp2.epil.1, i32 %sub3.epil.1, i32 %spec.select14.epil
  %epil.iter.cmp.1.not = icmp eq i32 %xtraiter, 2
  br i1 %epil.iter.cmp.1.not, label %while.end, label %while.body.epil.2

while.body.epil.2:                                ; preds = %while.body.epil.1
  %blkCnt.0.epil.1 = add i32 %blkCnt.020.unr, -2
  %pSrc.addr.021.epil.2 = getelementptr inbounds i32, i32* %pSrc.addr.021.pn.unr, i32 3
  %9 = load i32, i32* %pSrc.addr.021.epil.2, align 4
  %cmp2.epil.2 = icmp sgt i32 %spec.select.epil.1, %9
  %sub3.epil.2 = sub i32 %blockSize, %blkCnt.0.epil.1
  %spec.select.epil.2 = select i1 %cmp2.epil.2, i32 %9, i32 %spec.select.epil.1
  %spec.select14.epil.2 = select i1 %cmp2.epil.2, i32 %sub3.epil.2, i32 %spec.select14.epil.1
  br label %while.end
}
