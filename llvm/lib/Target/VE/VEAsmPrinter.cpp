//===-- VEAsmPrinter.cpp - VE LLVM assembly writer ------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains a printer that converts from our internal representation
// of machine-dependent LLVM code to GAS-format VE assembly language.
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/VEInstPrinter.h"
#include "MCTargetDesc/VEMCExpr.h"
#include "MCTargetDesc/VETargetStreamer.h"
#include "TargetInfo/VETargetInfo.h"
#include "VE.h"
#include "VEInstrInfo.h"
#include "VETargetMachine.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/CodeGen/MachineModuleInfoImpls.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "llvm/IR/Mangler.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCInst.h"
#include "llvm/MC/MCInstBuilder.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSymbol.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

#define DEBUG_TYPE "ve-asmprinter"

namespace {
class VEAsmPrinter : public AsmPrinter {
  VETargetStreamer &getTargetStreamer() {
    return static_cast<VETargetStreamer &>(*OutStreamer->getTargetStreamer());
  }

public:
  explicit VEAsmPrinter(TargetMachine &TM, std::unique_ptr<MCStreamer> Streamer)
      : AsmPrinter(TM, std::move(Streamer)) {}

  StringRef getPassName() const override { return "VE Assembly Printer"; }

  void lowerGETGOTAndEmitMCInsts(const MachineInstr *MI,
                                 const MCSubtargetInfo &STI);
  void lowerGETFunPLTAndEmitMCInsts(const MachineInstr *MI,
                                    const MCSubtargetInfo &STI);
  void lowerGETTLSAddrAndEmitMCInsts(const MachineInstr *MI,
                                     const MCSubtargetInfo &STI);

  // Expand non-native fp conversions
  void lowerFPConversionAndEmitMCInsts(const MachineInstr *MI,
                                       const MCSubtargetInfo &STI);

  void emitInstruction(const MachineInstr *MI) override;

  static const char *getRegisterName(unsigned RegNo) {
    return VEInstPrinter::getRegisterName(RegNo);
  }
  void printOperand(const MachineInstr *MI, int OpNum, raw_ostream &OS);
  bool PrintAsmOperand(const MachineInstr *MI, unsigned OpNo,
                       const char *ExtraCode, raw_ostream &O) override;
  bool PrintAsmMemoryOperand(const MachineInstr *MI, unsigned OpNo,
                             const char *ExtraCode, raw_ostream &O) override;
};
} // end of anonymous namespace

static MCOperand createVEMCOperand(VEMCExpr::VariantKind Kind, MCSymbol *Sym,
                                   MCContext &OutContext) {
  const MCSymbolRefExpr *MCSym = MCSymbolRefExpr::create(Sym, OutContext);
  const VEMCExpr *expr = VEMCExpr::create(Kind, MCSym, OutContext);
  return MCOperand::createExpr(expr);
}

static MCOperand createGOTRelExprOp(VEMCExpr::VariantKind Kind,
                                    MCSymbol *GOTLabel, MCContext &OutContext) {
  const MCSymbolRefExpr *GOT = MCSymbolRefExpr::create(GOTLabel, OutContext);
  const VEMCExpr *expr = VEMCExpr::create(Kind, GOT, OutContext);
  return MCOperand::createExpr(expr);
}

static void emitSIC(MCStreamer &OutStreamer, MCOperand &RD,
                    const MCSubtargetInfo &STI) {
  MCInst SICInst;
  SICInst.setOpcode(VE::SIC);
  SICInst.addOperand(RD);
  OutStreamer.emitInstruction(SICInst, STI);
}

static void emitBSIC(MCStreamer &OutStreamer, MCOperand &R1, MCOperand &R2,
                     const MCSubtargetInfo &STI) {
  MCInst BSICInst;
  BSICInst.setOpcode(VE::BSICrii);
  BSICInst.addOperand(R1);
  BSICInst.addOperand(R2);
  MCOperand czero = MCOperand::createImm(0);
  BSICInst.addOperand(czero);
  BSICInst.addOperand(czero);
  OutStreamer.emitInstruction(BSICInst, STI);
}

static void emitLEAzzi(MCStreamer &OutStreamer, MCOperand &Imm, MCOperand &RD,
                       const MCSubtargetInfo &STI) {
  MCInst LEAInst;
  LEAInst.setOpcode(VE::LEAzii);
  LEAInst.addOperand(RD);
  MCOperand CZero = MCOperand::createImm(0);
  LEAInst.addOperand(CZero);
  LEAInst.addOperand(CZero);
  LEAInst.addOperand(Imm);
  OutStreamer.emitInstruction(LEAInst, STI);
}

static void emitLEASLzzi(MCStreamer &OutStreamer, MCOperand &Imm, MCOperand &RD,
                         const MCSubtargetInfo &STI) {
  MCInst LEASLInst;
  LEASLInst.setOpcode(VE::LEASLzii);
  LEASLInst.addOperand(RD);
  MCOperand CZero = MCOperand::createImm(0);
  LEASLInst.addOperand(CZero);
  LEASLInst.addOperand(CZero);
  LEASLInst.addOperand(Imm);
  OutStreamer.emitInstruction(LEASLInst, STI);
}

static void emitLEAzii(MCStreamer &OutStreamer, MCOperand &RS1, MCOperand &Imm,
                       MCOperand &RD, const MCSubtargetInfo &STI) {
  MCInst LEAInst;
  LEAInst.setOpcode(VE::LEAzii);
  LEAInst.addOperand(RD);
  MCOperand CZero = MCOperand::createImm(0);
  LEAInst.addOperand(CZero);
  LEAInst.addOperand(RS1);
  LEAInst.addOperand(Imm);
  OutStreamer.emitInstruction(LEAInst, STI);
}

static void emitLEASLrri(MCStreamer &OutStreamer, MCOperand &RS1,
                         MCOperand &RS2, MCOperand &Imm, MCOperand &RD,
                         const MCSubtargetInfo &STI) {
  MCInst LEASLInst;
  LEASLInst.setOpcode(VE::LEASLrri);
  LEASLInst.addOperand(RD);
  LEASLInst.addOperand(RS1);
  LEASLInst.addOperand(RS2);
  LEASLInst.addOperand(Imm);
  OutStreamer.emitInstruction(LEASLInst, STI);
}

static void emitBinary(MCStreamer &OutStreamer, unsigned Opcode, MCOperand &RS1,
                       MCOperand &Src2, MCOperand &RD,
                       const MCSubtargetInfo &STI) {
  MCInst Inst;
  Inst.setOpcode(Opcode);
  Inst.addOperand(RD);
  Inst.addOperand(RS1);
  Inst.addOperand(Src2);
  OutStreamer.emitInstruction(Inst, STI);
}

static void emitANDrm(MCStreamer &OutStreamer, MCOperand &RS1, MCOperand &Imm,
                      MCOperand &RD, const MCSubtargetInfo &STI) {
  emitBinary(OutStreamer, VE::ANDrm, RS1, Imm, RD, STI);
}

static void emitHiLo(MCStreamer &OutStreamer, MCSymbol *GOTSym,
                     VEMCExpr::VariantKind HiKind, VEMCExpr::VariantKind LoKind,
                     MCOperand &RD, MCContext &OutContext,
                     const MCSubtargetInfo &STI) {

  MCOperand hi = createVEMCOperand(HiKind, GOTSym, OutContext);
  MCOperand lo = createVEMCOperand(LoKind, GOTSym, OutContext);
  emitLEAzzi(OutStreamer, lo, RD, STI);
  MCOperand M032 = MCOperand::createImm(M0(32));
  emitANDrm(OutStreamer, RD, M032, RD, STI);
  emitLEASLzzi(OutStreamer, hi, RD, STI);
}

void VEAsmPrinter::lowerGETGOTAndEmitMCInsts(const MachineInstr *MI,
                                             const MCSubtargetInfo &STI) {
  MCSymbol *GOTLabel =
      OutContext.getOrCreateSymbol(Twine("_GLOBAL_OFFSET_TABLE_"));

  const MachineOperand &MO = MI->getOperand(0);
  MCOperand MCRegOP = MCOperand::createReg(MO.getReg());

  if (!isPositionIndependent()) {
    // Just load the address of GOT to MCRegOP.
    switch (TM.getCodeModel()) {
    default:
      llvm_unreachable("Unsupported absolute code model");
    case CodeModel::Small:
    case CodeModel::Medium:
    case CodeModel::Large:
      emitHiLo(*OutStreamer, GOTLabel, VEMCExpr::VK_VE_HI32,
               VEMCExpr::VK_VE_LO32, MCRegOP, OutContext, STI);
      break;
    }
    return;
  }

  MCOperand RegGOT = MCOperand::createReg(VE::SX15); // GOT
  MCOperand RegPLT = MCOperand::createReg(VE::SX16); // PLT

  // lea %got, _GLOBAL_OFFSET_TABLE_@PC_LO(-24)
  // and %got, %got, (32)0
  // sic %plt
  // lea.sl %got, _GLOBAL_OFFSET_TABLE_@PC_HI(%plt, %got)
  MCOperand cim24 = MCOperand::createImm(-24);
  MCOperand loImm =
      createGOTRelExprOp(VEMCExpr::VK_VE_PC_LO32, GOTLabel, OutContext);
  emitLEAzii(*OutStreamer, cim24, loImm, MCRegOP, STI);
  MCOperand M032 = MCOperand::createImm(M0(32));
  emitANDrm(*OutStreamer, MCRegOP, M032, MCRegOP, STI);
  emitSIC(*OutStreamer, RegPLT, STI);
  MCOperand hiImm =
      createGOTRelExprOp(VEMCExpr::VK_VE_PC_HI32, GOTLabel, OutContext);
  emitLEASLrri(*OutStreamer, RegGOT, RegPLT, hiImm, MCRegOP, STI);
}

void VEAsmPrinter::lowerGETFunPLTAndEmitMCInsts(const MachineInstr *MI,
                                                const MCSubtargetInfo &STI) {
  const MachineOperand &MO = MI->getOperand(0);
  MCOperand MCRegOP = MCOperand::createReg(MO.getReg());
  const MachineOperand &Addr = MI->getOperand(1);
  MCSymbol *AddrSym = nullptr;

  switch (Addr.getType()) {
  default:
    llvm_unreachable("<unknown operand type>");
    return;
  case MachineOperand::MO_MachineBasicBlock:
    report_fatal_error("MBB is not supported yet");
    return;
  case MachineOperand::MO_ConstantPoolIndex:
    report_fatal_error("ConstantPool is not supported yet");
    return;
  case MachineOperand::MO_ExternalSymbol:
    AddrSym = GetExternalSymbolSymbol(Addr.getSymbolName());
    break;
  case MachineOperand::MO_GlobalAddress:
    AddrSym = getSymbol(Addr.getGlobal());
    break;
  }

  if (!isPositionIndependent()) {
    llvm_unreachable("Unsupported uses of %plt in not PIC code");
    return;
  }

  MCOperand RegPLT = MCOperand::createReg(VE::SX16); // PLT

  // lea %dst, func@plt_lo(-24)
  // and %dst, %dst, (32)0
  // sic %plt                            ; FIXME: is it safe to use %plt here?
  // lea.sl %dst, func@plt_hi(%plt, %dst)
  MCOperand cim24 = MCOperand::createImm(-24);
  MCOperand loImm =
      createGOTRelExprOp(VEMCExpr::VK_VE_PLT_LO32, AddrSym, OutContext);
  emitLEAzii(*OutStreamer, cim24, loImm, MCRegOP, STI);
  MCOperand M032 = MCOperand::createImm(M0(32));
  emitANDrm(*OutStreamer, MCRegOP, M032, MCRegOP, STI);
  emitSIC(*OutStreamer, RegPLT, STI);
  MCOperand hiImm =
      createGOTRelExprOp(VEMCExpr::VK_VE_PLT_HI32, AddrSym, OutContext);
  emitLEASLrri(*OutStreamer, MCRegOP, RegPLT, hiImm, MCRegOP, STI);
}

void VEAsmPrinter::lowerGETTLSAddrAndEmitMCInsts(const MachineInstr *MI,
                                                 const MCSubtargetInfo &STI) {
  const MachineOperand &Addr = MI->getOperand(0);
  MCSymbol *AddrSym = nullptr;

  switch (Addr.getType()) {
  default:
    llvm_unreachable("<unknown operand type>");
    return;
  case MachineOperand::MO_MachineBasicBlock:
    report_fatal_error("MBB is not supported yet");
    return;
  case MachineOperand::MO_ConstantPoolIndex:
    report_fatal_error("ConstantPool is not supported yet");
    return;
  case MachineOperand::MO_ExternalSymbol:
    AddrSym = GetExternalSymbolSymbol(Addr.getSymbolName());
    break;
  case MachineOperand::MO_GlobalAddress:
    AddrSym = getSymbol(Addr.getGlobal());
    break;
  }

  MCOperand RegLR = MCOperand::createReg(VE::SX10);  // LR
  MCOperand RegS0 = MCOperand::createReg(VE::SX0);   // S0
  MCOperand RegS12 = MCOperand::createReg(VE::SX12); // S12
  MCSymbol *GetTLSLabel = OutContext.getOrCreateSymbol(Twine("__tls_get_addr"));

  // lea %s0, sym@tls_gd_lo(-24)
  // and %s0, %s0, (32)0
  // sic %lr
  // lea.sl %s0, sym@tls_gd_hi(%lr, %s0)
  // lea %s12, __tls_get_addr@plt_lo(8)
  // and %s12, %s12, (32)0
  // lea.sl %s12, __tls_get_addr@plt_hi(%s12, %lr)
  // bsic %lr, (, %s12)
  MCOperand cim24 = MCOperand::createImm(-24);
  MCOperand loImm =
      createGOTRelExprOp(VEMCExpr::VK_VE_TLS_GD_LO32, AddrSym, OutContext);
  emitLEAzii(*OutStreamer, cim24, loImm, RegS0, STI);
  MCOperand M032 = MCOperand::createImm(M0(32));
  emitANDrm(*OutStreamer, RegS0, M032, RegS0, STI);
  emitSIC(*OutStreamer, RegLR, STI);
  MCOperand hiImm =
      createGOTRelExprOp(VEMCExpr::VK_VE_TLS_GD_HI32, AddrSym, OutContext);
  emitLEASLrri(*OutStreamer, RegS0, RegLR, hiImm, RegS0, STI);
  MCOperand ci8 = MCOperand::createImm(8);
  MCOperand loImm2 =
      createGOTRelExprOp(VEMCExpr::VK_VE_PLT_LO32, GetTLSLabel, OutContext);
  emitLEAzii(*OutStreamer, ci8, loImm2, RegS12, STI);
  emitANDrm(*OutStreamer, RegS12, M032, RegS12, STI);
  MCOperand hiImm2 =
      createGOTRelExprOp(VEMCExpr::VK_VE_PLT_HI32, GetTLSLabel, OutContext);
  emitLEASLrri(*OutStreamer, RegS12, RegLR, hiImm2, RegS12, STI);
  emitBSIC(*OutStreamer, RegLR, RegS12, STI);
}

static void emit_vml_v(MCStreamer &OutStreamer, unsigned OC,
                       MCOperand &InV,
                       MCOperand &Mask, MCOperand &VL,
                       MCOperand &ResV,
                       MCOperand &Passthru,
                       const MCSubtargetInfo &STI) {
  MCInst Inst;
  Inst.setOpcode(OC);
  // ins
  Inst.addOperand(InV); // v
  Inst.addOperand(Mask); // x
  Inst.addOperand(VL); // l
  Inst.addOperand(Passthru); // _v
  // outs
  Inst.addOperand(ResV);
  OutStreamer.emitInstruction(Inst, STI);
}

static void emit_vml(MCStreamer &OutStreamer, unsigned OC,
                       MCOperand &InV,
                       MCOperand &Mask, MCOperand &VL,
                       MCOperand &ResV,
                       const MCSubtargetInfo &STI) {
  MCInst Inst;
  Inst.setOpcode(OC);
  // ins
  Inst.addOperand(InV); // v
  Inst.addOperand(Mask); // x
  Inst.addOperand(VL); // l
  // outs
  Inst.addOperand(ResV);
  OutStreamer.emitInstruction(Inst, STI);
}

static void emit_vl(MCStreamer &OutStreamer, unsigned OC,
                       MCOperand &InV,
                       MCOperand &VL,
                       MCOperand &ResV,
                       const MCSubtargetInfo &STI) {
  MCInst Inst;
  Inst.setOpcode(OC);
  // ins
  Inst.addOperand(InV); // v
  Inst.addOperand(VL); // l
  // outs
  Inst.addOperand(ResV);
  OutStreamer.emitInstruction(Inst, STI);
}

static void emit_rdvml_v(MCStreamer &OutStreamer, unsigned OC,
                       MCOperand &RdV,
                       MCOperand &InV,
                       MCOperand &Mask, MCOperand &VL,
                       MCOperand &ResV,
                       MCOperand &Passthru,
                       const MCSubtargetInfo &STI) {
  MCInst Inst;
  Inst.setOpcode(OC);
  // ins
  Inst.addOperand(RdV); // rd (rounding mode operand)
  Inst.addOperand(InV); // v
  Inst.addOperand(Mask); // x
  Inst.addOperand(VL); // l
  Inst.addOperand(Passthru); // _v
  // Inst.addOperand(PassthruV); // _v // [implicit]
  // outs
  Inst.addOperand(ResV);
  OutStreamer.emitInstruction(Inst, STI);
}

static void emit_rdvml(MCStreamer &OutStreamer, unsigned OC,
                       MCOperand &RdV,
                       MCOperand &InV,
                       MCOperand &Mask, MCOperand &VL,
                       MCOperand &ResV,
                       const MCSubtargetInfo &STI) {
  MCInst Inst;
  Inst.setOpcode(OC);
  // ins
  Inst.addOperand(RdV); // rd (rounding mode operand)
  Inst.addOperand(InV); // v
  Inst.addOperand(Mask); // x
  Inst.addOperand(VL); // l
  // Inst.addOperand(PassthruV); // _v // [implicit]
  // outs
  Inst.addOperand(ResV);
  OutStreamer.emitInstruction(Inst, STI);
}

static void emit_rdvl(MCStreamer &OutStreamer, unsigned OC,
                       MCOperand &RdV,
                       MCOperand &InV,
                       MCOperand &VL,
                       MCOperand &ResV,
                       const MCSubtargetInfo &STI) {
  MCInst Inst;
  Inst.setOpcode(OC);
  // ins
  Inst.addOperand(RdV); // rd (rounding mode operand)
  Inst.addOperand(InV); // v
  Inst.addOperand(VL); // l
  // outs
  Inst.addOperand(ResV);
  OutStreamer.emitInstruction(Inst, STI);
}

static MCOperand getRegOperand(const MachineOperand& MO) {
  assert(MO.isReg());
  return MCOperand::createReg(MO.getReg());
}

static MCOperand getImmOperand(const MachineOperand& MO) {
  assert(MO.isImm());
  return MCOperand::createImm(MO.getImm());
}

void VEAsmPrinter::lowerFPConversionAndEmitMCInsts(const MachineInstr *MI,
                                                 const MCSubtargetInfo &STI) {
  MCOperand ResV, RdOpV, SrcV, Mask, VL, PassThruV;
  switch (MI->getOpcode()) {
    // VCVTLS
    case VE::VCVTLSvl:
      ResV = getRegOperand(MI->getOperand(0));
      RdOpV = getImmOperand(MI->getOperand(1));
      SrcV = getRegOperand(MI->getOperand(2));
      VL = getRegOperand(MI->getOperand(3));
      break;

    case VE::VCVTLSvml_v:
      PassThruV = getRegOperand(MI->getOperand(5));
      LLVM_FALLTHROUGH;
    case VE::VCVTLSvml:
      ResV = getRegOperand(MI->getOperand(0));
      RdOpV = getImmOperand(MI->getOperand(1));
      SrcV = getRegOperand(MI->getOperand(2));
      Mask = getRegOperand(MI->getOperand(3));
      VL = getRegOperand(MI->getOperand(4));
      break;

    // VCVTSL
    case VE::VCVTSLvl:
      ResV = getRegOperand(MI->getOperand(0));
      SrcV = getRegOperand(MI->getOperand(1));
      VL = getRegOperand(MI->getOperand(2));
      break;
    case VE::VCVTSLvml_v:
      PassThruV = getRegOperand(MI->getOperand(4));
      LLVM_FALLTHROUGH;
    case VE::VCVTSLvml:
      ResV = getRegOperand(MI->getOperand(0));
      SrcV = getRegOperand(MI->getOperand(1));
      Mask = getRegOperand(MI->getOperand(2));
      VL = getRegOperand(MI->getOperand(3));
    break;
  }

  // VCVTLS
  // Conversion chain: float -> double -> long.
  if (RdOpV.isValid()) {
    // vml_v
    if (PassThruV.isValid()) {
      emit_vml_v(*OutStreamer, VE::VCVTDSvml, ResV, SrcV, Mask, VL, PassThruV, STI);
      emit_rdvml_v(*OutStreamer, VE::VCVTLDvml_v, ResV, RdOpV, ResV, Mask, VL, ResV, STI);
      return;
    }
    // vml
    if (Mask.isValid()) {
      emit_vml(*OutStreamer, VE::VCVTDSvml, ResV, SrcV, Mask, VL, STI);
      emit_rdvml(*OutStreamer, VE::VCVTLDvml, ResV, RdOpV, ResV, Mask, VL, STI);
      return;
    }

    // vl
    emit_vl(*OutStreamer, VE::VCVTDSvl, ResV, SrcV, VL, STI);
    emit_rdvl(*OutStreamer, VE::VCVTLDvl, ResV, RdOpV, ResV, VL, STI);
  }

  // VCVTSL
  // Conversion chain: long -> double -> float.
  if (PassThruV.isValid()) {
    // vml_v
    emit_vml_v(*OutStreamer, VE::VCVTDLvml, ResV, SrcV, Mask, VL, PassThruV,STI);
    emit_vml_v(*OutStreamer, VE::VCVTSDvml_v, ResV, ResV, Mask, VL, ResV, STI);
  }
  // vml
  if (Mask.isValid()) {
    emit_vml(*OutStreamer, VE::VCVTDLvml, ResV, SrcV, Mask, VL, STI);
    emit_vml(*OutStreamer, VE::VCVTSDvml, ResV, ResV, Mask, VL, STI);
  }

  // vl
  emit_vl(*OutStreamer, VE::VCVTDLvl, ResV, SrcV, VL, STI);
  emit_vl(*OutStreamer, VE::VCVTSDvl, ResV, ResV, VL, STI);
}


#define FPCONV_CASES(BASEOPC) \
case VE::BASEOPC##vl: \
case VE::BASEOPC##vml_v: \
case VE::BASEOPC##vml:

void VEAsmPrinter::emitInstruction(const MachineInstr *MI) {
  switch (MI->getOpcode()) {
  default:
    break;
  case TargetOpcode::DBG_VALUE:
    // FIXME: Debug Value.
    return;
FPCONV_CASES(VCVTLS)
FPCONV_CASES(VCVTSL)
#undef FPCONV_CASES
    lowerFPConversionAndEmitMCInsts(MI, getSubtargetInfo());
    return;

  case VE::GETGOT:
    lowerGETGOTAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  case VE::GETFUNPLT:
    lowerGETFunPLTAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  case VE::GETTLSADDR:
    lowerGETTLSAddrAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  // Emit nothing here but a comment if we can.
  case VE::MEMBARRIER:
    OutStreamer->emitRawComment("MEMBARRIER");
    return;
  }

  MachineBasicBlock::const_instr_iterator I = MI->getIterator();
  MachineBasicBlock::const_instr_iterator E = MI->getParent()->instr_end();
  do {
    MCInst TmpInst;
    LowerVEMachineInstrToMCInst(&*I, TmpInst, *this);
    EmitToStreamer(*OutStreamer, TmpInst);
  } while ((++I != E) && I->isInsideBundle()); // Delay slot check.
}

void VEAsmPrinter::printOperand(const MachineInstr *MI, int OpNum,
                                raw_ostream &O) {
  const DataLayout &DL = getDataLayout();
  const MachineOperand &MO = MI->getOperand(OpNum);
  VEMCExpr::VariantKind TF = (VEMCExpr::VariantKind) MO.getTargetFlags();

#ifndef NDEBUG
  // Verify the target flags.
  if (MO.isGlobal() || MO.isSymbol() || MO.isCPI()) {
#if 0
    if (MI->getOpcode() == SP::CALL)
      assert(TF == VEMCExpr::VK_VE_None &&
             "Cannot handle target flags on call address");
    else if (MI->getOpcode() == VE::LEASL)
      assert((TF == VEMCExpr::VK_VE_HI
              || TF == VEMCExpr::VK_VE_H44
              || TF == VEMCExpr::VK_VE_HH
              || TF == VEMCExpr::VK_VE_TLS_GD_HI22
              || TF == VEMCExpr::VK_VE_TLS_LDM_HI22
              || TF == VEMCExpr::VK_VE_TLS_LDO_HIX22
              || TF == VEMCExpr::VK_VE_TLS_IE_HI22
              || TF == VEMCExpr::VK_VE_TLS_LE_HIX22) &&
             "Invalid target flags for address operand on sethi");
    else if (MI->getOpcode() == SP::XORri || MI->getOpcode() == SP::XORXri)
      assert((TF == VEMCExpr::VK_VE_TLS_LDO_LOX10
              || TF == VEMCExpr::VK_VE_TLS_LE_LOX10) &&
             "Cannot handle target flags on xor for TLS");
    else
      assert((TF == VEMCExpr::VK_VE_LO
              || TF == VEMCExpr::VK_VE_M44
              || TF == VEMCExpr::VK_VE_L44
              || TF == VEMCExpr::VK_VE_HM
              || TF == VEMCExpr::VK_VE_TLS_GD_LO10
              || TF == VEMCExpr::VK_VE_TLS_LDM_LO10
              || TF == VEMCExpr::VK_VE_TLS_IE_LO10 ) &&
             "Invalid target flags for small address operand");
#endif
  }
#endif


  bool CloseParen = VEMCExpr::printVariantKind(O, TF);

  switch (MO.getType()) {
  case MachineOperand::MO_Register:
    O << "%" << StringRef(getRegisterName(MO.getReg())).lower();
    break;

  case MachineOperand::MO_Immediate:
    O << (int)MO.getImm();
    break;
  case MachineOperand::MO_MachineBasicBlock:
    MO.getMBB()->getSymbol()->print(O, MAI);
    return;
  case MachineOperand::MO_GlobalAddress:
    getSymbol(MO.getGlobal())->print(O, MAI);
    break;
  case MachineOperand::MO_BlockAddress:
    O <<  GetBlockAddressSymbol(MO.getBlockAddress())->getName();
    break;
  case MachineOperand::MO_ExternalSymbol:
    O << MO.getSymbolName();
    break;
  case MachineOperand::MO_ConstantPoolIndex:
    O << DL.getPrivateGlobalPrefix() << "CPI" << getFunctionNumber() << "_"
      << MO.getIndex();
    break;
  case MachineOperand::MO_Metadata:
    MO.getMetadata()->printAsOperand(O, MMI->getModule());
    break;
  default:
    llvm_unreachable("<unknown operand type>");
  }
  if (CloseParen) O << ")";
  VEMCExpr::printVariantKindSuffix(O, TF);
}

// PrintAsmOperand - Print out an operand for an inline asm expression.
bool VEAsmPrinter::PrintAsmOperand(const MachineInstr *MI, unsigned OpNo,
                                   const char *ExtraCode, raw_ostream &O) {
  if (ExtraCode && ExtraCode[0]) {
    if (ExtraCode[1] != 0)
      return true; // Unknown modifier.

    switch (ExtraCode[0]) {
    default:
      // See if this is a generic print operand
      return AsmPrinter::PrintAsmOperand(MI, OpNo, ExtraCode, O);
    case 'r':
    case 'v':
      break;
    case 'f':
     break;
    }
  }

  printOperand(MI, OpNo, O);

  return false;
}

bool VEAsmPrinter::PrintAsmMemoryOperand(const MachineInstr *MI, unsigned OpNo,
                                         const char *ExtraCode,
                                         raw_ostream &O) {
  if (ExtraCode && ExtraCode[0])
    return true;  // Unknown modifier

  if (MI->getOperand(OpNo+1).isImm() &&
      MI->getOperand(OpNo+1).getImm() == 0) {
    // don't print "+0"
  } else {
    printOperand(MI, OpNo+1, O);
  }
  if (MI->getOperand(OpNo).isImm() &&
      MI->getOperand(OpNo).getImm() == 0) {
    if (MI->getOperand(OpNo+1).isImm() &&
        MI->getOperand(OpNo+1).getImm() == 0) {
      O << "0";
    } else {
      // don't print "(0)"
    }
  } else {
    O << "(";
    printOperand(MI, OpNo, O);
    O << ")";
  }
  return false;
}

// Force static initialization.
extern "C" LLVM_EXTERNAL_VISIBILITY void LLVMInitializeVEAsmPrinter() {
  RegisterAsmPrinter<VEAsmPrinter> X(getTheVETarget());
}
