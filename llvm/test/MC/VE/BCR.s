# RUN: llvm-mc -triple ve-unknown-unknown --show-encoding %s | FileCheck %s

# CHECK: br.l 8199
# CHECK: encoding: [0x07,0x20,0x00,0x00,0x00,0x00,0x0f,0x18]
br.l 8199

# CHECK: br.w.t -224
# CHECK: encoding: [0x20,0xff,0xff,0xff,0x00,0x00,0xbf,0x18]
br.w.t -224

# CHECK: braf.d.nt 224
# CHECK: encoding: [0xe0,0x00,0x00,0x00,0x00,0x00,0x60,0x18]
braf.d.nt 224

# CHECK: brgt.s 23, %s20, 224
# CHECK: encoding: [0xe0,0x00,0x00,0x00,0x94,0x17,0xc1,0x18]
brgt.s 23, %s20, 224

# CHECK: brlt.l.t 23, %s20, -224
# CHECK: encoding: [0x20,0xff,0xff,0xff,0x94,0x17,0x32,0x18]
brlt.l.t 23, %s20, -224

# CHECK: brne.w.nt 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0xa3,0x18]
brne.w.nt 23, %s20, 8192

# CHECK: breq.d 23, %s20, -224
# CHECK: encoding: [0x20,0xff,0xff,0xff,0x94,0x17,0x44,0x18]
breq.d 23, %s20, -224

# CHECK: brge.s.t 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0xf5,0x18]
brge.s.t 23, %s20, 8192

# CHECK: brle.l.nt 23, %s20, 224
# CHECK: encoding: [0xe0,0x00,0x00,0x00,0x94,0x17,0x26,0x18]
brle.l.nt 23, %s20, 224

# CHECK: brnum.d 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0x47,0x18]
brnum.d 23, %s20, 8192

# CHECK: brnan.s.t 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0xf8,0x18]
brnan.s.t 23, %s20, 8192

# CHECK: brgtnan.d.nt 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0x69,0x18]
brgtnan.d.nt 23, %s20, 8192

# CHECK: brltnan.s 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0xca,0x18]
brltnan.s 23, %s20, 8192

# CHECK: brnenan.d.t 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0x7b,0x18]
brnenan.d.t 23, %s20, 8192

# CHECK: breqnan.s.nt 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0xec,0x18]
breqnan.s.nt 23, %s20, 8192

# CHECK: brgenan.d 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0x4d,0x18]
brgenan.d 23, %s20, 8192

# CHECK: brlenan.s.t 23, %s20, 8192
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x94,0x17,0xfe,0x18]
brlenan.s.t 23, %s20, 8192
