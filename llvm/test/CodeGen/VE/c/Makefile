CLANG = $(HOME)/llvm-dev/install/bin/clang
LLC = $(HOME)/llvm-dev/install/bin/llc
CLEAN_TEST = $(HOME)/llvm-dev/llvm-project/llvm/utils/clean-test.sh
UPDATE_LLC_TEST = $(HOME)/llvm-dev/llvm-project/llvm/utils/update_llc_test_checks.py
PATCH_TEST = $(HOME)/llvm-dev/llvm-project/llvm/utils/patch-test.py

TARGETS = select.ll

all: $(TARGETS)

.SUFFIXES: .ll

.c.ll:
	$(CLANG) -target ve -O3 -S -emit-llvm $<
	$(CLEAN_TEST) $@
	sed -e '1i ; RUN: llc < %s -mtriple=ve | FileCheck %s' $@ > $@.tmp && mv $@.tmp $@
	$(UPDATE_LLC_TEST) --llc-binary=$(LLC) $@
	grep -v '; NOTE:' $@ > $@.tmp && mv $@.tmp $@
#	$(PATCH_TEST) $@

all: select.ll

clean: FORCE
	rm -f $(TARGETS)

FORCE:
