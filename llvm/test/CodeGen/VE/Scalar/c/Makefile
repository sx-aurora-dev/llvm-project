INSTALLPATH = $(HOME)/llvm-dev/install
LLVMSRCPATH = ../../../../..

CLANG = $(INSTALLPATH)/bin/clang
CLANGXX = $(INSTALLPATH)/bin/clang++
CFLAGS = -target ve -O3 -ffast-math
LLC = $(INSTALLPATH)/bin/llc
CLEAN_TEST = $(LLVMSRCPATH)/utils/clean-test.sh
UPDATE_LLC_TEST = $(LLVMSRCPATH)/utils/update_llc_test_checks.py
PATCH_TEST = $(LLVMSRCPATH)/utils/patch-test.py

IOP_TARGETS = shl.ll shr.ll brcond.ll br_cc.ll select.ll select_cc.ll setcc.ll
FOP_TARGETS = fp_add.ll fp_sub.ll fp_mul.ll fp_div.ll fp_fneg.ll fp_fdiv.ll \
              fp_frem.ll
FMATH_TARGETS = fabs.ll fcopysign.ll fcos.ll fma.ll fsin.ll fsqrt.ll \
	minnum.ll maxnum.ll pow.ll
ATOMIC_TARGETS = atomic_fence.ll atomic_load.ll atomic_store.ll \
                 atomic_cmp_swap.ll atomic_swap.ll
STACKFRAME_TARGETS = stackframe_call.ll stackframe_nocall.ll
STACK_TARGETS = load_stk.ll store_stk.ll

TARGETS = $(IOP_TARGETS) $(FOP_TARGETS) $(FMATH_TARGETS) $(ATOMIC_TARGETS) \
          $(STACKFRAME_TARGETS) $(STACK_TARGETS) \
          br_jt.ll brind.ll \
          fp_ceil.ll \
          fp_exp.ll fp_exp2.ll fp_floor.ll \
          fp_fma.ll fp_llrint.ll fp_llround.ll       \
          fp_log.ll fp_log10.ll fp_log2.ll           \
          fp_lrint.ll fp_lround.ll fp_nearbyint.ll   \
          fp_rint.ll fp_round.ll fp_roundeven.ll \
          fp_trunc.ll                     \
          selectcc_int1.ll  \
          selectcc_int8.ll   selectcc_uint8.ll   \
          selectcc_int16.ll  selectcc_uint16.ll  \
          selectcc_int32.ll  selectcc_uint32.ll  \
          selectcc_int64.ll  selectcc_uint64.ll  \
          selectcc_int128.ll selectcc_uint128.ll \
          selectcc_float.ll  selectcc_fcomp.ll   \
          selectcc_double.ll selectcc_dcomp.ll   \
          selectcc_quad.ll   selectcc_qcomp.ll

all: $(TARGETS)

.SUFFIXES: .ll

.c.ll:
	$(CLANG) $(CFLAGS) -S -emit-llvm $<
	$(CLEAN_TEST) $@
	-grep '///' $< > /dev/null && (echo; grep '///' $<) | sed -e 's:///:;;;:' | cat - $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve | FileCheck %s' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@
	$(PATCH_TEST) $@

.cpp.ll:
	$(CLANGXX) $(CFLAGS) -S -emit-llvm $<
	$(CLEAN_TEST) $@
	-grep '///' $< > /dev/null && (echo; grep '///' $<) | sed -e 's:///:;;;:' | cat - $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve | FileCheck %s' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@
	$(PATCH_TEST) $@

fp_roundeven.ll: fp_round.ll
	sed -e 's/llvm\.round/llvm.roundeven/' -e 's/fp_roundf/fp_roundevenf/' $? > $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@
	$(PATCH_TEST) $@

stackframe_call.ll : stackframe_call.c
	$(CLANG) $(CFLAGS) -S -emit-llvm $<
	sed -e '/^!2 /d' $@ > $@.tmp && mv $@.tmp $@
	$(CLEAN_TEST) $@
	-grep '///' $< > /dev/null && (echo; grep '///' $<) | sed -e 's:///:;;;:' | cat - $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve -relocation-model=pic \\\n; RUN:     | FileCheck %s --check-prefix=PIC' $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve | FileCheck %s' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@

stackframe_nocall.ll : stackframe_nocall.c
	$(CLANG) $(CFLAGS) -S -emit-llvm $<
	sed -e '/^!2 /d' $@ > $@.tmp && mv $@.tmp $@
	$(CLEAN_TEST) $@
	-grep '///' $< > /dev/null && (echo; grep '///' $<) | sed -e 's:///:;;;:' | cat - $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve -relocation-model=pic \\\n; RUN:     | FileCheck %s --check-prefix=PIC' $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve | FileCheck %s' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@

store_stk.ll : store_stk.c
	$(CLANG) $(CFLAGS) -S -emit-llvm $<
	sed -e '/^!2 /d' $@ > $@.tmp && mv $@.tmp $@
	$(CLEAN_TEST) $@
	-grep '///' $< > /dev/null && (echo; grep '///' $<) | sed -e 's:///:;;;:' | cat - $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve | FileCheck %s' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@

load_stk.ll : load_stk.c
	$(CLANG) $(CFLAGS) -S -emit-llvm $<
	sed -e '/^!2 /d' $@ > $@.tmp && mv $@.tmp $@
	$(CLEAN_TEST) $@
	-grep '///' $< > /dev/null && (echo; grep '///' $<) | sed -e 's:///:;;;:' | cat - $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve | FileCheck %s' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@

clean: FORCE
	rm -f $(TARGETS)

FORCE:
