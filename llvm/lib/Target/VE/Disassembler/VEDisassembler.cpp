//===- VEDisassembler.cpp - Disassembler for VE -----------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file is part of the VE Disassembler.
//
//===----------------------------------------------------------------------===//

#include "MCTargetDesc/VEMCTargetDesc.h"
#include "VE.h"
#include "TargetInfo/VETargetInfo.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCDisassembler/MCDisassembler.h"
#include "llvm/MC/MCFixedLenDisassembler.h"
#include "llvm/MC/MCInst.h"
#include "llvm/Support/TargetRegistry.h"

using namespace llvm;

#define DEBUG_TYPE "ve-disassembler"

typedef MCDisassembler::DecodeStatus DecodeStatus;

namespace {

/// A disassembler class for VE.
class VEDisassembler : public MCDisassembler {
public:
  VEDisassembler(const MCSubtargetInfo &STI, MCContext &Ctx)
      : MCDisassembler(STI, Ctx) {}
  virtual ~VEDisassembler() {}

  DecodeStatus getInstruction(MCInst &Instr, uint64_t &Size,
                              ArrayRef<uint8_t> Bytes, uint64_t Address,
                              raw_ostream &CStream) const override;
};
}

static MCDisassembler *createVEDisassembler(const Target &T,
                                               const MCSubtargetInfo &STI,
                                               MCContext &Ctx) {
  return new VEDisassembler(STI, Ctx);
}


extern "C" void LLVMInitializeVEDisassembler() {
  // Register the disassembler.
  TargetRegistry::RegisterMCDisassembler(getTheVETarget(),
                                         createVEDisassembler);
}

static const unsigned I8RegDecoderTable[] = {
  VE::SB0,  VE::SB1,  VE::SB2,  VE::SB3,
  VE::SB4,  VE::SB5,  VE::SB6,  VE::SB7,
  VE::SB8,  VE::SB9,  VE::SB10, VE::SB11,
  VE::SB12, VE::SB13, VE::SB14, VE::SB15,
  VE::SB16, VE::SB17, VE::SB18, VE::SB19,
  VE::SB20, VE::SB21, VE::SB22, VE::SB23,
  VE::SB24, VE::SB25, VE::SB26, VE::SB27,
  VE::SB28, VE::SB29, VE::SB30, VE::SB31,
  VE::SB32, VE::SB33, VE::SB34, VE::SB35,
  VE::SB36, VE::SB37, VE::SB38, VE::SB39,
  VE::SB40, VE::SB41, VE::SB42, VE::SB43,
  VE::SB44, VE::SB45, VE::SB46, VE::SB47,
  VE::SB48, VE::SB49, VE::SB50, VE::SB51,
  VE::SB52, VE::SB53, VE::SB54, VE::SB55,
  VE::SB56, VE::SB57, VE::SB58, VE::SB59,
  VE::SB60, VE::SB61, VE::SB62, VE::SB63 };

static const unsigned I16RegDecoderTable[] = {
  VE::SH0,  VE::SH1,  VE::SH2,  VE::SH3,
  VE::SH4,  VE::SH5,  VE::SH6,  VE::SH7,
  VE::SH8,  VE::SH9,  VE::SH10, VE::SH11,
  VE::SH12, VE::SH13, VE::SH14, VE::SH15,
  VE::SH16, VE::SH17, VE::SH18, VE::SH19,
  VE::SH20, VE::SH21, VE::SH22, VE::SH23,
  VE::SH24, VE::SH25, VE::SH26, VE::SH27,
  VE::SH28, VE::SH29, VE::SH30, VE::SH31,
  VE::SH32, VE::SH33, VE::SH34, VE::SH35,
  VE::SH36, VE::SH37, VE::SH38, VE::SH39,
  VE::SH40, VE::SH41, VE::SH42, VE::SH43,
  VE::SH44, VE::SH45, VE::SH46, VE::SH47,
  VE::SH48, VE::SH49, VE::SH50, VE::SH51,
  VE::SH52, VE::SH53, VE::SH54, VE::SH55,
  VE::SH56, VE::SH57, VE::SH58, VE::SH59,
  VE::SH60, VE::SH61, VE::SH62, VE::SH63 };

static const unsigned I32RegDecoderTable[] = {
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

static const unsigned I64RegDecoderTable[] = {
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

static const unsigned F32RegDecoderTable[] = {
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

static const unsigned F128RegDecoderTable[] = {
  VE::Q0,  VE::Q1,  VE::Q2,  VE::Q3,
  VE::Q4,  VE::Q5,  VE::Q6,  VE::Q7,
  VE::Q8,  VE::Q9,  VE::Q10, VE::Q11,
  VE::Q12, VE::Q13, VE::Q14, VE::Q15,
  VE::Q16, VE::Q17, VE::Q18, VE::Q19,
  VE::Q20, VE::Q21, VE::Q22, VE::Q23,
  VE::Q24, VE::Q25, VE::Q26, VE::Q27,
  VE::Q28, VE::Q29, VE::Q30, VE::Q31 };

static const unsigned MiscRegDecoderTable[] = {
  VE::USRCC, VE::PSW,   VE::SAR,   0,
  0,         0,         0,         VE::PMMR,
  VE::PMCR0, VE::PMCR1, VE::PMCR2, VE::PMCR3,
  0,         0,         0,         0,
  VE::PMC0,  VE::PMC1,  VE::PMC2,  VE::PMC3,
  VE::PMC4,  VE::PMC5,  VE::PMC6,  VE::PMC7,
  VE::PMC8,  VE::PMC9,  VE::PMC10, VE::PMC11,
  VE::PMC12, VE::PMC13, VE::PMC14 };

static const unsigned V64RegDecoderTable[] = {
  VE::V0,  VE::V1,  VE::V2,  VE::V3,
  VE::V4,  VE::V5,  VE::V6,  VE::V7,
  VE::V8,  VE::V9,  VE::V10, VE::V11,
  VE::V12, VE::V13, VE::V14, VE::V15,
  VE::V16, VE::V17, VE::V18, VE::V19,
  VE::V20, VE::V21, VE::V22, VE::V23,
  VE::V24, VE::V25, VE::V26, VE::V27,
  VE::V28, VE::V29, VE::V30, VE::V31,
  VE::V32, VE::V33, VE::V34, VE::V35,
  VE::V36, VE::V37, VE::V38, VE::V39,
  VE::V40, VE::V41, VE::V42, VE::V43,
  VE::V44, VE::V45, VE::V46, VE::V47,
  VE::V48, VE::V49, VE::V50, VE::V51,
  VE::V52, VE::V53, VE::V54, VE::V55,
  VE::V56, VE::V57, VE::V58, VE::V59,
  VE::V60, VE::V61, VE::V62, VE::V63 };

static const unsigned VM_RegDecoderTable[] = {
  VE::VM0,  VE::VM1,  VE::VM2,  VE::VM3,
  VE::VM4,  VE::VM5,  VE::VM6,  VE::VM7,
  VE::VM8,  VE::VM9,  VE::VM10, VE::VM11,
  VE::VM12, VE::VM13, VE::VM14, VE::VM15 };

static const unsigned VM512_RegDecoderTable[] = {
  VE::VMP0,  VE::VMP1,  VE::VMP2,  VE::VMP3,
  VE::VMP4,  VE::VMP5,  VE::VMP6,  VE::VMP7 };

static DecodeStatus DecodeI8RegisterClass(MCInst &Inst,
                                          unsigned RegNo,
                                          uint64_t Address,
                                          const void *Decoder) {
  if (RegNo > 63)
    return MCDisassembler::Fail;
  unsigned Reg = I8RegDecoderTable[RegNo];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeI16RegisterClass(MCInst &Inst,
                                           unsigned RegNo,
                                           uint64_t Address,
                                           const void *Decoder) {
  if (RegNo > 63)
    return MCDisassembler::Fail;
  unsigned Reg = I16RegDecoderTable[RegNo];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeI32RegisterClass(MCInst &Inst,
                                           unsigned RegNo,
                                           uint64_t Address,
                                           const void *Decoder) {
  if (RegNo > 63)
    return MCDisassembler::Fail;
  unsigned Reg = I32RegDecoderTable[RegNo];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeI64RegisterClass(MCInst &Inst,
                                           unsigned RegNo,
                                           uint64_t Address,
                                           const void *Decoder) {
  if (RegNo > 63)
    return MCDisassembler::Fail;
  unsigned Reg = I64RegDecoderTable[RegNo];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeF32RegisterClass(MCInst &Inst,
                                           unsigned RegNo,
                                           uint64_t Address,
                                           const void *Decoder) {
  if (RegNo > 63)
    return MCDisassembler::Fail;
  unsigned Reg = F32RegDecoderTable[RegNo];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeF128RegisterClass(MCInst &Inst,
                                            unsigned RegNo,
                                            uint64_t Address,
                                            const void *Decoder) {
  if (RegNo % 2 || RegNo > 63)
    return MCDisassembler::Fail;
  unsigned Reg = F128RegDecoderTable[RegNo / 2];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeMISCRegisterClass(MCInst &Inst,
                                            unsigned RegNo,
                                            uint64_t Address,
                                            const void *Decoder) {
  if (!isMiscReg(RegNo))
    return MCDisassembler::Fail;
  unsigned Reg = MiscRegDecoderTable[RegNo];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeV64RegisterClass(MCInst &Inst,
                                           unsigned RegNo,
                                           uint64_t Address,
                                           const void *Decoder) {
  unsigned Reg = VE::NoRegister;
  if (RegNo == 255)
    Reg = VE::VIX;
  else if (RegNo > 63)
    return MCDisassembler::Fail;
  else
    Reg = V64RegDecoderTable[RegNo];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeVM_RegisterClass(MCInst &Inst,
                                           unsigned RegNo,
                                           uint64_t Address,
                                           const void *Decoder) {
  if (RegNo > 15)
    return MCDisassembler::Fail;
  unsigned Reg = VM_RegDecoderTable[RegNo];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeVM512_RegisterClass(MCInst &Inst,
                                              unsigned RegNo,
                                              uint64_t Address,
                                              const void *Decoder) {
  if (RegNo % 2 || RegNo > 15)
    return MCDisassembler::Fail;
  unsigned Reg = VM512_RegDecoderTable[RegNo / 2];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeASX(MCInst &Inst, uint64_t insn, uint64_t Address,
                              const void *Decoder);
static DecodeStatus DecodeAS(MCInst &Inst, uint64_t insn, uint64_t Address,
                             const void *Decoder);
static DecodeStatus DecodeLoadI8(MCInst &Inst, uint64_t insn, uint64_t Address,
                                 const void *Decoder);
static DecodeStatus DecodeStoreI8(MCInst &Inst, uint64_t insn,
                                  uint64_t Address, const void *Decoder);
static DecodeStatus DecodeLoadI16(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder);
static DecodeStatus DecodeStoreI16(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder);
static DecodeStatus DecodeLoadI32(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder);
static DecodeStatus DecodeStoreI32(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder);
static DecodeStatus DecodeLoadI64(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder);
static DecodeStatus DecodeStoreI64(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder);
static DecodeStatus DecodeLoadF32(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder);
static DecodeStatus DecodeStoreF32(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder);
static DecodeStatus DecodeLoadASI64(MCInst &Inst, uint64_t insn,
                                    uint64_t Address, const void *Decoder);
static DecodeStatus DecodeStoreASI64(MCInst &Inst, uint64_t insn,
                                     uint64_t Address, const void *Decoder);
static DecodeStatus DecodeCall(MCInst &Inst, uint64_t insn, uint64_t Address,
                               const void *Decoder);
static DecodeStatus DecodeSIMM7(MCInst &Inst, uint64_t insn,
                                uint64_t Address, const void *Decoder);
static DecodeStatus DecodeSIMM32(MCInst &Inst, uint64_t insn,
                                 uint64_t Address, const void *Decoder);
static DecodeStatus DecodeCCOperand(MCInst &Inst, uint64_t insn,
                                    uint64_t Address, const void *Decoder);
static DecodeStatus DecodeRDOperand(MCInst &Inst, uint64_t insn,
                                    uint64_t Address, const void *Decoder);
static DecodeStatus DecodeBranchCondition(MCInst &Inst, uint64_t insn,
                                          uint64_t Address,
                                          const void *Decoder);
static DecodeStatus DecodeBranchConditionAlways(MCInst &Inst, uint64_t insn,
                                                uint64_t Address,
                                                const void *Decoder);

#include "VEGenDisassemblerTables.inc"

/// Read four bytes from the ArrayRef and return 32 bit word.
static DecodeStatus readInstruction64(ArrayRef<uint8_t> Bytes, uint64_t Address,
                                      uint64_t &Size, uint64_t &Insn,
                                      bool IsLittleEndian) {
  // We want to read exactly 8 Bytes of data.
  if (Bytes.size() < 8) {
    Size = 0;
    return MCDisassembler::Fail;
  }

  Insn = IsLittleEndian
             ? ((uint64_t)Bytes[0] <<  0) | ((uint64_t)Bytes[1] <<  8) |
               ((uint64_t)Bytes[2] << 16) | ((uint64_t)Bytes[3] << 24) |
               ((uint64_t)Bytes[4] << 32) | ((uint64_t)Bytes[5] << 40) |
               ((uint64_t)Bytes[6] << 48) | ((uint64_t)Bytes[7] << 56)
             : ((uint64_t)Bytes[7] <<  0) | ((uint64_t)Bytes[6] <<  8) |
               ((uint64_t)Bytes[5] << 16) | ((uint64_t)Bytes[4] << 24) |
               ((uint64_t)Bytes[3] << 32) | ((uint64_t)Bytes[2] << 40) |
               ((uint64_t)Bytes[1] << 48) | ((uint64_t)Bytes[0] << 56);

  return MCDisassembler::Success;
}

DecodeStatus VEDisassembler::getInstruction(MCInst &Instr, uint64_t &Size,
                                            ArrayRef<uint8_t> Bytes,
                                            uint64_t Address,
                                            raw_ostream &CStream) const {
  uint64_t Insn;
  bool isLittleEndian = getContext().getAsmInfo()->isLittleEndian();
  DecodeStatus Result =
      readInstruction64(Bytes, Address, Size, Insn, isLittleEndian);
  if (Result == MCDisassembler::Fail)
    return MCDisassembler::Fail;

  // Calling the auto-generated decoder function.

  Result =
      decodeInstruction(DecoderTableVE64, Instr, Insn, Address, this, STI);

  if (Result != MCDisassembler::Fail) {
    Size = 8;
    return Result;
  }

  return MCDisassembler::Fail;
}


typedef DecodeStatus (*DecodeFunc)(MCInst &MI, unsigned RegNo, uint64_t Address,
                                   const void *Decoder);

static DecodeStatus DecodeASX(MCInst &MI, uint64_t insn, uint64_t Address,
                              const void *Decoder) {
  unsigned sy = fieldFromInstruction(insn, 40, 7);
  bool cy = fieldFromInstruction(insn, 47, 1);
  unsigned sz = fieldFromInstruction(insn, 32, 7);
  bool cz = fieldFromInstruction(insn, 39, 1);
  uint64_t simm32 = SignExtend64<32>(fieldFromInstruction(insn, 0, 32));
  DecodeStatus status;

  // Decode sz.
  if (cz) {
    status = DecodeI32RegisterClass(MI, sz, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  } else {
    MI.addOperand(MCOperand::createImm(0));
  }

  // Decode sy.
  if (cy) {
    status = DecodeI32RegisterClass(MI, sy, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  } else {
    MI.addOperand(MCOperand::createImm(SignExtend32<7>(sy)));
  }

  // Decode simm32.
  MI.addOperand(MCOperand::createImm(simm32));

  return MCDisassembler::Success;
}

static DecodeStatus DecodeAS(MCInst &MI, uint64_t insn, uint64_t Address,
                             const void *Decoder) {
  unsigned sz = fieldFromInstruction(insn, 32, 7);
  bool cz = fieldFromInstruction(insn, 39, 1);
  uint64_t simm32 = SignExtend64<32>(fieldFromInstruction(insn, 0, 32));
  DecodeStatus status;

  // Decode sz.
  if (cz) {
    status = DecodeI32RegisterClass(MI, sz, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  } else {
    MI.addOperand(MCOperand::createImm(0));
  }

  // Decode simm32.
  MI.addOperand(MCOperand::createImm(simm32));

  return MCDisassembler::Success;
}

static DecodeStatus DecodeMem(MCInst &MI, uint64_t insn, uint64_t Address,
                              const void *Decoder,
                              bool isLoad, DecodeFunc DecodeSX) {
  unsigned sx = fieldFromInstruction(insn, 48, 7);

  DecodeStatus status;
  if (isLoad) {
    status = DecodeSX(MI, sx, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  }

  status = DecodeASX(MI, insn, Address, Decoder);
  if (status != MCDisassembler::Success)
    return status;

  if (!isLoad) {
    status = DecodeSX(MI, sx, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  }
  return MCDisassembler::Success;
}

static DecodeStatus DecodeMemAS(MCInst &MI, uint64_t insn, uint64_t Address,
                                const void *Decoder,
                                bool isLoad, DecodeFunc DecodeSX) {
  unsigned sx = fieldFromInstruction(insn, 48, 7);

  DecodeStatus status;
  if (isLoad) {
    status = DecodeSX(MI, sx, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  }

  status = DecodeAS(MI, insn, Address, Decoder);
  if (status != MCDisassembler::Success)
    return status;

  if (!isLoad) {
    status = DecodeSX(MI, sx, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  }
  return MCDisassembler::Success;
}

static DecodeStatus DecodeLoadI8(MCInst &Inst, uint64_t insn, uint64_t Address,
                                 const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, true,
                   DecodeI8RegisterClass);
}

static DecodeStatus DecodeStoreI8(MCInst &Inst, uint64_t insn,
                                  uint64_t Address, const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, false,
                   DecodeI8RegisterClass);
}

static DecodeStatus DecodeLoadI16(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, true,
                   DecodeI16RegisterClass);
}

static DecodeStatus DecodeStoreI16(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, false,
                   DecodeI16RegisterClass);
}

static DecodeStatus DecodeLoadI32(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, true,
                   DecodeI32RegisterClass);
}

static DecodeStatus DecodeStoreI32(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, false,
                   DecodeI32RegisterClass);
}

static DecodeStatus DecodeLoadI64(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, true,
                   DecodeI64RegisterClass);
}

static DecodeStatus DecodeStoreI64(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, false,
                   DecodeI64RegisterClass);
}

static DecodeStatus DecodeLoadF32(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, true,
                   DecodeF32RegisterClass);
}

static DecodeStatus DecodeStoreF32(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, false,
                   DecodeF32RegisterClass);
}

static DecodeStatus DecodeLoadASI64(MCInst &Inst, uint64_t insn,
                                    uint64_t Address, const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, true,
                     DecodeI64RegisterClass);
}

static DecodeStatus DecodeStoreASI64(MCInst &Inst, uint64_t insn,
                                     uint64_t Address, const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, false,
                     DecodeI64RegisterClass);
}

static DecodeStatus DecodeCall(MCInst &Inst, uint64_t insn, uint64_t Address,
                               const void *Decoder) {
  return DecodeMem(Inst, insn, Address, Decoder, true,
                   DecodeI64RegisterClass);
}

static DecodeStatus DecodeSIMM7(MCInst &MI, uint64_t insn,
                                uint64_t Address, const void *Decoder) {
  uint64_t tgt = SignExtend64<7>(insn);
  MI.addOperand(MCOperand::createImm(tgt));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeSIMM32(MCInst &MI, uint64_t insn,
                                 uint64_t Address, const void *Decoder) {
  uint64_t tgt = SignExtend64<32>(insn);
  MI.addOperand(MCOperand::createImm(tgt));
  return MCDisassembler::Success;
}

static bool isIntegerBCKind(MCInst &MI) {

#define BCm_kind(NAME)  \
  case NAME ## rri:     \
  case NAME ## rzi:     \
  case NAME ## iri:     \
  case NAME ## izi:     \
  case NAME ## rri_nt:  \
  case NAME ## rzi_nt:  \
  case NAME ## iri_nt:  \
  case NAME ## izi_nt:  \
  case NAME ## rri_t:   \
  case NAME ## rzi_t:   \
  case NAME ## iri_t:   \
  case NAME ## izi_t:

#define BCRm_kind(NAME) \
  case NAME ## rr:      \
  case NAME ## ir:      \
  case NAME ## rr_nt:   \
  case NAME ## ir_nt:   \
  case NAME ## rr_t:    \
  case NAME ## ir_t:


  {
    using namespace llvm::VE;
    switch (MI.getOpcode()) {
    BCm_kind(BCFL)
    BCm_kind(BCFW)
    BCRm_kind(BRCFL)
    BCRm_kind(BRCFW)
      return true;
    }
  }
#undef BCm_kind

  return false;
}

// Decode CC Operand field.
static DecodeStatus DecodeCCOperand(MCInst &MI, uint64_t cf,
                                    uint64_t Address, const void *Decoder) {
  MI.addOperand(MCOperand::createImm(VEValToCondCode(cf, isIntegerBCKind(MI))));
  return MCDisassembler::Success;
}

// Decode RD Operand field.
static DecodeStatus DecodeRDOperand(MCInst &MI, uint64_t cf,
                                    uint64_t Address, const void *Decoder) {
  MI.addOperand(MCOperand::createImm(VEValToRD(cf)));
  return MCDisassembler::Success;
}

// Decode branch condition instruction and CCOperand field in it.
static DecodeStatus DecodeBranchCondition(MCInst &MI, uint64_t insn,
                                          uint64_t Address,
                                          const void *Decoder) {
  unsigned cf = fieldFromInstruction(insn, 48, 4);
  bool cy = fieldFromInstruction(insn, 47, 1);
  unsigned sy = fieldFromInstruction(insn, 40, 7);

  // Decode cf.
  MI.addOperand(MCOperand::createImm(VEValToCondCode(cf, isIntegerBCKind(MI))));

  // Decode sy.
  DecodeStatus status;
  if (cy) {
    status = DecodeI64RegisterClass(MI, sy, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  } else {
    MI.addOperand(MCOperand::createImm(SignExtend32<7>(sy)));
  }

  // Decode MEMri.
  return DecodeAS(MI, insn, Address, Decoder);
}

static DecodeStatus DecodeBranchConditionAlways(MCInst &MI, uint64_t insn,
                                                uint64_t Address,
                                                const void *Decoder) {
  // Decode MEMri.
  return DecodeAS(MI, insn, Address, Decoder);
}

