//===-- VEInstrInfo.td - Target Description for VE Target -----------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
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

def simm32  : PatLeaf<(imm), [{ return isInt<32>(N->getSExtValue()); }]>;

def LO32 : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant((unsigned)(N->getZExtValue() & 0xffffffff),
                                   SDLoc(N), MVT::i32);
}]>;

def HI32 : SDNodeXForm<imm, [{
  // Transformation function: shift the immediate value down into the low bits.
  return CurDAG->getTargetConstant((unsigned)(N->getZExtValue() >> 32),
                                   SDLoc(N), MVT::i32);
}]>;

def LEASLimm : PatLeaf<(imm), [{
  return isShiftedUInt<32, 32>(N->getZExtValue());
}], HI32>;

// Addressing modes.
def ADDRrr : ComplexPattern<iPTR, 2, "SelectADDRrr", [], []>;
def ADDRri : ComplexPattern<iPTR, 2, "SelectADDRri", [frameindex], []>;

// Address operands
def VEMEMrrAsmOperand : AsmOperandClass {
  let Name = "MEMrr";
  let ParserMethod = "parseMEMOperand";
}

def VEMEMriAsmOperand : AsmOperandClass {
  let Name = "MEMri";
  let ParserMethod = "parseMEMOperand";
}

def MEMrr : Operand<iPTR> {
  let PrintMethod = "printMemOperand";
  let MIOperandInfo = (ops ptr_rc, ptr_rc);
  let ParserMatchClass = VEMEMrrAsmOperand;
}
def MEMri : Operand<iPTR> {
  let PrintMethod = "printMemOperand";
  let MIOperandInfo = (ops ptr_rc, i32imm);
  let ParserMatchClass = VEMEMriAsmOperand;
}

def TLSSym : Operand<iPTR>;

// Branch targets have OtherVT type.
def brtarget : Operand<OtherVT> {
  let EncoderMethod = "getBranchTargetOpValue";
}

def calltarget : Operand<i32> {
  let EncoderMethod = "getCallTargetOpValue";
  let DecoderMethod = "DecodeCall";
}

// Operand for printing out a condition code.
let PrintMethod = "printCCOperand" in
  def CCOp : Operand<i32>;

def VEhi    : SDNode<"VEISD::Hi", SDTIntUnaryOp>;
def VElo    : SDNode<"VEISD::Lo", SDTIntUnaryOp>;

//  These are target-independent nodes, but have target-specific formats.
def SDT_SPCallSeqStart : SDCallSeqStart<[ SDTCisVT<0, i32>,
                                          SDTCisVT<1, i32> ]>;
def SDT_SPCallSeqEnd   : SDCallSeqEnd<[ SDTCisVT<0, i32>,
                                        SDTCisVT<1, i32> ]>;

def callseq_start : SDNode<"ISD::CALLSEQ_START", SDT_SPCallSeqStart,
                           [SDNPHasChain, SDNPOutGlue]>;
def callseq_end   : SDNode<"ISD::CALLSEQ_END",   SDT_SPCallSeqEnd,
                           [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue]>;

def SDT_SPCall    : SDTypeProfile<0, -1, [SDTCisVT<0, i32>]>;
def call          : SDNode<"VEISD::CALL", SDT_SPCall,
                           [SDNPHasChain, SDNPOptInGlue, SDNPOutGlue,
                            SDNPVariadic]>;

def retflag       : SDNode<"VEISD::RET_FLAG", SDTNone,
                           [SDNPHasChain, SDNPOptInGlue, SDNPVariadic]>;

//===----------------------------------------------------------------------===//
// VE Flag Conditions
//===----------------------------------------------------------------------===//

// Note that these values must be kept in sync with the CCOp::CondCode enum
// values.
class CC_VAL<int N> : PatLeaf<(i32 N)>;
def CC_AF    : CC_VAL< 0>;  // Always false
def CC_G     : CC_VAL< 1>;  // Greater
def CC_L     : CC_VAL< 2>;  // Less
def CC_NE    : CC_VAL< 3>;  // Not Equal
def CC_E     : CC_VAL< 4>;  // Equal
def CC_GE    : CC_VAL< 5>;  // Greater or Equal
def CC_LE    : CC_VAL< 6>;  // Less or Equal
def CC_NUM   : CC_VAL< 7>;  // Number
def CC_NAN   : CC_VAL< 8>;  // NaN
def CC_GNAN  : CC_VAL< 9>;  // Greater or NaN
def CC_LNAN  : CC_VAL<10>;  // Less or NaN
def CC_NENAN : CC_VAL<11>;  // Not Equal or NaN
def CC_EQNAN : CC_VAL<12>;  // Equal or NaN
def CC_GENAN : CC_VAL<13>;  // Greater or Equal or NaN
def CC_LENAN : CC_VAL<14>;  // Less or Equal or NaN
def CC_AT    : CC_VAL<15>;  // Always true

//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

// NOP instruction
let cx = 0, sx = 0, cy = 0, sy = 0, cz = 0, sz = 0, imm32 = 0 in
def NOP : RM<0x79, (outs), (ins), "nop", []>;

// LEA instruction (load 32 bit imm to high part)
let cx = 0, cy = 0, sy = 0, cz = 1 in
def LEA : RM<
    0x06, (outs IntRegs:$sx), (ins IntRegs:$sz, i32imm:$imm32),
    "lea.sl $sx, $sz, $imm32",
    [(set i32:$sx, (or i32:$sz, simm32:$imm32))]>;

// LEA.SL instruction (load 32 bit imm to high part)
let cx = 1, cy = 0, sy = 0, cz = 1 in
def LEASL : RM<
    0x06, (outs IntRegs:$sx), (ins IntRegs:$sz, i32imm:$imm32),
    "lea.sl $sx, $sz, $imm32",
    [(set i32:$sx, (or i32:$sz, LEASLimm:$imm32))]>;

// ADS instruction
let cx = 0, cy = 1, cz = 1 in
def ADSsrr : RR<
    0x4A, (outs IntRegs:$sx), (ins IntRegs:$sy, IntRegs:$sz),
    "adds.w.sx $sx, $sy, $sz",
    [(set i32:$sx, (add i32:$sy, i32:$sz))]>;

let cx = 1, cy = 0, sy = 0, cz = 1 in
def ADSzrr : RR<
    0x4A, (outs IntRegs:$sx), (ins IntRegs:$sy, IntRegs:$sz),
    "adds.w.zx $sx, $sy, $sz",
    [(set i32:$sx, (add i32:$sy, i32:$sz))]>;

// LDS and STS instructions
// As 1st step, only uses sz and imm32 to represent $addr
let cx = 0, cy = 0, sy = 0, cz = 1 in
def LDS : RM<
    0x01, (outs IntRegs:$sx), (ins MEMri:$addr),
    "ld $sx, $addr",
    [(set i32:$sx, (load ADDRri:$addr))]>;

let cx = 0, cy = 0, sy = 0, cz = 1 in
def SDS : RM<
    0x11, (outs), (ins MEMri:$addr, IntRegs:$sx),
    "st $sx, $addr",
    [(store i32:$sx, ADDRri:$addr)]>;

let bpf = 0 /* NONE */, cf = 15 /* AT */, cy = 0, sy = 0,
    cz = 1, sz = 0x10 /* S10 */, imm32 = 0, Uses = [S10],
    isReturn = 1, isTerminator = 1, hasDelaySlot = 1, isBarrier = 1,
    isCodeGenOnly = 1 in
def RET : CF<
    0x19, (outs), (ins),
    "b.l (,%lr)",
    [(retflag)]>;

//===----------------------------------------------------------------------===//
// Pseudo Instructions
//===----------------------------------------------------------------------===//

let Defs = [S11], Uses = [S11] in {
def ADJCALLSTACKDOWN : Pseudo<(outs), (ins i32imm:$amt, i32imm:$amt2),
                              "# ADJCALLSTACKDOWN $amt, $amt2",
                              [(callseq_start timm:$amt, timm:$amt2)]>;
def ADJCALLSTACKUP : Pseudo<(outs), (ins i32imm:$amt1, i32imm:$amt2),
                            "# ADJCALLSTACKUP $amt1",
                            [(callseq_end timm:$amt1, timm:$amt2)]>;
}
