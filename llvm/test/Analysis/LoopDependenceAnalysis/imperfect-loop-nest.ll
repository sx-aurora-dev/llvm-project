; RUN: opt -passes='require<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t n, int64_t m, int64_t A[n][m]) {
;     for (int64_t i = 0; i < n; ++i) {
;       for (int64_t j = 0; j < m; ++j) {
;             A[i+2][j-1] = A[i][j];
;         }
;         for (int64_t j = 0; j < m; ++j) {
;             A[i+2][j-1] = A[i][j];
;         }
;     }
; }

; CHECK: Loop: for.body: Is NOT vectorizable
; CHECK: Loop: for.body3: Is NOT vectorizable
; CHECK: Loop: for.body10: Is NOT vectorizable

; Explanation: Imperfect loop nest. Can't handle
; it for now.

define void @test(i64 %n, i64 %m, i64* %A) #0 {
entry:
  %cmp5 = icmp sgt i64 %n, 0
  br i1 %cmp5, label %for.body, label %for.end22

for.body:                                         ; preds = %entry, %for.inc20
  %i.06 = phi i64 [ %inc21, %for.inc20 ], [ 0, %entry ]
  %cmp21 = icmp sgt i64 %m, 0
  br i1 %cmp21, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i64 [ %inc, %for.body3 ], [ 0, %for.body ]
  %0 = mul nsw i64 %i.06, %m
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %j.02
  %1 = load i64, i64* %arrayidx4, align 8
  %add = add nuw nsw i64 %i.06, 2
  %2 = mul nsw i64 %add, %m
  %arrayidx5 = getelementptr inbounds i64, i64* %A, i64 %2
  %sub = add nsw i64 %j.02, -1
  %arrayidx6 = getelementptr inbounds i64, i64* %arrayidx5, i64 %sub
  store i64 %1, i64* %arrayidx6, align 8
  %inc = add nuw nsw i64 %j.02, 1
  %cmp2 = icmp slt i64 %inc, %m
  br i1 %cmp2, label %for.body3, label %for.end

for.end:                                          ; preds = %for.body3, %for.body
  %cmp93 = icmp sgt i64 %m, 0
  br i1 %cmp93, label %for.body10, label %for.inc20

for.body10:                                       ; preds = %for.end, %for.body10
  %j7.04 = phi i64 [ %inc18, %for.body10 ], [ 0, %for.end ]
  %3 = mul nsw i64 %i.06, %m
  %arrayidx11 = getelementptr inbounds i64, i64* %A, i64 %3
  %arrayidx12 = getelementptr inbounds i64, i64* %arrayidx11, i64 %j7.04
  %4 = load i64, i64* %arrayidx12, align 8
  %add13 = add nuw nsw i64 %i.06, 2
  %5 = mul nsw i64 %add13, %m
  %arrayidx14 = getelementptr inbounds i64, i64* %A, i64 %5
  %sub15 = add nsw i64 %j7.04, -1
  %arrayidx16 = getelementptr inbounds i64, i64* %arrayidx14, i64 %sub15
  store i64 %4, i64* %arrayidx16, align 8
  %inc18 = add nuw nsw i64 %j7.04, 1
  %cmp9 = icmp slt i64 %inc18, %m
  br i1 %cmp9, label %for.body10, label %for.inc20

for.inc20:                                        ; preds = %for.end, %for.body10
  %inc21 = add nuw nsw i64 %i.06, 1
  %cmp = icmp slt i64 %inc21, %n
  br i1 %cmp, label %for.body, label %for.end22

for.end22:                                        ; preds = %for.inc20, %entry
  ret void
}