; RUN: opt -indvars < %s 2>&1 | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t* restrict A, int64_t* restrict B) {
;   for (int64_t k = 0; k < x - 5; ++k) {
;     B[k] = B[k+5];
;     for (int64_t i = 0; i < y; ++i) {
;       for (int64_t j = 0; j < z; ++j) {
;         A[(j-1)*y*z + (k+3)*y + 0] = A[j*y*z + k*y + 0];
;         // A[j-1][k+3][0] = A[j][k][0];
;       }
;     }
;     for (int64_t i = 0; i < y; ++i) {
;       for (int64_t j = 0; j < z; ++j) {
;         A[(j-1)*y*z + (k+4)*y + 0] = A[j*y*z + k*y + 0];
;         // A[j-1][k+4][0] = A[j][k][0];
;       }
;     }
;   }
; }

; CHECK: Loop: for.body: Is vectorizable with VF: 3

; Explanation: We want to make sure that the vectorization factor
; of the i-loop is the minimum of:
; Access on the B in k-loop: This has max VF: 5
; (k-loop)-(first i-j (sub-)nest): This has max VF: 3
; (k-loop)-(second i-j (sub-)nest): This has max VF: 4

; Currently FAILING for two reasons: We can't do bounds checking on
; `k` for both `y` and `x`, because we don't know if `x-5` (the max
; value of `k`) is less than `y` (the size of the second dimension).
; Note that `k` is used on both the first and second subscripts. We do
; know though that `x-5+5` <= `x` (see the subscripts used in `B`).
; The second reason is that we don't know if `z` >= 0 (see the third
; subscripts).

define void @test(i64 %x, i64 %y, i64 %z, i64* noalias %A, i64* noalias %B) {
entry:
  %sub = sub nsw i64 %x, 5
  %cmp9 = icmp slt i64 0, %sub
  br i1 %cmp9, label %for.body, label %for.end54

for.body:                                         ; preds = %entry, %for.inc52
  %k.010 = phi i64 [ %inc53, %for.inc52 ], [ 0, %entry ]
  %add = add nsw i64 %k.010, 5
  %arrayidx = getelementptr inbounds i64, i64* %B, i64 %add
  %0 = load i64, i64* %arrayidx, align 8
  %arrayidx1 = getelementptr inbounds i64, i64* %B, i64 %k.010
  store i64 %0, i64* %arrayidx1, align 8
  %cmp33 = icmp slt i64 0, %y
  br i1 %cmp33, label %for.body4, label %for.end23

for.body4:                                        ; preds = %for.body, %for.inc21
  %i.04 = phi i64 [ %inc22, %for.inc21 ], [ 0, %for.body ]
  %cmp61 = icmp slt i64 0, %z
  br i1 %cmp61, label %for.body7, label %for.inc21

for.body7:                                        ; preds = %for.body4, %for.body7
  %j.02 = phi i64 [ %inc, %for.body7 ], [ 0, %for.body4 ]
  %mul = mul nsw i64 %j.02, %y
  %mul8 = mul nsw i64 %mul, %z
  %mul9 = mul nsw i64 %k.010, %y
  %add10 = add nsw i64 %mul8, %mul9
  %add11 = add nsw i64 %add10, 0
  %arrayidx12 = getelementptr inbounds i64, i64* %A, i64 %add11
  %1 = load i64, i64* %arrayidx12, align 8
  %sub13 = sub nsw i64 %j.02, 1
  %mul14 = mul nsw i64 %sub13, %y
  %mul15 = mul nsw i64 %mul14, %z
  %add16 = add nsw i64 %k.010, 3
  %mul17 = mul nsw i64 %add16, %y
  %add18 = add nsw i64 %mul15, %mul17
  %add19 = add nsw i64 %add18, 0
  %arrayidx20 = getelementptr inbounds i64, i64* %A, i64 %add19
  store i64 %1, i64* %arrayidx20, align 8
  %inc = add nsw i64 %j.02, 1
  %cmp6 = icmp slt i64 %inc, %z
  br i1 %cmp6, label %for.body7, label %for.inc21

for.inc21:                                        ; preds = %for.body4, %for.body7
  %inc22 = add nsw i64 %i.04, 1
  %cmp3 = icmp slt i64 %inc22, %y
  br i1 %cmp3, label %for.body4, label %for.end23

for.end23:                                        ; preds = %for.inc21, %for.body
  %cmp267 = icmp slt i64 0, %y
  br i1 %cmp267, label %for.body27, label %for.inc52

for.body27:                                       ; preds = %for.end23, %for.inc49
  %i24.08 = phi i64 [ %inc50, %for.inc49 ], [ 0, %for.end23 ]
  %cmp305 = icmp slt i64 0, %z
  br i1 %cmp305, label %for.body31, label %for.inc49

for.body31:                                       ; preds = %for.body27, %for.body31
  %j28.06 = phi i64 [ %inc47, %for.body31 ], [ 0, %for.body27 ]
  %mul32 = mul nsw i64 %j28.06, %y
  %mul33 = mul nsw i64 %mul32, %z
  %mul34 = mul nsw i64 %k.010, %y
  %add35 = add nsw i64 %mul33, %mul34
  %add36 = add nsw i64 %add35, 0
  %arrayidx37 = getelementptr inbounds i64, i64* %A, i64 %add36
  %2 = load i64, i64* %arrayidx37, align 8
  %sub38 = sub nsw i64 %j28.06, 1
  %mul39 = mul nsw i64 %sub38, %y
  %mul40 = mul nsw i64 %mul39, %z
  %add41 = add nsw i64 %k.010, 4
  %mul42 = mul nsw i64 %add41, %y
  %add43 = add nsw i64 %mul40, %mul42
  %add44 = add nsw i64 %add43, 0
  %arrayidx45 = getelementptr inbounds i64, i64* %A, i64 %add44
  store i64 %2, i64* %arrayidx45, align 8
  %inc47 = add nsw i64 %j28.06, 1
  %cmp30 = icmp slt i64 %inc47, %z
  br i1 %cmp30, label %for.body31, label %for.inc49

for.inc49:                                        ; preds = %for.body27, %for.body31
  %inc50 = add nsw i64 %i24.08, 1
  %cmp26 = icmp slt i64 %inc50, %y
  br i1 %cmp26, label %for.body27, label %for.inc52

for.inc52:                                        ; preds = %for.end23, %for.inc49
  %inc53 = add nsw i64 %k.010, 1
  %cmp = icmp slt i64 %inc53, %sub
  br i1 %cmp, label %for.body, label %for.end54

for.end54:                                        ; preds = %for.inc52, %entry
  ret void
}