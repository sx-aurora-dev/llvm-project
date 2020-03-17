// RUN: %clang -target ve-unknown-linux -### %s -mvevpu 2>&1 | FileCheck %s -check-prefix=VEVPU
// RUN: %clang -target ve-unknown-linux -### %s -mno-vevpu 2>&1 | FileCheck %s -check-prefix=NO-VEVPU
// RUN: %clang -target ve-unknown-linux -### %s 2>&1 | FileCheck %s -check-prefix=DEFAULT

// VEVPU: "-target-feature" "+vpu"
// NO-VEVPU: "-target-feature" "-vpu"
// DEFAULT: "-target-feature" "+vpu"
