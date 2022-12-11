; RUN: opt -passes=indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t n, int64_t m, int64_t A[n][m]) {
;   for (int64_t i = 0; i < m - 2; ++i)
;     for (int64_t j = 3; j < n; ++j)
;       A[j-3][i+2] = A[j][i];
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 2
; CHECK: Loop: for.body3: Is vectorizable for any factor

; Explanation: We want to check that by shuffling the
; indices (i.e. j, which is IV of the innermost loop, is used
; in the outermost dimension in the array),
; we still can deduce the loop vectorizable.

; We also want to check that the inner loop is vectorizable.

define void @test(i64 %n, i64 %m, i64* %A) {
entry:
  %sub = sub nsw i64 %m, 2
  %cmp3 = icmp slt i64 0, %sub
  br i1 %cmp3, label %for.body, label %for.end10

for.body:                                         ; preds = %entry, %for.inc8
  %i.04 = phi i64 [ %inc9, %for.inc8 ], [ 0, %entry ]
  %cmp21 = icmp slt i64 3, %n
  br i1 %cmp21, label %for.body3, label %for.inc8

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i64 [ %inc, %for.body3 ], [ 3, %for.body ]
  %0 = mul nsw i64 %j.02, %m
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %i.04
  %1 = load i64, i64* %arrayidx4, align 8
  %sub5 = sub nsw i64 %j.02, 3
  %2 = mul nsw i64 %sub5, %m
  %arrayidx6 = getelementptr inbounds i64, i64* %A, i64 %2
  %add = add nsw i64 %i.04, 2
  %arrayidx7 = getelementptr inbounds i64, i64* %arrayidx6, i64 %add
  store i64 %1, i64* %arrayidx7, align 8
  %inc = add nsw i64 %j.02, 1
  %cmp2 = icmp slt i64 %inc, %n
  br i1 %cmp2, label %for.body3, label %for.inc8

for.inc8:                                         ; preds = %for.body, %for.body3
  %inc9 = add nsw i64 %i.04, 1
  %cmp = icmp slt i64 %inc9, %sub
  br i1 %cmp, label %for.body, label %for.end10

for.end10:                                        ; preds = %for.inc8, %entry
  ret void
}
