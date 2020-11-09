; RUN: llc -O0 --march=ve %s -o=/dev/stdout | FileCheck %s

define void @test_vp_harness(<256 x i64>* %Out, <256 x i64> %i0) {
; CHECK-LABEL: test_vp_harness:
; CHECK:       # %bb.0:
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vst %v0, 8, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  store <256 x i64> %i0, <256 x i64>* %Out
  ret void
}

;;; FMUL ;;;
define fastcc double @test_reduce_fmul(<256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fmul:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vmrg %v0, 0, %v0, %vm1
; CHECK-NEXT:    lea.sl %s0, 1072693248
; CHECK-NEXT:    vfim.d %v0, %v0, %s0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call double @llvm.vp.reduce.fmul.v256f64(double 1.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

define fastcc double @test_reduce_fmul_start(double %s, <256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fmul_start:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vmrg %v0, 0, %v0, %vm1
; CHECK-NEXT:    vfim.d %v0, %v0, %s0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call double @llvm.vp.reduce.fmul.v256f64(double %s, <256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

define fastcc double @test_reduce_fmul_fast(<256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fmul_fast:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andm %vm3, %vm0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v1, (0)1, %v0
; CHECK-NEXT:    and %s1, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    # implicit-def: $sx1
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrd %v2, %s1
; CHECK-NEXT:    vseq %v0
; CHECK-NEXT:    vcmpu.l %v0, %v0, %v2
; CHECK-NEXT:    andm %vm1, %vm0, %vm0
; CHECK-NEXT:    vfmk.l.lt %vm2, %v0, %vm1
; CHECK-NEXT:    andm %vm2, %vm2, %vm3
; CHECK-NEXT:    lea.sl %s1, 1072693248
; CHECK-NEXT:    vbrd %v0, %s1
; CHECK-NEXT:    vmrg %v0, %v0, %v1, %vm2
; CHECK-NEXT:    lea %s1, -128
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    or %s1, 0, %s1
; CHECK-NEXT:    lea %s2, 128
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    lea %s1, 64
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    or %s1, 32, (0)1
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    or %s1, 16, (0)1
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    or %s1, 8, (0)1
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    or %s1, 4, (0)1
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    lvs %s1, %v0(2)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s1
; CHECK-NEXT:    lvs %s1, %v0(3)
; CHECK-NEXT:    lsv %v1(1), %s1
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    lvs %s1, %v0(1)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s1
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call fast double @llvm.vp.reduce.fmul.v256f64(double 1.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

define fastcc double @test_reduce_fmul_start_fast(double %s, <256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fmul_start_fast:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andm %vm3, %vm0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v1, (0)1, %v0
; CHECK-NEXT:    and %s2, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    adds.w.sx %s1, %s1, (0)1
; CHECK-NEXT:    # implicit-def: $sx2
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    lea %s1, 256
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vbrd %v2, %s2
; CHECK-NEXT:    vseq %v0
; CHECK-NEXT:    vcmpu.l %v0, %v0, %v2
; CHECK-NEXT:    andm %vm1, %vm0, %vm0
; CHECK-NEXT:    vfmk.l.lt %vm2, %v0, %vm1
; CHECK-NEXT:    andm %vm2, %vm2, %vm3
; CHECK-NEXT:    lea.sl %s2, 1072693248
; CHECK-NEXT:    vbrd %v0, %s2
; CHECK-NEXT:    vmrg %v0, %v0, %v1, %vm2
; CHECK-NEXT:    lea %s2, -128
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    or %s2, 0, %s2
; CHECK-NEXT:    lea %s3, 128
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 killed $sx3
; CHECK-NEXT:    lvl %s3
; CHECK-NEXT:    vmv %v1, %s2, %v0, %vm1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    lea %s2, 64
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    or %s2, 0, %s3
; CHECK-NEXT:    lvl %s3
; CHECK-NEXT:    vmv %v1, %s2, %v0, %vm1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    or %s2, 32, (0)1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    or %s2, 0, %s3
; CHECK-NEXT:    lvl %s3
; CHECK-NEXT:    vmv %v1, %s2, %v0, %vm1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    or %s2, 16, (0)1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    or %s2, 0, %s3
; CHECK-NEXT:    lvl %s3
; CHECK-NEXT:    vmv %v1, %s2, %v0, %vm1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    or %s2, 8, (0)1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    or %s2, 0, %s3
; CHECK-NEXT:    lvl %s3
; CHECK-NEXT:    vmv %v1, %s2, %v0, %vm1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    or %s2, 4, (0)1
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    or %s2, 0, %s3
; CHECK-NEXT:    lvl %s3
; CHECK-NEXT:    vmv %v1, %s2, %v0, %vm1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    lvs %s2, %v0(2)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s2
; CHECK-NEXT:    lvs %s2, %v0(3)
; CHECK-NEXT:    lsv %v1(1), %s2
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    lvs %s2, %v0(1)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s2
; CHECK-NEXT:    vfmul.d %v0, %v0, %v1
; CHECK-NEXT:    lvs %s1, %v0(0)
; CHECK-NEXT:    fmul.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call fast double @llvm.vp.reduce.fmul.v256f64(double %s, <256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

;;; FADD ;;;
define fastcc double @test_reduce_fadd(<256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fadd:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vmrg %v0, 0, %v0, %vm1
; CHECK-NEXT:    lea.sl %s0, 0
; CHECK-NEXT:    vfia.d %v0, %v0, %s0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call double @llvm.vp.reduce.fadd.v256f64(double 0.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

define fastcc double @test_reduce_fadd_start(double %s, <256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fadd_start:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vmrg %v0, 0, %v0, %vm1
; CHECK-NEXT:    vfia.d %v0, %v0, %s0
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call double @llvm.vp.reduce.fadd.v256f64(double %s, <256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

define fastcc double @test_reduce_fadd_fast(<256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fadd_fast:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfsum.d %v0, %v0, %vm1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call fast double @llvm.vp.reduce.fadd.v256f64(double 0.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

define fastcc double @test_reduce_fadd_start_fast(double %s, <256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fadd_start_fast:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s1, %s1, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vfsum.d %v0, %v0, %vm1
; CHECK-NEXT:    lvs %s1, %v0(0)
; CHECK-NEXT:    fadd.d %s0, %s0, %s1
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call fast double @llvm.vp.reduce.fadd.v256f64(double %s, <256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

;;; FMIN ;;;
define fastcc double @test_reduce_fmin(<256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fmin:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfrmin.d.fst %v0, %v0, %vm1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call double @llvm.vp.reduce.fmin.v256f64(<256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

;;; FMAX ;;;
define fastcc double @test_reduce_fmax(<256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fmax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfrmax.d.fst %v0, %v0, %vm1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call double @llvm.vp.reduce.fmax.v256f64(<256 x double> %v, <256 x i1> %m, i32 %n)
  ret double %r
}

;;; Integer ;;;
define fastcc i64 @test_reduce_add(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_add:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vsum.l %v0, %v0, %vm1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call i64 @llvm.vp.reduce.add.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ret i64 %r
}

define fastcc i64 @test_reduce_mul(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_mul:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andm %vm3, %vm0, %vm1
; CHECK-NEXT:    lea %s16, 256
; CHECK-NEXT:    lvl %s16
; CHECK-NEXT:    vor %v1, (0)1, %v0
; CHECK-NEXT:    and %s1, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    # implicit-def: $sx1
; CHECK-NEXT:    or %s1, 0, %s0
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrd %v2, %s1
; CHECK-NEXT:    vseq %v0
; CHECK-NEXT:    vcmpu.l %v0, %v0, %v2
; CHECK-NEXT:    andm %vm1, %vm0, %vm0
; CHECK-NEXT:    vfmk.l.lt %vm2, %v0, %vm1
; CHECK-NEXT:    andm %vm2, %vm2, %vm3
; CHECK-NEXT:    or %s1, 1, (0)1
; CHECK-NEXT:    vbrd %v0, %s1
; CHECK-NEXT:    vmrg %v0, %v0, %v1, %vm2
; CHECK-NEXT:    lea %s1, -128
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    or %s1, 0, %s1
; CHECK-NEXT:    lea %s2, 128
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v0, %v0, %v1
; CHECK-NEXT:    lea %s1, 64
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v0, %v0, %v1
; CHECK-NEXT:    or %s1, 32, (0)1
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v0, %v0, %v1
; CHECK-NEXT:    or %s1, 16, (0)1
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v0, %v0, %v1
; CHECK-NEXT:    or %s1, 8, (0)1
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v0, %v0, %v1
; CHECK-NEXT:    or %s1, 4, (0)1
; CHECK-NEXT:    or %s2, 0, %s1
; CHECK-NEXT:    or %s1, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s1, %v0, %vm1
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v0, %v0, %v1
; CHECK-NEXT:    lvs %s1, %v0(2)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s1
; CHECK-NEXT:    lvs %s1, %v0(3)
; CHECK-NEXT:    lsv %v1(1), %s1
; CHECK-NEXT:    vmuls.l %v0, %v0, %v1
; CHECK-NEXT:    lvs %s1, %v0(1)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s1
; CHECK-NEXT:    vmuls.l %v0, %v0, %v1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call i64 @llvm.vp.reduce.mul.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ret i64 %r
}

define fastcc i64 @test_reduce_and(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_and:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vrand %v0, %v0, %vm1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call i64 @llvm.vp.reduce.and.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ret i64 %r
}

define fastcc i64 @test_reduce_or(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_or:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vror %v0, %v0, %vm1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call i64 @llvm.vp.reduce.or.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ret i64 %r
}

define fastcc i64 @test_reduce_xor(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_xor:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vrxor %v0, %v0, %vm1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call i64 @llvm.vp.reduce.xor.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ret i64 %r
}

define fastcc i64 @test_reduce_smin(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; TODO: map to smax
  %r = call i64 @llvm.vp.reduce.smin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ret i64 %r
}

define fastcc i64 @test_reduce_smax(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_smax:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s0, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vrmaxs.l.fst %v0, %v0, %vm1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    b.l.t (, %s10)
  %r = call i64 @llvm.vp.reduce.smax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ret i64 %r
}

define fastcc i64 @test_reduce_umin(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; TODO: map to smax
  %r = call i64 @llvm.vp.reduce.umin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ret i64 %r
}

define fastcc i64 @test_reduce_umax(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; TODO: map to smax
  %r = call i64 @llvm.vp.reduce.umax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  ret i64 %r
}

declare double @llvm.vp.reduce.fadd.v256f64(double, <256 x double>, <256 x i1> mask, i32 vlen)
declare double @llvm.vp.reduce.fmul.v256f64(double, <256 x double>, <256 x i1> mask, i32 vlen)
declare double @llvm.vp.reduce.fmin.v256f64(<256 x double>, <256 x i1> mask, i32 vlen)
declare double @llvm.vp.reduce.fmax.v256f64(<256 x double>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.add.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.mul.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.and.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.xor.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.or.v256i64(<256 x i64>, <256 x i1> mask, i32 vlen)
declare i64 @llvm.vp.reduce.smax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
declare i64 @llvm.vp.reduce.smin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
declare i64 @llvm.vp.reduce.umax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
declare i64 @llvm.vp.reduce.umin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
