; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; REQUIRES: asserts
; RUN: opt -S -enable-loop-simplifycfg-term-folding=true -indvars -loop-simplifycfg -debug-only=loop-simplifycfg -verify-loop-info -verify-dom-info -verify-loop-lcssa 2>&1 < %s | FileCheck %s
; RUN: opt -S -enable-loop-simplifycfg-term-folding=true -passes='require<domtree>,loop(indvars,simplify-cfg)' -debug-only=loop-simplifycfg -verify-loop-info -verify-dom-info -verify-loop-lcssa 2>&1 < %s | FileCheck %s
; RUN: opt -S -enable-loop-simplifycfg-term-folding=true -indvars -loop-simplifycfg -enable-mssa-loop-dependency=true -verify-memoryssa -debug-only=loop-simplifycfg -verify-loop-info -verify-dom-info -verify-loop-lcssa 2>&1 < %s | FileCheck %s

define void @test(i1 %c) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    switch i32 0, label [[ENTRY_SPLIT:%.*]] [
; CHECK-NEXT:    i32 1, label [[DEAD_EXIT:%.*]]
; CHECK-NEXT:    ]
; CHECK:       entry-split:
; CHECK-NEXT:    br label [[OUTER:%.*]]
; CHECK:       outer:
; CHECK-NEXT:    br i1 [[C:%.*]], label [[TO_FOLD:%.*]], label [[LATCH:%.*]]
; CHECK:       to_fold:
; CHECK-NEXT:    br i1 [[C]], label [[LATCH]], label [[INNER_PREHEADER:%.*]]
; CHECK:       inner.preheader:
; CHECK-NEXT:    br label [[INNER:%.*]]
; CHECK:       inner:
; CHECK-NEXT:    br i1 false, label [[INNER_LATCH:%.*]], label [[UNDEAD:%.*]]
; CHECK:       inner_latch:
; CHECK-NEXT:    br i1 true, label [[INNER]], label [[LATCH_LOOPEXIT:%.*]]
; CHECK:       undead:
; CHECK-NEXT:    br label [[LATCH]]
; CHECK:       latch.loopexit:
; CHECK-NEXT:    br label [[LATCH]]
; CHECK:       latch:
; CHECK-NEXT:    br label [[OUTER]]
; CHECK:       dead_exit:
; CHECK-NEXT:    ret void
;

entry:
  br label %outer

outer:
  br i1 %c, label %to_fold, label %latch

to_fold:
  br i1 %c, label %latch, label %inner

inner:
  %iv = phi i32 [0, %to_fold], [%iv.next, %inner_latch]
  %never = icmp sgt i32 %iv, 40
  br i1 %never, label %inner_latch, label %undead

inner_latch:
  %iv.next = add i32 %iv, 1
  %cmp = icmp slt i32 %iv.next, 10
  br i1 %cmp, label %inner, label %latch

undead:
  br label %latch

latch:
  br i1 true, label %outer, label %dead_exit

dead_exit:
  ret void
}
