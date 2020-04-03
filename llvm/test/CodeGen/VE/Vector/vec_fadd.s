	.text
	.file	"vec_fadd.ll"
	.globl	vec_add_v1f64           # -- Begin function vec_add_v1f64
	.p2align	4
	.type	vec_add_v1f64,@function
vec_add_v1f64:                          # @vec_add_v1f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB0_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB0_2:
	fadd.d %s0, %s0, %s1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end0:
	.size	vec_add_v1f64, .Lfunc_end0-vec_add_v1f64
                                        # -- End function
	.globl	vec_add_v2f64           # -- Begin function vec_add_v2f64
	.p2align	4
	.type	vec_add_v2f64,@function
vec_add_v2f64:                          # @vec_add_v2f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB1_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB1_2:
	or %s0, 2, (0)1
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end1:
	.size	vec_add_v2f64, .Lfunc_end1-vec_add_v2f64
                                        # -- End function
	.globl	vec_add_v3f64           # -- Begin function vec_add_v3f64
	.p2align	4
	.type	vec_add_v3f64,@function
vec_add_v3f64:                          # @vec_add_v3f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB2_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB2_2:
	lea %s0, 256
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end2:
	.size	vec_add_v3f64, .Lfunc_end2-vec_add_v3f64
                                        # -- End function
	.globl	vec_add_v4f64           # -- Begin function vec_add_v4f64
	.p2align	4
	.type	vec_add_v4f64,@function
vec_add_v4f64:                          # @vec_add_v4f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB3_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB3_2:
	or %s0, 4, (0)1
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end3:
	.size	vec_add_v4f64, .Lfunc_end3-vec_add_v4f64
                                        # -- End function
	.globl	vec_add_v8f64           # -- Begin function vec_add_v8f64
	.p2align	4
	.type	vec_add_v8f64,@function
vec_add_v8f64:                          # @vec_add_v8f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB4_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB4_2:
	or %s0, 8, (0)1
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end4:
	.size	vec_add_v8f64, .Lfunc_end4-vec_add_v8f64
                                        # -- End function
	.globl	vec_add_v16f64          # -- Begin function vec_add_v16f64
	.p2align	4
	.type	vec_add_v16f64,@function
vec_add_v16f64:                         # @vec_add_v16f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB5_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB5_2:
	or %s0, 16, (0)1
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end5:
	.size	vec_add_v16f64, .Lfunc_end5-vec_add_v16f64
                                        # -- End function
	.globl	vec_add_v32f64          # -- Begin function vec_add_v32f64
	.p2align	4
	.type	vec_add_v32f64,@function
vec_add_v32f64:                         # @vec_add_v32f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB6_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB6_2:
	or %s0, 32, (0)1
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end6:
	.size	vec_add_v32f64, .Lfunc_end6-vec_add_v32f64
                                        # -- End function
	.globl	vec_add_v64f64          # -- Begin function vec_add_v64f64
	.p2align	4
	.type	vec_add_v64f64,@function
vec_add_v64f64:                         # @vec_add_v64f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB7_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB7_2:
	lea %s0, 64
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end7:
	.size	vec_add_v64f64, .Lfunc_end7-vec_add_v64f64
                                        # -- End function
	.globl	vec_add_v128f64         # -- Begin function vec_add_v128f64
	.p2align	4
	.type	vec_add_v128f64,@function
vec_add_v128f64:                        # @vec_add_v128f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB8_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB8_2:
	lea %s0, 128
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end8:
	.size	vec_add_v128f64, .Lfunc_end8-vec_add_v128f64
                                        # -- End function
	.globl	vec_add_v253f64         # -- Begin function vec_add_v253f64
	.p2align	4
	.type	vec_add_v253f64,@function
vec_add_v253f64:                        # @vec_add_v253f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB9_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB9_2:
	lea %s0, 256
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end9:
	.size	vec_add_v253f64, .Lfunc_end9-vec_add_v253f64
                                        # -- End function
	.globl	vec_add_v256f64         # -- Begin function vec_add_v256f64
	.p2align	4
	.type	vec_add_v256f64,@function
vec_add_v256f64:                        # @vec_add_v256f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB10_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB10_2:
	lea %s0, 256
	lvl %s0
	vfadd.d %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end10:
	.size	vec_add_v256f64, .Lfunc_end10-vec_add_v256f64
                                        # -- End function
	.globl	vec_add_v512f64         # -- Begin function vec_add_v512f64
	.p2align	4
	.type	vec_add_v512f64,@function
vec_add_v512f64:                        # @vec_add_v512f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB11_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB11_2:
	lea %s0, 256
	lvl %s0
	vfadd.d %v0,%v0,%v2
	vfadd.d %v1,%v1,%v3
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end11:
	.size	vec_add_v512f64, .Lfunc_end11-vec_add_v512f64
                                        # -- End function
	.globl	vec_add_v1024f64        # -- Begin function vec_add_v1024f64
	.p2align	4
	.type	vec_add_v1024f64,@function
vec_add_v1024f64:                       # @vec_add_v1024f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB12_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB12_2:
	lea %s0, 256
	lvl %s0
	vfadd.d %v0,%v0,%v4
	vfadd.d %v1,%v1,%v5
	vfadd.d %v2,%v2,%v6
	vfadd.d %v3,%v3,%v7
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end12:
	.size	vec_add_v1024f64, .Lfunc_end12-vec_add_v1024f64
                                        # -- End function
	.globl	vec_add_v1f32           # -- Begin function vec_add_v1f32
	.p2align	4
	.type	vec_add_v1f32,@function
vec_add_v1f32:                          # @vec_add_v1f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB13_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB13_2:
	fadd.s %s0, %s0, %s1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end13:
	.size	vec_add_v1f32, .Lfunc_end13-vec_add_v1f32
                                        # -- End function
	.globl	vec_add_v2f32           # -- Begin function vec_add_v2f32
	.p2align	4
	.type	vec_add_v2f32,@function
vec_add_v2f32:                          # @vec_add_v2f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB14_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB14_2:
	or %s0, 2, (0)1
	lvl %s0
	vfadd.s %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end14:
	.size	vec_add_v2f32, .Lfunc_end14-vec_add_v2f32
                                        # -- End function
	.globl	vec_add_v3f32           # -- Begin function vec_add_v3f32
	.p2align	4
	.type	vec_add_v3f32,@function
vec_add_v3f32:                          # @vec_add_v3f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB15_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB15_2:
                                        # kill: def $sf5 killed $sf5 def $sx5
                                        # kill: def $sf4 killed $sf4 def $sx4
                                        # kill: def $sf3 killed $sf3 def $sx3
                                        # kill: def $sf2 killed $sf2 def $sx2
                                        # kill: def $sf1 killed $sf1 def $sx1
                                        # kill: def $sf0 killed $sf0 def $sx0
	lsv %v0(0),%s3
	lsv %v0(1),%s4
	lsv %v0(2),%s5
	lsv %v1(0),%s0
	lsv %v1(1),%s1
	lsv %v1(2),%s2
	or %s0, 3, (0)1
	lvl %s0
	vfadd.s %v0,%v1,%v0
	lvs %s0,%v0(0)
	lvs %s1,%v0(1)
	lvs %s2,%v0(2)
                                        # kill: def $sf0 killed $sf0 killed $sx0
                                        # kill: def $sf1 killed $sf1 killed $sx1
                                        # kill: def $sf2 killed $sf2 killed $sx2
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end15:
	.size	vec_add_v3f32, .Lfunc_end15-vec_add_v3f32
                                        # -- End function
	.globl	vec_add_v4f32           # -- Begin function vec_add_v4f32
	.p2align	4
	.type	vec_add_v4f32,@function
vec_add_v4f32:                          # @vec_add_v4f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB16_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB16_2:
	or %s0, 4, (0)1
	lvl %s0
	vfadd.s %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end16:
	.size	vec_add_v4f32, .Lfunc_end16-vec_add_v4f32
                                        # -- End function
	.globl	vec_add_v8f32           # -- Begin function vec_add_v8f32
	.p2align	4
	.type	vec_add_v8f32,@function
vec_add_v8f32:                          # @vec_add_v8f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB17_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB17_2:
	or %s0, 8, (0)1
	lvl %s0
	vfadd.s %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end17:
	.size	vec_add_v8f32, .Lfunc_end17-vec_add_v8f32
                                        # -- End function
	.globl	vec_add_v16f32          # -- Begin function vec_add_v16f32
	.p2align	4
	.type	vec_add_v16f32,@function
vec_add_v16f32:                         # @vec_add_v16f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB18_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB18_2:
	or %s0, 16, (0)1
	lvl %s0
	vfadd.s %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end18:
	.size	vec_add_v16f32, .Lfunc_end18-vec_add_v16f32
                                        # -- End function
	.globl	vec_add_v32f32          # -- Begin function vec_add_v32f32
	.p2align	4
	.type	vec_add_v32f32,@function
vec_add_v32f32:                         # @vec_add_v32f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB19_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB19_2:
	or %s0, 32, (0)1
	lvl %s0
	vfadd.s %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end19:
	.size	vec_add_v32f32, .Lfunc_end19-vec_add_v32f32
                                        # -- End function
	.globl	vec_add_v64f32          # -- Begin function vec_add_v64f32
	.p2align	4
	.type	vec_add_v64f32,@function
vec_add_v64f32:                         # @vec_add_v64f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB20_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB20_2:
	lea %s0, 64
	lvl %s0
	vfadd.s %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end20:
	.size	vec_add_v64f32, .Lfunc_end20-vec_add_v64f32
                                        # -- End function
	.globl	vec_add_v128f32         # -- Begin function vec_add_v128f32
	.p2align	4
	.type	vec_add_v128f32,@function
vec_add_v128f32:                        # @vec_add_v128f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB21_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB21_2:
	lea %s0, 128
	lvl %s0
	vfadd.s %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end21:
	.size	vec_add_v128f32, .Lfunc_end21-vec_add_v128f32
                                        # -- End function
	.globl	vec_add_v253f32         # -- Begin function vec_add_v253f32
	.p2align	4
	.type	vec_add_v253f32,@function
vec_add_v253f32:                        # @vec_add_v253f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB22_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB22_2:
	lea %s0, 256
	lvl %s0
	vfadd.s %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end22:
	.size	vec_add_v253f32, .Lfunc_end22-vec_add_v253f32
                                        # -- End function
	.globl	vec_add_v256f32         # -- Begin function vec_add_v256f32
	.p2align	4
	.type	vec_add_v256f32,@function
vec_add_v256f32:                        # @vec_add_v256f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB23_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB23_2:
	lea %s0, 256
	lvl %s0
	vfadd.s %v0,%v0,%v1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end23:
	.size	vec_add_v256f32, .Lfunc_end23-vec_add_v256f32
                                        # -- End function
	.globl	vec_add_v512f32         # -- Begin function vec_add_v512f32
	.p2align	4
	.type	vec_add_v512f32,@function
vec_add_v512f32:                        # @vec_add_v512f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB24_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB24_2:
	lea %s0, 256
	lvl %s0
	vfadd.s %v0,%v0,%v2
	vfadd.s %v1,%v1,%v3
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end24:
	.size	vec_add_v512f32, .Lfunc_end24-vec_add_v512f32
                                        # -- End function
	.globl	vec_add_v1024f32        # -- Begin function vec_add_v1024f32
	.p2align	4
	.type	vec_add_v1024f32,@function
vec_add_v1024f32:                       # @vec_add_v1024f32
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l %s11, %s8, .LBB25_2
# %bb.1:
	ld %s61, 24(, %s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB25_2:
	lea %s0, 256
	lvl %s0
	vfadd.s %v0,%v0,%v4
	vfadd.s %v1,%v1,%v5
	vfadd.s %v2,%v2,%v6
	vfadd.s %v3,%v3,%v7
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l (, %lr)
.Lfunc_end25:
	.size	vec_add_v1024f32, .Lfunc_end25-vec_add_v1024f32
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
