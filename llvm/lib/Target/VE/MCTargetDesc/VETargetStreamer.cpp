//===-- VETargetStreamer.cpp - VE Target Streamer Methods -----------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file provides VE specific target streamer methods.
//
//===----------------------------------------------------------------------===//

#include "VETargetStreamer.h"
#include "InstPrinter/VEInstPrinter.h"
#include "llvm/Support/FormattedStream.h"

using namespace llvm;

// pin vtable to this file
VETargetStreamer::VETargetStreamer(MCStreamer &S) : MCTargetStreamer(S) {}

void VETargetStreamer::anchor() {}

VETargetAsmStreamer::VETargetAsmStreamer(MCStreamer &S,
                                               formatted_raw_ostream &OS)
    : VETargetStreamer(S), OS(OS) {}

void VETargetAsmStreamer::emitVERegisterIgnore(unsigned reg) {
  OS << "\t.register "
     << "%" << StringRef(VEInstPrinter::getRegisterName(reg)).lower()
     << ", #ignore\n";
}

void VETargetAsmStreamer::emitVERegisterScratch(unsigned reg) {
  OS << "\t.register "
     << "%" << StringRef(VEInstPrinter::getRegisterName(reg)).lower()
     << ", #scratch\n";
}

VETargetELFStreamer::VETargetELFStreamer(MCStreamer &S)
    : VETargetStreamer(S) {}

MCELFStreamer &VETargetELFStreamer::getStreamer() {
  return static_cast<MCELFStreamer &>(Streamer);
}
