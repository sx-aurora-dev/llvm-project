; RUN: opt -indvars < %s 2>&1 | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; for (int64_t ii = 0; ii < l-4; ++ii) {
;   for (int64_t i = 0; i < n-4; ++i) {
;     for (int64_t j = 1; j < m; ++j) {
;       for (int64_t k = 1; k < o; ++k) {
;         A[ii+4][i+4][j-1][k-1] = A[ii][i][j][k];
;       }
;     }
;   }
; }

; Note that this DV is neither in the Ngo patter nor in
; the trivial case where every entry is positive. Yet, the
; vectorization factor of the outermost loop is infinite.

; CHECK: Loop: for.cond1.preheader: Is vectorizable for any factor


define void @test(i64 %n, i64 %m, i64 %o, i64 %l, i64* %A) {
entry:
  %sub = sub nsw i64 %l, 4
  %cmp8 = icmp slt i64 0, %sub
  br i1 %cmp8, label %for.cond1.preheader.lr.ph, label %for.end32

for.cond1.preheader.lr.ph:                        ; preds = %entry
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond1.preheader.lr.ph, %for.inc30
  %ii.09 = phi i64 [ 0, %for.cond1.preheader.lr.ph ], [ %inc31, %for.inc30 ]
  %sub2 = sub nsw i64 %n, 4
  %cmp35 = icmp slt i64 0, %sub2
  br i1 %cmp35, label %for.cond6.preheader.lr.ph, label %for.inc30

for.cond6.preheader.lr.ph:                        ; preds = %for.cond1.preheader
  br label %for.cond6.preheader

for.cond6.preheader:                              ; preds = %for.cond6.preheader.lr.ph, %for.inc27
  %i.06 = phi i64 [ 0, %for.cond6.preheader.lr.ph ], [ %inc28, %for.inc27 ]
  %cmp73 = icmp slt i64 1, %m
  br i1 %cmp73, label %for.cond10.preheader.lr.ph, label %for.inc27

for.cond10.preheader.lr.ph:                       ; preds = %for.cond6.preheader
  br label %for.cond10.preheader

for.cond10.preheader:                             ; preds = %for.cond10.preheader.lr.ph, %for.inc24
  %j.04 = phi i64 [ 1, %for.cond10.preheader.lr.ph ], [ %inc25, %for.inc24 ]
  %cmp111 = icmp slt i64 1, %o
  br i1 %cmp111, label %for.body13.lr.ph, label %for.inc24

for.body13.lr.ph:                                 ; preds = %for.cond10.preheader
  br label %for.body13

for.body13:                                       ; preds = %for.body13.lr.ph, %for.body13
  %k.02 = phi i64 [ 1, %for.body13.lr.ph ], [ %inc, %for.body13 ]
  %0 = mul nuw i64 %n, %m
  %1 = mul nuw i64 %0, %o
  %2 = mul nsw i64 %ii.09, %1
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %2
  %3 = mul nuw i64 %m, %o
  %4 = mul nsw i64 %i.06, %3
  %arrayidx14 = getelementptr inbounds i64, i64* %arrayidx, i64 %4
  %5 = mul nsw i64 %j.04, %o
  %arrayidx15 = getelementptr inbounds i64, i64* %arrayidx14, i64 %5
  %arrayidx16 = getelementptr inbounds i64, i64* %arrayidx15, i64 %k.02
  %6 = load i64, i64* %arrayidx16, align 8
  %add = add nsw i64 %ii.09, 4
  %7 = mul nuw i64 %n, %m
  %8 = mul nuw i64 %7, %o
  %9 = mul nsw i64 %add, %8
  %arrayidx17 = getelementptr inbounds i64, i64* %A, i64 %9
  %add18 = add nsw i64 %i.06, 4
  %10 = mul nuw i64 %m, %o
  %11 = mul nsw i64 %add18, %10
  %arrayidx19 = getelementptr inbounds i64, i64* %arrayidx17, i64 %11
  %sub20 = sub nsw i64 %j.04, 1
  %12 = mul nsw i64 %sub20, %o
  %arrayidx21 = getelementptr inbounds i64, i64* %arrayidx19, i64 %12
  %sub22 = sub nsw i64 %k.02, 1
  %arrayidx23 = getelementptr inbounds i64, i64* %arrayidx21, i64 %sub22
  store i64 %6, i64* %arrayidx23, align 8
  %inc = add nsw i64 %k.02, 1
  %cmp11 = icmp slt i64 %inc, %o
  br i1 %cmp11, label %for.body13, label %for.cond10.for.inc24_crit_edge

for.cond10.for.inc24_crit_edge:                   ; preds = %for.body13
  br label %for.inc24

for.inc24:                                        ; preds = %for.cond10.for.inc24_crit_edge, %for.cond10.preheader
  %inc25 = add nsw i64 %j.04, 1
  %cmp7 = icmp slt i64 %inc25, %m
  br i1 %cmp7, label %for.cond10.preheader, label %for.cond6.for.inc27_crit_edge

for.cond6.for.inc27_crit_edge:                    ; preds = %for.inc24
  br label %for.inc27

for.inc27:                                        ; preds = %for.cond6.for.inc27_crit_edge, %for.cond6.preheader
  %inc28 = add nsw i64 %i.06, 1
  %cmp3 = icmp slt i64 %inc28, %sub2
  br i1 %cmp3, label %for.cond6.preheader, label %for.cond1.for.inc30_crit_edge

for.cond1.for.inc30_crit_edge:                    ; preds = %for.inc27
  br label %for.inc30

for.inc30:                                        ; preds = %for.cond1.for.inc30_crit_edge, %for.cond1.preheader
  %inc31 = add nsw i64 %ii.09, 1
  %cmp = icmp slt i64 %inc31, %sub
  br i1 %cmp, label %for.cond1.preheader, label %for.cond.for.end32_crit_edge

for.cond.for.end32_crit_edge:                     ; preds = %for.inc30
  br label %for.end32

for.end32:                                        ; preds = %for.cond.for.end32_crit_edge, %entry
  ret void
}
