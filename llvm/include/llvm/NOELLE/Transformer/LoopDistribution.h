#ifndef LLVM_NOELLE_LOOP_DISTRIBUTION
#define LLVM_NOELLE_LOOP_DISTRIBUTION

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Dominators.h"
#include "llvm/NOELLE/PDG/PDG.h"
#include "llvm/Transforms/Utils/ValueMapper.h"

namespace llvm {

namespace noelle {

/* Casey's basic principles on API design:

1) Granularity: A or BC
   -- Flexibility vs Simplicity --

2) Redundancy: A or B
   -- Convenience vs Orthogonality --

3) Coupling: A implies B
   -- Always bad --

4) Retention: The API retains user's data.
   -- Synchronization vs Automation --

5) Flow-Control: Does the API ever call
   back the user ?
   -- If yes, it's bad --

*/



/* Characteristics of this API:
1) Granularity: Explored to a high-degree. You should
be able to compose building blocks (i.e., functions) to the
finer-grained way possible.

2) Redundancy: There's a big TODO - IMPORTANT in redundancy and
that is to support some other set than std::set. But otherwise,
we probably have enough redundancy from granularity

3) There are not many things that are coupled. Probably the biggest
one is the preservation of PDG along with the removal of instructions.
Changing that would probably require a lot of work (and it would
require back calls to preservation).

4) Retention: This API retains nothing. We may actually explore
retention to make coarse-grained but not too coarse-grained calls
easy.

5) Flow-Control: This API never calls the user.
*/

/* ---------------- Loop Distribution Method -------------------------
 * SCC are the instructions that we want to distribute in their own
 * loop. However, those instructions may depend on other instructions which
 * forces us to clone the latter along with the former. We call the latter
 * InstsToClone.

 * Notice that the term "clone" is important here as these
 * instructions will appear in both loops. The general method we'll follow is:
 * - Gather all branches and anything they depend on in InstsToClone
 * - Gather all instructions which SCC depend on in InstsToClone
 * - Here, you want to check that SCC U InstsToClone is smaller than
 *   the whole loop, otherwise there's no point doing the distribution.
 * - Clone the loop above:
 *
 *   - In the original loop, remove SCC (only! you don't want to remove
 InstsToClone,
 *     those are supposed to be in both loops). The problem here is that some
 instructions from
 *     the original loop may depend on some insts in SCC (and not
 *     be in the set). We want to preserve these specific SCC. The problem is
 *     however that if you keep at least one instruction from the SCC, you
 have
 *     to keep the _whole_ SCC because er... it is an SCC! Every instruction
 *     transitively depends on every other instruction.
 *
 *     The full story here is more intricate. See note on loop distribution
 legality below.
 *
 *   - In the copy, called NewLoop, remove all instructions except SCC
 *     and InstsToClone (notice that there can't be an instruction `I` that is
 *     not in one of these two sets and some instruction from any of these two
 *     sets to depend on `I`. The reason for that is because InstsToClone
 gathered
 *     all dependences recursively from both sets).
 *
 *     Note that if SCC union InstsToClone is the whole original
 *     loop, then there's no point doing the distribution and the split is
 trivial.
 *
 *     ----- NOTE: Loop distribution legality -----
 *
 *     There can be an instruction outside the cycle that depends on (some
 instruction in) it
 *     and the distribution could still be valid. Consider this:

       for (...) {
         S1: int l1 = A[i-1];
         S2: A[i] = l1 + d;

         S3: int l2 = A[i-2];
         S4: B[i] = l2 + c;
       }
 *
 *     Apparently, there's the {S1, S2} cycle. You can see though that S3
 depends on S2 and S3 is
 *     outside the cycle. However, we can actually distribute the loop because
 if we take any memory
 *     location in A, the loop first stores to it and _then_ l2 loads from
 that! So, if we do
 *     all the stores together first (which happens if we distribute the loop)
 and then all the stores,
 *     there's no problem.
 *
 *     Constrast this with the following:
 *
       for (...) {
         S1: int l1 = A[i-1];
         S2: A[i] = l1 + d;

         S3: int l2 = A[i+1];
         S4: B[i] = l2 + c;
       }
 *
 *     Now, in any memory location of A, l2 first loads from that and _then_
 S2 stores to it! If we
 *     distribute the loop, the store will write the locations before l2 has
 chance to read them.
 *
 *     To sum up, loop distribution is legal if any location that we store to
 from _within_ the cycle
 *     is written before any instruction from _outside_ the cycle reads from
 it.
 */

/*
 * Checkers: These functions just check facts. They don't change the inputs.
 */

Loop *SCCSpansOneLoop(const std::set<Instruction *> &SCC, const LoopInfo &LI);
bool isLoopDistributable(const Loop *L);
bool isLegalToRemoveSCCFromLoop(const std::set<Instruction *> &SCC,
                                const Loop *OrigLoop, const PDG *LoopPDG);
bool isSCCDistributionTrivial(const std::set<Instruction *> &SCC,
                              const LoopInfo &LI, const Loop *OrigLoop,
                              const PDG *LoopPDG,
                              const std::set<const Instruction *> &InstsToClone);

/*
 * Gatherers: These functions gather data, without changing any data structures.
 */

void findInstsToClone(const std::set<Instruction *> &SCC, const PDG *LoopPDG,
                      const Loop *OrigLoop,
                      std::set<const Instruction *> &InstsToClone);

/*
 * Core Manipulators: These functions manipulate the code in different levels
 * of granularity.
 */

// Preserve PDG and removes unneeded instructions from both loops. PDG preservation
// is coupled with instruction removal because it assumes it's going to happen (note
// however that the inverse coupling does not hold)
void preservePDGAndRemoveInstructions(
    DominatorTree &DT, LoopInfo &LI, PDG *ModulePDG, Loop *OrigLoop,
    Loop *NewLoop, const std::set<Instruction *> &SCC,
    const std::set<const Instruction *> &InstsToClone,
    ValueToValueMapTy &MapOrigToNew);

void removeSCCFromOriginal(const std::set<Instruction *> &SCC);

// Remove unneeded instructions (those that are neither in SCC nor in InstsToClone)
// from the new loop.
void removeInstructionsFromNewLoop(
    const Loop *OrigLoop, const std::set<Instruction *> &SCC,
    const std::set<const Instruction *> &InstsToClone,
    ValueToValueMapTy &MapOrigToNew);

// Removes unneeded instructions from both loops.
void removeInstructions(Loop *OrigLoop, Loop *NewLoop,
                        const std::set<Instruction *> &SCC,
                        const std::set<const Instruction *> &InstsToClone,
                        ValueToValueMapTy &MapOrigToNew);

// You call that just to clone the loop and only update DT and LI only.
// It assumes that you have already checked that the loop is distributable.
// Note that cloning is currently coupled with DT preservation. It's probably
// not a problem but even if we want to decouple them, we can easily do it.
Loop *cloneLoop(Loop *OrigLoop, ValueToValueMapTy &VMap, LoopInfo &LI,
                DominatorTree &DT);

// If you have checked (or not) that the loop can be cloned,
// that SCC spans only one loop and that the split
// is not trivial, then you call this splitter to do the split and
// preserve analyses (it returns void because it assumes the split
// can happen).
void splitSCCUnchecked(const std::set<Instruction *> &SCC, const PDG *LoopPDG,
                       const std::set<const Instruction *> &InstsToClone,
                       PDG *ModulePDG, LoopInfo &LI, DominatorTree &DT,
                       Loop *OrigLoop);

// This is the most coarse-grained call. You call the splitter and it will check
// legality and triviality constraints itself. It will return you true if it succeeded
// in splitting the SCC out of the loop by preserving all analyses. Otherwise, false/
bool splitSCC(const std::set<Instruction *> &SCC, PDG *ModulePDG, LoopInfo &LI,
              DominatorTree &DT);

} // namespace noelle

} // namespace llvm

#endif // LLVM_NOELLE_LOOP_DISTRIBUTION