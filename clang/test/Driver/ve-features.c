// RUN: %clang -target ve-unknown-linux -### %s -mvevpu 2>&1 | FileCheck %s -check-prefix=VEVPU
// RUN: %clang -target ve-unknown-linux -### %s -mno-vevpu 2>&1 | FileCheck %s -check-prefix=NO-VEVPU
// RUN: %clang -target ve-unknown-linux -### %s -mvepacked 2>&1 | FileCheck %s -check-prefix=VEPACKED
// RUN: %clang -target ve-unknown-linux -### %s -mno-vepacked 2>&1 | FileCheck %s -check-prefix=NO-VEPACKED
// RUN: %clang -target ve-unknown-linux -### %s -mvesimd 2>&1 | FileCheck %s -check-prefix=VESIMD
// RUN: %clang -target ve-unknown-linux -### %s 2>&1 | FileCheck %s -check-prefix=DEFAULT

// VEVPU: "-target-feature" "+vpu"
// NO-VEVPU: "-target-feature" "-vpu"
// VEPACKED: "-target-feature" "+packed"
// NO-VEPACKED: "-target-feature" "-packed"
// VESIMD: "-target-feature" "+simd" "-target-feature" "-vpu" "-target-feature" "-packed"
// DEFAULT-NOT: "-target-feature"
