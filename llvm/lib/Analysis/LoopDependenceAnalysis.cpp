//===----------- LoopDependenceAnalysis.cpp - Iter Dependences -------------==//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// The implementation of outer-loop vectorization legality analysis for
// for the Region Vectorizer.
//
//===----------------------------------------------------------------------===//

#include "llvm/Analysis/LoopDependenceAnalysis.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/AliasSetTracker.h"
#include "llvm/Analysis/Delinearization.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/TargetLibraryInfo.h"
#include "llvm/Analysis/ValueTracking.h"
#include "llvm/Analysis/VectorUtils.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/ScalarEvolutionExpander.h"

/*

------ Documentation ------

The structure of this doc is as follows. First we introduce some
foundational terminology. Then the algorithm is described in detail, as
a whole, so that it is obvious how every little piece fits into
the whole picture. Any other comments in the rest of the code
are implementation details that are not part of the algorithm per se
and are implementation details (e.g. why use one data structure over another).

-- Terminology --

First of all, we assume that all accesses are in the form
of array accesses (this is a rule that the code does
not follow strictly, but the exceptions are few and simple).

Index:  It is used to mean the index variable (induction variable) for
    some loop surrounding an array access. For example, in:
        A[i][j+1][k-2]
    `i`, `j` and `k` are indexes.

Subscript: It is used to refer to one of the subscripted
    positions in an array reference. For example, in:
      A[i][j+1][k-2]
    the expressions `i`, `j+1` and `k-2` are subscripts
    (which use indices). Note that it is also useful
    to number subscripts. `i` is subscript no. 0,
    `j+1` is no. 1 and `k-2` is no. 2.

Loop Vectorization Factor: It refers to the number of iterations
    that can be run in parallel for a specific loop. For
    example, in:
      int A[n][m];
      for (i = 0; i < n; ++i)
        for (j = 0; j < m; ++j)
          A[i+2][j] = A[i][j];

    The loop vectorization factor for the `i-loop` is 2, since
    we can run the loops in groups of 2. This _looks like_ the
    the following:
      int A[n][m];
      for (i = 0; i < n; i+=2)
        for (j = 0; j < m; ++j) {
          A[i+2][j] = A[i][j];
          A[i+3][j] = A[i+1][j];
        }

    This is like an unroll-and-jam but UAJ is not an accurate
    description since here the two statements are run sequentially
    (although both at the same `j-iteration`) while in vectorization
    they will be run in parallel. As far as DA is concerned,
    in this example both UAJ and vectorization by a factor of 2
    are valid but this is not always the case.

    Finally, the `j-loop` has a VF of infinity, since all iterations can
    be run in parallel.





-- Algorithm --

This describes that algorithm to get the vectorization factor
for a loop, which we'll refer to as the queried loop (QL).




- 0.1 Representing Dependences - Direction and Distance Vectors -

Let's start with an example:

int A[n][m];
for (int i = 0; i < n-1; ++i)
  for (int j = 1; j < m; ++j)
    A[i+1][j-1] = A[i][j];

We have an 2-dimensional loop nest and so a 2-dimensional
iteration space that looks like this:

    i
n-2 | (n-2, 0)  (n-2, 1)  (n-2, 2)      (n-2, m-1)
   ...
  2 | (2, 0)    (2, 1)    (2, 2)        (2, m-1)
  1 | (1, 0)    (1, 1)    (1, 2)        (1, m-1)
    | --------- --------- --------- ... ---------
          0         1         2            m-1

Each cell is an iteration instance (or simply, an iteration)
parameterized by the i and j values at this specific instance.
As time goes forwards, the iterations are executed left to right,
bottom to top (e.g. (1, 0), which btw is the first iteration,
precedes (1, 1) which precedes (2, 0)).

Looking at the code again, we'll see that in iteration (1, 1),
we write to the _memory location_ A[2][0] (it's quite important
to not confuse the _access space_, i.e. the space of memory locations
accessed in the loop with the _iteration space_, the space of
the executed iterations). Then, in iteration (2, 0), we read
from this same location. So, after vectorization (or any transformation
for that matter in order for it to be valid) iteration (1, 1)
must be executed before iteration (2, 0).

What we ultimately care about is the dependences in the iteration
space like that above. That is, what iteration instance(s) has to
be run before some other iteration instance(s)
(because remember, vectorization is about running iteration
instances in parallel). And we want a compact way to describe
such dependences.

The most common way is by using a direction or a distance vector.
The direction vector here would look "upwards" and "to the left" -
imagine an arrow pointing from (1, 1) (the source) to (2, 0) (the sink).
We represent that as (<, >). Each entry in the vector describes
a dimension and the further left the entry, the greater the dimension
it describes (e.g. here the entry '<' describes the 2nd dimension and
biggest dimension i.e. the `i`-axis). '<' represents that we're pointing towards
_greater_ elements in that dimension. In this case, the vector points "upwards",
i.e. towards higher elements in the `i`-axis. Similarly, '>' represents
that we're pointing towards _smaller_ elements in that dimension. In
this case, the vector points "to the left", i.e. towards smaller (or
further to the left) elements in the `j`-axis. There's a third
possible entry for a dimension and that is `=`, which just means
we're pointing to exactly the same value in that dimension. For
example, the vector (<, =) points _directly_ upwards.


Be aware that with this description, the sink of the arrow
(or the end of it, in this case (2, 0))
depends on the source (in this case (1, 1)) of it. Different
literature works describe dependences in the opposite way.

Now, there's also the distance vector which gives us a more
accurate description of the dependence. For example, it not
only tells us e.g. that the vector points "upwards" but "how
far upwards does it point", that is, what is the _distance_
of the dependence in that direction. In that case, the distance
vector would be (1, -1). What we call the dependence vector
in this code is basically a combination of both kinds of vector.
Each entry has both a direction and a distance.




- 0.2 High-level Overview -

This algorithm could be separated intuitevely in two steps.
Given that we're processing an N-dimensional loop nest,
the first step of this algorithm is to get an N-dimensional
dependence vector that describes the dependences between
iterations of the N-dimensional iteration space of this nest.

Then, the second and final step is given an N-dimensional
direction vector, to decide what is the maximum vectorization
factor that we can apply, assuming that we're interested to
vectorize the Nth dimension. As of now, in this implementation,
we have not found a generic way to determine the max
vectorization factor (or dependence distance) in the Nth
dimension of an N-dimensional dependence vector. We
can only handle 1, 2 and 3-dimensional vectors.




- 1. Loop Nest Info -

TODO: We can now handle more complicated things than loop nests.
Document it!

- 2. Gather Accessing Instructions -

The only instructions that we can handle are simple loads and stores.
The rest of the instructions are in one of the following categories:
  - Calls that we know are vectorizable (either as intrinsics or because
    they have a vectorizable counterpart).
  - Instructions that don't read or write to memory.
  - Calls that are convergent.
  - Any other instruction.

The first two categories are safe and we ignore them. Any instruction
in the last two results in immediate failure.




- 3. Test loads against stores -

We test every load against every store. Before we mention the procedure,
we should make clear that this is a very naive approach. We should
only test access pairs that can potentially. We may know (e.g. from the
Alias Set Tracker) that two pointers can never alias. Then, we should
never check pairs of instructions in which the one uses the one pointer
and the other the other.

Second, we should account for output dependences, i.e. stores against
stores. For now however, the focus is on how do we check an access pair
and not what pairs we check. This is not a problem since the former
does not change if the latter changes.




- 4. Delinearization -

Delinearization is the process of lifting linear accesses to
multi-dimensional space (read the related Appedix to understand why we
need to do that).

The best case is that we get as many subscripts as the original access,
with accurate description of the sizes (except the first one, which we
can't even guess in C/C++ just by looking at the access). Note
that subscripts are described with SCEVs. Since one doesn't _have to_
use SCEV, it's rarely referenced in this doc, because one could use
some other way of describing subscripts. But for now, one has to be familiar
with SCEV to understand the implementation.

Once we delinearize them, we verify that some constraints hold.
Progressively we want this verification to have less and less constraints.
Because they change quite often, this is one of the parts that is described
in the relevant function.





- 5.1 Computing the Dependence Distance -

The input of the deduction phase of the dependence vector
is an access pair. Each access has a list of subscripts. In the simple
case, each subscript is an expression of an iteration variable.

Now let's ask the question "how this info helps
us find dependences between iterations?". Let's take a simple
example:

for (int j = 0; j < ...; ++j)
  A[j+1] = A[j];

We have 2 accesses here which access the same space (the space
of the underlying object `A`). Let's take one of those accesses,
A[j]. Notice that by using a loop (induction) variable in the subscript,
we have created an implicit _mapping_ from iteration space
to access space (or vice versa). To put it simpler, we have
connected each iteration (which in this case is represented
by `j`) with a specific cell of `A`. Iteration j = 0 is mapped
to A[0], iteration j = 1 to A[1] and so on. As a side note,
the iteration space is aligned with the access space (the first
iteration is mapped to the first cell, the second iteration to the
second cell and so on).

We have a similar mapping for the other access, A[j+1]. Here
j = 0 is mapped to A[1], j = 1 to A[2] and so on (notice that
the two spaces now are "misaligned" by 1).

The reason that this is important is because a dependence
between two iterations fundamentally arises because in the one
we write and in the other we read _from the same cell_ (or in general,
memory location - note that this is the very reason that
we only analyze accesses that could potentially access the
same memory location, aka alias).
So this mapping from iterations to cells is key.

Another thing to understand here is that iterations are really
just a representation of time. Imagine that each iteration is a moment
and then you see that this mapping from iterations to cells,
for a specific access, is stubbing each cell with a (different)
moment in which this access happens.

Going back to our example, the access A[j] accesses cell A[1]
for a read at moment j = 1 while the access A[j+1] accesses
cell A[1] at moment j = 0 for a write. We don't want these
two accesses to happen in reverse, as far as _time_ is concerned,
or to happen in parallel.

Finally, notice that vectorization is about squeezing time. That is,
if you vectorize a loop by a factor of 4, what previously
happened in 4 distinct moments, now happens at one moment.

Let's now go back to the example: What we're trying to deduce
is "how much difference in time have the accesses A[j] and A[j+1]?".
That's the maximum vectorization factor we can use and it
is also their dependence distance. That's how
much moments we can perform _at once_ before we attempt to
include an illegal moment. And it is
obvious that the amount of time by which they differ is (j+1) - j,
i.e. the difference between the subscripts, since the subscripts
are expressions of the "time variable", i.e. `j`. This is in
_absolute value_, more on that later.

Imagine now that the same thing happens when we're having
multi-dimensional accesses. It's just that now time
has become a multi-dimensional entity. For example, in an
access like A[i][j], the "moment" (0, 0) is connected with
the cell A[0][0]. But the concept is still the same.

The important thing is that if we're analyzing pairs of accesses,
these accesses have to ultimately have a _constant_ time
difference. For example, the accesses A[i+1][j-1] and A[i][j]
have a constant time difference of (1, -1), but the
accesses A[j][i] and A[i][j] don't have a constant time difference.

Again,this potentially multi-dimensional time difference
is really the dependence distance. Note that the outer-loop vectorization
tries to vectorize _one_ loop, so _one_ dimension which also
applies to the dependence vector (we're trying to
squeeze moments on one dimension).




- 5.2 Anti-Dependences -

An anti-dependence occurs when the read happens before
the write in iteration order, e.g. something like this:

for (int j = 0; j < ...; ++j)
  A[j] = A[j+1];

In j = 0 we're reading from A[1] and in j = 1 we're writing to it.
Still, that doesn't change the direction of the dependence vector.
j = 1 depends on j = 0 and not the opposite. The reason is obviously
that the order of reads and writes has to be maintained so that
the reads read the _old_ value (before its (over-)written).

The other case is of course when we have to preserve that the read
will read the _new_ values, e.g. in this: A[j+2] = A[j];

The same idea is true for more dimensions.

Now that causes problem, because in the implementation, we try
to deduce the distance _of_ the store _from_ the load. If the
store accesses memory locations first, then this distance is
also the iteration dependence distance. But if it's the opposite,
then we have some kind of "negative" value. We have to take
its _reflection_ to find the distance of the iterations. In 1D,
the reflection is just the absolute value. In all other dimensions,
it's the reflection of the vector by the origin.




- 6. Squashing -

Squashing happens when a dimension of the iteration space does
not contribute to the elements accessed by an access. For example, in this:

for (int i = 0; i < ...; ++i)
  for (int j = 0; j < ...; ++j)
    A[i+1][0] = A[i][0];

The `j` dimension does not contribute anywhere. In fact, it's like the
j-loop never existed. We can squash this, which means remove it from
the dependence vector and the dependence vector effectively becomes
an 1D (although the loop nest is 2D).

Squashing happens for two reasons:
a) We are analyzing constant subscripts in both accesses and they're
equal. Then, it's literally like a dimension is non-existent. There's
a special case here. If they're constant and _not_ equal, then the
loop is definitely vectorizable (with whatever factor) and we stop immediately.
This is because then the two accesses never alias (imagine e.g. a 3D access pair
where the two accesses access different planes).

b) The two subscripts (both) use an iteration variable of a loop that is not
inside the loop nest. In this case, again this dimension is like it does
not exist.

Notice that any other combination of subscripts is illegal and results
in failure.


- 7. Forward Dependences -

The basic idea behind a forward dependence is that we have a sequence like:
write, read, write, read

If the write writes either to the same or later addresses from those
that the read reads, then the read will always read _new_ values written.
So, if that's the case, can do a bunch of writes together and then a bunch
of reads (that is, we don't have to preserve the previous values as
we're moving forward). For example:

for (int i = 0; i < ...; ++i) {
  d[i] = y;
  x = d[i];
}
The load will read the _new_ values (the ones about to be written).
If we execute the loop sequentially, we will write a value, read
this value, write a value, read this value etc. The semantics don't
change if instead we: Write 4 values, read 4 values, ...

We should mention that for the vectorization to be valid, two things have to
hold:
  * The write should be before the read in program order
    (so that the write writes first).
  * The (vectorized) write should always have written to addresses
    before the read reads from them. To put it otherwise, there must
    not be a read that accessed an address before the write. In the 1D
    case that just means that the write should write in further
    memory addresses (or to the same and assuming that the loop
    advances in memory access order).

- 7.2 2D case -

  In the 2D case, the same thing holds regarding further memory addresses.
  That is, if the write does not write to further memory addresses, we don't
  have a forward dependence. But, it's not enough. For example:
    for (i)
      for (j) {
        A[i+1][j-1] = y;
        x = A[i][j];
      }

  The write writes further in memory order, but note that the vectorization will
  happen vertically. Because the read is "further to the
  the right" (it reads from a "further to the right" column), the write
  writes previous memory addresses than those which will be accessed
  by the read.


- 8. Finding the maximum vectorization factor from a dependence vector -

As was previously mentioned, once we have the dependence vector, the first
thing we do is to reflect if it's needed. Then, we have 3 cases
that we currently handle.



- 7.1 1D case -

The 1D case is very simple. The maximum vectorization factor is the
distance of the only entry in the vector



- 7.2 2D case -

We're imagining that the outer loop is represented in the y-axis.
But note that the order of entries is not: (x, y) but (y, x)
(always outermost first).

Remember that in any N-D case with N > 1, we're trying to squeeze together
iterations in _one_ dimension, the Nth. In the case of 2D, we're
trying to squeeze iterations by going upwards. Imagine a 2D loop where
the outer variable is the `i` and the inner the `j`. In the the 2D space,
the `i` takes values in the y-axis and the `j` in the x-axis. Now imagine
that we're only executing the inner loop (the j-loop), which looks
like just going to the right, and we're taking multiple vertical
iterations at a time (instead of just one).

By "looking" upwards and trying to get as many iterations as we can,
the only vectors that are worrying are either those that look directly
upwards or upwards and to the left. For the latter, see figure 8.12,
from Chapter 8 of the book "Optimizing Compilers for Modern Architectures"
since in this case, vectorization looks like unroll and jam. Notice that
there, only the "upwards and to the left" is mentioned as illegal but we
also have to consider the directly upwards. That is because unroll-and-jam
on a directly upwards vector is fine because we assume that the iterations
will be executed one after the other. But on the case of vectorization,
we assume they'll be executed in _parallel_.

Such vectors are problematic because an iteration that is more to the
right has to precede an iteration that is upwards. Which makes us
having to execute the whole `j` axis of iterations for a specific `i`
before going to greater `i` values. In this case, the maximum vectorization
factor is the distance in the `i` dimension of the vector because any vertical
iterations in between have no problem being executed before any
further to the right iterations.




- 7.3 3D case -

In the 3D case, we're imagining that we're adding another outermost
loop that is represented in the z-axis. _However_, the order of entries
is not: (x, y, z) but (z, y, x) (outermost first).

We're trying to squeeze iterations in this axis. The only vectors that are
potentially worrying are those that have a middle entry with distance equal to
0. Otherwise, the vector starts from a x-z plane and points to a _different_
plane, so we don't care.

But if the middle entry is 0, then we squash it and fall-back to the 2D case.




-- Appedix: Multi-dimensional array access in C/C++ and in LLVM IR --

What we conceptually and abstractly think of as a multi-dimensional array access
does not exactly happen in C/C++ and in turn in LLVM IR. We mimic it though
through pointers and we have two kinds of multi-dimensional accesses.

The first kind is through multi-indirection pointers. That is,
accessing elements with e.g. a int **p, say p[0][1], is conceptually
similar to a multi-dimensional array access. We don't have
many hopes handling such cases mostly because every different
subscript requires a load and so alias analysis is very difficult.
Fortunately, people who write high performance code know that so
they next kind of array accessing.
Note that if we somehow knew the there's no aliasing, the dependence analysis
theory would work as in the following kind.

The second is through "actual" multi-dimensional arrays.
These are arrays that are declared in this form: int A[10][20], where
each subscript describes the dimension.

There are a lot of nuances depending on where this declaration takes place
but the important thing to remember is that the underlying object of such
entities is assumed to be a _contiguous_ buffer. C/C++ takes advantage
of this fact and when an access happens through such an object, under
the hood, it's just a linear access (i.e. access in a linear buffer)
using a single-indirection pointer, which points to the first
element of the underlying object.

To clarify this, let's say we have this code:

int A[10][20];
int x = A[1][3];

Let's focus on the access through the object. Under the hood, A is handled
as a pointer, let's say `p`, to the starting address of a _supposedly_ linear
buffer that _supposedly_ has 10 * 20 * 4 bytes allocated (assuming
sizeof(int) == 4).

So, under the hood, this code is: int x = p[1*20 + 3];
If you pass A to a function, you'll actually see that in LLVM IR the function
takes just a pointer and the accesses are done through getelementptr. This
"flattening" of accesses has a couple of subtleties:

1) Take the accesses: A[0][3], A[1][0]. Intuitively, we would think that
such accesses don't alias. But, remembering that what matters is the
_flattened_ access in `A`, and taking as an example that the declaration
of `A` is say: int A[...][2], these two _do_ alias. And note that
out of bounds access in a _dimension_ (and not the underlying object as a
whole) is _not UB_, in which case we would not care.
This means that dependence analysis theory that is based on
actually multi-dimensional access spaces does not work here and instead we have
to test the flattened access expressions. This is an unrealistic approach as
this is a very difficult problem. So, we "cheat" by treating those as
flattened accesses as if they were multi-dimensional and to do that,
we have to verify (either statically or at run-time) that each subscript
is not out of bounds of the respective dimension.

2) But to even cheat is not easy. Some has to "reverse engineer" these
expressions into multi-dimensional expressions and this is why
we use SCEV delinearization. Given though that the function _from_ the
original syntactic sugar _to_ the flattened access is not injective,
problems are introduced.

One final note is that you can imitate this flattening yourself in
the source program. If you have an int *p and you do an access like
p[i*m + j], it compiles to same thing as if you had declared `p` as:
int p[][m] and accessed p[i][j]. Because it compiles to the same thing,
it has the same chances for delinearization.

*/

using namespace llvm;

#define DEBUG_TYPE "loop-dependence"

AnalysisKey LoopDependenceAnalysis::Key;

LoopDependenceInfo LoopDependenceAnalysis::run(Function &F,
                                               FunctionAnalysisManager &FAM) {
  ScalarEvolution &SE = FAM.getResult<ScalarEvolutionAnalysis>(F);
  TargetLibraryInfo &TLI = FAM.getResult<TargetLibraryAnalysis>(F);
  AAResults &AA = FAM.getResult<AAManager>(F);
  DominatorTree &DT = FAM.getResult<DominatorTreeAnalysis>(F);
  LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
  return LoopDependenceInfo(F, SE, TLI, AA, DT, LI);
}

LoopDependenceInfo::LoopDependenceInfo(Function &F, ScalarEvolution &SE,
                                       TargetLibraryInfo &TLI, AAResults &AA,
                                       DominatorTree &DT, LoopInfo &LI)
    : SE(SE), TLI(TLI), AA(AA), DT(DT), LI(LI) {}

struct LoopNestInfo {
  int NumDimensions;
  const Loop *InnermostLoop;
  const Loop *AnalyzedLoop;
};

struct MinMaxSCEVPair {
  const SCEV *Min, *Max;
};

static void addNoSignedWrapFlag(const SCEV *S) {
  if (S->getSCEVType() == scAddRecExpr) {
    SCEVAddRecExpr *AR = (SCEVAddRecExpr *)S;
    AR->setNoWrapFlags(SCEV::NoWrapFlags::FlagNSW);
  } else if (S->getSCEVType() == scAddExpr) {
    SCEVAddExpr *AE = (SCEVAddExpr *)S;
    AE->setNoWrapFlags(SCEV::NoWrapFlags::FlagNSW);
  }
}

/// Language / Framework for preconditions
/// Still experimental...

static bool isLTArraySize(ScalarEvolution &SE, const SCEV *Val,
                          const SCEV *ArrSize) {
  const SCEVConstant *Zero =
      dyn_cast<SCEVConstant>(SE.getConstant(Val->getType(), 0, true));

  // Assume that array sizes are positive.
  if (Val == Zero)
    return true;

  // TODO: We can add NSW flag in C/C++ because signed
  // overflow is UB. What about other languages ?
  addNoSignedWrapFlag(Val);
  addNoSignedWrapFlag(ArrSize);
  LLVM_DEBUG(dbgs() << "ArrSize: " << *ArrSize << "\n");
  LLVM_DEBUG(dbgs() << "Val: " << *Val << "\n");
  const SCEV *Max = SE.getSMaxExpr(ArrSize, Val);
  if (Max != ArrSize)
    return false;
  // Also, verify that they're not equal
  if (SE.getMinusSCEV(Val, ArrSize) == Zero)
    return false;
  return true;
}

/// Return true if it could prove that all min/max pairs
/// are within bounds. For this setting, within bounds means
/// that min >= 0 and Max[I] < Sizes[I]. Otherwise, return false.
// TODO: At some point, instead of just returning true or false, we should
// return e.g. a vector of checks for those that we couldn't deduce statically.
static bool
verifyMinMaxPairs(ScalarEvolution &SE,
                  const SmallVectorImpl<MinMaxSCEVPair> &MinMaxPairs,
                  const SmallVectorImpl<const SCEV *> &Sizes) {

  // Remember that `Sizes` has the size() of `Subscripts`
  // when delinearizing, but it actually has one less element.
  assert(MinMaxPairs.size() > 0);
  assert(MinMaxPairs.size() == Sizes.size() - 1);

  for (size_t I = 0; I < Sizes.size() - 1; ++I) {
    MinMaxSCEVPair MMPair = MinMaxPairs[I];
    assert(MMPair.Min);
    assert(MMPair.Max);
    const SCEV *Sz = Sizes[I];
    assert(Sz);
    // Probably we don't want to hoist this out because the type
    // of each subscript may be different.
    const SCEVConstant *Zero =
        dyn_cast<SCEVConstant>(SE.getConstant(Sz->getType(), 0, true));
    assert(Zero);
    // Verify that Min >= 0.
    const SCEV *Min = SE.getSMinExpr(Zero, MMPair.Min);
    if (Min != Zero)
      return false;

    // Verify that Max[I] < Sizes[I]
    if (!isLTArraySize(SE, MMPair.Max, Sz))
      return false;
  }
  return true;
}

static bool addRecHasPositiveConstStep(ScalarEvolution &SE,
                                       const SCEVAddRecExpr *AR) {
  const SCEV *Step = AR->getStepRecurrence(SE);
  if (Step->getSCEVType() != scConstant)
    return false;
  const SCEVConstant *StepConst = dyn_cast<SCEVConstant>(Step);
  if (StepConst->getAPInt().getSExtValue() <= 0)
    return false;
  return true;
}

static MinMaxSCEVPair getMinMaxOfIncreasingAddRec(ScalarEvolution &SE,
                                                  const SCEVAddRecExpr *AR) {
  assert(AR);
  assert(addRecHasPositiveConstStep(SE, AR));
  MinMaxSCEVPair Res;
  // Important: This is valid only because we have already tested
  // that the step is positive.
  // TODO: We don't take wrapping into consideration. It it wraps,
  // the minimum value is (possibly) not the start.
  Res.Min = AR->getStart();
  // Top-level -> function-level. This will give us the value of the
  // AR after the _whole_ loop nest (i.e. what is considered
  // usually an exit value but not just for its loop, but the whole
  // nest).
  const Loop *TopLevel = nullptr;
  // Again, this works because we have tested that the step is positive.
  Res.Max = SE.getSCEVAtScope(AR, TopLevel);
  return Res;
}

bool subscriptsAreWithinBounds(ScalarEvolution &SE,
                               const SmallVectorImpl<const SCEV *> &Subscripts,
                               const SmallVectorImpl<const SCEV *> &Sizes) {
  assert(Subscripts.size() == Sizes.size());
  if (Subscripts.size() <= 1)
    return true;
  // Gather min / max of subscripts.
  // Remember that Sizes has one less entry than Subscripts because we never
  // know the first dimension.
  SmallVector<MinMaxSCEVPair, 4> MinMaxPairs(Sizes.size() - 1);
  for (size_t SubIt = 1, SzIt = 0; SubIt < Subscripts.size(); ++SubIt, ++SzIt) {
    const SCEV *Sub = Subscripts[SubIt];
    // We have already checked the following before calling
    // this function.
    assert(Sub->getSCEVType() == scConstant ||
           Sub->getSCEVType() == scAddRecExpr);

    if (Sub->getSCEVType() == scConstant) {
      MinMaxPairs[SzIt].Min = MinMaxPairs[SzIt].Max = Sub;
      continue;
    }
    const SCEVAddRecExpr *SubAR = dyn_cast<SCEVAddRecExpr>(Sub);
    assert(SubAR);
    MinMaxPairs[SzIt] = getMinMaxOfIncreasingAddRec(SE, SubAR);
  }

  return verifyMinMaxPairs(SE, MinMaxPairs, Sizes);
}

static bool subscriptsAreLegal(ScalarEvolution &SE,
                               const SmallVectorImpl<const SCEV *> &Subscripts,
                               const SmallVectorImpl<const SCEV *> &Sizes,
                               LoopNestInfo NestInfo) {
  // We want to check a couple of things:
  // a) That any SCEV is either constant or AddRec.
  // b) That the any AddRec has positive step.
  // c) That any loop of the nest is used in at most one recurrence.
  // Note in that way, we can have a subscript recurrence that is based
  // on an outer loop - that is not included in the loop nest.
  SmallDenseMap<const Loop *, bool> UsedLoops;
  for (const SCEV *S : Subscripts) {
    switch (S->getSCEVType()) {
    case scConstant:
      break;
    case scAddRecExpr: {
      const SCEVAddRecExpr *AddRec = dyn_cast<SCEVAddRecExpr>(S);
      const Loop *L = AddRec->getLoop();
      if (UsedLoops[L])
        return false;
      UsedLoops[L] = true;
      if (!addRecHasPositiveConstStep(SE, AddRec))
        return false;
    } break;
    default:
      return false;
    }
  }

  if (!subscriptsAreWithinBounds(SE, Subscripts, Sizes))
    return false;

  return true;
}

static const SCEVConstant *getNegativeSCEVConstant(ScalarEvolution &SE,
                                                   const SCEVConstant *S) {
  int NumBits = S->getAPInt().getBitWidth();
  int64_t Val = S->getValue()->getSExtValue();
  const SCEVConstant *Res =
      (const SCEVConstant *)SE.getConstant(APInt(NumBits, -Val, true));
  return Res;
}

static const SCEV *getSDivSimpleAddRec(ScalarEvolution &SE,
                                       const SCEVAddRecExpr *AddRec,
                                       const SCEV *Divisor) {
  // Assert it's "simple".
  const SCEVConstant *Start = dyn_cast<SCEVConstant>(AddRec->getStart());
  const SCEVConstant *Step =
      dyn_cast<SCEVConstant>(AddRec->getStepRecurrence(SE));
  assert(Start != nullptr);
  assert(Step != nullptr);

  // If the step / start is negative, negate it so that unsigned division
  // works and then negate the result again.

  bool StartIsNegative = false;
  bool StepIsNegative = false;
  if (Start->getValue()->getSExtValue() < 0) {
    StartIsNegative = true;
    Start = getNegativeSCEVConstant(SE, Start);
  }
  if (Step->getValue()->getSExtValue() < 0) {
    StepIsNegative = true;
    Step = getNegativeSCEVConstant(SE, Step);
  }
  SmallVector<const SCEV *, 2> Operands;
  Operands.push_back(Start);
  Operands.push_back(Step);
  AddRec = (SCEVAddRecExpr *)SE.getAddRecExpr(Operands, AddRec->getLoop(),
                                              AddRec->getNoWrapFlags());

  // Do the division
  dbgs() << "AddRec: " << *AddRec << "\n";
  dbgs() << "Divisor: " << *Divisor << "\n";
  const SCEV *UDivExpr = SE.getUDivExpr(AddRec, Divisor);
  dbgs() << "UDivExpr: " << *UDivExpr << "\n";
  const SCEVAddRecExpr *Res = dyn_cast<SCEVAddRecExpr>(UDivExpr);
  assert(Res);

  // Negate again what was negative.
  Start = dyn_cast<SCEVConstant>(Res->getStart());
  assert(Start != nullptr);
  if (StartIsNegative) {
    Start = getNegativeSCEVConstant(SE, Start);
  }
  Step = dyn_cast<SCEVConstant>(Res->getStepRecurrence(SE));
  assert(Step != nullptr);
  if (StepIsNegative) {
    Step = getNegativeSCEVConstant(SE, Step);
  }

  Operands.clear();
  Operands.push_back(Start);
  Operands.push_back(Step);
  Res = (SCEVAddRecExpr *)SE.getAddRecExpr(Operands, Res->getLoop(),
                                           Res->getNoWrapFlags());

  return Res;
}

static bool
handleFailedDelinearization(ScalarEvolution &SE, const Loop *L,
                            const SCEV *AccessExpr, Value *Pointer,
                            SmallVectorImpl<const SCEV *> &Subscripts,
                            SmallVectorImpl<const SCEV *> &Sizes) {
  if (AccessExpr->getSCEVType() != scAddRecExpr) {
    Subscripts.push_back(AccessExpr);
    return true;
  }
  // If we have an AddRecExpr, we have to normalize it.
  SCEVAddRecExpr *AddRec = (SCEVAddRecExpr *)cast<SCEVAddRecExpr>(AccessExpr);
  // Add wrapping flags. We have to do this otherwise unsigned div later
  // may not work.
  // TODO: It's important to add run-time checks to verify that
  AddRec->setNoWrapFlags(SCEV::NoWrapFlags::FlagNUW);
  Type *Ty = Pointer->getType();
  auto &DL = L->getHeader()->getModule()->getDataLayout();
  uint64_t TypeByteSize = DL.getTypeAllocSize(Ty->getPointerElementType());
  const SCEV *Divisor = SE.getConstant(Ty, TypeByteSize);
  const SCEV *Normalized = getSDivSimpleAddRec(SE, AddRec, Divisor);
  LLVM_DEBUG(dbgs() << "Normalized: " << *Normalized << "\n";);
  Subscripts.clear();
  Subscripts.push_back(Normalized);
  // Push an invalid size just because the sizes of the two vectors
  // have to be equal.
  Sizes.clear();
  Sizes.push_back(SE.getConstant(Ty, ~0));
  return true;
}

static const SCEV *getSCEVStrippedFromBasePointer(ScalarEvolution &SE,
                                                  Value *Pointer,
                                                  const Loop *L) {

  const SCEV *AccessExpr = SE.getSCEVAtScope(Pointer, L);

  LLVM_DEBUG(dbgs() << "\n\nAccessExpr (" << *AccessExpr->getType()
                    << "): " << *AccessExpr << "\n";);

  const SCEVUnknown *BasePointer =
      dyn_cast<SCEVUnknown>(SE.getPointerBase(AccessExpr));
  // Do not delinearize if we cannot find the base pointer.
  if (!BasePointer)
    return nullptr;
  LLVM_DEBUG(dbgs() << "Base Pointer: " << *BasePointer << "\n";);
  // Remove the base pointer from the expr.
  AccessExpr = SE.getMinusSCEV(AccessExpr, BasePointer);
  LLVM_DEBUG(dbgs() << "\n\nAccessExpr (" << *AccessExpr->getType()
                    << "): " << *AccessExpr << "\n";);
  return AccessExpr;
}

static bool delinearizeAccessInst(ScalarEvolution &SE, Instruction *Inst,
                                  SmallVectorImpl<const SCEV *> &Subscripts,
                                  SmallVectorImpl<const SCEV *> &Sizes,
                                  const Loop *L) {

  assert(isa<StoreInst>(Inst) || isa<LoadInst>(Inst));
  Value *Pointer = getPointerOperand(Inst);
  const SCEV *AccessExpr = getSCEVStrippedFromBasePointer(SE, Pointer, L);
  if (!AccessExpr)
    return false;

  delinearize(SE, AccessExpr, Subscripts, Sizes, SE.getElementSize(Inst));

  if (Subscripts.size() == 0 || Sizes.size() == 0 ||
      Subscripts.size() != Sizes.size()) {
    LLVM_DEBUG(dbgs() << "Failed to delinearize. Using a single subscript - "
                         "the original SCEV\n";);
    return handleFailedDelinearization(SE, L, AccessExpr, Pointer, Subscripts,
                                       Sizes);
  }

  LLVM_DEBUG(
      dbgs() << "ArrayDecl[UnknownSize]"; int Size = Subscripts.size();
      for (int i = 0; i < Size - 1; i++) dbgs() << "[" << *Sizes[i] << "]";
      dbgs() << " with elements of " << *Sizes[Size - 1] << " bytes.\n";

      dbgs() << "ArrayRef";
      for (int i = 0; i < Size; i++) dbgs() << "[" << *Subscripts[i] << "]";
      dbgs() << "\n";

  );

  return true;
}

static void getArraySizes(ScalarEvolution &SE, Value *Obj,
                          SmallVectorImpl<const SCEV *> &Sizes) {
  Type *Ty = Obj->getType();
  assert(Ty->isPointerTy());
  ArrayType *ArrTy = dyn_cast<ArrayType>(Ty->getPointerElementType());
  assert(ArrTy);
  // Skip the first size; It's not always present.
  ArrTy = dyn_cast<ArrayType>(ArrTy->getArrayElementType());
  while (ArrTy) {
    uint64_t NumElements = ArrTy->getArrayNumElements();
    const SCEVConstant *S = dyn_cast<SCEVConstant>(SE.getConstant(
        Type::getInt64Ty(ArrTy->getContext()), NumElements, false));
    assert(S);
    Sizes.push_back(S);
    ArrTy = dyn_cast<ArrayType>(ArrTy->getArrayElementType());
  }
  // Push a dummy value; `Sizes.size()` should be the same as
  // `Subscripts.size()`
  Sizes.push_back(SE.getConstant(Type::getInt64Ty(Ty->getContext()), 0, false));
}

static bool getCumulativeStartingOffset(ScalarEvolution &SE,
                                        const SCEVAddRecExpr *S,
                                        uint64_t &Offset) {
  assert(S);
  const SCEV *Save;
  do {
    assert(S->getStepRecurrence(SE)->getSCEVType() == scConstant);
    Save = S->getStart();
    S = dyn_cast<SCEVAddRecExpr>(Save);
  } while (S);
  const SCEVConstant *OffsetSCEV = dyn_cast<SCEVConstant>(Save);
  if (!OffsetSCEV)
    return false;
  Offset = OffsetSCEV->getValue()->getZExtValue();
  return true;
}

static void findArraySubscripts(ScalarEvolution &SE, uint64_t Offset,
                                uint64_t TypeByteSize, const SCEVAddRecExpr *S,
                                SmallVectorImpl<const SCEV *> &Subscripts,
                                SmallVectorImpl<const SCEV *> &Sizes) {
  SmallVector<std::pair<uint64_t, const SCEVAddRecExpr *>, 3> Steps;
  do {
    const SCEVConstant *Step = dyn_cast<SCEVConstant>(S->getStepRecurrence(SE));
    assert(Step);
    uint64_t StepVal = Step->getValue()->getZExtValue();
    // Save parent SCEV for later.
    Steps.push_back({StepVal, S});
    S = dyn_cast<SCEVAddRecExpr>(S->getStart());
  } while (S);

  llvm::sort(Steps.begin(), Steps.end());

  dbgs() << "\n";
  // To be continued: Run the example with [i+2][j+1] and see that you get
  // bad index offset (index offsets are the DivRes, e.g. in i+2, it is the 2).
  // To make this work, probably we have to always start with the recurrence
  // with the biggest step.

  // TODO: Also, we probably want to take into consideration the `Sizes`, to
  // find out if we have a +1 step or more.

  assert(Subscripts.size() == 0);
  for (std::pair<uint64_t, const SCEVAddRecExpr *> StepPair : reverse(Steps)) {
    uint64_t StepVal = StepPair.first;
    uint64_t DivRes = Offset / StepVal;
    uint64_t DivMod = Offset % StepVal;
    LLVM_DEBUG(dbgs() << "Offset: " << Offset << "\n";
               dbgs() << "StepVal: " << StepVal << "\n";
               dbgs() << "DivRes: " << DivRes << "\n";
               dbgs() << "DivMod: " << DivMod << "\n";
               dbgs() << "---------------------\n";);

    const SCEVAddRecExpr *Parent = StepPair.second;
    // Construct AddRec SCEV with DivRes as Start
    // and +1 as Step (see the TODO above).
    const SCEV *Start = SE.getConstant(Parent->getType(), DivRes, false);
    const SCEV *Step = SE.getConstant(Parent->getType(), 1, false);
    const SCEVAddRecExpr *S = dyn_cast<SCEVAddRecExpr>(SE.getAddRecExpr(
        Start, Step, StepPair.second->getLoop(), Parent->getNoWrapFlags()));
    assert(S);
    Subscripts.push_back(S);

    Offset = DivMod;
  }
  assert(Subscripts.size() == Sizes.size());
}

static bool
delinearizePtrOnGlobalArray(ScalarEvolution &SE, Value *Ptr, Value *Obj,
                            SmallVectorImpl<const SCEV *> &Subscripts,
                            SmallVectorImpl<const SCEV *> &Sizes,
                            LoopNestInfo NestInfo) {
  const SCEV *AccessExpr =
      getSCEVStrippedFromBasePointer(SE, Ptr, NestInfo.InnermostLoop);
  getArraySizes(SE, Obj, Sizes);
  for (const SCEV *Sz : Sizes) {
    dbgs() << "Sz: " << *Sz << "\n";
  }
  auto &DL = NestInfo.AnalyzedLoop->getHeader()->getModule()->getDataLayout();
  assert(Ptr->getType()->isPointerTy());
  uint64_t TypeByteSize =
      DL.getTypeAllocSize(Ptr->getType()->getPointerElementType());
  const SCEVAddRecExpr *AddRec = dyn_cast<SCEVAddRecExpr>(AccessExpr);
  if (!AddRec)
    return false;
  uint64_t Offset = UINT_MAX;
  if (!getCumulativeStartingOffset(SE, AddRec, Offset))
    return false;
  findArraySubscripts(SE, Offset, TypeByteSize, AddRec, Subscripts, Sizes);
  return subscriptsAreLegal(SE, Subscripts, Sizes, NestInfo);
}

static bool
delinearizeInstAndVerifySubscripts(ScalarEvolution &SE, Instruction *Inst,
                                   SmallVectorImpl<const SCEV *> &Subscripts,
                                   SmallVectorImpl<const SCEV *> &Sizes,
                                   LoopNestInfo NestInfo) {

  bool DelinSucc = delinearizeAccessInst(SE, Inst, Subscripts, Sizes,
                                         NestInfo.InnermostLoop);
  if (!DelinSucc)
    return false;
  return subscriptsAreLegal(SE, Subscripts, Sizes, NestInfo);
}

struct DepVectorComponent {
  char Dir;
  // TODO: Probably change to SCEV
  int64_t Dist;
  const llvm::Loop *Loop = nullptr;

  void print() const {
    dbgs() << "{" << Dir << ", " << Dist << ", "
           << ((Loop) ? Loop->getName() : "") << "}";
  }
  void negate() {
    assert(Dir == '=' || Dir == '<' || Dir == '>');
    if (Dir == '=')
      return;
    Dist = -Dist;
    Dir = (Dir == '<') ? '>' : '<';
  }
};

struct DepVector {
  constexpr static size_t MaxComps = 4;
  SmallVector<DepVectorComponent, MaxComps> Comps;

  DepVector(int Dimensions) : Comps(Dimensions) {
    // Start with everything destined to be squashed
    // and only fill those that don't.
    for (DepVectorComponent &DVC : Comps) {
      DVC.Dir = 'S';
    }
    assert(Dimensions <= MaxComps);
  }

  const DepVectorComponent operator[](size_t I) const { return Comps[I]; }
  DepVectorComponent &operator[](size_t I) { return Comps[I]; }

  void print() const {
    if (Comps.size() == 0) {
      dbgs() << "(Empty)";
      return;
    }
    dbgs() << "(";
    Comps[0].print();
    for (size_t i = 1; i < Comps.size(); ++i) {
      dbgs() << ", ";
      Comps[i].print();
    }
    dbgs() << ")";
    dbgs() << "\n";
  }

  size_t size() const { return Comps.size(); }

  bool verify() const {
    for (DepVectorComponent DVC : Comps) {
      if (DVC.Dir == '<' && DVC.Dist <= 0)
        return false;
      else if (DVC.Dir == '>' && DVC.Dist >= 0)
        return false;
      else if (DVC.Dir == '=' && DVC.Dist != 0)
        return false;
    }
    return true;
  }

  void reflect() {
    for (DepVectorComponent &DVC : Comps) {
      DVC.negate();
    }
  }
};

struct DirDistPair {
  char Dir;
  int64_t Dist;
};

DirDistPair getDirDistPairFromSCEVConstant(const SCEVConstant *C) {
  ConstantInt *V = C->getValue();
  int64_t Dist = V->getSExtValue();
  DirDistPair Res = {'<', Dist};
  if (!Dist)
    Res.Dir = '=';
  else if (Dist < 0)
    Res.Dir = '>';
  return Res;
}

bool getDVComponent(ScalarEvolution *SE, const SCEV *S1, const SCEV *S2,
                    DepVectorComponent &DVC, LoopNestInfo NestInfo) {
  if (S1->getType() != S2->getType())
    return false;
  if (S1->getSCEVType() == scConstant && S2->getSCEVType() == scConstant) {
    // If they're both constants and equal, then we have dimension squashing.
    // Otherwise, the two references never alias.
    if (dyn_cast<SCEVConstant>(S1)->getValue()->getSExtValue() ==
        dyn_cast<SCEVConstant>(S2)->getValue()->getSExtValue()) {
      DVC.Dir = 'S';
      return true;
    } else {
      DVC.Dir = 'N';
      return true;
    }
  }
  if (S1->getSCEVType() != scAddRecExpr || S2->getSCEVType() != scAddRecExpr) {
    // Can't handle other cases - either both constants or both AddRecs.
    return false;
  }

  const SCEVAddRecExpr *AddRec1 = dyn_cast<SCEVAddRecExpr>(S1);
  const SCEVAddRecExpr *AddRec2 = dyn_cast<SCEVAddRecExpr>(S2);

  if (AddRec1->getLoop() != AddRec2->getLoop())
    return false;

  const Loop *RecLoop = AddRec1->getLoop();

  // TODO: What about the order here?
  const SCEV *Diff = SE->getMinusSCEV(AddRec2, AddRec1);
  // TODO: Handle other things
  const SCEVConstant *C = dyn_cast<const SCEVConstant>(Diff);

  // Note: Constant here means "loop invariant" and also "value known at
  // compile-time". We're happy with less strict cases, like `-2 + n` too,
  // because they're loop-invariant (assuming that n is loop-invariant) and we
  // can find out the distance with a single runtime check.

  if (C) {
    auto DirDist = getDirDistPairFromSCEVConstant(C);
    DVC = {DirDist.Dir, DirDist.Dist, RecLoop};
    return true;
  } else {
    LLVM_DEBUG(dbgs() << "Non-constant SCEV distance: " << *Diff << "\n");
    return false;
  }
}

static int findPositionInDV(DepVectorComponent DVC, LoopNestInfo NestInfo) {
  const Loop *RecLoop = DVC.Loop;
  assert(RecLoop != nullptr);
  const Loop *Runner = NestInfo.InnermostLoop;
  // This is the position of the first dimension, which is the rightmost.
  // Because remember that vectors follow the convention of C when it comes
  // to multi-dimensional description. That is, every new dimension is added
  // to the left in an access.
  int Pos = NestInfo.NumDimensions - 1;
  while (Pos >= 0) {
    assert(Runner != nullptr);
    if (RecLoop == Runner)
      return Pos;
    Pos--;
    Runner = Runner->getParentLoop();
  }
  return -1;
}

enum class DVValidity { INVALID, VALID, DEFINITELY_VECTORIZABLE };

DVValidity getDirVector(ScalarEvolution *SE, DepVector &DV,
                        SmallVectorImpl<const SCEV *> &Subscripts1,
                        SmallVectorImpl<const SCEV *> &Subscripts2,
                        LoopNestInfo NestInfo) {

  assert(Subscripts1.size() == Subscripts2.size());

  for (size_t Index = 0; Index < Subscripts1.size(); ++Index) {
    DepVectorComponent DVC;
    if (!getDVComponent(SE, Subscripts1[Index], Subscripts2[Index], DVC,
                        NestInfo))
      return DVValidity::INVALID;
    if (DVC.Dir == 'N')
      return DVValidity::DEFINITELY_VECTORIZABLE;
    if (DVC.Dir == 'S')
      // Ignore
      continue;
    int Pos = findPositionInDV(DVC, NestInfo);
    if (Pos == -1) {
      // The outer dimension is different, hence the two accesses
      // on the inner loop never alias.
      if (DVC.Dist != 0)
        return DVValidity::DEFINITELY_VECTORIZABLE;
      // The loop that the recurrence is based on does not
      // affect this (inner) loop nest.
      continue;
    }
    DV[Pos] = DVC;
  }

  // We're interested in vectorizing the outermost
  // loop. If the outermost (i.e. first) dimension of the DV
  // is squashed, then the loop does not contribute to
  // the dependences.
  if (DV.size() && DV[0].Dir == 'S')
    return DVValidity::DEFINITELY_VECTORIZABLE;

  return DVValidity::VALID;
}

void squashIfNeeded(DepVector &DV) {
  if (!DV.size())
    return;

  SmallVectorImpl<DepVectorComponent> &Comps = DV.Comps;
  // Squash unused dimensions. Maybe we should use a list instead of
  // a vector - it depends on how common this is.

  // Note that currently squshing works for something
  // like this:
  // for (k)
  //   for (i)
  //     for (j)
  //       A[k+2][i-1][0] = A[k][i][0]
  // i.e. we're squashing the first dimension (the j-loop).
  // The currently implemented squashing could do quite more
  // complicated squashing, like in the above loop: A[k+2][0][i-1] = ...
  // that is, squash the middle dimension, or the last. But
  // delinearization fails to deduce these subscripts.
  Comps.erase(
      std::remove_if(Comps.begin(), Comps.end(),
                     [](DepVectorComponent DVC) { return DVC.Dir == 'S'; }),
      Comps.end());
}

static bool looksDirectlyLeft2D(const DepVector &DV) {
  assert(DV.size() == 2);
  return (DV[0].Dir == '=' && DV[1].Dir == '>');
}

static bool looksDirectlyUpwards2D(const DepVector &DV) {
  assert(DV.size() == 2);
  return (DV[0].Dir == '<' && DV[1].Dir == '=');
}

/// Looks directly downwards, downwards and to the right or to the
/// left.
static bool looksDownwards2D(const DepVector &DV) {
  assert(DV.size() == 2);
  return DV[0].Dir == '>';
}

/// Looks directly left, upwards left or downwards left
static bool looksLeft2D(const DepVector &DV) {
  assert(DV.size() == 2);
  return DV[1].Dir == '>';
}

/// Looks directly backwards, backwards left / right or backwards
/// up / down.
static bool looksBackwards3D(const DepVector &DV) {
  assert(DV.size() == 3);
  return DV[0].Dir == '>';
}

bool isForwardDependence(DepVector &DV, unsigned LoadPosition,
                         unsigned StorePosition) {
  // If the store is before the load and the store
  // writes further in memory (or at the same memory), then we have a forward
  // dependence (and we can vectorize). For example:
  // for (int i = 0; i < ...; ++i) {
  //   d[i] = y;
  //   x = d[i];
  // }
  // The load will read the _new_ values (the ones about to be written).
  // If we execute the loop sequentially, we will write a value, read
  // this value, write a value, read this value etc. The semantics don't
  // change if instead we: Write 4 values, read 4 values, ...

  if (StorePosition < LoadPosition) {
    if (DV.size() == 1) {
      bool WriteIsFurtherOrSame = DV[0].Dist >= 0;
      if (WriteIsFurtherOrSame)
        return true;
    } else if (DV.size() == 2) {
      bool WritesToPreviousMemory =
          looksDownwards2D(DV) || looksDirectlyLeft2D(DV);
      bool WritesFurtherToTheLeft = looksLeft2D(DV);
      if (WritesFurtherToTheLeft || WritesToPreviousMemory)
        return false;
      return true;
    } // TODO: Handle 3D case.
  }
  return false;
}

/// Reflect if it points to previous iterations - something
/// that arises because the load accesses memory locations
/// before the store (in time).
void reflectIfNeeded(DepVector &IterDV) {
  if (!IterDV.size())
    return;

  if (IterDV.size() > 4)
    return;
  if (IterDV.size() == 4) {
    if (IterDV[0].Dist < 0) {
      IterDV.reflect();
    } else if (IterDV[0].Dist == 0) {
      DepVector IterDV3D(3);
      IterDV3D[0] = IterDV[1];
      IterDV3D[1] = IterDV[2];
      IterDV3D[2] = IterDV[3];
      reflectIfNeeded(IterDV3D);
      IterDV[1] = IterDV3D[0];
      IterDV[2] = IterDV3D[1];
      IterDV[3] = IterDV3D[2];
    }
    return;
  }
  if (IterDV.size() == 1) {
    if (IterDV[0].Dist < 0)
      IterDV[0].negate();
    return;
  } else if (IterDV.size() == 2) {
    if (looksDownwards2D(IterDV) || looksDirectlyLeft2D(IterDV))
      IterDV.reflect();
  } else { // 3D case
    // If it looks backwards, it definitely looks towards
    // to previous iterations.
    if (looksBackwards3D(IterDV))
      IterDV.reflect();
    // If it looks forwards, it definitely looks towards
    // later iterations. So the only case left is when
    // 1st dimension (outermost) is 0, in which case fall-back to
    // the 2D case for the other two.
    if (IterDV[0].Dir == '=') {
      DepVector IterDV2D(2);
      IterDV2D[0] = IterDV[1];
      IterDV2D[1] = IterDV[2];
      reflectIfNeeded(IterDV2D);
      IterDV[1] = IterDV2D[0];
      IterDV[2] = IterDV2D[1];
    }
  }
}

static ConstVF getMaxAllowedVecFact(DepVector &);

static ConstVF fallback2D(DepVector &IterDV, int Ignore) {
  assert(Ignore >= 0 && Ignore < 3);
  DepVector Copy(2);
  int J = 0;
  for (int I = 0; I < 3; ++I) {
    if (I != Ignore) {
      Copy[J] = IterDV[I];
      ++J;
    }
  }
  return getMaxAllowedVecFact(Copy);
}

static ConstVF fallback3D(DepVector &IterDV, int Ignore) {
  assert(Ignore >= 0 && Ignore < 4);
  DepVector Copy(3);
  int J = 0;
  for (int I = 0; I < 4; ++I) {
    if (I != Ignore) {
      Copy[J] = IterDV[I];
      ++J;
    }
  }
  return getMaxAllowedVecFact(Copy);
}

static ConstVF getMaxAllowedVecFact(DepVector &IterDV) {
  assert(IterDV.verify());
  ConstVF Best = LoopDependence::getBestPossible().VectorizationFactor;
  ConstVF Worst = LoopDependence::getWorstPossible().VectorizationFactor;
  if (!IterDV.size())
    return Best;
  if (IterDV.size() > 4)
    return Worst;

  if (IterDV.size() == 4) {
    for (int I = 0; I < 4; ++I) {
      if (IterDV[I].Dist == 0)
        return fallback3D(IterDV, I);
    }
    return Worst;
  }

  if (IterDV.size() == 1) {
    int Dist = IterDV[0].Dist;
    if (Dist) {
      return Dist;
    }
    return Best;
  } else {
    ConstVF Res = Best;
    if (IterDV.size() == 2) {
      // Handle outermost loop vectorization in 2-level loop nest.
      if (looksLeft2D(IterDV) || looksDirectlyUpwards2D(IterDV))
        Res = (size_t)IterDV[0].Dist;
      return Res;
    } else {
      // If any of the dimensions is 0, then fall-back
      // to a 2D case.
      for (int I = 0; I < 3; ++I) {
        if (IterDV[I].Dist == 0)
          return fallback2D(IterDV, I);
      }
      // Otherwise, the vectorization in z-axis
      // will always 'grab' a later iteration. So,
      // it's limited by the distance in 'z'.
      return IterDV[0].Dist;
    }
  }
  assert(0);
  return Worst;
}

enum class TrivialAliasRes {
  CANNOT_ALIAS,
  SAME_OBJECT,
  CAN_ALIAS,
};

static TrivialAliasRes trivialAliasCheck(LoopInfo &LI, const DataLayout &DL,
                                         const Value *Ptr1, const Value *Ptr2) {

  // We want the two sets of underlying objects
  // to be disjoint. If they indeed are, we want in any pair of
  // objects from different sets, at least one to have the
  // the `noalias` attribute.

  SmallVector<const Value *, 2> Objects1;
  SmallVector<const Value *, 2> Objects2;
  getUnderlyingObjects(Ptr1, Objects1, &LI);
  getUnderlyingObjects(Ptr2, Objects2, &LI);

  for (const Value *IObj : Objects1) {
    const Argument *A1 = dyn_cast<Argument>(IObj);
    if (!A1)
      return TrivialAliasRes::CAN_ALIAS;
    for (const Value *JObj : Objects2) {
      if (IObj == JObj)
        return TrivialAliasRes::SAME_OBJECT;
      const Argument *A2 = dyn_cast<Argument>(JObj);
      if (!A2)
        return TrivialAliasRes::CAN_ALIAS;
      if (!A1->hasAttribute(Attribute::AttrKind::NoAlias) &&
          !A2->hasAttribute(Attribute::AttrKind::NoAlias))
        return TrivialAliasRes::CAN_ALIAS;
    }
  }
  return TrivialAliasRes::CANNOT_ALIAS;
}

struct RTAliasCheckInfo {
  MinMaxSCEVPair Bounds1, Bounds2;
};

enum class CanAliasRes {
  CANNOT_ALIAS,
  SAME_OBJECT,
  CAN_ALIAS_RTCHECK_INFO,
  CAN_ALIAS_NO_INFO
};

// None: They can't alias.
// Otherwise, return info to generate an alias check.
static CanAliasRes canAlias(ScalarEvolution &SE, LoopInfo &LI,
                            const DataLayout &DL, const Value *Ptr1,
                            const Value *Ptr2, const Loop *InnermostLoop,
                            RTAliasCheckInfo &AliasCheckInfo) {
  TrivialAliasRes trivialRes = trivialAliasCheck(LI, DL, Ptr1, Ptr2);
  if (trivialRes == TrivialAliasRes::CANNOT_ALIAS)
    return CanAliasRes::CANNOT_ALIAS;
  else if (trivialRes == TrivialAliasRes::SAME_OBJECT)
    return CanAliasRes::SAME_OBJECT;
  // else: Fill AliasCheckInfo, if we can

  // TODO: What happens if the asserts fail ? We have to turn those in ifs
  // and the function should return three "results":
  // None: They can't alias.
  // RTAliasCheckInfo: They can alias, here's info to gen an RT check.
  // Otherwise: They can alias and I can't find info.
  const SCEVAddRecExpr *S1 = dyn_cast<SCEVAddRecExpr>(
      SE.getSCEVAtScope((Value *)Ptr1, (Loop *)InnermostLoop));
  if (!S1)
    return CanAliasRes::CAN_ALIAS_NO_INFO;
  const SCEVAddRecExpr *S2 = dyn_cast<SCEVAddRecExpr>(
      SE.getSCEVAtScope((Value *)Ptr2, (Loop *)InnermostLoop));
  if (!S2)
    return CanAliasRes::CAN_ALIAS_NO_INFO;

  AliasCheckInfo.Bounds1 = getMinMaxOfIncreasingAddRec(SE, S1);
  AliasCheckInfo.Bounds2 = getMinMaxOfIncreasingAddRec(SE, S2);

  return CanAliasRes::CAN_ALIAS_RTCHECK_INFO;
}

struct ProgramOrderedAccess {
  union {
    LoadInst *Load;
    StoreInst *Store;
  };
  // Greater `Position` means later in program order.
  unsigned Position;

  static ProgramOrderedAccess get(LoadInst *LD, unsigned Position) {
    ProgramOrderedAccess POA;
    POA.Load = LD;
    POA.Position = Position;
    return POA;
  }

  static ProgramOrderedAccess get(StoreInst *ST, unsigned Position) {
    ProgramOrderedAccess POA;
    POA.Store = ST;
    POA.Position = Position;
    return POA;
  }
};

static bool isInNest(Instruction &I, LoopNestInfo NestInfo) {

  // A nest is considered a path from the outermost loop towards
  // an innermost loop (any loop can be thought as a tree with
  // subloops loops being the children). What we would like to know
  // is if an instruction is inside this path. But, a loop contains()
  // instructions not only in the loop itself (i.e. not in any subloops
  // which could be considered a single node in the tree) but also instructions
  // in all the subloops (i.e. instructions in all sub-trees). So, the idea is
  // to take the path from the innermost back to the outermost and keep the
  // one-before loop every time in this path. This is basically the only
  // sub-tree in which we're interested. Any instruction "in the nest" is any
  // instruction either in that subtree or in the outermost loop. So, by
  // checking if the instruction is in any of the other subloops, we check if it
  // is any subtree that we don't want to analyze. Example:

  //   2
  //  /
  // 1     4
  //  \  /
  //   3
  //     \
  //      5

  // Imagine this tree (with the root being 1, the outermost loop and going
  // towards the right we find the leaves, the innermost loops) that could
  // come from this source:
  // for (i) {    - 1 -
  //   for (j)    - 2 -
  //   for (j) {  - 3 -
  //     for (k)  - 4 -
  //     for (k)  - 5 -
  //   }
  // }
  // And say we're interested in the nest 1 - 3 - 4
  // The states are going to go like:
  // OneBefore = 4
  // L = 3           (we want to check that the instruction is not in the
  //                  subtree 5)
  // OneBefore = 3
  // L = 1           (we want to check that the instruction is not in the
  //                  subtree 2)

  const Loop *L = NestInfo.InnermostLoop;
  if (L == NestInfo.AnalyzedLoop)
    return true;
  const Loop *OneBefore;
  do {
    OneBefore = L;
    L = L->getParentLoop();
    for (const Loop *Sub : L->getSubLoops())
      if (Sub != OneBefore && Sub->contains(&I))
        return false;
    // Remember, NestInfo.AnalyzedLoop is the outermost loop
    // in the nest.
  } while (L != NestInfo.AnalyzedLoop);
  return true;
}

bool operator<(const ConstVF V1, const ConstVF V2) {
  if (!V1.hasValue())
    return false;
  if (!V2.hasValue())
    return true;
  return V1.getValue() < V2.getValue();
}

// FIXME: factor this out
#if 0
// TODO: This should definitely be moved in the transformation part! Note that
// because this now transforms the loop, certain already verified preconditions
// (like the loop being simplified) may not hold anymore.
struct ExpandedMinMaxSCEVPair {
  TrackingVH<Value> Min;
  TrackingVH<Value> Max;
};

struct ExpandedRTAliasCheckInfo {
  ExpandedMinMaxSCEVPair Bounds1, Bounds2;
};

static ExpandedMinMaxSCEVPair expandBoundsPair(MinMaxSCEVPair MinMax, Instruction *InsertBefore,
                                               SCEVExpander &SEExpander) {
  unsigned AddrSpace = MinMax.Min->getType()->getPointerAddressSpace();
  LLVMContext &Ctx = InsertBefore->getContext();
  Type *I8PtrTy = Type::getInt8PtrTy(Ctx, AddrSpace);
  
  Value *Min = nullptr, *Max = nullptr;
  Min = SEExpander.expandCodeFor(MinMax.Min, I8PtrTy, InsertBefore);
  Max= SEExpander.expandCodeFor(MinMax.Max, I8PtrTy, InsertBefore);
  LLVM_DEBUG(dbgs() << "Expanded Checks -- Min: " << *MinMax.Min
                    << ", Max: " << *MinMax.Max << "\n";);
  return {Min, Max};
}

static SmallVector<ExpandedRTAliasCheckInfo, 4>
expandBounds(SmallVectorImpl<RTAliasCheckInfo> &AliasChecks,
             Instruction *InsertBefore, SCEVExpander &SEExpander) {
  SmallVector<ExpandedRTAliasCheckInfo, 4> ExpandedAliasChecks;
  for (RTAliasCheckInfo &AC : AliasChecks) {
    ExpandedRTAliasCheckInfo EAC;
    EAC.Bounds1 = expandBoundsPair(AC.Bounds1, InsertBefore, SEExpander);
    EAC.Bounds2 = expandBoundsPair(AC.Bounds2, InsertBefore, SEExpander);
    ExpandedAliasChecks.push_back(EAC);
  }
  return ExpandedAliasChecks;
}

static void
emitRuntimeAliasChecks(ScalarEvolution &SE, DominatorTree &DT, LoopInfo &LI, const Loop *L,
                       SmallVectorImpl<RTAliasCheckInfo> &AliasChecks) {
  if (AliasChecks.empty())
    return;
  assert(L->isLoopSimplifyForm());
  BasicBlock *AliasChecksBlock = L->getLoopPreheader();
  Instruction *InsertBefore = (Instruction *) AliasChecksBlock->getTerminator();

  const DataLayout &DL = L->getHeader()->getModule()->getDataLayout();
  
  SCEVExpander SEExpander(SE, DL, "induction");
  auto ExpandedChecks = expandBounds(AliasChecks, InsertBefore, SEExpander);

  LLVMContext &Ctx = InsertBefore->getContext();
  IRBuilder<> CheckBuilder(InsertBefore);

  // Our instructions might fold to a constant.
  Value *RuntimeCheck = nullptr;

  for (const auto &Check : ExpandedChecks) {
    ExpandedMinMaxSCEVPair A = Check.Bounds1;
    ExpandedMinMaxSCEVPair B = Check.Bounds2;
    // Check if two pointers (A and B) conflict where conflict is computed as:
    // min(A) <= max(B) && min(B) <= max(A)
    unsigned AddrSpace = A.Min->getType()->getPointerAddressSpace();
    assert(AddrSpace == B.Min->getType()->getPointerAddressSpace());

    Type *I8PtrTy = Type::getInt8PtrTy(Ctx, AddrSpace);
    Value *Min1 = CheckBuilder.CreateBitCast(A.Min, I8PtrTy, "bc");
    Value *Min2 = CheckBuilder.CreateBitCast(B.Min, I8PtrTy, "bc");
    Value *Max1 = CheckBuilder.CreateBitCast(A.Max, I8PtrTy, "bc");
    Value *Max2 = CheckBuilder.CreateBitCast(B.Max, I8PtrTy, "bc");

    // [A|B].Min points to the minimum accessed byte under base [A|B].
    // [A|B].Max points to the maximum accessed byte.
    // There is no conflict when the intervals are disjoint:
    // NoConflict = (B.Min > A.Max) || (A.Min > B.Max)
    //
    // bound1 = (B.Min <= A.Max)
    // bound2 = (A.Min <= B.Max)
    //  TheyAlias = bound0 & bound1
    
    Value *Cmp1 = CheckBuilder.CreateICmpULE(Min1, Max2, "bound1");
    Value *Cmp2 = CheckBuilder.CreateICmpULE(Min2, Max1, "bound2");
    Value *TheyAlias = CheckBuilder.CreateAnd(Cmp1, Cmp2, "pointers.alias");
    if (RuntimeCheck) {
      TheyAlias =
          CheckBuilder.CreateOr(RuntimeCheck, TheyAlias, "alias.reduction");
    }
    RuntimeCheck = TheyAlias;
  }
  // We have to do this trickery because the IRBuilder might fold the check to a
  // constant expression in which case there is no Instruction anchored in a
  // the block.
  RuntimeCheck =
      BinaryOperator::CreateAnd(RuntimeCheck, ConstantInt::getTrue(Ctx));
  CheckBuilder.Insert(RuntimeCheck, "rt.alias.check");

  AliasChecksBlock->setName("vectorization.alias.checks");
  
  BasicBlock *LoopPreheader =
      SplitBlock(AliasChecksBlock, AliasChecksBlock->getTerminator(), &DT, &LI,
                 nullptr, "loop.ph");

  BasicBlock *ExitBlock = L->getExitBlock();
  // TODO: For now we hope that the loop has only one exit block.
  // In the end, this should be the preheader of the scalar version of the loop.
  assert(ExitBlock);
  Instruction *AliasCheckBranch =
      BranchInst::Create(ExitBlock, LoopPreheader, RuntimeCheck);
  ReplaceInstWithInst(AliasChecksBlock->getTerminator(), AliasCheckBranch);
}
#endif

const LoopDependence getImperfectNestDependence(LoopNestInfo NestInfo,
                                                LoopInfo &LI, DominatorTree &DT,
                                                ScalarEvolution &SE,
                                                const TargetLibraryInfo &TLI) {
  LoopDependence Bail = LoopDependence::getWorstPossible();
  const Loop &L = *NestInfo.AnalyzedLoop;
  const Loop &Inner = *NestInfo.InnermostLoop;

  SmallVector<ProgramOrderedAccess, 16> Loads;
  SmallVector<ProgramOrderedAccess, 16> Stores;

  // Find if there's any illegal instruction and gather
  // loads and stores, along with their program
  // order. Also put the pointers in the AST.
  unsigned ProgramOrder = 0;
  for (BasicBlock *BB : L.blocks()) {
    for (Instruction &I : *BB) {
      if (auto *Call = dyn_cast<CallBase>(&I)) {
        if (Call->isConvergent())
          return Bail;
      }

      // If this instruction may read from memory and it is not
      // a simple load or a known call, we can't vectorize it.
      if (I.mayReadFromMemory()) {
        // Many math library functions read the rounding mode. We will only
        // vectorize a loop if it contains known function calls that don't set
        // the flag. Therefore, it is safe to ignore this read from memory.
        auto *Call = dyn_cast<CallInst>(&I);
        if (Call && getVectorIntrinsicIDForCall(Call, &TLI))
          continue;

        // If the function has an explicit vectorized counterpart, we can safely
        // assume that it can be vectorized.
        if (Call && !Call->isNoBuiltin() && Call->getCalledFunction() &&
            !VFDatabase::getMappings(*Call).empty())
          continue;

        auto *Ld = dyn_cast<LoadInst>(&I);
        if (!Ld || !Ld->isSimple())
          return Bail;

        if (!isInNest(I, NestInfo))
          continue;

        Loads.push_back({Ld, ProgramOrder});
        ProgramOrder++;

        // If this instruction may write to memory and it is not a simple store,
        // then we can't vectorize it.
      } else if (I.mayWriteToMemory()) {
        auto *St = dyn_cast<StoreInst>(&I);
        if (!St || !St->isSimple())
          return Bail;

        if (!isInNest(I, NestInfo))
          continue;

        Stores.push_back(ProgramOrderedAccess::get(St, ProgramOrder));
        ProgramOrder++;
      } // else -> We don't care about any other instruction.
    }
  }

  // TODO: For now, we do a simple quadratic check. For every load, we check
  // whether there is a dependence with any of the stores.
  // Eventually, we want to be smarter about it, like LAA.

  // Starting from the best possible dependence (optimistically),
  // either bail out early for some reason, or try to meet
  // the best acceptable value (with monotone pessimistic movements).
  LoopDependence Res = LoopDependence::getBestPossible();

  SmallVector<RTAliasCheckInfo, 4> AliasChecks;

  LLVM_DEBUG(dbgs() << "\n\n-------------\n\n";
             dbgs() << "Analyze access pairs\n\n";);
  auto &DL = L.getHeader()->getModule()->getDataLayout();
  for (ProgramOrderedAccess LAccess : Loads) {
    LoadInst *Load = LAccess.Load;
    Value *LPtr = Load->getPointerOperand();

    for (ProgramOrderedAccess SAccess : Stores) {
      Value *SPtr = SAccess.Store->getPointerOperand();
      StoreInst *Store = SAccess.Store;

      LLVM_DEBUG(dbgs() << "\nLoad pointer: " << *LPtr << "\n";
                 dbgs() << *SE.getSCEVAtScope(LPtr, &Inner) << "\n\n";
                 dbgs() << "Store pointer: " << *SPtr << "\n";
                 dbgs() << *SE.getSCEVAtScope(SPtr, &Inner) << "\n";);

      SmallVector<const SCEV *, 3> Subscripts1, Subscripts2;
      SmallVector<const SCEV *, 3> Sizes1, Sizes2;

      // Special handling for globals.
      Value *LObj = getUnderlyingObject(LPtr);
      Type *LObjTy = LObj->getType();
      if (dyn_cast<GlobalValue>(LObj) && LObjTy->isPointerTy() &&
          LObjTy->getPointerElementType()->isArrayTy()) {
        Value *SObj = getUnderlyingObject(SPtr);
        Type *SObjTy = SObj->getType();

        LLVM_DEBUG(dbgs() << "\n";);
        LLVM_DEBUG(dbgs() << "LObj: " << *LObj << "\n";);
        LLVM_DEBUG(dbgs() << "SObj: " << *SObj << "\n";);

        // TODO: For now, we don't know global array and pointer
        // combination on aliasing.
        if (!dyn_cast<GlobalValue>(SObj) || !SObjTy->isPointerTy() ||
            !SObjTy->getPointerElementType()->isArrayTy()) {
          return Bail;
        }
        // They can't alias.
        if (LObj != SObj)
          continue;

        if (!delinearizePtrOnGlobalArray(SE, LPtr, LObj, Subscripts1, Sizes1,
                                         NestInfo))
          return Bail;
        if (!delinearizePtrOnGlobalArray(SE, SPtr, SObj, Subscripts2, Sizes2,
                                         NestInfo))
          return Bail;
      } else {
        // Note: Right now we are probably calling getUnderlyingObjects()
        // a lot of times.
        RTAliasCheckInfo AliasCheckInfo;
        CanAliasRes canAliasRes = canAlias(
            SE, LI, DL, LPtr, SPtr, NestInfo.InnermostLoop, AliasCheckInfo);
        if (canAliasRes == CanAliasRes::CANNOT_ALIAS) {
          LLVM_DEBUG(dbgs() << "Definitely can't alias\n";);
          continue;
        } else if (canAliasRes == CanAliasRes::CAN_ALIAS_NO_INFO) {
          LLVM_DEBUG(
              dbgs() << "They can alias and we have no info for RT check.\n";);
          return Bail;
        } else if (canAliasRes == CanAliasRes::CAN_ALIAS_RTCHECK_INFO) {
          AliasChecks.push_back(AliasCheckInfo);
          continue;
        } // else: Same object, the common case... keep going

        LLVM_DEBUG(dbgs() << "\n"; dbgs() << "\n\n------\n\n";
                   dbgs() << "Delinearize SCEVs\n";);

        if (!delinearizeInstAndVerifySubscripts(SE, Load, Subscripts1, Sizes1,
                                                NestInfo))
          return Bail;
        if (!delinearizeInstAndVerifySubscripts(SE, Store, Subscripts2, Sizes2,
                                                NestInfo))
          return Bail;
      }

      LLVM_DEBUG(dbgs() << "\n");
      DepVector IterDV(NestInfo.NumDimensions);
      DVValidity Valid =
          getDirVector(&SE, IterDV, Subscripts1, Subscripts2, NestInfo);
      if (Valid == DVValidity::INVALID)
        return Bail;
      if (Valid == DVValidity::DEFINITELY_VECTORIZABLE)
        continue;
      squashIfNeeded(IterDV);
      if (isForwardDependence(IterDV, LAccess.Position, SAccess.Position)) {
        LLVM_DEBUG(dbgs() << "It is forward dependence, skipping...\n");
        continue;
      }
      reflectIfNeeded(IterDV);
      LLVM_DEBUG(IterDV.print(););
      ConstVF MaxAllowedVectorizationFactor = getMaxAllowedVecFact(IterDV);
      if (MaxAllowedVectorizationFactor < Res.VectorizationFactor)
        Res.VectorizationFactor = MaxAllowedVectorizationFactor;
      if (Res.isWorstPossible())
        return Bail;
    }
  }

  // emitRuntimeAliasChecks(SE, DT, LI, NestInfo.AnalyzedLoop, AliasChecks);

  return Res;
}

struct DFSNestClipboard {

  DFSNestClipboard(const Loop *_AnalyzedLoop, LoopDependence StartingDep,
                   int _NumDimensions, LoopInfo &_LI, DominatorTree &_DT,
                   ScalarEvolution &_SE, const TargetLibraryInfo &_TLI)
      : AnalyzedLoop(_AnalyzedLoop), CurrentLoop(_AnalyzedLoop),
        CurrentDep(StartingDep), NumDimensions(_NumDimensions), LI(_LI),
        DT(_DT), SE(_SE), TLI(_TLI) {}

  const Loop *const AnalyzedLoop;
  const Loop *CurrentLoop;
  LoopDependence CurrentDep;
  int NumDimensions;

  LoopInfo &LI;
  DominatorTree &DT;
  ScalarEvolution &SE;
  const TargetLibraryInfo &TLI;
};

static bool analyzeNestsDFS(DFSNestClipboard *Clip) {
  const Loop *CurrentLoop = Clip->CurrentLoop;

  if (CurrentLoop->isInnermost()) {
    LoopNestInfo NestInfo = {Clip->NumDimensions, Clip->CurrentLoop,
                             Clip->AnalyzedLoop};
    const LoopDependence Dep = getImperfectNestDependence(
        NestInfo, Clip->LI, Clip->DT, Clip->SE, Clip->TLI);
    if (Dep.VectorizationFactor < Clip->CurrentDep.VectorizationFactor)
      Clip->CurrentDep = Dep;
    return !Clip->CurrentDep.isWorstPossible();
  }

  const auto &SubLoops = CurrentLoop->getSubLoops();
  for (const Loop *Sub : SubLoops) {
    Clip->CurrentLoop = Sub;
    Clip->NumDimensions += 1;
    if (!analyzeNestsDFS(Clip))
      return false;
    Clip->NumDimensions -= 1;
  }
  return true;
}

const LoopDependence
LoopDependenceInfo::getDependenceInfo(const Loop &L) const {
  LoopDependence Bail = LoopDependence::getWorstPossible();

  if (L.isAnnotatedParallel())
    return LoopDependence::getBestPossible();

  if (!L.isLoopSimplifyForm())
    return Bail;

  DFSNestClipboard Clip(&L, LoopDependence::getBestPossible(), 1, LI, DT, SE,
                        TLI);
  analyzeNestsDFS(&Clip);

  return Clip.CurrentDep;
}

/// Printer Pass

// Print results for all loops in DFS.
static void printAllLoops(LoopDependenceInfo *LDI, const Loop *L) {
  assert(L);
  LoopDependence Res = LDI->getDependenceInfo(*L);
  dbgs() << "\nLoop: " << L->getName() << ": ";
  if (!Res.VectorizationFactor.hasValue()) {
    dbgs() << "Is vectorizable for any factor\n";
  } else {
    uint64_t VF = Res.VectorizationFactor.getValue();
    if (VF > 1)
      dbgs() << "Is vectorizable with VF: " << VF << "\n";
    else
      dbgs() << "Is NOT vectorizable\n";
  }
  dbgs() << "\n";
  for (const Loop *L : L->getSubLoops()) {
    printAllLoops(LDI, L);
  }
}

llvm::PreservedAnalyses
LoopDependencePrinter::run(Function &F, FunctionAnalysisManager &FAM) {
  auto &LoopDepInfo = FAM.getResult<LoopDependenceAnalysis>(F);
  LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
  for (const Loop *L : LI) {
    printAllLoops(&LoopDepInfo, L);
  }
  return llvm::PreservedAnalyses::all();
}
