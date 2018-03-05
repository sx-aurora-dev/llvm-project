//===-- VETargetStreamer.h - VE Target Streamer ----------------*- C++ -*--===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_SPARC_SPARCTARGETSTREAMER_H
#define LLVM_LIB_TARGET_SPARC_SPARCTARGETSTREAMER_H

#include "llvm/MC/MCELFStreamer.h"
#include "llvm/MC/MCStreamer.h"

namespace llvm {
class VETargetStreamer : public MCTargetStreamer {
  virtual void anchor();

public:
  VETargetStreamer(MCStreamer &S);
  /// Emit ".register <reg>, #ignore".
  virtual void emitVERegisterIgnore(unsigned reg) = 0;
  /// Emit ".register <reg>, #scratch".
  virtual void emitVERegisterScratch(unsigned reg) = 0;
};

// This part is for ascii assembly output
class VETargetAsmStreamer : public VETargetStreamer {
  formatted_raw_ostream &OS;

public:
  VETargetAsmStreamer(MCStreamer &S, formatted_raw_ostream &OS);
  void emitVERegisterIgnore(unsigned reg) override;
  void emitVERegisterScratch(unsigned reg) override;

};

// This part is for ELF object output
class VETargetELFStreamer : public VETargetStreamer {
public:
  VETargetELFStreamer(MCStreamer &S);
  MCELFStreamer &getStreamer();
  void emitVERegisterIgnore(unsigned reg) override {}
  void emitVERegisterScratch(unsigned reg) override {}
};
} // end namespace llvm

#endif
