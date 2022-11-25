; RUN: llc < %s -mtriple=ve-unknown-unknown | FileCheck %s

%struct.sci = type <{ i8, i32 }>
%struct.scl = type <{ i8, i64 }>
%struct.sil = type <{ i32, i64 }>
%struct.siiii = type { i8, i8, i8, i8 }

@c = common global i8 0, align 1
@s = common global i16 0, align 1
@i = common global i32 0, align 1
@l = common global i64 0, align 1
@it= common global i128 0, align 1
@ui = common global i32 0, align 1
@sci1 = common global %struct.sci <{ i8 0, i32 0 }>, align 1
@scl1 = common global %struct.scl <{ i8 0, i64 0 }>, align 1
@sil1 = common global %struct.sil <{ i32 0, i64 0 }>, align 1
@siiii1 = common global %struct.siiii { i8 0, i8 0, i8 0, i8 0 }, align 1

; Function Attrs: norecurse nounwind
define void @test_atomic_store_1() {
; CHECK-LABEL: test_atomic_store_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 1
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i8 12, i8* @c release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_1seq() {
; CHECK-LABEL: test_atomic_store_1seq:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i8 12, i8* @c seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_2() {
; CHECK-LABEL: test_atomic_store_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 1
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    st2b %s1, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i16 12, i16* @s release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_2seq() {
; CHECK-LABEL: test_atomic_store_2seq:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    st2b %s1, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i16 12, i16* @s seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_4() {
; CHECK-LABEL: test_atomic_store_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 1
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, i@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    stl %s1, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i32 12, i32* @i release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_4cst() {
; CHECK-LABEL: test_atomic_store_4cst:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, i@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    stl %s1, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i32 12, i32* @i seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_8() {
; CHECK-LABEL: test_atomic_store_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 1
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, l@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i64 12, i64* @l release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_8cst() {
; CHECK-LABEL: test_atomic_store_8cst:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, l@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    st %s1, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i64 12, i64* @l seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_16() {
; CHECK-LABEL: test_atomic_store_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_store_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_store_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s3, 3, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  store atomic i128 12, i128* @it release, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_store_16cst() {
; CHECK-LABEL: test_atomic_store_16cst:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_store_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_store_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 12, (0)1
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s3, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  store atomic i128 12, i128* @it seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_load_1() {
; CHECK-LABEL: test_atomic_load_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    ld1b.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = load atomic i8, i8* @c acquire, align 32
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_load_1cst() {
; CHECK-LABEL: test_atomic_load_1cst:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    ld1b.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = load atomic i8, i8* @c seq_cst, align 32
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_load_2() {
; CHECK-LABEL: test_atomic_load_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    ld2b.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = load atomic i16, i16* @s acquire, align 32
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_load_2cst() {
; CHECK-LABEL: test_atomic_load_2cst:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    ld2b.sx %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = load atomic i16, i16* @s seq_cst, align 32
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_load_4() {
; CHECK-LABEL: test_atomic_load_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, i@hi(, %s0)
; CHECK-NEXT:    ldl.zx %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = load atomic i32, i32* @i acquire, align 32
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_load_4cst() {
; CHECK-LABEL: test_atomic_load_4cst:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, i@hi(, %s0)
; CHECK-NEXT:    ldl.zx %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = load atomic i32, i32* @i seq_cst, align 32
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_load_8() {
; CHECK-LABEL: test_atomic_load_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, l@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = load atomic i64, i64* @l acquire, align 32
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_load_8cst() {
; CHECK-LABEL: test_atomic_load_8cst:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, l@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = load atomic i64, i64* @l seq_cst, align 32
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_load_16() {
; CHECK-LABEL: test_atomic_load_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_load_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = load atomic i128, i128* @it acquire, align 32
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_load_16cst() {
; CHECK-LABEL: test_atomic_load_16cst:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_load_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_load_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = load atomic i128, i128* @it seq_cst, align 32
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_exchange_1() {
; CHECK-LABEL: test_atomic_exchange_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    and %s1, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s1, 3
; CHECK-NEXT:    or %s3, 10, (0)1
; CHECK-NEXT:    sla.w.sx %s3, %s3, %s2
; CHECK-NEXT:    and %s0, -4, %s0
; CHECK-NEXT:    sla.w.sx %s1, (63)0, %s1
; CHECK-NEXT:    ts1am.w %s3, (%s0), %s1
; CHECK-NEXT:    and %s0, %s3, (32)0
; CHECK-NEXT:    srl %s0, %s0, %s2
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i8* @c, i8 10 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_exchange_1_0() {
; CHECK-LABEL: test_atomic_exchange_1_0:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, siiii1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, siiii1@hi(, %s0)
; CHECK-NEXT:    and %s1, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s1, 3
; CHECK-NEXT:    or %s3, 14, (0)1
; CHECK-NEXT:    sla.w.sx %s3, %s3, %s2
; CHECK-NEXT:    and %s0, -4, %s0
; CHECK-NEXT:    sla.w.sx %s1, (63)0, %s1
; CHECK-NEXT:    ts1am.w %s3, (%s0), %s1
; CHECK-NEXT:    and %s0, %s3, (32)0
; CHECK-NEXT:    srl %s0, %s0, %s2
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i8* getelementptr inbounds (%struct.siiii, %struct.siiii* @siiii1, i32 0, i32 0), i8 14 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_exchange_1_1() {
; CHECK-LABEL: test_atomic_exchange_1_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, siiii1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, siiii1@hi(1, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    and %s0, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, (63)0, %s0
; CHECK-NEXT:    sla.w.sx %s0, %s0, 3
; CHECK-NEXT:    sla.w.sx %s3, (60)0, %s0
; CHECK-NEXT:    ts1am.w %s3, (%s1), %s2
; CHECK-NEXT:    and %s1, %s3, (32)0
; CHECK-NEXT:    srl %s0, %s1, %s0
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i8* getelementptr inbounds (%struct.siiii, %struct.siiii* @siiii1, i32 0, i32 1), i8 15 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_exchange_1_2() {
; CHECK-LABEL: test_atomic_exchange_1_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, siiii1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, siiii1@hi(2, %s0)
; CHECK-NEXT:    and %s1, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s1, 3
; CHECK-NEXT:    lea %s3, -86
; CHECK-NEXT:    sla.w.sx %s3, %s3, %s2
; CHECK-NEXT:    and %s0, -4, %s0
; CHECK-NEXT:    sla.w.sx %s1, (63)0, %s1
; CHECK-NEXT:    ts1am.w %s3, (%s0), %s1
; CHECK-NEXT:    and %s0, %s3, (32)0
; CHECK-NEXT:    srl %s0, %s0, %s2
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i8* getelementptr inbounds (%struct.siiii, %struct.siiii* @siiii1, i32 0, i32 2), i8 170 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_exchange_1_3() {
; CHECK-LABEL: test_atomic_exchange_1_3:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, siiii1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, siiii1@hi(3, %s0)
; CHECK-NEXT:    and %s1, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s1, 3
; CHECK-NEXT:    lea %s3, -69
; CHECK-NEXT:    sla.w.sx %s3, %s3, %s2
; CHECK-NEXT:    and %s0, -4, %s0
; CHECK-NEXT:    sla.w.sx %s1, (63)0, %s1
; CHECK-NEXT:    ts1am.w %s3, (%s0), %s1
; CHECK-NEXT:    and %s0, %s3, (32)0
; CHECK-NEXT:    srl %s0, %s0, %s2
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i8* getelementptr inbounds (%struct.siiii, %struct.siiii* @siiii1, i32 0, i32 3), i8 187 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_exchange_2() {
; CHECK-LABEL: test_atomic_exchange_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    and %s1, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s1, 3
; CHECK-NEXT:    lea %s3, 28672
; CHECK-NEXT:    sla.w.sx %s3, %s3, %s2
; CHECK-NEXT:    and %s0, -4, %s0
; CHECK-NEXT:    sla.w.sx %s1, (62)0, %s1
; CHECK-NEXT:    ts1am.w %s3, (%s0), %s1
; CHECK-NEXT:    and %s0, %s3, (32)0
; CHECK-NEXT:    srl %s0, %s0, %s2
; CHECK-NEXT:    sll %s0, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s0, 48
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i16* @s, i16 28672 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_exchange_4() {
; CHECK-LABEL: test_atomic_exchange_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, i@hi(, %s0)
; CHECK-NEXT:    lea %s0, 1886417008
; CHECK-NEXT:    ts1am.w %s0, (%s1), 15
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i32* @i, i32 1886417008 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
; FIXME: Bus Error occurred due to unaligned ts1am instruction
define i32 @test_atomic_exchange_4_align1() {
; CHECK-LABEL: test_atomic_exchange_4_align1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, sci1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, sci1@hi(, %s0)
; CHECK-NEXT:    lea %s0, 1886417008
; CHECK-NEXT:    ts1am.w %s0, 1(%s1), 15
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i32* getelementptr inbounds (%struct.sci, %struct.sci* @sci1, i32 0, i32 1), i32 1886417008 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_exchange_8() {
; CHECK-LABEL: test_atomic_exchange_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, l@hi(, %s0)
; CHECK-NEXT:    lea %s2, 255
; CHECK-NEXT:    lea %s0, 1886417008
; CHECK-NEXT:    lea.sl %s0, 1886417008(, %s0)
; CHECK-NEXT:    ts1am.l %s0, (%s1), %s2
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i64* @l, i64 8102099357864587376 acquire
  ret i64 %0
}

; Function Attrs: norecurse nounwind
; FIXME: Bus Error occurred due to unaligned ts1am instruction
define i64 @test_atomic_exchange_8_align1() {
; CHECK-LABEL: test_atomic_exchange_8_align1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, scl1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, scl1@hi(, %s0)
; CHECK-NEXT:    lea %s2, 255
; CHECK-NEXT:    lea %s0, 1886417008
; CHECK-NEXT:    lea.sl %s0, 1886417008(, %s0)
; CHECK-NEXT:    ts1am.l %s0, 1(%s1), %s2
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i64* getelementptr inbounds (%struct.scl, %struct.scl* @scl1, i32 0, i32 1), i64 8102099357864587376 acquire
  ret i64 %0
}

; Function Attrs: norecurse nounwind
; FIXME: Bus Error occurred due to unaligned ts1am instruction
define i64 @test_atomic_exchange_8_align4() {
; CHECK-LABEL: test_atomic_exchange_8_align4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s0, sil1@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, sil1@hi(, %s0)
; CHECK-NEXT:    lea %s2, 255
; CHECK-NEXT:    lea %s0, 1886417008
; CHECK-NEXT:    lea.sl %s0, 1886417008(, %s0)
; CHECK-NEXT:    ts1am.l %s0, 4(%s1), %s2
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xchg i64* getelementptr inbounds (%struct.sil, %struct.sil* @sil1, i32 0, i32 1), i64 8102099357864587376 acquire
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_exchange_16() {
; CHECK-LABEL: test_atomic_exchange_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_exchange_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_exchange_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    lea %s1, 1886417008
; CHECK-NEXT:    lea.sl %s1, 1886417008(, %s1)
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s3, 2, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = atomicrmw xchg i128* @it, i128 8102099357864587376 acquire
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_compare_exchange_1(i8, i8) {
; CHECK-LABEL: test_atomic_compare_exchange_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s2, c@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s4, c@hi(, %s2)
; CHECK-NEXT:    and %s3, -4, %s4
; CHECK-NEXT:    and %s1, %s1, (56)0
; CHECK-NEXT:    and %s4, 3, %s4
; CHECK-NEXT:    sla.w.sx %s4, %s4, 3
; CHECK-NEXT:    sla.w.sx %s1, %s1, %s4
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    and %s0, %s0, (56)0
; CHECK-NEXT:    sla.w.sx %s0, %s0, %s4
; CHECK-NEXT:    sla.w.sx %s4, (56)0, %s4
; CHECK-NEXT:    nnd %s4, %s4, %s5
; CHECK-NEXT:    and %s7, %s4, (32)0
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %partword.cmpxchg.loop
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s5, 0, %s7
; CHECK-NEXT:    or %s4, %s5, %s1
; CHECK-NEXT:    or %s6, %s5, %s0
; CHECK-NEXT:    cas.w %s4, (%s3), %s6
; CHECK-NEXT:    breq.w %s4, %s6, .LBB{{[0-9]+}}_3
; CHECK-NEXT:  # %bb.2: # %partword.cmpxchg.failure
; CHECK-NEXT:    # in Loop: Header=BB32_1 Depth=1
; CHECK-NEXT:    lea.sl %s7, c@hi(, %s2)
; CHECK-NEXT:    and %s7, 3, %s7
; CHECK-NEXT:    sla.w.sx %s7, %s7, 3
; CHECK-NEXT:    sla.w.sx %s7, (56)0, %s7
; CHECK-NEXT:    nnd %s7, %s7, %s4
; CHECK-NEXT:    brne.w %s5, %s7, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %partword.cmpxchg.end
; CHECK-NEXT:    cmpu.w %s0, %s4, %s6
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i8* @c, i8 %0, i8 %1 seq_cst seq_cst
  %3 = extractvalue { i8, i1 } %2, 1
  %frombool = zext i1 %3 to i8
  ret i8 %frombool
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_compare_exchange_2(i16, i16) {
; CHECK-LABEL: test_atomic_compare_exchange_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s2, s@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s4, s@hi(, %s2)
; CHECK-NEXT:    and %s3, -4, %s4
; CHECK-NEXT:    and %s1, %s1, (48)0
; CHECK-NEXT:    and %s4, 3, %s4
; CHECK-NEXT:    sla.w.sx %s4, %s4, 3
; CHECK-NEXT:    sla.w.sx %s1, %s1, %s4
; CHECK-NEXT:    ldl.sx %s5, (, %s3)
; CHECK-NEXT:    and %s0, %s0, (48)0
; CHECK-NEXT:    sla.w.sx %s0, %s0, %s4
; CHECK-NEXT:    sla.w.sx %s4, (48)0, %s4
; CHECK-NEXT:    nnd %s4, %s4, %s5
; CHECK-NEXT:    and %s7, %s4, (32)0
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %partword.cmpxchg.loop
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s5, 0, %s7
; CHECK-NEXT:    or %s4, %s5, %s1
; CHECK-NEXT:    or %s6, %s5, %s0
; CHECK-NEXT:    cas.w %s4, (%s3), %s6
; CHECK-NEXT:    breq.w %s4, %s6, .LBB{{[0-9]+}}_3
; CHECK-NEXT:  # %bb.2: # %partword.cmpxchg.failure
; CHECK-NEXT:    # in Loop: Header=BB33_1 Depth=1
; CHECK-NEXT:    lea.sl %s7, s@hi(, %s2)
; CHECK-NEXT:    and %s7, 3, %s7
; CHECK-NEXT:    sla.w.sx %s7, %s7, 3
; CHECK-NEXT:    sla.w.sx %s7, (48)0, %s7
; CHECK-NEXT:    nnd %s7, %s7, %s4
; CHECK-NEXT:    brne.w %s5, %s7, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  .LBB{{[0-9]+}}_3: # %partword.cmpxchg.end
; CHECK-NEXT:    cmpu.w %s0, %s4, %s6
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i16* @s, i16 %0, i16 %1 seq_cst seq_cst
  %3 = extractvalue { i16, i1 } %2, 1
  %conv = zext i1 %3 to i16
  ret i16 %conv
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_compare_exchange_4(i32, i32) {
; CHECK-LABEL: test_atomic_compare_exchange_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s2, i@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, i@hi(, %s2)
; CHECK-NEXT:    cas.w %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i32* @i, i32 %0, i32 %1 seq_cst seq_cst
  %3 = extractvalue { i32, i1 } %2, 1
  %conv = zext i1 %3 to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind
; FIXME: Bus Error occurred due to unaligned cas instruction
define i32 @test_atomic_compare_exchange_4_align1(i32, i32) {
; CHECK-LABEL: test_atomic_compare_exchange_4_align1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s2, sci1@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, sci1@hi(, %s2)
; CHECK-NEXT:    cas.w %s1, 1(%s2), %s0
; CHECK-NEXT:    cmpu.w %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i32* getelementptr inbounds (%struct.sci, %struct.sci* @sci1, i32 0, i32 1), i32 %0, i32 %1 seq_cst seq_cst
  %3 = extractvalue { i32, i1 } %2, 1
  %conv = zext i1 %3 to i32
  ret i32 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry: %2 = cmpxchg i64* @l, i64 %0, i64 %1 seq_cst seq_cst
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
; FIXME: Bus Error occurred due to unaligned cas instruction
define i64 @test_atomic_compare_exchange_8_align1(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_align1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s2, scl1@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, scl1@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, 1(%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i64* getelementptr inbounds (%struct.scl, %struct.scl* @scl1, i32 0, i32 1), i64 %0, i64 %1 seq_cst seq_cst
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
; FIXME: Bus Error occurred due to unaligned cas instruction
define i64 @test_atomic_compare_exchange_8_align4(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_align4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s2, sil1@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, sil1@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, 4(%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i64* getelementptr inbounds (%struct.sil, %struct.sil* @sil1, i32 0, i32 1), i64 %0, i64 %1 seq_cst seq_cst
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_compare_exchange_16(i128, i128) {
; CHECK-LABEL: test_atomic_compare_exchange_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    st %s1, -8(, %s9)
; CHECK-NEXT:    st %s0, -16(, %s9)
; CHECK-NEXT:    lea %s0, __atomic_compare_exchange_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_compare_exchange_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    lea %s1, -16(, %s9)
; CHECK-NEXT:    or %s4, 5, (0)1
; CHECK-NEXT:    or %s5, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %2 = cmpxchg i128* @it, i128 %0, i128 %1 seq_cst seq_cst
  %3 = extractvalue { i128, i1 } %2, 1
  %conv = zext i1 %3 to i128
  ret i128 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_relaxed(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_relaxed:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 monotonic monotonic
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_consume(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_consume:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 acquire acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_acquire(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_acquire:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 acquire acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_release(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_release:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 1
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 release monotonic
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_acq_rel(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_acq_rel:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 1
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg i64* @l, i64 %0, i64 %1 acq_rel acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 seq_cst seq_cst
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_relaxed(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_relaxed:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 monotonic monotonic
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_consume(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_consume:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 acquire acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_acquire(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_acquire:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 acquire acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_release(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_release:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 1
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 release monotonic
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8_weak_acq_rel(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8_weak_acq_rel:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 1
; CHECK-NEXT:    lea %s2, l@lo
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:    lea.sl %s2, l@hi(, %s2)
; CHECK-NEXT:    cas.l %s1, (%s2), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %2 = cmpxchg weak i64* @l, i64 %0, i64 %1 acq_rel acquire
  %3 = extractvalue { i64, i1 } %2, 1
  %conv = zext i1 %3 to i64
  ret i64 %conv
}

; Function Attrs: norecurse nounwind readnone
define void @test_atomic_fence_relaxed() {
; CHECK-LABEL: test_atomic_fence_relaxed:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_consume() {
; CHECK-LABEL: test_atomic_fence_consume:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  fence acquire
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_acquire() {
; CHECK-LABEL: test_atomic_fence_acquire:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 2
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  fence acquire
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_release() {
; CHECK-LABEL: test_atomic_fence_release:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 1
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  fence release
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_acq_rel() {
; CHECK-LABEL: test_atomic_fence_acq_rel:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  fence acq_rel
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_fence_seq_cst() {
; CHECK-LABEL: test_atomic_fence_seq_cst:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  fence seq_cst
  ret void
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_add_1() {
; CHECK-LABEL: test_atomic_fetch_add_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s4, (63)0, %s2
; CHECK-NEXT:    adds.w.sx %s4, %s3, %s4
; CHECK-NEXT:    sla.w.sx %s2, (56)0, %s2
; CHECK-NEXT:    and %s4, %s4, %s2
; CHECK-NEXT:    nnd %s2, %s2, %s3
; CHECK-NEXT:    or %s2, %s2, %s4
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, c@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, c@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw add i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_add_2() {
; CHECK-LABEL: test_atomic_fetch_add_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s4, (63)0, %s2
; CHECK-NEXT:    adds.w.sx %s4, %s3, %s4
; CHECK-NEXT:    sla.w.sx %s2, (48)0, %s2
; CHECK-NEXT:    and %s4, %s4, %s2
; CHECK-NEXT:    nnd %s2, %s2, %s3
; CHECK-NEXT:    or %s2, %s2, %s4
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, s@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, s@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s0, 48
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw add i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_add_4() {
; CHECK-LABEL: test_atomic_fetch_add_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, i@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    adds.w.sx %s0, 1, %s0
; CHECK-NEXT:    cas.w %s0, (%s1), %s2
; CHECK-NEXT:    brne.w %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw add i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_add_8() {
; CHECK-LABEL: test_atomic_fetch_add_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, l@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s0, 1(, %s0)
; CHECK-NEXT:    cas.l %s0, (%s1), %s2
; CHECK-NEXT:    brne.l %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw add i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_add_16() {
; CHECK-LABEL: test_atomic_fetch_add_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_fetch_add_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_fetch_add_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s3, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = atomicrmw add i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_sub_1() {
; CHECK-LABEL: test_atomic_fetch_sub_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s4, (63)0, %s2
; CHECK-NEXT:    subs.w.sx %s4, %s3, %s4
; CHECK-NEXT:    sla.w.sx %s2, (56)0, %s2
; CHECK-NEXT:    and %s4, %s4, %s2
; CHECK-NEXT:    nnd %s2, %s2, %s3
; CHECK-NEXT:    or %s2, %s2, %s4
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, c@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, c@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw sub i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_sub_2() {
; CHECK-LABEL: test_atomic_fetch_sub_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s4, (63)0, %s2
; CHECK-NEXT:    subs.w.sx %s4, %s3, %s4
; CHECK-NEXT:    sla.w.sx %s2, (48)0, %s2
; CHECK-NEXT:    and %s4, %s4, %s2
; CHECK-NEXT:    nnd %s2, %s2, %s3
; CHECK-NEXT:    or %s2, %s2, %s4
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, s@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, s@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s0, 48
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw sub i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_sub_4() {
; CHECK-LABEL: test_atomic_fetch_sub_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, i@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    adds.w.sx %s0, -1, %s0
; CHECK-NEXT:    cas.w %s0, (%s1), %s2
; CHECK-NEXT:    brne.w %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw sub i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_sub_8() {
; CHECK-LABEL: test_atomic_fetch_sub_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, l@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s0, -1(, %s0)
; CHECK-NEXT:    cas.l %s0, (%s1), %s2
; CHECK-NEXT:    brne.l %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw sub i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_sub_16() {
; CHECK-LABEL: test_atomic_fetch_sub_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_fetch_sub_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_fetch_sub_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s3, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = atomicrmw sub i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_and_1() {
; CHECK-LABEL: test_atomic_fetch_and_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s4, (63)0, %s2
; CHECK-NEXT:    sla.w.sx %s2, (56)0, %s2
; CHECK-NEXT:    xor %s2, -1, %s2
; CHECK-NEXT:    or %s2, %s2, %s4
; CHECK-NEXT:    and %s2, %s3, %s2
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, c@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, c@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw and i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_and_2() {
; CHECK-LABEL: test_atomic_fetch_and_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s4, (63)0, %s2
; CHECK-NEXT:    sla.w.sx %s2, (48)0, %s2
; CHECK-NEXT:    xor %s2, -1, %s2
; CHECK-NEXT:    or %s2, %s2, %s4
; CHECK-NEXT:    and %s2, %s3, %s2
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, s@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, s@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s0, 48
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw and i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_and_4() {
; CHECK-LABEL: test_atomic_fetch_and_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, i@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    and %s0, 1, %s2
; CHECK-NEXT:    cas.w %s0, (%s1), %s2
; CHECK-NEXT:    brne.w %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw and i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_and_8() {
; CHECK-LABEL: test_atomic_fetch_and_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, l@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    and %s0, 1, %s0
; CHECK-NEXT:    cas.l %s0, (%s1), %s2
; CHECK-NEXT:    brne.l %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw and i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_and_16() {
; CHECK-LABEL: test_atomic_fetch_and_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_fetch_and_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_fetch_and_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s3, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = atomicrmw and i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_or_1() {
; CHECK-LABEL: test_atomic_fetch_or_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s2, (63)0, %s2
; CHECK-NEXT:    or %s2, %s3, %s2
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, c@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, c@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw or i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_or_2() {
; CHECK-LABEL: test_atomic_fetch_or_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s2, (63)0, %s2
; CHECK-NEXT:    or %s2, %s3, %s2
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, s@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, s@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s0, 48
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw or i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_or_4() {
; CHECK-LABEL: test_atomic_fetch_or_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, i@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s0, 1, %s2
; CHECK-NEXT:    cas.w %s0, (%s1), %s2
; CHECK-NEXT:    brne.w %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw or i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_or_8() {
; CHECK-LABEL: test_atomic_fetch_or_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, l@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    or %s0, 1, %s0
; CHECK-NEXT:    cas.l %s0, (%s1), %s2
; CHECK-NEXT:    brne.l %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw or i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_or_16() {
; CHECK-LABEL: test_atomic_fetch_or_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_fetch_or_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_fetch_or_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s3, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = atomicrmw or i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_xor_1() {
; CHECK-LABEL: test_atomic_fetch_xor_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s2, (63)0, %s2
; CHECK-NEXT:    xor %s2, %s3, %s2
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, c@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, c@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xor i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_xor_2() {
; CHECK-LABEL: test_atomic_fetch_xor_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s2, (63)0, %s2
; CHECK-NEXT:    xor %s2, %s3, %s2
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, s@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, s@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s0, 48
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xor i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_xor_4() {
; CHECK-LABEL: test_atomic_fetch_xor_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, i@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    xor %s0, 1, %s2
; CHECK-NEXT:    cas.w %s0, (%s1), %s2
; CHECK-NEXT:    brne.w %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xor i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_xor_8() {
; CHECK-LABEL: test_atomic_fetch_xor_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, l@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    xor %s0, 1, %s0
; CHECK-NEXT:    cas.l %s0, (%s1), %s2
; CHECK-NEXT:    brne.l %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw xor i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_xor_16() {
; CHECK-LABEL: test_atomic_fetch_xor_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_fetch_xor_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_fetch_xor_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s3, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = atomicrmw xor i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define signext i8 @test_atomic_fetch_nand_1() {
; CHECK-LABEL: test_atomic_fetch_nand_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s4, (63)0, %s2
; CHECK-NEXT:    and %s4, %s3, %s4
; CHECK-NEXT:    sla.w.sx %s2, (56)0, %s2
; CHECK-NEXT:    nnd %s4, %s4, %s2
; CHECK-NEXT:    nnd %s2, %s2, %s3
; CHECK-NEXT:    or %s2, %s2, %s4
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, c@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, c@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 56
; CHECK-NEXT:    sra.l %s0, %s0, 56
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw nand i8* @c, i8 1 seq_cst
  ret i8 %0
}

; Function Attrs: norecurse nounwind
define signext i16 @test_atomic_fetch_nand_2() {
; CHECK-LABEL: test_atomic_fetch_nand_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    and %s1, -4, %s0
; CHECK-NEXT:    ldl.sx %s2, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    and %s2, 3, %s0
; CHECK-NEXT:    sla.w.sx %s2, %s2, 3
; CHECK-NEXT:    sla.w.sx %s4, (63)0, %s2
; CHECK-NEXT:    and %s4, %s3, %s4
; CHECK-NEXT:    sla.w.sx %s2, (48)0, %s2
; CHECK-NEXT:    nnd %s4, %s4, %s2
; CHECK-NEXT:    nnd %s2, %s2, %s3
; CHECK-NEXT:    or %s2, %s2, %s4
; CHECK-NEXT:    cas.w %s2, (%s1), %s3
; CHECK-NEXT:    brne.w %s2, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    and %s0, %s2, (32)0
; CHECK-NEXT:    lea %s1, s@lo
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    lea.sl %s1, s@hi(, %s1)
; CHECK-NEXT:    and %s1, 3, %s1
; CHECK-NEXT:    sla.w.sx %s1, %s1, 3
; CHECK-NEXT:    srl %s0, %s0, %s1
; CHECK-NEXT:    sll %s0, %s0, 48
; CHECK-NEXT:    sra.l %s0, %s0, 48
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw nand i16* @s, i16 1 seq_cst
  ret i16 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_nand_4() {
; CHECK-LABEL: test_atomic_fetch_nand_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, i@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:    lea %s2, -2
; CHECK-NEXT:    and %s2, %s2, (32)0
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s3, 0, %s0
; CHECK-NEXT:    xor %s0, -1, %s3
; CHECK-NEXT:    or %s0, %s0, %s2
; CHECK-NEXT:    cas.w %s0, (%s1), %s3
; CHECK-NEXT:    brne.w %s0, %s3, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw nand i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_fetch_nand_8() {
; CHECK-LABEL: test_atomic_fetch_nand_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, l@hi(, %s0)
; CHECK-NEXT:    ld %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    xor %s0, -1, %s0
; CHECK-NEXT:    or %s0, -2, %s0
; CHECK-NEXT:    cas.l %s0, (%s1), %s2
; CHECK-NEXT:    brne.l %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw nand i64* @l, i64 1 seq_cst
  ret i64 %0
}

; Function Attrs: norecurse nounwind
define i128 @test_atomic_fetch_nand_16() {
; CHECK-LABEL: test_atomic_fetch_nand_16:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    lea %s0, __atomic_fetch_nand_16@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s12, __atomic_fetch_nand_16@hi(, %s0)
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    or %s2, 0, (0)1
; CHECK-NEXT:    or %s3, 5, (0)1
; CHECK-NEXT:    bsic %s10, (, %s12)
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = atomicrmw nand i128* @it, i128 1 seq_cst
  ret i128 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_max_4() {
; CHECK-LABEL: test_atomic_fetch_max_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, i@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    maxs.w.sx %s0, 1, %s0
; CHECK-NEXT:    cas.w %s0, (%s1), %s2
; CHECK-NEXT:    brne.w %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw max i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_min_4() {
; CHECK-LABEL: test_atomic_fetch_min_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, i@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    mins.w.sx %s0, 1, %s0
; CHECK-NEXT:    cas.w %s0, (%s1), %s2
; CHECK-NEXT:    brne.w %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw min i32* @i, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_umax_4() {
; CHECK-LABEL: test_atomic_fetch_umax_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, ui@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, ui@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    cmpu.w %s3, %s0, (63)0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    cmov.w.le %s0, (63)0, %s3
; CHECK-NEXT:    cas.w %s0, (%s1), %s2
; CHECK-NEXT:    brne.w %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw umax i32* @ui, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define i32 @test_atomic_fetch_umin_4() {
; CHECK-LABEL: test_atomic_fetch_umin_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, ui@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s1, ui@hi(, %s0)
; CHECK-NEXT:    ldl.sx %s0, (, %s1)
; CHECK-NEXT:  .LBB{{[0-9]+}}_1: # %atomicrmw.start
; CHECK-NEXT:    # =>This Inner Loop Header: Depth=1
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    cmpu.w %s3, 2, %s0
; CHECK-NEXT:    or %s0, 0, %s2
; CHECK-NEXT:    cmov.w.le %s0, (63)0, %s3
; CHECK-NEXT:    cas.w %s0, (%s1), %s2
; CHECK-NEXT:    brne.w %s0, %s2, .LBB{{[0-9]+}}_1
; CHECK-NEXT:  # %bb.2: # %atomicrmw.end
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  %0 = atomicrmw umin i32* @ui, i32 1 seq_cst
  ret i32 %0
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_1() {
; CHECK-LABEL: test_atomic_clear_1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, c@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, c@hi(, %s0)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i8 0, i8* @c seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_2() {
; CHECK-LABEL: test_atomic_clear_2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, s@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, s@hi(, %s0)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i8 0, i8* bitcast (i16* @s to i8*) seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_4() {
; CHECK-LABEL: test_atomic_clear_4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, i@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, i@hi(, %s0)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i8 0, i8* bitcast (i32* @i to i8*) seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_8() {
; CHECK-LABEL: test_atomic_clear_8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, l@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, l@hi(, %s0)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i8 0, i8* bitcast (i64* @l to i8*) seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define void @test_atomic_clear_16() {
; CHECK-LABEL: test_atomic_clear_16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    lea %s0, it@lo
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    lea.sl %s0, it@hi(, %s0)
; CHECK-NEXT:    or %s1, 0, (0)1
; CHECK-NEXT:    st1b %s1, (, %s0)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    b.l.t (, %s10)
entry:
  store atomic i8 0, i8* bitcast (i128* @it to i8*) seq_cst, align 32
  ret void
}

; Function Attrs: norecurse nounwind
define i64 @test_atomic_compare_exchange_8stk(i64, i64) {
; CHECK-LABEL: test_atomic_compare_exchange_8stk:
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    cas.l %s1, 192(%s11), %s0
; CHECK-NEXT:    cmpu.l %s0, %s1, %s0
; CHECK-NEXT:    ldz %s0, %s0
; CHECK-NEXT:    srl %s0, %s0, 6
; CHECK-NEXT:    adds.w.zx %s0, %s0, (0)1
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    or %s11, 0, %s9
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
; CHECK:       .LBB{{[0-9]+}}_2: # %entry
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    or %s0, 0, (0)1
; CHECK-NEXT:    st1b %s0, 192(, %s11)
; CHECK-NEXT:    fencem 3
; CHECK-NEXT:    or %s11, 0, %s9
entry:
  %0 = alloca i64, align 32
  %1 = bitcast i64* %0 to i8*
  store atomic i8 0, i8* %1 seq_cst, align 32
  ret void
}
