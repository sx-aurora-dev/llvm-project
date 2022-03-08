#include "VVPCombine.h"

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
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/KnownBits.h"

#include "VECustomDAG.h"

#ifdef DEBUG_TYPE
#undef DEBUG_TYPE
#endif
#define DEBUG_TYPE "vvp-combine"

using namespace llvm;

// Optimize packed mode patterns.
static cl::opt<bool>
    OptimizePackedMode("ve-optimize-packed", cl::init(true),
                       cl::desc("Simplify packed mode patterns"), cl::Hidden);

// Optimize packed mode patterns.
static cl::opt<bool>
    FuseOps("ve-fuse-ops", cl::init(true),
                       cl::desc("Perform aggressive fmul/fadd/fsub."), cl::Hidden);

static cl::opt<bool> ExpandOverPackedRegisterCopies(
    "ve-expand-overpacked-copies", cl::init(true),
    cl::desc("Expand physical register copies during isel to assist register "
             "coalescing in packed  mode."),
    cl::Hidden);

using Matcher = std::function<bool(SDValue)>;

SDValue llvm::getSplatValue(SDNode *N) {
  if (auto *BuildVec = dyn_cast<BuildVectorSDNode>(N)) {
    return BuildVec->getSplatValue();
  }
  if (N->getOpcode() != VEISD::VEC_BROADCAST)
    return SDValue();

  return N->getOperand(0);
}

bool llvm::match_FPOne(SDValue V) {
  SDValue S = getSplatValue(V.getNode());
  if (S)
    return match_FPOne(S);

  auto FPConst = dyn_cast<ConstantFPSDNode>(V);
  if (!FPConst)
    return false;

  return FPConst->isExactlyValue(1.0);
}

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

static bool match_Reciprocal(SDNode *N, SDValue &VX, SDValue &Mask,
                             SDValue &AVL) {
  // Fold VFRCP.
  if (N->getOpcode() != VEISD::VVP_FDIV ||
      !N->getFlags().hasAllowReciprocal() || !match_FPOne(N->getOperand(0)))
    return false;

  Mask = N->getOperand(2);
  AVL = N->getOperand(3);
  VX = N->getOperand(1);
  return true;
}

static bool match_AllowReciprocalDiv(SDNode *N, SDValue &VX, SDValue &VY,
                                     SDValue &Mask, SDValue &AVL) {
  // Invert VRCP.
  if (N->getOpcode() != VEISD::VVP_FDIV || !N->getFlags().hasAllowReciprocal())
    return false;

  VX = N->getOperand(0);
  VY = N->getOperand(1);
  Mask = N->getOperand(2);
  AVL = N->getOperand(3);
  return true;
}

static bool match_Sqrt(SDNode *N, SDValue &VX, SDValue &Mask, SDValue &AVL) {
  if (N->getOpcode() != VEISD::VVP_FSQRT)
    return false;
  VX = N->getOperand(0);
  Mask = N->getOperand(1);
  AVL = N->getOperand(2);
  return true;
}

SDValue VETargetLowering::combineVVP(SDNode *N, DAGCombinerInfo &DCI) const {
  if (!FuseOps)
    return SDValue();
    // Perform this shortly before isel.

  // TODO: optimize
  LLVM_DEBUG(dbgs() << "combineVVP: "; N->print(dbgs(), &DCI.DAG);
             dbgs() << "\n";);

  VECustomDAG CDAG(*this, DCI.DAG, N);
  SDNodeFlags Flags = N->getFlags();
  switch (N->getOpcode()) {

  // Fuse FMA, FMSB, FNMA, FNMSB, ..
  case VEISD::VVP_FADD: {
    SDValue VY, VZ, VW, Mask, AVL;
    if (match_FFMA(N, VY, VZ, VW, Mask, AVL)) {
      MVT ResVT = N->getSimpleValueType(0);
      auto N =
          CDAG.getNode(VEISD::VVP_FFMA, ResVT, {VY, VZ, VW, Mask, AVL}, Flags);
      return N;
    }
  } break;
  case VEISD::VVP_FSUB: {
    SDValue VY, VZ, VW, Mask, AVL;
    bool Negated;
    if (match_FFMS(N, VY, VZ, VW, Mask, AVL, Negated)) {
      MVT ResVT = N->getSimpleValueType(0);
      unsigned Opcode = Negated ? VEISD::VVP_FFMSN : VEISD::VVP_FFMS;
      auto N = CDAG.getNode(Opcode, ResVT, {VY, VZ, VW, Mask, AVL}, Flags);
      return N;
    }
  } break;
  // TODO FFP_FNEG match root

  // Fuse recip(sqrt(vx))
  case VEISD::VVP_FRCP: {
    if (!N->getFlags().hasAllowContract())
      break;
    SDValue VX, Mask, AVL;
    if (!match_Sqrt(N->getOperand(0).getNode(), VX, Mask, AVL))
      break;
    MVT ResVT = N->getSimpleValueType(0);
    auto N = CDAG.getNode(VEISD::VVP_FRSQRT, ResVT, {VX, Mask, AVL}, Flags);
    return N;
  }

  // Fuse reciprocals.
  case VEISD::VVP_FDIV: {
    SDValue VX, VY, Mask, AVL;
    MVT ResVT = N->getSimpleValueType(0);
    if (!match_AllowReciprocalDiv(N, VX, VY, Mask, AVL)) 
      return SDValue();
    // 1 / vy
    if (match_FPOne(VX)) {
      auto N = CDAG.getNode(VEISD::VVP_FRCP, ResVT, {VY, Mask, AVL}, Flags);
      return N;
    }
    // vx * VRCP(vy)
    auto RecipV =
        CDAG.getNode(VEISD::VVP_FRCP, ResVT, {VY, Mask, AVL}, Flags);
    auto MulV =
        CDAG.getNode(VEISD::VVP_FMUL, ResVT, {VX, RecipV, Mask, AVL}, Flags);
    return MulV;
  } break;
  default:
    break;
  }
  return SDValue();
}

// What 32bit half to pack this scalar VT (or this vector's elem VT to).
SDValue llvm::match_ReplLoHi(SDValue N, PackElem &SrcElem) {
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
static SDValue match_Broadcast(SDValue N, SDValue &AVL) {
  if (N->getOpcode() != VEISD::VEC_BROADCAST)
    return SDValue();
  AVL = N->getOperand(1);
  return N->getOperand(0);
}

// vec_unpack_X(vec_broadcast(ret))
static SDValue match_UnpackBroadcast(SDValue N, PackElem &UnpackElem,
                                     SDValue &BroadcastAVL) {
  SDValue UnpackedV = match_UnpackLoHi(N, UnpackElem);
  if (!UnpackedV)
    return SDValue();
  SDValue UnpackedBroadcastV = match_Broadcast(UnpackedV, BroadcastAVL);
  if (!UnpackedBroadcastV)
    return SDValue();
  return UnpackedBroadcastV;
}

// broadcast(%ret = repl_X)
static SDValue match_BroadcastRepl(SDValue N, PackElem &ReplElem,
                                   SDValue &BroadcastAVL) {
  SDValue SplatV = match_Broadcast(N, BroadcastAVL);
  if (!SplatV)
    return SDValue();
  if (SDValue ReplV = match_ReplLoHi(SplatV, ReplElem))
     return SplatV;
  return SDValue();
}

// vec_unpack_X(vec_broadcast(%ret = repl_Y(...), %avl))
static SDValue match_UnpackBroadcastRepl(SDValue N, SDValue &AVL) {
  PackElem UnpackElem;
  SDValue PackedV = match_UnpackLoHi(N, UnpackElem);
  if (!PackedV)
    return SDValue();

  PackElem ReplElem;
  SDValue UnpackedBroadcastV = match_BroadcastRepl(N, ReplElem, AVL);
  return UnpackedBroadcastV;
}

SDValue combineUnpackLoHi(VECustomDAG &CDAG, SDValue N) {
  PackElem UnpackElem;
  SDValue PackedV = match_UnpackLoHi(N, UnpackElem);
  if (!PackedV)
    return SDValue();

  SDValue AVL = getUnpackAVL(N);
  return combineUnpackLoHi(PackedV, UnpackElem, N.getValueType(), AVL, CDAG);
}

SDValue llvm::combineUnpackLoHi(SDValue PackedVec, PackElem UnpackPart,
                                EVT DestVT, SDValue UnpackAVL,
                                const VECustomDAG &CDAG) {
  LLVM_DEBUG(dbgs() << "Online combiningUnpackLoHi from ";
             CDAG.print(dbgs(), PackedVec) << "\n";);
  // Replace vec_unpack(vec_broadcast(repl_X(V)) with
  // vec_broadcast(repl_X(V)) to enable folding.
  PackElem ReplElem;
  SDValue AVL;
  SDValue ReplV = match_BroadcastRepl(PackedVec, ReplElem, AVL);
  if (!ReplV)
    return SDValue();

  // Directly replace the packed vec_broadcast(repl_X(V)) with a plain regular
  // vec_broadcast(V). Bits read from destination register are the same part as
  // the value that is replicated? Remove replication!
  PackElem UsedDestPart = getPackElemForVT(DestVT);
  PackElem ReplPart;
  match_ReplLoHi(ReplV, ReplPart);
  if (UsedDestPart != ReplPart) return SDValue();

  return CDAG.getBroadcast(DestVT, ReplV->getOperand(0), AVL);
}

SDValue VETargetLowering::combinePacking(SDNode *N,
                                         DAGCombinerInfo &DCI) const {
  if (!OptimizePackedMode)
    return SDValue();
    // Perform this shortly before isel.
#if 0
  if (!DCI.isAfterLegalizeDAG())
    return SDValue();
#endif

  LLVM_DEBUG(dbgs() << "combinePacking: "; N->print(dbgs(), &DCI.DAG);
             dbgs() << "\n";);
  VECustomDAG CDAG(*this, DCI.DAG, N);
  switch (N->getOpcode()) {
  case VEISD::VEC_UNPACK_HI:
  case VEISD::VEC_UNPACK_LO: {
    SDValue AsVal(N, 0);
    PackElem UnpackPart = getPartForUnpackOpcode(N->getOpcode());
    EVT DestVT = N->getValueType(0);
    SDValue Pack = getUnpackPackOperand(AsVal);
    SDValue AVL = getUnpackAVL(AsVal);
    return combineUnpackLoHi(Pack, UnpackPart, DestVT, AVL, CDAG);
  }

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
  VECustomDAG CDAG(*this, DCI.DAG, N);
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
  // Bail on virtual register copies.
  if (!DestPhysReg.isPhysical())
    return SDValue();
  auto SrcV = N->getOperand(2);
  bool HasSrcGlue = N->getNumOperands() == 4;
  SDValue SrcGlue;
  if (HasSrcGlue)
    SrcGlue = N->getOperand(3);
  if (!isOverPackedType(SrcV.getValueType()))
    return SDValue();

  LLVM_DEBUG(dbgs() << "Found over-packed CopyToReg:";
             N->print(dbgs(), &DCI.DAG); dbgs() << "\n";);

  // Match a feeding vec_pack operation.
  if (SrcV->getOpcode() != VEISD::VEC_PACK)
    return SDValue();
  SDValue LoSrcVal = SrcV->getOperand(0);
  SDValue HiSrcVal = SrcV->getOperand(1);
  auto *TRI = Subtarget->getRegisterInfo();

  // Expand to V64 CopyToReg.
  VECustomDAG CDAG(*this, DCI.DAG, N);
  for (auto Part : {PackElem::Lo, PackElem::Hi}) {
    unsigned SubRegIdx = getOverPackedSubRegIdx(Part);
    auto DestPartReg = TRI->getSubReg(DestPhysReg, SubRegIdx);
    SDValue PartV = Part == PackElem::Lo ? LoSrcVal : HiSrcVal;
    Chain = CDAG.DAG.getCopyToReg(Chain, CDAG.DL, DestPartReg, PartV, SrcGlue);
    SrcGlue = SDValue(Chain.getNode(), 1);
  }

  return Chain;
}
