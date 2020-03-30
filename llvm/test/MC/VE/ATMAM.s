# RUN: llvm-mc -triple ve-unknown-unknown --show-encoding %s | FileCheck %s

# CHECK: atmam %s20, 20(%s11), %s32
# CHECK: encoding: [0x14,0x00,0x00,0x00,0x8b,0xa0,0x14,0x53]
atmam %s20, 20(%s11), %s32

# CHECK: atmam %s20, 8192, 0
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x00,0x00,0x14,0x53]
atmam %s20, 8192, 0

# CHECK: atmam %s20, 8192, 1
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x00,0x01,0x14,0x53]
atmam %s20, 8192, 1

# CHECK: atmam %s20, 8192, 2
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x00,0x02,0x14,0x53]
atmam %s20, 8192, 2

# CHECK: atmam %s20, 8192, 127
# CHECK: encoding: [0x00,0x20,0x00,0x00,0x00,0x7f,0x14,0x53]
atmam %s20, 8192, 127
