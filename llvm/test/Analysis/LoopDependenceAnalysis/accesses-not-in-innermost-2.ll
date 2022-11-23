; RUN: opt -indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t A[x][y]) {
;   for (int64_t i = 0; i < x; ++i) {
;     int64_t v = A[i][0];
;     int64_t sum = v;
;     for (int64_t j = 0; j < y; ++j) {
;       sum += 1;
;     }
;     A[i+2][0] = sum;
;   }
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 2
; CHECK: Loop: for.body4: Is vectorizable for any factor

; Explanation: Basically, it's like the j-loop didn't
; exist and the accesses to A were 1D.

define void @test(i64 %x, i64 %y, i64* %A) {
entry:
  %cmp4 = icmp sgt i64 %x, 0
  br i1 %cmp4, label %for.body, label %for.end10

for.body:                                         ; preds = %entry, %for.end
  %i.05 = phi i64 [ %inc9, %for.end ], [ 0, %entry ]
  %0 = mul nsw i64 %i.05, %y
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  %1 = load i64, i64* %arrayidx, align 8
  %cmp31 = icmp sgt i64 %y, 0
  br i1 %cmp31, label %for.body4, label %for.end

for.body4:                                        ; preds = %for.body, %for.body4
  %j.03 = phi i64 [ %inc, %for.body4 ], [ 0, %for.body ]
  %sum.02 = phi i64 [ %add, %for.body4 ], [ %1, %for.body ]
  %add = add nsw i64 %sum.02, 1
  %inc = add nuw nsw i64 %j.03, 1
  %cmp3 = icmp slt i64 %inc, %y
  br i1 %cmp3, label %for.body4, label %for.end

for.end:                                          ; preds = %for.body4, %for.body
  %sum.0.lcssa = phi i64 [ %1, %for.body ], [ %add, %for.body4 ]
  %add5 = add nuw nsw i64 %i.05, 2
  %2 = mul nsw i64 %add5, %y
  %arrayidx6 = getelementptr inbounds i64, i64* %A, i64 %2
  store i64 %sum.0.lcssa, i64* %arrayidx6, align 8
  %inc9 = add nuw nsw i64 %i.05, 1
  %cmp = icmp slt i64 %inc9, %x
  br i1 %cmp, label %for.body, label %for.end10

for.end10:                                        ; preds = %for.end, %entry
  ret void
}
