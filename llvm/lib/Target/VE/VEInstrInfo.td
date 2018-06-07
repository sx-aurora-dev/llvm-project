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

def trunc_imm : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(N->getZExtValue(), SDLoc(N), MVT::i32);
}]>;

def sext_imm : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(N->getSExtValue(), SDLoc(N), MVT::i64);
}]>;

def zext_imm : SDNodeXForm<imm, [{
  return CurDAG->getTargetConstant(N->getZExtValue(), SDLoc(N), MVT::i64);
}]>;

def cond2cc : SDNodeXForm<cond, [{
  VECC::CondCodes cc;
  switch (N->get()) {
  default:          llvm_unreachable("Unknown integer condition code!");
  case ISD::SETEQ:  cc = VECC::CC_EQ; break;
  case ISD::SETNE:  cc = VECC::CC_NE; break;
  case ISD::SETLT:  cc = VECC::CC_L;  break;
  case ISD::SETGT:  cc = VECC::CC_G;  break;
  case ISD::SETLE:  cc = VECC::CC_LE; break;
  case ISD::SETGE:  cc = VECC::CC_GE; break;
  case ISD::SETULT: cc = VECC::CC_LNAN; break;
  case ISD::SETULE: cc = VECC::CC_LENAN; break;
  case ISD::SETUGT: cc = VECC::CC_GNAN; break;
  case ISD::SETUGE: cc = VECC::CC_GENAN; break;
  case ISD::SETOLT: cc = VECC::CC_L; break;
  case ISD::SETOLE: cc = VECC::CC_LE; break;
  case ISD::SETOGT: cc = VECC::CC_G; break;
  case ISD::SETOGE: cc = VECC::CC_GE; break;
  }
  return CurDAG->getTargetConstant(cc, SDLoc(N), MVT::i32);
}]>;

// reverse
/*
def cond2rcc : SDNodeXForm<cond, [{
  VECC::CondCodes cc;
  switch (N->get()) {
  default:          llvm_unreachable("Unknown integer condition code!");
  case ISD::SETEQ:  cc = VECC::CC_NE; break;
  case ISD::SETNE:  cc = VECC::CC_EQ; break;
  case ISD::SETLT:  cc = VECC::CC_GE;  break;
  case ISD::SETGT:  cc = VECC::CC_LE;  break;
  case ISD::SETLE:  cc = VECC::CC_G; break;
  case ISD::SETGE:  cc = VECC::CC_L; break;
  }
  return CurDAG->getTargetConstant(cc, SDLoc(N), MVT::i32);
}]>;
*/


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

def MEMhm : Operand<iPTR> {
  let PrintMethod = "printMemHmOperand";
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

def VEmax : SDNode<"VEISD::MAX", SDTIntBinOp>;
def VEmin : SDNode<"VEISD::MIN", SDTIntBinOp>;
def VEfmax : SDNode<"VEISD::FMAX", SDTFPBinOp>;
def VEfmin : SDNode<"VEISD::FMIN", SDTFPBinOp>;

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
def CC_EQ    : CC_VAL< 4>;  // Equal
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
  /*
  def rii : RM<
    opc, (outs RC:$sx), (ins RC:$sz, immOp:$sy, immOp2:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}($sy, ${sz})"),
    [(set Ty:$sx, (OpNode (OpNode Ty:$sz, (Ty simm7:$sy)), (Ty simm32:$imm32)))]> {
    let cy = 0;
    let cz = 1;
  }
  */
  def rzi : RM<
    opc, (outs RC:$sx), (ins RC:$sz, immOp2:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}(${sz})"),
    [(set Ty:$sx, (OpNode Ty:$sz, (Ty simm32:$imm32)))]> {
    let cy = 0;
    let sy = 0;
    let cz = 1;
  }
  /*
  def zii : RM<
    opc, (outs RC:$sx), (ins immOp:$sy, immOp2:$imm32),
    !strconcat(opcStr, " $sx, ${imm32}(${sy})"),
    [(set Ty:$sx, (OpNode (Ty simm7:$sy), (Ty simm32:$imm32)))]> {
    let cy = 0;
    let cz = 0;
    let sz = 0;
  }
  */
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
  /*
  def zi : RR<
    opc, (outs RC:$sx), (ins immOp:$sy),
    !strconcat(opcStr, " $sx, $sy"),
    [(set Ty:$sx, (OpNode 0, (Ty simm7:$sy)))]> {
    let cy = 0;
    let cz = 0;
    let sz = 0;
  }
  */
}


// Branch multiclass
let cx = 0, cx2 = 0, bpf = 0 /* NONE */,
  isBranch = 1, isTerminator = 1, hasDelaySlot = 1 in
multiclass BCRm {
  def rr : CF<
    0x18, (outs),
    (ins CCOp:$cf, I64:$sy, I64:$sz, brtarget32:$imm32),
    "br${cf}.l $sy, $sz, $imm32", []> {
    let cy = 1;
    let cz = 1;
  }
//  def ri : CF<
//    0x18, (outs),
//    (ins CCOp:$cf, I64:$sz, i64imm:$sy, brtarget32:$imm32),
//    "br${cf}.l $sy, $sz, $imm32", []> {
//    let cy = 0;
//    let cz = 1;
//  }
  def ir : CF<
    0x18, (outs),
    (ins CCOp:$cf, i64imm:$sy, I64:$sz, brtarget32:$imm32),
    "br${cf}.l $sy, $sz, $imm32", []> {
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
    let isBarrier = 1;
  }
}

//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

// SX = SZ if cf(sy)
let cw = 0, cw2 = 0 in
def CMOVlrr : RR<0x3B, (outs I64:$sx), (ins CCOp:$cf, I64:$sy, I64:$sz),
    "cmov.l.${cf} $sx,$sy,$sz", []>;

let cw = 1, cw2 = 0 in
def CMOVwrr : RR<0x3B, (outs I64:$sx), (ins CCOp:$cf, I64:$sy, I64:$sz),
    "cmov.w.${cf} $sx,$sy,$sz", []>;

let cw = 0, cw2 = 1 in
def CMOVdrr : RR<0x3B, (outs I64:$sx), (ins CCOp:$cf, I64:$sy, I64:$sz),
    "cmov.w.${cf} $sx,$sy,$sz", []>;

let cw = 1, cw2 = 1 in
def CMOVsrr : RR<0x3B, (outs I64:$sx), (ins CCOp:$cf, I64:$sy, I64:$sz),
    "cmov.w.${cf} $sx,$sy,$sz", []>;

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

let cx = 0, cy = 1, cz = 0, sz = 0 in {
  def LEAasx : RM<
      0x06, (outs I64:$sx), (ins MEMri:$addr),
      "lea $sx,$addr", []>;
}

// 5.3.2.2. Fixed-Point Arithmetic Operation Instructions

// ADD instruction
let cx = 0 in
defm ADD : RRm<"addu.l", 0x48, add, I64, i64, simm7Op64, uimm6Op64>;
let cx = 1 in
defm ADDUW : RRm<"addu.w", 0x48, add, I32, i32, simm7Op32, uimm6Op32>;

// ADS instruction
let cx = 0 in
defm ADS : RRm<"adds.w.sx", 0x4A, add, I64, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm ADSU : RRm<"adds.w.zx", 0x4A, add, I64, i32, simm7Op32, uimm6Op32>;

//def ADSir : RR<0x4A, (outs I64:$sx), (ins simm7Op32:$sy, I64:$sz),
//  "adds.w.sx $sx,$sy,$sz", []>;

//def ADSri0 : RR<0x4A, (outs I64:$sx), (ins I64:$sy, uimm6Op32:$sy),
//  "adds.w.sx $sx,$sy,($sz)0", []>;

// ADX instruction
let cx = 0 in
defm ADX : RRm<"adds.l", 0x59, add, I64, i64, simm7Op64, uimm6Op64>;

// SUB instruction
let cx = 0 in
defm SUB : RRm<"subu.l", 0x58, sub, I64, i64, simm7Op64, uimm6Op64>;
let cx = 1 in
defm SUBUW : RRm<"subu.w", 0x58, sub, I32, i32, simm7Op32, uimm6Op32>;

// SBS instruction
let cx = 0 in
defm SBS : RRm<"subs.w.sx", 0x5A, add, I32, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm SBSU : RRm<"subs.w.zx", 0x5A, add, I32, i32, simm7Op32, uimm6Op32>;

// SBX instruction
let cx = 0 in
defm SBX : RRm<"subs.l", 0x5B, add, I64, i64, simm7Op64, uimm6Op64>;

// MPY instruction (mul u64)
defm MPY : RRm<"mulu.l", 0x49, mul, I64, i64, simm7Op64, uimm6Op64>;

// DIV

// u64
let cx = 0, cy = 1, cz = 1 in
def CMPLrr : RR<0x55, (outs I64:$sx), (ins I64:$sy, I64:$sz),
        "cmpu.l $sx,$sy,$sz", []>;

// u32
let cx = 1, cy = 1, cz = 1 in
def CMPWrr : RR<0x55, (outs I64:$sx), (ins I64:$sy, I64:$sz),
        "cmpu.w $sx,$sy,$sz", []>;

// i32 cx: sx
let cx = 1, cy = 1, cz = 1 in
def CPSWZrr : RR<0x7A, (outs I64:$sx), (ins I64:$sy, I64:$sz),
        "cmps.w.zx $sx,$sy,$sz", []>;

// i64
let cy = 1, cz = 1 in
def CPXrr : RR<0x7A, (outs I64:$sx), (ins I64:$sy, I64:$sz),
        "cmps.l $sx,$sy,$sz", []>;

// cx: sx/zx, cw: max/min

let cw = 0 in defm CMXa : 
  RRm<"maxs.l", 0x68, VEmax, I64, i64, simm7Op64, uimm6Op64>;

let cx = 0, cw = 0 in defm CMSa :
  RRm<"maxs.w.zx", 0x78, VEmax, I64, i32, simm7Op32, uimm6Op32>;

let cw = 1 in defm CMXi : 
  RRm<"mins.l", 0x68, VEmin, I64, i64, simm7Op64, uimm6Op64>;

let cx = 1, cw = 0 in defm CMSi :
  RRm<"mins.w.zx", 0x78, VEmin, I64, i32, simm7Op32, uimm6Op32>;

// cx: sx/zx, cw: max/min
/*
let cx = 0, cw = 0 in def CMSal : RR<0x78, (outs I64:$sx), (ins I64:$sy, I64:$sz),
  "maxs.l.zx $sx,$sy,$sz",
  [(set i64:$sx, (VEmax i64:$sy, i64:$sz))]>;

let cx = 0, cw = 0 in def CMSa : RR<0x78, (outs I64:$sx), (ins I64:$sy, I64:$sz),
  "maxs.w.zx $sx,$sy,$sz",
  [(set i32:$sx, (VEmax i32:$sy, i32:$sz))]>;

let cx = 0, cw = 1 in def CMSi : RR<0x78, (outs I64:$sx), (ins I64:$sy, I64:$sz),
  "mins.w.zx $sx,$sy,$sz",
  [(set i32:$sx, (VEmin i32:$sy, i32:$sz))]>;
  */

// 5.3.2.3. Logical Arithmetic Operation Instructions

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

// 5.3.2.4 Shift Instructions

// should be uimm5? (0-31)
let cy = 0, cz = 1 in
def SRAX : RR<0x76, (outs I64:$sx), (ins I64:$sy, uimm6Op32:$sz),
  "sra.l $sx,$sy,$sz",
  [(set i32:$sx, (sra i32:$sy, (i32 uimm6:$sz)))]>;

def SLL : RR<0x64, (outs I64:$sx), (ins I64:$sy, uimm6Op32:$sz),
  "sll $sx,$sy,$sz",
  [(set i64:$sx, (shl i64:$sy, (i32 uimm6:$sz)))]>;

def : Pat<(i32 (shl i32:$sy, (i32 uimm6:$sz))),
          (SLL i32:$sy, (i32 uimm6:$sz))>;

def SRL : RR<0x75, (outs I64:$sx), (ins I64:$sy, uimm6Op32:$sz),
  "srl $sx,$sy,$sz",
  [(set i64:$sx, (srl i64:$sy, (i32 uimm6:$sz)))]>;

def : Pat<(srl i32:$sy, (i32 uimm6:$sz)),
          (SRL i32:$sy, (i32 uimm6:$sz))>;

// 5.3.2.5. Floating-point Arithmetic Operation Instructions
class RRF<string opcStr, bits<8>opc, SDNode OpNode, RegisterClass RC, ValueType Ty>
  : RR<opc, (outs RC:$sx), (ins RC:$sy, RC:$sz),
      !strconcat(opcStr, " $sx,$sy,$sz"), [(set Ty:$sx, (OpNode Ty:$sy, Ty:$sz))]> {
        let cy = 0;
        let cz = 0;
}

multiclass RRFm<string opcStr, bits<8> opc, SDNode OpNode>
{
  def d : RRF<opcStr#".d", opc, OpNode, I64, f64> { let cx = 0; }
  def s : RRF<opcStr#".s", opc, OpNode, I64, f32> { let cx = 1; }
}

defm FAD : RRFm<"fadd", 0x4C, fadd>;
defm FSB : RRFm<"fsub", 0x5C, fsub>;
defm FMP : RRFm<"fmul", 0x4D, fmul>;
defm FDV : RRFm<"fdiv", 0x5D, fdiv>;

def : Pat<(fneg f64:$sx), (FSBd (ORim1 0, 0), $sx)>;
def : Pat<(fneg f32:$sx), (FSBs (ORim1 0, 0), $sx)>;

let cx = 0 in def FCPdrr : RR<0x7E, (outs I64:$sx), (ins I64:$sy, I64:$sz),
  "fcmp.d $sx,$sy,$sz", []>;
let cx = 1 in def FCPsrr : RR<0x7E, (outs I64:$sx), (ins I64:$sy, I64:$sz),
  "fcmp.s $sx,$sy,$sz", []>;
// FCM

/*
def FCMas : RR<0x3E, (outs I64:$sx), (ins I64:$sy, I64:$sz),
  "fmax.s $sx,$sy,$sz", 
  [(set f32:$sx, (VEfmax f32:$sy, f32:$sz))]>;
*/
let cw = 0 in defm FCMa : RRFm<"fmax", 0x3E, VEfmax>;
let cw = 1 in defm FCMi : RRFm<"fmin", 0x3E, VEfmin>;

multiclass CVTm<string opcStr, bits<8> opc>
{
  def r : RR<opc, (outs I64:$sx), (ins I64:$sy), 
    !strconcat(opcStr, " $sx,$sy"), []> {
      let cy = 1;
    }

  def i : RR<opc, (outs I64:$sx), (ins simm7Op32:$sy), 
    !strconcat(opcStr, " $sx,$sy"), []> {
      let cy = 0;
    }
}

let cx = 1, cw = 0 in let CFw = 8 in defm FIXs : CVTm<"cvt.w.s.sx.rz", 0x5E>;
let cx = 0, cw = 0 in let CFw = 8 in defm FIXd : CVTm<"cvt.w.d.sx.rz", 0x5E>;
let CFw = 8 in defm FIXX : CVTm<"cvt.l.d.rz", 0x4F>;
let cx = 1 in defm FLTs : CVTm<"cvt.s.w", 0x5E>;
let cx = 0 in defm FLTd : CVTm<"cvt.d.w", 0x5E>;
defm FLTX : CVTm<"cvt.d.l", 0x5F>;
defm CVS : CVTm<"cvt.s.d", 0x1F>;
defm CVD : CVTm<"cvt.d.s", 0x0F>;
// CVQ: f32 or f64 -> f128


def : Pat<(i32 (trunc i64:$sy)), (i32 (ADSrm1 i64:$sy, 0))>;
def : Pat<(i32 (fp_to_sint f32:$sy)), (i32 (FIXsr f32:$sy))>;
def : Pat<(i32 (fp_to_sint f64:$sy)), (i32 (FIXdr f64:$sy))>;

def : Pat<(i64 (sext i32:$sy)), (i64 (ADSrm1 i32:$sy, 0))>;
def : Pat<(i64 (zext i32:$sy)), (i64 (ADSUrm1 i32:$sy, 0))>;
def : Pat<(i64 (fp_to_sint f32:$sy)), (i64 (FIXXr (CVDr f32:$sy)))>;
def : Pat<(i64 (fp_to_sint f64:$sy)), (i64 (FIXXr f64:$sy))>;

def : Pat<(f32 (sint_to_fp i32:$sy)), (f32 (FLTsr i32:$sy))>;
def : Pat<(f32 (sint_to_fp i64:$sy)), (f32 (CVSr (FLTXr i64:$sy)))>;
def : Pat<(f32 (fpround f64:$sy)), (f32 (CVSr f64:$sy))>;

def : Pat<(f64 (sint_to_fp i32:$sy)), (f64 (FLTdr i32:$sy))>;
def : Pat<(f64 (sint_to_fp i64:$sy)), (f64 (FLTXr i64:$sy))>;
def : Pat<(f64 (fpextend f32:$sy)), (f64 (CVDr f32:$sy))>;

def : Pat<(i64 (anyext i32:$sy)), (COPY $sy)>;


// Load and Store instructions
// As 1st step, only uses sz and imm32 to represent $addr
let cy = 0, sy = 0, cz = 1 in {
let cx = 0 in
def LDSri : RM<
    0x01, (outs I64:$sx), (ins MEMri:$addr),
    "ld $sx, $addr",
    []>;
//    [(set i64:$sx, (load ADDRri:$addr))]>;
let cx = 0 in
def LDUri : RM<
    0x02, (outs I32:$sx), (ins MEMri:$addr),
    "ldu $sx, $addr",
    [/* FIXME: load into only upper part of $sx here
     (set i32:$sx, (load ADDRri:$addr)) */]>;
let cx = 0 in
def LDLri : RM<
    0x03, (outs I64:$sx), (ins MEMri:$addr),
    "ldl.sx $sx, $addr",
    [(set i32:$sx, (load ADDRri:$addr))]>;
let cx = 1 in
def LDLUri : RM<
    0x03, (outs I32:$sx), (ins MEMri:$addr),
    "ldl.zx $sx, $addr",
    [(set i32:$sx, (load ADDRri:$addr))]>;
let cx = 0 in
def LD2Bri : RM<
    0x04, (outs I16:$sx), (ins MEMri:$addr),
    "ld2b.sx $sx, $addr",
    [(set i16:$sx, (load ADDRri:$addr))]>;
let cx = 1 in
def LD2BUri : RM<
    0x04, (outs I16:$sx), (ins MEMri:$addr),
    "ld2b.zx $sx, $addr",
    [(set i16:$sx, (load ADDRri:$addr))]>;
let cx = 0 in
def LD1Bri : RM<
    0x05, (outs I8:$sx), (ins MEMri:$addr),
    "ld1b.sx $sx, $addr",
    [(set i8:$sx, (load ADDRri:$addr))]>;
let cx = 1 in
def LD1BUri : RM<
    0x05, (outs I8:$sx), (ins MEMri:$addr),
    "ld1b.zx $sx, $addr",
    [(set i8:$sx, (load ADDRri:$addr))]>;
}

let cx = 0, cy = 0, sy = 0, cz = 1 in {
def STSri : RM<
    0x11, (outs), (ins MEMri:$addr, I64:$sx),
    "st $sx, $addr",
    []>;
    //[(store f64:$sx, ADDRri:$addr), (store i64:$sx, ADDRri:$addr)]>; // why don't work?
def STUri : RM<
    0x12, (outs), (ins MEMri:$addr, I32:$sx),
    "stu $sx, $addr",
    [/* FIXME: store only upper part of $sx here
     (store i32:$sx, ADDRri:$addr) */]>;
def STLri : RM<
    0x13, (outs), (ins MEMri:$addr, I32:$sx),
    "stl $sx, $addr",
    [(store i32:$sx, ADDRri:$addr)]>;
def ST2Bri : RM<
    0x14, (outs), (ins MEMri:$addr, I16:$sx),
    "st2b $sx, $addr",
    [(store i16:$sx, ADDRri:$addr)]>;
def ST1Bri : RM<
    0x15, (outs), (ins MEMri:$addr, I8:$sx),
    "st1b $sx, $addr",
    [(store i8:$sx, ADDRri:$addr)]>;
}

def : Pat<(f64 (load ADDRri:$addr)), (LDSri ADDRri:$addr)>;
def : Pat<(i64 (load ADDRri:$addr)), (LDSri ADDRri:$addr)>;
def : Pat<(f32 (load ADDRri:$addr)), (LDUri ADDRri:$addr)>;
def : Pat<(store f64:$sx, ADDRri:$addr), (STSri ADDRri:$addr, f64:$sx)>;
def : Pat<(store i64:$sx, ADDRri:$addr), (STSri ADDRri:$addr, i64:$sx)>;
def : Pat<(store f32:$sx, ADDRri:$addr), (STUri ADDRri:$addr, f32:$sx)>;

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

// Load and Store host memory instructions
let cx = 0, cy = 0, cz = 1 in {
let sy = 3 in
def LHMri : RM<
    0x21, (outs I64:$sx), (ins MEMhm:$addr),
    "lhm.l $sx, $addr",
    []>;
let sy = 2 in
def LHMLri : RM<
    0x21, (outs I32:$sx), (ins MEMhm:$addr),
    "lhm.w $sx, $addr",
    []>;
let sy = 1 in
def LHM2Bri : RM<
    0x21, (outs I16:$sx), (ins MEMhm:$addr),
    "lhm.h $sx, $addr",
    []>;
let sy = 0 in
def LHM1Bri : RM<
    0x21, (outs I8:$sx), (ins MEMhm:$addr),
    "lhm.b $sx, $addr",
    []>;
}

let cx = 0, cy = 0, cz = 1 in {
let sy = 3 in
def SHMri : RM<
    0x31, (outs), (ins MEMhm:$addr, I64:$sx),
    "shm.l $sx, $addr",
    []>;
let sy = 2 in
def SHMLri : RM<
    0x31, (outs), (ins MEMhm:$addr, I32:$sx),
    "shm.l $sx, $addr",
    []>;
let sy = 1 in
def SHM2Bri : RM<
    0x31, (outs), (ins MEMhm:$addr, I16:$sx),
    "shm.l $sx, $addr",
    []>;
let sy = 0 in
def SHM1Bri : RM<
    0x31, (outs), (ins MEMhm:$addr, I8:$sx),
    "shm.l $sx, $addr",
    []>;
}

let cx = 0, sx = 0, cy = 0, sy = 0, cz = 0, sz = 0 in
def MONC : RR<
    0x3F, (outs), (ins),
    "monc",
    []>;

let cx = 1, sx = 0, cy = 0, sy = 0, cz = 0, sz = 0 in
def MONCT : RR<
    0x3F, (outs), (ins),
    "monc.hdb",
    []>;


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
/*
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
*/
// use sz to represent a register
let cx = 0, sx = 10, cy = 0, sy = 0, cz = 1, imm32 = 0 in
def CALLr : RM<
    0x08, (outs), (ins I64:$sz, variable_ops),
    "bsic %lr, (,$sz)",
    []>;
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
// def : Pat<(i64 (anyext i32:$val)), (COPY_TO_REGCLASS $val, I64)>;
// def : Pat<(i32 (trunc i64:$val)), (COPY_TO_REGCLASS $val, I32)>;

// Or free trunc, but 1 instruction for anyext.
def : Pat<(i64 (zext i32:$val)), (COPY_TO_REGCLASS (ADSUri i32:$val, 0), I64)>;
def : Pat<(i64 (sext i32:$val)), (COPY_TO_REGCLASS (ADSri $val, 0), I64)>;
def : Pat<(i32 (trunc i64:$val)), (COPY_TO_REGCLASS $val, I32)>;

def : Pat<(i64 (sext_inreg i64:$val, i32)), (COPY_TO_REGCLASS (ADSri $val, 0), I64)>;
//def : Pat<(i64 (sext_inreg i64:$val, i32)), (i64 (ADSri $val, 0))>;

// sextload and zextload stuff
def : Pat<(i64 (sextloadi32 ADDRri:$addr)),
          (COPY_TO_REGCLASS (LDLri MEMri:$addr), I64)>;
def : Pat<(i64 (zextloadi32 ADDRri:$addr)),
          (COPY_TO_REGCLASS (LDLUri MEMri:$addr), I64)>;

def : Pat<(i64 (extloadi32 ADDRri:$addr)),
          (i64 (LDLri MEMri:$addr))>;

// truncstore
def : Pat<(truncstorei32 i64:$src, ADDRri:$addr),
          (STLri MEMri:$addr, (COPY_TO_REGCLASS $src, I32))>;

// Address calculation and its optimization
def : Pat<(VEhi tglobaladdr:$in), (LEASLzzi tglobaladdr:$in)>;
def : Pat<(VElo tglobaladdr:$in), (ANDrm0 (LEAzzi tglobaladdr:$in), 32)>;
def : Pat<(add (VEhi tglobaladdr:$in1), (VElo tglobaladdr:$in2)),
          (LEASLrzi (ANDrm0 (LEAzzi tglobaladdr:$in2), 32),
                    (tglobaladdr:$in1))>;

// Address calculation and its optimization
def : Pat<(VEhi tconstpool:$in), (LEASLzzi tconstpool:$in)>;
def : Pat<(VElo tconstpool:$in), (ANDrm0 (LEAzzi tconstpool:$in), 32)>;
def : Pat<(add (VEhi tconstpool:$in1), (VElo tconstpool:$in2)),
          (LEASLrzi (ANDrm0 (LEAzzi tconstpool:$in2), 32),
                    (tconstpool:$in1))>;

// Address calculation and its optimization
def : Pat<(VEhi texternalsym:$in), (LEASLzzi texternalsym:$in)>;
def : Pat<(VElo texternalsym:$in), (ANDrm0 (LEAzzi texternalsym:$in), 32)>;
def : Pat<(add (VEhi texternalsym:$in1), (VElo texternalsym:$in2)),
          (LEASLrzi (ANDrm0 (LEAzzi texternalsym:$in2), 32),
                    (texternalsym:$in1))>;

// Calls
def : Pat<(call tglobaladdr:$dst),
          (CALL tglobaladdr:$dst)>;
def : Pat<(call texternalsym:$dst),
          (CALL texternalsym:$dst)>;
def : Pat<(call i64:$dst),
          (CALLr i64:$dst)>;

// Branches
def : Pat<(br bb:$addr), (BCRa bb:$addr)>;
//def : Pat<(brcc cond:$cond, i32:$lhs, simm7:$rhs, bb:$addr),
//          (BCRri (cond2cc $cond), (COPY_TO_REGCLASS $lhs, I64),
//                 (i64 (sext_imm $rhs)), bb:$addr)>;
def : Pat<(brcc cond:$cond, simm7:$lhs, i32:$rhs, bb:$addr),
          (BCRir (cond2cc $cond), (i64 (sext_imm $lhs)), 
                 (COPY_TO_REGCLASS $rhs, I64), bb:$addr)>;
//def : Pat<(brcc cond:$cond, i32:$lhs, simm7:$rhs, bb:$addr),
//          (BCRir (cond2rcc $cond), (i64 (sext_imm $rhs)), 
//                 (COPY_TO_REGCLASS $lhs, I64), bb:$addr)>;
def : Pat<(brcc cond:$cond, i32:$lhs, i32:$rhs, bb:$addr),
          (BCRrr (cond2cc $cond), (COPY_TO_REGCLASS $lhs, I64),
                 (COPY_TO_REGCLASS $rhs, I64), bb:$addr)>;
def : Pat<(brcc cond:$cond, i64:$lhs, i64:$rhs, bb:$addr),
          (BCRrr (cond2cc $cond), $lhs, $rhs, bb:$addr)>;

def : Pat<(i32 (bitconvert f32:$op)), (i32 I64:$op)>;


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

let Defs = [S8], Uses = [S8, S11] in
def EXTEND_STACK : Pseudo<(outs), (ins),
                          "# EXTEND STACK",
                          []>;
def EXTEND_STACK_GUARD : Pseudo<(outs), (ins),
                                "# EXTEND STACK GUARD",
                                []>;

// Pseudo CMOV
def PCMOVlrr : Pseudo<(outs I64:$sx), (ins CCOp:$cf, I64:$sy, I64:$sz, I64:$sd),
  "cmov.l.${cf} $sx,$sz,$sy", []> {
  let Constraints = "$sx = $sd";
  }

def PCMOVwrr : Pseudo<(outs I64:$sx), (ins CCOp:$cf, I64:$sy, I64:$sz, I64:$sd),
  "cmov.w.${cf} $sx,$sz,$sy", []> {
  let Constraints = "$sx = $sd";
  }

def PCMOVdrr : Pseudo<(outs I64:$sx), (ins CCOp:$cf, I64:$sy, I64:$sz, I64:$sd),
  "cmov.d.${cf} $sx,$sz,$sy", []> {
  let Constraints = "$sx = $sd";
  }

def PCMOVsrr : Pseudo<(outs I64:$sx), (ins CCOp:$cf, I64:$sy, I64:$sz, I64:$sd),
  "cmov.s.${cf} $sx,$sz,$sy", []> {
  let Constraints = "$sx = $sd";
  }

def : Pat<(i32 (setcc i64:$LHS, i64:$RHS, cond:$cond)),
          (i32 (PCMOVlrr (cond2cc $cond), 
                         (CMPLrr i64:$LHS, i64:$RHS), 
                         (ORim1 1, 0), 
                         (ORim1 0, 0)))>;

def : Pat<(i32 (setcc i32:$LHS, i32:$RHS, cond:$cond)),
          (i32 (PCMOVwrr (cond2cc $cond), 
                         (CMPWrr i32:$LHS, i32:$RHS),
                         (ORim1 1, 0), 
                         (ORim1 0, 0)))>;

def : Pat<(i32 (setcc f64:$LHS, f64:$RHS, cond:$cond)),
          (i32 (PCMOVsrr (cond2cc $cond), 
                         (FCPsrr f64:$LHS, f64:$RHS), 
                         (ORim1 1, 0), 
                         (ORim1 0, 0)))>;

def : Pat<(i32 (setcc f32:$LHS, f32:$RHS, cond:$cond)),
          (i32 (PCMOVsrr (cond2cc $cond), 
                         (FCPsrr f32:$LHS, f32:$RHS), 
                         (ORim1 1, 0), 
                         (ORim1 0, 0)))>;

include "VEInstrVec.td"
