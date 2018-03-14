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

def simm7   : PatLeaf<(imm), [{ return isInt<7>(N->getSExtValue()); }]>;
def simm32  : PatLeaf<(imm), [{ return isInt<32>(N->getSExtValue()); }]>;
def uimm7   : PatLeaf<(imm), [{ return isUInt<7>(N->getZExtValue()); }]>;
def zero    : PatLeaf<(imm), [{ return N->getSExtValue() == 0; }]>;

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

// Branch targets have OtherVT type.
def brtarget32 : Operand<OtherVT> {
  let EncoderMethod = "getBranchTarget32OpValue";
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

def simm7Op32 : Operand<i32> {
  let DecoderMethod = "DecodeSIMM7";
}

def simm7Op64 : Operand<i64> {
  let DecoderMethod = "DecodeSIMM7";
}

def simm32Op64 : Operand<i64> {
  let DecoderMethod = "DecodeSIMM32";
}

def uimm7Op64 : Operand<i64> {
  let DecoderMethod = "DecodeUIMM7";
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
// VE Multiclasses for common instruction formats
//===----------------------------------------------------------------------===//

multiclass RMm<string opcStr, bits<8>opc, SDNode OpNode,
               RegisterClass RC, ValueType Ty, Operand immOp> {
  def rri : RM<
    opc, (outs RC:$sx), (ins RC:$sy, RC:$sz, simm32Op64:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}($sy, ${sz})"),
    [(set Ty:$sx, (OpNode (OpNode Ty:$sy, Ty:$sz), (Ty simm32:$imm32)))]> {
    let cy = 1;
    let cz = 1;
  }
  def rii : RM<
    opc, (outs RC:$sx), (ins RC:$sz, immOp:$sy, simm32Op64:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}($sy, ${sz})"),
    [(set Ty:$sx, (OpNode (OpNode Ty:$sz, (Ty simm7:$sy)), (Ty simm32:$imm32)))]> {
    let cy = 0;
    let cz = 1;
  }
  def rzi : RM<
    opc, (outs RC:$sx), (ins RC:$sz, simm32Op64:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}(${sz})"),
    [(set Ty:$sx, (OpNode Ty:$sz, (Ty simm32:$imm32)))]> {
    let cy = 0;
    let sy = 0;
    let cz = 1;
  }
  def zii : RM<
    opc, (outs RC:$sx), (ins immOp:$sy, simm32Op64:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}(${sy})"),
    [(set Ty:$sx, (OpNode (Ty simm7:$sy), (Ty simm32:$imm32)))]> {
    let cy = 0;
    let cz = 0;
    let sz = 0;
  }
  def zzi : RM<
    opc, (outs RC:$sx), (ins simm32Op64:$imm32),
    !strconcat(opcStr, " $sx, $imm32"),
    [(set Ty:$sx, (Ty simm32:$imm32))]> {
    let cy = 0;
    let sy = 0;
    let cz = 0;
    let sz = 0;
  }
}

multiclass RRm<string opcStr, bits<8>opc, SDNode OpNode,
               RegisterClass RC, ValueType Ty, Operand immOp> {
  def rr : RR<
    opc, (outs RC:$sx), (ins RC:$sy, RC:$sz),
    !strconcat(opcStr, " $sx, $sy, $sz"),
    [(set Ty:$sx, (OpNode Ty:$sy, Ty:$sz))]> {
    let cy = 1;
    let cz = 1;
  }
  def ri : RR<
    opc, (outs RC:$sx), (ins RC:$sz, immOp:$sy),
    !strconcat(opcStr, " $sx, $sy, $sz"),
    [(set Ty:$sx, (OpNode Ty:$sz, (Ty simm7:$sy)))]> {
    let cy = 0;
    let cz = 1;
  }
  def rm0 : RR<
    opc, (outs RC:$sx), (ins RC:$sy, uimm7Op64:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})0"),
    []> {
    let cy = 1;
    let cz = 0;
    let sz{6} = 1;
  }
  def rm1 : RR<
    opc, (outs RC:$sx), (ins RC:$sy, uimm7Op64:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})1"),
    []> {
    let cy = 1;
    let cz = 0;
  }
  def im0 : RR<
    opc, (outs RC:$sx), (ins immOp:$sy, uimm7Op64:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})0"),
    []> {
    let cy = 0;
    let cz = 0;
    let sz{6} = 1;
  }
  def im1 : RR<
    opc, (outs RC:$sx), (ins immOp:$sy, uimm7Op64:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})1"),
    []> {
    let cy = 0;
    let cz = 0;
  }
  def zi : RR<
    opc, (outs RC:$sx), (ins immOp:$sy),
    !strconcat(opcStr, " $sx, $sy"),
    [(set Ty:$sx, (OpNode 0, (Ty simm7:$sy)))]> {
    let cy = 0;
    let cz = 0;
    let sz = 0;
  }
}

// Branch multiclass
let cx = 0, cx2 = 0, bpf = 0 /* NONE */,
  isBranch = 1, isTerminator = 1, hasDelaySlot = 1 in
multiclass BCRm {
  def rr : CF<
    0x18, (outs),
    (ins CCOp:$cf, IntRegs:$sy, IntRegs:$sz, brtarget32:$imm32),
    "br.${cf}.l $sy, $sz, $imm32", []> {
    let cy = 1;
    let cz = 1;
  }
  def ri : CF<
    0x18, (outs),
    (ins CCOp:$cf, IntRegs:$sz, i32imm:$sy, brtarget32:$imm32),
    "br.${cf}.l $sy, $sz, $imm32", []> {
    let cy = 0;
    let cz = 1;
  }
  def a : CF<
    0x18, (outs), (ins brtarget32:$imm32),
    "br.l $imm32", []> {
    let cy = 0;
    let sy = 0;
    let cz = 0;
    let sz = 0;
    let cf = 15;  /* AT */
  }
}

//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

// NOP instruction
let cx = 0, sx = 0, cy = 0, sy = 0, cz = 0, sz = 0, imm32 = 0 in
def NOP : RR<0x79, (outs), (ins), "nop", []>;

// LEA and LEASL instruction (load 32 bit imm to low or high part)
let cx = 0 in
defm LEA : RMm<"lea", 0x06, add, IntRegs, i64, simm7Op64>;
let cx = 1 in
defm LEASL : RMm<"lea.sl", 0x06, add, IntRegs, i64, simm7Op64>;

/*
// LEA instruction (load 32 bit imm to high part)
let cx = 0, cy = 0, sy = 0, cz = 1 in
def LEA : RR<
    0x06, (outs IntRegs:$sx), (ins IntRegs:$sz, i32imm:$imm32),
    "lea.sl $sx, $sz, $imm32",
    [(set i32:$sx, (or i32:$sz, simm32:$imm32))]>;

// LEA.SL instruction (load 32 bit imm to high part)
let cx = 1, cy = 0, sy = 0, cz = 1 in
def LEASL : RR<
    0x06, (outs IntRegs:$sx), (ins IntRegs:$sz, i32imm:$imm32),
    "lea.sl $sx, $sz, $imm32",
    [(set i32:$sx, (or i32:$sz, LEASLimm:$imm32))]>;
*/

// ADD instruction
let cx = 0 in
defm ADD : RRm<"addu.l", 0x48, add, IntRegs, i64, simm7Op64>;
let cx = 1 in
defm ADDUW : RRm<"addu.w", 0x48, add, IntRegs, i32, simm7Op32>;

// ADS instruction
let cx = 0 in
defm ADS : RRm<"adds.w.sx", 0x4A, add, IntRegs, i32, simm7Op32>;
let cx = 1 in
defm ADSU : RRm<"adds.w.zx", 0x4A, add, IntRegs, i32, simm7Op32>;

// ADX instruction
let cx = 0 in
defm ADX : RRm<"adds.l", 0x59, add, IntRegs, i64, simm7Op64>;

// AND, OR, XOR, EQV, NND, and MRG instruction
let cx = 0 in {
defm AND : RRm<"and", 0x44, and, IntRegs, i64, simm7Op64>;
defm OR : RRm<"or", 0x45, or, IntRegs, i64, simm7Op64>;
defm XOR : RRm<"xor", 0x46, xor, IntRegs, i64, simm7Op64>;
/*
defm EQV : RRm<"eqv", 0x47, eqv, IntRegs, i64, simm7Op64>;
defm NND : RRm<"nnd", 0x54, nnd, IntRegs, i64, simm7Op64>;
defm MRG : RRm<"mrg", 0x56, mrg, IntRegs, i64, simm7Op64>;
*/
}

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

// Jump instruction
let cx = 0, cx2 = 0, bpf = 0 /* NONE */, cy = 1, cz = 1,
    isBranch = 1, isTerminator = 1, hasDelaySlot = 1 in
def BC : CF<
    0x19, (outs), (ins CCOp:$cf, IntRegs:$sy, brtarget32:$imm32),
    "b.${cf}.l $sy, $imm32",
    []>;

// Jump always instruction is treated as a special case of jump in order
// to make finding unconditional jump easy.
let cx = 0, cx2 = 0, bpf = 0 /* NONE */, cf = 15 /* AT */, cy = 0, sy = 0,
    cz = 1,
    isBranch = 1, isTerminator = 1, hasDelaySlot = 1 in
def BA : CF<
    0x19, (outs), (ins brtarget32:$imm32),
    "b.l $imm32",
    []>;

// Jump never instruction is also a special case of jump.
let cx = 0, cx2 = 0, bpf = 0 /* NONE */, cf = 0 /* AF */, cy = 1, sy = 0,
    cz = 1,
    isBranch = 1, isTerminator = 1, hasDelaySlot = 1 in
def BN : CF<
    0x19, (outs), (ins brtarget32:$imm32),
    "b.af.l $imm32",
    []>;

// Return instruction is also a special case of jump.
let cx = 0, cx2 = 0, bpf = 0 /* NONE */, cf = 15 /* AT */, cy = 0, sy = 0,
    cz = 1, sz = 0x10 /* S10 */, imm32 = 0, Uses = [S10],
    isReturn = 1, isTerminator = 1, hasDelaySlot = 1, isBarrier = 1,
    isCodeGenOnly = 1 in
def RET : CF<
    0x19, (outs), (ins),
    "b.l (,%lr)",
    [(retflag)]>;

// Branch instruction
defm BCR : BCRm;

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
