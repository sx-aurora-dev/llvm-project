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
#include "TargetInfo/VETargetInfo.h"
#include "llvm/MC/MCAsmInfo.h"
#include "llvm/MC/MCContext.h"
#include "llvm/MC/MCDisassembler/MCDisassembler.h"
#include "llvm/MC/MCFixedLenDisassembler.h"
#include "llvm/MC/MCInst.h"
#include "llvm/Support/TargetRegistry.h"

using namespace llvm;

#define DEBUG_TYPE "sparc-disassembler"

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
  if (RegNo > 31)
    return MCDisassembler::Fail;
  unsigned Reg = F128RegDecoderTable[RegNo];
  Inst.addOperand(MCOperand::createReg(Reg));
  return MCDisassembler::Success;
}

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
static DecodeStatus DecodeLoadASI8(MCInst &Inst, uint64_t insn, uint64_t Address,
                                 const void *Decoder);
static DecodeStatus DecodeStoreASI8(MCInst &Inst, uint64_t insn,
                                  uint64_t Address, const void *Decoder);
static DecodeStatus DecodeLoadASI16(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder);
static DecodeStatus DecodeStoreASI16(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder);
static DecodeStatus DecodeLoadASI32(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder);
static DecodeStatus DecodeStoreASI32(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder);
static DecodeStatus DecodeLoadASI64(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder);
static DecodeStatus DecodeStoreASI64(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder);
static DecodeStatus DecodeLoadASF32(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder);
static DecodeStatus DecodeStoreASF32(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder);
static DecodeStatus DecodeUIMM6(MCInst &Inst, uint64_t insn,
                                uint64_t Address, const void *Decoder);
static DecodeStatus DecodeSIMM7(MCInst &Inst, uint64_t insn,
                                uint64_t Address, const void *Decoder);

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

static DecodeStatus DecodeMem(MCInst &MI, uint64_t insn, uint64_t Address,
                              const void *Decoder,
                              bool isLoad, DecodeFunc DecodeSX) {
  unsigned sx = fieldFromInstruction(insn, 48, 7);
  unsigned sy = fieldFromInstruction(insn, 40, 7);
  bool cy = fieldFromInstruction(insn, 47, 1);
  unsigned sz = fieldFromInstruction(insn, 32, 7);
  bool cz = fieldFromInstruction(insn, 39, 1);
  uint64_t simm32 = SignExtend64<32>(fieldFromInstruction(insn, 0, 32));

  DecodeStatus status;
  if (isLoad) {
    status = DecodeSX(MI, sx, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  }

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
  unsigned sz = fieldFromInstruction(insn, 32, 7);
  bool cz = fieldFromInstruction(insn, 39, 1);
  uint64_t simm32 = SignExtend64<32>(fieldFromInstruction(insn, 0, 32));

  DecodeStatus status;
  if (isLoad) {
    status = DecodeSX(MI, sx, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  }

  // Decode sz.
  if (cz) {
    status = DecodeI32RegisterClass(MI, sz, Address, Decoder);
    if (status != MCDisassembler::Success)
      return status;
  } else {
    MI.addOperand(MCOperand::createImm(0));
  }

  // Add Imm(0) to normalize memory address internal representation.
  MI.addOperand(MCOperand::createImm(0));

  // Decode simm32.
  MI.addOperand(MCOperand::createImm(simm32));

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

static DecodeStatus DecodeLoadASI8(MCInst &Inst, uint64_t insn, uint64_t Address,
                                 const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, true,
                     DecodeI8RegisterClass);
}

static DecodeStatus DecodeStoreASI8(MCInst &Inst, uint64_t insn,
                                  uint64_t Address, const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, false,
                     DecodeI8RegisterClass);
}

static DecodeStatus DecodeLoadASI16(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, true,
                     DecodeI16RegisterClass);
}

static DecodeStatus DecodeStoreASI16(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, false,
                     DecodeI16RegisterClass);
}

static DecodeStatus DecodeLoadASI32(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, true,
                     DecodeI32RegisterClass);
}

static DecodeStatus DecodeStoreASI32(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, false,
                     DecodeI32RegisterClass);
}

static DecodeStatus DecodeLoadASI64(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, true,
                     DecodeI64RegisterClass);
}

static DecodeStatus DecodeStoreASI64(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, false,
                     DecodeI64RegisterClass);
}

static DecodeStatus DecodeLoadASF32(MCInst &Inst, uint64_t insn, uint64_t Address,
                                  const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, true,
                     DecodeF32RegisterClass);
}

static DecodeStatus DecodeStoreASF32(MCInst &Inst, uint64_t insn,
                                   uint64_t Address, const void *Decoder) {
  return DecodeMemAS(Inst, insn, Address, Decoder, false,
                     DecodeF32RegisterClass);
}

static DecodeStatus DecodeUIMM6(MCInst &MI, uint64_t insn,
                                uint64_t Address, const void *Decoder) {
  uint64_t tgt = fieldFromInstruction(insn, 40, 6);
  MI.addOperand(MCOperand::createImm(tgt));
  return MCDisassembler::Success;
}

static DecodeStatus DecodeSIMM7(MCInst &MI, uint64_t insn,
                                uint64_t Address, const void *Decoder) {
  uint64_t tgt = SignExtend64<7>(fieldFromInstruction(insn, 40, 7));
  MI.addOperand(MCOperand::createImm(tgt));
  return MCDisassembler::Success;
}
