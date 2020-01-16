//===-- VECallingConv.td - Calling Conventions VE ----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This describes the calling conventions for the VE architectures.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Aurora VE
//===----------------------------------------------------------------------===//
def CC_VE_C_Stack: CallingConv<[
  // F128 are assigned to the stack in 16-byte aligned units
  CCIfType<[f128], CCAssignToStackWithShadow<16, 16, [SX7]>>,

  // float --> need special handling like below.
  //    0      4
  //    +------+------+
  //    | empty| float|
  //    +------+------+
  CCIfType<[f32], CCCustom<"allocateFloat">>,

  // All of the rest are assigned to the stack in 8-byte aligned units.
  CCAssignToStack<0, 8>
]>;

def CC_VE : CallingConv<[
  // All arguments get passed in generic registers if there is space.

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
  // NOTE: If Q1 is allocated while SX1 is free, llvm tries to allocate SX1 for
  //       following operands, this masks SX1 to avoid such behavior.
  CCIfType<[f128],
           CCAssignToRegWithShadow<[Q0, Q1, Q2, Q3],
                                   [SX0, SX1, SX3, SX5]>>,

  // Alternatively, they are assigned to the stack in 8-byte aligned units.
  CCDelegateTo<CC_VE_C_Stack>
]>;

// All arguments get passed in stack for varargs function or non-prototyped
// function.
def CC_VE2 : CallingConv<[
  // F128 are assigned to the stack in 16-byte aligned units
  CCIfType<[f128], CCAssignToStack<16, 16>>,

  // float --> need special handling like below.
  //    0      4
  //    +------+------+
  //    | empty| float|
  //    +------+------+
  CCIfType<[f32], CCCustom<"allocateFloat">>,

  CCAssignToStack<0, 8>
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
           CCAssignToRegWithShadow<[Q0, Q1, Q2, Q3],
                                   [SX0, SX1, SX3, SX5]>>,
]>;

// Callee-saved registers
def CSR : CalleeSavedRegs<(add (sequence "SX%u", 18, 33))>;
def CSR_NoRegs : CalleeSavedRegs<(add)>;

// vec_expf destroys s0, s1, s5, s6, s11, s61, s62, s63
def CSR_vec_expf : CalleeSavedRegs<(add (sequence "SX%u", 2, 4),
                                        (sequence "SX%u", 7, 10),
                                        (sequence "SX%u", 12, 60)
                                        )>;

// llvm_grow_stack destroys s62 and s63
def CSR_llvm_grow_stack : CalleeSavedRegs<(add (sequence "SX%u", 0, 61)
                                               )>;
