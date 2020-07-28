	.text
	.file	"vec_store.ll"
	.globl	vec_store_v1f64         # -- Begin function vec_store_v1f64
	.p2align	4
	.type	vec_store_v1f64,@function
vec_store_v1f64:                        # @vec_store_v1f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l.t %s11, %s8, .LBB0_2
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
	st %s1, (, %s0)
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l.t (, %s10)
.Lfunc_end0:
	.size	vec_store_v1f64, .Lfunc_end0-vec_store_v1f64
                                        # -- End function
	.globl	vec_store_v17f64        # -- Begin function vec_store_v17f64
	.p2align	4
	.type	vec_store_v17f64,@function
vec_store_v17f64:                       # @vec_store_v17f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l.t %s11, %s8, .LBB1_2
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
	or %s1, 17, (0)1
	or %s2, 8, (0)1
	lvl %s1
	vst %v0,%s2,%s0
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l.t (, %s10)
.Lfunc_end1:
	.size	vec_store_v17f64, .Lfunc_end1-vec_store_v17f64
                                        # -- End function
	.globl	vec_mstore_v128f64      # -- Begin function vec_mstore_v128f64
	.p2align	4
	.type	vec_mstore_v128f64,@function
vec_mstore_v128f64:                     # @vec_mstore_v128f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l.t %s11, %s8, .LBB2_2
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
	lea %s1, 128
	or %s2, 8, (0)1
	lvl %s1
	vst %v0,%s2,%s0,%vm1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l.t (, %s10)
.Lfunc_end2:
	.size	vec_mstore_v128f64, .Lfunc_end2-vec_mstore_v128f64
                                        # -- End function
	.globl	vec_mstore_v256f64      # -- Begin function vec_mstore_v256f64
	.p2align	4
	.type	vec_mstore_v256f64,@function
vec_mstore_v256f64:                     # @vec_mstore_v256f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l.t %s11, %s8, .LBB3_2
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
	lea %s1, 256
	or %s2, 8, (0)1
	lvl %s1
	vst %v0,%s2,%s0,%vm1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l.t (, %s10)
.Lfunc_end3:
	.size	vec_mstore_v256f64, .Lfunc_end3-vec_mstore_v256f64
                                        # -- End function
	.globl	vec_scatter_v128f64     # -- Begin function vec_scatter_v128f64
	.p2align	4
	.type	vec_scatter_v128f64,@function
vec_scatter_v128f64:                    # @vec_scatter_v128f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l.t %s11, %s8, .LBB4_2
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
	lea %s0, 128
	lvl %s0
	vsc %v0, %v1, 0, 0, %vm1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l.t (, %s10)
.Lfunc_end4:
	.size	vec_scatter_v128f64, .Lfunc_end4-vec_scatter_v128f64
                                        # -- End function
	.globl	vec_scatter_v256f64     # -- Begin function vec_scatter_v256f64
	.p2align	4
	.type	vec_scatter_v256f64,@function
vec_scatter_v256f64:                    # @vec_scatter_v256f64
# %bb.0:
	st %s9, (, %s11)
	st %s10, 8(, %s11)
	st %s15, 24(, %s11)
	st %s16, 32(, %s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s13, %s11)
	brge.l.t %s11, %s8, .LBB5_2
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
	lea %s0, 256
	lvl %s0
	vsc %v0, %v1, 0, 0, %vm1
	or %s11, 0, %s9
	ld %s16, 32(, %s11)
	ld %s15, 24(, %s11)
	ld %s10, 8(, %s11)
	ld %s9, (, %s11)
	b.l.t (, %s10)
.Lfunc_end5:
	.size	vec_scatter_v256f64, .Lfunc_end5-vec_scatter_v256f64
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
