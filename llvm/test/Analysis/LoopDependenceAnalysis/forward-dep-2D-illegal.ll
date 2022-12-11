; RUN: opt -passes=indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t n, int64_t m, double A[n][m], int *p) {
;   double x;
;   for (int64_t i = 0; i < n - 1; ++i) {
;     for (int64_t j = 0; j < m - 1; ++j) {
;       A[i+1][j-1] = 4.2*i;
;       p[i + j] = A[i][j];
;     }
;   }
; }

; CHECK: Loop: for.body: Is NOT vectorizable

; Explanation: Although the write accesses
; further memory addresses, it doesn't always
; do before the read.

; Note: We have to use this storing into `p` (or something
; analogous) otherwise the load will be removed by `-indvars`.

define void @test(i64 %n, i64 %m, double* %A, i32* %p) {
entry:
  %sub = sub nsw i64 %n, 1
  %cmp4 = icmp slt i64 0, %sub
  br i1 %cmp4, label %for.body.preheader, label %for.end14

for.body.preheader:                               ; preds = %entry
  %0 = add i64 %m, -1
  %1 = add i64 %n, -1
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.inc12
  %i.05 = phi i64 [ %inc13, %for.inc12 ], [ 0, %for.body.preheader ]
  %sub2 = sub nsw i64 %m, 1
  %cmp31 = icmp slt i64 0, %sub2
  br i1 %cmp31, label %for.body4.preheader, label %for.inc12

for.body4.preheader:                              ; preds = %for.body
  br label %for.body4

for.body4:                                        ; preds = %for.body4.preheader, %for.body4
  %j.02 = phi i64 [ %inc, %for.body4 ], [ 0, %for.body4.preheader ]
  %conv = sitofp i64 %i.05 to double
  %mul = fmul double 4.200000e+00, %conv
  %add = add nuw nsw i64 %i.05, 1
  %2 = mul nsw i64 %add, %m
  %arrayidx = getelementptr inbounds double, double* %A, i64 %2
  %sub5 = sub nsw i64 %j.02, 1
  %arrayidx6 = getelementptr inbounds double, double* %arrayidx, i64 %sub5
  store double %mul, double* %arrayidx6, align 8
  %3 = mul nsw i64 %i.05, %m
  %arrayidx7 = getelementptr inbounds double, double* %A, i64 %3
  %arrayidx8 = getelementptr inbounds double, double* %arrayidx7, i64 %j.02
  %4 = load double, double* %arrayidx8, align 8
  %conv9 = fptosi double %4 to i32
  %add10 = add nuw nsw i64 %i.05, %j.02
  %arrayidx11 = getelementptr inbounds i32, i32* %p, i64 %add10
  store i32 %conv9, i32* %arrayidx11, align 4
  %inc = add nuw nsw i64 %j.02, 1
  %exitcond = icmp ne i64 %inc, %0
  br i1 %exitcond, label %for.body4, label %for.inc12.loopexit

for.inc12.loopexit:                               ; preds = %for.body4
  br label %for.inc12

for.inc12:                                        ; preds = %for.inc12.loopexit, %for.body
  %inc13 = add nuw nsw i64 %i.05, 1
  %exitcond6 = icmp ne i64 %inc13, %1
  br i1 %exitcond6, label %for.body, label %for.end14.loopexit

for.end14.loopexit:                               ; preds = %for.inc12
  br label %for.end14

for.end14:                                        ; preds = %for.end14.loopexit, %entry
  ret void
}
