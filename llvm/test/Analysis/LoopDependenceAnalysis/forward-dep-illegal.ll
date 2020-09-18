; RUN: opt -passes='loop-simplify,print<loop-dependence>' -disable-output  < %s 2>&1 | FileCheck %s

; void test(int64_t n, double A[n]) {
;   double x;
;   for (int64_t i = 0; i < n; ++i) {
;     A[i+1] = 4.2*i;
;     x = A[i+2];
;   }
; }

; CHECK: Loop: for.body: Is NOT vectorizable

; Explanation: Constract this with forward-dep.ll.
; Here, because the _read reads further_ (or equivalently,
; the writes writes in previous), the A[i+2] will always
; read an old value. If we vectorize the write (say to write
; 4 new values at once), it will read the new values.

define void @test(i64 %n, double* %A) {
entry:
  %cmp1 = icmp slt i64 0, %n
  br i1 %cmp1, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %conv = sitofp i64 %i.02 to double
  %mul = fmul double 4.200000e+00, %conv
  %add = add nsw i64 %i.02, 1
  %arrayidx = getelementptr inbounds double, double* %A, i64 %add
  store double %mul, double* %arrayidx, align 8
  %add1 = add nsw i64 %i.02, 2
  %arrayidx2 = getelementptr inbounds double, double* %A, i64 %add1
  %0 = load double, double* %arrayidx2, align 8
  %inc = add nsw i64 %i.02, 1
  %cmp = icmp slt i64 %inc, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}