//===-- VEAsmParser.cpp - Parse VE assembly to MCInst instructions --------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/VEMCExpr.h"
#include "MCTargetDesc/VEMCTargetDesc.h"
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
  bool ParseInstruction(ParseInstructionInfo &Info, StringRef Name,
                        SMLoc NameLoc, OperandVector &Operands) override;
  bool ParseDirective(AsmToken DirectiveID) override;

  unsigned validateTargetOperandClass(MCParsedAsmOperand &Op,
                                      unsigned Kind) override;

  // Custom parse functions for VE specific operands.
  OperandMatchResultTy parseMEMOperand(OperandVector &Operands);

  OperandMatchResultTy parseOperand(OperandVector &Operands, StringRef Name);

  OperandMatchResultTy
  parseVEAsmOperand(std::unique_ptr<VEOperand> &Operand,
                       bool isCall = false);

  OperandMatchResultTy parseBranchModifiers(OperandVector &Operands);

  // Helper function for dealing with %lo / %hi in PIC mode.
  const VEMCExpr *adjustPICRelocation(VEMCExpr::VariantKind VK,
                                         const MCExpr *subExpr);

  // returns true if Tok is matched to a register and returns register in RegNo.
  bool matchRegisterName(const AsmToken &Tok, unsigned &RegNo,
                         unsigned &RegKind);

  bool matchVEAsmModifiers(const MCExpr *&EVal, SMLoc &EndLoc);
  bool parseDirectiveWord(unsigned Size, SMLoc L);

  bool is64Bit() const {
    return getSTI().getTargetTriple().getArch() == Triple::sparcv9;
  }

#if 0
  bool expandSET(MCInst &Inst, SMLoc IDLoc,
                 SmallVectorImpl<MCInst> &Instructions);
#endif

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

  static const MCPhysReg IntRegs[64] = {
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

#if 0
  static const MCPhysReg FloatRegs[32] = {
    Sparc::F0,  Sparc::F1,  Sparc::F2,  Sparc::F3,
    Sparc::F4,  Sparc::F5,  Sparc::F6,  Sparc::F7,
    Sparc::F8,  Sparc::F9,  Sparc::F10, Sparc::F11,
    Sparc::F12, Sparc::F13, Sparc::F14, Sparc::F15,
    Sparc::F16, Sparc::F17, Sparc::F18, Sparc::F19,
    Sparc::F20, Sparc::F21, Sparc::F22, Sparc::F23,
    Sparc::F24, Sparc::F25, Sparc::F26, Sparc::F27,
    Sparc::F28, Sparc::F29, Sparc::F30, Sparc::F31 };

  static const MCPhysReg DoubleRegs[32] = {
    Sparc::D0,  Sparc::D1,  Sparc::D2,  Sparc::D3,
    Sparc::D4,  Sparc::D5,  Sparc::D6,  Sparc::D7,
    Sparc::D8,  Sparc::D9,  Sparc::D10, Sparc::D11,
    Sparc::D12, Sparc::D13, Sparc::D14, Sparc::D15,
    Sparc::D16, Sparc::D17, Sparc::D18, Sparc::D19,
    Sparc::D20, Sparc::D21, Sparc::D22, Sparc::D23,
    Sparc::D24, Sparc::D25, Sparc::D26, Sparc::D27,
    Sparc::D28, Sparc::D29, Sparc::D30, Sparc::D31 };

  static const MCPhysReg QuadFPRegs[32] = {
    Sparc::Q0,  Sparc::Q1,  Sparc::Q2,  Sparc::Q3,
    Sparc::Q4,  Sparc::Q5,  Sparc::Q6,  Sparc::Q7,
    Sparc::Q8,  Sparc::Q9,  Sparc::Q10, Sparc::Q11,
    Sparc::Q12, Sparc::Q13, Sparc::Q14, Sparc::Q15 };

  static const MCPhysReg ASRRegs[32] = {
    SP::Y,     SP::ASR1,  SP::ASR2,  SP::ASR3,
    SP::ASR4,  SP::ASR5,  SP::ASR6, SP::ASR7,
    SP::ASR8,  SP::ASR9,  SP::ASR10, SP::ASR11,
    SP::ASR12, SP::ASR13, SP::ASR14, SP::ASR15,
    SP::ASR16, SP::ASR17, SP::ASR18, SP::ASR19,
    SP::ASR20, SP::ASR21, SP::ASR22, SP::ASR23,
    SP::ASR24, SP::ASR25, SP::ASR26, SP::ASR27,
    SP::ASR28, SP::ASR29, SP::ASR30, SP::ASR31};

  static const MCPhysReg IntPairRegs[] = {
    Sparc::G0_G1, Sparc::G2_G3, Sparc::G4_G5, Sparc::G6_G7,
    Sparc::O0_O1, Sparc::O2_O3, Sparc::O4_O5, Sparc::O6_O7,
    Sparc::L0_L1, Sparc::L2_L3, Sparc::L4_L5, Sparc::L6_L7,
    Sparc::I0_I1, Sparc::I2_I3, Sparc::I4_I5, Sparc::I6_I7};

  static const MCPhysReg CoprocRegs[32] = {
    Sparc::C0,  Sparc::C1,  Sparc::C2,  Sparc::C3,
    Sparc::C4,  Sparc::C5,  Sparc::C6,  Sparc::C7,
    Sparc::C8,  Sparc::C9,  Sparc::C10, Sparc::C11,
    Sparc::C12, Sparc::C13, Sparc::C14, Sparc::C15,
    Sparc::C16, Sparc::C17, Sparc::C18, Sparc::C19,
    Sparc::C20, Sparc::C21, Sparc::C22, Sparc::C23,
    Sparc::C24, Sparc::C25, Sparc::C26, Sparc::C27,
    Sparc::C28, Sparc::C29, Sparc::C30, Sparc::C31 };

  static const MCPhysReg CoprocPairRegs[] = {
    Sparc::C0_C1,   Sparc::C2_C3,   Sparc::C4_C5,   Sparc::C6_C7,
    Sparc::C8_C9,   Sparc::C10_C11, Sparc::C12_C13, Sparc::C14_C15,
    Sparc::C16_C17, Sparc::C18_C19, Sparc::C20_C21, Sparc::C22_C23,
    Sparc::C24_C25, Sparc::C26_C27, Sparc::C28_C29, Sparc::C30_C31};
#endif
  
namespace {

/// VEOperand - Instances of this class represent a parsed VE machine
/// instruction.
class VEOperand : public MCParsedAsmOperand {
public:
  enum RegisterKind {
    rk_None,
    rk_IntReg,
    rk_IntPairReg,
    rk_FloatReg,
    rk_DoubleReg,
    rk_QuadReg,
    rk_CoprocReg,
    rk_CoprocPairReg,
    rk_Special,
  };

private:
  enum KindTy {
    k_Token,
    k_Register,
    k_Immediate,
    k_MemoryReg,
    k_MemoryImm
  } Kind;

  SMLoc StartLoc, EndLoc;

  struct Token {
    const char *Data;
    unsigned Length;
  };

  struct RegOp {
    unsigned RegNum;
    RegisterKind Kind;
  };

  struct ImmOp {
    const MCExpr *Val;
  };

  struct MemOp {
    unsigned Base;
    unsigned OffsetReg;
    const MCExpr *Off;
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
  bool isMem() const override { return isMEMrr() || isMEMri(); }
  bool isMEMrr() const { return Kind == k_MemoryReg; }
  bool isMEMri() const { return Kind == k_MemoryImm; }

  bool isIntReg() const {
    return (Kind == k_Register && Reg.Kind == rk_IntReg);
  }

  bool isFloatReg() const {
    return (Kind == k_Register && Reg.Kind == rk_FloatReg);
  }

  bool isFloatOrDoubleReg() const {
    return (Kind == k_Register && (Reg.Kind == rk_FloatReg
                                   || Reg.Kind == rk_DoubleReg));
  }

  bool isCoprocReg() const {
    return (Kind == k_Register && Reg.Kind == rk_CoprocReg);
  }

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
    assert((Kind == k_MemoryReg || Kind == k_MemoryImm) && "Invalid access!");
    return Mem.Base;
  }

  unsigned getMemOffsetReg() const {
    assert((Kind == k_MemoryReg) && "Invalid access!");
    return Mem.OffsetReg;
  }

  const MCExpr *getMemOff() const {
    assert((Kind == k_MemoryImm) && "Invalid access!");
    return Mem.Off;
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
    case k_Token:     OS << "Token: " << getToken() << "\n"; break;
    case k_Register:  OS << "Reg: #" << getReg() << "\n"; break;
    case k_Immediate: OS << "Imm: " << getImm() << "\n"; break;
    case k_MemoryReg: OS << "Mem: " << getMemBase() << "+"
                         << getMemOffsetReg() << "\n"; break;
    case k_MemoryImm: assert(getMemOff() != nullptr);
      OS << "Mem: " << getMemBase()
         << "+" << *getMemOff()
         << "\n"; break;
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

  void addMEMrrOperands(MCInst &Inst, unsigned N) const {
    assert(N == 2 && "Invalid number of operands!");

    Inst.addOperand(MCOperand::createReg(getMemBase()));

    assert(getMemOffsetReg() != 0 && "Invalid offset");
    Inst.addOperand(MCOperand::createReg(getMemOffsetReg()));
  }

  void addMEMriOperands(MCInst &Inst, unsigned N) const {
    assert(N == 2 && "Invalid number of operands!");

    Inst.addOperand(MCOperand::createReg(getMemBase()));

    const MCExpr *Expr = getMemOff();
    addExpr(Inst, Expr);
  }

  static std::unique_ptr<VEOperand> CreateToken(StringRef Str, SMLoc S) {
    auto Op = make_unique<VEOperand>(k_Token);
    Op->Tok.Data = Str.data();
    Op->Tok.Length = Str.size();
    Op->StartLoc = S;
    Op->EndLoc = S;
    return Op;
  }

  static std::unique_ptr<VEOperand> CreateReg(unsigned RegNum, unsigned Kind,
                                                 SMLoc S, SMLoc E) {
    auto Op = make_unique<VEOperand>(k_Register);
    Op->Reg.RegNum = RegNum;
    Op->Reg.Kind   = (VEOperand::RegisterKind)Kind;
    Op->StartLoc = S;
    Op->EndLoc = E;
    return Op;
  }

  static std::unique_ptr<VEOperand> CreateImm(const MCExpr *Val, SMLoc S,
                                                 SMLoc E) {
    auto Op = make_unique<VEOperand>(k_Immediate);
    Op->Imm.Val = Val;
    Op->StartLoc = S;
    Op->EndLoc = E;
    return Op;
  }

#if 0
  static bool MorphToIntPairReg(VEOperand &Op) {
    unsigned Reg = Op.getReg();
    assert(Op.Reg.Kind == rk_IntReg);
    unsigned regIdx = 32;
    if (Reg >= Sparc::G0 && Reg <= Sparc::G7)
      regIdx = Reg - Sparc::G0;
    else if (Reg >= Sparc::O0 && Reg <= Sparc::O7)
      regIdx = Reg - Sparc::O0 + 8;
    else if (Reg >= Sparc::L0 && Reg <= Sparc::L7)
      regIdx = Reg - Sparc::L0 + 16;
    else if (Reg >= Sparc::I0 && Reg <= Sparc::I7)
      regIdx = Reg - Sparc::I0 + 24;
    if (regIdx % 2 || regIdx > 31)
      return false;
    Op.Reg.RegNum = IntPairRegs[regIdx / 2];
    Op.Reg.Kind = rk_IntPairReg;
    return true;
  }

  static bool MorphToDoubleReg(VEOperand &Op) {
    unsigned Reg = Op.getReg();
    assert(Op.Reg.Kind == rk_FloatReg);
    unsigned regIdx = Reg - Sparc::F0;
    if (regIdx % 2 || regIdx > 31)
      return false;
    Op.Reg.RegNum = DoubleRegs[regIdx / 2];
    Op.Reg.Kind = rk_DoubleReg;
    return true;
  }

  static bool MorphToQuadReg(VEOperand &Op) {
    unsigned Reg = Op.getReg();
    unsigned regIdx = 0;
    switch (Op.Reg.Kind) {
    default: llvm_unreachable("Unexpected register kind!");
    case rk_FloatReg:
      regIdx = Reg - Sparc::F0;
      if (regIdx % 4 || regIdx > 31)
        return false;
      Reg = QuadFPRegs[regIdx / 4];
      break;
    case rk_DoubleReg:
      regIdx =  Reg - Sparc::D0;
      if (regIdx % 2 || regIdx > 31)
        return false;
      Reg = QuadFPRegs[regIdx / 2];
      break;
    }
    Op.Reg.RegNum = Reg;
    Op.Reg.Kind = rk_QuadReg;
    return true;
  }

  static bool MorphToCoprocPairReg(VEOperand &Op) {
    unsigned Reg = Op.getReg();
    assert(Op.Reg.Kind == rk_CoprocReg);
    unsigned regIdx = 32;
    if (Reg >= Sparc::C0 && Reg <= Sparc::C31)
      regIdx = Reg - Sparc::C0;
    if (regIdx % 2 || regIdx > 31)
      return false;
    Op.Reg.RegNum = CoprocPairRegs[regIdx / 2];
    Op.Reg.Kind = rk_CoprocPairReg;
    return true;
  }
#endif
  
  static std::unique_ptr<VEOperand>
  MorphToMEMrr(unsigned Base, std::unique_ptr<VEOperand> Op) {
    unsigned offsetReg = Op->getReg();
    Op->Kind = k_MemoryReg;
    Op->Mem.Base = Base;
    Op->Mem.OffsetReg = offsetReg;
    Op->Mem.Off = nullptr;
    return Op;
  }

  static std::unique_ptr<VEOperand>
  CreateMEMr(unsigned Base, SMLoc S, SMLoc E) {
    auto Op = make_unique<VEOperand>(k_MemoryReg);
    Op->Mem.Base = Base;
    Op->Mem.OffsetReg = 0;  // always 0
    Op->Mem.Off = nullptr;
    Op->StartLoc = S;
    Op->EndLoc = E;
    return Op;
  }

  static std::unique_ptr<VEOperand>
  MorphToMEMri(unsigned Base, std::unique_ptr<VEOperand> Op) {
    const MCExpr *Imm  = Op->getImm();
    Op->Kind = k_MemoryImm;
    Op->Mem.Base = Base;
    Op->Mem.OffsetReg = 0;
    Op->Mem.Off = Imm;
    return Op;
  }
};

} // end anonymous namespace

#if 0
bool VEAsmParser::expandSET(MCInst &Inst, SMLoc IDLoc,
                               SmallVectorImpl<MCInst> &Instructions) {
  MCOperand MCRegOp = Inst.getOperand(0);
  MCOperand MCValOp = Inst.getOperand(1);
  assert(MCRegOp.isReg());
  assert(MCValOp.isImm() || MCValOp.isExpr());

  // the imm operand can be either an expression or an immediate.
  bool IsImm = Inst.getOperand(1).isImm();
  int64_t RawImmValue = IsImm ? MCValOp.getImm() : 0;

  // Allow either a signed or unsigned 32-bit immediate.
  if (RawImmValue < -2147483648LL || RawImmValue > 4294967295LL) {
    return Error(IDLoc,
                 "set: argument must be between -2147483648 and 4294967295");
  }

  // If the value was expressed as a large unsigned number, that's ok.
  // We want to see if it "looks like" a small signed number.
  int32_t ImmValue = RawImmValue;
  // For 'set' you can't use 'or' with a negative operand on V9 because
  // that would splat the sign bit across the upper half of the destination
  // register, whereas 'set' is defined to zero the high 32 bits.
  bool IsEffectivelyImm13 =
      IsImm && ((is64Bit() ? 0 : -4096) <= ImmValue && ImmValue < 4096);
  const MCExpr *ValExpr;
  if (IsImm)
    ValExpr = MCConstantExpr::create(ImmValue, getContext());
  else
    ValExpr = MCValOp.getExpr();

  // FIXME: need to collect this S31
  MCOperand PrevReg = MCOperand::createReg(VE::S31);

  // FIXME: need lea.sl
  // If not just a signed imm13 value, then either we use a 'sethi' with a
  // following 'or', or a 'sethi' by itself if there are no more 1 bits.
  // In either case, start with the 'sethi'.
  if (!IsEffectivelyImm13) {
    MCInst TmpInst;
    const MCExpr *Expr = adjustPICRelocation(VEMCExpr::VK_VE_HI, ValExpr);
    TmpInst.setLoc(IDLoc);
    TmpInst.setOpcode(SP::SETHIi);
    TmpInst.addOperand(MCRegOp);
    TmpInst.addOperand(MCOperand::createExpr(Expr));
    Instructions.push_back(TmpInst);
    PrevReg = MCRegOp;
  }

  // The low bits require touching in 3 cases:
  // * A non-immediate value will always require both instructions.
  // * An effectively imm13 value needs only an 'or' instruction.
  // * Otherwise, an immediate that is not effectively imm13 requires the
  //   'or' only if bits remain after clearing the 22 bits that 'sethi' set.
  // If the low bits are known zeros, there's nothing to do.
  // In the second case, and only in that case, must we NOT clear
  // bits of the immediate value via the %lo() assembler function.
  // Note also, the 'or' instruction doesn't mind a large value in the case
  // where the operand to 'set' was 0xFFFFFzzz - it does exactly what you mean.
  if (!IsImm || IsEffectivelyImm13 || (ImmValue & 0x3ff)) {
    MCInst TmpInst;
    const MCExpr *Expr;
    if (IsEffectivelyImm13)
      Expr = ValExpr;
    else
      Expr = adjustPICRelocation(VEMCExpr::VK_VE_LO, ValExpr);
    TmpInst.setLoc(IDLoc);
    TmpInst.setOpcode(SP::ORri);
    TmpInst.addOperand(MCRegOp);
    TmpInst.addOperand(PrevReg);
    TmpInst.addOperand(MCOperand::createExpr(Expr));
    Instructions.push_back(TmpInst);
  }
  return false;
}
#endif

bool VEAsmParser::MatchAndEmitInstruction(SMLoc IDLoc, unsigned &Opcode,
                                             OperandVector &Operands,
                                             MCStreamer &Out,
                                             uint64_t &ErrorInfo,
                                             bool MatchingInlineAsm) {
  MCInst Inst;
  SmallVector<MCInst, 8> Instructions;
  unsigned MatchResult = MatchInstructionImpl(Operands, Inst, ErrorInfo,
                                              MatchingInlineAsm);
  switch (MatchResult) {
  case Match_Success: {
#if 0
    switch (Inst.getOpcode()) {
    default:
      Inst.setLoc(IDLoc);
      Instructions.push_back(Inst);
      break;
    case SP::SET:
      if (expandSET(Inst, IDLoc, Instructions))
        return true;
      break;
    }
#endif

    for (const MCInst &I : Instructions) {
      Out.EmitInstruction(I, getSTI());
    }
    return false;
  }

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
  const AsmToken &Tok = Parser.getTok();
  StartLoc = Tok.getLoc();
  EndLoc = Tok.getEndLoc();
  RegNo = 0;
  if (getLexer().getKind() != AsmToken::Percent)
    return false;
  Parser.Lex();
  unsigned regKind = VEOperand::rk_None;
  if (matchRegisterName(Tok, RegNo, regKind)) {
    Parser.Lex();
    return false;
  }

  return Error(StartLoc, "invalid register name");
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
    if (getLexer().is(AsmToken::Comma)) {
      if (parseBranchModifiers(Operands) != MatchOperand_Success) {
        SMLoc Loc = getLexer().getLoc();
        return Error(Loc, "unexpected token");
      }
    }
    if (parseOperand(Operands, Name) != MatchOperand_Success) {
      SMLoc Loc = getLexer().getLoc();
      return Error(Loc, "unexpected token");
    }

    while (getLexer().is(AsmToken::Comma) || getLexer().is(AsmToken::Plus)) {
      if (getLexer().is(AsmToken::Plus)) {
      // Plus tokens are significant in software_traps (p83, sparcv8.pdf). We must capture them.
        Operands.push_back(VEOperand::CreateToken("+", Parser.getTok().getLoc()));
      }
      Parser.Lex(); // Eat the comma or plus.
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

      getParser().getStreamer().EmitValue(Value, Size);

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
  SMLoc S, E;
  unsigned BaseReg = 0;

  if (ParseRegister(BaseReg, S, E)) {
    return MatchOperand_NoMatch;
  }

  switch (getLexer().getKind()) {
  default: return MatchOperand_NoMatch;

  case AsmToken::Comma:
  case AsmToken::RBrac:
  case AsmToken::EndOfStatement:
    Operands.push_back(VEOperand::CreateMEMr(BaseReg, S, E));
    return MatchOperand_Success;

  case AsmToken:: Plus:
    Parser.Lex(); // Eat the '+'
    break;
  case AsmToken::Minus:
    break;
  }

  std::unique_ptr<VEOperand> Offset;
  OperandMatchResultTy ResTy = parseVEAsmOperand(Offset);
  if (ResTy != MatchOperand_Success || !Offset)
    return MatchOperand_NoMatch;

  Operands.push_back(
      Offset->isImm() ? VEOperand::MorphToMEMri(BaseReg, std::move(Offset))
                      : VEOperand::MorphToMEMrr(BaseReg, std::move(Offset)));

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

  if (getLexer().is(AsmToken::LBrac)) {
    // Memory operand
    Operands.push_back(VEOperand::CreateToken("[",
                                                 Parser.getTok().getLoc()));
    Parser.Lex(); // Eat the [

    if (Mnemonic == "cas" || Mnemonic == "casx" || Mnemonic == "casa") {
      SMLoc S = Parser.getTok().getLoc();
      if (getLexer().getKind() != AsmToken::Percent)
        return MatchOperand_NoMatch;
      Parser.Lex(); // eat %

      unsigned RegNo, RegKind;
      if (!matchRegisterName(Parser.getTok(), RegNo, RegKind))
        return MatchOperand_NoMatch;

      Parser.Lex(); // Eat the identifier token.
      SMLoc E = SMLoc::getFromPointer(Parser.getTok().getLoc().getPointer()-1);
      Operands.push_back(VEOperand::CreateReg(RegNo, RegKind, S, E));
      ResTy = MatchOperand_Success;
    } else {
      ResTy = parseMEMOperand(Operands);
    }

    if (ResTy != MatchOperand_Success)
      return ResTy;

    if (!getLexer().is(AsmToken::RBrac))
      return MatchOperand_ParseFail;

    Operands.push_back(VEOperand::CreateToken("]",
                                                 Parser.getTok().getLoc()));
    Parser.Lex(); // Eat the ]

    // Parse an optional address-space identifier after the address.
    if (getLexer().is(AsmToken::Integer)) {
      std::unique_ptr<VEOperand> Op;
      ResTy = parseVEAsmOperand(Op, false);
      if (ResTy != MatchOperand_Success || !Op)
        return MatchOperand_ParseFail;
      Operands.push_back(std::move(Op));
    }
    return MatchOperand_Success;
  }

  std::unique_ptr<VEOperand> Op;

  ResTy = parseVEAsmOperand(Op, (Mnemonic == "call"));
  if (ResTy != MatchOperand_Success || !Op)
    return MatchOperand_ParseFail;

  // Push the parsed operand into the list of operands
  Operands.push_back(std::move(Op));

  return MatchOperand_Success;
}

OperandMatchResultTy
VEAsmParser::parseVEAsmOperand(std::unique_ptr<VEOperand> &Op,
                                     bool isCall) {
  SMLoc S = Parser.getTok().getLoc();
  SMLoc E = SMLoc::getFromPointer(Parser.getTok().getLoc().getPointer() - 1);
  const MCExpr *EVal;

  Op = nullptr;
  switch (getLexer().getKind()) {
  default:  break;

  case AsmToken::Percent:
    Parser.Lex(); // Eat the '%'.
    unsigned RegNo;
    unsigned RegKind;
    if (matchRegisterName(Parser.getTok(), RegNo, RegKind)) {
#if 0
      StringRef name = Parser.getTok().getString();
#endif
      Parser.Lex(); // Eat the identifier token.
      E = SMLoc::getFromPointer(Parser.getTok().getLoc().getPointer() - 1);
      switch (RegNo) {
      default:
        Op = VEOperand::CreateReg(RegNo, RegKind, S, E);
        break;
#if 0
      case Sparc::PSR:
        Op = VEOperand::CreateToken("%psr", S);
        break;
      case Sparc::FSR:
        Op = VEOperand::CreateToken("%fsr", S);
        break;
      case Sparc::FQ:
        Op = VEOperand::CreateToken("%fq", S);
        break;
      case Sparc::CPSR:
        Op = VEOperand::CreateToken("%csr", S);
        break;
      case Sparc::CPQ:
        Op = VEOperand::CreateToken("%cq", S);
        break;
      case Sparc::WIM:
        Op = VEOperand::CreateToken("%wim", S);
        break;
      case Sparc::TBR:
        Op = VEOperand::CreateToken("%tbr", S);
        break;
      case Sparc::ICC:
        if (name == "xcc")
          Op = VEOperand::CreateToken("%xcc", S);
        else
          Op = VEOperand::CreateToken("%icc", S);
        break;
#endif
      }
      break;
    }
    if (matchVEAsmModifiers(EVal, E)) {
      E = SMLoc::getFromPointer(Parser.getTok().getLoc().getPointer() - 1);
      Op = VEOperand::CreateImm(EVal, S, E);
    }
    break;

  case AsmToken::Minus:
  case AsmToken::Integer:
  case AsmToken::LParen:
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
#if 0
      // FIXME: VE may need some modification here.
      if (isCall && getContext().getObjectFileInfo()->isPositionIndependent())
        Res = VEMCExpr::create(VEMCExpr::VK_VE_WPLT30, Res,
                                  getContext());
#endif
      Op = VEOperand::CreateImm(Res, S, E);
    }
    break;
  }
  }
  return (Op) ? MatchOperand_Success : MatchOperand_ParseFail;
}

OperandMatchResultTy
VEAsmParser::parseBranchModifiers(OperandVector &Operands) {
  // parse (,a|,pn|,pt)+

  while (getLexer().is(AsmToken::Comma)) {
    Parser.Lex(); // Eat the comma

    if (!getLexer().is(AsmToken::Identifier))
      return MatchOperand_ParseFail;
    StringRef modName = Parser.getTok().getString();
    if (modName == "a" || modName == "pn" || modName == "pt") {
      Operands.push_back(VEOperand::CreateToken(modName,
                                                   Parser.getTok().getLoc()));
      Parser.Lex(); // eat the identifier.
    }
  }
  return MatchOperand_Success;
}

bool VEAsmParser::matchRegisterName(const AsmToken &Tok, unsigned &RegNo,
                                       unsigned &RegKind) {
  int64_t intVal = 0;
  RegNo = 0;
  RegKind = VEOperand::rk_None;
  if (Tok.is(AsmToken::Identifier)) {
    StringRef name = Tok.getString();

    // %fp
    if (name.equals("fp")) {
      RegNo = VE::SX9;
      RegKind = VEOperand::rk_IntReg;
      return true;
    }
    // %sp
    if (name.equals("sp")) {
      RegNo = VE::SX11;
      RegKind = VEOperand::rk_IntReg;
      return true;
    }

#if 0
    // %f0 - %f31
    if (name.substr(0, 1).equals_lower("f")
        && !name.substr(1, 2).getAsInteger(10, intVal) && intVal < 32) {
      RegNo = FloatRegs[intVal];
      RegKind = VEOperand::rk_FloatReg;
      return true;
    }
    // %f32 - %f62
    if (name.substr(0, 1).equals_lower("f")
        && !name.substr(1, 2).getAsInteger(10, intVal)
        && intVal >= 32 && intVal <= 62 && (intVal % 2 == 0)) {
      // FIXME: Check V9
      RegNo = DoubleRegs[intVal/2];
      RegKind = VEOperand::rk_DoubleReg;
      return true;
    }
#endif

    // %s0 - %s63
    if (name.substr(0, 1).equals_lower("s")
        && !name.substr(1).getAsInteger(10, intVal) && intVal < 64) {
      RegNo = IntRegs[intVal];
      RegKind = VEOperand::rk_IntReg;
      return true;
    }

    if (name.equals("usrcc")) {
      RegNo = VE::UCC;
      RegKind = VEOperand::rk_Special;
      return true;
    }
  }
  return false;
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

extern "C" void LLVMInitializeVEAsmParser() {
  RegisterMCAsmParser<VEAsmParser> A(getTheVETarget());
}

#define GET_REGISTER_MATCHER
#define GET_MATCHER_IMPLEMENTATION
#include "VEGenAsmMatcher.inc"

unsigned VEAsmParser::validateTargetOperandClass(MCParsedAsmOperand &GOp,
                                                    unsigned Kind) {
  VEOperand &Op = (VEOperand &)GOp;
  if (Op.isFloatOrDoubleReg()) {
    switch (Kind) {
    default: break;
#if 0
    case MCK_DFPRegs:
      if (!Op.isFloatReg() || VEOperand::MorphToDoubleReg(Op))
        return MCTargetAsmParser::Match_Success;
      break;
    case MCK_QFPRegs:
      if (VEOperand::MorphToQuadReg(Op))
        return MCTargetAsmParser::Match_Success;
      break;
#endif
    }
  }
#if 0
  if (Op.isIntReg() && Kind == MCK_IntPair) {
    if (VEOperand::MorphToIntPairReg(Op))
      return MCTargetAsmParser::Match_Success;
  }
  if (Op.isCoprocReg() && Kind == MCK_CoprocPair) {
     if (VEOperand::MorphToCoprocPairReg(Op))
       return MCTargetAsmParser::Match_Success;
   }
#endif
  return Match_InvalidOperand;
}
