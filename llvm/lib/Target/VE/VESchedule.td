//===-- VESchedule.td - Describe the VE Itineries ----------*- tablegen -*-===//
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

/*
def ALU_FU  : FuncUnit;
def LDST_FU : FuncUnit;

def VE_ALU  : InstrItinClass;
def VE_LD   : InstrItinClass;
def VE_ST   : InstrItinClass;

def VEItinerary : ProcessorItineraries<[ALU_FU, LDST_FU],[],[
  // InstrItinData<VE_LD,   [InstrStage<1, [LDST_FU]>]>,
  // InstrItinData<VE_ST,   [InstrStage<1, [LDST_FU]>]>,
  //   InstrItinData<VE_LDSW, [InstrStage<2, [LDST_FU]>]>,
  //   InstrItinData<VE_STSW, [InstrStage<2, [LDST_FU]>]>,
  InstrItinData<VE_ALU,  [InstrStage<1, [ALU_FU]>]>
]>;
*/
