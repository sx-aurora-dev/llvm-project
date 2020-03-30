# RUN: llvm-mc -triple ve-unknown-unknown --show-encoding %s | FileCheck %s

# CHECK: fencei
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x20]
fencei

# CHECK: fencem 1
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x20]
fencem 1

# CHECK: fencem 2
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x00,0x02,0x20]
fencem 2

# CHECK: fencem 3
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x20]
fencem 3

# CHECK: fencec 1
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x20]
fencec 1

# CHECK: fencec 2
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x02,0x00,0x20]
fencec 2

# CHECK: fencec 3
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x20]
fencec 3

# CHECK: fencec 4
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x04,0x00,0x20]
fencec 4

# CHECK: fencec 5
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x05,0x00,0x20]
fencec 5

# CHECK: fencec 6
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x06,0x00,0x20]
fencec 6

# CHECK: fencec 7
# CHECK: encoding: [0x00,0x00,0x00,0x00,0x00,0x07,0x00,0x20]
fencec 7
