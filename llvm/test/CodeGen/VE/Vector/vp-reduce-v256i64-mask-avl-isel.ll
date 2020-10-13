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

define double @test_reduce_fp(<256 x double> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_fp:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s1, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    # implicit-def: $sx2
; CHECK-NEXT:    or %s2, 0, %s0
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrd %v1, %s2
; CHECK-NEXT:    vseq %v2
; CHECK-NEXT:    vcmpu.l %v1, %v2, %v1
; CHECK-NEXT:    andm %vm2, %vm0, %vm0
; CHECK-NEXT:    vfmk.l.lt %vm3, %v1, %vm2
; CHECK-NEXT:    andm %vm1, %vm3, %vm1
; CHECK-NEXT:    lea.sl %s2, 2146959360
; CHECK-NEXT:    vbrd %v1, %s2
; CHECK-NEXT:    vmrg %v1, %v1, %v0, %vm1
; CHECK-NEXT:    lea %s2, -128
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    or %s2, 0, %s2
; CHECK-NEXT:    lea %s3, 128
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 killed $sx3
; CHECK-NEXT:    lvl %s3
; CHECK-NEXT:    vmv %v0, %s2, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmin.d %v2, %v1, %v0
; CHECK-NEXT:    lea %s2, 64
; CHECK-NEXT:    # kill: def $sw2 killed $sw2 killed $sx2
; CHECK-NEXT:    or %s3, 0, %s2
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v3, %s3, %v2, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmin.d %v2, %v2, %v3
; CHECK-NEXT:    or %s4, 32, (0)1
; CHECK-NEXT:    # kill: def $sw4 killed $sw4 killed $sx4
; CHECK-NEXT:    or %s5, 0, %s4
; CHECK-NEXT:    lvl %s4
; CHECK-NEXT:    vmv %v3, %s5, %v2, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmin.d %v2, %v2, %v3
; CHECK-NEXT:    or %s6, 16, (0)1
; CHECK-NEXT:    # kill: def $sw6 killed $sw6 killed $sx6
; CHECK-NEXT:    or %s7, 0, %s6
; CHECK-NEXT:    lvl %s6
; CHECK-NEXT:    vmv %v3, %s7, %v2, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmin.d %v2, %v2, %v3
; CHECK-NEXT:    or %s34, 8, (0)1
; CHECK-NEXT:    # kill: def $sw34 killed $sw34 killed $sx34
; CHECK-NEXT:    or %s35, 0, %s34
; CHECK-NEXT:    lvl %s34
; CHECK-NEXT:    vmv %v3, %s35, %v2, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmin.d %v2, %v2, %v3
; CHECK-NEXT:    or %s36, 4, (0)1
; CHECK-NEXT:    # kill: def $sw36 killed $sw36 killed $sx36
; CHECK-NEXT:    or %s37, 0, %s36
; CHECK-NEXT:    lvl %s36
; CHECK-NEXT:    vmv %v3, %s37, %v2, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmin.d %v2, %v2, %v3
; CHECK-NEXT:    lvs %s38, %v2(2)
; CHECK-NEXT:    # implicit-def: $v3
; CHECK-NEXT:    lsv %v3(0), %s38
; CHECK-NEXT:    lvs %s38, %v2(3)
; CHECK-NEXT:    lsv %v3(1), %s38
; CHECK-NEXT:    vfmin.d %v2, %v2, %v3
; CHECK-NEXT:    lvs %s38, %v2(1)
; CHECK-NEXT:    # implicit-def: $v3
; CHECK-NEXT:    lsv %v3(0), %s38
; CHECK-NEXT:    vfmin.d %v2, %v2, %v3
; CHECK-NEXT:    lvs %s38, %v2(0)
; CHECK-NEXT:    vfmax.d %v0, %v1, %v0
; CHECK-NEXT:    lvl %s2
; CHECK-NEXT:    vmv %v1, %s3, %v0, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmax.d %v0, %v0, %v1
; CHECK-NEXT:    lvl %s4
; CHECK-NEXT:    vmv %v1, %s5, %v0, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmax.d %v0, %v0, %v1
; CHECK-NEXT:    lvl %s6
; CHECK-NEXT:    vmv %v1, %s7, %v0, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmax.d %v0, %v0, %v1
; CHECK-NEXT:    lvl %s34
; CHECK-NEXT:    vmv %v1, %s35, %v0, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmax.d %v0, %v0, %v1
; CHECK-NEXT:    lvl %s36
; CHECK-NEXT:    vmv %v1, %s37, %v0, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vfmax.d %v0, %v0, %v1
; CHECK-NEXT:    lvs %s2, %v0(2)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s2
; CHECK-NEXT:    lvs %s2, %v0(3)
; CHECK-NEXT:    lsv %v1(1), %s2
; CHECK-NEXT:    vfmax.d %v0, %v0, %v1
; CHECK-NEXT:    lvs %s2, %v0(1)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s2
; CHECK-NEXT:    vfmax.d %v0, %v0, %v1
; CHECK-NEXT:    lvs %s0, %v0(0)
; CHECK-NEXT:    fadd.d %s0, %s38, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %r0 = call double @llvm.vp.reduce.fadd.v256f64(double 0.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  %r0a = call reassoc double @llvm.vp.reduce.fadd.v256f64(double 0.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  %r1 = call double @llvm.vp.reduce.fmul.v256f64(double 42.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  %r1a = call reassoc double @llvm.vp.reduce.fmul.v256f64(double 42.0, <256 x double> %v, <256 x i1> %m, i32 %n)
  %r2 = call double @llvm.vp.reduce.fmin.v256f64(<256 x double> %v, <256 x i1> %m, i32 %n)
  %r3 = call double @llvm.vp.reduce.fmax.v256f64(<256 x double> %v, <256 x i1> %m, i32 %n)
  %s0 = fadd double %r0, %r0a
  %s1 = fadd double %r1, %r1a
  %s2 = fadd double %r2, %r3
  %t0 = fadd double %s0, %s1
  %u =  fadd double %t0, %s2
  ret double %s2
}

define i64 @test_reduce_int(<256 x i64> %v, <256 x i1> %m, i32 %n) {
; CHECK-LABEL: test_reduce_int:
; CHECK:       # %bb.0:
; CHECK-NEXT:    and %s1, %s0, (32)0
; CHECK-NEXT:    # kill: def $sw1 killed $sw1 killed $sx1
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vsum.l %v1, %v0, %vm1
; CHECK-NEXT:    lvs %s2, %v1(0)
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    adds.w.sx %s0, %s0, (0)1
; CHECK-NEXT:    # implicit-def: $sx3
; CHECK-NEXT:    or %s3, 0, %s0
; CHECK-NEXT:    lea %s0, 256
; CHECK-NEXT:    # kill: def $sw0 killed $sw0 killed $sx0
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrd %v1, %s3
; CHECK-NEXT:    vseq %v2
; CHECK-NEXT:    vcmpu.l %v1, %v2, %v1
; CHECK-NEXT:    andm %vm2, %vm0, %vm0
; CHECK-NEXT:    vfmk.l.lt %vm3, %v1, %vm2
; CHECK-NEXT:    andm %vm3, %vm3, %vm1
; CHECK-NEXT:    or %s3, 1, (0)1
; CHECK-NEXT:    vbrd %v1, %s3
; CHECK-NEXT:    vmrg %v1, %v1, %v0, %vm3
; CHECK-NEXT:    lea %s3, -128
; CHECK-NEXT:    # kill: def $sw3 killed $sw3 killed $sx3
; CHECK-NEXT:    or %s3, 0, %s3
; CHECK-NEXT:    lea %s4, 128
; CHECK-NEXT:    # kill: def $sw4 killed $sw4 killed $sx4
; CHECK-NEXT:    lvl %s4
; CHECK-NEXT:    vmv %v2, %s3, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v1, %v1, %v2
; CHECK-NEXT:    lea %s5, 64
; CHECK-NEXT:    # kill: def $sw5 killed $sw5 killed $sx5
; CHECK-NEXT:    or %s6, 0, %s5
; CHECK-NEXT:    lvl %s5
; CHECK-NEXT:    vmv %v2, %s6, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v1, %v1, %v2
; CHECK-NEXT:    or %s7, 32, (0)1
; CHECK-NEXT:    # kill: def $sw7 killed $sw7 killed $sx7
; CHECK-NEXT:    or %s34, 0, %s7
; CHECK-NEXT:    lvl %s7
; CHECK-NEXT:    vmv %v2, %s34, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v1, %v1, %v2
; CHECK-NEXT:    or %s35, 16, (0)1
; CHECK-NEXT:    # kill: def $sw35 killed $sw35 killed $sx35
; CHECK-NEXT:    or %s36, 0, %s35
; CHECK-NEXT:    lvl %s35
; CHECK-NEXT:    vmv %v2, %s36, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v1, %v1, %v2
; CHECK-NEXT:    or %s37, 8, (0)1
; CHECK-NEXT:    # kill: def $sw37 killed $sw37 killed $sx37
; CHECK-NEXT:    or %s38, 0, %s37
; CHECK-NEXT:    lvl %s37
; CHECK-NEXT:    vmv %v2, %s38, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v1, %v1, %v2
; CHECK-NEXT:    or %s39, 4, (0)1
; CHECK-NEXT:    # kill: def $sw39 killed $sw39 killed $sx39
; CHECK-NEXT:    or %s40, 0, %s39
; CHECK-NEXT:    lvl %s39
; CHECK-NEXT:    vmv %v2, %s40, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vmuls.l %v1, %v1, %v2
; CHECK-NEXT:    lvs %s41, %v1(2)
; CHECK-NEXT:    # implicit-def: $v2
; CHECK-NEXT:    lsv %v2(0), %s41
; CHECK-NEXT:    lvs %s41, %v1(3)
; CHECK-NEXT:    lsv %v2(1), %s41
; CHECK-NEXT:    vmuls.l %v1, %v1, %v2
; CHECK-NEXT:    lvs %s41, %v1(1)
; CHECK-NEXT:    # implicit-def: $v2
; CHECK-NEXT:    lsv %v2(0), %s41
; CHECK-NEXT:    vmuls.l %v1, %v1, %v2
; CHECK-NEXT:    lvs %s41, %v1(0)
; CHECK-NEXT:    lvl %s1
; CHECK-NEXT:    vrand %v1, %v0, %vm1
; CHECK-NEXT:    lvs %s42, %v1(0)
; CHECK-NEXT:    vrxor %v1, %v0, %vm1
; CHECK-NEXT:    lvs %s1, %v1(0)
; CHECK-NEXT:    lea %s43, -1
; CHECK-NEXT:    and %s43, %s43, (32)0
; CHECK-NEXT:    lea.sl %s43, 2147483647(, %s43)
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vbrd %v1, %s43
; CHECK-NEXT:    vmrg %v1, %v1, %v0, %vm3
; CHECK-NEXT:    lvl %s4
; CHECK-NEXT:    vmv %v2, %s3, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmps.l %v3, %v1, %v2
; CHECK-NEXT:    vfmk.l.lt %vm1, %v3, %vm2
; CHECK-NEXT:    vmrg %v2, %v2, %v1, %vm1
; CHECK-NEXT:    lvl %s5
; CHECK-NEXT:    vmv %v1, %s6, %v2, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmps.l %v3, %v2, %v1
; CHECK-NEXT:    vfmk.l.lt %vm1, %v3, %vm2
; CHECK-NEXT:    vmrg %v1, %v1, %v2, %vm1
; CHECK-NEXT:    lvl %s7
; CHECK-NEXT:    vmv %v2, %s34, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmps.l %v3, %v1, %v2
; CHECK-NEXT:    vfmk.l.lt %vm1, %v3, %vm2
; CHECK-NEXT:    vmrg %v2, %v2, %v1, %vm1
; CHECK-NEXT:    lvl %s35
; CHECK-NEXT:    vmv %v1, %s36, %v2, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmps.l %v3, %v2, %v1
; CHECK-NEXT:    vfmk.l.lt %vm1, %v3, %vm2
; CHECK-NEXT:    vmrg %v1, %v1, %v2, %vm1
; CHECK-NEXT:    lvl %s37
; CHECK-NEXT:    vmv %v2, %s38, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmps.l %v3, %v1, %v2
; CHECK-NEXT:    vfmk.l.lt %vm1, %v3, %vm2
; CHECK-NEXT:    vmrg %v2, %v2, %v1, %vm1
; CHECK-NEXT:    lvl %s39
; CHECK-NEXT:    vmv %v1, %s40, %v2, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmps.l %v3, %v2, %v1
; CHECK-NEXT:    vfmk.l.lt %vm1, %v3, %vm2
; CHECK-NEXT:    vmrg %v1, %v1, %v2, %vm1
; CHECK-NEXT:    lvs %s43, %v1(2)
; CHECK-NEXT:    # implicit-def: $v2
; CHECK-NEXT:    lsv %v2(0), %s43
; CHECK-NEXT:    lvs %s43, %v1(3)
; CHECK-NEXT:    lsv %v2(1), %s43
; CHECK-NEXT:    vcmps.l %v3, %v1, %v2
; CHECK-NEXT:    vfmk.l.lt %vm1, %v3, %vm2
; CHECK-NEXT:    vmrg %v2, %v2, %v1, %vm1
; CHECK-NEXT:    lvs %s43, %v2(1)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s43
; CHECK-NEXT:    vcmps.l %v3, %v2, %v1
; CHECK-NEXT:    vfmk.l.lt %vm1, %v3, %vm2
; CHECK-NEXT:    vmrg %v1, %v1, %v2, %vm1
; CHECK-NEXT:    lvs %s43, %v1(0)
; CHECK-NEXT:    or %s44, 0, (0)1
; CHECK-NEXT:    vbrd %v1, %s44
; CHECK-NEXT:    vmrg %v1, %v1, %v0, %vm3
; CHECK-NEXT:    lvl %s4
; CHECK-NEXT:    vmv %v0, %s3, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmpu.l %v2, %v1, %v0
; CHECK-NEXT:    vfmk.l.gt %vm1, %v2, %vm2
; CHECK-NEXT:    vmrg %v0, %v0, %v1, %vm1
; CHECK-NEXT:    lvl %s5
; CHECK-NEXT:    vmv %v1, %s6, %v0, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmpu.l %v2, %v0, %v1
; CHECK-NEXT:    vfmk.l.gt %vm1, %v2, %vm2
; CHECK-NEXT:    vmrg %v1, %v1, %v0, %vm1
; CHECK-NEXT:    lvl %s7
; CHECK-NEXT:    vmv %v0, %s34, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmpu.l %v2, %v1, %v0
; CHECK-NEXT:    vfmk.l.gt %vm1, %v2, %vm2
; CHECK-NEXT:    vmrg %v0, %v0, %v1, %vm1
; CHECK-NEXT:    lvl %s35
; CHECK-NEXT:    vmv %v1, %s36, %v0, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmpu.l %v2, %v0, %v1
; CHECK-NEXT:    vfmk.l.gt %vm1, %v2, %vm2
; CHECK-NEXT:    vmrg %v1, %v1, %v0, %vm1
; CHECK-NEXT:    lvl %s37
; CHECK-NEXT:    vmv %v0, %s38, %v1, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmpu.l %v2, %v1, %v0
; CHECK-NEXT:    vfmk.l.gt %vm1, %v2, %vm2
; CHECK-NEXT:    vmrg %v0, %v0, %v1, %vm1
; CHECK-NEXT:    lvl %s39
; CHECK-NEXT:    vmv %v1, %s40, %v0, %vm2
; CHECK-NEXT:    lvl %s0
; CHECK-NEXT:    vcmpu.l %v2, %v0, %v1
; CHECK-NEXT:    vfmk.l.gt %vm1, %v2, %vm2
; CHECK-NEXT:    vmrg %v1, %v1, %v0, %vm1
; CHECK-NEXT:    lvs %s3, %v1(2)
; CHECK-NEXT:    # implicit-def: $v0
; CHECK-NEXT:    lsv %v0(0), %s3
; CHECK-NEXT:    lvs %s3, %v1(3)
; CHECK-NEXT:    lsv %v0(1), %s3
; CHECK-NEXT:    vcmpu.l %v2, %v1, %v0
; CHECK-NEXT:    vfmk.l.gt %vm1, %v2, %vm2
; CHECK-NEXT:    vmrg %v0, %v0, %v1, %vm1
; CHECK-NEXT:    lvs %s3, %v0(1)
; CHECK-NEXT:    # implicit-def: $v1
; CHECK-NEXT:    lsv %v1(0), %s3
; CHECK-NEXT:    vcmpu.l %v2, %v0, %v1
; CHECK-NEXT:    vfmk.l.gt %vm1, %v2, %vm2
; CHECK-NEXT:    vmrg %v1, %v1, %v0, %vm1
; CHECK-NEXT:    lvs %s0, %v1(0)
; CHECK-NEXT:    adds.l %s2, %s2, %s41
; CHECK-NEXT:    adds.l %s1, %s42, %s1
; CHECK-NEXT:    adds.l %s1, %s2, %s1
; CHECK-NEXT:    adds.l %s1, %s1, %s43
; CHECK-NEXT:    adds.l %s0, %s1, %s0
; CHECK-NEXT:    b.l.t (, %s10)
  %r0 = call i64 @llvm.vp.reduce.add.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r1 = call i64 @llvm.vp.reduce.mul.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r2 = call i64 @llvm.vp.reduce.and.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r3 = call i64 @llvm.vp.reduce.xor.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r4 = call i64 @llvm.vp.reduce.or.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r5 = call i64 @llvm.vp.reduce.smin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r6 = call i64 @llvm.vp.reduce.smax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r7 = call i64 @llvm.vp.reduce.umin.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %r8 = call i64 @llvm.vp.reduce.umax.v256i64(<256 x i64> %v, <256 x i1> %m, i32 %n)
  %s0 = add i64 %r0, %r1
  %s1 = add i64 %r2, %r3
  %s2 = add i64 %r4, %r5
  %s3 = add i64 %r6, %r7
  %s4 = add i64 %s0, %s1
  %s5 = add i64 %s2, %s3
  %s6 = add i64 %s4, %r5
  %s7 = add i64 %s6, %r8
  ret i64 %s7
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
