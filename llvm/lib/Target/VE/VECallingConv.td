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
  // i32 f32 i64 f64 arguments get passed in generic registers
  // if there is space.
  CCIfType<[i32, f32, i64, f64],
           CCAssignToReg<[S0, S1, S2, S3, S4, S5, S6, S7]>>,

  // Alternatively, they are assigned to the stack in 8-byte aligned units.
  CCAssignToStack<8, 8>
]>;

def RetCC_VE : CallingConv<[
  CCIfType<[i32, f32, i64, f64],
           CCAssignToReg<[S0, S1, S2, S3, S4, S5, S6, S7]>>
]>;

// Callee-saved registers are handled by the register window mechanism.
def CSR : CalleeSavedRegs<(add)> {
  let OtherPreserved = (sequence "S%u", 18, 33);
}
