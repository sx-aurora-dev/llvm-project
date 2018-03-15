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
def uimm6   : PatLeaf<(imm), [{ return isUInt<6>(N->getZExtValue()); }]>;
def zero    : PatLeaf<(imm), [{ return N->getSExtValue() == 0; }]>;

def LO32 : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant((unsigned)(N->getZExtValue() & 0xffffffff),
                                   SDLoc(N), MVT::i64);
}]>;

def HI32 : SDNodeXForm<imm, [{
  // Transformation function: shift the immediate value down into the low bits.
  return CurDAG->getTargetConstant((unsigned)(N->getZExtValue() >> 32),
                                   SDLoc(N), MVT::i64);
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
  let MIOperandInfo = (ops ptr_rc, i64imm);
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

def calltarget : Operand<i64> {
  let EncoderMethod = "getCallTargetOpValue";
  let DecoderMethod = "DecodeCall";
}

def simm7Op32 : Operand<i32> {
  let DecoderMethod = "DecodeSIMM7";
}

def simm7Op64 : Operand<i64> {
  let DecoderMethod = "DecodeSIMM7";
}

def simm32Op32 : Operand<i32> {
  let DecoderMethod = "DecodeSIMM32";
}

def simm32Op64 : Operand<i64> {
  let DecoderMethod = "DecodeSIMM32";
}

def uimm6Op32 : Operand<i32> {
  let DecoderMethod = "DecodeUIMM6";
}

def uimm6Op64 : Operand<i64> {
  let DecoderMethod = "DecodeUIMM6";
}

// Operand for printing out a condition code.
let PrintMethod = "printCCOperand" in
  def CCOp : Operand<i32>;

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
               RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2> {
  def rri : RM<
    opc, (outs RC:$sx), (ins RC:$sy, RC:$sz, immOp2:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}($sy, ${sz})"),
    [(set Ty:$sx, (OpNode (OpNode Ty:$sy, Ty:$sz), (Ty simm32:$imm32)))]> {
    let cy = 1;
    let cz = 1;
  }
  def rii : RM<
    opc, (outs RC:$sx), (ins RC:$sz, immOp:$sy, immOp2:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}($sy, ${sz})"),
    [(set Ty:$sx, (OpNode (OpNode Ty:$sz, (Ty simm7:$sy)), (Ty simm32:$imm32)))]> {
    let cy = 0;
    let cz = 1;
  }
  def rzi : RM<
    opc, (outs RC:$sx), (ins RC:$sz, immOp2:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}(${sz})"),
    [(set Ty:$sx, (OpNode Ty:$sz, (Ty simm32:$imm32)))]> {
    let cy = 0;
    let sy = 0;
    let cz = 1;
  }
  def zii : RM<
    opc, (outs RC:$sx), (ins immOp:$sy, immOp2:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}(${sy})"),
    [(set Ty:$sx, (OpNode (Ty simm7:$sy), (Ty simm32:$imm32)))]> {
    let cy = 0;
    let cz = 0;
    let sz = 0;
  }
  def zzi : RM<
    opc, (outs RC:$sx), (ins immOp2:$imm32),
    !strconcat(opcStr, " $sx, $imm32"),
    [/* Not define set here to avoid llvm uses LEAzzi for all set instructions.
        We uses pattern matching to select instructions depend on the size of
        immediate later.
        (set Ty:$sx, (Ty simm32:$imm32)) */]> {
    let cy = 0;
    let sy = 0;
    let cz = 0;
    let sz = 0;
  }
}

multiclass RRm<string opcStr, bits<8>opc, SDNode OpNode,
               RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2> {
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
    opc, (outs RC:$sx), (ins RC:$sy, immOp2:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})0"),
    []> {
    let cy = 1;
    let cz = 0;
    let sz{6} = 1;
  }
  def rm1 : RR<
    opc, (outs RC:$sx), (ins RC:$sy, immOp2:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})1"),
    []> {
    let cy = 1;
    let cz = 0;
  }
  def im0 : RR<
    opc, (outs RC:$sx), (ins immOp:$sy, immOp2:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})0"),
    []> {
    let cy = 0;
    let cz = 0;
    let sz{6} = 1;
  }
  def im1 : RR<
    opc, (outs RC:$sx), (ins immOp:$sy, immOp2:$sz),
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
    (ins CCOp:$cf, I64:$sy, I64:$sz, brtarget32:$imm32),
    "br.${cf}.l $sy, $sz, $imm32", []> {
    let cy = 1;
    let cz = 1;
  }
  def ri : CF<
    0x18, (outs),
    (ins CCOp:$cf, I64:$sz, i64imm:$sy, brtarget32:$imm32),
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
defm LEA : RMm<"lea", 0x06, add, I64, i64, simm7Op64, simm32Op64>;
let cx = 1 in
defm LEASL : RMm<"lea.sl", 0x06, add, I64, i64, simm7Op64, simm32Op64>;
let isCodeGenOnly = 1 in {
let cx = 0 in
defm LEA32 : RMm<"lea", 0x06, add, I32, i32, simm7Op32, simm32Op32>;
let cx = 1 in
defm LEASL32 : RMm<"lea.sl", 0x06, add, I32, i32, simm7Op32, simm32Op32>;
}

// ADD instruction
let cx = 0 in
defm ADD : RRm<"addu.l", 0x48, add, I64, i64, simm7Op64, uimm6Op64>;
let cx = 1 in
defm ADDUW : RRm<"addu.w", 0x48, add, I32, i32, simm7Op32, uimm6Op32>;

// ADS instruction
let cx = 0 in
defm ADS : RRm<"adds.w.sx", 0x4A, add, I32, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm ADSU : RRm<"adds.w.zx", 0x4A, add, I32, i32, simm7Op32, uimm6Op32>;

// ADX instruction
let cx = 0 in
defm ADX : RRm<"adds.l", 0x59, add, I64, i64, simm7Op64, uimm6Op64>;

// AND, OR, XOR, EQV, NND, and MRG instruction
let cx = 0 in {
defm AND : RRm<"and", 0x44, and, I64, i64, simm7Op64, uimm6Op64>;
defm OR : RRm<"or", 0x45, or, I64, i64, simm7Op64, uimm6Op64>;
defm XOR : RRm<"xor", 0x46, xor, I64, i64, simm7Op64, uimm6Op64>;
let isCodeGenOnly = 1 in {
defm AND32 : RRm<"and", 0x44, and, I32, i32, simm7Op32, uimm6Op32>;
defm OR32 : RRm<"or", 0x45, or, I32, i32, simm7Op32, uimm6Op32>;
defm XOR32 : RRm<"xor", 0x46, xor, I32, i32, simm7Op32, uimm6Op32>;
}
/*
defm EQV : RRm<"eqv", 0x47, eqv, I64, i64, simm7Op64, uimm6Op64>;
defm NND : RRm<"nnd", 0x54, nnd, I64, i64, simm7Op64, uimm6Op64>;
defm MRG : RRm<"mrg", 0x56, mrg, I64, i64, simm7Op64, uimm6Op64>;
*/
}

// LDS and STS instructions
// As 1st step, only uses sz and imm32 to represent $addr
let cx = 0, cy = 0, sy = 0, cz = 1 in
def LDS : RM<
    0x01, (outs I64:$sx), (ins MEMri:$addr),
    "ld $sx, $addr",
    [(set i64:$sx, (load ADDRri:$addr))]>;

let cx = 0, cy = 0, sy = 0, cz = 1 in
def SDS : RM<
    0x11, (outs), (ins MEMri:$addr, I64:$sx),
    "st $sx, $addr",
    [(store i64:$sx, ADDRri:$addr)]>;

// Jump instruction
let cx = 0, cx2 = 0, bpf = 0 /* NONE */, cy = 1, cz = 1,
    isBranch = 1, isTerminator = 1, hasDelaySlot = 1 in
def BC : CF<
    0x19, (outs), (ins CCOp:$cf, I64:$sy, brtarget32:$imm32),
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
// Instructions for CodeGenOnly
//===----------------------------------------------------------------------===//

let isCodeGenOnly = 1 in {

// Call instruction
let Defs = [S10], Uses = [S11], hasDelaySlot = 1, isCall = 1 in {
let cx = 0, sx = 10, cy = 0, sy = 0, cz = 0, sz = 0 in
def CALL : RM<
    0x08, (outs), (ins calltarget:$imm32, variable_ops),
    "bsic %lr, $imm32",
    []>;
// use sy and sz to represent 2 registers
let cx = 0, sx = 10, cy = 1, cz = 1, imm32 = 0 in
def CALLrr : RM<
    0x08, (outs), (ins MEMrr:$ptr, variable_ops),
    "bsic %lr, $ptr",
    [(call ADDRrr:$ptr)]>;
// use sz to represent a register, and use imm32 to represent immediate value
let cx = 0, sx = 10, cy = 0, sy = 0, cz = 1 in
def CALLri : RM<
    0x08, (outs), (ins MEMri:$ptr, variable_ops),
    "bsic %lr, $ptr",
    [(call ADDRri:$ptr)]>;
}

}

//===----------------------------------------------------------------------===//
// Pattern Matchings
//===----------------------------------------------------------------------===//

// Small immediates.
def : Pat<(i32 simm7:$val), (OR32im1 imm:$val, 0)>;
def : Pat<(i64 simm7:$val), (ORim1 imm:$val, 0)>;
// Medium immediates.
def : Pat<(i32 simm32:$val), (LEA32zzi imm:$val)>;
def : Pat<(i64 simm32:$val), (LEAzzi imm:$val)>;
// Arbitrary immediates.
def : Pat<(i64 imm:$val),
          (LEASLrzi (ANDrm0 (LEAzzi (LO32 imm:$val)), 32),
                    (HI32 imm:$val))>;

// The same integer registers are used for i32 and i64 values.
// When registers hold i32 values, the high bits are don't care.
// This give us free trunc and anyext.
def : Pat<(i64 (anyext i32:$val)), (COPY_TO_REGCLASS $val, I64)>;
def : Pat<(i32 (trunc i64:$val)), (COPY_TO_REGCLASS $val, I32)>;

/*
def : Pat<(i64 (zext i32:$val)), (i64 (ADSUri $val, 0))>;
def : Pat<(i64 (sext i32:$val)), (i64 (ADSri $val, 0))>;
*/

def : Pat<(VEhi tglobaladdr:$in), (LEASLzzi tglobaladdr:$in)>;
def : Pat<(VElo tglobaladdr:$in), (ANDrm0 (LEAzzi tglobaladdr:$in), 32)>;
def : Pat<(VEhi tconstpool:$in), (LEASLzzi tconstpool:$in)>;
def : Pat<(VElo tconstpool:$in), (ANDrm0 (LEAzzi tconstpool:$in), 32)>;

def : Pat<(call tglobaladdr:$dst),
          (CALL tglobaladdr:$dst)>;
def : Pat<(call texternalsym:$dst),
          (CALL texternalsym:$dst)>;

//===----------------------------------------------------------------------===//
// Pseudo Instructions
//===----------------------------------------------------------------------===//

let Defs = [S11], Uses = [S11] in {
def ADJCALLSTACKDOWN : Pseudo<(outs), (ins i64imm:$amt, i64imm:$amt2),
                              "# ADJCALLSTACKDOWN $amt, $amt2",
                              [(callseq_start timm:$amt, timm:$amt2)]>;
def ADJCALLSTACKUP : Pseudo<(outs), (ins i64imm:$amt1, i64imm:$amt2),
                            "# ADJCALLSTACKUP $amt1",
                            [(callseq_end timm:$amt1, timm:$amt2)]>;
}
