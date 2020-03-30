# RUN: llvm-mc -triple ve-unknown-unknown --show-encoding %s | FileCheck %s

# CHECK: cvt.d.q %s11, %s12
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x8c,0x8b,0x0f]
cvt.d.q %s11, %s12

# CHECK: cvt.d.q %s11, 63
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x3f,0x8b,0x0f]
cvt.d.q %s11, 63

# CHECK: cvt.d.q %s11, -64
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x40,0x8b,0x0f]
cvt.d.q %s11, -64

# CHECK: cvt.d.q %s11, -1
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x7f,0x8b,0x0f]
cvt.d.q %s11, -1
