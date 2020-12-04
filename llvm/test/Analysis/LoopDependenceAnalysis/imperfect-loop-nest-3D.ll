; RUN: opt -indvars < %s 2>&1 | opt -passes='loop-simplify,print<loop-dependence>' -disable-output 2>&1 | FileCheck %s

; void test(int64_t x, int64_t y, int64_t z, int64_t *restrict A,
;           int64_t *restrict B) {
;   for (int64_t k = 0; k < x; ++k) {
;     B[k] = B[k+5];
;     for (int64_t i = 0; i < y; ++i) {
;       for (int64_t j = 0; j < z; ++j) {
;         A[(j-1)*y*z + (k+3)*y + i] = A[j*y*z + k*y + i];
;         // A[j-1][k+3][i] = A[j][k][i];
;       }
;     }
;     for (int64_t i = 0; i < y; ++i) {
;       for (int64_t j = 0; j < z; ++j) {
;         A[(j-1)*y*z + (k+4)*y + i+1] = A[j*y*z + k*y + i+1];
;         // A[j-1][k+4][i+1] = A[j][k][i+1];
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

; Currently FAILING for similar reasons as imperfect-loop-nest-3.ll

define void @test(i64 %x, i64 %y, i64 %z, i64* noalias %A, i64* noalias %B) {
entry:
  %cmp9 = icmp slt i64 0, %x
  br i1 %cmp9, label %for.body, label %for.end55

for.body:                                         ; preds = %entry, %for.inc53
  %k.010 = phi i64 [ %inc54, %for.inc53 ], [ 0, %entry ]
  %add = add nsw i64 %k.010, 5
  %arrayidx = getelementptr inbounds i64, i64* %B, i64 %add
  %0 = load i64, i64* %arrayidx, align 8
  %arrayidx1 = getelementptr inbounds i64, i64* %B, i64 %k.010
  store i64 %0, i64* %arrayidx1, align 8
  %cmp33 = icmp slt i64 0, %y
  br i1 %cmp33, label %for.body4, label %for.end22

for.body4:                                        ; preds = %for.body, %for.inc20
  %i.04 = phi i64 [ %inc21, %for.inc20 ], [ 0, %for.body ]
  %cmp61 = icmp slt i64 0, %z
  br i1 %cmp61, label %for.body7, label %for.inc20

for.body7:                                        ; preds = %for.body4, %for.body7
  %j.02 = phi i64 [ %inc, %for.body7 ], [ 0, %for.body4 ]
  %mul = mul nsw i64 %j.02, %y
  %mul8 = mul nsw i64 %mul, %z
  %mul9 = mul nsw i64 %k.010, %y
  %add10 = add nsw i64 %mul8, %mul9
  %add11 = add nsw i64 %add10, %i.04
  %arrayidx12 = getelementptr inbounds i64, i64* %A, i64 %add11
  %1 = load i64, i64* %arrayidx12, align 8
  %sub = sub nsw i64 %j.02, 1
  %mul13 = mul nsw i64 %sub, %y
  %mul14 = mul nsw i64 %mul13, %z
  %add15 = add nsw i64 %k.010, 3
  %mul16 = mul nsw i64 %add15, %y
  %add17 = add nsw i64 %mul14, %mul16
  %add18 = add nsw i64 %add17, %i.04
  %arrayidx19 = getelementptr inbounds i64, i64* %A, i64 %add18
  store i64 %1, i64* %arrayidx19, align 8
  %inc = add nsw i64 %j.02, 1
  %cmp6 = icmp slt i64 %inc, %z
  br i1 %cmp6, label %for.body7, label %for.inc20

for.inc20:                                        ; preds = %for.body4, %for.body7
  %inc21 = add nsw i64 %i.04, 1
  %cmp3 = icmp slt i64 %inc21, %y
  br i1 %cmp3, label %for.body4, label %for.end22

for.end22:                                        ; preds = %for.inc20, %for.body
  %cmp257 = icmp slt i64 0, %y
  br i1 %cmp257, label %for.body26, label %for.inc53

for.body26:                                       ; preds = %for.end22, %for.inc50
  %i23.08 = phi i64 [ %inc51, %for.inc50 ], [ 0, %for.end22 ]
  %cmp295 = icmp slt i64 0, %z
  br i1 %cmp295, label %for.body30, label %for.inc50

for.body30:                                       ; preds = %for.body26, %for.body30
  %j27.06 = phi i64 [ %inc48, %for.body30 ], [ 0, %for.body26 ]
  %mul31 = mul nsw i64 %j27.06, %y
  %mul32 = mul nsw i64 %mul31, %z
  %mul33 = mul nsw i64 %k.010, %y
  %add34 = add nsw i64 %mul32, %mul33
  %add35 = add nsw i64 %add34, %i23.08
  %add36 = add nsw i64 %add35, 1
  %arrayidx37 = getelementptr inbounds i64, i64* %A, i64 %add36
  %2 = load i64, i64* %arrayidx37, align 8
  %sub38 = sub nsw i64 %j27.06, 1
  %mul39 = mul nsw i64 %sub38, %y
  %mul40 = mul nsw i64 %mul39, %z
  %add41 = add nsw i64 %k.010, 4
  %mul42 = mul nsw i64 %add41, %y
  %add43 = add nsw i64 %mul40, %mul42
  %add44 = add nsw i64 %add43, %i23.08
  %add45 = add nsw i64 %add44, 1
  %arrayidx46 = getelementptr inbounds i64, i64* %A, i64 %add45
  store i64 %2, i64* %arrayidx46, align 8
  %inc48 = add nsw i64 %j27.06, 1
  %cmp29 = icmp slt i64 %inc48, %z
  br i1 %cmp29, label %for.body30, label %for.inc50

for.inc50:                                        ; preds = %for.body26, %for.body30
  %inc51 = add nsw i64 %i23.08, 1
  %cmp25 = icmp slt i64 %inc51, %y
  br i1 %cmp25, label %for.body26, label %for.inc53

for.inc53:                                        ; preds = %for.end22, %for.inc50
  %inc54 = add nsw i64 %k.010, 1
  %cmp = icmp slt i64 %inc54, %x
  br i1 %cmp, label %for.body, label %for.end55

for.end55:                                        ; preds = %for.inc53, %entry
  ret void
}