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
def uimm32  : PatLeaf<(imm), [{ return isUInt<32>(N->getZExtValue()); }]>;
def uimm6   : PatLeaf<(imm), [{ return isUInt<6>(N->getZExtValue()); }]>;
def zero    : PatLeaf<(imm), [{ return N->getSExtValue() == 0; }]>;

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

def icond2cc : SDNodeXForm<cond, [{
  VECC::CondCodes cc;
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

def fcond2cc : SDNodeXForm<cond, [{
  VECC::CondCodes cc;
  switch (N->get()) {
  default:          llvm_unreachable("Unknown float condition code!");
  case ISD::SETFALSE: cc = VECC::CC_AF;    break;
  case ISD::SETOEQ:   cc = VECC::CC_EQ;    break;
  case ISD::SETONE:   cc = VECC::CC_NE;    break;
  case ISD::SETOLT:   cc = VECC::CC_L;     break;
  case ISD::SETOGT:   cc = VECC::CC_G;     break;
  case ISD::SETOLE:   cc = VECC::CC_LE;    break;
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

// Multiclass for RR type instructions
//   Used by add, sub, and similar isntructions

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
    // (guess) tblgen conservatively assumes hasSideEffects when it fails to infer from a pattern.
    let hasSideEffects = 0;
  }
  def rm1 : RR<
    opc, (outs RC:$sx), (ins RC:$sy, immOp2:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})1"),
    []> {
    let cy = 1;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def im0 : RR<
    opc, (outs RC:$sx), (ins immOp:$sy, immOp2:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})0"),
    []> {
    let cy = 0;
    let cz = 0;
    let sz{6} = 1;
    let hasSideEffects = 0;
  }
  def im1 : RR<
    opc, (outs RC:$sx), (ins immOp:$sy, immOp2:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})1"),
    []> {
    let cy = 0;
    let cz = 0;
    let hasSideEffects = 0;
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

// Multiclass for RR type instructions without dag pattern
//   Used by cmp instruction

multiclass RRNDm<string opcStr, bits<8>opc, SDNode OpNode,
               RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2> {
  def rr : RR<
    opc, (outs RC:$sx), (ins RC:$sy, RC:$sz),
    !strconcat(opcStr, " $sx, $sy, $sz"),
    []> {
    let cy = 1;
    let cz = 1;
  }
  def ri : RR<
    opc, (outs RC:$sx), (ins RC:$sz, immOp:$sy),
    !strconcat(opcStr, " $sx, $sy, $sz"),
    []> {
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
    // (guess) tblgen conservatively assumes hasSideEffects when it fails to infer from a pattern.
    let hasSideEffects = 0;
  }
  def rm1 : RR<
    opc, (outs RC:$sx), (ins RC:$sy, immOp2:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})1"),
    []> {
    let cy = 1;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def im0 : RR<
    opc, (outs RC:$sx), (ins immOp:$sy, immOp2:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})0"),
    []> {
    let cy = 0;
    let cz = 0;
    let sz{6} = 1;
    let hasSideEffects = 0;
  }
  def im1 : RR<
    opc, (outs RC:$sx), (ins immOp:$sy, immOp2:$sz),
    !strconcat(opcStr, " $sx, $sy, (${sz})1"),
    []> {
    let cy = 0;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def zi : RR<
    opc, (outs RC:$sx), (ins immOp:$sy),
    !strconcat(opcStr, " $sx, $sy"),
    []> {
    let cy = 0;
    let cz = 0;
    let sz = 0;
    let hasSideEffects = 0;
  }
}

// Multiclass for RR type instructions
//   Used by sra, sla, sll, etc.

multiclass RRIm<string opcStr, bits<8>opc, SDNode OpNode,
               RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2> {
  def rr : RR<
    opc, (outs RC:$sx), (ins RC:$sz, I32:$sy),
    !strconcat(opcStr, " $sx, $sz, $sy"),
    [(set Ty:$sx, (OpNode Ty:$sz, i32:$sy))]> {
    let cy = 1;
    let cz = 1;
  }
  def ri : RR<
    opc, (outs RC:$sx), (ins RC:$sz, immOp:$sy),
    !strconcat(opcStr, " $sx, $sz, $sy"),
    [(set Ty:$sx, (OpNode Ty:$sz, (i32 simm7:$sy)))]> {
    let cy = 0;
    let cz = 1;
  }
  def rm0 : RR<
    opc, (outs RC:$sx), (ins immOp2:$sz, I32:$sy),
    !strconcat(opcStr, " $sx, (${sz})0, $sy"),
    []> {
    let cy = 1;
    let cz = 0;
    let sz{6} = 1;
    // (guess) tblgen conservatively assumes hasSideEffects when it fails to infer from a pattern.
    let hasSideEffects = 0;
  }
  def rm1 : RR<
    opc, (outs RC:$sx), (ins immOp2:$sz, I32:$sy),
    !strconcat(opcStr, " $sx, (${sz})1, $sy"),
    []> {
    let cy = 1;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def im0 : RR<
    opc, (outs RC:$sx), (ins immOp2:$sz, immOp:$sy),
    !strconcat(opcStr, " $sx, (${sz})0, $sy"),
    []> {
    let cy = 0;
    let cz = 0;
    let sz{6} = 1;
    let hasSideEffects = 0;
  }
  def im1 : RR<
    opc, (outs RC:$sx), (ins immOp2:$sz, immOp:$sy),
    !strconcat(opcStr, " $sx, (${sz})1, $sy"),
    []> {
    let cy = 0;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def zi : RR<
    opc, (outs RC:$sx), (ins immOp:$sy),
    !strconcat(opcStr, " $sx, $sy"),
    [(set Ty:$sx, (OpNode 0, (i32 simm7:$sy)))]> {
    let cy = 0;
    let cz = 0;
    let sz = 0;
  }
}

// Multiclass for RR type instructions without dag pattern
//   Used by sra.w.zx, sla.w.zx, and others

multiclass RRINDm<string opcStr, bits<8>opc, SDNode OpNode,
               RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2> {
  def rr : RR<
    opc, (outs RC:$sx), (ins RC:$sz, I32:$sy),
    !strconcat(opcStr, " $sx, $sz, $sy"),
    []> {
    let cy = 1;
    let cz = 1;
  }
  def ri : RR<
    opc, (outs RC:$sx), (ins RC:$sz, immOp:$sy),
    !strconcat(opcStr, " $sx, $sz, $sy"),
    []> {
    let cy = 0;
    let cz = 1;
  }
  def rm0 : RR<
    opc, (outs RC:$sx), (ins immOp2:$sz, I32:$sy),
    !strconcat(opcStr, " $sx, (${sz})0, $sy"),
    []> {
    let cy = 1;
    let cz = 0;
    let sz{6} = 1;
    // (guess) tblgen conservatively assumes hasSideEffects when it fails to infer from a pattern.
    let hasSideEffects = 0;
  }
  def rm1 : RR<
    opc, (outs RC:$sx), (ins immOp2:$sz, I32:$sy),
    !strconcat(opcStr, " $sx, (${sz})1, $sy"),
    []> {
    let cy = 1;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def im0 : RR<
    opc, (outs RC:$sx), (ins immOp2:$sz, immOp:$sy),
    !strconcat(opcStr, " $sx, (${sz})0, $sy"),
    []> {
    let cy = 0;
    let cz = 0;
    let sz{6} = 1;
    let hasSideEffects = 0;
  }
  def im1 : RR<
    opc, (outs RC:$sx), (ins immOp2:$sz, immOp:$sy),
    !strconcat(opcStr, " $sx, (${sz})1, $sy"),
    []> {
    let cy = 0;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def zi : RR<
    opc, (outs RC:$sx), (ins immOp:$sy),
    !strconcat(opcStr, " $sx, $sy"),
    []> {
    let cy = 0;
    let cz = 0;
    let sz = 0;
  }
}

// Multiclass for RR type instructions
//   Used by cmov instruction

let Constraints = "$sx = $sd", DisableEncoding = "$sd" in
multiclass RRCMOVm<string opcStr, bits<8>opc,
               RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2> {
  def rr : RR<
    opc, (outs I64:$sx), (ins CCOp:$cf, RC:$sy, I64:$sz, I64:$sd),
    !strconcat(opcStr, " $sx, $sz, $sy"),
    []> {
    let cy = 1;
    let cz = 1;
  }
  def ri : RR<
    opc, (outs I64:$sx), (ins CCOp:$cf, I64:$sz, immOp:$sy, I64:$sd),
    !strconcat(opcStr, " $sx, $sz, $sy"),
    []> {
    let cy = 0;
    let cz = 1;
  }
  def rm0 : RR<
    opc, (outs I64:$sx), (ins CCOp:$cf, RC:$sy, immOp2:$sz, I64:$sd),
    !strconcat(opcStr, " $sx, (${sz})0, $sy"),
    []> {
    let cy = 1;
    let cz = 0;
    let sz{6} = 1;
    // (guess) tblgen conservatively assumes hasSideEffects when it fails to infer from a pattern.
    let hasSideEffects = 0;
  }
  def rm1 : RR<
    opc, (outs I64:$sx), (ins CCOp:$cf, RC:$sy, immOp2:$sz, I64:$sd),
    !strconcat(opcStr, " $sx, (${sz})1, $sy"),
    []> {
    let cy = 1;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def im0 : RR<
    opc, (outs I64:$sx), (ins CCOp:$cf, immOp:$sy, immOp2:$sz, I64:$sd),
    !strconcat(opcStr, " $sx, (${sz})0, $sy"),
    []> {
    let cy = 0;
    let cz = 0;
    let sz{6} = 1;
    let hasSideEffects = 0;
  }
  def im1 : RR<
    opc, (outs I64:$sx), (ins CCOp:$cf, immOp:$sy, immOp2:$sz, I64:$sd),
    !strconcat(opcStr, " $sx, (${sz})1, $sy"),
    []> {
    let cy = 0;
    let cz = 0;
    let hasSideEffects = 0;
  }
}


// Branch multiclass
let isBranch = 1, isTerminator = 1, hasDelaySlot = 1 in
multiclass BCRm<string opcStr, string opcStrAt, bits<8> opc,
                RegisterClass RC, ValueType Ty, Operand immOp, Operand immOp2> {
  def rr : CF<
    opc, (outs),
    (ins CCOp:$cf, RC:$sy, RC:$sz, brtarget32:$imm32),
    !strconcat(opcStr, " $sy, $sz, $imm32"), []> {
    let cy = 1;
    let cz = 1;
  }
  def ir : CF<
    opc, (outs),
    (ins CCOp:$cf, immOp:$sy, RC:$sz, brtarget32:$imm32),
    !strconcat(opcStr, " $sy, $sz, $imm32"), []> {
    let cy = 0;
    let cz = 1;
  }
  def rm0 : CF<
    opc, (outs), (ins CCOp:$cf, RC:$sy, immOp2:$sz, brtarget32:$imm32),
    !strconcat(opcStr, " $sy, (${sz})0, $imm32"), []> {
    let cy = 1;
    let cz = 0;
    let sz{6} = 1;
    // (guess) tblgen conservatively assumes hasSideEffects when it fails to infer from a pattern.
    let hasSideEffects = 0;
  }
  def rm1 : CF<
    opc, (outs), (ins CCOp:$cf, RC:$sy, immOp2:$sz, brtarget32:$imm32),
    !strconcat(opcStr, " $sy, (${sz})1, $imm32"), []> {
    let cy = 1;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def im0 : CF<
    opc, (outs), (ins CCOp:$cf, immOp:$sy, immOp2:$sz, brtarget32:$imm32),
    !strconcat(opcStr, " $sy, (${sz})0, $imm32"), []> {
    let cy = 0;
    let cz = 0;
    let sz{6} = 1;
    let hasSideEffects = 0;
  }
  def im1 : CF<
    opc, (outs), (ins CCOp:$cf, immOp:$sy, immOp2:$sz, brtarget32:$imm32),
    !strconcat(opcStr, " $sy, (${sz})1, $imm32"), []> {
    let cy = 0;
    let cz = 0;
    let hasSideEffects = 0;
  }
  def a : CF<
    opc, (outs), (ins brtarget32:$imm32),
    !strconcat(opcStrAt, " $imm32"), []> {
    let cy = 0;
    let sy = 0;
    let cz = 0;
    let sz = 0;
    let cf = 15;  /* AT */
    let isBarrier = 1;
  }
}

// Multiclass for floating point conversion instructions.
//   Used by CVS/CVD/FLT and others
multiclass CVTm<string opcStr, bits<8> opc,
                RegisterClass RCo, ValueType Tyo,
                RegisterClass RCi, ValueType Tyi, Operand immOp> {
  def r : RR<opc, (outs RCo:$sx), (ins RCi:$sy), 
    !strconcat(opcStr, " $sx, $sy"), []> {
      let cy = 1;
    }

  def i : RR<opc, (outs RCo:$sx), (ins immOp:$sy), 
    !strconcat(opcStr, " $sx, $sy"), []> {
      let cy = 0;
    }
}


//===----------------------------------------------------------------------===//
// Instructions
//===----------------------------------------------------------------------===//

// CMOV instructions
let cx = 0, cw = 0, cw2 = 0 in
defm CMOVL : RRCMOVm<"cmov.l.${cf}", 0x3B, I64, i64, simm7Op64, uimm6Op64>;

let cx = 0, cw = 1, cw2 = 0 in
defm CMOVW : RRCMOVm<"cmov.w.${cf}", 0x3B, I32, i32, simm7Op64, uimm6Op32>;

let cx = 0, cw = 0, cw2 = 1 in
defm CMOVD : RRCMOVm<"cmov.d.${cf}", 0x3B, I64, f64, simm7Op64, uimm6Op64>;

let cx = 0, cw = 1, cw2 = 1 in
defm CMOVS : RRCMOVm<"cmov.s.${cf}", 0x3B, F32, f32, simm7Op64, uimm6Op32>;

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
      "lea $sx,$addr", [(set iPTR:$sx, ADDRri:$addr)]>;
}

// 5.3.2.2. Fixed-Point Arithmetic Operation Instructions

// ADD instruction
let cx = 0 in
defm ADD : RRNDm<"addu.l", 0x48, add, I64, i64, simm7Op64, uimm6Op64>;
let cx = 1 in
defm ADDUW : RRNDm<"addu.w", 0x48, add, I32, i32, simm7Op32, uimm6Op32>;

// ADS instruction
let cx = 0 in
defm ADS : RRm<"adds.w.sx", 0x4A, add, I32, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm ADSU : RRNDm<"adds.w.zx", 0x4A, add, I32, i32, simm7Op32, uimm6Op32>;

// ADX instruction
let cx = 0 in
defm ADX : RRm<"adds.l", 0x59, add, I64, i64, simm7Op64, uimm6Op64>;

// SUB instruction
let cx = 0 in
defm SUB : RRNDm<"subu.l", 0x58, sub, I64, i64, simm7Op64, uimm6Op64>;
let cx = 1 in
defm SUBUW : RRNDm<"subu.w", 0x58, sub, I32, i32, simm7Op32, uimm6Op32>;

// SBS instruction
let cx = 0 in
defm SBS : RRm<"subs.w.sx", 0x5A, sub, I32, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm SBSU : RRNDm<"subs.w.zx", 0x5A, sub, I32, i32, simm7Op32, uimm6Op32>;

// SBX instruction
let cx = 0 in
defm SBX : RRm<"subs.l", 0x5B, sub, I64, i64, simm7Op64, uimm6Op64>;

// MPY instruction
let cx = 0 in
defm MPY : RRNDm<"mulu.l", 0x49, mul, I64, i64, simm7Op64, uimm6Op64>;
let cx = 1 in
defm MPYUW : RRNDm<"mulu.w", 0x49, mul, I32, i32, simm7Op32, uimm6Op32>;

// MPS instruction
let cx = 0 in
defm MPS : RRm<"muls.w.sx", 0x4B, mul, I32, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm MPSU : RRNDm<"muls.w.zx", 0x4B, mul, I32, i32, simm7Op32, uimm6Op32>;

// MPX instruction
let cx = 0 in
defm MPX : RRm<"muls.l", 0x6E, mul, I64, i64, simm7Op64, uimm6Op64>;

// DIV instruction
let cx = 0 in
defm DIV : RRm<"divu.l", 0x6F, udiv, I64, i64, simm7Op64, uimm6Op64>;
let cx = 1 in
defm DIVUW : RRm<"divu.w", 0x6F, udiv, I32, i32, simm7Op32, uimm6Op32>;

// DVS instruction
let cx = 0 in
defm DVS : RRm<"divs.w.sx", 0x7B, sdiv, I32, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm DVSU : RRNDm<"divs.w.zx", 0x7B, sdiv, I32, i32, simm7Op32, uimm6Op32>;

// DVX instruction
let cx = 0 in
defm DVX : RRm<"divs.l", 0x7F, sdiv, I64, i64, simm7Op64, uimm6Op64>;

// CMP instruction
let cx = 0 in
defm CMP : RRNDm<"cmpu.l", 0x55, setcc, I64, i64, simm7Op64, uimm6Op64>;
let cx = 1 in
defm CMPUW : RRNDm<"cmpu.w", 0x55, setcc, I32, i32, simm7Op32, uimm6Op32>;

// CPS instruction
let cx = 0 in
defm CPS : RRNDm<"cmps.w.sx", 0x7A, setcc, I32, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm CPSU : RRNDm<"cmps.w.zx", 0x7A, setcc, I32, i32, simm7Op32, uimm6Op32>;

// CPX instruction
let cx = 0 in
defm CPX : RRNDm<"cmps.l", 0x6A, setcc, I64, i64, simm7Op64, uimm6Op64>;

// cx: sx/zx, cw: max/min

let cw = 0 in defm CMXa : 
  RRm<"maxs.l", 0x68, VEmax, I64, i64, simm7Op64, uimm6Op64>;

let cx = 0, cw = 0 in defm CMSa :
  RRm<"maxs.w.zx", 0x78, VEmax, I32, i32, simm7Op32, uimm6Op32>;

let cw = 1 in defm CMXi : 
  RRm<"mins.l", 0x68, VEmin, I64, i64, simm7Op64, uimm6Op64>;

let cx = 1, cw = 0 in defm CMSi :
  RRm<"mins.w.zx", 0x78, VEmin, I32, i32, simm7Op32, uimm6Op32>;

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

let cx = 0 in
defm SRAX : RRIm<"sra.l", 0x77, sra, I64, i64, simm7Op32, uimm6Op64>;
let cx = 0 in
defm SRA : RRIm<"sra.w.sx", 0x76, sra, I32, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm SRAU : RRINDm<"sra.w.zx", 0x76, sra, I32, i32, simm7Op32, uimm6Op32>;

let cx = 0 in
defm SLL : RRIm<"sll", 0x65, shl, I64, i64, simm7Op32, uimm6Op64>;
let cx = 0 in
defm SLA : RRIm<"sla.w.sx", 0x66, shl, I32, i32, simm7Op32, uimm6Op32>;
let cx = 1 in
defm SLAU : RRINDm<"sla.w.zx", 0x66, shl, I32, i32, simm7Op32, uimm6Op32>;

let cx = 0 in
defm SRL : RRIm<"srl", 0x75, srl, I64, i64, simm7Op32, uimm6Op64>;
let cx = 0, isCodeGenOnly = 1 in
defm SRLW : RRIm<"srl", 0x75, srl, I32, i32, simm7Op32, uimm6Op32>;

// 5.3.2.5. Floating-point Arithmetic Operation Instructions
class RRF<string opcStr, bits<8>opc, SDNode OpNode, RegisterClass RC, ValueType Ty>
  : RR<opc, (outs RC:$sx), (ins RC:$sy, RC:$sz),
       !strconcat(opcStr, " $sx, $sy, $sz"),
       [(set Ty:$sx, (OpNode Ty:$sy, Ty:$sz))]> {
         let cy = 0;
         let cz = 0;
}

multiclass RRFm<string opcStr, bits<8> opc, SDNode OpNode>
{
  def d : RRF<opcStr#".d", opc, OpNode, I64, f64> { let cx = 0; }
  def s : RRF<opcStr#".s", opc, OpNode, F32, f32> { let cx = 1; }
}

defm FAD : RRFm<"fadd", 0x4C, fadd>;
defm FSB : RRFm<"fsub", 0x5C, fsub>;
defm FMP : RRFm<"fmul", 0x4D, fmul>;
defm FDV : RRFm<"fdiv", 0x5D, fdiv>;

// FCP instruction
let cx = 0 in
defm FCP : RRNDm<"fcmp.d", 0x7E, setcc, I64, f64, simm7Op64, uimm6Op64>;
let cx = 1 in
defm FCPS : RRNDm<"fcmp.s", 0x7E, setcc, F32, f32, simm7Op32, uimm6Op32>;

// FCM
let cw = 0 in defm FCMa : RRFm<"fmax", 0x3E, VEfmax>;
let cw = 1 in defm FCMi : RRFm<"fmin", 0x3E, VEfmin>;

let cx = 1, cw = 0 in let cfw = 8 in
defm FIXs : CVTm<"cvt.w.s.sx.rz", 0x5E, I32, i32, F32, f32, simm7Op32>;
let cx = 0, cw = 0 in let cfw = 8 in
defm FIXd : CVTm<"cvt.w.d.sx.rz", 0x5E, I32, i32, I64, f64, simm7Op32>;
let cfw = 8 in
defm FIXX : CVTm<"cvt.l.d.rz", 0x4F, I64, i64, I64, f64, simm7Op64>;
let cx = 1 in
defm FLTs : CVTm<"cvt.s.w", 0x5E, F32, f32, I32, i32, simm7Op32>;
let cx = 0 in
defm FLTd : CVTm<"cvt.d.w", 0x5E, I64, f64, I32, i32, simm7Op32>;
defm FLTX : CVTm<"cvt.d.l", 0x5F, I64, f64, I64, i64, simm7Op64>;
defm CVS : CVTm<"cvt.s.d", 0x1F, F32, f32, I64, f64, simm7Op64>;
defm CVD : CVTm<"cvt.d.s", 0x0F, I64, f64, F32, f32, simm7Op32>;
// CVQ: f32 or f64 -> f128


// Load and Store instructions
// As 1st step, only uses sz and imm32 to represent $addr
let cy = 0, sy = 0, cz = 1, mayLoad = 1 in {
let cx = 0 in
def LDSri : RM<
    0x01, (outs I64:$sx), (ins MEMri:$addr),
    "ld $sx, $addr",
    [(set i64:$sx, (load ADDRri:$addr))]>;
let cx = 0 in
def LDUri : RM<
    0x02, (outs F32:$sx), (ins MEMri:$addr),
    "ldu $sx, $addr",
    [(set f32:$sx, (load ADDRri:$addr))]>;
let cx = 0 in
def LDLri : RM<
    0x03, (outs I32:$sx), (ins MEMri:$addr),
    "ldl.sx $sx, $addr",
    [(set i32:$sx, (load ADDRri:$addr))]>;
let cx = 1 in
def LDLUri : RM<
    0x03, (outs I32:$sx), (ins MEMri:$addr),
    "ldl.zx $sx, $addr",
    [(set i32:$sx, (load ADDRri:$addr))]>;
let cx = 0 in
def LD2Bri : RM<
    0x04, (outs I32:$sx), (ins MEMri:$addr),
    "ld2b.sx $sx, $addr",
    [(set i32:$sx, (sextloadi16 ADDRri:$addr))]>;
let cx = 1 in
def LD2BUri : RM<
    0x04, (outs I32:$sx), (ins MEMri:$addr),
    "ld2b.zx $sx, $addr",
    [(set i32:$sx, (zextloadi16 ADDRri:$addr))]>;
let cx = 0 in
def LD1Bri : RM<
    0x05, (outs I32:$sx), (ins MEMri:$addr),
    "ld1b.sx $sx, $addr",
    [(set i32:$sx, (sextloadi8 ADDRri:$addr))]>;
let cx = 1 in
def LD1BUri : RM<
    0x05, (outs I32:$sx), (ins MEMri:$addr),
    "ld1b.zx $sx, $addr",
    [(set i32:$sx, (zextloadi8 ADDRri:$addr))]>;
}

let cx = 0, cy = 0, sy = 0, cz = 1, mayStore = 1 in {
def STSri : RM<
    0x11, (outs), (ins MEMri:$addr, I64:$sx),
    "st $sx, $addr",
    [(store i64:$sx, ADDRri:$addr)]>;
def STUri : RM<
    0x12, (outs), (ins MEMri:$addr, F32:$sx),
    "stu $sx, $addr",
    [(store f32:$sx, ADDRri:$addr)]>;
def STLri : RM<
    0x13, (outs), (ins MEMri:$addr, I32:$sx),
    "stl $sx, $addr",
    [(store i32:$sx, ADDRri:$addr)]>;
def ST2Bri : RM<
    0x14, (outs), (ins MEMri:$addr, I32:$sx),
    "st2b $sx, $addr",
    [(truncstorei16 i32:$sx, ADDRri:$addr)]>;
def ST1Bri : RM<
    0x15, (outs), (ins MEMri:$addr, I32:$sx),
    "st1b $sx, $addr",
    [(truncstorei8 i32:$sx, ADDRri:$addr)]>;
}

def : Pat<(f64 (load ADDRri:$addr)), (LDSri ADDRri:$addr)>;
def : Pat<(store f64:$sx, ADDRri:$addr), (STSri ADDRri:$addr, $sx)>;

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
    cz = 1, sz = 0x10 /* SX10 */, imm32 = 0, Uses = [SX10],
    isReturn = 1, isTerminator = 1, hasDelaySlot = 1, isBarrier = 1,
    isCodeGenOnly = 1 in
def RET : CF<
    0x19, (outs), (ins),
    "b.l (,%lr)",
    [(retflag)]>;

// Branch instruction
let cx = 0, cx2 = 0, bpf = 0 /* NONE */ in
defm BCRL : BCRm<"br${cf}.l", "br.l", 0x18, I64, i64, simm7Op64, uimm6Op64>;
let cx = 1, cx2 = 0, bpf = 0 /* NONE */ in
defm BCRW : BCRm<"br${cf}.w", "br.w", 0x18, I32, i32, simm7Op32, uimm6Op32>;
let cx = 0, cx2 = 1, bpf = 0 /* NONE */ in
defm BCRD : BCRm<"br${cf}.d", "br.d", 0x18, I64, f64, simm7Op64, uimm6Op64>;
let cx = 1, cx2 = 1, bpf = 0 /* NONE */ in
defm BCRS : BCRm<"br${cf}.s", "br.s", 0x18, F32, f32, simm7Op32, uimm6Op32>;

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
let Defs = [SX10], Uses = [SX11], hasDelaySlot = 1, isCall = 1 in {
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
def : Pat<(i64 uimm32:$val), (ANDrm0 (LEAzzi imm:$val), 32)>;
// Arbitrary immediates.
def : Pat<(i64 imm:$val),
          (LEASLrzi (ANDrm0 (LEAzzi (LO32 imm:$val)), 32),
                    (HI32 imm:$val))>;

// The same integer registers are used for i32 and i64 values.
// When registers hold i32 values, the high bits are don't care.

// Cast to i1
// Following patterns are not used by llvm, unfortunately.
// Need to investigate them later.
def : Pat<(sext_inreg I32:$src, i1), (AND32rm0 $src, 63)>;
def : Pat<(sext_inreg i64:$src, i1), (ANDrm0 $src, 63)>;

// Cast to i8
def : Pat<(sext_inreg I32:$src, i8),
          (SRAri (SLAri $src, 24), 24)>;
def : Pat<(sext_inreg I64:$src, i8),
          (SRAXri (SLLri $src, 56), 56)>;
def : Pat<(sext_inreg (i32 (trunc i64:$src)), i8),
          (EXTRACT_SUBREG (SRAXri (SLLri $src, 56), 56), sub_i32)>;
def : Pat<(and (trunc i64:$src), 0xff),
          (AND32rm0 (EXTRACT_SUBREG $src, sub_i32), 56)>;

// Cast to i16
def : Pat<(sext_inreg I32:$src, i16),
          (SRAri (SLAri $src, 16), 16)>;
def : Pat<(sext_inreg I64:$src, i16),
          (SRAXri (SLLri $src, 48), 48)>;
def : Pat<(sext_inreg (trunc i64:$src), i16),
          (EXTRACT_SUBREG (SRAXri (SLLri $src, 48), 48), sub_i32)>;
def : Pat<(and (trunc i64:$src), 0xffff),
          (AND32rm0 (EXTRACT_SUBREG $src, sub_i32), 48)>;

// Cast to i32
def : Pat<(i32 (trunc i64:$src)),
          (ADSrm1 (EXTRACT_SUBREG $src, sub_i32), 0)>;
def : Pat<(i32 (fp_to_sint f32:$sy)), (FIXsr f32:$sy)>;
def : Pat<(i32 (fp_to_sint f64:$sy)), (FIXdr f64:$sy)>;
def : Pat<(i32 (fp_to_uint f32:$sy)),
          (EXTRACT_SUBREG (ANDrm0 (FIXXr (CVDr $sy)), 32), sub_i32)>;
def : Pat<(i32 (fp_to_uint f64:$sy)),
          (EXTRACT_SUBREG (ANDrm0 (FIXXr f64:$sy), 32), sub_i32)>;

// Cast to i64
def : Pat<(sext_inreg I64:$src, i32),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
            (ADSrm1 (EXTRACT_SUBREG $src, sub_i32), 0), sub_i32)>;
def : Pat<(i64 (sext i32:$sy)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (ADSrm1 $sy, 0), sub_i32)>;
def : Pat<(i64 (zext i32:$sy)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (ADSUrm1 i32:$sy, 0), sub_i32)>;
def : Pat<(i64 (fp_to_sint f32:$sy)), (FIXXr (CVDr f32:$sy))>;
def : Pat<(i64 (fp_to_sint f64:$sy)), (FIXXr f64:$sy)>;
def : Pat<(i64 (fp_to_uint f32:$sy)), (FIXXr (CVDr f32:$sy))>;
def : Pat<(i64 (fp_to_uint f64:$sy)), (FIXXr f64:$sy)>;

// Cast to f32
def : Pat<(f32 (sint_to_fp i32:$sy)), (FLTsr i32:$sy)>;
def : Pat<(f32 (sint_to_fp i64:$sy)), (CVSr (FLTXr i64:$sy))>;
def : Pat<(f32 (uint_to_fp i32:$sy)),
          (CVSr (FLTXr
            (ANDrm0 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32)))>;
def : Pat<(f32 (uint_to_fp i64:$sy)),
          (CVSr (FLTXr $sy))>;
def : Pat<(f32 (fpround f64:$sy)), (CVSr f64:$sy)>;

// Cast to f64
def : Pat<(f64 (sint_to_fp i32:$sy)), (FLTdr i32:$sy)>;
def : Pat<(f64 (sint_to_fp i64:$sy)), (FLTXr i64:$sy)>;
def : Pat<(f64 (uint_to_fp i32:$sy)),
          (FLTXr (ANDrm0 (INSERT_SUBREG
            (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32))>;
def : Pat<(f64 (uint_to_fp i64:$sy)),
          (FLTXr $sy)>;
def : Pat<(f64 (fpextend f32:$sy)), (f64 (CVDr f32:$sy))>;

def : Pat<(i64 (anyext i32:$sy)), (COPY $sy)>;

// sextload and zextload stuff
def : Pat<(i64 (sextloadi8 ADDRri:$addr)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (LD1Bri MEMri:$addr), sub_i32)>;
def : Pat<(i64 (zextloadi8 ADDRri:$addr)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (LD1BUri MEMri:$addr), sub_i32)>;
def : Pat<(i64 (sextloadi16 ADDRri:$addr)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (LD2Bri MEMri:$addr), sub_i32)>;
def : Pat<(i64 (zextloadi16 ADDRri:$addr)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (LD2BUri MEMri:$addr), sub_i32)>;
def : Pat<(i64 (sextloadi32 ADDRri:$addr)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (LDLri MEMri:$addr), sub_i32)>;
def : Pat<(i64 (zextloadi32 ADDRri:$addr)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (LDLUri MEMri:$addr), sub_i32)>;
def : Pat<(i64 (extloadi32 ADDRri:$addr)),
          (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (LDLri MEMri:$addr), sub_i32)>;

// anyextload
def : Pat<(extloadi8  ADDRri:$addr), (LD1BUri MEMri:$addr)>;
def : Pat<(extloadi16 ADDRri:$addr), (LD2BUri MEMri:$addr)>;

// truncstore
def : Pat<(truncstorei8 i64:$src, ADDRri:$addr),
          (ST1Bri MEMri:$addr, (EXTRACT_SUBREG $src, sub_i32))>;
def : Pat<(truncstorei16 i64:$src, ADDRri:$addr),
          (ST2Bri MEMri:$addr, (EXTRACT_SUBREG $src, sub_i32))>;
def : Pat<(truncstorei32 i64:$src, ADDRri:$addr),
          (STLri MEMri:$addr, (EXTRACT_SUBREG $src, sub_i32))>;

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
def : Pat<(br bb:$addr), (BCRLa bb:$addr)>;

// selectcc for i64 result
def : Pat<(brcc CCSIOp:$cond, i32:$l, i32:$r, bb:$addr),
          (BCRWrr (icond2cc $cond), $l, $r, bb:$addr)>;
def : Pat<(brcc CCUIOp:$cond, i32:$l, i32:$r, bb:$addr),
          (BCRWir (icond2cc $cond), 0, (CMPUWrr $r, $l), bb:$addr)>;
def : Pat<(brcc CCSIOp:$cond, i64:$l, i64:$r, bb:$addr),
          (BCRLrr (icond2cc $cond), $l, $r, bb:$addr)>;
def : Pat<(brcc CCUIOp:$cond, i64:$l, i64:$r, bb:$addr),
          (BCRLir (icond2cc $cond), 0, (CMPrr $r, $l), bb:$addr)>;
def : Pat<(brcc cond:$cond, f32:$l, f32:$r, bb:$addr),
          (BCRSrr (fcond2cc $cond), $l, $r, bb:$addr)>;
def : Pat<(brcc cond:$cond, f64:$l, f64:$r, bb:$addr),
          (BCRDrr (fcond2cc $cond), $l, $r, bb:$addr)>;


def : Pat<(i32 (bitconvert f32:$op)), (EXTRACT_SUBREG (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $op, sub_f32), sub_i32)>;
def : Pat<(f32 (bitconvert i32:$op)), (EXTRACT_SUBREG (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $op, sub_i32), sub_f32)>;


//===----------------------------------------------------------------------===//
// Pseudo Instructions
//===----------------------------------------------------------------------===//

let Defs = [SX11], Uses = [SX11] in {
def ADJCALLSTACKDOWN : Pseudo<(outs), (ins i64imm:$amt, i64imm:$amt2),
                              "# ADJCALLSTACKDOWN $amt, $amt2",
                              [(callseq_start timm:$amt, timm:$amt2)]>;
def ADJCALLSTACKUP : Pseudo<(outs), (ins i64imm:$amt1, i64imm:$amt2),
                            "# ADJCALLSTACKUP $amt1",
                            [(callseq_end timm:$amt1, timm:$amt2)]>;
}

let Defs = [SX8], Uses = [SX8, SX11] in
def EXTEND_STACK : Pseudo<(outs), (ins),
                          "# EXTEND STACK",
                          []>;
def EXTEND_STACK_GUARD : Pseudo<(outs), (ins),
                                "# EXTEND STACK GUARD",
                                []>;

// SETCC pattern matches
//
//   CMP  %tmp, lhs, rhs     ; compare lhs and rhs
//   or   %res, 0, (0)1      ; initialize by 0
//   CMOV %res, (63)0, %tmp  ; set 1 if %tmp is true

def : Pat<(i32 (setcc i64:$LHS, i64:$RHS, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrm0 (icond2cc $cond), 
                        (CPXrr i64:$LHS, i64:$RHS), 
                        63, 
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc i64:$LHS, i64:$RHS, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrm0 (icond2cc $cond), 
                        (CMPrr i64:$LHS, i64:$RHS), 
                        63, 
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc i32:$LHS, i32:$RHS, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrm0 (icond2cc $cond), 
                        (CPSrr i32:$LHS, i32:$RHS),
                        63, 
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc i32:$LHS, i32:$RHS, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrm0 (icond2cc $cond), 
                        (CMPUWrr i32:$LHS, i32:$RHS),
                        63, 
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc f64:$LHS, f64:$RHS, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVDrm0 (fcond2cc $cond), 
                        (FCPrr f64:$LHS, f64:$RHS), 
                        63, 
                        (ORim1 0, 0)), sub_i32)>;

def : Pat<(i32 (setcc f32:$LHS, f32:$RHS, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVSrm0 (fcond2cc $cond), 
                        (FCPSrr f32:$LHS, f32:$RHS), 
                        63, 
                        (ORim1 0, 0)), sub_i32)>;

// Special SELECTCC pattern matches
// Use min/max for better performance.
//
//   MAX/MIN  %res, %lhs, %rhs

def : Pat<(f64 (selectcc f64:$LHS, f64:$RHS, f64:$LHS, f64:$RHS, SETOGT)),
          (FCMad $LHS, $RHS)>;
def : Pat<(f32 (selectcc f32:$LHS, f32:$RHS, f32:$LHS, f32:$RHS, SETOGT)),
          (FCMas $LHS, $RHS)>;
def : Pat<(i64 (selectcc i64:$LHS, i64:$RHS, i64:$LHS, i64:$RHS, SETGT)),
          (CMXarr $LHS, $RHS)>;
def : Pat<(i32 (selectcc i32:$LHS, i32:$RHS, i32:$LHS, i32:$RHS, SETGT)),
          (CMSarr $LHS, $RHS)>;
def : Pat<(f64 (selectcc f64:$LHS, f64:$RHS, f64:$LHS, f64:$RHS, SETOGE)),
          (FCMad $LHS, $RHS)>;
def : Pat<(f32 (selectcc f32:$LHS, f32:$RHS, f32:$LHS, f32:$RHS, SETOGE)),
          (FCMas $LHS, $RHS)>;
def : Pat<(i64 (selectcc i64:$LHS, i64:$RHS, i64:$LHS, i64:$RHS, SETGE)),
          (CMXarr $LHS, $RHS)>;
def : Pat<(i32 (selectcc i32:$LHS, i32:$RHS, i32:$LHS, i32:$RHS, SETGE)),
          (CMSarr $LHS, $RHS)>;

def : Pat<(f64 (selectcc f64:$LHS, f64:$RHS, f64:$LHS, f64:$RHS, SETOLT)),
          (FCMid $LHS, $RHS)>;
def : Pat<(f32 (selectcc f32:$LHS, f32:$RHS, f32:$LHS, f32:$RHS, SETOLT)),
          (FCMis $LHS, $RHS)>;
def : Pat<(i64 (selectcc i64:$LHS, i64:$RHS, i64:$LHS, i64:$RHS, SETLT)),
          (CMXirr $LHS, $RHS)>;
def : Pat<(i32 (selectcc i32:$LHS, i32:$RHS, i32:$LHS, i32:$RHS, SETLT)),
          (CMSirr $LHS, $RHS)>;
def : Pat<(f64 (selectcc f64:$LHS, f64:$RHS, f64:$LHS, f64:$RHS, SETOLE)),
          (FCMid $LHS, $RHS)>;
def : Pat<(f32 (selectcc f32:$LHS, f32:$RHS, f32:$LHS, f32:$RHS, SETOLE)),
          (FCMis $LHS, $RHS)>;
def : Pat<(i64 (selectcc i64:$LHS, i64:$RHS, i64:$LHS, i64:$RHS, SETLE)),
          (CMXirr $LHS, $RHS)>;
def : Pat<(i32 (selectcc i32:$LHS, i32:$RHS, i32:$LHS, i32:$RHS, SETLE)),
          (CMSirr $LHS, $RHS)>;

// Generic SELECTCC pattern matches
//
//   CMP  %tmp, %l, %r       ; compare %l and %r
//   or   %res, %f, (0)1     ; initialize by %f
//   CMOV %res, %t, %tmp     ; set %t if %tmp is true

// selectcc for i64 result
def : Pat<(i64 (selectcc i32:$l, i32:$r, i64:$t, i64:$f, CCSIOp:$cond)),
          (CMOVWrr (icond2cc $cond), (CPSrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc i32:$l, i32:$r, i64:$t, i64:$f, CCUIOp:$cond)),
          (CMOVWrr (icond2cc $cond), (CMPUWrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc i64:$l, i64:$r, i64:$t, i64:$f, CCSIOp:$cond)),
          (CMOVLrr (icond2cc $cond), (CPXrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc i64:$l, i64:$r, i64:$t, i64:$f, CCUIOp:$cond)),
          (CMOVLrr (icond2cc $cond), (CMPrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc f32:$l, f32:$r, i64:$t, i64:$f, cond:$cond)),
          (CMOVSrr (fcond2cc $cond), (FCPSrr $l, $r), $t, $f)>;
def : Pat<(i64 (selectcc f64:$l, f64:$r, i64:$t, i64:$f, cond:$cond)),
          (CMOVDrr (fcond2cc $cond), (FCPrr $l, $r), $t, $f)>;

// selectcc for i32 result
def : Pat<(i32 (selectcc i32:$l, i32:$r, i32:$t, i32:$f, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrr (icond2cc $cond),
                       (CPSrr $l, $r),
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
                       (CPXrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;
def : Pat<(i32 (selectcc i64:$l, i64:$r, i32:$t, i32:$f, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrr (icond2cc $cond),
                       (CMPrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;
def : Pat<(i32 (selectcc f32:$l, f32:$r, i32:$t, i32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVSrr (fcond2cc $cond),
                       (FCPSrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;
def : Pat<(i32 (selectcc f64:$l, f64:$r, i32:$t, i32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVDrr (fcond2cc $cond),
                       (FCPrr $l, $r),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $t, sub_i32),
                       (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $f, sub_i32)),
              sub_i32)>;

// selectcc for f64 result
def : Pat<(f64 (selectcc i32:$l, i32:$r, f64:$t, f64:$f, CCSIOp:$cond)),
          (CMOVWrr (icond2cc $cond), (CPSrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc i32:$l, i32:$r, f64:$t, f64:$f, CCUIOp:$cond)),
          (CMOVWrr (icond2cc $cond), (CMPUWrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc i64:$l, i64:$r, f64:$t, f64:$f, CCSIOp:$cond)),
          (CMOVLrr (icond2cc $cond), (CPXrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc i64:$l, i64:$r, f64:$t, f64:$f, CCUIOp:$cond)),
          (CMOVLrr (icond2cc $cond), (CMPrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc f32:$l, f32:$r, f64:$t, f64:$f, cond:$cond)),
          (CMOVSrr (fcond2cc $cond), (FCPSrr $l, $r), $t, $f)>;
def : Pat<(f64 (selectcc f64:$l, f64:$r, f64:$t, f64:$f, cond:$cond)),
          (CMOVDrr (fcond2cc $cond), (FCPrr $l, $r), $t, $f)>;

// selectcc for f32 result
def : Pat<(f32 (selectcc i32:$l, i32:$r, f32:$t, f32:$f, CCSIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVWrr (icond2cc $cond), 
                       (CPSrr $l, $r),
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
                       (CPXrr $l, $r),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;
def : Pat<(f32 (selectcc i64:$l, i64:$r, f32:$t, f32:$f, CCUIOp:$cond)),
          (EXTRACT_SUBREG
              (CMOVLrr (icond2cc $cond), 
                       (CMPrr $l, $r),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;
def : Pat<(f32 (selectcc f32:$l, f32:$r, f32:$t, f32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVSrr (fcond2cc $cond), 
                       (FCPSrr $l, $r), 
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $t, sub_f32),
                       (INSERT_SUBREG (f64 (IMPLICIT_DEF)), $f, sub_f32)),
              sub_f32)>;
def : Pat<(f32 (selectcc f64:$l, f64:$r, f32:$t, f32:$f, cond:$cond)),
          (EXTRACT_SUBREG
              (CMOVDrr (fcond2cc $cond), 
                       (FCPrr $l, $r),
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

// Several special pattern matches to optimize code

def : Pat<(i32 (and i32:$lhs, 0xff)),
          (AND32rm0 $lhs, 56)>;
def : Pat<(i32 (and i32:$lhs, 0xffff)),
          (AND32rm0 $lhs, 48)>;
def : Pat<(i32 (and i32:$lhs, 0xffffffff)),
          (AND32rm0 $lhs, 32)>;

include "VEInstrVec.td"
