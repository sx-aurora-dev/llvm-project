#ifndef LLVM_NOELLE_LOOP_INTERCHANGE
#define LLVM_NOELLE_LOOP_INTERCHANGE

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/NOELLE/PDG/PDG.h"
#include "llvm/Transforms/Utils/ValueMapper.h"

namespace llvm {

namespace noelle {

// These loops are guaranteed to be:
// a) In the same loop nest
// b) It is "semi-perfect" (i.e. each loop has one child loop)
struct LoopsToInterchange {
  Loop *Outer, *Inner;
};

bool interchangeLoops(LoopsToInterchange loopsToInterchange, DominatorTree &DT,
                      LoopInfo &LI, ScalarEvolution &SE, Function &F);

} // namespace noelle

} // namespace llvm

#endif // LLVM_NOELLE_LOOP_INTERCHANGE