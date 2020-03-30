# RUN: llvm-mc -triple ve-unknown-unknown --show-encoding %s | FileCheck %s

# CHECK: cvt.w.s.sx %s11, %s12
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x8c,0x8b,0x4e]
cvt.w.s.sx %s11, %s12

# CHECK: cvt.w.s.sx.rz %s11, 63
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x08,0x3f,0x8b,0x4e]
cvt.w.s.sx.rz %s11, 63

# CHECK: cvt.w.s.sx.rp %s11, -64
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x09,0x40,0x8b,0x4e]
cvt.w.s.sx.rp %s11, -64

# CHECK: cvt.w.s.sx.rm %s11, -1
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x0a,0x7f,0x8b,0x4e]
cvt.w.s.sx.rm %s11, -1

# CHECK: cvt.w.s.sx.rn %s11, 7
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x0b,0x07,0x8b,0x4e]
cvt.w.s.sx.rn %s11, 7

# CHECK: cvt.w.s.sx.ra %s11, %s63
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x0c,0xbf,0x8b,0x4e]
cvt.w.s.sx.ra %s11, %s63

# CHECK: cvt.w.s.zx %s11, %s12
# CHECK: encoding: [0x80,0x00,0x00,0x00,0x00,0x8c,0x8b,0x4e]
cvt.w.s.zx %s11, %s12

# CHECK: cvt.w.s.zx.rz %s11, 63
# CHECK: encoding: [0x80,0x00,0x00,0x00,0x08,0x3f,0x8b,0x4e]
cvt.w.s.zx.rz %s11, 63

# CHECK: cvt.w.s.zx.rp %s11, -64
# CHECK: encoding: [0x80,0x00,0x00,0x00,0x09,0x40,0x8b,0x4e]
cvt.w.s.zx.rp %s11, -64

# CHECK: cvt.w.s.zx.rm %s11, -1
# CHECK: encoding: [0x80,0x00,0x00,0x00,0x0a,0x7f,0x8b,0x4e]
cvt.w.s.zx.rm %s11, -1

# CHECK: cvt.w.s.zx.rn %s11, 7
# CHECK: encoding: [0x80,0x00,0x00,0x00,0x0b,0x07,0x8b,0x4e]
cvt.w.s.zx.rn %s11, 7

# CHECK: cvt.w.s.zx.ra %s11, %s63
# CHECK: encoding: [0x80,0x00,0x00,0x00,0x0c,0xbf,0x8b,0x4e]
cvt.w.s.zx.ra %s11, %s63
