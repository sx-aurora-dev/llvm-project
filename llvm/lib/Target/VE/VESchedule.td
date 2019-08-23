//===-- VESchedule.td - Describe the VE Itineries ----------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
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
