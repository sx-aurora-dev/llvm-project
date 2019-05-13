; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

@c = common global i8 0, align 32
@s = common global i16 0, align 32
@i = common global i32 0, align 32
@l = common global i64 0, align 32
@it= common global i128 0, align 32
@ui = common global i32 0, align 32

; Function Attrs: norecurse nounwind
define void @test_atomic_store_1() {
; CHECK-LABEL: test_atomic_store_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 1
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  or %s35, 12, (0)1
; CHECK-NEXT:  st1b %s35, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i8 12, i8* @c release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_1seq() {
; CHECK-LABEL: test_atomic_store_1seq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  or %s35, 12, (0)1
; CHECK-NEXT:  st1b %s35, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i8 12, i8* @c seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_2() {
; CHECK-LABEL: test_atomic_store_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 1
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  or %s35, 12, (0)1
; CHECK-NEXT:  st2b %s35, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i16 12, i16* @s release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_2seq() {
; CHECK-LABEL: test_atomic_store_2seq:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  or %s35, 12, (0)1
; CHECK-NEXT:  st2b %s35, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i16 12, i16* @s seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_4() {
; CHECK-LABEL: test_atomic_store_4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 1
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  or %s35, 12, (0)1
; CHECK-NEXT:  stl %s35, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i32 12, i32* @i release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_4cst() {
; CHECK-LABEL: test_atomic_store_4cst:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  or %s35, 12, (0)1
; CHECK-NEXT:  stl %s35, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i32 12, i32* @i seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_8() {
; CHECK-LABEL: test_atomic_store_8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 1
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  or %s35, 12, (0)1
; CHECK-NEXT:  st %s35, (,%s34)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i64 12, i64* @l release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_8cst() {
; CHECK-LABEL: test_atomic_store_8cst:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  or %s35, 12, (0)1
; CHECK-NEXT:  st %s35, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i64 12, i64* @l seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_16() {
; CHECK-LABEL: t_atomic_store_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_store_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_store_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 12, (0)1
; CHECK-NEXT:  or %s2, 0, (0)1
; CHECK-NEXT:  or %s3, 3, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i128 12, i128* @it release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_16cst() {
; CHECK-LABEL: test_atomic_store_16cst:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_store_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_store_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 12, (0)1
; CHECK-NEXT:  or %s2, 0, (0)1
; CHECK-NEXT:  or %s3, 5, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i128 12, i128* @it seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_load_1() {
; CHECK-LABEL: test_atomic_load_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  ld1b.zx %s34, (,%s34)
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  sla.w.sx %s34, %s34, 24
; CHECK-NEXT:  sra.w.sx %s0, %s34, 24
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i8, i8* @c acquire, align 32
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_load_1cst() {
; CHECK-LABEL: test_atomic_load_1cst:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  ld1b.zx %s34, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s34, 24
; CHECK-NEXT:  sra.w.sx %s0, %s34, 24
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i8, i8* @c seq_cst, align 32
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_load_2() {
; CHECK-LABEL: test_atomic_load_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  ld2b.zx %s34, (,%s34)
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  sla.w.sx %s34, %s34, 16
; CHECK-NEXT:  sra.w.sx %s0, %s34, 16
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i16, i16* @s acquire, align 32
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_load_2cst() {
; CHECK-LABEL: test_atomic_load_2cst:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  ld2b.zx %s34, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s34, 16
; CHECK-NEXT:  sra.w.sx %s0, %s34, 16
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i16, i16* @s seq_cst, align 32
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_load_4() {
; CHECK-LABEL: test_atomic_load_4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.zx %s0, (,%s34)
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i32, i32* @i acquire, align 32
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_load_4cst() {
; CHECK-LABEL: test_atomic_load_4cst:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.zx %s0, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i32, i32* @i seq_cst, align 32
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_load_8() {
; CHECK-LABEL: test_atomic_load_8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i64, i64* @l acquire, align 32
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_load_8cst() {
; CHECK-LABEL: test_atomic_load_8cst:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i64, i64* @l seq_cst, align 32
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_load_16() {
; CHECK-LABEL: test_atomic_load_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_load_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_load_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 2, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i128, i128* @it acquire, align 32
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_load_16cst() {
; CHECK-LABEL: test_atomic_load_16cst:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_load_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_load_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 5, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = load atomic i128, i128* @it seq_cst, align 32
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_exchange_1() {
; CHECK-LABEL: test_atomic_exchange_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  or %s35, 10, (0)1
; CHECK-NEXT:  ts1am.w %s35, (%s34), 1
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s35, 24
; CHECK-NEXT:  sra.w.sx %s0, %s34, 24
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xchg i8* @c, i8 10 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_exchange_2() {
; CHECK-LABEL: test_atomic_exchange_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  lea %s35, 28672
; CHECK-NEXT:  ts1am.w %s35, (%s34), 3
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s35, 16
; CHECK-NEXT:  sra.w.sx %s0, %s34, 16
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xchg i16* @s, i16 28672 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_exchange_4() {
; CHECK-LABEL: test_atomic_exchange_4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  lea %s0, 1886417008
; CHECK-NEXT:  ts1am.w %s0, (%s34), 15
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xchg i32* @i, i32 1886417008 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_exchange_8() {
; CHECK-LABEL: test_atomic_exchange_8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  lea %s35, 1886417008
; CHECK-NEXT:  and %s35, %s35, (32)0
; CHECK-NEXT:  lea.sl %s0, 1886417008(%s35)
; CHECK-NEXT:  ts1am.l %s0, (%s34), 127
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xchg i64* @l, i64 8102099357864587376 acquire
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_exchange_16() {
; CHECK-LABEL: test_atomic_exchange_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_exchange_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_exchange_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  lea %s34, 1886417008
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s1, 1886417008(%s34)
; CHECK-NEXT:  or %s2, 0, (0)1
; CHECK-NEXT:  or %s3, 2, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xchg i128* @it, i128 8102099357864587376 acquire
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_compare_exchange_1(i8, i8) {
; CHECK-LABEL: test_atomic_compare_exchange_1:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  and %s34, -4, %s34
; CHECK-NEXT:  ldl.sx %s38, (,%s34)
; CHECK-NEXT:  and %s35, %s1, (56)0
; CHECK-NEXT:  and %s36, %s0, (56)0
; CHECK-NEXT:  lea %s37, -256
; CHECK-NEXT:  and %s41, %s38, %s37
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s38, %s41, %s35
; CHECK-NEXT:  or %s39, %s41, %s36
; CHECK-NEXT:  cas.w %s38, (%s34), %s39
; CHECK-NEXT:  breq.w %s38, %s39, .LBB{{[0-9]+}}_3
; CHECK-NEXT:  # %partword.cmpxchg.failure
; CHECK-NEXT:  #   in Loop: Header=BB25_1 Depth=1
; CHECK-NEXT:  or %s40, 0, %s41
; CHECK-NEXT:  and %s41, %s38, %s37
; CHECK-NEXT:  brne.w %s40, %s41, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  cmps.w.sx %s34, %s38, %s39
; CHECK-NEXT:  cmov.w.eq %s0, (63)0, %s34
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg i8* @c, i8 %0, i8 %1 seq_cst seq_cst
  %3 = extractvalue { i8, i1 } %2, 1
  %frombool = zext i1 %3 to i8
  ret i8 %frombool
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_compare_exchange_2(i16, i16) {
; CHECK-LABEL: test_atomic_compare_exchange_2:
; CHECK:       .LBB{{[0-9]+}}_5:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  and %s34, -4, %s34
; CHECK-NEXT:  or %s35, 2, %s34
; FIXME: following ld2b.zx should be ldl.sx...
; CHECK-NEXT:  ld2b.zx %s37, (,%s35)
; CHECK-NEXT:  and %s35, %s1, (48)0
; CHECK-NEXT:  and %s36, %s0, (48)0
; CHECK-NEXT:  sla.w.sx %s41, %s37, 16
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  lea %s39, -65536
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s37, %s41, %s35
; CHECK-NEXT:  or %s38, %s41, %s36
; CHECK-NEXT:  cas.w %s37, (%s34), %s38
; CHECK-NEXT:  breq.w %s37, %s38, .LBB26_3
; CHECK-NEXT:  # %partword.cmpxchg.failure
; CHECK-NEXT:  #   in Loop: Header=BB{{[0-9]+}}_1 Depth=1
; CHECK-NEXT:  or %s40, 0, %s41
; CHECK-NEXT:  and %s41, %s37, %s39
; CHECK-NEXT:  brne.w %s40, %s41, .LBB26_1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  cmps.w.sx %s34, %s37, %s38
; CHECK-NEXT:  cmov.w.eq %s0, (63)0, %s34
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg i16* @s, i16 %0, i16 %1 seq_cst seq_cst
  %3 = extractvalue { i16, i1 } %2, 1
  %conv = zext i1 %3 to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_compare_exchange_4(i32, i32) {
; CHECK-LABEL: test_atomic_compare_exchange_4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  cas.w %s1, (%s34), %s0
; CHECK-NEXT:  cmps.w.sx %s34, %s1, %s0
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s0, 0, (0)1
; CHECK-NEXT:  cmov.w.eq %s0, (63)0, %s34
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg i32* @i, i32 %0, i32 %1 seq_cst seq_cst
  %3 = extractvalue { i32, i1 } %2, 1
  %conv = zext i1 %3 to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry: %2 = cmpxchg i64* @l, i64 %0, i64 %1 seq_cst seq_cst
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_compare_exchange_16(i128, i128) {
; CHECK-LABEL: test_atomic_compare_exchange_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  st %s1, -8(,%s9)
; CHECK-NEXT:  st %s0, -16(,%s9)
; CHECK-NEXT:  lea %s34, __atomic_compare_exchange_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_compare_exchange_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  lea %s1,-16(,%s9)
; CHECK-NEXT:  or %s4, 5, (0)1
; CHECK-NEXT:  or %s5, 0, %s4
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:  or %s1, 0, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg i128* @it, i128 %0, i128 %1 seq_cst seq_cst
  %3 = extractvalue { i128, i1 } %2, 1
  %conv = zext i1 %3 to i128
  ret i128 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_relaxed(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_relaxed:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 monotonic monotonic
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_consume(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_consume:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 acquire acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_acquire(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_acquire:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 acquire acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_release(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_release:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 1
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 release monotonic
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_acq_rel(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_acq_rel:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 1
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 acq_rel acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 seq_cst seq_cst
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_relaxed(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_relaxed:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 monotonic monotonic
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_consume(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_consume:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 acquire acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_acquire(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_acquire:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 acquire acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_release(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_release:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 1
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 release monotonic
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_acq_rel(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_acq_rel:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 1
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  cas.l %s1, (%s34), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 acq_rel acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define void @test_atomic_fence_relaxed() {
; CHECK-LABEL: test_atomic_fence_relaxed:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_consume() {
; CHECK-LABEL: test_atomic_fence_consume:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  fence acquire
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_acquire() {
; CHECK-LABEL: test_atomic_fence_acquire:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 2
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  fence acquire
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_release() {
; CHECK-LABEL: test_atomic_fence_release:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  fence release
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_acq_rel() {
; CHECK-LABEL: test_atomic_fence_acq_rel:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  fence acq_rel
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_seq_cst() {
; CHECK-LABEL: test_atomic_fence_seq_cst:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  fence seq_cst
  ret void
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_add_1() {
; CHECK-LABEL: test_atomic_fetch_add_1:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  and %s34, -4, %s34
; CHECK-NEXT:  ldl.sx %s36, (,%s34)
; CHECK-NEXT:  lea %s35, -256
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s37, 0, %s36
; CHECK-NEXT:  lea %s36, 1(%s36)
; CHECK-NEXT:  and %s36, %s36, (56)0
; CHECK-NEXT:  and %s38, %s37, %s35
; CHECK-NEXT:  or %s36, %s38, %s36
; CHECK-NEXT:  cas.w %s36, (%s34), %s37
; CHECK-NEXT:  brne.w %s36, %s37, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s36, 24
; CHECK-NEXT:  sra.w.sx %s0, %s34, 24
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw add i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_add_2() {
; CHECK-LABEL: test_atomic_fetch_add_2:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  and %s34, -4, %s34
; CHECK-NEXT:  ldl.sx %s36, (,%s34)
; CHECK-NEXT:  lea %s35, -65536
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s37, 0, %s36
; CHECK-NEXT:  lea %s36, 1(%s36)
; CHECK-NEXT:  and %s36, %s36, (48)0
; CHECK-NEXT:  and %s38, %s37, %s35
; CHECK-NEXT:  or %s36, %s38, %s36
; CHECK-NEXT:  cas.w %s36, (%s34), %s37
; CHECK-NEXT:  brne.w %s36, %s37, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s36, 16
; CHECK-NEXT:  sra.w.sx %s0, %s34, 16
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw add i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_add_4() {
; CHECK-LABEL: test_atomic_fetch_add_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  lea %s0, 1(%s0)
; CHECK-NEXT:  cas.w %s0, (%s34), %s35
; CHECK-NEXT:  brne.w %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw add i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_add_8() {
; CHECK-LABEL: test_atomic_fetch_add_8:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  lea %s0, 1(%s0)
; CHECK-NEXT:  cas.l %s0, (%s34), %s35
; CHECK-NEXT:  brne.l %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw add i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_add_16() {
; CHECK-LABEL: test_atomic_fetch_add_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_fetch_add_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_fetch_add_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 1, (0)1
; CHECK-NEXT:  or %s2, 0, (0)1
; CHECK-NEXT:  or %s3, 5, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw add i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_sub_1() {
; CHECK-LABEL: test_atomic_fetch_sub_1:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  and %s34, -4, %s34
; CHECK-NEXT:  ldl.sx %s36, (,%s34)
; CHECK-NEXT:  lea %s35, -256
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s37, 0, %s36
; CHECK-NEXT:  lea %s36, -1(%s36)
; CHECK-NEXT:  and %s36, %s36, (56)0
; CHECK-NEXT:  and %s38, %s37, %s35
; CHECK-NEXT:  or %s36, %s38, %s36
; CHECK-NEXT:  cas.w %s36, (%s34), %s37
; CHECK-NEXT:  brne.w %s36, %s37, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s36, 24
; CHECK-NEXT:  sra.w.sx %s0, %s34, 24
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw sub i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_sub_2() {
; CHECK-LABEL: test_atomic_fetch_sub_2:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  and %s34, -4, %s34
; CHECK-NEXT:  ldl.sx %s36, (,%s34)
; CHECK-NEXT:  lea %s35, -65536
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s37, 0, %s36
; CHECK-NEXT:  lea %s36, -1(%s36)
; CHECK-NEXT:  and %s36, %s36, (48)0
; CHECK-NEXT:  and %s38, %s37, %s35
; CHECK-NEXT:  or %s36, %s38, %s36
; CHECK-NEXT:  cas.w %s36, (%s34), %s37
; CHECK-NEXT:  brne.w %s36, %s37, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s36, 16
; CHECK-NEXT:  sra.w.sx %s0, %s34, 16
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw sub i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_sub_4() {
; CHECK-LABEL: test_atomic_fetch_sub_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  lea %s0, -1(%s0)
; CHECK-NEXT:  cas.w %s0, (%s34), %s35
; CHECK-NEXT:  brne.w %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw sub i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_sub_8() {
; CHECK-LABEL: test_atomic_fetch_sub_8:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  lea %s0, -1(%s0)
; CHECK-NEXT:  cas.l %s0, (%s34), %s35
; CHECK-NEXT:  brne.l %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw sub i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_sub_16() {
; CHECK-LABEL: test_atomic_fetch_sub_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_fetch_sub_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_fetch_sub_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 1, (0)1
; CHECK-NEXT:  or %s2, 0, (0)1
; CHECK-NEXT:  or %s3, 5, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw sub i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_and_1() {
; CHECK-LABEL: test_atomic_fetch_and_1:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  and %s35, -4, %s34
; CHECK-NEXT:  ldl.sx %s34, (,%s35)
; CHECK-NEXT:  lea %s36, -255
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s37, 0, %s34
; CHECK-NEXT:  and %s34, %s34, %s36
; CHECK-NEXT:  cas.w %s34, (%s35), %s37
; CHECK-NEXT:  brne.w %s34, %s37, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s34, 24
; CHECK-NEXT:  sra.w.sx %s0, %s34, 24
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw and i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_and_2() {
; CHECK-LABEL: test_atomic_fetch_and_2:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  and %s35, -4, %s34
; CHECK-NEXT:  ldl.sx %s34, (,%s35)
; CHECK-NEXT:  lea %s36, -65535
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s37, 0, %s34
; CHECK-NEXT:  and %s34, %s34, %s36
; CHECK-NEXT:  cas.w %s34, (%s35), %s37
; CHECK-NEXT:  brne.w %s34, %s37, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s34, 16
; CHECK-NEXT:  sra.w.sx %s0, %s34, 16
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw and i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_and_4() {
; CHECK-LABEL: test_atomic_fetch_and_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  and %s0, 1, %s0
; CHECK-NEXT:  cas.w %s0, (%s34), %s35
; CHECK-NEXT:  brne.w %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw and i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_and_8() {
; CHECK-LABEL: test_atomic_fetch_and_8:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  and %s0, 1, %s0
; CHECK-NEXT:  cas.l %s0, (%s34), %s35
; CHECK-NEXT:  brne.l %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw and i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_and_16() {
; CHECK-LABEL: test_atomic_fetch_and_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_fetch_and_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_fetch_and_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 1, (0)1
; CHECK-NEXT:  or %s2, 0, (0)1
; CHECK-NEXT:  or %s3, 5, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw and i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_or_1() {
; CHECK-LABEL: test_atomic_fetch_or_1:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  and %s35, -4, %s34
; CHECK-NEXT:  ldl.sx %s34, (,%s35)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s36, 0, %s34
; CHECK-NEXT:  or %s34, 1, %s34
; CHECK-NEXT:  cas.w %s34, (%s35), %s36
; CHECK-NEXT:  brne.w %s34, %s36, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s34, 24
; CHECK-NEXT:  sra.w.sx %s0, %s34, 24
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw or i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_or_2() {
; CHECK-LABEL: test_atomic_fetch_or_2:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  and %s35, -4, %s34
; CHECK-NEXT:  ldl.sx %s34, (,%s35)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s36, 0, %s34
; CHECK-NEXT:  or %s34, 1, %s34
; CHECK-NEXT:  cas.w %s34, (%s35), %s36
; CHECK-NEXT:  brne.w %s34, %s36, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s34, 16
; CHECK-NEXT:  sra.w.sx %s0, %s34, 16
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw or i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_or_4() {
; CHECK-LABEL: test_atomic_fetch_or_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  or %s0, 1, %s0
; CHECK-NEXT:  cas.w %s0, (%s34), %s35
; CHECK-NEXT:  brne.w %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw or i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_or_8() {
; CHECK-LABEL: test_atomic_fetch_or_8:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  or %s0, 1, %s0
; CHECK-NEXT:  cas.l %s0, (%s34), %s35
; CHECK-NEXT:  brne.l %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw or i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_or_16() {
; CHECK-LABEL: test_atomic_fetch_or_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_fetch_or_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_fetch_or_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 1, (0)1
; CHECK-NEXT:  or %s2, 0, (0)1
; CHECK-NEXT:  or %s3, 5, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw or i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_xor_1() {
; CHECK-LABEL: test_atomic_fetch_xor_1:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  and %s35, -4, %s34
; CHECK-NEXT:  ldl.sx %s34, (,%s35)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s36, 0, %s34
; CHECK-NEXT:  xor %s34, 1, %s34
; CHECK-NEXT:  cas.w %s34, (%s35), %s36
; CHECK-NEXT:  brne.w %s34, %s36, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s34, 24
; CHECK-NEXT:  sra.w.sx %s0, %s34, 24
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xor i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_xor_2() {
; CHECK-LABEL: test_atomic_fetch_xor_2:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  and %s35, -4, %s34
; CHECK-NEXT:  ldl.sx %s34, (,%s35)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s36, 0, %s34
; CHECK-NEXT:  xor %s34, 1, %s34
; CHECK-NEXT:  cas.w %s34, (%s35), %s36
; CHECK-NEXT:  brne.w %s34, %s36, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s34, 16
; CHECK-NEXT:  sra.w.sx %s0, %s34, 16
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xor i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_xor_4() {
; CHECK-LABEL: test_atomic_fetch_xor_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  xor %s0, 1, %s0
; CHECK-NEXT:  cas.w %s0, (%s34), %s35
; CHECK-NEXT:  brne.w %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xor i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_xor_8() {
; CHECK-LABEL: test_atomic_fetch_xor_8:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  xor %s0, 1, %s0
; CHECK-NEXT:  cas.l %s0, (%s34), %s35
; CHECK-NEXT:  brne.l %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xor i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_xor_16() {
; CHECK-LABEL: test_atomic_fetch_xor_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_fetch_xor_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_fetch_xor_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 1, (0)1
; CHECK-NEXT:  or %s2, 0, (0)1
; CHECK-NEXT:  or %s3, 5, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw xor i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_nand_1() {
; CHECK-LABEL: test_atomic_fetch_nand_1:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  and %s34, -4, %s34
; CHECK-NEXT:  ldl.sx %s37, (,%s34)
; CHECK-NEXT:  lea %s35, 254
; CHECK-NEXT:  lea %s36, -256
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s38, 0, %s37
; CHECK-NEXT:  xor %s37, -1, %s37
; CHECK-NEXT:  or %s37, %s37, %s35
; CHECK-NEXT:  and %s37, %s37, (56)0
; CHECK-NEXT:  and %s39, %s38, %s36
; CHECK-NEXT:  or %s37, %s39, %s37
; CHECK-NEXT:  cas.w %s37, (%s34), %s38
; CHECK-NEXT:  brne.w %s37, %s38, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s37, 24
; CHECK-NEXT:  sra.w.sx %s0, %s34, 24
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw nand i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_nand_2() {
; CHECK-LABEL: test_atomic_fetch_nand_2:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  and %s34, -4, %s34
; CHECK-NEXT:  ldl.sx %s37, (,%s34)
; CHECK-NEXT:  lea %s35, 65534
; CHECK-NEXT:  lea %s36, -65536
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s38, 0, %s37
; CHECK-NEXT:  xor %s37, -1, %s37
; CHECK-NEXT:  or %s37, %s37, %s35
; CHECK-NEXT:  and %s37, %s37, (48)0
; CHECK-NEXT:  and %s39, %s38, %s36
; CHECK-NEXT:  or %s37, %s39, %s37
; CHECK-NEXT:  cas.w %s37, (%s34), %s38
; CHECK-NEXT:  brne.w %s37, %s38, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  sla.w.sx %s34, %s37, 16
; CHECK-NEXT:  sra.w.sx %s0, %s34, 16
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw nand i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_nand_4() {
; CHECK-LABEL: test_atomic_fetch_nand_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  xor %s36, -1, %s0
; CHECK-NEXT:  or %s0, -2, %s36
; CHECK-NEXT:  cas.w %s0, (%s34), %s35
; CHECK-NEXT:  brne.w %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw nand i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_nand_8() {
; CHECK-LABEL: test_atomic_fetch_nand_8:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  ld %s0, (,%s34)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s35, 0, %s0
; CHECK-NEXT:  xor %s36, -1, %s0
; CHECK-NEXT:  or %s0, -2, %s36
; CHECK-NEXT:  cas.l %s0, (%s34), %s35
; CHECK-NEXT:  brne.l %s0, %s35, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw nand i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_nand_16() {
; CHECK-LABEL: test_atomic_fetch_nand_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  lea %s34, __atomic_fetch_nand_16@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s12, __atomic_fetch_nand_16@hi(%s34)
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s0, it@hi(%s34)
; CHECK-NEXT:  or %s1, 1, (0)1
; CHECK-NEXT:  or %s2, 0, (0)1
; CHECK-NEXT:  or %s3, 5, (0)1
; CHECK-NEXT:  bsic %lr, (,%s12)
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw nand i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_max_4() {
; CHECK-LABEL: test_atomic_fetch_max_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  or %s35, 1, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s36, 0, %s0
; CHECK-NEXT:  maxs.w.zx %s0, %s0, %s35
; CHECK-NEXT:  cas.w %s0, (%s34), %s36
; CHECK-NEXT:  brne.w %s0, %s36, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw max i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_min_4() {
; CHECK-LABEL: test_atomic_fetch_min_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  or %s35, 1, (0)1
; CHECK-NEXT:  or %s36, 2, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s37, 0, %s0
; CHECK-NEXT:  cmps.w.sx %s38, %s0, %s36
; CHECK-NEXT:  or %s0, 0, %s35
; CHECK-NEXT:  cmov.w.lt %s0, %s37, %s38
; CHECK-NEXT:  cas.w %s0, (%s34), %s37
; CHECK-NEXT:  brne.w %s0, %s37, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw min i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_umax_4() {
; CHECK-LABEL: test_atomic_fetch_umax_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, ui@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, ui@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  or %s35, 1, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s36, 0, %s0
; CHECK-NEXT:  cmpu.w %s37, %s0, %s35
; CHECK-NEXT:  or %s0, 0, %s35
; CHECK-NEXT:  cmov.w.gt %s0, %s36, %s37
; CHECK-NEXT:  cas.w %s0, (%s34), %s36
; CHECK-NEXT:  brne.w %s0, %s36, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw umax i32* @ui, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_umin_4() {
; CHECK-LABEL: test_atomic_fetch_umin_4:
; CHECK:       .LBB{{[0-9]+}}_4:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, ui@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, ui@hi(%s34)
; CHECK-NEXT:  ldl.sx %s0, (,%s34)
; CHECK-NEXT:  or %s35, 1, (0)1
; CHECK-NEXT:  or %s36, 2, (0)1
; CHECK-NEXT:  .LBB{{[0-9]+}}_1:
; CHECK-NEXT:  # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:  or %s37, 0, %s0
; CHECK-NEXT:  cmpu.w %s38, %s0, %s36
; CHECK-NEXT:  or %s0, 0, %s35
; CHECK-NEXT:  cmov.w.lt %s0, %s37, %s38
; CHECK-NEXT:  cas.w %s0, (%s34), %s37
; CHECK-NEXT:  brne.w %s0, %s37, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %atomicrmw.end
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = atomicrmw umin i32* @ui, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_1() {
; CHECK-LABEL: test_atomic_clear_1:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, c@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, c@hi(%s34)
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  st1b %s35, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i8 0, i8* @c seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_2() {
; CHECK-LABEL: test_atomic_clear_2:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, s@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, s@hi(%s34)
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  st1b %s35, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i8 0, i8* bitcast (i16* @s to i8*) seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_4() {
; CHECK-LABEL: test_atomic_clear_4:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, i@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, i@hi(%s34)
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  st1b %s35, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i8 0, i8* bitcast (i32* @i to i8*) seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_8() {
; CHECK-LABEL: test_atomic_clear_8:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, l@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, l@hi(%s34)
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  st1b %s35, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i8 0, i8* bitcast (i64* @l to i8*) seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_16() {
; CHECK-LABEL: test_atomic_clear_16:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  lea %s34, it@lo
; CHECK-NEXT:  and %s34, %s34, (32)0
; CHECK-NEXT:  lea.sl %s34, it@hi(%s34)
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  st1b %s35, (,%s34)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  store atomic i8 0, i8* bitcast (i128* @it to i8*) seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8stk(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  cas.l %s1, 192(%s11), %s0
; CHECK-NEXT:  cmps.l %s34, %s1, %s0
; CHECK-NEXT:  or %s35, 0, (0)1
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  cmov.l.eq %s35, (63)0, %s34
; CHECK-NEXT:  adds.w.zx %s0, %s35, (0)1
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %2 = alloca i64, align 32
  %3 = cmpxchg i64* %2, i64 %0, i64 %1 seq_cst seq_cst
  %4 = extractvalue { i64, i1 } %3, 1
  %conv = zext i1 %4 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_8stk() {
; CHECK-LABEL: test_atomic_clear_8stk:
; CHECK:       .LBB{{[0-9]+}}_2:
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s34, 0, (0)1
; CHECK-NEXT:  st1b %s34, 192(,%s11)
; CHECK-NEXT:  fencem 3
; CHECK-NEXT:  or %s11, 0, %s9
entry:
  %0 = alloca i64, align 32
  %1 = bitcast i64* %0 to i8*
  store atomic i8 0, i8* %1 seq_cst, align 32
  ret void
}
