; RUN: opt -indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void clenshaw(double *coeffs, int64_t n, double *xs,
;               double *restrict ys, int64_t m) {
;   for (int64_t i = 0; i < m; i++) {
;     double x = xs[i];
;     double u0 = 0, u1 = 0, u2 = 0;
;     for (int64_t k = n - 1; k >= 0; k--) {
;       u2 = u1;
;       u1 = u0;
;       u0 = 2 * x * u1 - u2 + coeffs[k];
;     }
;     ys[i] = 0.5 * (coeffs[0] + u0 - u2);
;   }
; }

; CHECK: Loop: for.body: Is vectorizable for any factor
; CHECK: Loop: for.body3: Is vectorizable for any factor

; Explanation: A real-world example that can be vectorized
; given that at least `ys`, the (only) memory in which we write,
; is noalias.

define void @clenshaw(double* %coeffs, i64 %n, double* %xs, double* noalias %ys, i64 %m) #0 {
entry:
  %cmp6 = icmp sgt i64 %m, 0
  br i1 %cmp6, label %for.body, label %for.end13

for.body:                                         ; preds = %entry, %for.end
  %i.07 = phi i64 [ %inc, %for.end ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds double, double* %xs, i64 %i.07
  %0 = load double, double* %arrayidx, align 8
  %cmp21 = icmp sgt i64 %n, 0
  br i1 %cmp21, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.body, %for.body3
  %k.04.in = phi i64 [ %k.04, %for.body3 ], [ %n, %for.body ]
  %u1.03 = phi double [ %u0.02, %for.body3 ], [ 0.000000e+00, %for.body ]
  %u0.02 = phi double [ %add, %for.body3 ], [ 0.000000e+00, %for.body ]
  %k.04 = add nsw i64 %k.04.in, -1
  %mul = fmul double %0, 2.000000e+00
  %mul4 = fmul double %mul, %u0.02
  %sub5 = fsub double %mul4, %u1.03
  %arrayidx6 = getelementptr inbounds double, double* %coeffs, i64 %k.04
  %1 = load double, double* %arrayidx6, align 8
  %add = fadd double %sub5, %1
  %cmp2 = icmp sgt i64 %k.04.in, 1
  br i1 %cmp2, label %for.body3, label %for.end

for.end:                                          ; preds = %for.body3, %for.body
  %u0.0.lcssa = phi double [ 0.000000e+00, %for.body ], [ %add, %for.body3 ]
  %u2.0.lcssa = phi double [ 0.000000e+00, %for.body ], [ %u1.03, %for.body3 ]
  %2 = load double, double* %coeffs, align 8
  %add8 = fadd double %2, %u0.0.lcssa
  %sub9 = fsub double %add8, %u2.0.lcssa
  %mul10 = fmul double %sub9, 5.000000e-01
  %arrayidx11 = getelementptr inbounds double, double* %ys, i64 %i.07
  store double %mul10, double* %arrayidx11, align 8
  %inc = add nuw nsw i64 %i.07, 1
  %cmp = icmp slt i64 %inc, %m
  br i1 %cmp, label %for.body, label %for.end13

for.end13:                                        ; preds = %for.end, %entry
  ret void
}
