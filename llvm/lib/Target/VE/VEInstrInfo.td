//===-- VEInstrInfo.td - Target Description for VE Target -----------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file describes the VE instructions in TableGen format.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction format superclass
//===----------------------------------------------------------------------===//

include "VEInstrFormats.td"

//===----------------------------------------------------------------------===//
// Feature predicates.
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction Pattern Stuff
//===----------------------------------------------------------------------===//

def UImm2AsmOperand : AsmOperandClass { let Name = "UImm2"; }
def uimm2 : Operand<i32>, PatLeaf<(imm), [{
    return isUInt<2>(N->getZExtValue()); }]> {
  let ParserMatchClass = UImm2AsmOperand;
}
def UImm3AsmOperand : AsmOperandClass { let Name = "UImm3"; }
def uimm3 : Operand<i32>, PatLeaf<(imm), [{
    return isUInt<3>(N->getZExtValue()); }]> {
  let ParserMatchClass = UImm3AsmOperand;
}
def UImm6AsmOperand : AsmOperandClass { let Name = "UImm6"; }
def uimm6 : Operand<i32>, PatLeaf<(imm), [{
    return isUInt<6>(N->getZExtValue()); }]> {
  let ParserMatchClass = UImm6AsmOperand;
}
def LO7 : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(SignExtend32(N->getSExtValue(), 7),
                                   SDLoc(N), MVT::i32);
}]>;
def SImm7AsmOperand : AsmOperandClass { let Name = "SImm7"; }
def simm7 : Operand<i32>, PatLeaf<(imm), [{
    return isInt<7>(N->getSExtValue()); }], LO7> {
  let ParserMatchClass = SImm7AsmOperand;
  let DecoderMethod = "DecodeSIMM7";
}
def UImm7AsmOperand : AsmOperandClass { let Name = "UImm7"; }
def uimm7 : Operand<i32>, PatLeaf<(imm), [{
    return isUInt<7>(N->getZExtValue()); }]> {
  let ParserMatchClass = UImm7AsmOperand;
}

def simm32      : PatLeaf<(imm), [{ return isInt<32>(N->getSExtValue()); }]>;
def uimm32      : PatLeaf<(imm), [{ return isUInt<32>(N->getZExtValue()); }]>;
def zero        : PatLeaf<(imm), [{ return N->getSExtValue() == 0; }]>;
def lomsbzero   : PatLeaf<(imm), [{ return (N->getZExtValue() & 0x80000000)
                                      == 0; }]>;
def lozero      : PatLeaf<(imm), [{ return (N->getZExtValue() & 0xffffffff)
                                      == 0; }]>;
def fpzero      : PatLeaf<(fpimm), [{ return N->getValueAPF().bitcastToAPInt()
                                      .getZExtValue() == 0; }]>;
def fplomsbzero : PatLeaf<(fpimm), [{ return (N->getValueAPF().bitcastToAPInt()
                                      .getZExtValue() & 0x80000000) == 0; }]>;
def fplozero    : PatLeaf<(fpimm), [{ return (N->getValueAPF().bitcastToAPInt()
                                      .getZExtValue() & 0xffffffff) == 0; }]>;

def CCSIOp : PatLeaf<(cond), [{
  switch (N->get()) {
  default:          return true;
  case ISD::SETULT:
  case ISD::SETULE:
  case ISD::SETUGT:
  case ISD::SETUGE: return false;
  }
}]>;

def CCUIOp : PatLeaf<(cond), [{
  switch (N->get()) {
  default:         return true;
  case ISD::SETLT:
  case ISD::SETLE:
  case ISD::SETGT:
  case ISD::SETGE: return false;
  }
}]>;

def GetVL : SDNodeXForm<imm, [{
  // Get a virtual register for VL and return it.
  MachineFunction& MF = CurDAG->getMachineFunction();
  unsigned VLReg = MF.getSubtarget<VESubtarget>().getInstrInfo()->getVectorLengthReg(&MF);
  return CurDAG->getCopyFromReg(CurDAG->getEntryNode(), SDLoc(N), VLReg, MVT::i32);
}]>;

def LOFP32 : SDNodeXForm<fpimm, [{
  // Get a integer immediate from fpimm
  const APInt& imm = N->getValueAPF().bitcastToAPInt();
  return CurDAG->getTargetConstant(Lo_32(imm.getZExtValue() & 0xffffffff),
                                   SDLoc(N), MVT::i64);
}]>;

def HIFP32 : SDNodeXForm<fpimm, [{
  // Get a integer immediate from fpimm
  const APInt& imm = N->getValueAPF().bitcastToAPInt();
  return CurDAG->getTargetConstant(Hi_32(imm.getZExtValue()),
                                   SDLoc(N), MVT::i64);
}]>;

def LO32 : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(Lo_32(N->getZExtValue()),
                                   SDLoc(N), MVT::i32);
}]>;

def HI32 : SDNodeXForm<imm, [{
  // Transformation function: shift the immediate value down into the low bits.
  return CurDAG->getTargetConstant(Hi_32(N->getZExtValue()),
                                   SDLoc(N), MVT::i32);
}]>;

def LEASLimm : PatLeaf<(imm), [{
  return isShiftedUInt<32, 32>(N->getZExtValue());
}], HI32>;

def trunc_imm : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(N->getZExtValue(), SDLoc(N), MVT::i32);
}]>;

def sext_imm : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(N->getSExtValue(), SDLoc(N), MVT::i64);
}]>;

def zext_imm : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(N->getZExtValue(), SDLoc(N), MVT::i64);
}]>;

def icond2cc : SDNodeXForm<cond, [{
  VECC::CondCode cc;
  switch (N->get()) {
  default:          llvm_unreachable("Unknown integer condition code!");
  case ISD::SETEQ:  cc = VECC::CC_IEQ; break;
  case ISD::SETNE:  cc = VECC::CC_INE; break;
  case ISD::SETLT:  cc = VECC::CC_IL;  break;
  case ISD::SETGT:  cc = VECC::CC_IG;  break;
  case ISD::SETLE:  cc = VECC::CC_ILE; break;
  case ISD::SETGE:  cc = VECC::CC_IGE; break;
  case ISD::SETULT: cc = VECC::CC_IL;  break;
  case ISD::SETULE: cc = VECC::CC_ILE; break;
  case ISD::SETUGT: cc = VECC::CC_IG;  break;
  case ISD::SETUGE: cc = VECC::CC_IGE; break;
  }
  return CurDAG->getTargetConstant(cc, SDLoc(N), MVT::i32);
}]>;

def icond2ccSwap : SDNodeXForm<cond, [{
  VECC::CondCode cc;
  switch (N->get()) {
  default:          llvm_unreachable("Unknown integer condition code!");
  case ISD::SETEQ:  cc = VECC::CC_IEQ; break;
  case ISD::SETNE:  cc = VECC::CC_INE; break;
  case ISD::SETLT:  cc = VECC::CC_IG;  break;
  case ISD::SETGT:  cc = VECC::CC_IL;  break;
  case ISD::SETLE:  cc = VECC::CC_IGE; break;
  case ISD::SETGE:  cc = VECC::CC_ILE; break;
  case ISD::SETULT: cc = VECC::CC_IG;  break;
  case ISD::SETULE: cc = VECC::CC_IGE; break;
  case ISD::SETUGT: cc = VECC::CC_IL;  break;
  case ISD::SETUGE: cc = VECC::CC_ILE; break;
  }
  return CurDAG->getTargetConstant(cc, SDLoc(N), MVT::i32);
}]>;

def fcond2cc : SDNodeXForm<cond, [{
  VECC::CondCode cc;
  switch (N->get()) {
  default:          llvm_unreachable("Unknown float condition code!");
  case ISD::SETFALSE: cc = VECC::CC_AF;    break;
  case ISD::SETEQ:
  case ISD::SETOEQ:   cc = VECC::CC_EQ;    break;
  case ISD::SETNE:
  case ISD::SETONE:   cc = VECC::CC_NE;    break;
  case ISD::SETLT:
  case ISD::SETOLT:   cc = VECC::CC_L;     break;
  case ISD::SETGT:
  case ISD::SETOGT:   cc = VECC::CC_G;     break;
  case ISD::SETLE:
  case ISD::SETOLE:   cc = VECC::CC_LE;    break;
  case ISD::SETGE:
  case ISD::SETOGE:   cc = VECC::CC_GE;    break;
  case ISD::SETO:     cc = VECC::CC_NUM;   break;
  case ISD::SETUO:    cc = VECC::CC_NAN;   break;
  case ISD::SETUEQ:   cc = VECC::CC_EQNAN; break;
  case ISD::SETUNE:   cc = VECC::CC_NENAN; break;
  case ISD::SETULT:   cc = VECC::CC_LNAN;  break;
  case ISD::SETUGT:   cc = VECC::CC_GNAN;  break;
  case ISD::SETULE:   cc = VECC::CC_LENAN; break;
  case ISD::SETUGE:   cc = VECC::CC_GENAN; break;
  case ISD::SETTRUE:  cc = VECC::CC_AT;    break;
  }
  return CurDAG->getTargetConstant(cc, SDLoc(N), MVT::i32);
}]>;

def fcond2ccSwap : SDNodeXForm<cond, [{
  VECC::CondCode cc;
  switch (N->get()) {
  default:          llvm_unreachable("Unknown float condition code!");
  case ISD::SETFALSE: cc = VECC::CC_AF;    break;
  case ISD::SETEQ:
  case ISD::SETOEQ:   cc = VECC::CC_EQ;    break;
  case ISD::SETNE:
  case ISD::SETONE:   cc = VECC::CC_NE;    break;
  case ISD::SETLT:
  case ISD::SETOLT:   cc = VECC::CC_G;     break;
  case ISD::SETGT:
  case ISD::SETOGT:   cc = VECC::CC_L;     break;
  case ISD::SETLE:
  case ISD::SETOLE:   cc = VECC::CC_GE;    break;
  case ISD::SETGE:
  case ISD::SETOGE:   cc = VECC::CC_LE;    break;
  case ISD::SETO:     cc = VECC::CC_NUM;   break;
  case ISD::SETUO:    cc = VECC::CC_NAN;   break;
  case ISD::SETUEQ:   cc = VECC::CC_EQNAN; break;
  case ISD::SETUNE:   cc = VECC::CC_NENAN; break;
  case ISD::SETULT:   cc = VECC::CC_GNAN;  break;
  case ISD::SETUGT:   cc = VECC::CC_LNAN;  break;
  case ISD::SETULE:   cc = VECC::CC_GENAN; break;
  case ISD::SETUGE:   cc = VECC::CC_LENAN; break;
  case ISD::SETTRUE:  cc = VECC::CC_AT;    break;
  }
  return CurDAG->getTargetConstant(cc, SDLoc(N), MVT::i32);
}]>;

// Addressing modes.
// SX-Aurora has following fields.
//    sz: register or 0
//    sy: register or immediate (-64 to 63)
//    disp: immediate (-2147483648 to 2147483647)
//
// There are two kinds of instruction.
//    ASX format uses sz + sy + disp.
//    AS format uses sz + disp.
//
// Moreover, there are four kinds of assembly instruction format.
//    ASX format uses "disp", "disp(, sz)", "disp(sy)", "disp(sy, sz)",
//    "(, sz)", "(sy)", or "(sy, sz)".
//    AS format uses "disp", "disp(, sz)", or "(, sz)" in general.
//    AS format in RRM format uses "disp", "disp(sz)", or "(sz)".
//    AS format in RRM format for host memory access uses "sz", "(sz)",
//    or "disp(sz)".
//
// We defined them below.
//
// ASX format:
//    MEMrri, MEMrii, MEMzri, MEMzii
// AS format:
//    MEMriASX, MEMziASX    : simple AS format
//    MEMriRRM, MEMziRRM    : AS format in RRM format
//    MEMriHM, MEMziHM      : AS format in RRM format for host memory access

def ADDRrri : ComplexPattern<iPTR, 3, "SelectADDRrri", [frameindex], []>;
def ADDRrii : ComplexPattern<iPTR, 3, "SelectADDRrii", [frameindex], []>;
def ADDRzri : ComplexPattern<iPTR, 3, "SelectADDRzri", [], []>;
def ADDRzii : ComplexPattern<iPTR, 3, "SelectADDRzii", [], []>;
// AS format:
def ADDRri : ComplexPattern<iPTR, 2, "SelectADDRri", [frameindex], []>;
def ADDRzi : ComplexPattern<iPTR, 2, "SelectADDRzi", [], []>;
//
// ASX assembly instrcution format:
def VEMEMrriAsmOperand : AsmOperandClass {
  let Name = "MEMrri";
  let ParserMethod = "parseMEMOperand";
}
def VEMEMriiAsmOperand : AsmOperandClass {
  let Name = "MEMrii";
  let ParserMethod = "parseMEMOperand";
}
def VEMEMzriAsmOperand : AsmOperandClass {
  let Name = "MEMzri";
  let ParserMethod = "parseMEMOperand";
}
def VEMEMziiAsmOperand : AsmOperandClass {
  let Name = "MEMzii";
  let ParserMethod = "parseMEMOperand";
}
def MEMrri : Operand<iPTR> {
  let PrintMethod = "printMemASXOperand";
  let MIOperandInfo = (ops ptr_rc, ptr_rc, i32imm);
  let ParserMatchClass = VEMEMrriAsmOperand;
}
def MEMrii : Operand<iPTR> {
  let PrintMethod = "printMemASXOperand";
  let MIOperandInfo = (ops ptr_rc, i32imm, i32imm);
  let ParserMatchClass = VEMEMriiAsmOperand;
}
def MEMzri : Operand<iPTR> {
  let PrintMethod = "printMemASXOperand";
  let MIOperandInfo = (ops i32imm /* = 0 */, ptr_rc, i32imm);
  let ParserMatchClass = VEMEMzriAsmOperand;
}
def MEMzii : Operand<iPTR> {
  let PrintMethod = "printMemASXOperand";
  let MIOperandInfo = (ops i32imm /* = 0 */, i32imm, i32imm);
  let ParserMatchClass = VEMEMziiAsmOperand;
}
// AS assembly instrcution format:
def VEMEMriAsmOperand : AsmOperandClass {
  let Name = "MEMri";
  let ParserMethod = "parseMEMAsOperand";
}
def VEMEMziAsmOperand : AsmOperandClass {
  let Name = "MEMzi";
  let ParserMethod = "parseMEMAsOperand";
}
// AS generic assembly instruction format:
def MEMriASX : Operand<iPTR> {
  let PrintMethod = "printMemASOperandASX";
  let MIOperandInfo = (ops ptr_rc, i32imm);
  let ParserMatchClass = VEMEMriAsmOperand;
}
def MEMziASX : Operand<iPTR> {
  let PrintMethod = "printMemASOperandASX";
  let MIOperandInfo = (ops i32imm /* = 0 */, i32imm);
  let ParserMatchClass = VEMEMziAsmOperand;
}
// AS RRM style assembly instruction format:
def MEMriRRM : Operand<iPTR> {
  let PrintMethod = "printMemASOperandRRM";
  let MIOperandInfo = (ops ptr_rc, i32imm);
  let ParserMatchClass = VEMEMriAsmOperand;
}
def MEMziRRM : Operand<iPTR> {
  let PrintMethod = "printMemASOperandRRM";
  let MIOperandInfo = (ops i32imm /* = 0 */, i32imm);
  let ParserMatchClass = VEMEMziAsmOperand;
}
// AS HM style assembly instruction format:
def MEMriHM : Operand<iPTR> {
  let PrintMethod = "printMemASOperandHM";
  let MIOperandInfo = (ops ptr_rc, i32imm);
  let ParserMatchClass = VEMEMriAsmOperand;
}
def MEMziHM : Operand<iPTR> {
  let PrintMethod = "printMemASOperandHM";
  let MIOperandInfo = (ops i32imm /* = 0 */, i32imm);
  let ParserMatchClass = VEMEMziAsmOperand;
}

// Branch targets have OtherVT type.
def brtarget32 : Operand<OtherVT> {
  let EncoderMethod = "getBranchTargetOpValue";
  let DecoderMethod = "DecodeSIMM32";
}

def TLSSym : Operand<iPTR>;

def calltarget : Operand<i64> {
  let EncoderMethod = "getCallTargetOpValue";
  let DecoderMethod = "DecodeCallTarget";
}

def simm7Op32 : Operand<i32> {
  let DecoderMethod = "DecodeSIMM7";
}

def simm7Op64 : Operand<i64> {
  let DecoderMethod = "DecodeSIMM7";
}

def simm7Op128 : Operand<i128> {
  let DecoderMethod = "DecodeSIMM7";
}

def simm32Op32 : Operand<i32> {
  let DecoderMethod = "DecodeSIMM32";
}

def simm32Op64 : Operand<i64> {
  let DecoderMethod = "DecodeSIMM32";
}

def uimm6Op32 : Operand<i32>;
def uimm6Op64 : Operand<i64>;
def uimm6Op128 : Operand<i128>;

// Operand for printing out a condition code.
def CCOpAsmOperand : AsmOperandClass {
  let Name = "CCOp";
}
def CCOp : Operand<i32> {
  let PrintMethod = "printCCOperand";
  let DecoderMethod = "DecodeCCOperand";
  let EncoderMethod = "getCCOpValue";
  let ParserMatchClass = CCOpAsmOperand;
}
def CCOpDotAsmOperand : AsmOperandClass {
  let Name = "CCOpDot";
}
def CCOpDot : Operand<i32> {
  let PrintMethod = "printCCOperandDot";
  let DecoderMethod = "DecodeCCOperand";
  let EncoderMethod = "getCCOpValue";
  let ParserMatchClass = CCOpDotAsmOperand;
}

// Operand for printing out a branch prediction code.
def BPOp : Operand<i32> {
  let PrintMethod = "printBPOperand";
  let DecoderMethod = "DecodeBPOperand";
  let EncoderMethod = "getBPOpValue";
}

// Operand for printing out a rounding mode code.
def RDOpAsmOperand : AsmOperandClass {
  let Name = "RDOp";
}
def RDOp : Operand<i32> {
  let PrintMethod = "printRDOperand";
  let DecoderMethod = "DecodeRDOperand";
  let EncoderMethod = "getRDOpValue";
  let ParserMatchClass = RDOpAsmOperand;
}

def VEhi    : SDNode<"VEISD::Hi", SDTIntUnaryOp>;
def VElo    : SDNode<"VEISD::Lo", SDTIntUnaryOp>;

//  These are target-independent nodes, but have target-specific formats.
def SDT_SPCallSeqStart : SDCallSeqStart<[ SDTCisVT<0, i64>,
                                          SDTCisVT<1, i64> ]>;
def SDT_SPCallSeqEnd   : SDCallSeqEnd<[ SDTCisVT<0, i64>,
                                        SDTCisVT<1, i64> ]>;

def callseq_start : SDNode<"ISD::CALLSEQ_START", SDT_SPCallSeqStart,
                           [SDNPHasChain, SDNPOutGlue]>;
def callseq_end   : SDNode<"ISD::CALLSEQ_END",   SDT_SPCallSeqEnd,
                           [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue]>;

def SDT_SPCall    : SDTypeProfile<0, -1, [SDTCisVT<0, i64>]>;
def call          : SDNode<"VEISD::CALL", SDT_SPCall,
                           [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue,
                            SDNPVariadic]>;

def retflag       : SDNode<"VEISD::RET_FLAG", SDTNone,
                           [SDNPHasChain, SDNPOptInGlue, SDNPVariadic]>;

def getGOT        : Operand<iPTR>;
def getFunPLT     : Operand<iPTR> {
  let PrintMethod = "printGetFunPLT";
}

def VEmax : SDNode<"VEISD::MAX", SDTIntBinOp>;
def VEmin : SDNode<"VEISD::MIN", SDTIntBinOp>;
def VEfmax : SDNode<"VEISD::FMAX", SDTFPBinOp>;
def VEfmin : SDNode<"VEISD::FMIN", SDTFPBinOp>;

def VEeh_sjlj_setjmp: SDNode<"VEISD::EH_SJLJ_SETJMP",
                             SDTypeProfile<1, 1, [SDTCisInt<0>,
                                                  SDTCisPtrTy<1>]>,
                             [SDNPHasChain, SDNPSideEffect]>;
def VEeh_sjlj_longjmp: SDNode<"VEISD::EH_SJLJ_LONGJMP",
                              SDTypeProfile<0, 1, [SDTCisPtrTy<0>]>,
                              [SDNPHasChain, SDNPSideEffect]>;
def VEeh_sjlj_setup_dispatch: SDNode<"VEISD::EH_SJLJ_SETUP_DISPATCH",
                                     SDTypeProfile<0, 0, []>,
                                     [SDNPHasChain, SDNPSideEffect]>;

// GETFUNPLT for PIC
def GetFunPLT : SDNode<"VEISD::GETFUNPLT", SDTIntUnaryOp>;

// GETTLSADDR for TLS
def GetTLSAddr : SDNode<"VEISD::GETTLSADDR", SDT_SPCall,
                        [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue,
                         SDNPVariadic]>;

// GETSTACKTOP
def GetStackTop : SDNode<"VEISD::GETSTACKTOP", SDTNone,
                        [SDNPHasChain, SDNPSideEffect]>;

// MEMBARRIER
def MemBarrier : SDNode<"VEISD::MEMBARRIER", SDTNone,
                        [SDNPHasChain, SDNPSideEffect]>;


//===----------------------------------------------------------------------===//
// VE Flag Conditions
//===----------------------------------------------------------------------===//

// Note that these values must be kept in sync with the CCOp::CondCode enum
// values.
class CC_VAL<int N> : PatLeaf<(i32 N)>;
def CC_IG    : CC_VAL< 0>;  // Greater
def CC_IL    : CC_VAL< 1>;  // Less
def CC_INE   : CC_VAL< 2>;  // Not Equal
def CC_IEQ   : CC_VAL< 3>;  // Equal
def CC_IGE   : CC_VAL< 4>;  // Greater or Equal
def CC_ILE   : CC_VAL< 5>;  // Less or Equal
def CC_AF    : CC_VAL< 6>;  // Always false
def CC_G     : CC_VAL< 7>;  // Greater
def CC_L     : CC_VAL< 8>;  // Less
def CC_NE    : CC_VAL< 9>;  // Not Equal
def CC_EQ    : CC_VAL<10>;  // Equal
def CC_GE    : CC_VAL<11>;  // Greater or Equal
def CC_LE    : CC_VAL<12>;  // Less or Equal
def CC_NUM   : CC_VAL<13>;  // Number
def CC_NAN   : CC_VAL<14>;  // NaN
def CC_GNAN  : CC_VAL<15>;  // Greater or NaN
def CC_LNAN  : CC_VAL<16>;  // Less or NaN
def CC_NENAN : CC_VAL<17>;  // Not Equal or NaN
def CC_EQNAN : CC_VAL<18>;  // Equal or NaN
def CC_GENAN : CC_VAL<19>;  // Greater or Equal or NaN
def CC_LENAN : CC_VAL<20>;  // Less or Equal or NaN
def CC_AT    : CC_VAL<21>;  // Always true

//===----------------------------------------------------------------------===//
// VE Rounding Mode
//===----------------------------------------------------------------------===//

// Note that these values must be kept in sync with the VERD::RoundingMode enum
// values.
class RD_VAL<int N> : PatLeaf<(i32 N)>;
def RD_NONE  : RD_VAL< 0>;  // According to PSW
def RD_RZ    : RD_VAL< 8>;  // Round toward Zero
def RD_RP    : RD_VAL< 9>;  // Round toward Plus infinity
def RD_RM    : RD_VAL<10>;  // Round toward Minus infinity
def RD_RN    : RD_VAL<11>;  // Round to Nearest (ties to Even)
def RD_RA    : RD_VAL<12>;  // Round to Nearest (ties to Away)

//===----------------------------------------------------------------------===//
// VE Multiclasses for common instruction formats
//===----------------------------------------------------------------------===//

multiclass RMm<string opcStr, bits<8>opc, RegisterClass RC> {
  def rri : RM<opc, (outs RC:$dest), (ins MEMrri:$addr),
               !strconcat(opcStr, " $dest, $addr"), []>;
  let cy = 0 in
  def rii : RM<opc, (outs RC:$dest), (ins MEMrii:$addr),
               !strconcat(opcStr, " $dest, $addr"), []>;
  let cz = 0 in
  def zri : RM<opc, (outs RC:$dest), (ins MEMzri:$addr),
               !strconcat(opcStr, " $dest, $addr"), []>;
  let cy = 0, cz = 0 in
  def zii : RM<opc, (outs RC:$dest), (ins MEMzii:$addr),
               !strconcat(opcStr, " $dest, $addr"), []>;
}

// Multiclass for RR type instructions
multiclass RRmrr<string opcStr, bits<8>opc,
                 RegisterClass RCo, ValueType Tyo,
                 RegisterClass RCi, ValueType Tyi,
                 SDPatternOperator OpNode = null_frag> {
  let hasSideEffects = 0 in
  def rr : RR<opc, (outs RCo:$sx), (ins RCi:$sy, RCi:$sz),
              !strconcat(opcStr, " $sx, $sy, $sz"),
              [(set Tyo:$sx, (OpNode Tyi:$sy, Tyi:$sz))]>;
}

multiclass RRmri<string opcStr, bits<8>opc,
                 RegisterClass RCo, ValueType Tyo,
                 RegisterClass RCi, ValueType Tyi, Operand immOp,
                 SDPatternOperator OpNode = null_frag> {
  // VE calculates (OpNode $sy, $sz), but llvm requires to have immediate
  // in RHS, so we use following definition.
  let cy = 0, hasSideEffects = 0 in
  def ri : RR<opc, (outs RCo:$sx), (ins RCi:$sz, immOp:$sy),
              !strconcat(opcStr, " $sx, $sy, $sz"),
              [(set Tyo:$sx, (OpNode Tyi:$sz, (Tyi simm7:$sy)))]>;
}

multiclass RRmir<string opcStr, bits<8>opc,
                 RegisterClass RCo, ValueType Tyo,
                 RegisterClass RCi, ValueType Tyi, Operand immOp,
                 SDPatternOperator OpNode = null_frag> {
  let cy = 0, hasSideEffects = 0 in
  def ir : RR<opc, (outs RCo:$sx), (ins immOp:$sy, RCi:$sz),
              !strconcat(opcStr, " $sx, $sy, $sz"),
              [(set Tyo:$sx, (OpNode (Tyi simm7:$sy), Tyi:$sz))]>;
}

multiclass RRmiz<string opcStr, bits<8>opc,
                 RegisterClass RCo, ValueType Tyo,
                 RegisterClass RCi, ValueType Tyi, Operand immOp,
                 SDPatternOperator OpNode = null_frag> {
  let cy = 0, cz = 0, sz = 0, hasSideEffects = 0 in
  def zi : RR<opc, (outs RCo:$sx), (ins immOp:$sy),
              !strconcat(opcStr, " $sx, $sy"),
              [(set Tyo:$sx, (OpNode (Tyi simm7:$sy), 0))]>;
}

multiclass RRNDmrm<string opcStr, bits<8>opc,
                   RegisterClass RCo, ValueType Tyo,
                   RegisterClass RCi, ValueType Tyi, Operand immOp2> {
  let cz = 0, mz = 1, hasSideEffects = 0 in
  def rm0 : RR<opc, (outs RCo:$sx), (ins RCi:$sy, immOp2:$sz),
               !strconcat(opcStr, " $sx, $sy, (${sz})0")>;
  let cz = 0, mz = 0, hasSideEffects = 0 in
  def rm1 : RR<opc, (outs RCo:$sx), (ins RCi:$sy, immOp2:$sz),
               !strconcat(opcStr, " $sx, $sy, (${sz})1")>;
}

multiclass RRNDmim<string opcStr, bits<8>opc,
                 RegisterClass RCo, ValueType Tyo,
                 RegisterClass RCi, ValueType Tyi,
                 Operand immOp, Operand immOp2> {
  let cy = 0, cz = 0, mz = 1, hasSideEffects = 0 in
  def im0 : RR<opc, (outs RCo:$sx), (ins immOp:$sy, immOp2:$sz),
               !strconcat(opcStr, " $sx, $sy, (${sz})0")>;
  let cy = 0, cz = 0, mz = 0, hasSideEffects = 0 in
  def im1 : RR<opc, (outs RCo:$sx), (ins immOp:$sy, immOp2:$sz),
               !strconcat(opcStr, " $sx, $sy, (${sz})1")>;
}

// Used by add, mul, and similar commutative instructions
//   The order of operands are "$sx, $sy, $sz"

multiclass RRm<string opcStr, bits<8>opc,
               RegisterClass RC, ValueType Ty,
               Operand immOp, Operand immOp2,
               SDPatternOperator OpNode = null_frag> :
  RRmrr<opcStr, opc, RC, Ty, RC, Ty, OpNode>,
  RRmri<opcStr, opc, RC, Ty, RC, Ty, immOp, OpNode>,
  RRmiz<opcStr, opc, RC, Ty, RC, Ty, immOp, OpNode>,
  RRNDmrm<opcStr, opc, RC, Ty, RC, Ty, immOp2>,
  RRNDmim<opcStr, opc, RC, Ty, RC, Ty, immOp, immOp2>;

// Used by mpd (int x int = long) and similar instructions.

multiclass RRTYm<string opcStr, bits<8>opc,
               RegisterClass RCo, ValueType Tyo,
               RegisterClass RCi, ValueType Tyi,
               Operand immOp, Operand immOp2,
               SDPatternOperator OpNode = null_frag> :
  RRmrr<opcStr, opc, RCo, Tyo, RCi, Tyi, OpNode>,
  RRmri<opcStr, opc, RCo, Tyo, RCi, Tyi, immOp, OpNode>,
  RRmiz<opcStr, opc, RCo, Tyo, RCi, Tyi, immOp, OpNode>,
  RRNDmrm<opcStr, opc, RCo, Tyo, RCi, Tyi, immOp2>,
  RRNDmim<opcStr, opc, RCo, Tyo, RCi, Tyi, immOp, immOp2>;

// Used by sub, div, and similar not commutative instructions
//   The order of operands are "$sx, $sy, $sz"

multiclass RRNCm<string opcStr, bits<8>opc,
               RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2,
               SDPatternOperator OpNode = null_frag> :
  RRmrr<opcStr, opc, RC, Ty, RC, Ty, OpNode>,
  RRmir<opcStr, opc, RC, Ty, RC, Ty, immOp, OpNode>,
  RRmiz<opcStr, opc, RC, Ty, RC, Ty, immOp, OpNode>,
  RRNDmrm<opcStr, opc, RC, Ty, RC, Ty, immOp2>,
  RRNDmim<opcStr, opc, RC, Ty, RC, Ty, immOp, immOp2>;

// Used by fadd, fsub, and similar floating point instructions
//   The order of operands are "$sx, $sy, $sz"

multiclass RRFm<string opcStr, bits<8>opc,
               RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2,
               SDPatternOperator OpNode = null_frag> :
  RRmrr<opcStr, opc, RC, Ty, RC, Ty, OpNode>,
  RRmir<opcStr, opc, RC, Ty, RC, Ty, immOp, null_frag>,
  RRmiz<opcStr, opc, RC, Ty, RC, Ty, immOp, null_frag>,
  RRNDmrm<opcStr, opc, RC, Ty, RC, Ty, immOp2>,
  RRNDmim<opcStr, opc, RC, Ty, RC, Ty, immOp, immOp2>;

// Used by fcq instruction like "F64 <- cmp F128, F128"
//   The order of operands are "$sx, $sy, $sz"

multiclass RRFCQm<string opcStr, bits<8>opc,
                  RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2,
                  SDPatternOperator OpNode = null_frag> :
  RRmrr<opcStr, opc, I64, f64, RC, Ty, null_frag>,
  RRmir<opcStr, opc, I64, f64, RC, Ty, immOp, null_frag>,
  RRmiz<opcStr, opc, I64, f64, RC, Ty, immOp, null_frag>,
  RRNDmrm<opcStr, opc, I64, f64, RC, Ty, immOp2>,
  RRNDmim<opcStr, opc, I64, f64, RC, Ty, immOp, immOp2>;


//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

// NOP instruction
let cx = 0, sx = 0, cy = 0, sy = 0, cz = 0, sz = 0, hasSideEffects = 0 in
def NOP : RR<0x79, (outs), (ins), "nop">;

//-----------------------------------------------------------------------------
// Section 8.2 - Load/Store instructions
//-----------------------------------------------------------------------------

// Section 8.2.1 - LEA
let cx = 0, DecoderMethod = "DecodeLoadI64" in
defm LEA : RMm<"lea", 0x06, I64>;
let cx = 1, DecoderMethod = "DecodeLoadI64" in
defm LEASL : RMm<"lea.sl", 0x06, I64>;
let isCodeGenOnly = 1 in {
let cx = 0, DecoderMethod = "DecodeLoadI32" in
defm LEA32 : RMm<"lea", 0x06, I32>;
}

def : Pat<(iPTR ADDRrri:$addr), (LEArri MEMrri:$addr)>;
def : Pat<(iPTR ADDRrii:$addr), (LEArii MEMrii:$addr)>;
def : Pat<(add I64:$base, simm32:$disp), (LEArii $base, 0, (LO32 $disp))>;
def : Pat<(add (add I64:$base, simm7:$idx), simm32:$disp),
          (LEArii $base, (LO7 $idx), (LO32 $disp))>;
def : Pat<(add (add I64:$base, simm32:$disp), simm7:$idx),
          (LEArii $base, (LO7 $idx), (LO32 $disp))>;
def : Pat<(add (add I64:$base, I64:$idx), simm32:$disp),
          (LEArri $base, $idx, (LO32 $disp))>;
def : Pat<(add (add I64:$base, simm32:$disp), I64:$idx),
          (LEArri $base, $idx, (LO32 $disp))>;
def : Pat<(add I64:$base, lozero:$disp), (LEASLrii $base, 0, (HI32 $disp))>;
def : Pat<(add (add I64:$base, simm7:$idx), lozero:$disp),
          (LEASLrii $base, (LO7 $idx), (HI32 $disp))>;
def : Pat<(add (add I64:$base, lozero:$disp), simm7:$idx),
          (LEASLrii $base, (LO7 $idx), (HI32 $disp))>;
def : Pat<(add (add I64:$base, I64:$idx), lozero:$disp),
          (LEASLrri $base, $idx, (HI32 $disp))>;
def : Pat<(add (add I64:$base, lozero:$disp), I64:$idx),
          (LEASLrri $base, $idx, (HI32 $disp))>;

def : Pat<(add I32:$base, simm32:$disp),
          (LEA32rii (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $base, sub_i32), 0,
                    (LO32 $disp))>;

// Multiclass for load instructions.
let mayLoad = 1, hasSideEffects = 0 in
multiclass LOADm<string opcStr, bits<8> opc, RegisterClass RC, ValueType Ty,
                 SDPatternOperator OpNode = null_frag> {
  def rri : RM<opc, (outs RC:$dest), (ins MEMrri:$addr),
               !strconcat(opcStr, " $dest, $addr"),
               [(set Ty:$dest, (OpNode ADDRrri:$addr))]>;
  let cy = 0 in
  def rii : RM<opc, (outs RC:$dest), (ins MEMrii:$addr),
               !strconcat(opcStr, " $dest, $addr"),
               [(set Ty:$dest, (OpNode ADDRrii:$addr))]>;
  let cz = 0 in
  def zri : RM<opc, (outs RC:$dest), (ins MEMzri:$addr),
               !strconcat(opcStr, " $dest, $addr"),
               [(set Ty:$dest, (OpNode ADDRzri:$addr))]>;
  let cy = 0, cz = 0 in
  def zii : RM<opc, (outs RC:$dest), (ins MEMzii:$addr),
               !strconcat(opcStr, " $dest, $addr"),
               [(set Ty:$dest, (OpNode ADDRzii:$addr))]>;
}

// Section 8.2.2 - LDS
let DecoderMethod = "DecodeLoadI64" in
defm LD : LOADm<"ld", 0x01, I64, i64, load>;
def : Pat<(f64 (load ADDRrri:$addr)), (LDrri MEMrri:$addr)>;
def : Pat<(f64 (load ADDRrii:$addr)), (LDrii MEMrii:$addr)>;
def : Pat<(f64 (load ADDRzri:$addr)), (LDzri MEMzri:$addr)>;
def : Pat<(f64 (load ADDRzii:$addr)), (LDzii MEMzii:$addr)>;

// Section 8.2.3 - LDU
let DecoderMethod = "DecodeLoadF32" in
defm LDU : LOADm<"ldu", 0x02, F32, f32, load>;

// Section 8.2.4 - LDL
let DecoderMethod = "DecodeLoadI32" in
defm LDLSX : LOADm<"ldl.sx", 0x03, I32, i32, load>;
let cx = 1, DecoderMethod = "DecodeLoadI32" in
defm LDLZX : LOADm<"ldl.zx", 0x03, I32, i32, load>;

// Section 8.2.5 - LD2B
let DecoderMethod = "DecodeLoadI16" in
defm LD2BSX : LOADm<"ld2b.sx", 0x04, I32, i32, sextloadi16>;
let cx = 1, DecoderMethod = "DecodeLoadI16" in
defm LD2BZX : LOADm<"ld2b.zx", 0x04, I32, i32, zextloadi16>;

// Section 8.2.6 - LD1B
let DecoderMethod = "DecodeLoadI8" in
defm LD1BSX : LOADm<"ld1b.sx", 0x05, I32, i32, sextloadi8>;
let cx = 1, DecoderMethod = "DecodeLoadI8" in
defm LD1BZX : LOADm<"ld1b.zx", 0x05, I32, i32, zextloadi8>;

// LDQ pseudo instructions
let mayLoad = 1, hasSideEffects = 0 in {
def LDQrri : Pseudo<(outs F128:$dest), (ins MEMrri:$addr),
                    "# pseudo ldq $dest, $addr",
                    [(set f128:$dest, (load ADDRrri:$addr))]>;
def LDQrii : Pseudo<(outs F128:$dest), (ins MEMrii:$addr),
                    "# pseudo ldq $dest, $addr",
                    [(set f128:$dest, (load ADDRrii:$addr))]>;
def LDQzri : Pseudo<(outs F128:$dest), (ins MEMzri:$addr),
                    "# pseudo ldq $dest, $addr",
                    [(set f128:$dest, (load ADDRzri:$addr))]>;
def LDQzii : Pseudo<(outs F128:$dest), (ins MEMzii:$addr),
                    "# pseudo ldq $dest, $addr",
                    [(set f128:$dest, (load ADDRzii:$addr))]>;
}

// Multiclass for store instructions.
let mayStore = 1 in
multiclass STOREm<string opcStr, bits<8> opc, RegisterClass RC, ValueType Ty,
                  SDPatternOperator OpNode = null_frag> {
  def rri : RM<opc, (outs), (ins MEMrri:$addr, RC:$sx),
               !strconcat(opcStr, " $sx, $addr"),
               [(OpNode Ty:$sx, ADDRrri:$addr)]>;
  let cy = 0 in
  def rii : RM<opc, (outs), (ins MEMrii:$addr, RC:$sx),
               !strconcat(opcStr, " $sx, $addr"),
               [(OpNode Ty:$sx, ADDRrii:$addr)]>;
  let cz = 0 in
  def zri : RM<opc, (outs), (ins MEMzri:$addr, RC:$sx),
               !strconcat(opcStr, " $sx, $addr"),
               [(OpNode Ty:$sx, ADDRzri:$addr)]>;
  let cy = 0, cz = 0 in
  def zii : RM<opc, (outs), (ins MEMzii:$addr, RC:$sx),
               !strconcat(opcStr, " $sx, $addr"),
               [(OpNode Ty:$sx, ADDRzii:$addr)]>;
}

// Section 8.2.7 - STS
let DecoderMethod = "DecodeStoreI64" in
defm ST : STOREm<"st", 0x11, I64, i64, store>;
def : Pat<(store f64:$src, ADDRrri:$addr), (STrri MEMrri:$addr, $src)>;
def : Pat<(store f64:$src, ADDRrii:$addr), (STrii MEMrii:$addr, $src)>;
def : Pat<(store f64:$src, ADDRzri:$addr), (STzri MEMzri:$addr, $src)>;
def : Pat<(store f64:$src, ADDRzii:$addr), (STzii MEMzii:$addr, $src)>;

// Section 8.2.8 - STU
let DecoderMethod = "DecodeStoreF32" in
defm STU : STOREm<"stu", 0x12, F32, f32, store>;

// Section 8.2.9 - STL
let DecoderMethod = "DecodeStoreI32" in
defm STL : STOREm<"stl", 0x13, I32, i32, store>;

// Section 8.2.10 - ST2B
let DecoderMethod = "DecodeStoreI16" in
defm ST2B : STOREm<"st2b", 0x14, I32, i32, truncstorei16>;

// Section 8.2.11 - ST1B
let DecoderMethod = "DecodeStoreI8" in
defm ST1B : STOREm<"st1b", 0x15, I32, i32, truncstorei8>;

// STQ pseudo instructions
let mayStore = 1, hasSideEffects = 0 in {
def STQrri : Pseudo<(outs), (ins MEMrri:$addr, F128:$sx),
                    "# pseudo stq $sx, $addr",
                    [(store f128:$sx, ADDRrri:$addr)]>;
def STQrii : Pseudo<(outs), (ins MEMrii:$addr, F128:$sx),
                    "# pseudo stq $sx, $addr",
                    [(store f128:$sx, ADDRrii:$addr)]>;
def STQzri : Pseudo<(outs), (ins MEMzri:$addr, F128:$sx),
                    "# pseudo stq $sx, $addr",
                    [(store f128:$sx, ADDRzri:$addr)]>;
def STQzii : Pseudo<(outs), (ins MEMzii:$addr, F128:$sx),
                    "# pseudo stq $sx, $addr",
                    [(store f128:$sx, ADDRzii:$addr)]>;
}

// Section 8.2.12 - DLDS
let DecoderMethod = "DecodeLoadI64" in
defm DLD : LOADm<"dld", 0x09, I64, i64, load>;

// Section 8.2.13 - DLDU
let DecoderMethod = "DecodeLoadF32" in
defm DLDU : LOADm<"dldu", 0x0a, F32, f32, load>;

// Section 8.2.14 - DLDL
let DecoderMethod = "DecodeLoadI32" in
defm DLDLSX : LOADm<"dldl.sx", 0x0b, I32, i32, load>;
let cx = 1, DecoderMethod = "DecodeLoadI32" in
defm DLDLZX : LOADm<"dldl.zx", 0x0b, I32, i32, load>;

// Section 8.2.15 - PFCH
let sx = 0 in
multiclass PFCHm<string opcStr, bits<8>opc> {
  def rri : RM<opc, (outs), (ins MEMrri:$addr), !strconcat(opcStr, " $addr"),
               [(prefetch ADDRrri:$addr, imm, imm, (i32 1))]>;
  let cy = 0 in
  def rii : RM<opc, (outs), (ins MEMrii:$addr), !strconcat(opcStr, " $addr"),
               [(prefetch ADDRrii:$addr, imm, imm, (i32 1))]>;
  let cz = 0 in
  def zri : RM<opc, (outs), (ins MEMzri:$addr), !strconcat(opcStr, " $addr"),
               [(prefetch ADDRzri:$addr, imm, imm, (i32 1))]>;
  let cy = 0, cz = 0 in
  def zii : RM<opc, (outs), (ins MEMzii:$addr), !strconcat(opcStr, " $addr"),
               [(prefetch ADDRzii:$addr, imm, imm, (i32 1))]>;
}
let DecoderMethod = "DecodeASX" in defm PFCH : PFCHm<"pfch", 0x0c>;

// Section 8.2.16 - TS1AM (Test and Set 1 AM)

let Constraints = "$dest = $sd", DisableEncoding = "$sd",
    mayStore=1, mayLoad = 1, hasSideEffects = 0 in
multiclass RRCAStgm<string opcStr, bits<8>opc, RegisterClass RC, Operand immOp,
                    Operand ADDR> {
  def r : RRM<opc, (outs RC:$dest), (ins ADDR:$addr, RC:$sy, RC:$sd),
                !strconcat(opcStr, " $dest, $addr, $sy")>;
  let cy = 0 in
  def i : RRM<opc, (outs RC:$dest), (ins ADDR:$addr, immOp:$sy, RC:$sd),
                  !strconcat(opcStr, " $dest, $addr, $sy")>;
}
multiclass RRCASm<string opcStr, bits<8>opc, RegisterClass RC, Operand immOp> {
  defm ri : RRCAStgm<opcStr, opc, RC, immOp, MEMriRRM>;
  let cz = 0 in defm zi : RRCAStgm<opcStr, opc, RC, immOp, MEMziRRM>;
}

let cx = 0 in
defm TS1AML : RRCASm<"ts1am.l", 0x42, I64, uimm7>;
let cx = 1 in
defm TS1AMW : RRCASm<"ts1am.w", 0x42, I32, uimm7>;

// Section 8.2.17 - TS2AM (Test and Set 2 AM)
let cx = 0 in defm TS2AM : RRCASm<"ts2am", 0x43, I64, uimm7>;

// Section 8.2.18 - TS3AM (Test and Set 3 AM)
let cx = 0 in defm TS3AM : RRCASm<"ts3am", 0x52, I64, uimm7>;

// Section 8.2.19 - ATMAM (Atomic AM)
let cx = 0 in defm ATMAM : RRCASm<"atmam", 0x53, I64, uimm7>;

// Section 8.2.20 - CAS (Compare and Swap)
let cx = 0 in defm CASL : RRCASm<"cas.l", 0x62, I64, simm7>;
let cx = 1 in defm CASW : RRCASm<"cas.w", 0x62, I32, simm7>;

//-----------------------------------------------------------------------------
// Section 8.3 - Transfer Control Instructions
//-----------------------------------------------------------------------------

// Section 8.3.1 - FENCE (Fence)
let hasSideEffects = 1 in {
  let avo = 1 in def FENCEI : RRFENCE<0x20, (outs), (ins), "fencei">;
  def FENCEM : RRFENCE<0x20, (outs), (ins uimm2:$kind), "fencem $kind"> {
    bits<2> kind;
    let lf = kind{1};
    let sf = kind{0};
  }
  def FENCEC : RRFENCE<0x20, (outs), (ins uimm3:$kind), "fencec $kind"> {
    bits<3> kind;
    let c2 = kind{2};
    let c1 = kind{1};
    let c0 = kind{0};
  }
}

// Section 8.3.2 - SVOB (Set Vector Out-of-order memory access Boundary)
let sx = 0, cy = 0, sy = 0, cz = 0, sz = 0, hasSideEffects = 1 in
def SVOB : RR<0x30, (outs), (ins), "svob">;

//-----------------------------------------------------------------------------
// Section 8.4 - Fixed-point Operation Instructions
//-----------------------------------------------------------------------------

// Section 8.4.1 - ADD (Add)
defm ADDUL : RRm<"addu.l", 0x48, I64, i64, simm7, uimm6>;
let cx = 1 in defm ADDUW : RRm<"addu.w", 0x48, I32, i32, simm7, uimm6>;

// Section 8.4.2 - ADS (Add Single)
defm ADDSWSX : RRm<"adds.w.sx", 0x4A, I32, i32, simm7, uimm6, add>;
let cx = 1 in defm ADDSWZX : RRm<"adds.w.zx", 0x4A, I32, i32, simm7, uimm6>;

// Section 8.4.3 - ADX (Add)
defm ADDSL : RRm<"adds.l", 0x59, I64, i64, simm7, uimm6, add>;

// Section 8.4.4 - SUB (Subtract)
defm SUBUL : RRNCm<"subu.l", 0x58, I64, i64, simm7, uimm6>;
let cx = 1 in defm SUBUW : RRNCm<"subu.w", 0x58, I32, i32, simm7, uimm6>;

// Section 8.4.5 - SBS (Subtract Single)
defm SUBSWSX : RRNCm<"subs.w.sx", 0x5A, I32, i32, simm7, uimm6, sub>;
let cx = 1 in defm SUBSWZX : RRNCm<"subs.w.zx", 0x5A, I32, i32, simm7, uimm6>;

// Section 8.4.6 - SBX (Subtract)
defm SUBSL : RRNCm<"subs.l", 0x5B, I64, i64, simm7, uimm6, sub>;

// Section 8.4.7 - MPY (Multiply)
defm MULUL : RRm<"mulu.l", 0x49, I64, i64, simm7, uimm6>;
let cx = 1 in defm MULUW : RRm<"mulu.w", 0x49, I32, i32, simm7, uimm6>;

// Section 8.4.8 - MPS (Multiply Single)
defm MULSWSX : RRm<"muls.w.sx", 0x4B, I32, i32, simm7, uimm6, mul>;
let cx = 1 in defm MULSWZX : RRm<"muls.w.zx", 0x4B, I32, i32, simm7, uimm6>;

// Section 8.4.9 - MPX (Multiply)
defm MULSL : RRm<"muls.l", 0x6E, I64, i64, simm7, uimm6, mul>;

// Section 8.4.10 - MPD (Multiply)
defm MULSLW : RRTYm<"muls.l.w", 0x6B, I64, i64, I32, i32, simm7, uimm6>;

// Section 8.4.11 - DIV (Divide)
defm DIVUL : RRNCm<"divu.l", 0x6F, I64, i64, simm7, uimm6, udiv>;
let cx = 1 in defm DIVUW : RRNCm<"divu.w", 0x6F, I32, i32, simm7, uimm6, udiv>;

// Section 8.4.12 - DVS (Divide Single)
defm DIVSWSX : RRNCm<"divs.w.sx", 0x7B, I32, i32, simm7, uimm6, sdiv>;
let cx = 1 in defm DIVSWZX : RRNCm<"divs.w.zx", 0x7B, I32, i32, simm7, uimm6>;

// Section 8.4.13 - DVX (Divide)
defm DIVSL : RRNCm<"divs.l", 0x7F, I64, i64, simm7, uimm6, sdiv>;

// Section 8.4.14 - CMP (Compare)
defm CMPUL : RRNCm<"cmpu.l", 0x55, I64, i64, simm7, uimm6>;
let cx = 1 in defm CMPUW : RRNCm<"cmpu.w", 0x55, I32, i32, simm7, uimm6>;

// Section 8.4.15 - CPS (Compare Single)
defm CMPSWSX : RRNCm<"cmps.w.sx", 0x7A, I32, i32, simm7, uimm6>;
let cx = 1 in defm CMPSWZX : RRNCm<"cmps.w.zx", 0x7A, I32, i32, simm7, uimm6>;

// Section 8.4.16 - CPX (Compare)
defm CMPSL : RRNCm<"cmps.l", 0x6A, I64, i64, simm7, uimm6>;

// Section 8.4.17 - CMS (Compare and Select Maximum/Minimum Single)
// cx: sx/zx, cw: max/min
defm MAXSWSX : RRm<"maxs.w.sx", 0x78, I32, i32, simm7, uimm6>;
let cx = 1 in defm MAXSWZX : RRm<"maxs.w.zx", 0x78, I32, i32, simm7, uimm6>;
let cw = 1 in defm MINSWSX : RRm<"mins.w.sx", 0x78, I32, i32, simm7, uimm6>;
let cx = 1, cw = 1 in
defm MINSWZX : RRm<"mins.w.zx", 0x78, I32, i32, simm7, uimm6>;

// Section 8.4.18 - CMX (Compare and Select Maximum/Minimum)
defm MAXSL : RRm<"maxs.l", 0x68, I64, i64, simm7, uimm6>;
let cw = 1 in defm MINSL : RRm<"mins.l", 0x68, I64, i64, simm7, uimm6>;

//-----------------------------------------------------------------------------
// Section 8.5 - Logical Operation Instructions
//-----------------------------------------------------------------------------

// Section 8.5.1 - AND (AND)
defm AND : RRm<"and", 0x44, I64, i64, simm7, uimm6, and>;
let isCodeGenOnly = 1 in
defm AND32 : RRm<"and", 0x44, I32, i32, simm7, uimm6, and>;

// Section 8.5.2 - OR (OR)
defm OR : RRm<"or", 0x45, I64, i64, simm7, uimm6, or>;
let isCodeGenOnly = 1 in
defm OR32 : RRm<"or", 0x45, I32, i32, simm7, uimm6, or>;

// Section 8.5.3 - XOR (Exclusive OR)
defm XOR : RRm<"xor", 0x46, I64, i64, simm7, uimm6, xor>;
let isCodeGenOnly = 1 in
defm XOR32 : RRm<"xor", 0x46, I32, i32, simm7, uimm6, xor>;

// Section 8.5.4 - EQV (Equivalence)
defm EQV : RRm<"eqv", 0x47, I64, i64, simm7, uimm6>;

// Section 8.5.5 - NND (Negate AND)
defm NND : RRm<"nnd", 0x54, I64, i64, simm7, uimm6>;

// Section 8.5.6 - MRG (Merge)
defm MRG : RRm<"mrg", 0x56, I64, i64, simm7, uimm6>;

// Section 8.5.7 - LDZ (Leading Zero Count)
let cy = 0, sy = 0, hasSideEffects = 0 in
multiclass RRI2m<string opcStr, bits<8>opc, RegisterClass RC, ValueType Ty,
                 SDPatternOperator OpNode = null_frag> {
  def r : RR<opc, (outs RC:$sx), (ins RC:$sz), !strconcat(opcStr, " $sx, $sz"),
             [(set Ty:$sx, (OpNode Ty:$sz))]>;
  let cz = 0, mz = 1 in
  def m0 : RR<opc, (outs RC:$sx), (ins uimm6:$sz),
              !strconcat(opcStr, " $sx, (${sz})0")>;
  let cz = 0 in
  def m1 : RR<opc, (outs RC:$sx), (ins uimm6:$sz),
              !strconcat(opcStr, " $sx, (${sz})1")>;
}
defm LDZ : RRI2m<"ldz", 0x67, I64, i64, ctlz>;

// Section 8.5.8 - PCNT (Population Count)
defm PCNT : RRI2m<"pcnt", 0x38, I64, i64, ctpop>;

// Section 8.5.9 - BRV (Bit Reverse)
defm BRV : RRI2m<"brv", 0x39, I64, i64, bitreverse>;

// Section 8.5.10 - BSWP (Byte Swap)

// Multiclass for RR type instructions
//   Used by sra, sla, sll, and similar instructions
let hasSideEffects = 0 in
multiclass RRIm<string opcStr, bits<8>opc,
                RegisterClass RC, ValueType Ty,
                SDPatternOperator OpNode = null_frag> {
  def rr : RR<opc, (outs RC:$sx), (ins RC:$sz, I32:$sy),
              !strconcat(opcStr, " $sx, $sz, $sy"),
              [(set Ty:$sx, (OpNode Ty:$sz, i32:$sy))]>;
  let cy = 0 in
  def ri : RR<opc, (outs RC:$sx), (ins RC:$sz, simm7:$sy),
              !strconcat(opcStr, " $sx, $sz, $sy"),
              [(set Ty:$sx, (OpNode Ty:$sz, (i32 simm7:$sy)))]>;
  let cz = 0, mz = 1 in
  def m0r : RR<opc, (outs RC:$sx), (ins uimm6:$sz, I32:$sy),
               !strconcat(opcStr, " $sx, (${sz})0, $sy")>;
  let cz = 0 in
  def m1r : RR<opc, (outs RC:$sx), (ins uimm6:$sz, I32:$sy),
               !strconcat(opcStr, " $sx, (${sz})1, $sy")>;
  let cy = 0, cz = 0, mz = 1 in
  def m0i : RR<opc, (outs RC:$sx), (ins uimm6:$sz, simm7:$sy),
               !strconcat(opcStr, " $sx, (${sz})0, $sy")>;
  let cy = 0, cz = 0 in
  def m1i : RR<opc, (outs RC:$sx), (ins uimm6:$sz, simm7:$sy),
               !strconcat(opcStr, " $sx, (${sz})1, $sy")>;
}

defm BSWP : RRIm<"bswp", 0x2B, I64, i64>;

// Section 8.5.11 - CMOV (Conditional Move)
let Constraints = "$sx = $sd", DisableEncoding = "$sd", hasSideEffects = 0,
    cfw = ? in
multiclass RRCMOVm<string opcStr, bits<8>opc, RegisterClass RC, ValueType Ty> {
  def rr : RR<opc, (outs I64:$sx), (ins CCOpDot:$cfw, RC:$sy, I64:$sz, I64:$sd),
              !strconcat(opcStr, " $sx, $sz, $sy")>;
  let cy = 0 in
  def ir : RR<opc, (outs I64:$sx),
              (ins CCOpDot:$cfw, simm7:$sy, I64:$sz, I64:$sd),
              !strconcat(opcStr, " $sx, $sz, $sy")>;
  let cz = 0, mz = 1 in
  def rm0 : RR<opc, (outs I64:$sx),
               (ins CCOpDot:$cfw, RC:$sy, uimm6:$sz, I64:$sd),
               !strconcat(opcStr, " $sx, (${sz})0, $sy")>;
  let cz = 0 in
  def rm1 : RR<opc, (outs I64:$sx),
               (ins CCOpDot:$cfw, RC:$sy, uimm6:$sz, I64:$sd),
               !strconcat(opcStr, " $sx, (${sz})1, $sy")>;
  let cy = 0, cz = 0, mz = 1 in
  def im0 : RR<opc, (outs I64:$sx),
               (ins CCOpDot:$cfw, simm7:$sy, uimm6:$sz, I64:$sd),
               !strconcat(opcStr, " $sx, (${sz})0, $sy")>;
  let cy = 0, cz = 0 in
  def im1 : RR<opc, (outs I64:$sx),
               (ins CCOpDot:$cfw, simm7:$sy, uimm6:$sz, I64:$sd),
               !strconcat(opcStr, " $sx, (${sz})1, $sy")>;
}

let cw = 0, cw2 = 0 in defm CMOVL : RRCMOVm<"cmov.l${cfw}", 0x3B, I64, i64>;
let cw = 1, cw2 = 0 in defm CMOVW : RRCMOVm<"cmov.w${cfw}", 0x3B, I32, i32>;
let cw = 0, cw2 = 1 in defm CMOVD : RRCMOVm<"cmov.d${cfw}", 0x3B, I64, f64>;
let cw = 1, cw2 = 1 in defm CMOVS : RRCMOVm<"cmov.s${cfw}", 0x3B, F32, f32>;

//-----------------------------------------------------------------------------
// Section 8.6 - Shift Operation Instructions
//-----------------------------------------------------------------------------

// Section 8.6.1 - SLL (Shift Left Logical)
defm SLL : RRIm<"sll", 0x65, I64, i64, shl>;

// Section 8.6.2 - SLD (Shift Left Double)
defm SLD : RRIm<"sld", 0x64, I64, i64>;

// Section 8.6.3 - SRL (Shift Right Logical)
defm SRL : RRIm<"srl", 0x75, I64, i64, srl>;

// Section 8.6.4 - SRD (Shift Right Double)
defm SRD : RRIm<"srd", 0x74, I64, i64>;

// Section 8.6.5 - SLA (Shift Left Arithmetic)
defm SLAWSX : RRIm<"sla.w.sx", 0x66, I32, i32, shl>;
let cx = 1 in defm SLAWZX : RRIm<"sla.w.zx", 0x66, I32, i32>;

// Section 8.6.6 - SLAX (Shift Left Arithmetic)
defm SLAL : RRIm<"sla.l", 0x57, I64, i64>;

// Section 8.6.7 - SRA (Shift Right Arithmetic)
defm SRAWSX : RRIm<"sra.w.sx", 0x76, I32, i32, sra>;
let cx = 1 in defm SRAWZX : RRIm<"sra.w.zx", 0x76, I32, i32>;

// Section 8.6.8 - SRAX (Shift Right Arithmetic)
defm SRAL : RRIm<"sra.l", 0x77, I64, i64, sra>;

def : Pat<(i32 (srl i32:$src, (i32 simm7:$val))),
          (EXTRACT_SUBREG (SRLri (ANDrm0 (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
            $src, sub_i32), 32), imm:$val), sub_i32)>;
def : Pat<(i32 (srl i32:$src, i32:$val)),
          (EXTRACT_SUBREG (SRLrr (ANDrm0 (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
            $src, sub_i32), 32), $val), sub_i32)>;

//-----------------------------------------------------------------------------
// Section 8.7 - Floating-point Arithmetic Instructions
//-----------------------------------------------------------------------------

// Section 8.7.1 - FAD (Floating Add)
defm FADDD : RRFm<"fadd.d", 0x4C, I64, f64, simm7, uimm6, fadd>;
let cx = 1 in defm FADDS : RRFm<"fadd.s", 0x4C, F32, f32, simm7, uimm6, fadd>;

// Section 8.7.2 - FSB (Floating Subtract)
defm FSUBD : RRFm<"fsub.d", 0x5C, I64, f64, simm7, uimm6, fsub>;
let cx = 1 in defm FSUBS : RRFm<"fsub.s", 0x5C, F32, f32, simm7, uimm6, fsub>;

// Section 8.7.3 - FMP (Floating Multiply)
defm FMULD : RRFm<"fmul.d", 0x4D, I64, f64, simm7, uimm6, fmul>;
let cx = 1 in defm FMULS : RRFm<"fmul.s", 0x4D, F32, f32, simm7, uimm6, fmul>;

// Section 8.7.4 - FDV (Floating Divide)
defm FDIVD : RRFm<"fdiv.d", 0x5D, I64, f64, simm7, uimm6, fdiv>;
let cx = 1 in defm FDIVS : RRFm<"fdiv.s", 0x5D, F32, f32, simm7, uimm6, fdiv>;

// Section 8.7.5 - FCP (Floating Compare)
defm FCMPD : RRFm<"fcmp.d", 0x7E, I64, f64, simm7, uimm6>;
let cx = 1 in defm FCMPS : RRFm<"fcmp.s", 0x7E, F32, f32, simm7, uimm6>;

// Section 8.7.6 - CMS (Compare and Select Maximum/Minimum Single)
// cx: double/float, cw: max/min
defm FMAXD : RRFm<"fmax.d", 0x3E, I64, f64, simm7, uimm6>;
let cx = 1 in defm FMAXS : RRFm<"fmax.s", 0x3E, F32, f32, simm7, uimm6>;
let cw = 1 in defm FMIND : RRFm<"fmin.d", 0x3E, I64, f64, simm7, uimm6>;
let cw = 1, cx = 1 in defm FMINS : RRFm<"fmin.s", 0x3E, F32, f32, simm7, uimm6>;

// Section 8.7.7 - FAW (Floating Add Quadruple)
defm FADDQ : RRFm<"fadd.q", 0x6C, F128, f128, simm7, uimm6, fadd>;

// Section 8.7.8 - FSQ (Floating Subtract Quadruple)
defm FSUBQ : RRFm<"fsub.q", 0x7C, F128, f128, simm7, uimm6, fsub>;

// Section 8.7.9 - FMQ (Floating Subtract Quadruple)
defm FMULQ : RRFm<"fmul.q", 0x6D, F128, f128, simm7, uimm6, fmul>;

// Section 8.7.10 - FCQ (Floating Compare Quadruple)
defm FCMPQ : RRFCQm<"fcmp.q", 0x7D, F128, f128, simm7, uimm6>;

// Multiclass for floating point conversion instructions.
//   Used by CVS/CVD/FLT and others
// sz{3-0} = rounding mode
let cz = 0, hasSideEffects = 0 in
multiclass CVTRDm<string opcStr, bits<8> opc, RegisterClass RCo, ValueType Tyo,
                  RegisterClass RCi, ValueType Tyi> {
  def r : RR<opc, (outs RCo:$sx), (ins RDOp:$rd, RCi:$sy),
             !strconcat(opcStr, "${rd} $sx, $sy")> {
    bits<4> rd;
    let sz{5-4} = 0;
    let sz{3-0} = rd;
  }
  let cy = 0 in
  def i : RR<opc, (outs RCo:$sx), (ins RDOp:$rd, simm7:$sy),
             !strconcat(opcStr, "${rd} $sx, $sy")> {
    bits<4> rd;
    let sz{5-4} = 0;
    let sz{3-0} = rd;
  }
}

// Section 8.7.11 - FIX (Convert to Fixed Point)
// cx: double/float, cw: sx/zx, sz{0-3} = round
let cx = 0, cw = 0 /* sign extend */ in
defm CVTWDSX : CVTRDm<"cvt.w.d.sx", 0x4E, I32, i32, I64, f64>;
let cx = 0, cw = 1 /* zero extend */ in
defm CVTWDZX : CVTRDm<"cvt.w.d.zx", 0x4E, I32, i32, I64, f64>;
let cx = 1, cw = 0 /* sign extend */ in
defm CVTWSSX : CVTRDm<"cvt.w.s.sx", 0x4E, I32, i32, F32, f32>;
let cx = 1, cw = 1 /* zero extend */ in
defm CVTWSZX : CVTRDm<"cvt.w.s.zx", 0x4E, I32, i32, F32, f32>;
def : Pat<(i32 (fp_to_sint I64:$reg)), (CVTWDSXr RD_RZ, $reg)>;
def : Pat<(i32 (fp_to_sint F32:$reg)), (CVTWSSXr RD_RZ, $reg)>;

// Section 8.7.12 - FIXX (Convert to Fixed Point)
defm CVTLD : CVTRDm<"cvt.l.d", 0x4F, I64, i64, I64, f64>;
def : Pat<(i64 (fp_to_sint I64:$reg)), (CVTLDr RD_RZ, $reg)>;

let cz = 0, sz = 0, hasSideEffects = 0 in
multiclass CVTm<string opcStr, bits<8> opc, RegisterClass RCo, ValueType Tyo,
                RegisterClass RCi, ValueType Tyi,
                SDPatternOperator OpNode = null_frag> {
  def r : RR<opc, (outs RCo:$sx), (ins RCi:$sy),
             !strconcat(opcStr, " $sx, $sy"),
             [(set Tyo:$sx, (OpNode Tyi:$sy))]>;
  let cy = 0 in
  def i : RR<opc, (outs RCo:$sx), (ins simm7:$sy),
             !strconcat(opcStr, " $sx, $sy")>;
}

// Section 8.7.13 - FLT (Convert to Floating Point)
defm CVTDW : CVTm<"cvt.d.w", 0x5E, I64, f64, I32, i32, sint_to_fp>;
let cx = 1 in
defm CVTSW : CVTm<"cvt.s.w", 0x5E, F32, f32, I32, i32, sint_to_fp>;

// Section 8.7.14 - FLTX (Convert to Floating Point)
defm CVTDL : CVTm<"cvt.d.l", 0x5F, I64, f64, I64, i64, sint_to_fp>;

// Section 8.7.15 - CVS (Convert to Single-format)
let cx = 0 in
defm CVTSD : CVTm<"cvt.s.d", 0x1F, F32, f32, I64, f64, fpround>;
let cx = 1 in
defm CVTSQ : CVTm<"cvt.s.q", 0x1F, F32, f32, F128, f128, fpround>;

// Section 8.7.16 - CVD (Convert to Double-format)
defm CVTDS : CVTm<"cvt.d.s", 0x0F, I64, f64, F32, f32, fpextend>;
let cx = 1 in
defm CVTDQ : CVTm<"cvt.d.q", 0x0F, I64, f64, F128, f128, fpround>;

// Section 8.7.17 - CVQ (Convert to Single-format)
defm CVTQD : CVTm<"cvt.q.d", 0x2D, F128, f128, I64, f64, fpextend>;
let cx = 1 in
defm CVTQS : CVTm<"cvt.q.s", 0x2D, F128, f128, F32, f32, fpextend>;

//-----------------------------------------------------------------------------
// Section 8.8 - Branch instructions
//-----------------------------------------------------------------------------

// Branch multiclass
let isBranch = 1, isTerminator = 1, isIndirectBranch = 1 in
multiclass BCbpfm<string opcStr, string cmpStr, bits<8> opc, dag cond,
                  Operand ADDR> {
  let bpf = 0 /* NONE */ in
  def "" : CF<opc, (outs), !con(cond, (ins ADDR:$addr)),
              !strconcat(opcStr, " ", cmpStr, "$addr")>;
  let bpf = 2 /* NOT TaKEN */ in
  def _nt : CF<opc, (outs), !con(cond, (ins ADDR:$addr)),
               !strconcat(opcStr, ".nt ", cmpStr, "$addr")>;
  let bpf = 3 /* TaKEN */ in
  def _t : CF<opc, (outs), !con(cond, (ins ADDR:$addr)),
              !strconcat(opcStr, ".t ", cmpStr, "$addr")>;
}
multiclass BCtgm<string opcStr, string cmpStr, bits<8> opc, dag cond> {
  defm ri : BCbpfm<opcStr, cmpStr, opc, cond, MEMriASX>;
  let cz = 0 in defm zi : BCbpfm<opcStr, cmpStr, opc, cond, MEMziASX>;
}
multiclass BCm<string opcStr, string opcStrAt, string opcStrAf, bits<8> opc,
               RegisterClass RC, Operand immOp> {
  let DecoderMethod = "DecodeBranchCondition" in
  defm r : BCtgm<opcStr, "$comp, ", opc, (ins CCOp:$cond, RC:$comp)>;
  let DecoderMethod = "DecodeBranchCondition", cy = 0 in
  defm i : BCtgm<opcStr, "$comp, ", opc, (ins CCOp:$cond, immOp:$comp)>;
  let DecoderMethod = "DecodeBranchConditionAlways", cy = 0, sy = 0,
      cf = 15 /* AT */, isBarrier = 1 in
  defm a : BCtgm<opcStrAt, "", opc, (ins)>;
  let DecoderMethod = "DecodeBranchConditionAlways", cy = 0, sy = 0,
      cf = 0 /* AF */ in
  defm na : BCtgm<opcStrAf, "", opc, (ins)>;
}

// Branch relative multiclass
let isBranch = 1, isTerminator = 1 in
multiclass BCRbpfm<string opcStr, string cmpStr, bits<8> opc, dag cond> {
  let bpf = 0 /* NONE */ in
  def "" : CF<opc, (outs), !con(cond, (ins brtarget32:$imm32)),
              !strconcat(opcStr, " ", cmpStr, "$imm32")>;
  let bpf = 2 /* NOT TaKEN */ in
  def _nt : CF<opc, (outs), !con(cond, (ins brtarget32:$imm32)),
               !strconcat(opcStr, ".nt ", cmpStr, "$imm32")>;
  let bpf = 3 /* TaKEN */ in
  def _t : CF<opc, (outs), !con(cond, (ins brtarget32:$imm32)),
              !strconcat(opcStr, ".t ", cmpStr, "$imm32")>;
}
multiclass BCRm<string opcStr, string opcStrAt, string opcStrAf, bits<8> opc,
               RegisterClass RC, Operand immOp> {
  defm rr : BCRbpfm<opcStr, "$sy, $sz, ", opc, (ins CCOp:$cf, RC:$sy, RC:$sz)>;
  let cy = 0 in
  defm ir : BCRbpfm<opcStr, "$sy, $sz, ", opc, (ins CCOp:$cf, immOp:$sy, RC:$sz)>;
  let cy = 0, sy = 0, cz = 0, sz = 0, cf = 15 /* AT */, isBarrier = 1 in
  defm a : BCRbpfm<opcStrAt, "", opc, (ins)>;
  let cy = 0, sy = 0, cz = 0, sz = 0, cf = 0 /* AF */ in
  defm na : BCRbpfm<opcStrAf, "", opc, (ins)>;
}

// Section 8.8.1 - BC (Branch on Codition)
defm BCFL : BCm<"b${cond}.l", "b.l", "baf.l", 0x19, I64, simm7>;

// Indirect branch aliases
def : Pat<(brind I64:$reg), (BCFLari_t $reg, 0)>;
def : Pat<(brind tblockaddress:$imm), (BCFLazi_t 0, $imm)>;

// Return instruction is a special case of jump.
let Uses = [SX10], bpf = 3 /* TAKEN */, cf = 15 /* AT */, cy = 0, sy = 0,
    sz = 10 /* SX10 */, imm32 = 0, isReturn = 1, isTerminator = 1,
    isBarrier = 1, isCodeGenOnly = 1 in
def RET : CF<0x19, (outs), (ins), "b.l.t (, %lr)", [(retflag)]>;

// Section 8.8.2 - BCS (Branch on Condition Single)
defm BCFW : BCm<"b${cond}.w", "b.w", "baf.w", 0x1B, I32, simm7>;

// Section 8.8.3 - BCF (Branch on Condition Floating Point)
defm BCFD : BCm<"b${cond}.d", "b.d", "baf.d", 0x1C, I64, simm7>;
let cx = 1 in
defm BCFS : BCm<"b${cond}.s", "b.s", "baf.s", 0x1C, F32, simm7>;

// Section 8.8.4 - BCR (Branch on Condition Relative)
let cx = 0, cx2 = 0 in
defm BRCFL : BCRm<"br${cf}.l", "br.l", "braf.l", 0x18, I64, simm7>;
let cx = 1, cx2 = 0 in
defm BRCFW : BCRm<"br${cf}.w", "br.w", "braf.w", 0x18, I32, simm7>;
let cx = 0, cx2 = 1 in
defm BRCFD : BCRm<"br${cf}.d", "br.d", "braf.d", 0x18, I64, simm7>;
let cx = 1, cx2 = 1 in
defm BRCFS : BCRm<"br${cf}.s", "br.s", "braf.s", 0x18, F32, simm7>;

// Section 8.8.5 - BSIC (Branch and Save IC)
let isCall = 1, hasSideEffects = 0 /* , Uses = [IC] */ in
defm BSIC : RMm<"bsic", 0x08, I64>;

// Call instruction is a special case of BSIC.
let Defs = [SX10], sx = 10 /* SX10 */, cy = 0, sy = 0, imm32 = 0,
    isCall = 1, isCodeGenOnly = 1, hasSideEffects = 0 in
def CALLr : RM<0x08, (outs), (ins I64:$sz, variable_ops),
               "bsic %s10, (, $sz)", [(call i64:$sz)]>;

// Load and Store host memory instructions
let cx = 0, cz = 1, hasSideEffects = 0 in {
let ry = 3, DecoderMethod = "DecodeLoadASI64" in
def LHMri : RRMHM<0x21, (outs I64:$dest), (ins MEMriHM:$addr),
                  "lhm.l $dest, $addr">;
let ry = 2, DecoderMethod = "DecodeLoadASI32" in
def LHMLri : RRMHM<0x21, (outs I32:$dest), (ins MEMriHM:$addr),
                   "lhm.w $dest, $addr">;
let ry = 1, DecoderMethod = "DecodeLoadASI16" in
def LHM2Bri : RRMHM<0x21, (outs I16:$dest), (ins MEMriHM:$addr),
                    "lhm.h $dest, $addr">;
let ry = 0, DecoderMethod = "DecodeLoadASI8" in
def LHM1Bri : RRMHM<0x21, (outs I8:$dest), (ins MEMriHM:$addr),
                    "lhm.b $dest, $addr">;
}

let cx = 0, cz = 1, hasSideEffects = 0 in {
let ry = 3, DecoderMethod = "DecodeStoreASI64" in
def SHMri : RRMHM<0x31, (outs), (ins MEMriHM:$addr, I64:$sx),
                  "shm.l $sx, $addr">;
let ry = 2, DecoderMethod = "DecodeStoreASI32" in
def SHMLri : RRMHM<0x31, (outs), (ins MEMriHM:$addr, I32:$sx),
                   "shm.w $sx, $addr">;
let ry = 1, DecoderMethod = "DecodeStoreASI16" in
def SHM2Bri : RRMHM<0x31, (outs), (ins MEMriHM:$addr, I16:$sx),
                    "shm.h $sx, $addr">;
let ry = 0, DecoderMethod = "DecodeStoreASI8" in
def SHM1Bri : RRMHM<0x31, (outs), (ins MEMriHM:$addr, I8:$sx),
                    "shm.b $sx, $addr">;
}

let cx = 0, sx = 0, cy = 0, sy = 0, cz = 0, sz = 0, hasSideEffects = 0 in
def MONC : RR<
    0x3F, (outs), (ins),
    "monc">;

let cx = 1, sx = 0, cy = 0, sy = 0, cz = 0, sz = 0, hasSideEffects = 0 in
def MONCT : RR<
    0x3F, (outs), (ins),
    "monc.hdb">;

// Save Instruction Counter

let cx = 0, cy = 0, sy = 0, cz = 0, sz = 0, hasSideEffects = 0 /* , Uses = [IC] */ in
def SIC : RR<0x28, (outs I32:$sx), (ins), "sic $sx">;

// Atomic swap
//   AND $newsrc, $src, -4      ; 4 byte align address
//   AND $frac, $src, 3         ; $src position in $newsrc
//   ADD $flag, 0, 1            ; set 1
//   SLA $flag, $flag, $frac    ; shift 1 for 1byte ts1am
//   SLA $tmp, $flac, 3         ; calc shift bits for next SLA
//   SLA $new, $new, $tmp       ; shift $new for 1byte ts1am
//   TS1AM $new, 0($newsrc), $flag ; 1byte ts1am
def : Pat<(i32 (atomic_swap_8 i64:$src, i32:$new)),
          (SRAWSXri
            (SLAWSXrr
              (TS1AMWrir
                (ANDri $src, -4),
                0,
                (SLAWSXm0r 63,
                          (AND32ri (EXTRACT_SUBREG $src, sub_i32), 3)),
                (SLAWSXrr $new,
                          (SLAWSXri (AND32ri (EXTRACT_SUBREG $src, sub_i32), 3), 3))),
              (SUBSWSXir 24,
                (SLAWSXri (AND32ri (EXTRACT_SUBREG $src, sub_i32), 3), 3))),
            24
          )>;
// def : Pat<(i32 (atomic_swap_16 ADDRri:$src, i32:$new)),
//           (TS1AMWrir MEMriRRM:$src, 3, $new)>;
def : Pat<(i32 (atomic_swap_32 ADDRri:$src, i32:$new)),
          (TS1AMWrir MEMriRRM:$src, 15, $new)>;
def : Pat<(i64 (atomic_swap_64 ADDRri:$src, i64:$new)),
          (TS1AMLrir MEMriRRM:$src, 127, $new)>;

// Atomic cmp and swap
def : Pat<(i32 (atomic_cmp_swap_32 ADDRri:$src, i32:$cmp, i32:$new)),
          (CASWrir MEMriRRM:$src, $cmp, $new)>;
def : Pat<(i64 (atomic_cmp_swap_64 ADDRri:$src, i64:$cmp, i64:$new)),
          (CASLrir MEMriRRM:$src, $cmp, $new)>;

// Fence

def : Pat<(int_ve_fencem1), (FENCEM 1)>;
def : Pat<(int_ve_fencem2), (FENCEM 2)>;
def : Pat<(int_ve_fencem3), (FENCEM 3)>;

// MEMBARRIER
let hasSideEffects = 1 in
def MEMBARRIER : Pseudo<(outs), (ins), "# MEMBARRIER",
                       [(MemBarrier)] >;

//===----------------------------------------------------------------------===//
// SJLJ Exception handling intrinsics
//===----------------------------------------------------------------------===//

let hasSideEffects = 1, isBarrier = 1, isCodeGenOnly = 1,
    usesCustomInserter = 1 in {
  def EH_SjLj_SetJmp  : Pseudo<(outs I32:$dst), (ins I64:$buf),
                               "# EH_SJLJ_SETJMP",
                               [(set I32:$dst, (VEeh_sjlj_setjmp I64:$buf))]>;
  let isTerminator = 1 in {
  def EH_SjLj_LongJmp : Pseudo<(outs), (ins I64:$buf),
                               "# EH_SJLJ_LONGJMP",
                               [(VEeh_sjlj_longjmp I64:$buf)]>;
  }
}

let isBarrier = 1, hasSideEffects = 1, usesCustomInserter = 1 in
  def EH_SjLj_Setup_Dispatch : Pseudo<(outs), (ins), "# EH_SJLJ_SETUP_DISPATCH",
                                      [(VEeh_sjlj_setup_dispatch)]>;

let isBranch = 1, isTerminator = 1, isCodeGenOnly = 1 in
  def EH_SjLj_Setup : Pseudo<(outs), (ins brtarget32:$dst),
                             "# EH_SJlJ_SETUP $dst">;

//===----------------------------------------------------------------------===//
// Dummy instruction for CPU flow control
//===----------------------------------------------------------------------===//

let mayLoad = 1, mayStore = 0, hasSideEffects = 1, isTrap = 1 in {
  def TRAP    : Pseudo<(outs), (ins), "# TRAP", [(trap)]>;
}

//===----------------------------------------------------------------------===//
// Pattern Matchings
//===----------------------------------------------------------------------===//

// Small immediates.
def : Pat<(i32 simm7:$val), (OR32im1 (LO7 $val), 0)>;
def : Pat<(i64 simm7:$val), (ORim1 (LO7 $val), 0)>;
// Medium immediates.
def : Pat<(i32 simm32:$val), (LEA32zii 0, 0, (LO32 $val))>;
def : Pat<(i64 simm32:$val), (LEAzii 0, 0, (LO32 $val))>;
def : Pat<(i64 uimm32:$val), (ANDrm0 (LEAzii 0, 0, (LO32 $val)), 32)>;
// Arbitrary immediates.
def : Pat<(i64 lozero:$val),
          (LEASLzii 0, 0, (HI32 imm:$val))>;
def : Pat<(i64 lomsbzero:$val),
          (LEASLrii (LEAzii 0, 0, (LO32 imm:$val)), 0, (HI32 imm:$val))>;
def : Pat<(i64 imm:$val),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, (LO32 imm:$val)), 32), 0,
                    (HI32 imm:$val))>;

// floating point
def : Pat<(f32 fpimm:$val),
          (COPY_TO_REGCLASS (LEASLzii 0, 0, (LOFP32 $val)), F32)>;
def : Pat<(f64 fplozero:$val),
          (LEASLzii 0, 0, (HIFP32 $val))>;
def : Pat<(f64 fplomsbzero:$val),
          (LEASLrii (LEAzii 0, 0, (LOFP32 $val)), 0, (HIFP32 $val))>;
def : Pat<(f64 fpimm:$val),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, (LOFP32 $val)), 32), 0,
                    (HIFP32 $val))>;

// The same integer registers are used for i32 and i64 values.
// When registers hold i32 values, the high bits are unused.

// TODO Use standard expansion for shift-based lowering of sext_inreg

// Cast to i1
def : Pat<(sext_inreg I32:$src, i1),
          (SRAWSXri (SLAWSXri $src, 31), 31)>;
def : Pat<(sext_inreg I64:$src, i1),
          (SRALri (SLLri $src, 63), 63)>;

// Cast to i8
def : Pat<(sext_inreg I32:$src, i8),
          (SRAWSXri (SLAWSXri $src, 24), 24)>;
def : Pat<(sext_inreg I64:$src, i8),
          (SRALri (SLLri $src, 56), 56)>;
def : Pat<(sext_inreg (i32 (trunc i64:$src)), i8),
          (EXTRACT_SUBREG (SRALri (SLLri $src, 56), 56), sub_i32)>;
def : Pat<(and (trunc i64:$src), 0xff),
          (AND32rm0 (EXTRACT_SUBREG $src, sub_i32), 56)>;

// Cast to i16
def : Pat<(sext_inreg I32:$src, i16),
          (SRAWSXri (SLAWSXri $src, 16), 16)>;
def : Pat<(sext_inreg I64:$src, i16),
          (SRALri (SLLri $src, 48), 48)>;
def : Pat<(sext_inreg (i32 (trunc i64:$src)), i16),
          (EXTRACT_SUBREG (SRALri (SLLri $src, 48), 48), sub_i32)>;
def : Pat<(and (trunc i64:$src), 0xffff),
          (AND32rm0 (EXTRACT_SUBREG $src, sub_i32), 48)>;

// Cast to i32
def : Pat<(i32 (trunc i64:$src)),
          (ADDSWSXrm1 (EXTRACT_SUBREG $src, sub_i32), 0)>;
def : Pat<(i32 (fp_to_sint f128:$sy)), (CVTWDSXr RD_RZ, (CVTDQr $sy))>;

// Cast to i64
def : Pat<(sext_inreg I64:$src, i32),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
            (ADDSWSXrm1 (EXTRACT_SUBREG $src, sub_i32), 0), sub_i32)>;
def : Pat<(i64 (sext i32:$sy)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (ADDSWSXrm1 $sy, 0), sub_i32)>;
def : Pat<(i64 (zext i32:$sy)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (ADDSWZXrm1 $sy, 0), sub_i32)>;
def : Pat<(i64 (fp_to_sint f32:$sy)), (CVTLDr RD_RZ, (CVTDSr $sy))>;
def : Pat<(i64 (fp_to_sint f128:$sy)), (CVTLDr RD_RZ, (CVTDQr $sy))>;

// Cast to f32
def : Pat<(f32 (sint_to_fp i64:$sy)), (CVTSDr (CVTDLr i64:$sy))>;

// Cast to f128
def : Pat<(f128 (sint_to_fp i32:$sy)), (CVTQDr (CVTDWr $sy))>;
def : Pat<(f128 (sint_to_fp i64:$sy)), (CVTQDr (CVTDLr $sy))>;

def : Pat<(i64 (anyext i32:$sy)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32)>;

// extload, sextload and zextload stuff
multiclass EXT64m<SDPatternOperator from,
                  SDPatternOperator torri,
                  SDPatternOperator torii,
                  SDPatternOperator tozri,
                  SDPatternOperator tozii> {
  def : Pat<(i64 (from ADDRrri:$addr)),
            (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (torri MEMrri:$addr),
                           sub_i32)>;
  def : Pat<(i64 (from ADDRrii:$addr)),
            (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (torii MEMrii:$addr),
                           sub_i32)>;
  def : Pat<(i64 (from ADDRzri:$addr)),
            (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (tozri MEMzri:$addr),
                           sub_i32)>;
  def : Pat<(i64 (from ADDRzii:$addr)),
            (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (tozii MEMzii:$addr),
                           sub_i32)>;
}
defm : EXT64m<sextloadi8, LD1BSXrri, LD1BSXrii, LD1BSXzri, LD1BSXzii>;
defm : EXT64m<zextloadi8, LD1BZXrri, LD1BZXrii, LD1BZXzri, LD1BZXzii>;
defm : EXT64m<extloadi8, LD1BZXrri, LD1BZXrii, LD1BZXzri, LD1BZXzii>;
defm : EXT64m<sextloadi16, LD2BSXrri, LD2BSXrii, LD2BSXzri, LD2BSXzii>;
defm : EXT64m<zextloadi16, LD2BZXrri, LD2BZXrii, LD2BZXzri, LD2BZXzii>;
defm : EXT64m<extloadi16, LD2BZXrri, LD2BZXrii, LD2BZXzri, LD2BZXzii>;
defm : EXT64m<sextloadi32, LDLSXrri, LDLSXrii, LDLSXzri, LDLSXzii>;
defm : EXT64m<zextloadi32, LDLZXrri, LDLZXrii, LDLZXzri, LDLZXzii>;
defm : EXT64m<extloadi32, LDLSXrri, LDLSXrii, LDLSXzri, LDLSXzii>;

// anyextload
multiclass EXT32m<SDPatternOperator from,
                  SDPatternOperator torri,
                  SDPatternOperator torii,
                  SDPatternOperator tozri,
                  SDPatternOperator tozii> {
  def : Pat<(from ADDRrri:$addr), (torri MEMrri:$addr)>;
  def : Pat<(from ADDRrii:$addr), (torii MEMrii:$addr)>;
  def : Pat<(from ADDRzri:$addr), (tozri MEMzri:$addr)>;
  def : Pat<(from ADDRzii:$addr), (tozii MEMzii:$addr)>;
}
defm : EXT32m<extloadi8, LD1BZXrri, LD1BZXrii, LD1BZXzri, LD1BZXzii>;
defm : EXT32m<extloadi16, LD2BZXrri, LD2BZXrii, LD2BZXzri, LD2BZXzii>;

// truncstore
multiclass TRUNC64m<SDPatternOperator from,
                    SDPatternOperator torri,
                    SDPatternOperator torii,
                    SDPatternOperator tozri,
                    SDPatternOperator tozii> {
  def : Pat<(from i64:$src, ADDRrri:$addr),
            (torri MEMrri:$addr, (EXTRACT_SUBREG $src, sub_i32))>;
  def : Pat<(from i64:$src, ADDRrii:$addr),
            (torii MEMrii:$addr, (EXTRACT_SUBREG $src, sub_i32))>;
  def : Pat<(from i64:$src, ADDRzri:$addr),
            (tozri MEMzri:$addr, (EXTRACT_SUBREG $src, sub_i32))>;
  def : Pat<(from i64:$src, ADDRzii:$addr),
            (tozii MEMzii:$addr, (EXTRACT_SUBREG $src, sub_i32))>;
}
defm : TRUNC64m<truncstorei8, ST1Brri, ST1Brii, ST1Bzri, ST1Bzii>;
defm : TRUNC64m<truncstorei16, ST2Brri, ST2Brii, ST2Bzri, ST2Bzii>;
defm : TRUNC64m<truncstorei32, STLrri, STLrii, STLzri, ST1Bzii>;

// Atomic loads
multiclass ATMLDm<SDPatternOperator from,
                  SDPatternOperator torri,
                  SDPatternOperator torii,
                  SDPatternOperator tozri,
                  SDPatternOperator tozii> {
  def : Pat<(from ADDRrri:$addr), (torri MEMrri:$addr)>;
  def : Pat<(from ADDRrii:$addr), (torii MEMrii:$addr)>;
  def : Pat<(from ADDRzri:$addr), (tozri MEMzri:$addr)>;
  def : Pat<(from ADDRzii:$addr), (tozii MEMzii:$addr)>;
}
defm : ATMLDm<atomic_load_8, LD1BZXrri, LD1BZXrii, LD1BZXzri, LD1BZXzii>;
defm : ATMLDm<atomic_load_16, LD2BZXrri, LD2BZXrii, LD2BZXzri, LD2BZXzii>;
defm : ATMLDm<atomic_load_32, LDLZXrri, LDLZXrii, LDLZXzri, LDLZXzii>;
defm : ATMLDm<atomic_load_64, LDrri, LDrii, LDzri, LDzii>;

// Atomic stores
multiclass ATMSTm<SDPatternOperator from,
                  ValueType ty,
                  SDPatternOperator torri,
                  SDPatternOperator torii,
                  SDPatternOperator tozri,
                  SDPatternOperator tozii> {
  def : Pat<(from ADDRrri:$addr, ty:$src), (torri MEMrri:$addr, $src)>;
  def : Pat<(from ADDRrii:$addr, ty:$src), (torii MEMrii:$addr, $src)>;
  def : Pat<(from ADDRzri:$addr, ty:$src), (tozri MEMzri:$addr, $src)>;
  def : Pat<(from ADDRzii:$addr, ty:$src), (tozii MEMzii:$addr, $src)>;
}
defm : ATMSTm<atomic_store_8, i32, ST1Brri, ST1Brii, ST1Bzri, ST1Bzii>;
defm : ATMSTm<atomic_store_16, i32, ST2Brri, ST2Brii, ST2Bzri, ST2Bzii>;
defm : ATMSTm<atomic_store_32, i32, STLrri, STLrii, STLzri, STLzii>;
defm : ATMSTm<atomic_store_64, i64, STrri, STrii, STzri, STzii>;

// Address calculation and its optimization
def : Pat<(VEhi tglobaladdr:$in), (LEASLzii 0, 0, tglobaladdr:$in)>;
def : Pat<(VElo tglobaladdr:$in), (ANDrm0 (LEAzii 0, 0, tglobaladdr:$in), 32)>;
def : Pat<(add (VEhi tglobaladdr:$in1), (VElo tglobaladdr:$in2)),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, tglobaladdr:$in2), 32), 0,
                    (tglobaladdr:$in1))>;
def : Pat<(add (add (VEhi tglobaladdr:$in1), (VElo tglobaladdr:$in2)),
               simm7:$val),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, tglobaladdr:$in2), 32),
                    (LO7 $val), (tglobaladdr:$in1))>;

// GlobalTLS address calculation and its optimization
def : Pat<(VEhi tglobaltlsaddr:$in), (LEASLzii 0, 0, tglobaltlsaddr:$in)>;
def : Pat<(VElo tglobaltlsaddr:$in),
          (ANDrm0 (LEAzii 0, 0, tglobaltlsaddr:$in), 32)>;
def : Pat<(add (VEhi tglobaltlsaddr:$in1), (VElo tglobaltlsaddr:$in2)),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, tglobaltlsaddr:$in2), 32), 0,
                    (tglobaltlsaddr:$in1))>;
def : Pat<(add (add (VEhi tglobaltlsaddr:$in1), (VElo tglobaltlsaddr:$in2)),
               simm7:$val),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, tglobaltlsaddr:$in2), 32),
                    (LO7 $val), (tglobaltlsaddr:$in1))>;

// Address calculation and its optimization
def : Pat<(VEhi tconstpool:$in), (LEASLzii 0, 0, tconstpool:$in)>;
def : Pat<(VElo tconstpool:$in), (ANDrm0 (LEAzii 0, 0, tconstpool:$in), 32)>;
def : Pat<(add (VEhi tconstpool:$in1), (VElo tconstpool:$in2)),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, tconstpool:$in2), 32), 0,
                    (tconstpool:$in1))>;
def : Pat<(add (add (VEhi tconstpool:$in1), (VElo tconstpool:$in2)),
               simm7:$val),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, tconstpool:$in2), 32),
                    (LO7 $val), (tconstpool:$in1))>;

// Address calculation and its optimization
def : Pat<(VEhi texternalsym:$in), (LEASLzii 0, 0, texternalsym:$in)>;
def : Pat<(VElo texternalsym:$in),
          (ANDrm0 (LEAzii 0, 0, texternalsym:$in), 32)>;
def : Pat<(add (VEhi texternalsym:$in1), (VElo texternalsym:$in2)),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, texternalsym:$in2), 32), 0,
                    (texternalsym:$in1))>;
def : Pat<(add (add (VEhi texternalsym:$in1), (VElo texternalsym:$in2)),
               simm7:$val),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, texternalsym:$in2), 32),
                    (LO7 $val), (texternalsym:$in1))>;

// Address calculation of mcsym
def : Pat<(i64 mcsym:$src),
          (LEASLrii (ANDrm0 (LEAzii 0, 0, (LO32 mcsym:$src)), 32), 0,
                    (HI32 mcsym:$src))>;

// Address calculation and its optimization

// Branches
def : Pat<(br bb:$addr), (BRCFLa bb:$addr)>;

// brcc
// integer brcc
multiclass BRCCIm<ValueType ty, SDPatternOperator BrOpNode1,
                 SDPatternOperator BrOpNode2,
                 SDPatternOperator CmpOpNode1,
                 SDPatternOperator CmpOpNode2> {
  def : Pat<(brcc CCSIOp:$cond, ty:$l, simm7:$r, bb:$addr),
            (BrOpNode2 (icond2ccSwap $cond), (LO7 $r), $l, bb:$addr)>;
  def : Pat<(brcc CCSIOp:$cond, ty:$l, ty:$r, bb:$addr),
            (BrOpNode1 (icond2cc $cond), $l, $r, bb:$addr)>;
  def : Pat<(brcc CCUIOp:$cond, ty:$l, simm7:$r, bb:$addr),
            (BrOpNode2 (icond2cc $cond), 0, (CmpOpNode2 (LO7 $r), $l),
                       bb:$addr)>;
  def : Pat<(brcc CCUIOp:$cond, ty:$l, ty:$r, bb:$addr),
            (BrOpNode2 (icond2cc $cond), 0, (CmpOpNode1 $r, $l), bb:$addr)>;
}
defm : BRCCIm<i32, BRCFWrr, BRCFWir, CMPUWrr, CMPUWir>;
defm : BRCCIm<i64, BRCFLrr, BRCFLir, CMPULrr, CMPULir>;

// floating point brcc
multiclass BRCCFm<ValueType ty, SDPatternOperator BrOpNode1,
                 SDPatternOperator BrOpNode2> {
  def : Pat<(brcc cond:$cond, ty:$l, fpzero:$r, bb:$addr),
            (BrOpNode2 (fcond2ccSwap $cond), (LOFP32 $r), $l, bb:$addr)>;
  def : Pat<(brcc cond:$cond, ty:$l, ty:$r, bb:$addr),
            (BrOpNode1 (fcond2cc $cond), $l, $r, bb:$addr)>;
}
defm : BRCCFm<f32, BRCFSrr, BRCFSir>;
defm : BRCCFm<f64, BRCFDrr, BRCFDir>;
// FIXME: fpzero doesn't work with f128 since f128 is separated
//        to INSERT_SUBREG stuff before performing ISEL.
def : Pat<(brcc cond:$cond, f128:$l, fpzero:$r, bb:$addr),
          (BRCFDrr (fcond2cc $cond), 0, (FCMPQir (LOFP32 $r), $l), bb:$addr)>;
def : Pat<(brcc cond:$cond, f128:$l, f128:$r, bb:$addr),
          (BRCFDrr (fcond2cc $cond), 0, (FCMPQrr $r, $l), bb:$addr)>;

//===----------------------------------------------------------------------===//
// Pseudo Instructions
//===----------------------------------------------------------------------===//

// GETGOT for PIC
let Defs = [SX15 /* %got */, SX16 /* %plt */], hasSideEffects = 0 in {
  def GETGOT : Pseudo<(outs getGOT:$getpcseq), (ins), "$getpcseq">;
}

// GETFUNPLT for PIC
let hasSideEffects = 0 in
def GETFUNPLT : Pseudo<(outs I64:$dst), (ins i64imm:$addr),
                       "$dst, $addr",
                       [(set iPTR:$dst, (GetFunPLT tglobaladdr:$addr))] >;

def : Pat<(GetFunPLT tglobaladdr:$dst),
          (GETFUNPLT tglobaladdr:$dst)>;
def : Pat<(GetFunPLT texternalsym:$dst),
          (GETFUNPLT texternalsym:$dst)>;

// GETTLSADDR for TLS
let Defs = [SX0, SX10, SX12], hasSideEffects = 0 in
def GETTLSADDR : Pseudo<(outs), (ins i64imm:$addr),
                        "# GETTLSADDR $addr",
                        [(GetTLSAddr tglobaltlsaddr:$addr)] >;

def : Pat<(GetTLSAddr tglobaltlsaddr:$dst),
          (GETTLSADDR tglobaltlsaddr:$dst)>;

let Defs = [SX11], Uses = [SX11], hasSideEffects = 0 in {
def ADJCALLSTACKDOWN : Pseudo<(outs), (ins i64imm:$amt, i64imm:$amt2),
                              "# ADJCALLSTACKDOWN $amt, $amt2",
                              [(callseq_start timm:$amt, timm:$amt2)]>;
def ADJCALLSTACKUP : Pseudo<(outs), (ins i64imm:$amt1, i64imm:$amt2),
                            "# ADJCALLSTACKUP $amt1",
                            [(callseq_end timm:$amt1, timm:$amt2)]>;
}

let Defs = [SX8], Uses = [SX8, SX11], hasSideEffects = 0 in
def EXTEND_STACK : Pseudo<(outs), (ins),
                          "# EXTEND STACK",
                          []>;
let  hasSideEffects = 0 in
def EXTEND_STACK_GUARD : Pseudo<(outs), (ins),
                                "# EXTEND STACK GUARD",
                                []>;

// Dynamic stack allocation yields a __llvm_grow_stack for VE targets.
// These calls are needed to probe the stack when allocating more over
// %s8 (%sl - stack limit).

let Uses = [SX11], hasSideEffects = 1 in
def GETSTACKTOP : Pseudo<(outs I64:$dst), (ins),
                         "# GET STACK TOP",
                         [(set iPTR:$dst, (GetStackTop))]>;

// SETCC pattern matches
//
//   CMP  %tmp, lhs, rhs     ; compare lhs and rhs
//   or   %res, 0, (0)1      ; initialize by 0
//   CMOV %res, (63)0, %tmp  ; set 1 if %tmp is true

def : Pat<(i32 (setcc i64:$LHS, i64:$RHS, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrm0 (icond2cc $cond),
                        (CMPSLrr i64:$LHS, i64:$RHS),
                        63,
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc i64:$LHS, i64:$RHS, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrm0 (icond2cc $cond),
                        (CMPULrr i64:$LHS, i64:$RHS),
                        63,
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc i32:$LHS, i32:$RHS, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrm0 (icond2cc $cond),
                        (CMPSWSXrr i32:$LHS, i32:$RHS),
                        63,
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc i32:$LHS, i32:$RHS, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrm0 (icond2cc $cond),
                        (CMPUWrr i32:$LHS, i32:$RHS),
                        63,
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc f128:$LHS, f128:$RHS, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVDrm0 (fcond2cc $cond),
                        (FCMPQrr f128:$LHS, f128:$RHS),
                        63,
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc f64:$LHS, f64:$RHS, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVDrm0 (fcond2cc $cond),
                        (FCMPDrr f64:$LHS, f64:$RHS),
                        63,
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc f32:$LHS, f32:$RHS, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVSrm0 (fcond2cc $cond),
                        (FCMPSrr f32:$LHS, f32:$RHS),
                        63,
                        (ORim1 0, 0)), sub_i32)>;

// Special SELECTCC pattern matches
// Use min/max for better performance.
//
//   MAX/MIN  %res, %lhs, %rhs

def : Pat<(f64 (selectcc f64:$LHS, f64:$RHS, f64:$LHS, f64:$RHS, SETOGT)),
          (FMAXDrr $LHS, $RHS)>;
def : Pat<(f32 (selectcc f32:$LHS, f32:$RHS, f32:$LHS, f32:$RHS, SETOGT)),
          (FMAXSrr $LHS, $RHS)>;
def : Pat<(i64 (selectcc i64:$LHS, i64:$RHS, i64:$LHS, i64:$RHS, SETGT)),
          (MAXSLrr $LHS, $RHS)>;
def : Pat<(i32 (selectcc i32:$LHS, i32:$RHS, i32:$LHS, i32:$RHS, SETGT)),
          (MAXSWSXrr $LHS, $RHS)>;
def : Pat<(f64 (selectcc f64:$LHS, f64:$RHS, f64:$LHS, f64:$RHS, SETOGE)),
          (FMAXDrr $LHS, $RHS)>;
def : Pat<(f32 (selectcc f32:$LHS, f32:$RHS, f32:$LHS, f32:$RHS, SETOGE)),
          (FMAXSrr $LHS, $RHS)>;
def : Pat<(i64 (selectcc i64:$LHS, i64:$RHS, i64:$LHS, i64:$RHS, SETGE)),
          (MAXSLrr $LHS, $RHS)>;
def : Pat<(i32 (selectcc i32:$LHS, i32:$RHS, i32:$LHS, i32:$RHS, SETGE)),
          (MAXSWSXrr $LHS, $RHS)>;

def : Pat<(f64 (selectcc f64:$LHS, f64:$RHS, f64:$LHS, f64:$RHS, SETOLT)),
          (FMINDrr $LHS, $RHS)>;
def : Pat<(f32 (selectcc f32:$LHS, f32:$RHS, f32:$LHS, f32:$RHS, SETOLT)),
          (FMINSrr $LHS, $RHS)>;
def : Pat<(i64 (selectcc i64:$LHS, i64:$RHS, i64:$LHS, i64:$RHS, SETLT)),
          (MINSLrr $LHS, $RHS)>;
def : Pat<(i32 (selectcc i32:$LHS, i32:$RHS, i32:$LHS, i32:$RHS, SETLT)),
          (MINSWSXrr $LHS, $RHS)>;
def : Pat<(f64 (selectcc f64:$LHS, f64:$RHS, f64:$LHS, f64:$RHS, SETOLE)),
          (FMINDrr $LHS, $RHS)>;
def : Pat<(f32 (selectcc f32:$LHS, f32:$RHS, f32:$LHS, f32:$RHS, SETOLE)),
          (FMINSrr $LHS, $RHS)>;
def : Pat<(i64 (selectcc i64:$LHS, i64:$RHS, i64:$LHS, i64:$RHS, SETLE)),
          (MINSLrr $LHS, $RHS)>;
def : Pat<(i32 (selectcc i32:$LHS, i32:$RHS, i32:$LHS, i32:$RHS, SETLE)),
          (MINSWSXrr $LHS, $RHS)>;

// Generic SELECTCC pattern matches
//
//   CMP  %tmp, %l, %r       ; compare %l and %r
//   or   %res, %f, (0)1     ; initialize by %f
//   CMOV %res, %t, %tmp     ; set %t if %tmp is true

// selectcc for i64 result
def : Pat<(i64 (selectcc i32:$l, i32:$r, i64:$t, i64:$f, CCSIOp:$cond)),
          (CMOVWrr (icond2cc $cond), (CMPSWSXrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc i32:$l, i32:$r, i64:$t, i64:$f, CCUIOp:$cond)),
          (CMOVWrr (icond2cc $cond), (CMPUWrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc i64:$l, i64:$r, i64:$t, i64:$f, CCSIOp:$cond)),
          (CMOVLrr (icond2cc $cond), (CMPSLrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc i64:$l, i64:$r, i64:$t, i64:$f, CCUIOp:$cond)),
          (CMOVLrr (icond2cc $cond), (CMPULrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc f32:$l, f32:$r, i64:$t, i64:$f, cond:$cond)),
          (CMOVSrr (fcond2cc $cond), (FCMPSrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc f64:$l, f64:$r, i64:$t, i64:$f, cond:$cond)),
          (CMOVDrr (fcond2cc $cond), (FCMPDrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc f128:$l, f128:$r, i64:$t, i64:$f, cond:$cond)),
          (CMOVDrr (fcond2cc $cond), (FCMPQrr $l, $r), $t, $f)>;

// selectcc for i32 result
def : Pat<(i32 (selectcc i32:$l, i32:$r, i32:$t, i32:$f, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrr (icond2cc $cond),
                       (CMPSWSXrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;
def : Pat<(i32 (selectcc i32:$l, i32:$r, i32:$t, i32:$f, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrr (icond2cc $cond),
                       (CMPUWrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;
def : Pat<(i32 (selectcc i64:$l, i64:$r, i32:$t, i32:$f, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrr (icond2cc $cond),
                       (CMPSLrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;
def : Pat<(i32 (selectcc i64:$l, i64:$r, i32:$t, i32:$f, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrr (icond2cc $cond),
                       (CMPULrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;
def : Pat<(i32 (selectcc f32:$l, f32:$r, i32:$t, i32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVSrr (fcond2cc $cond),
                       (FCMPSrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;
def : Pat<(i32 (selectcc f64:$l, f64:$r, i32:$t, i32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVDrr (fcond2cc $cond),
                       (FCMPDrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;
def : Pat<(i32 (selectcc f128:$l, f128:$r, i32:$t, i32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVDrr (fcond2cc $cond),
                       (FCMPQrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;

// selectcc for f128 result
def : Pat<(f128 (selectcc i32:$l, i32:$r, f128:$t, f128:$f, CCSIOp:$cond)),
          (INSERT_SUBREG
            (INSERT_SUBREG (f128 (IMPLICIT_DEF)),
              (CMOVWrr (icond2cc $cond), (CMPSWSXrr $l, $r),
                (EXTRACT_SUBREG $t, sub_odd),
                (EXTRACT_SUBREG $f, sub_odd)), sub_odd),
            (CMOVWrr (icond2cc $cond), (CMPSWSXrr $l, $r),
              (EXTRACT_SUBREG $t, sub_even),
              (EXTRACT_SUBREG $f, sub_even)), sub_even)>;
def : Pat<(f128 (selectcc i32:$l, i32:$r, f128:$t, f128:$f, CCUIOp:$cond)),
          (INSERT_SUBREG
            (INSERT_SUBREG (f128 (IMPLICIT_DEF)),
              (CMOVWrr (icond2cc $cond), (CMPUWrr $l, $r),
                (EXTRACT_SUBREG $t, sub_odd),
                (EXTRACT_SUBREG $f, sub_odd)), sub_odd),
            (CMOVWrr (icond2cc $cond), (CMPUWrr $l, $r),
              (EXTRACT_SUBREG $t, sub_even),
              (EXTRACT_SUBREG $f, sub_even)), sub_even)>;
def : Pat<(f128 (selectcc i64:$l, i64:$r, f128:$t, f128:$f, CCSIOp:$cond)),
          (INSERT_SUBREG
            (INSERT_SUBREG (f128 (IMPLICIT_DEF)),
              (CMOVLrr (icond2cc $cond), (CMPSLrr $l, $r),
                (EXTRACT_SUBREG $t, sub_odd),
                (EXTRACT_SUBREG $f, sub_odd)), sub_odd),
            (CMOVLrr (icond2cc $cond), (CMPSLrr $l, $r),
              (EXTRACT_SUBREG $t, sub_even),
              (EXTRACT_SUBREG $f, sub_even)), sub_even)>;
def : Pat<(f128 (selectcc i64:$l, i64:$r, f128:$t, f128:$f, CCUIOp:$cond)),
          (INSERT_SUBREG
            (INSERT_SUBREG (f128 (IMPLICIT_DEF)),
              (CMOVLrr (icond2cc $cond), (CMPULrr $l, $r),
                (EXTRACT_SUBREG $t, sub_odd),
                (EXTRACT_SUBREG $f, sub_odd)), sub_odd),
            (CMOVLrr (icond2cc $cond), (CMPULrr $l, $r),
              (EXTRACT_SUBREG $t, sub_even),
              (EXTRACT_SUBREG $f, sub_even)), sub_even)>;
def : Pat<(f128 (selectcc f32:$l, f32:$r, f128:$t, f128:$f, cond:$cond)),
          (INSERT_SUBREG
            (INSERT_SUBREG (f128 (IMPLICIT_DEF)),
              (CMOVSrr (fcond2cc $cond), (FCMPSrr $l, $r),
                (EXTRACT_SUBREG $t, sub_odd),
                (EXTRACT_SUBREG $f, sub_odd)), sub_odd),
            (CMOVSrr (fcond2cc $cond), (FCMPSrr $l, $r),
              (EXTRACT_SUBREG $t, sub_even),
              (EXTRACT_SUBREG $f, sub_even)), sub_even)>;
def : Pat<(f128 (selectcc f64:$l, f64:$r, f128:$t, f128:$f, cond:$cond)),
          (INSERT_SUBREG
            (INSERT_SUBREG (f128 (IMPLICIT_DEF)),
              (CMOVDrr (fcond2cc $cond), (FCMPDrr $l, $r),
                (EXTRACT_SUBREG $t, sub_odd),
                (EXTRACT_SUBREG $f, sub_odd)), sub_odd),
            (CMOVDrr (fcond2cc $cond), (FCMPDrr $l, $r),
              (EXTRACT_SUBREG $t, sub_even),
              (EXTRACT_SUBREG $f, sub_even)), sub_even)>;
def : Pat<(f128 (selectcc f128:$l, f128:$r, f128:$t, f128:$f, cond:$cond)),
          (INSERT_SUBREG
            (INSERT_SUBREG (f128 (IMPLICIT_DEF)),
              (CMOVDrr (fcond2cc $cond), (FCMPQrr $l, $r),
                (EXTRACT_SUBREG $t, sub_odd),
                (EXTRACT_SUBREG $f, sub_odd)), sub_odd),
            (CMOVDrr (fcond2cc $cond), (FCMPQrr $l, $r),
              (EXTRACT_SUBREG $t, sub_even),
              (EXTRACT_SUBREG $f, sub_even)), sub_even)>;

// selectcc for f64 result
def : Pat<(f64 (selectcc i32:$l, i32:$r, f64:$t, f64:$f, CCSIOp:$cond)),
          (CMOVWrr (icond2cc $cond), (CMPSWSXrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc i32:$l, i32:$r, f64:$t, f64:$f, CCUIOp:$cond)),
          (CMOVWrr (icond2cc $cond), (CMPUWrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc i64:$l, i64:$r, f64:$t, f64:$f, CCSIOp:$cond)),
          (CMOVLrr (icond2cc $cond), (CMPSLrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc i64:$l, i64:$r, f64:$t, f64:$f, CCUIOp:$cond)),
          (CMOVLrr (icond2cc $cond), (CMPULrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc f32:$l, f32:$r, f64:$t, f64:$f, cond:$cond)),
          (CMOVSrr (fcond2cc $cond), (FCMPSrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc f64:$l, f64:$r, f64:$t, f64:$f, cond:$cond)),
          (CMOVDrr (fcond2cc $cond), (FCMPDrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc f128:$l, f128:$r, f64:$t, f64:$f, cond:$cond)),
          (CMOVDrr (fcond2cc $cond), (FCMPQrr $l, $r), $t, $f)>;

// selectcc for f32 result
def : Pat<(f32 (selectcc i32:$l, i32:$r, f32:$t, f32:$f, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrr (icond2cc $cond),
                       (CMPSWSXrr $l, $r),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;
def : Pat<(f32 (selectcc i32:$l, i32:$r, f32:$t, f32:$f, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrr (icond2cc $cond),
                       (CMPUWrr $l, $r),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;
def : Pat<(f32 (selectcc i64:$l, i64:$r, f32:$t, f32:$f, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrr (icond2cc $cond),
                       (CMPSLrr $l, $r),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;
def : Pat<(f32 (selectcc i64:$l, i64:$r, f32:$t, f32:$f, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrr (icond2cc $cond),
                       (CMPULrr $l, $r),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;
def : Pat<(f32 (selectcc f32:$l, f32:$r, f32:$t, f32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVSrr (fcond2cc $cond),
                       (FCMPSrr $l, $r),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;
def : Pat<(f32 (selectcc f64:$l, f64:$r, f32:$t, f32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVDrr (fcond2cc $cond),
                       (FCMPDrr $l, $r),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;
def : Pat<(f32 (selectcc f128:$l, f128:$r, f32:$t, f32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVDrr (fcond2cc $cond),
                       (FCMPQrr $l, $r),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;

// Generic SELECT pattern matches
// Use cmov.w for all cases since %pred holds i32.
//
//   CMOV.w.ne %res, %tval, %tmp  ; set tval if %tmp is true

def : Pat<(i64 (select i32:$pred, i64:$t, i64:$f)),
          (CMOVWrr CC_INE, $pred, $t, $f)>;

def : Pat<(i32 (select i32:$pred, i32:$t, i32:$f)),
          (EXTRACT_SUBREG
              (CMOVWrr CC_INE, $pred,
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;

def : Pat<(f128 (select i32:$pred, f128:$t, f128:$f)),
          (INSERT_SUBREG
            (INSERT_SUBREG (f128 (IMPLICIT_DEF)),
              (CMOVWrr CC_INE, $pred,
                (EXTRACT_SUBREG $t, sub_odd),
                (EXTRACT_SUBREG $f, sub_odd)), sub_odd),
            (CMOVWrr CC_INE, $pred,
              (EXTRACT_SUBREG $t, sub_even),
              (EXTRACT_SUBREG $f, sub_even)), sub_even)>;

def : Pat<(f64 (select i32:$pred, f64:$t, f64:$f)),
          (CMOVWrr CC_INE, $pred, $t, $f)>;

def : Pat<(f32 (select i32:$pred, f32:$t, f32:$f)),
          (EXTRACT_SUBREG
            (CMOVWrr CC_INE, $pred,
                     (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_f32),
                     (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_f32)),
            sub_f32)>;

// bitconvert
def : Pat<(f64 (bitconvert i64:$src)), (COPY_TO_REGCLASS $src, I64)>;
def : Pat<(i64 (bitconvert f64:$src)), (COPY_TO_REGCLASS $src, I64)>;

def : Pat<(i32 (bitconvert f32:$op)),
          (EXTRACT_SUBREG (SRALri (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
            $op, sub_f32), 32), sub_i32)>;
def : Pat<(f32 (bitconvert i32:$op)),
          (EXTRACT_SUBREG (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
            $op, sub_i32), 32), sub_f32)>;

// Bits operations pattern matchings.
def : Pat<(i32 (ctpop i32:$src)),
          (EXTRACT_SUBREG (PCNTr (ANDrm0 (INSERT_SUBREG
            (i64 (IMPLICIT_DEF)), $src, sub_i32), 32)), sub_i32)>;
def : Pat<(i32 (ctlz i32:$src)),
          (EXTRACT_SUBREG (LDZr (SLLri (INSERT_SUBREG
            (i64 (IMPLICIT_DEF)), $src, sub_i32), 32)), sub_i32)>;
def : Pat<(i64 (bswap i64:$src)),
          (BSWPri $src, 0)>;
def : Pat<(i32 (bswap i32:$src)),
          (EXTRACT_SUBREG (BSWPri (INSERT_SUBREG
            (i64 (IMPLICIT_DEF)), $src, sub_i32), 1), sub_i32)>;

// Several special pattern matches to optimize code

def : Pat<(i32 (and i32:$val, 0xff)), (AND32rm0 $val, 56)>;
def : Pat<(i32 (and i32:$val, 0xffff)), (AND32rm0 $val, 48)>;
def : Pat<(i64 (and i64:$val, 0xffffffff)), (ANDrm0 $val, 32)>;

// vector instructions
include "VEInstrVec.td"
include "VEInstrVecVL.td"

// generic vector instruction patterns
include "VEInstrPatternsVec.td"

// vevlintrin
include "VEInstrIntrinsicVL.td"
