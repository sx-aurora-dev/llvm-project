//===-- VECallingConv.td - Calling Conventions VE ----------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This describes the calling conventions for the VE architectures.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Aurora VE
//===----------------------------------------------------------------------===//

def CC_VE : CallingConv<[
  // all arguments get passed in generic registers if there is space.

  // Promote i1/i8/i16 arguments to i32.
  CCIfType<[i1, i8, i16], CCPromoteToType<i32>>,

  // bool, char, int, enum, long --> generic integer 32 bit registers
  CCIfType<[i32], CCAssignToRegWithShadow<
    [SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7],
    [SX0, SX1, SX2, SX3, SX4, SX5, SX6, SX7]>>,

  // float --> generic floating point 32 bit registers
  CCIfType<[f32], CCAssignToRegWithShadow<
    [SF0, SF1, SF2, SF3, SF4, SF5, SF6, SF7],
    [SX0, SX1, SX2, SX3, SX4, SX5, SX6, SX7]>>,

  // long long/double --> generic 64 bit registers
  CCIfType<[i64, f64],
           CCAssignToReg<[SX0, SX1, SX2, SX3, SX4, SX5, SX6, SX7]>>,

  // long double --> pair of generic 64 bit registers
  //
  // NOTE: If Q1 is allocated, SX1 should not be used for following arguments,
  //       so masking them like below.
  CCIfType<[f128],
           CCAssignToRegWithShadow<[Q0, Q1, Q2, Q3],
                                   [SX0, SX1, SX3, SX5]>>,
  CCIfType<[f128], CCAssignToStackWithShadow<16, 16, [SX7]>>,

  // Alternatively, they are assigned to the stack in 8-byte aligned units.
  CCAssignToStack<8, 8>
]>;

def CC_VE2 : CallingConv<[
  // all arguments get passed in stack
  CCIfType<[f128], CCAssignToStack<16, 16>>,

  // Alternatively, they are assigned to the stack in 8-byte aligned units.
  CCAssignToStack<8, 8>
]>;

def RetCC_VE : CallingConv<[
  // Promote i1/i8/i16 arguments to i32.
  CCIfType<[i1, i8, i16], CCPromoteToType<i32>>,

  // bool, char, int, enum, long --> generic integer 32 bit registers
  CCIfType<[i32], CCAssignToRegWithShadow<
    [SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7],
    [SX0, SX1, SX2, SX3, SX4, SX5, SX6, SX7]>>,

  // float --> generic floating point 32 bit registers
  CCIfType<[f32], CCAssignToRegWithShadow<
    [SF0, SF1, SF2, SF3, SF4, SF5, SF6, SF7],
    [SX0, SX1, SX2, SX3, SX4, SX5, SX6, SX7]>>,

  // long long/double --> generic 64 bit registers
  CCIfType<[i64, f64],
           CCAssignToReg<[SX0, SX1, SX2, SX3, SX4, SX5, SX6, SX7]>>,

  // long double --> pair of generic 64 bit registers
  CCIfType<[f128],
           CCAssignToReg<[Q0, Q1, Q2, Q3]>>
]>;

// Callee-saved registers
def CSR : CalleeSavedRegs<(add (sequence "SX%u", 18, 33))>;

// vec_expf destroys s0, s1, s5, s6, s11, s61, s62, s63, v0-6, and vm6
def CSR_vec_expf : CalleeSavedRegs<(add (sequence "SX%u", 2, 4),
                                        (sequence "SX%u", 7, 10),
                                        (sequence "SX%u", 12, 60),
                                        (sequence "V%u", 7, 63),
                                        (sequence "VM%u", 1, 5),
                                        (sequence "VM%u", 7, 15))>;
