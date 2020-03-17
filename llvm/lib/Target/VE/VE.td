//===-- VE.td - Describe the VE Target Machine -------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Target-independent interfaces which we are implementing
//===----------------------------------------------------------------------===//

include "llvm/Target/Target.td"

//===----------------------------------------------------------------------===//
// VE Subtarget features.
//

def FeaturePackedMode
  : SubtargetFeature<"packed", "PackedMode", "true",
                     "Enable v512 packed mode (experimental)">;

def FeatureVPU
  : SubtargetFeature<"vpu", "EnableVPU", "true",
                     "Use the VPU">;

//===----------------------------------------------------------------------===//
// Register File, Calling Conv, Instruction Descriptions
//===----------------------------------------------------------------------===//

include "VERegisterInfo.td"
include "VECallingConv.td"
include "VESchedule.td"
include "VEInstrInfo.td"

def VEInstrInfo : InstrInfo;

def VEAsmParser : AsmParser {
  bit ShouldEmitMatchRegisterName = 0;
}

//===----------------------------------------------------------------------===//
// VE processors supported.
//===----------------------------------------------------------------------===//

class Proc<string Name, list<SubtargetFeature> Features>
 : Processor<Name, NoItineraries, Features>;

def : Proc<"ve",             []>;

//===----------------------------------------------------------------------===//
// Declare the target which we are implementing
//===----------------------------------------------------------------------===//

def VEAsmWriter : AsmWriter {
  string AsmWriterClassName  = "InstPrinter";
  int PassSubtarget = 1;
  int Variant = 0;
}

def VE : Target {
  // Pull in Instruction Info:
  let InstructionSet = VEInstrInfo;
  let AssemblyParsers  = [VEAsmParser];
  let AssemblyWriters = [VEAsmWriter];
  let AllowRegisterRenaming = 1;
}
