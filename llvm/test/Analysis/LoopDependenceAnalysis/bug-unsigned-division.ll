; RUN: opt -passes='loop-simplify,print<loop-dependence>' -debug-only=loop-dependence -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t x, int64_t *A) {
;   int v;
;   for (int i = 0; i < x; ++i) {
;     A[i - 1] = 2;
;     v = A[i - 1] * 4;
;   }
; }

; CHECK-NOT: Normalized: {2305843009213693951,+,1}

; Explanation: In single subscript, we try to normalize
; the index by the size of the pointer. The division
; is UDiv in SCEV and so with these -1 there (which become -8,
; because the size of the pointer is 8) we have overflow.
; That's likely just the effect, there's probably a deeper
; problem in the logic.

; There are cases where there's a crash, like in the
; bug report: https://github.com/baziotis/llvm-project/issues/7

define void @test(i64 %x, i64* %A) {
entry:
  %cmp1 = icmp slt i64 0, %x
  br i1 %cmp1, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i32 [ %inc, %for.body ], [ 0, %entry ]
  %sub = sub nsw i32 %i.02, 1
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %idxprom
  store i64 2, i64* %arrayidx, align 8
  %sub2 = sub nsw i32 %i.02, 1
  %idxprom3 = sext i32 %sub2 to i64
  %arrayidx4 = getelementptr inbounds i64, i64* %A, i64 %idxprom3
  %0 = load i64, i64* %arrayidx4, align 8
  %mul = mul nsw i64 %0, 4
  %conv5 = trunc i64 %mul to i32
  %inc = add nsw i32 %i.02, 1
  %conv = sext i32 %inc to i64
  %cmp = icmp slt i64 %conv, %x
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}
