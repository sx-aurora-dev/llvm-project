; RUN: opt -passes='require<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t n, int64_t m, int64_t A[n][m]) {
;     for (int64_t i = 0; i < n; ++i) {
;       A[i][0] = 2;
;         for (int64_t j = 0; j < m; ++j) {
;             A[j+2][i-1] = A[j][i];
;         }
;     }
; }

; CHECK: Loop: for.body4: Is NOT vectorizable

; Explanation: Accesses not in the innermost loop.

define void @test(i64 %n, i64 %m, i64* %A) #0 {
entry:
  %cmp4 = icmp sgt i64 %n, 0
  br i1 %cmp4, label %for.body, label %for.end11

for.body:                                         ; preds = %entry, %for.inc9
  %i.05 = phi i64 [ %inc10, %for.inc9 ], [ 0, %entry ]
  %0 = mul nsw i64 %i.05, %m
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  store i64 2, i64* %arrayidx, align 8
  %cmp31 = icmp sgt i64 %m, 0
  br i1 %cmp31, label %for.body4, label %for.inc9

for.body4:                                        ; preds = %for.body, %for.body4
  %j.02 = phi i64 [ %inc, %for.body4 ], [ 0, %for.body ]
  %1 = mul nsw i64 %j.02, %m
  %arrayidx5 = getelementptr inbounds i64, i64* %A, i64 %i.05
  %arrayidx6 = getelementptr inbounds i64, i64* %arrayidx5, i64 %1
  %2 = load i64, i64* %arrayidx6, align 8
  %add = add nuw nsw i64 %j.02, 2
  %3 = mul nsw i64 %add, %m
  %arrayidx7 = getelementptr inbounds i64, i64* %A, i64 %3
  %sub = add nsw i64 %i.05, -1
  %arrayidx8 = getelementptr inbounds i64, i64* %arrayidx7, i64 %sub
  store i64 %2, i64* %arrayidx8, align 8
  %inc = add nuw nsw i64 %j.02, 1
  %cmp3 = icmp slt i64 %inc, %m
  br i1 %cmp3, label %for.body4, label %for.inc9

for.inc9:                                         ; preds = %for.body, %for.body4
  %inc10 = add nuw nsw i64 %i.05, 1
  %cmp = icmp slt i64 %inc10, %n
  br i1 %cmp, label %for.body, label %for.end11

for.end11:                                        ; preds = %for.inc9, %entry
  ret void
}