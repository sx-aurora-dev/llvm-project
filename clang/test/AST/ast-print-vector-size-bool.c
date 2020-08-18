// RUN: %clang_cc1 -ast-print %s -o - | FileCheck %s

// CHECK: typedef __attribute__((__vector_size__(32 * sizeof(_Bool)))) _Bool bool256;
typedef _Bool bool256 __attribute__((vector_size(32)));
