; RUN: opt -passes=indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; IMPORTANT: You _must_ add target data layout otherwise -indvars won't know if it's good to widen.
target datalayout = "n8:16:32:64"

; void test(int32_t n, int32_t m, int32_t A[n][m]) {
;   for (int32_t i = 0; i < n - 3; ++i) {
;     for (int32_t j = 1; j < m; ++j)
;       A[i+3][j-1] = A[i][j];
;     for (int32_t j = 1; j < m; ++j)
;       A[i+2][j-1] = A[i][j];
;   }
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 2
; CHECK: Loop: for.body3: Is vectorizable for any factor
; CHECK: Loop: for.body14: Is vectorizable for any factor

; Explanation: We want to make sure that the vectorization factor
; of the i-loop is the minimum of the two nests:
; (i-loop)-(first j-loop): This has max VF: 3
; (i-loop)-(second j-loop): This has max VF: 2

; Note: In this, we specifically want to make sure that using int32_t
; (in a 64-bit machine, i.e. pointers are 64-bit, i.e. using indexing
; requires sext) doesn't cause problems, specifically, that delinearization
; doesn't fail. Delinearization fails with some combinations of sext, but
; because we run -indvars first, this widens the induction variables 64-bit
; Also note: -indvars can do that because signed integer overflow (e.g.
; when incrementing the IV) is UB and so we can assume it doesn't happen.

define void @test(i32 %n, i32 %m, i32* %A) {
entry:
  %0 = zext i32 %n to i64
  %1 = zext i32 %m to i64
  %sub = sub nsw i32 %n, 3
  %cmp5 = icmp slt i32 0, %sub
  br i1 %cmp5, label %for.body, label %for.end30

for.body:                                         ; preds = %entry, %for.inc28
  %i.06 = phi i32 [ %inc29, %for.inc28 ], [ 0, %entry ]
  %cmp21 = icmp slt i32 1, %m
  br i1 %cmp21, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i32 [ %inc, %for.body3 ], [ 1, %for.body ]
  %idxprom = sext i32 %i.06 to i64
  %2 = mul nsw i64 %idxprom, %1
  %arrayidx = getelementptr inbounds i32, i32* %A, i64 %2
  %idxprom4 = sext i32 %j.02 to i64
  %arrayidx5 = getelementptr inbounds i32, i32* %arrayidx, i64 %idxprom4
  %3 = load i32, i32* %arrayidx5, align 4
  %add = add nsw i32 %i.06, 3
  %idxprom6 = sext i32 %add to i64
  %4 = mul nsw i64 %idxprom6, %1
  %arrayidx7 = getelementptr inbounds i32, i32* %A, i64 %4
  %sub8 = sub nsw i32 %j.02, 1
  %idxprom9 = sext i32 %sub8 to i64
  %arrayidx10 = getelementptr inbounds i32, i32* %arrayidx7, i64 %idxprom9
  store i32 %3, i32* %arrayidx10, align 4
  %inc = add nsw i32 %j.02, 1
  %cmp2 = icmp slt i32 %inc, %m
  br i1 %cmp2, label %for.body3, label %for.end

for.end:                                          ; preds = %for.body3, %for.body
  %cmp133 = icmp slt i32 1, %m
  br i1 %cmp133, label %for.body14, label %for.inc28

for.body14:                                       ; preds = %for.end, %for.body14
  %j11.04 = phi i32 [ %inc26, %for.body14 ], [ 1, %for.end ]
  %idxprom15 = sext i32 %i.06 to i64
  %5 = mul nsw i64 %idxprom15, %1
  %arrayidx16 = getelementptr inbounds i32, i32* %A, i64 %5
  %idxprom17 = sext i32 %j11.04 to i64
  %arrayidx18 = getelementptr inbounds i32, i32* %arrayidx16, i64 %idxprom17
  %6 = load i32, i32* %arrayidx18, align 4
  %add19 = add nsw i32 %i.06, 2
  %idxprom20 = sext i32 %add19 to i64
  %7 = mul nsw i64 %idxprom20, %1
  %arrayidx21 = getelementptr inbounds i32, i32* %A, i64 %7
  %sub22 = sub nsw i32 %j11.04, 1
  %idxprom23 = sext i32 %sub22 to i64
  %arrayidx24 = getelementptr inbounds i32, i32* %arrayidx21, i64 %idxprom23
  store i32 %6, i32* %arrayidx24, align 4
  %inc26 = add nsw i32 %j11.04, 1
  %cmp13 = icmp slt i32 %inc26, %m
  br i1 %cmp13, label %for.body14, label %for.inc28

for.inc28:                                        ; preds = %for.end, %for.body14
  %inc29 = add nsw i32 %i.06, 1
  %cmp = icmp slt i32 %inc29, %sub
  br i1 %cmp, label %for.body, label %for.end30

for.end30:                                        ; preds = %for.inc28, %entry
  ret void
}
