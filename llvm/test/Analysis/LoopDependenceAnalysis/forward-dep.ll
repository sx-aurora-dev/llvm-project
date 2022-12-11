; RUN: opt -passes=indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t n, double A[n]) {
;   double x;
;   for (int64_t i = 0; i < n; ++i) {
;     A[i] = 4.2*i;
;     x = A[i];
;   }
; }

; CHECK: Loop: for.body: Is vectorizable for any factor

; Explanation: There is a forward dependence, that is, the
; read depends on the write. Specifically:
; - The write writes to further (or to the same) memory addresses
; - The write precedes the read in program order.

; If we were to execute the loop sequentially, we would write
; one value, read one value (the new value we just wrote), write
; one value, read it, ...
; The semantics don't change if we: write 4 values, read these
; 4 values etc.

define void @test(i64 %n, double* %A) {
entry:
  %cmp1 = icmp slt i64 0, %n
  br i1 %cmp1, label %for.body, label %for.end

for.body:                                         ; preds = %entry, %for.body
  %i.02 = phi i64 [ %inc, %for.body ], [ 0, %entry ]
  %conv = sitofp i64 %i.02 to double
  %mul = fmul double 4.200000e+00, %conv
  %arrayidx = getelementptr inbounds double, double* %A, i64 %i.02
  store double %mul, double* %arrayidx, align 8
  %arrayidx1 = getelementptr inbounds double, double* %A, i64 %i.02
  %0 = load double, double* %arrayidx1, align 8
  %inc = add nsw i64 %i.02, 1
  %cmp = icmp slt i64 %inc, %n
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

