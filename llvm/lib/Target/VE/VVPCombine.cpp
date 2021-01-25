#include "MCTargetDesc/VEMCExpr.h"
#include "VEISelLowering.h"
#include "VEInstrBuilder.h"
#include "VEMachineFunctionInfo.h"
#include "VERegisterInfo.h"
#include "VETargetMachine.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/CodeGen/CallingConvLower.h"
#include "llvm/CodeGen/MachineFrameInfo.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/MachineJumpTableInfo.h"
#include "llvm/CodeGen/MachineModuleInfo.h"
#include "llvm/CodeGen/MachineRegisterInfo.h"
#include "llvm/CodeGen/SelectionDAG.h"
#include "llvm/CodeGen/TargetLoweringObjectFileImpl.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/IntrinsicsVE.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"
#include "llvm/Support/CommandLine.h"

#include "CustomDAG.h"

#ifdef DEBUG_TYPE
#undef DEBUG_TYPE
#endif
#define DEBUG_TYPE "vvp-combine"

using namespace llvm;

// Optimize packed mode patterns.
static cl::opt<bool>
OptimizePackedMode("ve-optimize-packed",
    cl::init(true),
    cl::desc("Simplify packed mode patterns"),
    cl::Hidden);

static cl::opt<bool> ExpandOverPackedRegisterCopies(
    "ve-expand-overpacked-copies", cl::init(true),
    cl::desc("Expand physical register copies during isel to assist register "
             "coalescing in packed  mode."),
    cl::Hidden);

using Matcher = std::function<bool(SDValue)>;

static int match_SomeOperand(SDNode *Op, unsigned VVPOpcode, Matcher M) {
  for (int i = 0; i < 2; ++i) {
    if ((Op->getOperand(i)->getOpcode() == VVPOpcode) && M(Op->getOperand(i))) {
      return i;
    }
  }
  return -1;
}

// vz * vw + vy
static bool match_FFMA(SDNode *Root, SDValue &VY, SDValue &VZ, SDValue &VW,
                       SDValue &Mask, SDValue &AVL) {
  if (Root->getOpcode() != VEISD::VVP_FADD)
    return false;

  // Detect contractable FMUL leaf.
  int MulIdx = match_SomeOperand(Root, VEISD::VVP_FMUL, [](SDValue Op) {
    return Op->hasOneUse() && Op->getFlags().hasAllowContract();
  });
  if (MulIdx < 0)
    return false;
  assert(MulIdx < 2);
  const int LeafIdx = 1 - MulIdx;

  // Take apart.
  SDValue MulV = Root->getOperand(MulIdx);
  VY = Root->getOperand(LeafIdx);
  VZ = MulV->getOperand(0);
  VW = MulV->getOperand(1);
  Mask = Root->getOperand(2);
  AVL = Root->getOperand(3);
  return true;
}

// vz * vw - vy
static bool match_FFMS(SDNode *Root, SDValue &VY, SDValue &VZ, SDValue &VW,
                       SDValue &Mask, SDValue &AVL, bool &Negated) {
  if (Root->getOpcode() != VEISD::VVP_FSUB)
    return false;

  // Detect contractable FMUL leaf.
  int MulIdx = match_SomeOperand(Root, VEISD::VVP_FMUL, [](SDValue Op) {
    return Op->hasOneUse() && Op->getFlags().hasAllowContract();
  });
  if (MulIdx < 0)
    return false;
  assert(MulIdx < 2);
  const int LeafIdx = 1 - MulIdx;
  Negated = (MulIdx == 1);

  // Take apart.
  SDValue MulV = Root->getOperand(MulIdx);
  assert(MulV->getOpcode() == VEISD::VVP_FMUL);
  VY = Root->getOperand(LeafIdx);
  VZ = MulV->getOperand(0);
  VW = MulV->getOperand(1);
  Mask = Root->getOperand(2);
  AVL = Root->getOperand(3);
  return true;
}

SDValue VETargetLowering::combineVVP(SDNode *N, DAGCombinerInfo &DCI) const {
  if (!OptimizePackedMode)
    return SDValue();
  // Perform this shortly before isel.
  if (!DCI.isAfterLegalizeDAG())
    return SDValue();

  // TODO: optimize
  LLVM_DEBUG(dbgs() << "combineVVP: "; N->print(dbgs(), &DCI.DAG);
             dbgs() << "\n";);

  CustomDAG CDAG(*this, DCI.DAG, N);
  switch (N->getOpcode()) {
  case VEISD::VVP_FADD: {
    SDValue VY, VZ, VW, Mask, AVL;
    if (match_FFMA(N, VY, VZ, VW, Mask, AVL)) {
      MVT ResVT = N->getSimpleValueType(0);
      return CDAG.getNode(VEISD::VVP_FFMA, ResVT, {VY, VZ, VW, Mask, AVL});
    }
  } break;
  case VEISD::VVP_FSUB: {
    SDValue VY, VZ, VW, Mask, AVL;
    bool Negated;
    if (match_FFMS(N, VY, VZ, VW, Mask, AVL, Negated)) {
      MVT ResVT = N->getSimpleValueType(0);
      unsigned Opcode = Negated ? VEISD::VVP_FFMSN : VEISD::VVP_FFMS;
      return CDAG.getNode(Opcode, ResVT, {VY, VZ, VW, Mask, AVL});
    }
  } break;
  default:
    break;
  }
  return SDValue();
}

// What 32bit half to pack this scalar VT (or this vector's elem VT to).
static SDValue match_ReplLoHi(SDValue N, PackElem &SrcElem) {
  switch (N->getOpcode()) {
  case VEISD::REPL_I32:
    SrcElem = PackElem::Lo;
    return N->getOperand(0);
  case VEISD::REPL_F32:
    SrcElem = PackElem::Hi;
    return N->getOperand(0);
  default:
    return SDValue();
  }
}

static SDValue match_UnpackLoHi(SDValue N, PackElem &SrcElem) {
  switch (N->getOpcode()) {
  case VEISD::VEC_UNPACK_LO:
    SrcElem = PackElem::Lo;
    return N->getOperand(0);
  case VEISD::VEC_UNPACK_HI:
    SrcElem = PackElem::Hi;
    return N->getOperand(0);
  default:
    return SDValue();
  }
}

// vec_broadcast(ret, AVL)
static SDValue match_Broadcast(SDValue N, SDValue & AVL) {
  if (N->getOpcode() != VEISD::VEC_BROADCAST)
    return SDValue();
  AVL = N->getOperand(1);
  return N->getOperand(0);
}

// vec_unpack_X(vec_broadcast(ret))
static SDValue
match_UnpackBroadcast(SDNode *N, PackElem & UnpackElem, SDValue & BroadcastAVL) {
  SDValue UnpackedV = match_UnpackLoHi(SDValue(N, 0), UnpackElem);
  if (!UnpackedV) return SDValue();
  SDValue UnpackedBroadcastV = match_Broadcast(UnpackedV, BroadcastAVL);
  if (!UnpackedBroadcastV) return SDValue();
  return UnpackedBroadcastV;
}

// vec_unpack_X(vec_broadcast(%ret = repl_Y(...), %avl))
static SDValue match_UnpackBroadcastRepl(SDNode *N, SDValue &AVL) {
  PackElem UnpackElem;
  SDValue UnpackedBroadcastV = match_UnpackBroadcast(N, UnpackElem, AVL);
  if (!UnpackedBroadcastV)
    return SDValue();
  PackElem ReplElem;
  SDValue ReplV = match_ReplLoHi(UnpackedBroadcastV, ReplElem);
  if (!ReplV)
    return SDValue();

  return UnpackedBroadcastV;
}

static SDValue combineUnpackLoHi(CustomDAG &CDAG, SDNode *N,
                                 VETargetLowering::DAGCombinerInfo &DCI) {
  // Replace vec_unpack(vec_broadcast(repl_X(V)) with
  // vec_broadcast(repl_X(V)) to enable folding.
  SDValue AVL;
  SDValue ReplV = match_UnpackBroadcastRepl(N, AVL);
  if (!ReplV) {
    // TODO Optimize U = unpack_X(pack(lo,hi)) -> lo|hi where 'U' only used by
    // pack.
    return SDValue();
  }

  // Directly replace vec_broadcast(repl_X(V)) with a plain vec_broadcast(V).
  // Bits read from destination register are the same part as the value that is
  // replicated? Remove replication!
  PackElem UsedDestPart = getPackElemForVT(N->getValueType(0));
  PackElem ReplPart;
  match_ReplLoHi(ReplV, ReplPart);
  if (UsedDestPart == ReplPart)
    return CDAG.CreateBroadcast(N->getValueType(0), ReplV->getOperand(0), AVL);

  // At least simplify to a plain packed broadcast.
  return CDAG.CreateBroadcast(N->getValueType(0), ReplV, AVL);
}

SDValue VETargetLowering::combinePacking(SDNode *N, DAGCombinerInfo &DCI) const {
  if (!OptimizePackedMode)
    return SDValue();
  // Perform this shortly before isel.
  if (!DCI.isAfterLegalizeDAG())
    return SDValue();

  LLVM_DEBUG(dbgs() << "combinePacking: "; N->print(dbgs(), &DCI.DAG); dbgs() << "\n";);
  CustomDAG CDAG(*this, DCI.DAG, N);
  switch (N->getOpcode()) {
    case VEISD::VEC_UNPACK_HI:
    case VEISD::VEC_UNPACK_LO:
      return combineUnpackLoHi(CDAG, N, DCI);

    // case VEISD::VEC_PACK:
    // case VEISD::VEC_SWAP:
    default:
      break;
  }
  return SDValue();
}

#if 0
// FIXME We have to do this in ::LowerFormalArguments
SDValue VETargetLowering::combineCopyFromRegVVP(SDNode *N,
                                              DAGCombinerInfo &DCI) const {
  // Perform this shortly before isel.
  if (!DCI.isBeforeLegalize())
    return SDValue();
  if (!ExpandOverPackedRegisterCopies)
    return SDValue();

  if (!isOverPackedType(N->getValueType(0)))
    return SDValue();

  LLVM_DEBUG(dbgs() << "Found over-packed CopyFromReg:";
             N->print(dbgs(), &DCI.DAG); dbgs() << "\n"; );

  // Decompose & check that this is an over-packed CopyFromReg.
  auto Chain = N->getOperand(0);
  auto PhysRegV = N->getOperand(1);
  auto SrcPhysReg = cast<RegisterSDNode>(PhysRegV)->getReg();
  assert(SrcPhysReg.isVirtual());
  auto *TRI = Subtarget->getRegisterInfo();

  EVT PackVT = N->getValueType(0);
  EVT PartScaVT = PackVT.getScalarType();
  EVT PartVT;
  if (PartScaVT == MVT::f64)
    PartVT = MVT::v256f64;
  else if (PartScaVT == MVT::i64)
    PartVT = MVT::v256i64;
  else
    llvm_unreachable("Unexpected over-packed type!");

  SDValue LoVal, HiVal;

  // Expand to V64 CopyFromReg.
  CustomDAG CDAG(*this, DCI.DAG, N);
  for (auto Part : {PackElem::Lo, PackElem::Hi}) {
    unsigned SubRegIdx = getOverPackedSubRegIdx(Part);
    // auto SrcPartReg = TRI->getSubReg(SrcPhysReg, SubRegIdx);
    unsigned V64SubRegIdx = 2 * SrcPhysReg.virtRegIndex() + (unsigned) Part;

    SDValue CopyVal = CDAG.DAG.getCopyFromReg(Chain, CDAG.DL, SrcPartReg, PartVT);
    Chain = SDValue(CopyVal.getNode(), 1);
    if (Part == PackElem::Lo)
      LoVal = CopyVal;
    else 
      HiVal = CopyVal;
  }

  // Re-package both parts as values and put the chain back in.
  auto RePacked = CDAG.CreatePack(PackVT, LoVal, HiVal,
                                  CDAG.getConstEVL(StandardVectorWidth));
  return CDAG.getMergeValues({RePacked, Chain});
}
#endif

SDValue VETargetLowering::combineCopyToRegVVP(SDNode *N,
                                              DAGCombinerInfo &DCI) const {
  // Perform this shortly before isel.
  if (!DCI.isAfterLegalizeDAG())
    return SDValue();
  if (!ExpandOverPackedRegisterCopies)
    return SDValue();

  // Decompose & check that this is an over-packed copy.
  auto Chain = N->getOperand(0);
  auto PhysRegV = N->getOperand(1);
  auto DestPhysReg = cast<RegisterSDNode>(PhysRegV)->getReg();
  auto SrcV = N->getOperand(2);
  bool HasSrcGlue = N->getNumOperands() == 4;
  SDValue SrcGlue;
  if (HasSrcGlue)
    SrcGlue = N->getOperand(3);
  if (!isOverPackedType(SrcV.getValueType()))
    return SDValue();

  LLVM_DEBUG(dbgs() << "Found over-packed CopyToReg:";
             N->print(dbgs(), &DCI.DAG); dbgs() << "\n"; );

  // Match a feeding vec_pack operation.
  if (SrcV->getOpcode() != VEISD::VEC_PACK)
    return SDValue();
  SDValue LoSrcVal = SrcV->getOperand(0);
  SDValue HiSrcVal = SrcV->getOperand(1);
  auto *TRI = Subtarget->getRegisterInfo();

  // Expand to V64 CopyToReg.
  CustomDAG CDAG(*this, DCI.DAG, N);
  for (auto Part : {PackElem::Lo, PackElem::Hi}) {
    unsigned SubRegIdx = getOverPackedSubRegIdx(Part);
    auto DestPartReg = TRI->getSubReg(DestPhysReg, SubRegIdx);
    SDValue PartV =Part == PackElem::Lo ? LoSrcVal : HiSrcVal;
    Chain = CDAG.DAG.getCopyToReg(Chain, CDAG.DL, DestPartReg, PartV, SrcGlue);
    SrcGlue = SDValue(Chain.getNode(), 1);
  }

  return Chain;
}
