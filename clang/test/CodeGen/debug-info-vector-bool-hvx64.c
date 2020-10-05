// RUN: %clang_cc1 -triple hexagon-unknown-elf -target-cpu hexagonv65 -target-feature +hvxv65 -target-feature +hvx-length64b -emit-llvm -debug-info-kind=limited %s -o - | FileCheck %s
typedef _Bool bool4 __attribute__((__vector_size__(4)));

bool4 b;

// Test that we get byte-sized bool elements on Hexagon
// CHECK: !DICompositeType(tag: DW_TAG_array_type,
// CHECK-SAME:             baseType: ![[BOOL:[0-9]+]]
// CHECK-SAME:             size: 256
// CHECK-SAME:             DIFlagVector
// CHECK: ![[BOOL]] = !DIBasicType(name: "_Bool"
