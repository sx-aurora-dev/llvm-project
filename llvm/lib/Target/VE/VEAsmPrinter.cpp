//===-- VEAsmPrinter.cpp - VE LLVM assembly writer ------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains a printer that converts from our internal representation
// of machine-dependent LLVM code to GAS-format SPARC assembly language.
//
//===----------------------------------------------------------------------===//

#include "InstPrinter/VEInstPrinter.h"
#include "MCTargetDesc/VEMCExpr.h"
#include "VE.h"
#include "VEInstrInfo.h"
#include "VETargetMachine.h"
#include "MCTargetDesc/VETargetStreamer.h"
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
#include "llvm/Support/TargetRegistry.h"
#include "llvm/Support/raw_ostream.h"
using namespace llvm;

#define DEBUG_TYPE "asm-printer"

namespace {
  class VEAsmPrinter : public AsmPrinter {
    VETargetStreamer &getTargetStreamer() {
      return static_cast<VETargetStreamer &>(
          *OutStreamer->getTargetStreamer());
    }
  public:
    explicit VEAsmPrinter(TargetMachine &TM,
                             std::unique_ptr<MCStreamer> Streamer)
        : AsmPrinter(TM, std::move(Streamer)) {}

    StringRef getPassName() const override { return "VE Assembly Printer"; }

    void printOperand(const MachineInstr *MI, int opNum, raw_ostream &OS);
    void printMemASXOperand(const MachineInstr *MI, int opNum, raw_ostream &OS,
                         const char *Modifier = nullptr);
    void printMemASOperand(const MachineInstr *MI, int opNum, raw_ostream &OS,
                           const char *Modifier = nullptr);

    void EmitFunctionBodyStart() override;
    void EmitInstruction(const MachineInstr *MI) override;

    static const char *getRegisterName(unsigned RegNo) {
      return VEInstPrinter::getRegisterName(RegNo);
    }

    bool PrintAsmOperand(const MachineInstr *MI, unsigned OpNo,
                         const char *ExtraCode, raw_ostream &O) override;
    bool PrintAsmMemoryOperand(const MachineInstr *MI, unsigned OpNo,
                               const char *ExtraCode, raw_ostream &O) override;

    void LowerGETGOTAndEmitMCInsts(const MachineInstr *MI,
                                   const MCSubtargetInfo &STI);
    void LowerGETFunPLTAndEmitMCInsts(const MachineInstr *MI,
                                      const MCSubtargetInfo &STI);
    void LowerGETTLSAddrAndEmitMCInsts(const MachineInstr *MI,
                                       const MCSubtargetInfo &STI);
    void LowerEH_SJLJ_SETJMPAndEmitMCInsts(const MachineInstr *MI,
                                           const MCSubtargetInfo &STI);
    void LowerEH_SJLJ_LONGJMPAndEmitMCInsts(const MachineInstr *MI,
                                            const MCSubtargetInfo &STI);
    void LowerVM2VAndEmitMCInsts(const MachineInstr *MI,
                                 const MCSubtargetInfo &STI);
    void LowerVMP2VAndEmitMCInsts(const MachineInstr *MI,
                                  const MCSubtargetInfo &STI);
    void LowerV2VMAndEmitMCInsts(const MachineInstr *MI,
                                 const MCSubtargetInfo &STI);
    void LowerV2VMPAndEmitMCInsts(const MachineInstr *MI,
                                  const MCSubtargetInfo &STI);

  };
} // end of anonymous namespace

static MCOperand createVEMCOperand(VEMCExpr::VariantKind Kind,
                                      MCSymbol *Sym, MCContext &OutContext) {
  const MCSymbolRefExpr *MCSym = MCSymbolRefExpr::create(Sym,
                                                         OutContext);
  const VEMCExpr *expr = VEMCExpr::create(Kind, MCSym, OutContext);
  return MCOperand::createExpr(expr);

}

static MCOperand createGOTRelExprOp(VEMCExpr::VariantKind Kind,
                                    MCSymbol *GOTLabel,
                                    MCContext &OutContext)
{
  const MCSymbolRefExpr *GOT = MCSymbolRefExpr::create(GOTLabel, OutContext);
  const VEMCExpr *expr = VEMCExpr::create(Kind, GOT, OutContext);
  return MCOperand::createExpr(expr);
}

static void EmitSIC(MCStreamer &OutStreamer,
                    MCOperand &RD, const MCSubtargetInfo &STI) {
  MCInst SICInst;
  SICInst.setOpcode(VE::SIC);
  SICInst.addOperand(RD);
  OutStreamer.EmitInstruction(SICInst, STI);
}

static void EmitBSIC(MCStreamer &OutStreamer,
                    MCOperand &R1, MCOperand &R2, const MCSubtargetInfo &STI) {
  MCInst BSICInst;
  BSICInst.setOpcode(VE::BSIC);
  BSICInst.addOperand(R1);
  BSICInst.addOperand(R2);
  OutStreamer.EmitInstruction(BSICInst, STI);
}

static void EmitLEAzzi(MCStreamer &OutStreamer,
                    MCOperand &Imm, MCOperand &RD,
                    const MCSubtargetInfo &STI)
{
  MCInst LEAInst;
  LEAInst.setOpcode(VE::LEAzzi);
  LEAInst.addOperand(RD);
  LEAInst.addOperand(Imm);
  OutStreamer.EmitInstruction(LEAInst, STI);
}

static void EmitLEASLzzi(MCStreamer &OutStreamer,
                      MCOperand &Imm, MCOperand &RD,
                      const MCSubtargetInfo &STI)
{
  MCInst LEASLInst;
  LEASLInst.setOpcode(VE::LEASLzzi);
  LEASLInst.addOperand(RD);
  LEASLInst.addOperand(Imm);
  OutStreamer.EmitInstruction(LEASLInst, STI);
}

static void EmitLEAzii(MCStreamer &OutStreamer,
                       MCOperand &RS1, MCOperand &Imm, MCOperand &RD,
                       const MCSubtargetInfo &STI)
{
  MCInst LEAInst;
  LEAInst.setOpcode(VE::LEAzii);
  LEAInst.addOperand(RD);
  LEAInst.addOperand(RS1);
  LEAInst.addOperand(Imm);
  OutStreamer.EmitInstruction(LEAInst, STI);
}

static void EmitLEASLrri(MCStreamer &OutStreamer,
                         MCOperand &RS1, MCOperand &RS2,
                         MCOperand &Imm, MCOperand &RD,
                         const MCSubtargetInfo &STI)
{
  MCInst LEASLInst;
  LEASLInst.setOpcode(VE::LEASLrri);
  LEASLInst.addOperand(RS1);
  LEASLInst.addOperand(RS2);
  LEASLInst.addOperand(RD);
  LEASLInst.addOperand(Imm);
  OutStreamer.EmitInstruction(LEASLInst, STI);
}

static void EmitBinary(MCStreamer &OutStreamer, unsigned Opcode,
                       MCOperand &RS1, MCOperand &Src2, MCOperand &RD,
                       const MCSubtargetInfo &STI)
{
  MCInst Inst;
  Inst.setOpcode(Opcode);
  Inst.addOperand(RD);
  Inst.addOperand(RS1);
  Inst.addOperand(Src2);
  OutStreamer.EmitInstruction(Inst, STI);
}

static void EmitANDrm0(MCStreamer &OutStreamer,
                       MCOperand &RS1, MCOperand &Imm, MCOperand &RD,
                       const MCSubtargetInfo &STI) {
  EmitBinary(OutStreamer, VE::ANDrm0, RS1, Imm, RD, STI);
}

#if 0
static void EmitOR(MCStreamer &OutStreamer,
                   MCOperand &RS1, MCOperand &Imm, MCOperand &RD,
                   const MCSubtargetInfo &STI) {
  EmitBinary(OutStreamer, VE::ORri, RS1, Imm, RD, STI);
}

static void EmitADD(MCStreamer &OutStreamer,
                    MCOperand &RS1, MCOperand &RS2, MCOperand &RD,
                    const MCSubtargetInfo &STI) {
  EmitBinary(OutStreamer, VE::ADDrr, RS1, RS2, RD, STI);
}

static void EmitSHL(MCStreamer &OutStreamer,
                    MCOperand &RS1, MCOperand &Imm, MCOperand &RD,
                    const MCSubtargetInfo &STI) {
  EmitBinary(OutStreamer, VE::SLLri, RS1, Imm, RD, STI);
}
#endif

static void EmitHiLo(MCStreamer &OutStreamer,  MCSymbol *GOTSym,
                     VEMCExpr::VariantKind HiKind,
                     VEMCExpr::VariantKind LoKind,
                     MCOperand &RD,
                     MCContext &OutContext,
                     const MCSubtargetInfo &STI) {

  MCOperand hi = createVEMCOperand(HiKind, GOTSym, OutContext);
  MCOperand lo = createVEMCOperand(LoKind, GOTSym, OutContext);
  MCOperand ci32 = MCOperand::createImm(32);
  EmitLEAzzi(OutStreamer, lo, RD, STI);
  EmitANDrm0(OutStreamer, RD, ci32, RD, STI);
  EmitLEASLzzi(OutStreamer, hi, RD, STI);
}

void VEAsmPrinter::LowerGETGOTAndEmitMCInsts(const MachineInstr *MI,
                                             const MCSubtargetInfo &STI)
{
  MCSymbol *GOTLabel   =
    OutContext.getOrCreateSymbol(Twine("_GLOBAL_OFFSET_TABLE_"));

  const MachineOperand &MO = MI->getOperand(0);
  MCOperand MCRegOP = MCOperand::createReg(MO.getReg());


  if (!isPositionIndependent()) {
    // Just load the address of GOT to MCRegOP.
    switch(TM.getCodeModel()) {
    default:
      llvm_unreachable("Unsupported absolute code model");
    case CodeModel::Small:
    case CodeModel::Medium:
    case CodeModel::Large:
      EmitHiLo(*OutStreamer, GOTLabel,
               VEMCExpr::VK_VE_HI32, VEMCExpr::VK_VE_LO32,
               MCRegOP, OutContext, STI);
      break;
    }
    return;
  }

  MCOperand RegGOT   = MCOperand::createReg(VE::SX15);  // GOT
  MCOperand RegPLT   = MCOperand::createReg(VE::SX16);  // PLT

  // lea %got, _GLOBAL_OFFSET_TABLE_@PC_LO(-24)
  // and %got, %got, (32)0
  // sic %plt
  // lea.sl %got, _GLOBAL_OFFSET_TABLE_@PC_HI(%got, %plt)
  MCOperand cim24 = MCOperand::createImm(-24);
  MCOperand loImm = createGOTRelExprOp(VEMCExpr::VK_VE_PC_LO32,
                                       GOTLabel,
                                       OutContext);
  EmitLEAzii(*OutStreamer, cim24, loImm, MCRegOP, STI);
  MCOperand ci32 = MCOperand::createImm(32);
  EmitANDrm0(*OutStreamer, MCRegOP, ci32, MCRegOP, STI);
  EmitSIC(*OutStreamer, RegPLT, STI);
  MCOperand hiImm = createGOTRelExprOp(VEMCExpr::VK_VE_PC_HI32,
                                       GOTLabel,
                                       OutContext);
  EmitLEASLrri(*OutStreamer, RegGOT, RegPLT, hiImm, MCRegOP, STI);
}

void VEAsmPrinter::LowerGETFunPLTAndEmitMCInsts(const MachineInstr *MI,
                                                const MCSubtargetInfo &STI)
{
  const MachineOperand &MO = MI->getOperand(0);
  MCOperand MCRegOP = MCOperand::createReg(MO.getReg());
  const MachineOperand &Addr = MI->getOperand(1);
  MCSymbol* AddrSym = nullptr;

  switch (Addr.getType()) {
  default:
    llvm_unreachable ("<unknown operand type>");
    return;
  case MachineOperand::MO_MachineBasicBlock:
    report_fatal_error("MBB is not supporeted yet");
    return;
  case MachineOperand::MO_ConstantPoolIndex:
    report_fatal_error("ConstantPool is not supporeted yet");
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

  MCOperand RegPLT   = MCOperand::createReg(VE::SX16);  // PLT

  // lea %dst, %plt_lo(func)(-24)
  // and %dst, %dst, (32)0
  // sic %plt                            ; FIXME: is it safe to use %plt here?
  // lea.sl %dst, %plt_hi(func)(%dst, %plt)
  MCOperand cim24 = MCOperand::createImm(-24);
  MCOperand loImm = createGOTRelExprOp(VEMCExpr::VK_VE_PLT_LO32,
                                       AddrSym,
                                       OutContext);
  EmitLEAzii(*OutStreamer, cim24, loImm, MCRegOP, STI);
  MCOperand ci32 = MCOperand::createImm(32);
  EmitANDrm0(*OutStreamer, MCRegOP, ci32, MCRegOP, STI);
  EmitSIC(*OutStreamer, RegPLT, STI);
  MCOperand hiImm = createGOTRelExprOp(VEMCExpr::VK_VE_PLT_HI32,
                                       AddrSym,
                                       OutContext);
  EmitLEASLrri(*OutStreamer, MCRegOP, RegPLT, hiImm, MCRegOP, STI);
}

void VEAsmPrinter::LowerGETTLSAddrAndEmitMCInsts(const MachineInstr *MI,
                                                 const MCSubtargetInfo &STI)
{
  const MachineOperand &Addr = MI->getOperand(0);
  MCSymbol* AddrSym = nullptr;

  switch (Addr.getType()) {
  default:
    llvm_unreachable ("<unknown operand type>");
    return;
  case MachineOperand::MO_MachineBasicBlock:
    report_fatal_error("MBB is not supporeted yet");
    return;
  case MachineOperand::MO_ConstantPoolIndex:
    report_fatal_error("ConstantPool is not supporeted yet");
    return;
  case MachineOperand::MO_ExternalSymbol:
    AddrSym = GetExternalSymbolSymbol(Addr.getSymbolName());
    break;
  case MachineOperand::MO_GlobalAddress:
    AddrSym = getSymbol(Addr.getGlobal());
    break;
  }

  MCOperand RegLR   = MCOperand::createReg(VE::SX10);   // LR
  MCOperand RegS0   = MCOperand::createReg(VE::SX0);    // S0
  MCOperand RegS12  = MCOperand::createReg(VE::SX12);   // S12
  MCSymbol *GetTLSLabel   =
    OutContext.getOrCreateSymbol(Twine("__tls_get_addr"));

  // lea %s0, sym@tls_gd_lo(-24)
  // and %s0, %s0, (32)0
  // sic %lr
  // lea.sl %s0, sym@tls_gd_hi(%s0, %lr)
  // lea %s12, __tls_get_addr@plt_lo(8)
  // and %s12, %s12, (32)0
  // lea.sl %s12, __tls_get_addr@plt_hi(%s12, %lr)
  // bsic %lr, (, %s12)
  MCOperand cim24 = MCOperand::createImm(-24);
  MCOperand loImm = createGOTRelExprOp(VEMCExpr::VK_VE_TLS_GD_LO32,
                                       AddrSym,
                                       OutContext);
  EmitLEAzii(*OutStreamer, cim24, loImm, RegS0, STI);
  MCOperand ci32 = MCOperand::createImm(32);
  EmitANDrm0(*OutStreamer, RegS0, ci32, RegS0, STI);
  EmitSIC(*OutStreamer, RegLR, STI);
  MCOperand hiImm = createGOTRelExprOp(VEMCExpr::VK_VE_TLS_GD_HI32,
                                       AddrSym,
                                       OutContext);
  EmitLEASLrri(*OutStreamer, RegS0, RegLR, hiImm, RegS0, STI);
  MCOperand ci8 = MCOperand::createImm(8);
  MCOperand loImm2 = createGOTRelExprOp(VEMCExpr::VK_VE_PLT_LO32,
                                        GetTLSLabel,
                                        OutContext);
  EmitLEAzii(*OutStreamer, ci8, loImm2, RegS12, STI);
  EmitANDrm0(*OutStreamer, RegS12, ci32, RegS12, STI);
  MCOperand hiImm2 = createGOTRelExprOp(VEMCExpr::VK_VE_PLT_HI32,
                                        GetTLSLabel,
                                        OutContext);
  EmitLEASLrri(*OutStreamer, RegS12, RegLR, hiImm2, RegS12, STI);
  EmitBSIC(*OutStreamer, RegLR, RegS12, STI);
}

void VEAsmPrinter::LowerEH_SJLJ_SETJMPAndEmitMCInsts(
    const MachineInstr *MI, const MCSubtargetInfo &STI) {
  //   sic $dest
  //   lea $dest, 32($dest)     // $dest points 0f
  //   st $dest, 8(,$src)
  //   lea $dest, 0
  //   br.l 16                  // br 1f
  // 0:
  //   lea $dest, 1
  // 1:

  unsigned DestReg = MI->getOperand(0).getReg();
  unsigned SrcReg = MI->getOperand(1).getReg();

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::SIC)
    .addReg(DestReg));

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LEArzi)
    .addReg(DestReg)
    .addReg(DestReg)
    .addImm(32));

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::STSri)
    .addReg(SrcReg)
    .addImm(8)
    .addReg(DestReg));

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LEAzzi)
    .addReg(DestReg)
    .addImm(0));

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::BCRLa)
    .addImm(16));

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LEAzzi)
    .addReg(DestReg)
    .addImm(1));
}

void VEAsmPrinter::LowerEH_SJLJ_LONGJMPAndEmitMCInsts(
    const MachineInstr *MI, const MCSubtargetInfo &STI) {
  // ld %s9, (, $src)           // s9  = fp
  // ld %s10, 8(, $src)         // s10 = lr
  // ld %s11, 16(, $src)        // s11 = sp
  // b.l (%s10)

  unsigned SrcReg = MI->getOperand(0).getReg();

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LDSri)
    .addReg(VE::SX9)
    .addReg(SrcReg)
    .addImm(0));

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LDSri)
    .addReg(VE::SX10)
    .addReg(SrcReg)
    .addImm(8));

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LDSri)
    .addReg(VE::SX11)
    .addReg(SrcReg)
    .addImm(16));

  EmitToStreamer(*OutStreamer, MCInstBuilder(VE::BAri)
    .addReg(VE::SX10)
    .addImm(0));
  return;
}

void VEAsmPrinter::LowerVM2VAndEmitMCInsts(
    const MachineInstr *MI, const MCSubtargetInfo &STI) {
  // FIXME: using sx16 as a temporary register.
  // SVMi %sx16, $src, 0
  // LSVi $dest, $dest, 0, %sx16
  // SVMi %sx16, $src, 1
  // LSVi $dest, $dest, 1, %sx16
  // SVMi %sx16, $src, 2
  // LSVi $dest, $dest, 2, %sx16
  // SVMi %sx16, $src, 3
  // LSVi $dest, $dest, 3, %sx16

  unsigned DestReg = MI->getOperand(0).getReg();
  unsigned SrcReg = MI->getOperand(1).getReg();

  for (int i = 0; i < 4; ++i) {
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::SVMi)
      .addReg(VE::SX16)
      .addReg(SrcReg)
      .addImm(i));
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LSVi)
      .addReg(DestReg)
      .addReg(DestReg)
      .addImm(i)
      .addReg(VE::SX16));
  }
}

void VEAsmPrinter::LowerV2VMAndEmitMCInsts(
    const MachineInstr *MI, const MCSubtargetInfo &STI) {
  // FIXME: using sx16 as a temporary register.
  // LVSi %sx16, $src, 0
  // LVMi $dest, $dest, 0, %sx16
  // LVSi %sx16, $src, 1
  // LVMi $dest, $dest, 1, %sx16
  // LVSi %sx16, $src, 2
  // LVMi $dest, $dest, 2, %sx16
  // LVSi %sx16, $src, 3
  // LVMi $dest, $dest, 3, %sx16

  unsigned DestReg = MI->getOperand(0).getReg();
  unsigned SrcReg = MI->getOperand(1).getReg();

  for (int i = 0; i < 4; ++i) {
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LVSi)
      .addReg(VE::SX16)
      .addReg(SrcReg)
      .addImm(i));
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LVMi)
      .addReg(DestReg)
      .addReg(DestReg)
      .addImm(i)
      .addReg(VE::SX16));
  }
}

void VEAsmPrinter::LowerVMP2VAndEmitMCInsts(
    const MachineInstr *MI, const MCSubtargetInfo &STI) {
  // FIXME: using sx16 as a temporary register.
  // SVMi %sx16, $src+1, i
  // LSVi $dest, $dest, i, %sx16        x 4
  // SVMi %sx16, $src, i
  // LSVi $dest, $dest, i+4, %sx16      x 4

  unsigned DestReg = MI->getOperand(0).getReg();
  unsigned SrcReg = MI->getOperand(1).getReg();
  const MachineFunction &MF = *MI->getParent()->getParent();
  const TargetRegisterInfo *TRI = MF.getSubtarget().getRegisterInfo();
  unsigned SrcRegLo = TRI->getSubReg(SrcReg, VE::sub_vm_odd);
  unsigned SrcRegHi = TRI->getSubReg(SrcReg, VE::sub_vm_even);

  for (int i = 0; i < 4; ++i) {
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::SVMi)
      .addReg(VE::SX16)
      .addReg(SrcRegLo)
      .addImm(i));
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LSVi)
      .addReg(DestReg)
      .addReg(DestReg)
      .addImm(i)
      .addReg(VE::SX16));
  }
  for (int i = 0; i < 4; ++i) {
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::SVMi)
      .addReg(VE::SX16)
      .addReg(SrcRegHi)
      .addImm(i));
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LSVi)
      .addReg(DestReg)
      .addReg(DestReg)
      .addImm(i+4)
      .addReg(VE::SX16));
  }
}

void VEAsmPrinter::LowerV2VMPAndEmitMCInsts(
    const MachineInstr *MI, const MCSubtargetInfo &STI) {
  // FIXME: using sx16 as a temporary register.
  // LVSi %sx16, $src, i
  // LVMi $dest+1, $dest+1, i, %sx16        x 4
  // LVSi %sx16, $src, i+4
  // LVMi $dest, $dest, i, %sx16    x 4

  unsigned DestReg = MI->getOperand(0).getReg();
  unsigned SrcReg = MI->getOperand(1).getReg();
  const MachineFunction &MF = *MI->getParent()->getParent();
  const TargetRegisterInfo *TRI = MF.getSubtarget().getRegisterInfo();
  unsigned DestRegLo = TRI->getSubReg(DestReg, VE::sub_vm_odd);
  unsigned DestRegHi = TRI->getSubReg(DestReg, VE::sub_vm_even);

  for (int i = 0; i < 4; ++i) {
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LVSi)
      .addReg(VE::SX16)
      .addReg(SrcReg)
      .addImm(i));
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LVMi)
      .addReg(DestRegLo)
      .addReg(DestRegLo)
      .addImm(i)
      .addReg(VE::SX16));
  }
  for (int i = 0; i < 4; ++i) {
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LVSi)
      .addReg(VE::SX16)
      .addReg(SrcReg)
      .addImm(i+4));
    EmitToStreamer(*OutStreamer, MCInstBuilder(VE::LVMi)
      .addReg(DestRegHi)
      .addReg(DestRegHi)
      .addImm(i)
      .addReg(VE::SX16));
  }
}

void VEAsmPrinter::EmitInstruction(const MachineInstr *MI)
{

  switch (MI->getOpcode()) {
  default: break;
  case TargetOpcode::DBG_VALUE:
    // FIXME: Debug Value.
    return;
  case VE::GETGOT:
    LowerGETGOTAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  case VE::GETFUNPLT:
    LowerGETFunPLTAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  case VE::GETTLSADDR:
    LowerGETTLSAddrAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  // Emit nothing here but a comment if we can.
  case VE::MEMBARRIER:
    OutStreamer->emitRawComment("MEMBARRIER");
    return;
  case VE::EH_SjLj_SetJmp:
    LowerEH_SJLJ_SETJMPAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  case VE::EH_SjLj_LongJmp:
    LowerEH_SJLJ_LONGJMPAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  case VE::VM2V:
    LowerVM2VAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  case VE::VMP2V:
    LowerVMP2VAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  case VE::V2VM:
    LowerV2VMAndEmitMCInsts(MI, getSubtargetInfo());
    return;
  case VE::V2VMP:
    LowerV2VMPAndEmitMCInsts(MI, getSubtargetInfo());
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

void VEAsmPrinter::EmitFunctionBodyStart() {
#if 0
  const MachineRegisterInfo &MRI = MF->getRegInfo();
  const unsigned globalRegs[] = { SP::G2, SP::G3, SP::G6, SP::G7, 0 };
  for (unsigned i = 0; globalRegs[i] != 0; ++i) {
    unsigned reg = globalRegs[i];
    if (MRI.use_empty(reg))
      continue;

    if  (reg == SP::G6 || reg == SP::G7)
      getTargetStreamer().emitVERegisterIgnore(reg);
    else
      getTargetStreamer().emitVERegisterScratch(reg);
  }
#endif
}

void VEAsmPrinter::printOperand(const MachineInstr *MI, int opNum,
                                   raw_ostream &O) {
  const DataLayout &DL = getDataLayout();
  const MachineOperand &MO = MI->getOperand (opNum);
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
    else if (MI->getOpcode() == SP::TLS_CALL)
      assert((TF == VEMCExpr::VK_VE_None
              || TF == VEMCExpr::VK_VE_TLS_GD_CALL
              || TF == VEMCExpr::VK_VE_TLS_LDM_CALL) &&
             "Cannot handle target flags on tls call address");
    else if (MI->getOpcode() == SP::TLS_ADDrr)
      assert((TF == VEMCExpr::VK_VE_TLS_GD_ADD
              || TF == VEMCExpr::VK_VE_TLS_LDM_ADD
              || TF == VEMCExpr::VK_VE_TLS_LDO_ADD
              || TF == VEMCExpr::VK_VE_TLS_IE_ADD) &&
             "Cannot handle target flags on add for TLS");
    else if (MI->getOpcode() == SP::TLS_LDrr)
      assert(TF == VEMCExpr::VK_VE_TLS_IE_LD &&
             "Cannot handle target flags on ld for TLS");
    else if (MI->getOpcode() == SP::TLS_LDXrr)
      assert(TF == VEMCExpr::VK_VE_TLS_IE_LDX &&
             "Cannot handle target flags on ldx for TLS");
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

void VEAsmPrinter::printMemASXOperand(const MachineInstr *MI, int opNum,
                                      raw_ostream &O, const char *Modifier) {
  // If this is an ADD operand, emit it like normal operands.
  if (Modifier && !strcmp(Modifier, "arith")) {
    printOperand(MI, opNum, O);
    O << ", ";
    printOperand(MI, opNum+1, O);
    return;
  }

  if (MI->getOperand(opNum+1).isImm() &&
      MI->getOperand(opNum+1).getImm() == 0) {
    // don't print "+0"
  } else {
    printOperand(MI, opNum+1, O);
  }
  O << "(,";
  printOperand(MI, opNum, O);
  O << ")";
}

void VEAsmPrinter::printMemASOperand(const MachineInstr *MI, int opNum,
                                      raw_ostream &O, const char *Modifier) {
  // If this is an ADD operand, emit it like normal operands.
  if (Modifier && !strcmp(Modifier, "arith")) {
    printOperand(MI, opNum, O);
    O << ", ";
    printOperand(MI, opNum+1, O);
    return;
  }

  if (MI->getOperand(opNum+1).isImm() &&
      MI->getOperand(opNum+1).getImm() == 0) {
    // don't print "+0"
  } else {
    printOperand(MI, opNum+1, O);
  }
  O << "(";
  printOperand(MI, opNum, O);
  O << ")";
}

/// PrintAsmOperand - Print out an operand for an inline asm expression.
///
bool VEAsmPrinter::PrintAsmOperand(const MachineInstr *MI, unsigned OpNo,
                                   const char *ExtraCode,
                                   raw_ostream &O) {
  if (ExtraCode && ExtraCode[0]) {
    if (ExtraCode[1] != 0) return true; // Unknown modifier.

    switch (ExtraCode[0]) {
    default:
      // See if this is a generic print operand
      return AsmPrinter::PrintAsmOperand(MI, OpNo, ExtraCode, O);
    case 'f':
    case 'r':
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

  O << '[';
  printMemASXOperand(MI, OpNo, O);
  O << ']';

  return false;
}

// Force static initialization.
extern "C" void LLVMInitializeVEAsmPrinter() {
  RegisterAsmPrinter<VEAsmPrinter> X(getTheVETarget());
}
