//===-- VE.td - Describe the VE Target Machine -------------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
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
// def : Processor<"ve", VEItinerary, []>;
// def : ProcessorModel<"ve", VESchedModel, []>;

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
