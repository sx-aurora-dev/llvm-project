// RUN: llvm-mc -triple ve-unknown-unknown --show-encoding %s | FileCheck %s

// CHECK: svob
// CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x30]
svob
