// RUN: %clang -target ve-unknown-linux -### %s -mvevec=simd 2>&1 | FileCheck %s -check-prefix=SIMD
// RUN: %clang -target ve-unknown-linux -### %s -mvevec simd 2>&1 | FileCheck %s -check-prefix=SIMD
// RUN: %clang -target ve-unknown-linux -### %s -mvevec=vpu 2>&1 | FileCheck %s -check-prefix=VPU
// RUN: %clang -target ve-unknown-linux -### %s -mvevec=intrin 2>&1 | FileCheck %s -check-prefix=INTRIN
// RUN: %clang -target ve-unknown-linux -### %s -mvevec=none 2>&1 | FileCheck %s -check-prefix=NONE
// RUN: %clang -target ve-unknown-linux -### %s 2>&1 | FileCheck %s -check-prefix=DEFAULT

// SIMD: "-target-feature" "+simd"
// VPU: "-target-feature" "+vpu"
// INTRIN: "-target-feature" "+intrin"
// NONE-NOT: "-target-feature"
// DEFAULT: "-target-feature" "+intrin"
