; RUN: opt -indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t n, int64_t m, double A[n][m]) {
;   double x;
;   for (int64_t i = 0; i < n - 1; ++i) {
;     for (int64_t j = 0; j < m - 1; ++j) {
;       A[i+1][j+1] = 4.2*i;
;       x = A[i][j];
;     }
;   }
; }


; CHECK: Loop: for.body: Is vectorizable for any factor

; Explanation: The writes always access memory
; locations before reads do.

define void @test(i64 %n, i64 %m, double* %A) {
entry:
  %sub = sub nsw i64 %n, 1
  %cmp4 = icmp slt i64 0, %sub
  br i1 %cmp4, label %for.body, label %for.end11

for.body:                                         ; preds = %entry, %for.inc9
  %i.05 = phi i64 [ %inc10, %for.inc9 ], [ 0, %entry ]
  %sub2 = sub nsw i64 %m, 1
  %cmp31 = icmp slt i64 0, %sub2
  br i1 %cmp31, label %for.body4, label %for.inc9

for.body4:                                        ; preds = %for.body, %for.body4
  %j.02 = phi i64 [ %inc, %for.body4 ], [ 0, %for.body ]
  %conv = sitofp i64 %i.05 to double
  %mul = fmul double 4.200000e+00, %conv
  %add = add nsw i64 %i.05, 1
  %0 = mul nsw i64 %add, %m
  %arrayidx = getelementptr inbounds double, double* %A, i64 %0
  %add5 = add nsw i64 %j.02, 1
  %arrayidx6 = getelementptr inbounds double, double* %arrayidx, i64 %add5
  store double %mul, double* %arrayidx6, align 8
  %1 = mul nsw i64 %i.05, %m
  %arrayidx7 = getelementptr inbounds double, double* %A, i64 %1
  %arrayidx8 = getelementptr inbounds double, double* %arrayidx7, i64 %j.02
  %2 = load double, double* %arrayidx8, align 8
  %inc = add nsw i64 %j.02, 1
  %cmp3 = icmp slt i64 %inc, %sub2
  br i1 %cmp3, label %for.body4, label %for.inc9

for.inc9:                                         ; preds = %for.body, %for.body4
  %inc10 = add nsw i64 %i.05, 1
  %cmp = icmp slt i64 %inc10, %sub
  br i1 %cmp, label %for.body, label %for.end11

for.end11:                                        ; preds = %for.inc9, %entry
  ret void
}
