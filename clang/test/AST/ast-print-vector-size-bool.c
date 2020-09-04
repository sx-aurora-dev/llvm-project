// RUN: %clang_cc1 -ast-print %s -o - | FileCheck %s

// CHECK: typedef __attribute__((__vector_size__(256))) _Bool bool32;
typedef _Bool bool32 __attribute__((vector_size(32)));
