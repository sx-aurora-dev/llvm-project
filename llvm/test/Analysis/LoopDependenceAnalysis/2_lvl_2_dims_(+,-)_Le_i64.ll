; RUN: opt -indvars < %s 2>&1 | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t n, int64_t m, int x, int64_t A[n][m]) {
;     for (int64_t i = 0; i < n; ++i) {
;         for (int64_t j = 0; j < m; ++j) {
;             A[i+2+x][j-1] = A[i+x][j];
;         }
;     }
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 2
; CHECK: Loop: for.body3: Is vectorizable for any factor

; Explanation: We have direction vector (<, >) with outer distance
; being greater than 1, so we can vectorize in that dinstance
; (specifically 2). What we really want to check here is
; that while `i+2+x` and `i+x` are offset by an unknown
; value but their difference is constant and so
; we should be able to find that the loop is vectorizable.

; This is currently FAILING because of bounds-checking. We can't
; take advantage here of the fact that the difference is constant
; because for all that to be valid, each subscript (part) should
; be in-bounds.

define void @test(i64 %n, i64 %m, i32 %x, i64* %A) {
entry:
  %cmp3 = icmp sgt i64 %n, 0
  br i1 %cmp3, label %for.body, label %for.end12

for.body:                                         ; preds = %entry, %for.inc10
  %i.04 = phi i64 [ %inc11, %for.inc10 ], [ 0, %entry ]
  %cmp21 = icmp sgt i64 %m, 0
  br i1 %cmp21, label %for.body3, label %for.inc10

for.body3:                                        ; preds = %for.body, %for.body3
  %j.02 = phi i64 [ %inc, %for.body3 ], [ 0, %for.body ]
  %conv = sext i32 %x to i64
  %add = add nsw i64 %i.04, %conv
  %0 = mul nsw i64 %add, %m
  %arrayidx = getelementptr inbounds i64, i64* %A, i64 %0
  %arrayidx4 = getelementptr inbounds i64, i64* %arrayidx, i64 %j.02
  %1 = load i64, i64* %arrayidx4, align 8
  %add5 = add nuw nsw i64 %i.04, 2
  %conv6 = sext i32 %x to i64
  %add7 = add nsw i64 %add5, %conv6
  %2 = mul nsw i64 %add7, %m
  %arrayidx8 = getelementptr inbounds i64, i64* %A, i64 %2
  %sub = add nsw i64 %j.02, -1
  %arrayidx9 = getelementptr inbounds i64, i64* %arrayidx8, i64 %sub
  store i64 %1, i64* %arrayidx9, align 8
  %inc = add nuw nsw i64 %j.02, 1
  %cmp2 = icmp slt i64 %inc, %m
  br i1 %cmp2, label %for.body3, label %for.inc10

for.inc10:                                        ; preds = %for.body, %for.body3
  %inc11 = add nuw nsw i64 %i.04, 1
  %cmp = icmp slt i64 %inc11, %n
  br i1 %cmp, label %for.body, label %for.end12

for.end12:                                        ; preds = %for.inc10, %entry
  ret void
}