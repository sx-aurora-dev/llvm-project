INSTALLPATH = $(HOME)/llvm-dev/install
LLVMSRCPATH = ../../../..

CLANG = $(INSTALLPATH)/bin/clang
LLC = $(INSTALLPATH)/bin/llc
CLEAN_TEST = $(LLVMSRCPATH)/utils/clean-test.sh
UPDATE_LLC_TEST = $(LLVMSRCPATH)/utils/update_llc_test_checks.py
PATCH_TEST = $(LLVMSRCPATH)/utils/patch-test.py

TARGETS = select.ll

all: $(TARGETS)

.SUFFIXES: .ll

.c.ll:
	$(CLANG) -target ve -O3 -S -emit-llvm $<
	$(CLEAN_TEST) $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve | FileCheck %s' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@
#	grep -v '; NOTE:' $@ > $@.tmp && mv $@.tmp $@
	$(PATCH_TEST) $@

clean: FORCE
	rm -f $(TARGETS)

FORCE:
