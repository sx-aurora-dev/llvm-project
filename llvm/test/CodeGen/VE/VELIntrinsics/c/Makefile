INSTALLPATH = $(HOME)/llvm-dev/install
LLVMSRCPATH = ../../../../..

CLANG = $(INSTALLPATH)/bin/clang
CLANGXX = $(INSTALLPATH)/bin/clang++
CFLAGS = -target ve -O3 -ffast-math
LLC = $(INSTALLPATH)/bin/llc
LLC = $(HOME)/llvm-dev/build/bin/llc
CLEAN_TEST = $(LLVMSRCPATH)/utils/clean-test.sh
UPDATE_LLC_TEST = $(LLVMSRCPATH)/utils/update_llc_test_checks.py
PATCH_TEST = $(LLVMSRCPATH)/utils/patch-test.py

LDSTMV_TARGETS = vld.ll vst.ll pfchv.ll lsv.ll lvm.ll vbrd.ll vmv.ll vgt.ll \
	vsc.ll
ARITH_TARGETS = vadd.ll vsub.ll vmul.ll vdiv.ll vcmp.ll vmax.ll vmin.ll
LOGICAL_TARGETS = vand.ll vor.ll vxor.ll veqv.ll vseq.ll
SHIFT_TARGETS = vsll.ll vsrl.ll vsla.ll vsra.ll vsfa.ll
FP_ARITH_TARGETS = vfadd.ll vfsub.ll vfmul.ll vfdiv.ll vfsqrt.ll vfcmp.ll \
	vfmax.ll vfmin.ll vfmad.ll vfmsb.ll vfnmad.ll vfnmsb.ll vrcp.ll vrsqrt.ll \
	vcvt.ll vfrmax.ll vfrmin.ll
MERGER_TARGETS = vmrg.ll vshf.ll vcp.ll vex.ll
MASK_TARGETS = vfmk.ll andm.ll orm.ll xorm.ll eqvm.ll nndm.ll negm.ll pcvm.ll \
	lzvm.ll tovm.ll
REDUCTION_TARGETS = vsum.ll vfsum.ll vrmax.ll vrmin.ll vrand.ll vror.ll vrxor.ll
CR_TARGETS = lcr.ll
TRANSFER_TARGETS = svob.ll
OTHERS_TARGETS = pack.ll extract.ll insert.ll

TARGETS = $(LDSTMV_TARGETS) $(ARITH_TARGETS) $(LOGICAL_TARGETS) \
	$(SHIFT_TARGETS) $(FP_ARITH_TARGETS) $(MERGER_TARGETS) $(MASK_TARGETS) \
	$(REDUCTION_TARGETS) $(CR_TARGETS) $(TRANSFER_TARGETS) $(OTHERS_TARGETS)

all: $(TARGETS)

.SUFFIXES: .ll

.c.ll:
	$(CLANG) $(CFLAGS) -S -emit-llvm $<
	$(CLEAN_TEST) $@
	-grep '///' $< > /dev/null && (echo; grep '///' $<) | sed -e 's:///:;;;:' | cat - $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve -mattr=+vpu | FileCheck %s' -e 's:x86_fastcallcc:fastcc:' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@
	$(PATCH_TEST) $@

.cpp.ll:
	$(CLANGXX) $(CFLAGS) -S -emit-llvm $<
	$(CLEAN_TEST) $@
	-grep '///' $< > /dev/null && (echo; grep '///' $<) | sed -e 's:///:;;;:' | cat - $@ > $@.tmp && mv $@.tmp $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve -mattr=+vpu | FileCheck %s' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@
	$(PATCH_TEST) $@

clean: FORCE
	rm -f $(TARGETS)

FORCE:
