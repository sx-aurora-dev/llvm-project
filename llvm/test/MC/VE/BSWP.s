# RUN: llvm-mc -triple ve-unknown-unknown --show-encoding %s | FileCheck %s

# CHECK: bswp %s11, %s11, %s11
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x8b,0x8b,0x0b,0x2b]
bswp %s11, %s11, %s11

# CHECK: bswp %s11, %s11, 63
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x8b,0x3f,0x0b,0x2b]
bswp %s11, %s11, 63

# CHECK: bswp %s11, %s11, -1
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x8b,0x7f,0x0b,0x2b]
bswp %s11, %s11, -1

# CHECK: bswp %s11, %s11, -64
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x8b,0x40,0x0b,0x2b]
bswp %s11, %s11, -64

# CHECK: bswp %s11, (32)1, -64
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x20,0x40,0x0b,0x2b]
bswp %s11, (32)1, -64

# CHECK: bswp %s11, (32)0, 63
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x60,0x3f,0x0b,0x2b]
bswp %s11, (32)0, 63
