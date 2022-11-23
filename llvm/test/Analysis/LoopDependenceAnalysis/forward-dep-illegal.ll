; RUN: opt -indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t n, double A[n], int *p) {
;   double x;
;   for (int64_t i = 0; i < n; ++i) {
;     A[i+1] = 4.2*i;
;     p[i] = A[i+2];
;   }
; }

; CHECK: Loop: for.body: Is NOT vectorizable

; Explanation: Constract this with forward-dep.ll.
; Here, because the _read reads further_ (or equivalently,
; the writes writes in previous), the A[i+2] will always
; read an old value. If we vectorize the write (say to write
; 4 new values at once), it will read the new values.

; Note two important things here:
; 1) We have to store the loaded value into `p` (or do something)
;    analogous) otherwise, as part of running `-indvars`, the load
;    will be removed completely.
; 2) Note that we have out-of-bounds access when i=n-1 and i=n-2. However,
;    because this is a singly dimensional array, there's no away, from the IR,
;    to find out the limits. So, we don't see any bounds-checking error. But
;    maybe more importantly, these OOB accesses _are UB_, so we're ok.

define void @test(i64 %n, double* %A, i32* %p) {
entry:
  %cmp1 = icmp slt i64 0, %n
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.02 = phi i64 [ %inc, %for.body ], [ 0, %for.body.preheader ]
  %conv = sitofp i64 %i.02 to double
  %mul = fmul double 4.200000e+00, %conv
  %add = add nuw nsw i64 %i.02, 1
  %arrayidx = getelementptr inbounds double, double* %A, i64 %add
  store double %mul, double* %arrayidx, align 8
  %add1 = add nuw nsw i64 %i.02, 2
  %arrayidx2 = getelementptr inbounds double, double* %A, i64 %add1
  %0 = load double, double* %arrayidx2, align 8
  %conv3 = fptosi double %0 to i32
  %arrayidx4 = getelementptr inbounds i32, i32* %p, i64 %i.02
  store i32 %conv3, i32* %arrayidx4, align 4
  %inc = add nuw nsw i64 %i.02, 1
  %exitcond = icmp ne i64 %inc, %n
  br i1 %exitcond, label %for.body, label %for.end.loopexit

for.end.loopexit:                                 ; preds = %for.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %entry
  ret void
}
