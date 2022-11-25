; RUN: opt -indvars < %s | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t A[x]) {
;   for (int64_t i = 0; i < x - 2; ++i) {
;     int64_t v = A[i];
;     int64_t sum = v;
;     for (int64_t j = 0; j < y; ++j)
;       sum += 1;
;     A[i+2] = sum;
;   }
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 2
; CHECK: Loop: for.body3: Is vectorizable for any factor

; Explanation: Basically, it's like the j-loop didn't
; exist and the accesses to A were 1D.

define void @test(i64 %x, i64 %y, i64* %A) {
entry:
  %sub = sub nsw i64 %x, 2
  %cmp4 = icmp slt i64 0, %sub
  br i1 %cmp4, label %for.body, label %for.end8

for.body:                                         ; preds = %entry, %for.end
  %i.05 = phi i64 [ %inc7, %for.end ], [ 0, %entry ]
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %i.05
  %0 = load i64, i64* %arrayidx, align 8
  %cmp21 = icmp slt i64 0, %y
  br i1 %cmp21, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.body, %for.body3
  %j.03 = phi i64 [ %inc, %for.body3 ], [ 0, %for.body ]
  %sum.02 = phi i64 [ %add, %for.body3 ], [ %0, %for.body ]
  %add = add nsw i64 %sum.02, 1
  %inc = add nsw i64 %j.03, 1
  %cmp2 = icmp slt i64 %inc, %y
  br i1 %cmp2, label %for.body3, label %for.end

for.end:                                          ; preds = %for.body3, %for.body
  %sum.0.lcssa = phi i64 [ %0, %for.body ], [ %add, %for.body3 ]
  %add4 = add nsw i64 %i.05, 2
  %arrayidx5 = getelementptr inbounds i64, i64* %A, i64 %add4
  store i64 %sum.0.lcssa, i64* %arrayidx5, align 8
  %inc7 = add nsw i64 %i.05, 1
  %cmp = icmp slt i64 %inc7, %sub
  br i1 %cmp, label %for.body, label %for.end8

for.end8:                                         ; preds = %for.end, %entry
  ret void
}
