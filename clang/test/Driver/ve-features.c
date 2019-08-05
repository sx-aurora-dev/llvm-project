// RUN: %clang -target ve-unknown-linux -### %s -mvevec 2>&1 | FileCheck %s -check-prefix=VEVEC
// RUN: %clang -target ve-unknown-linux -### %s -mno-vevec 2>&1 | FileCheck %s -check-prefix=NO-VEVEC
// RUN: %clang -target ve-unknown-linux -### %s 2>&1 | FileCheck %s -check-prefix=DEFAULT

// VEVEC: "-target-feature" "+vec"
// NO-VEVEC: "-target-feature" "-vec"
// DEFAULT: "-target-feature" "-vec"
