# RUN: llvm-mc -triple ve-unknown-unknown --show-encoding %s | FileCheck %s

# CHECK: nnd %s11, %s11, %s11
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x8b,0x8b,0x0b,0x54]
nnd %s11, %s11, %s11

# CHECK: nnd %s11, 63, %s11
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x8b,0x3f,0x0b,0x54]
nnd %s11, 63, %s11

# CHECK: nnd %s11, -1, %s11
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x8b,0x7f,0x0b,0x54]
nnd %s11, -1, %s11

# CHECK: nnd %s11, -64, %s11
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x8b,0x40,0x0b,0x54]
nnd %s11, -64, %s11

# CHECK: nnd %s11, -64, (32)1
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x20,0x40,0x0b,0x54]
nnd %s11, -64, (32)1

# CHECK: nnd %s11, 63, (32)0
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x60,0x3f,0x0b,0x54]
nnd %s11, 63, (32)0
