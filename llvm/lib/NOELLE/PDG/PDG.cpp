/*
 * Copyright 2016 - 2020  Angelo Matni, Yian Su, Simone Campanoni
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions: The above copyright
 * notice and this permission notice shall be included in all copies or
 * substantial portions of the Software. THE SOFTWARE IS PROVIDED "AS IS",
 * WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
 * FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include "llvm/NOELLE/PDG/PDG.h"

using namespace llvm;
using namespace noelle;

namespace llvm {

namespace noelle {

template <class T, class SubT>
DGHyperEdge<T, SubT>::DGHyperEdge(const DGHyperEdge<T, SubT> &OtherEdge) {
  auto NodePair = OtherEdge.getNodePair();
  auto From = NodePair.first;
  auto To = NodePair.second;
  copyEdgeCharacteristics(OtherEdge);
  /*
  for (auto SubEdge : OtherEdge.subEdges)
    addSubEdge(SubEdge);
  */
}

/*
 * *** DGNode ***
 */

template <class T> void DGNode<T>::addOutgoingEdge(DGEdge<T> *Edge) {
  outgoingEdges.insert(Edge);
}

template <class T> void DGNode<T>::addIncomingEdge(DGEdge<T> *Edge) {
  incomingEdges.insert(Edge);
}

/*
 * *** DG ***
 */

template <class T> DGNode<T> *DG<T>::fetchNode(const T *TheTT) const {
  T *TheT = (T *)TheTT;
  auto NodeIt = internalNodeMap.find(TheTT);
  if (NodeIt != internalNodeMap.end())
    return NodeIt->second;

  NodeIt = externalNodeMap.find(TheTT);
  if (NodeIt != externalNodeMap.end())
    return NodeIt->second;
  return nullptr;
}

template <class T>
DGNode<T> *DG<T>::fetchOrAddNode(const T *theT, bool inclusion) {
  if (isInGraph(theT))
    return fetchNode(theT);
  return addNode(theT, inclusion);
}

template <class T> void DG<T>::registerEdge(DGEdge<T> *Edge) {
  DGNode<T> *FromNode = Edge->getOutgoingNode();
  DGNode<T> *ToNode = Edge->getIncomingNode();
  auto InsertResult = allEdges.insert(Edge);
  assert(InsertResult.second == true);
  FromNode->addOutgoingEdge(Edge);
  ToNode->addIncomingEdge(Edge);
}

template <class T> bool DG<T>::edgeExists(DGEdge<T> *NewEdge) {
  const T *FromT = NewEdge->getOutgoingT();
  DGNode<T> *FromNode = fetchNode(FromT);
  assert(FromNode);
  const T *ToT = NewEdge->getIncomingT();
  DGNode<T> *ToNode = fetchNode(ToT);
  assert(ToNode);
  // Check duplicate
  for (DGEdge<Value> *ExistingEdge : this->fetchEdges(FromNode, ToNode)) {
    if (ExistingEdge->hasSameCharacteristics(*NewEdge))
      return true;
  }
  return false;
}

// Return true if the edge was added.
template <class T> bool DG<T>::addEdge(DGEdge<T> *NewEdge) {
  if (edgeExists(NewEdge))
    return false;
  registerEdge(NewEdge);
  return true;
}

template <class T> DGEdge<T> *DG<T>::addEdge(const T *From, const T *To) {
  DGEdge<T> *Edge = createUncharacterizedEdge(From, To);
  // dbgs() << "Source: " << Edge << "\n";
  // Assert it was actually inserted (i.e., it didn't already exist)
  registerEdge(Edge);
  return Edge;
}

template <class T> DGEdge<T> *DG<T>::copyEdge(DGEdge<T> &EdgeToCopy) {
  auto Edge = new DGEdge<T>(EdgeToCopy);
  allEdges.insert(Edge);

  /*
   * Point copy of edge to equivalent nodes in this graph
   * (We're assuming that `EdgeToCopy` is in another graph)
   */
  auto NodePair = EdgeToCopy.getNodePair();
  auto FromNode = fetchNode(NodePair.first->getT());
  auto ToNode = fetchNode(NodePair.second->getT());
  Edge->setNodePair(FromNode, ToNode);

  FromNode->addOutgoingEdge(Edge);
  ToNode->addIncomingEdge(Edge);
  return Edge;
}

template <class T> DGNode<T> *DG<T>::addNode(const T *TheT, bool IsInternal) {
  assert(fetchNode(TheT) == nullptr);
  auto Node = new DGNode<T>(nodeIdCounter++, TheT);
  allNodes.insert(Node);
  auto &map = IsInternal ? internalNodeMap : externalNodeMap;
  map[TheT] = Node;
  return Node;
}

/*
 * *** PDG ***
 */

PDG::PDG(Module &M) {

  // Create a node per instruction and function argument
  for (auto &F : M) {
    if (F.isDeclaration())
      continue;
    addNodesOf(F);
  }

  // Set the entry node: the first instruction of the function "main"
  Function *MainF = M.getFunction("main");
  // It's possible that a Module PDG does not have an entry point. We don't
  // want to limit NOELLE only in complete programs.
  if (MainF) {
    this->setEntryPointAt(*MainF);
  } else {
    this->setEntryNode(nullptr);
  }
  return;
}

PDG::PDG(Function &F) {
  addNodesOf(F);
  setEntryPointAt(F);

  return;
}

PDG::PDG(const Loop *L) {

  /*
   * Create a node per instruction within loops of LI only (meaning
   * if an instruction is added, it must have been recognized as part
   * of a Loop by LI).
   */
  for (BasicBlock *BB : L->blocks()) {
    for (auto &I : *BB) {
      this->addNode(&I, /* isInternal = */ true);
    }
  }

  // Set the entry node as the loop header
  BasicBlock *Header = L->getHeader();
  Instruction &FirstInst = *(Header->begin());
  this->entryNode = this->internalNodeMap[&FirstInst];
  assert(this->entryNode != nullptr);

  return;
}

DGEdge<Value> *PDG::addEdge(const Value *From, const Value *To) {
  return this->DG<Value>::addEdge(From, To);
}

bool PDG::addEdge(DGEdge<Value> *NewEdge) {
  return this->DG<Value>::addEdge(NewEdge);
}

void PDG::setEntryPointAt(Function &F) {
  auto entryInstr = &*(F.begin()->begin());
  entryNode = internalNodeMap[entryInstr];
  assert(entryNode != nullptr);
}

void PDG::addNodesOf(Function &F) {
  // Add nodes for each instruction and function arg
  for (Argument &Arg : F.args()) {
    addNode(&Arg, /* isInternal = */ true);
  }
  for (BasicBlock &BB : F) {
    for (Instruction &I : BB) {
      addNode(&I, /* isInternal = */ true);
    }
  }
}

void PDG::addNodesOf(Loop *L) {
  for (BasicBlock *BB : L->getBlocks()) {
    for (Instruction &I : *BB) {
      addNode(&I, /* isInternal = */ true);
    }
  }
}

PDG *PDG::createFunctionSubgraph(Function &F) {
  // Check if the function has a body.
  if (F.empty())
    return nullptr;

  // Create the sub-PDG.
  PDG *FunctionPDG = new PDG(F);

  // Recreate all edges connected to internal nodes of function
  this->copyEdgesInto(FunctionPDG, /*linkToExternal=*/true);
  for (auto Edge : FunctionPDG->getEdges()) {
    assert(!Edge->isLoopCarriedDependence() && "Flag was already set");
  }
  return FunctionPDG;
}

PDG *PDG::createLoopSubgraph(const Loop *L) const {

  /*
   * Create a node per instruction within loops of LI only (meaning
   * if an instruction is added, it must have been recognized as part
   * of a Loop by LI).
   */
  PDG *loopPDG = new PDG(L);

  // Recreate all edges connected to internal nodes of loop
  copyEdgesInto(loopPDG, /*linkToExternal=*/true);

  return loopPDG;
}

bool PDG::iterateOverDependencesTo(
    const Value *ToValue, bool IncludeControlDependences,
    bool IncludeMemoryDataDependences, bool IncludeRegisterDataDependences,
    std::function<bool(const Value *FromValue, DGEdge<Value> *DepEdge)>
        functionToInvokePerDependence) const {
  // Fetch the node in the PDG.
  DGNode<Value> *PDGNode = this->fetchNode(ToValue);
  if (PDGNode == nullptr) {
    return false;
  }

  // Iterate over the incoming edges of the node (the sources of these edges
  // are the values that ToValue depends on).
  for (DGEdge<Value> *Edge : PDGNode->getIncomingEdges()) {
    const Value *SrcValue = Edge->getOutgoingT();

    if (IncludeControlDependences &&
        Edge->isControlDependence()) { // Control Dependence
      if (functionToInvokePerDependence(SrcValue, Edge)) {
        return true;
      }
    } else if (IncludeMemoryDataDependences &&
               Edge->isMemoryDependence()) { // Memory Data Dependence
      if (functionToInvokePerDependence(SrcValue, Edge)) {
        return true;
      }
    } else if (IncludeRegisterDataDependences &&
               Edge->isRegisterDependence()) { // Register Data Dependence
      if (functionToInvokePerDependence(SrcValue, Edge)) {
        return true;
      }
    }
  }
  return false;
}

bool PDG::iterateOverDependencesFrom(
    const Value *FromValue, bool IncludeControlDependences,
    bool IncludeMemoryDataDependences, bool IncludeRegisterDataDependences,
    std::function<bool(const Value *ToValue, DGEdge<Value> *DepEdge)>
        functionToInvokePerDependence) const {
  // Fetch the node in the PDG.
  DGNode<Value> *PDGNode = this->fetchNode(FromValue);
  if (PDGNode == nullptr) {
    return false;
  }

  // Iterate over the incoming edges of the node (the sources of these edges
  // are the values that ToValue depends on).
  for (DGEdge<Value> *Edge : PDGNode->getOutgoingEdges()) {
    const Value *DstValue = Edge->getIncomingT();

    if (IncludeControlDependences &&
        Edge->isControlDependence()) { // Control Dependence
      if (functionToInvokePerDependence(DstValue, Edge)) {
        return true;
      }
    } else if (IncludeMemoryDataDependences &&
               Edge->isMemoryDependence()) { // Memory Data Dependence
      if (functionToInvokePerDependence(DstValue, Edge)) {
        return true;
      }
    } else if (IncludeRegisterDataDependences &&
               Edge->isRegisterDependence()) { // Register Data Dependence
      if (functionToInvokePerDependence(DstValue, Edge)) {
        return true;
      }
    }
  }
  return false;
}

void PDG::copyEdgesInto(PDG *newPDG, bool linkToExternal) const {
  this->copyEdgesInto(newPDG, linkToExternal, {});
  return;
}

void PDG::copyEdgesInto(
    PDG *newPDG, bool linkToExternal,
    std::unordered_set<DGEdge<Value> *> const &edgesToIgnore) const {

  for (auto *oldEdge : allEdges) {
    if (edgesToIgnore.find(oldEdge) != edgesToIgnore.end()) {
      continue;
    }

    auto nodePair = oldEdge->getNodePair();
    auto fromT = nodePair.first->getT();
    auto toT = nodePair.second->getT();

    /*
     * Check whether edge belongs to nodes within function F
     */
    auto fromInclusion = newPDG->isInternal(fromT);
    auto toInclusion = newPDG->isInternal(toT);
    if (!fromInclusion && !toInclusion) {
      continue;
    }
    if (!linkToExternal && (!fromInclusion || !toInclusion)) {
      continue;
    }

    /*
     * Create appropriate external nodes and associate edge to them
     */
    auto newFromNode = newPDG->fetchOrAddNode(fromT, fromInclusion);
    auto newToNode = newPDG->fetchOrAddNode(toT, toInclusion);

    /*
     * Copy edge to match properties (mem/var, must/may, RAW/WAW/WAR/control)
     */
    newPDG->copyEdge(*oldEdge);
  }

  return;
}

} // namespace noelle
} // namespace llvm
