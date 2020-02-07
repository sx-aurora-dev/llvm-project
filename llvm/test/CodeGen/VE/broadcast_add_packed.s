	.text
	.file	"broadcast_add_packed.ll"
	.globl	addbrdv512i32           # -- Begin function addbrdv512i32
	.p2align	4
	.type	addbrdv512i32,@function
addbrdv512i32:                          # @addbrdv512i32
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB0_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB0_2:
	or %s3, 0, (0)1
	lvs %s1,%v0(%s3)
	lea.sl %s2, -1
	and %s4, %s1, %s2
	lvs %s5,%v0(%s3)
	lea %s1, -1
	and %s1, %s1, (32)0
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 1, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 2, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 3, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 4, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 5, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 6, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 7, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 8, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 9, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 10, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 11, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 12, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 13, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 14, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 15, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 16, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 17, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 18, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 19, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 20, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 21, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 22, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 23, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 24, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 25, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 26, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 27, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 28, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 29, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 30, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 31, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 32, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 33, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 34, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 35, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 36, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 37, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 38, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 39, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 40, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 41, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 42, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 43, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 44, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 45, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 46, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 47, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 48, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 49, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 50, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 51, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 52, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 53, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 54, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 55, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 56, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 57, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 58, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 59, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 60, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 61, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 62, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 63, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 64
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 65
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 66
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 67
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 68
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 69
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 70
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 71
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 72
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 73
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 74
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 75
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 76
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 77
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 78
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 79
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 80
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 81
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 82
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 83
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 84
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 85
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 86
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 87
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 88
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 89
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 90
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 91
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 92
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 93
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 94
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 95
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 96
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 97
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 98
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 99
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 100
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 101
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 102
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 103
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 104
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 105
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 106
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 107
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 108
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 109
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 110
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 111
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 112
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 113
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 114
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 115
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 116
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 117
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 118
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 119
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 120
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 121
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 122
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 123
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 124
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 125
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 126
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 127
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 128
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 129
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 130
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 131
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 132
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 133
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 134
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 135
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 136
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 137
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 138
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 139
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 140
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 141
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 142
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 143
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 144
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 145
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 146
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 147
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 148
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 149
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 150
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 151
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 152
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 153
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 154
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 155
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 156
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 157
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 158
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 159
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 160
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 161
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 162
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 163
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 164
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 165
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 166
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 167
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 168
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 169
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 170
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 171
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 172
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 173
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 174
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 175
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 176
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 177
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 178
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 179
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 180
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 181
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 182
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 183
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 184
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 185
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 186
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 187
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 188
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 189
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 190
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 191
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 192
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 193
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 194
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 195
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 196
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 197
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 198
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 199
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 200
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 201
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 202
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 203
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 204
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 205
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 206
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 207
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 208
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 209
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 210
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 211
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 212
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 213
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 214
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 215
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 216
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 217
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 218
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 219
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 220
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 221
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 222
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 223
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 224
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 225
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 226
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 227
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 228
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 229
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 230
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 231
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 232
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 233
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 234
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 235
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 236
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 237
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 238
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 239
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 240
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 241
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 242
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 243
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 244
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 245
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 246
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 247
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 248
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 249
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 250
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 251
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 252
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 253
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 254
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	adds.w.sx %s6, %s0, %s6
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	adds.w.sx %s5, %s0, %s5
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 255
	lvs %s4,%v1(%s3)
	and %s2, %s4, %s2
	lvs %s4,%v0(%s3)
	and %s5, %s4, %s1
	adds.w.sx %s5, %s0, %s5
	or %s2, %s5, %s2
	lsv %v1(%s3),%s2
	lvs %s2,%v1(%s3)
	and %s1, %s2, %s1
	srl %s2, %s4, 32
	adds.w.sx %s0, %s0, %s2
	sll %s0, %s0, 32
	or %s0, %s0, %s1
	lsv %v1(%s3),%s0
	lea %s12, 256
	lvl %s12
	vor %v0,(0)1,%v1
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end0:
	.size	addbrdv512i32, .Lfunc_end0-addbrdv512i32
                                        # -- End function
	.globl	addbrdv512f32           # -- Begin function addbrdv512f32
	.p2align	4
	.type	addbrdv512f32,@function
addbrdv512f32:                          # @addbrdv512f32
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB1_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB1_2:
	or %s3, 0, (0)1
	lvs %s1,%v0(%s3)
	lea.sl %s2, -1
	and %s4, %s1, %s2
	lvs %s5,%v0(%s3)
	lea %s1, -1
	and %s1, %s1, (32)0
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 1, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 2, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 3, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 4, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 5, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 6, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 7, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 8, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 9, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 10, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 11, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 12, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 13, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 14, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 15, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 16, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 17, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 18, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 19, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 20, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 21, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 22, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 23, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 24, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 25, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 26, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 27, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 28, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 29, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 30, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 31, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 32, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 33, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 34, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 35, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 36, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 37, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 38, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 39, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 40, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 41, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 42, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 43, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 44, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 45, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 46, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 47, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 48, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 49, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 50, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 51, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 52, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 53, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 54, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 55, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 56, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 57, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 58, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 59, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 60, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 61, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 62, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	or %s3, 63, (0)1
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 64
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 65
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 66
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 67
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 68
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 69
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 70
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 71
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 72
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 73
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 74
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 75
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 76
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 77
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 78
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 79
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 80
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 81
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 82
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 83
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 84
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 85
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 86
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 87
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 88
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 89
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 90
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 91
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 92
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 93
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 94
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 95
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 96
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 97
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 98
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 99
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 100
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 101
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 102
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 103
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 104
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 105
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 106
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 107
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 108
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 109
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 110
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 111
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 112
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 113
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 114
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 115
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 116
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 117
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 118
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 119
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 120
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 121
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 122
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 123
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 124
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 125
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 126
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 127
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 128
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 129
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 130
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 131
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 132
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 133
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 134
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 135
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 136
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 137
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 138
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 139
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 140
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 141
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 142
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 143
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 144
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 145
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 146
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 147
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 148
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 149
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 150
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 151
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 152
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 153
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 154
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 155
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 156
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 157
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 158
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 159
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 160
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 161
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 162
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 163
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 164
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 165
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 166
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 167
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 168
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 169
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 170
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 171
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 172
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 173
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 174
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 175
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 176
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 177
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 178
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 179
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 180
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 181
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 182
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 183
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 184
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 185
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 186
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 187
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 188
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 189
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 190
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 191
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 192
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 193
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 194
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 195
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 196
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 197
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 198
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 199
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 200
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 201
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 202
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 203
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 204
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 205
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 206
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 207
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 208
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 209
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 210
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 211
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 212
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 213
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 214
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 215
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 216
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 217
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 218
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 219
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 220
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 221
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 222
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 223
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 224
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 225
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 226
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 227
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 228
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 229
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 230
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 231
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 232
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 233
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 234
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 235
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 236
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 237
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 238
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 239
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 240
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 241
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 242
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 243
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 244
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 245
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 246
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 247
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 248
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 249
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 250
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 251
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 252
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 253
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 254
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s2
	lvs %s5,%v0(%s3)
	and %s6, %s5, %s1
	sll %s6, %s6, 32
	fadd.s %s6, %s0, %s6
	sra.l %s6, %s6, 32
	or %s4, %s6, %s4
	lsv %v1(%s3),%s4
	lvs %s4,%v1(%s3)
	and %s4, %s4, %s1
	srl %s5, %s5, 32
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	sll %s5, %s5, 32
	or %s4, %s5, %s4
	lsv %v1(%s3),%s4
	lea %s3, 255
	lvs %s4,%v1(%s3)
	and %s2, %s4, %s2
	lvs %s4,%v0(%s3)
	and %s5, %s4, %s1
	sll %s5, %s5, 32
	fadd.s %s5, %s0, %s5
	sra.l %s5, %s5, 32
	or %s2, %s5, %s2
	lsv %v1(%s3),%s2
	lvs %s2,%v1(%s3)
	and %s1, %s2, %s1
	srl %s2, %s4, 32
	sll %s2, %s2, 32
	fadd.s %s0, %s0, %s2
	sra.l %s0, %s0, 32
	sll %s0, %s0, 32
	or %s0, %s0, %s1
	lsv %v1(%s3),%s0
	lea %s12, 256
	lvl %s12
	vor %v0,(0)1,%v1
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end1:
	.size	addbrdv512f32, .Lfunc_end1-addbrdv512f32
                                        # -- End function
	.globl	addbrdv256i64           # -- Begin function addbrdv256i64
	.p2align	4
	.type	addbrdv256i64,@function
addbrdv256i64:                          # @addbrdv256i64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB2_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB2_2:
	lea %s1, 256
	lvl %s1
	vadds.l %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end2:
	.size	addbrdv256i64, .Lfunc_end2-addbrdv256i64
                                        # -- End function
	.globl	addbrdv256i64s          # -- Begin function addbrdv256i64s
	.p2align	4
	.type	addbrdv256i64s,@function
addbrdv256i64s:                         # @addbrdv256i64s
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB3_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB3_2:
	lea %s1, 256
	lvl %s1
	vadds.l %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end3:
	.size	addbrdv256i64s, .Lfunc_end3-addbrdv256i64s
                                        # -- End function
	.globl	addbrdv256i32           # -- Begin function addbrdv256i32
	.p2align	4
	.type	addbrdv256i32,@function
addbrdv256i32:                          # @addbrdv256i32
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB4_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB4_2:
	lea %s1, 256
	lvl %s1
	vadds.w.sx %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end4:
	.size	addbrdv256i32, .Lfunc_end4-addbrdv256i32
                                        # -- End function
	.globl	addbrdv256f64           # -- Begin function addbrdv256f64
	.p2align	4
	.type	addbrdv256f64,@function
addbrdv256f64:                          # @addbrdv256f64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB5_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB5_2:
	lea %s1, 256
	lvl %s1
	vfadd.d %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end5:
	.size	addbrdv256f64, .Lfunc_end5-addbrdv256f64
                                        # -- End function
	.globl	addbrdv256f32           # -- Begin function addbrdv256f32
	.p2align	4
	.type	addbrdv256f32,@function
addbrdv256f32:                          # @addbrdv256f32
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB6_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB6_2:
	lea %s1, 256
	lvl %s1
	vfadd.s %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end6:
	.size	addbrdv256f32, .Lfunc_end6-addbrdv256f32
                                        # -- End function
	.globl	addbrdv128i64           # -- Begin function addbrdv128i64
	.p2align	4
	.type	addbrdv128i64,@function
addbrdv128i64:                          # @addbrdv128i64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB7_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB7_2:
	lea %s1, 128
	lvl %s1
	vadds.l %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end7:
	.size	addbrdv128i64, .Lfunc_end7-addbrdv128i64
                                        # -- End function
	.globl	addbrdv64i64            # -- Begin function addbrdv64i64
	.p2align	4
	.type	addbrdv64i64,@function
addbrdv64i64:                           # @addbrdv64i64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB8_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB8_2:
	lea %s1, 64
	lvl %s1
	vadds.l %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end8:
	.size	addbrdv64i64, .Lfunc_end8-addbrdv64i64
                                        # -- End function
	.globl	addbrdv32i64            # -- Begin function addbrdv32i64
	.p2align	4
	.type	addbrdv32i64,@function
addbrdv32i64:                           # @addbrdv32i64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB9_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB9_2:
	or %s1, 32, (0)1
	lvl %s1
	vadds.l %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end9:
	.size	addbrdv32i64, .Lfunc_end9-addbrdv32i64
                                        # -- End function
	.globl	addbrdv16i64            # -- Begin function addbrdv16i64
	.p2align	4
	.type	addbrdv16i64,@function
addbrdv16i64:                           # @addbrdv16i64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB10_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB10_2:
	or %s1, 16, (0)1
	lvl %s1
	vadds.l %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end10:
	.size	addbrdv16i64, .Lfunc_end10-addbrdv16i64
                                        # -- End function
	.globl	addbrdv8i64             # -- Begin function addbrdv8i64
	.p2align	4
	.type	addbrdv8i64,@function
addbrdv8i64:                            # @addbrdv8i64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB11_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB11_2:
	or %s1, 8, (0)1
	lvl %s1
	vadds.l %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end11:
	.size	addbrdv8i64, .Lfunc_end11-addbrdv8i64
                                        # -- End function
	.globl	addbrdv4i64             # -- Begin function addbrdv4i64
	.p2align	4
	.type	addbrdv4i64,@function
addbrdv4i64:                            # @addbrdv4i64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB12_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB12_2:
	or %s1, 4, (0)1
	lvl %s1
	vadds.l %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end12:
	.size	addbrdv4i64, .Lfunc_end12-addbrdv4i64
                                        # -- End function
	.globl	addbrdv2i64             # -- Begin function addbrdv2i64
	.p2align	4
	.type	addbrdv2i64,@function
addbrdv2i64:                            # @addbrdv2i64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB13_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB13_2:
	or %s1, 2, (0)1
	lvl %s1
	vadds.l %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end13:
	.size	addbrdv2i64, .Lfunc_end13-addbrdv2i64
                                        # -- End function
	.globl	addbrdv128f64           # -- Begin function addbrdv128f64
	.p2align	4
	.type	addbrdv128f64,@function
addbrdv128f64:                          # @addbrdv128f64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB14_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB14_2:
	lea %s1, 128
	lvl %s1
	vfadd.d %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end14:
	.size	addbrdv128f64, .Lfunc_end14-addbrdv128f64
                                        # -- End function
	.globl	addbrdv64f64            # -- Begin function addbrdv64f64
	.p2align	4
	.type	addbrdv64f64,@function
addbrdv64f64:                           # @addbrdv64f64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB15_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB15_2:
	lea %s1, 64
	lvl %s1
	vfadd.d %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end15:
	.size	addbrdv64f64, .Lfunc_end15-addbrdv64f64
                                        # -- End function
	.globl	addbrdv32f64            # -- Begin function addbrdv32f64
	.p2align	4
	.type	addbrdv32f64,@function
addbrdv32f64:                           # @addbrdv32f64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB16_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB16_2:
	or %s1, 32, (0)1
	lvl %s1
	vfadd.d %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end16:
	.size	addbrdv32f64, .Lfunc_end16-addbrdv32f64
                                        # -- End function
	.globl	addbrdv16f64            # -- Begin function addbrdv16f64
	.p2align	4
	.type	addbrdv16f64,@function
addbrdv16f64:                           # @addbrdv16f64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB17_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB17_2:
	or %s1, 16, (0)1
	lvl %s1
	vfadd.d %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end17:
	.size	addbrdv16f64, .Lfunc_end17-addbrdv16f64
                                        # -- End function
	.globl	addbrdv8f64             # -- Begin function addbrdv8f64
	.p2align	4
	.type	addbrdv8f64,@function
addbrdv8f64:                            # @addbrdv8f64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB18_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB18_2:
	or %s1, 8, (0)1
	lvl %s1
	vfadd.d %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end18:
	.size	addbrdv8f64, .Lfunc_end18-addbrdv8f64
                                        # -- End function
	.globl	addbrdv4f64             # -- Begin function addbrdv4f64
	.p2align	4
	.type	addbrdv4f64,@function
addbrdv4f64:                            # @addbrdv4f64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB19_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB19_2:
	or %s1, 4, (0)1
	lvl %s1
	vfadd.d %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end19:
	.size	addbrdv4f64, .Lfunc_end19-addbrdv4f64
                                        # -- End function
	.globl	addbrdv2f64             # -- Begin function addbrdv2f64
	.p2align	4
	.type	addbrdv2f64,@function
addbrdv2f64:                            # @addbrdv2f64
# %bb.0:
	st %s9, (,%s11)
	st %s10, 8(,%s11)
	st %s15, 24(,%s11)
	st %s16, 32(,%s11)
	or %s9, 0, %s11
	lea %s13, -176
	and %s13, %s13, (32)0
	lea.sl %s11, -1(%s11, %s13)
	brge.l %s11, %s8, .LBB20_2
# %bb.1:
	ld %s61, 24(,%s14)
	or %s62, 0, %s0
	lea %s63, 315
	shm.l %s63, (%s61)
	shm.l %s8, 8(%s61)
	shm.l %s11, 16(%s61)
	monc
	or %s0, 0, %s62
.LBB20_2:
	or %s1, 2, (0)1
	lvl %s1
	vfadd.d %v0,%s0,%v0
	or %s11, 0, %s9
	ld %s16, 32(,%s11)
	ld %s15, 24(,%s11)
	ld %s10, 8(,%s11)
	ld %s9, (,%s11)
	b.l (,%lr)
.Lfunc_end20:
	.size	addbrdv2f64, .Lfunc_end20-addbrdv2f64
                                        # -- End function
	.section	".note.GNU-stack","",@progbits
