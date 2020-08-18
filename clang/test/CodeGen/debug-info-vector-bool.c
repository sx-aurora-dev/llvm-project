// RUN: %clang_cc1 -emit-llvm -debug-info-kind=limited %s -o - | FileCheck %s
typedef _Bool bool32 __attribute__((__vector_size__(4)));

bool32 b;

// Test that we get an char array type.
// CHECK: !DICompositeType(tag: DW_TAG_array_type,
// CHECK-SAME:             baseType: ![[CHAR:[0-9]+]]
// CHECK-SAME:             size: 32
// CHECK-SAME:             DIFlagVector
// CHECK: ![[CHAR]] = !DIBasicType(name: "char"
