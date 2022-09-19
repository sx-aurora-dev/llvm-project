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

VRCALL_TARGETS = vr_call_1_8.ll

TARGETS = $(VRCALL_TARGETS)

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
