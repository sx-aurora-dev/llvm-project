//===-- VEAsmParser.cpp - Parse VE assembly to MCInst instructions --------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/VEMCExpr.h"
#include "MCTargetDesc/VEMCTargetDesc.h"
#include "TargetInfo/VETargetInfo.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/ADT/Triple.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCExpr.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCObjectFileInfo.h"
#include "llvm/MC/MCParser/MCAsmLexer.h"
#include "llvm/MC/MCParser/MCAsmParser.h"
#include "llvm/MC/MCParser/MCParsedAsmOperand.h"
#include "llvm/MC/MCParser/MCTargetAsmParser.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/Support/Casting.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/SMLoc.h"
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"
#include <algorithm>
#include <cassert>
#include <cstdint>
#include <memory>

using namespace llvm;

// The generated AsmMatcher VEGenAsmMatcher uses "VE" as the target
// namespace. But SPARC backend uses "SP" as its namespace.
namespace llvm {
namespace VE {

    using namespace VE;

} // end namespace VE
} // end namespace llvm

namespace {

class VEOperand;

class VEAsmParser : public MCTargetAsmParser {
  MCAsmParser &Parser;

  /// @name Auto-generated Match Functions
  /// {

#define GET_ASSEMBLER_HEADER
#include "VEGenAsmMatcher.inc"

  /// }

  // public interface of the MCTargetAsmParser.
  bool MatchAndEmitInstruction(SMLoc IDLoc, unsigned &Opcode,
                               OperandVector &Operands, MCStreamer &Out,
                               uint64_t &ErrorInfo,
                               bool MatchingInlineAsm) override;
  bool ParseRegister(unsigned &RegNo, SMLoc &StartLoc, SMLoc &EndLoc) override;
  int parseRegisterName(unsigned (*matchFn)(StringRef));
  OperandMatchResultTy tryParseRegister(unsigned &RegNo, SMLoc &StartLoc,
                                        SMLoc &EndLoc) override;
  bool ParseInstruction(ParseInstructionInfo &Info, StringRef Name,
                        SMLoc NameLoc, OperandVector &Operands) override;
  bool ParseDirective(AsmToken DirectiveID) override;

  unsigned validateTargetOperandClass(MCParsedAsmOperand &Op,
                                      unsigned Kind) override;

  // Custom parse functions for VE specific operands.
  OperandMatchResultTy parseMEMOperand(OperandVector &Operands);

  OperandMatchResultTy parseOperand(OperandVector &Operands, StringRef Name);

  OperandMatchResultTy parseVEAsmOperand(std::unique_ptr<VEOperand> &Operand);

  // Helper function for dealing with %lo / %hi in PIC mode.
  const VEMCExpr *adjustPICRelocation(VEMCExpr::VariantKind VK,
                                         const MCExpr *subExpr);

  bool matchVEAsmModifiers(const MCExpr *&EVal, SMLoc &EndLoc);
  bool parseDirectiveWord(unsigned Size, SMLoc L);

  bool is64Bit() const {
    return getSTI().getTargetTriple().getArch() == Triple::sparcv9;
  }

public:
  VEAsmParser(const MCSubtargetInfo &sti, MCAsmParser &parser,
                const MCInstrInfo &MII,
                const MCTargetOptions &Options)
      : MCTargetAsmParser(Options, sti, MII), Parser(parser) {
    // Initialize the set of available features.
    setAvailableFeatures(ComputeAvailableFeatures(getSTI().getFeatureBits()));
  }
};

} // end anonymous namespace

  static const MCPhysReg I64Regs[64] = {
    VE::SX0,  VE::SX1,  VE::SX2,  VE::SX3,
    VE::SX4,  VE::SX5,  VE::SX6,  VE::SX7,
    VE::SX8,  VE::SX9,  VE::SX10, VE::SX11,
    VE::SX12, VE::SX13, VE::SX14, VE::SX15,
    VE::SX16, VE::SX17, VE::SX18, VE::SX19,
    VE::SX20, VE::SX21, VE::SX22, VE::SX23,
    VE::SX24, VE::SX25, VE::SX26, VE::SX27,
    VE::SX28, VE::SX29, VE::SX30, VE::SX31,
    VE::SX32, VE::SX33, VE::SX34, VE::SX35,
    VE::SX36, VE::SX37, VE::SX38, VE::SX39,
    VE::SX40, VE::SX41, VE::SX42, VE::SX43,
    VE::SX44, VE::SX45, VE::SX46, VE::SX47,
    VE::SX48, VE::SX49, VE::SX50, VE::SX51,
    VE::SX52, VE::SX53, VE::SX54, VE::SX55,
    VE::SX56, VE::SX57, VE::SX58, VE::SX59,
    VE::SX60, VE::SX61, VE::SX62, VE::SX63 };

  static const MCPhysReg I32Regs[64] = {
    VE::SW0,  VE::SW1,  VE::SW2,  VE::SW3,
    VE::SW4,  VE::SW5,  VE::SW6,  VE::SW7,
    VE::SW8,  VE::SW9,  VE::SW10, VE::SW11,
    VE::SW12, VE::SW13, VE::SW14, VE::SW15,
    VE::SW16, VE::SW17, VE::SW18, VE::SW19,
    VE::SW20, VE::SW21, VE::SW22, VE::SW23,
    VE::SW24, VE::SW25, VE::SW26, VE::SW27,
    VE::SW28, VE::SW29, VE::SW30, VE::SW31,
    VE::SW32, VE::SW33, VE::SW34, VE::SW35,
    VE::SW36, VE::SW37, VE::SW38, VE::SW39,
    VE::SW40, VE::SW41, VE::SW42, VE::SW43,
    VE::SW44, VE::SW45, VE::SW46, VE::SW47,
    VE::SW48, VE::SW49, VE::SW50, VE::SW51,
    VE::SW52, VE::SW53, VE::SW54, VE::SW55,
    VE::SW56, VE::SW57, VE::SW58, VE::SW59,
    VE::SW60, VE::SW61, VE::SW62, VE::SW63 };

  static const MCPhysReg F32Regs[64] = {
    VE::SF0,  VE::SF1,  VE::SF2,  VE::SF3,
    VE::SF4,  VE::SF5,  VE::SF6,  VE::SF7,
    VE::SF8,  VE::SF9,  VE::SF10, VE::SF11,
    VE::SF12, VE::SF13, VE::SF14, VE::SF15,
    VE::SF16, VE::SF17, VE::SF18, VE::SF19,
    VE::SF20, VE::SF21, VE::SF22, VE::SF23,
    VE::SF24, VE::SF25, VE::SF26, VE::SF27,
    VE::SF28, VE::SF29, VE::SF30, VE::SF31,
    VE::SF32, VE::SF33, VE::SF34, VE::SF35,
    VE::SF36, VE::SF37, VE::SF38, VE::SF39,
    VE::SF40, VE::SF41, VE::SF42, VE::SF43,
    VE::SF44, VE::SF45, VE::SF46, VE::SF47,
    VE::SF48, VE::SF49, VE::SF50, VE::SF51,
    VE::SF52, VE::SF53, VE::SF54, VE::SF55,
    VE::SF56, VE::SF57, VE::SF58, VE::SF59,
    VE::SF60, VE::SF61, VE::SF62, VE::SF63 };

  static const MCPhysReg F128Regs[32] = {
    VE::Q0,  VE::Q1,  VE::Q2,  VE::Q3,
    VE::Q4,  VE::Q5,  VE::Q6,  VE::Q7,
    VE::Q8,  VE::Q9,  VE::Q10, VE::Q11,
    VE::Q12, VE::Q13, VE::Q14, VE::Q15,
    VE::Q16, VE::Q17, VE::Q18, VE::Q19,
    VE::Q20, VE::Q21, VE::Q22, VE::Q23,
    VE::Q24, VE::Q25, VE::Q26, VE::Q27,
    VE::Q28, VE::Q29, VE::Q30, VE::Q31 };

namespace {

/// VEOperand - Instances of this class represent a parsed VE machine
/// instruction.
class VEOperand : public MCParsedAsmOperand {
private:
  enum KindTy {
    k_Token,
    k_Register,
    k_Immediate,
                        // SX-Aurora ASX form is disp(index, base).
    k_MemoryRegRegImm,  // base=reg, index=reg, disp=imm
    k_MemoryRegImmImm,  // base=reg, index=imm, disp=imm
    k_MemoryZeroRegImm, // base=0, index=reg, disp=imm
    k_MemoryZeroImmImm, // base=0, index=imm, disp=imm
                        // SX-Aurora AS form is disp(base).
    k_MemoryRegImm,     // base=reg, disp=imm
    k_MemoryZeroImm,    // base=0, disp=imm
  } Kind;

  SMLoc StartLoc, EndLoc;

  struct Token {
    const char *Data;
    unsigned Length;
  };

  struct RegOp {
    unsigned RegNum;
  };

  struct ImmOp {
    const MCExpr *Val;
  };

  struct MemOp {
    unsigned Base;
    unsigned IndexReg;
    const MCExpr *Index;
    const MCExpr *Offset;
  };

  union {
    struct Token Tok;
    struct RegOp Reg;
    struct ImmOp Imm;
    struct MemOp Mem;
  };

public:
  VEOperand(KindTy K) : MCParsedAsmOperand(), Kind(K) {}

  bool isToken() const override { return Kind == k_Token; }
  bool isReg() const override { return Kind == k_Register; }
  bool isImm() const override { return Kind == k_Immediate; }
  bool isMem() const override
  { return isMEMrri() || isMEMrii() || isMEMzri() || isMEMzii() ||
           isMEMri() || isMEMzi(); }
  bool isMEMrri() const { return Kind == k_MemoryRegRegImm; }
  bool isMEMrii() const { return Kind == k_MemoryRegImmImm; }
  bool isMEMzri() const { return Kind == k_MemoryZeroRegImm; }
  bool isMEMzii() const { return Kind == k_MemoryZeroImmImm; }
  bool isMEMri() const { return Kind == k_MemoryRegImm; }
  bool isMEMzi() const { return Kind == k_MemoryZeroImm; }

  StringRef getToken() const {
    assert(Kind == k_Token && "Invalid access!");
    return StringRef(Tok.Data, Tok.Length);
  }

  unsigned getReg() const override {
    assert((Kind == k_Register) && "Invalid access!");
    return Reg.RegNum;
  }

  const MCExpr *getImm() const {
    assert((Kind == k_Immediate) && "Invalid access!");
    return Imm.Val;
  }

  unsigned getMemBase() const {
    assert((Kind == k_MemoryRegRegImm || Kind == k_MemoryRegImmImm ||
            Kind == k_MemoryRegImm) && "Invalid access!");
    return Mem.Base;
  }

  unsigned getMemIndexReg() const {
    assert((Kind == k_MemoryRegRegImm || Kind == k_MemoryZeroRegImm)
           && "Invalid access!");
    return Mem.IndexReg;
  }

  const MCExpr *getMemIndex() const {
    assert((Kind == k_MemoryRegImmImm || Kind == k_MemoryZeroImmImm) &&
           "Invalid access!");
    return Mem.Index;
  }

  const MCExpr *getMemOffset() const {
    assert((Kind == k_MemoryRegRegImm || Kind == k_MemoryRegImmImm ||
            Kind == k_MemoryZeroImmImm || Kind == k_MemoryZeroRegImm ||
            Kind == k_MemoryRegImm || Kind == k_MemoryZeroImm) &&
           "Invalid access!");
    return Mem.Offset;
  }

  /// getStartLoc - Get the location of the first token of this operand.
  SMLoc getStartLoc() const override {
    return StartLoc;
  }
  /// getEndLoc - Get the location of the last token of this operand.
  SMLoc getEndLoc() const override {
    return EndLoc;
  }

  void print(raw_ostream &OS) const override {
    switch (Kind) {
    case k_Token:
      OS << "Token: " << getToken() << "\n";
      break;
    case k_Register:
      OS << "Reg: #" << getReg() << "\n";
      break;
    case k_Immediate:
      OS << "Imm: " << getImm() << "\n";
      break;
    case k_MemoryRegRegImm:
      assert(getMemOffset() != nullptr);
      OS << "Mem: #" << getMemBase() << "+#" << getMemIndexReg() << "+"
         << *getMemOffset() << "\n";
      break;
    case k_MemoryRegImmImm:
      assert(getMemIndex() != nullptr && getMemOffset() != nullptr);
      OS << "Mem: #" << getMemBase() << "+" << *getMemIndex() << "+"
         << *getMemOffset() << "\n";
      break;
    case k_MemoryZeroRegImm:
      assert(getMemOffset() != nullptr);
      OS << "Mem: 0+#" << getMemIndexReg() << "+" << *getMemOffset() << "\n";
      break;
    case k_MemoryZeroImmImm:
      assert(getMemIndex() != nullptr && getMemOffset() != nullptr);
      OS << "Mem: 0+" << *getMemIndex() << "+" << *getMemOffset() << "\n";
      break;
    case k_MemoryRegImm:
      assert(getMemOffset() != nullptr);
      OS << "Mem: #" << getMemBase() << "+" << *getMemOffset() << "\n";
      break;
    case k_MemoryZeroImm:
      assert(getMemOffset() != nullptr);
      OS << "Mem: 0+" << *getMemOffset() << "\n";
      break;
    }
  }

  void addRegOperands(MCInst &Inst, unsigned N) const {
    assert(N == 1 && "Invalid number of operands!");
    Inst.addOperand(MCOperand::createReg(getReg()));
  }

  void addImmOperands(MCInst &Inst, unsigned N) const {
    assert(N == 1 && "Invalid number of operands!");
    const MCExpr *Expr = getImm();
    addExpr(Inst, Expr);
  }

  void addExpr(MCInst &Inst, const MCExpr *Expr) const{
    // Add as immediate when possible.  Null MCExpr = 0.
    if (!Expr)
      Inst.addOperand(MCOperand::createImm(0));
    else if (const MCConstantExpr *CE = dyn_cast<MCConstantExpr>(Expr))
      Inst.addOperand(MCOperand::createImm(CE->getValue()));
    else
      Inst.addOperand(MCOperand::createExpr(Expr));
  }

  void addMEMrriOperands(MCInst &Inst, unsigned N) const {
    assert(N == 3 && "Invalid number of operands!");

    Inst.addOperand(MCOperand::createReg(getMemBase()));
    Inst.addOperand(MCOperand::createReg(getMemIndexReg()));
    addExpr(Inst, getMemOffset());
  }

  void addMEMriiOperands(MCInst &Inst, unsigned N) const {
    assert(N == 3 && "Invalid number of operands!");

    Inst.addOperand(MCOperand::createReg(getMemBase()));
    addExpr(Inst, getMemIndex());
    addExpr(Inst, getMemOffset());
  }

  void addMEMzriOperands(MCInst &Inst, unsigned N) const {
    assert(N == 3 && "Invalid number of operands!");

    Inst.addOperand(MCOperand::createImm(0));
    Inst.addOperand(MCOperand::createReg(getMemIndexReg()));
    addExpr(Inst, getMemOffset());
  }

  void addMEMziiOperands(MCInst &Inst, unsigned N) const {
    assert(N == 3 && "Invalid number of operands!");

    Inst.addOperand(MCOperand::createImm(0));
    addExpr(Inst, getMemIndex());
    addExpr(Inst, getMemOffset());
  }

  void addMEMriOperands(MCInst &Inst, unsigned N) const {
    assert(N == 2 && "Invalid number of operands!");

    Inst.addOperand(MCOperand::createReg(getMemBase()));
    addExpr(Inst, getMemOffset());
  }

  void addMEMziOperands(MCInst &Inst, unsigned N) const {
    assert(N == 2 && "Invalid number of operands!");

    Inst.addOperand(MCOperand::createImm(0));
    addExpr(Inst, getMemOffset());
  }

  static std::unique_ptr<VEOperand> CreateToken(StringRef Str, SMLoc S) {
    auto Op = std::make_unique<VEOperand>(k_Token);
    Op->Tok.Data = Str.data();
    Op->Tok.Length = Str.size();
    Op->StartLoc = S;
    Op->EndLoc = S;
    return Op;
  }

  static std::unique_ptr<VEOperand> CreateReg(unsigned RegNum, SMLoc S,
                                              SMLoc E) {
    auto Op = std::make_unique<VEOperand>(k_Register);
    Op->Reg.RegNum = RegNum;
    Op->StartLoc = S;
    Op->EndLoc = E;
    return Op;
  }

  static std::unique_ptr<VEOperand> CreateImm(const MCExpr *Val, SMLoc S,
                                              SMLoc E) {
    auto Op = std::make_unique<VEOperand>(k_Immediate);
    Op->Imm.Val = Val;
    Op->StartLoc = S;
    Op->EndLoc = E;
    return Op;
  }

  static bool MorphToI32Reg(VEOperand &Op) {
    unsigned Reg = Op.getReg();
    unsigned regIdx = Reg - VE::SX0;
    Op.Reg.RegNum = I32Regs[regIdx];
    return true;
  }

  static bool MorphToF32Reg(VEOperand &Op) {
    unsigned Reg = Op.getReg();
    unsigned regIdx = Reg - VE::SX0;
    Op.Reg.RegNum = F32Regs[regIdx];
    return true;
  }

  static bool MorphToF128Reg(VEOperand &Op) {
    unsigned Reg = Op.getReg();
    unsigned regIdx = Reg - VE::SX0;
    if (regIdx % 2 || regIdx > 31)
      return false;
    Op.Reg.RegNum = F128Regs[regIdx / 2];
    return true;
  }

  static std::unique_ptr<VEOperand>
  MorphToMEMri(unsigned Base, std::unique_ptr<VEOperand> Op) {
    const MCExpr *Imm  = Op->getImm();
    Op->Kind = k_MemoryRegImm;
    Op->Mem.Base = Base;
    Op->Mem.IndexReg = 0;
    Op->Mem.Index = nullptr;
    Op->Mem.Offset = Imm;
    return Op;
  }

  static std::unique_ptr<VEOperand>
  MorphToMEMzi(std::unique_ptr<VEOperand> Op) {
    const MCExpr *Imm  = Op->getImm();
    Op->Kind = k_MemoryZeroImm;
    Op->Mem.Base = 0;
    Op->Mem.IndexReg = 0;
    Op->Mem.Index = nullptr;
    Op->Mem.Offset = Imm;
    return Op;
  }

  static std::unique_ptr<VEOperand>
  MorphToMEMrri(unsigned Base, unsigned Index, std::unique_ptr<VEOperand> Op) {
    const MCExpr *Imm  = Op->getImm();
    Op->Kind = k_MemoryRegRegImm;
    Op->Mem.Base = Base;
    Op->Mem.IndexReg = Index;
    Op->Mem.Index = nullptr;
    Op->Mem.Offset = Imm;
    return Op;
  }

  static std::unique_ptr<VEOperand>
  MorphToMEMrii(unsigned Base, const MCExpr* Index,
                std::unique_ptr<VEOperand> Op) {
    const MCExpr *Imm  = Op->getImm();
    Op->Kind = k_MemoryRegImmImm;
    Op->Mem.Base = Base;
    Op->Mem.IndexReg = 0;
    Op->Mem.Index = Index;
    Op->Mem.Offset = Imm;
    return Op;
  }

  static std::unique_ptr<VEOperand>
  MorphToMEMzri(unsigned Index, std::unique_ptr<VEOperand> Op) {
    const MCExpr *Imm  = Op->getImm();
    Op->Kind = k_MemoryZeroRegImm;
    Op->Mem.Base = 0;
    Op->Mem.IndexReg = Index;
    Op->Mem.Index = nullptr;
    Op->Mem.Offset = Imm;
    return Op;
  }

  static std::unique_ptr<VEOperand>
  MorphToMEMzii(const MCExpr* Index, std::unique_ptr<VEOperand> Op) {
    const MCExpr *Imm  = Op->getImm();
    Op->Kind = k_MemoryZeroImmImm;
    Op->Mem.Base = 0;
    Op->Mem.IndexReg = 0;
    Op->Mem.Index = Index;
    Op->Mem.Offset = Imm;
    return Op;
  }
};

} // end anonymous namespace

bool VEAsmParser::MatchAndEmitInstruction(SMLoc IDLoc, unsigned &Opcode,
                                             OperandVector &Operands,
                                             MCStreamer &Out,
                                             uint64_t &ErrorInfo,
                                             bool MatchingInlineAsm) {
  MCInst Inst;
  unsigned MatchResult = MatchInstructionImpl(Operands, Inst, ErrorInfo,
                                              MatchingInlineAsm);
  switch (MatchResult) {
  case Match_Success:
    Inst.setLoc(IDLoc);
    Out.emitInstruction(Inst, getSTI());
    return false;

  case Match_MissingFeature:
    return Error(IDLoc,
                 "instruction requires a CPU feature not currently enabled");

  case Match_InvalidOperand: {
    SMLoc ErrorLoc = IDLoc;
    if (ErrorInfo != ~0ULL) {
      if (ErrorInfo >= Operands.size())
        return Error(IDLoc, "too few operands for instruction");

      ErrorLoc = ((VEOperand &)*Operands[ErrorInfo]).getStartLoc();
      if (ErrorLoc == SMLoc())
        ErrorLoc = IDLoc;
    }

    return Error(ErrorLoc, "invalid operand for instruction");
  }
  case Match_MnemonicFail:
    return Error(IDLoc, "invalid instruction mnemonic");
  }
  llvm_unreachable("Implement any new match types added!");
}

bool VEAsmParser::ParseRegister(unsigned &RegNo, SMLoc &StartLoc,
                                   SMLoc &EndLoc) {
  if (tryParseRegister(RegNo, StartLoc, EndLoc) != MatchOperand_Success)
    return Error(StartLoc, "invalid register name");
  return false;
}

/// Parses a register name using a given matching function.
/// Checks for lowercase or uppercase if necessary.
int VEAsmParser::parseRegisterName(unsigned (*matchFn)(StringRef)) {
  StringRef Name = Parser.getTok().getString();

  int RegNum = matchFn(Name);

  // GCC supports case insensitive register names. Some of the AVR registers
  // are all lower case, some are all upper case but non are mixed. We prefer
  // to use the original names in the register definitions. That is why we
  // have to test both upper and lower case here.
  if (RegNum == VE::NoRegister) {
    RegNum = matchFn(Name.lower());
  }
  if (RegNum == VE::NoRegister) {
    RegNum = matchFn(Name.upper());
  }

  return RegNum;
}

/// Maps from the set of all register names to a register number.
/// \note Generated by TableGen.
static unsigned MatchRegisterName(StringRef Name);

/// Maps from the set of all alternative registernames to a register number.
/// \note Generated by TableGen.
static unsigned MatchRegisterAltName(StringRef Name);

OperandMatchResultTy VEAsmParser::tryParseRegister(unsigned &RegNo,
                                                   SMLoc &StartLoc,
                                                   SMLoc &EndLoc) {
  const AsmToken &Tok = Parser.getTok();
  StartLoc = Tok.getLoc();
  EndLoc = Tok.getEndLoc();
  RegNo = 0;
  if (getLexer().getKind() != AsmToken::Percent)
    return MatchOperand_Success;
  Parser.Lex();

  RegNo = parseRegisterName(&MatchRegisterName);
  if (RegNo == VE::NoRegister)
      RegNo = parseRegisterName(&MatchRegisterAltName);

  if (RegNo != VE::NoRegister) {
    Parser.Lex();
    return MatchOperand_Success;
  }

  getLexer().UnLex(Tok);
  return MatchOperand_NoMatch;
}

#if 0
static void applyMnemonicAliases(StringRef &Mnemonic, uint64_t Features,
                                 unsigned VariantID);
#endif

bool VEAsmParser::ParseInstruction(ParseInstructionInfo &Info,
                                      StringRef Name, SMLoc NameLoc,
                                      OperandVector &Operands) {

  // First operand in MCInst is instruction mnemonic.
  Operands.push_back(VEOperand::CreateToken(Name, NameLoc));

#if 0
  // If the target architecture uses MnemonicAlias, call it here to parse
  // operands correctly.
  applyMnemonicAliases(Name, getAvailableFeatures(), 0);
#endif

  if (getLexer().isNot(AsmToken::EndOfStatement)) {
    // Read the first operand.
    if (parseOperand(Operands, Name) != MatchOperand_Success) {
      SMLoc Loc = getLexer().getLoc();
      return Error(Loc, "unexpected token");
    }

    while (getLexer().is(AsmToken::Comma)) {
      Parser.Lex(); // Eat the comma.
      // Parse and remember the operand.
      if (parseOperand(Operands, Name) != MatchOperand_Success) {
        SMLoc Loc = getLexer().getLoc();
        return Error(Loc, "unexpected token");
      }
    }
  }
  if (getLexer().isNot(AsmToken::EndOfStatement)) {
    SMLoc Loc = getLexer().getLoc();
    return Error(Loc, "unexpected token");
  }
  Parser.Lex(); // Consume the EndOfStatement.
  return false;
}

bool VEAsmParser::
ParseDirective(AsmToken DirectiveID)
{
  StringRef IDVal = DirectiveID.getString();

  if (IDVal == ".byte")
    return parseDirectiveWord(1, DirectiveID.getLoc());

  if (IDVal == ".half")
    return parseDirectiveWord(2, DirectiveID.getLoc());

  if (IDVal == ".word")
    return parseDirectiveWord(4, DirectiveID.getLoc());

  if (IDVal == ".nword")
    return parseDirectiveWord(is64Bit() ? 8 : 4, DirectiveID.getLoc());

  if (is64Bit() && IDVal == ".xword")
    return parseDirectiveWord(8, DirectiveID.getLoc());

  if (IDVal == ".register") {
    // For now, ignore .register directive.
    Parser.eatToEndOfStatement();
    return false;
  }
  if (IDVal == ".proc") {
    // For compatibility, ignore this directive.
    // (It's supposed to be an "optimization" in the Sun assembler)
    Parser.eatToEndOfStatement();
    return false;
  }

  // Let the MC layer to handle other directives.
  return true;
}

bool VEAsmParser:: parseDirectiveWord(unsigned Size, SMLoc L) {
  if (getLexer().isNot(AsmToken::EndOfStatement)) {
    while (true) {
      const MCExpr *Value;
      if (getParser().parseExpression(Value))
        return true;

      getParser().getStreamer().emitValue(Value, Size);

      if (getLexer().is(AsmToken::EndOfStatement))
        break;

      // FIXME: Improve diagnostic.
      if (getLexer().isNot(AsmToken::Comma))
        return Error(L, "unexpected token in directive");
      Parser.Lex();
    }
  }
  Parser.Lex();
  return false;
}

OperandMatchResultTy
VEAsmParser::parseMEMOperand(OperandVector &Operands) {
  const AsmToken &Tok = Parser.getTok();
  SMLoc S = Tok.getLoc();
  SMLoc E = Tok.getEndLoc();
  // Parse ASX format
  //   disp
  //   disp(, base)
  //   disp(index)
  //   disp(index, base)
  //   (, base)
  //   (index)
  //   (index, base)

  std::unique_ptr<VEOperand> Offset;
  switch (getLexer().getKind()) {
  default:
    return MatchOperand_NoMatch;

  case AsmToken::Minus:
  case AsmToken::Integer:
  case AsmToken::Dot: {
    const MCExpr *EVal;
    if (!getParser().parseExpression(EVal, E))
      Offset = VEOperand::CreateImm(EVal, S, E);
    else
      return MatchOperand_NoMatch;
    break;
  }
  case AsmToken::LParen:
    // empty disp (= 0)
    Offset = VEOperand::CreateImm(MCConstantExpr::create(0, getContext()),
                                  S, E);
    break;
  }

  switch (getLexer().getKind()) {
  default:
    return MatchOperand_NoMatch;

  case AsmToken::EndOfStatement:
    Operands.push_back(
        VEOperand::MorphToMEMzii(MCConstantExpr::create(0, getContext()),
                                 std::move(Offset)));
    return MatchOperand_Success;

  case AsmToken::LParen:
    Parser.Lex(); // Eat the (
    break;
  }

  const MCExpr *IndexValue = nullptr;
  unsigned IndexReg = 0;;

  switch (getLexer().getKind()) {
  default:
    if (ParseRegister(IndexReg, S, E))
      return MatchOperand_NoMatch;
    break;

  case AsmToken::Minus:
  case AsmToken::Integer:
  case AsmToken::Dot:
    if (getParser().parseExpression(IndexValue, E))
      return MatchOperand_NoMatch;
    break;

  case AsmToken::Comma:
    // empty index
    IndexValue = MCConstantExpr::create(0, getContext());
    break;
  }

  switch (getLexer().getKind()) {
  default:
    return MatchOperand_NoMatch;

  case AsmToken::RParen:
    Parser.Lex(); // Eat the )
    Operands.push_back(
        IndexValue ? VEOperand::MorphToMEMzii(IndexValue, std::move(Offset))
                   : VEOperand::MorphToMEMzri(IndexReg, std::move(Offset)));
    return MatchOperand_Success;

  case AsmToken::Comma:
    Parser.Lex(); // Eat the ,
    break;
  }

  unsigned BaseReg = 0;
  if (ParseRegister(BaseReg, S, E)) {
    return MatchOperand_NoMatch;
  }

  switch (getLexer().getKind()) {
  default:
    return MatchOperand_NoMatch;

  case AsmToken::RParen:
    Parser.Lex(); // Eat the )
    break;
  }

  Operands.push_back(
      IndexValue ? VEOperand::MorphToMEMrii(BaseReg, IndexValue,
                                            std::move(Offset))
                 : VEOperand::MorphToMEMrri(BaseReg, IndexReg,
                                            std::move(Offset)));

  return MatchOperand_Success;
}

OperandMatchResultTy
VEAsmParser::parseOperand(OperandVector &Operands, StringRef Mnemonic) {

  OperandMatchResultTy ResTy = MatchOperandParserImpl(Operands, Mnemonic);

  // If there wasn't a custom match, try the generic matcher below. Otherwise,
  // there was a match, but an error occurred, in which case, just return that
  // the operand parsing failed.
  if (ResTy == MatchOperand_Success || ResTy == MatchOperand_ParseFail)
    return ResTy;

  std::unique_ptr<VEOperand> Op;

  ResTy = parseVEAsmOperand(Op);
  if (ResTy != MatchOperand_Success || !Op)
    return MatchOperand_ParseFail;

  // Push the parsed operand into the list of operands
  Operands.push_back(std::move(Op));

  return MatchOperand_Success;
}

OperandMatchResultTy
VEAsmParser::parseVEAsmOperand(std::unique_ptr<VEOperand> &Op) {
  SMLoc S = Parser.getTok().getLoc();
  SMLoc E = SMLoc::getFromPointer(Parser.getTok().getLoc().getPointer() - 1);
  const MCExpr *EVal;

  Op = nullptr;
  switch (getLexer().getKind()) {
  default:
    break;

  case AsmToken::Percent:
    unsigned RegNo;
    if (tryParseRegister(RegNo, S, E) == MatchOperand_Success)
      Op = VEOperand::CreateReg(RegNo, S, E);
    break;

  case AsmToken::At:
    if (matchVEAsmModifiers(EVal, E)) {
      E = SMLoc::getFromPointer(Parser.getTok().getLoc().getPointer() - 1);
      Op = VEOperand::CreateImm(EVal, S, E);
    }
    break;

  case AsmToken::Minus:
  case AsmToken::Integer:
  case AsmToken::Dot:
    if (!getParser().parseExpression(EVal, E))
      Op = VEOperand::CreateImm(EVal, S, E);
    break;

  case AsmToken::Identifier: {
    StringRef Identifier;
    if (!getParser().parseIdentifier(Identifier)) {
      E = SMLoc::getFromPointer(Parser.getTok().getLoc().getPointer() - 1);
      MCSymbol *Sym = getContext().getOrCreateSymbol(Identifier);

      const MCExpr *Res = MCSymbolRefExpr::create(Sym, MCSymbolRefExpr::VK_None,
                                                  getContext());
      Op = VEOperand::CreateImm(Res, S, E);
    }
    break;
  }
  }
  return (Op) ? MatchOperand_Success : MatchOperand_ParseFail;
}

// Determine if an expression contains a reference to the symbol
// "_GLOBAL_OFFSET_TABLE_".
static bool hasGOTReference(const MCExpr *Expr) {
  switch (Expr->getKind()) {
  case MCExpr::Target:
    if (const VEMCExpr *SE = dyn_cast<VEMCExpr>(Expr))
      return hasGOTReference(SE->getSubExpr());
    break;

  case MCExpr::Constant:
    break;

  case MCExpr::Binary: {
    const MCBinaryExpr *BE = cast<MCBinaryExpr>(Expr);
    return hasGOTReference(BE->getLHS()) || hasGOTReference(BE->getRHS());
  }

  case MCExpr::SymbolRef: {
    const MCSymbolRefExpr &SymRef = *cast<MCSymbolRefExpr>(Expr);
    return (SymRef.getSymbol().getName() == "_GLOBAL_OFFSET_TABLE_");
  }

  case MCExpr::Unary:
    return hasGOTReference(cast<MCUnaryExpr>(Expr)->getSubExpr());
  }
  return false;
}

const VEMCExpr *
VEAsmParser::adjustPICRelocation(VEMCExpr::VariantKind VK,
                                    const MCExpr *subExpr) {
  // When in PIC mode, "%lo(...)" and "%hi(...)" behave differently.
  // If the expression refers contains _GLOBAL_OFFSETE_TABLE, it is
  // actually a %pc10 or %pc22 relocation. Otherwise, they are interpreted
  // as %got10 or %got22 relocation.

  if (getContext().getObjectFileInfo()->isPositionIndependent()) {
    switch(VK) {
    default: break;
    case VEMCExpr::VK_VE_LO32:
      VK = (hasGOTReference(subExpr) ? VEMCExpr::VK_VE_PC_LO32
                                     : VEMCExpr::VK_VE_GOT_LO32);
      break;
    case VEMCExpr::VK_VE_HI32:
      VK = (hasGOTReference(subExpr) ? VEMCExpr::VK_VE_PC_HI32
                                     : VEMCExpr::VK_VE_GOT_HI32);
      break;
    }
  }

  return VEMCExpr::create(VK, subExpr, getContext());
}

bool VEAsmParser::matchVEAsmModifiers(const MCExpr *&EVal,
                                            SMLoc &EndLoc) {
  AsmToken Tok = Parser.getTok();
  if (!Tok.is(AsmToken::Identifier))
    return false;

  StringRef name = Tok.getString();

  VEMCExpr::VariantKind VK = VEMCExpr::parseVariantKind(name);

  if (VK == VEMCExpr::VK_VE_None)
    return false;

  Parser.Lex(); // Eat the identifier.
  if (Parser.getTok().getKind() != AsmToken::LParen)
    return false;

  Parser.Lex(); // Eat the LParen token.
  const MCExpr *subExpr;
  if (Parser.parseParenExpression(subExpr, EndLoc))
    return false;

  EVal = adjustPICRelocation(VK, subExpr);
  return true;
}

// Force static initialization.
extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeVEAsmParser() {
  RegisterMCAsmParser<VEAsmParser> A(getTheVETarget());
}

#define GET_REGISTER_MATCHER
#define GET_MATCHER_IMPLEMENTATION
#include "VEGenAsmMatcher.inc"

unsigned VEAsmParser::validateTargetOperandClass(MCParsedAsmOperand &GOp,
                                                 unsigned Kind) {
  VEOperand &Op = (VEOperand &)GOp;

  // VE uses identical register name for all registers like both
  // F32 and I32 uses "%s23".  Need to convert the name of them
  // for validation.
  switch (Kind) {
  default:
    break;
  case MCK_F128:
    if (VEOperand::MorphToF128Reg(Op))
      return MCTargetAsmParser::Match_Success;
    break;
  case MCK_F32:
    if (VEOperand::MorphToF32Reg(Op))
      return MCTargetAsmParser::Match_Success;
    break;
  case MCK_I32:
    if (VEOperand::MorphToI32Reg(Op))
      return MCTargetAsmParser::Match_Success;
    break;
  }
  return Match_InvalidOperand;
}
