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

#ifndef LLVM_NOELLE_PDG_PDG_H
#define LLVM_NOELLE_PDG_PDG_H

#include <string>
#include <unordered_map>
#include <unordered_set>

#include "llvm/Analysis/DependenceAnalysis.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/Function.h"

using namespace llvm;

namespace llvm {
namespace noelle {

/*
 * Pre-Declarations
 */

template <class T> class DG;
template <class T> class DGNode;
template <class T> class DGEdge;

enum class DataDepType { NONE, RAW, WAR, WAW };

/*
 * Definitions
 */

/*
 * This is a hyper-edge, which means, multiple underlying / sub-edges contribute
 * to its existence. To understand that, imagine a graph G of nodes and a
 * hyper-graph HG of SCCs incident to G. Let's say there are two SCCs, S1, S2
 * and two edges:
 * a) E1: From a node N1 of S1 to a node N2 of S2
 * b) E2: From a node N3 of S1 to a node N4 of S2
 *
 * Both of these edges represent the same thing in HG: S1 points to S2 (in other
 * words, _somehow_, from S1 you can reach S2). So, we group these edges in a
 * single hyper-edge which is created because of E1, E2 (i.e. those are its
 * subedges).
 *
 * Connecting the example above with the class below, T = SCC, SubT = node.
 * Hyper-edges point from T to T and sub-edges from SubT to SubT.
 */
template <class T, class SubT> class DGHyperEdge {
public:
  DGHyperEdge(DGNode<T> *Src, DGNode<T> *Dst)
      : from(Src), to(Dst), memory(false), must(false),
        dataDepType(DataDepType::NONE), isControl(false) {}
  DGHyperEdge(const DGHyperEdge<T, SubT> &OtherEdge);

  /*
  typedef typename std::unordered_set<DGEdge<SubT> *> SubEdgeSetT;

  typedef typename SubEdgeSetT::iterator edges_iterator;
  typedef typename SubEdgeSetT::const_iterator edges_const_iterator;

  edges_iterator begin_sub_edges() { return subEdges.begin(); }
  edges_iterator end_sub_edges() { return subEdges.end(); }
  edges_const_iterator begin_sub_edges() const { return subEdges.begin(); }
  edges_const_iterator end_sub_edges() const { return subEdges.end(); }

  inline iterator_range<edges_iterator> getSubEdges() {
    return make_range(subEdges.begin(), subEdges.end());
  }

  void addSubEdge(DGEdge<SubT> *edge) {
    subEdges.insert(edge);
    isLoopCarried |= edge->isLoopCarriedDependence();
    
    if (edge->isRemovableDependence() &&
        (subEdges.size() == 1 || this->isRemovableDependence())) {
      isRemovable = true;
      if (auto optional_remeds = edge->getRemedies()) {
        for (auto &r : *(optional_remeds))
          this->addRemedies(r);
      }
    } else {
      remeds = nullptr;
      isRemovable = false;
    }
  }

  void removeSubEdge(DGEdge<SubT> *edge) {
    subEdges.erase(edge);
  }

  void clearSubEdges() {
    subEdges.clear();
    setLoopCarried(false);
    setRemovable(false);
  }
  */
  
  
  bool hasSameCharacteristics(const DGHyperEdge<T, SubT> &Other) const {
    bool SameMem = (memory == Other.memory);
    bool SameMust = (must == Other.must);
    bool SameCtrl = (isControl == Other.isControl);
    bool SameType = (dataDepType == Other.dataDepType);
    return (SameMem && SameMust && SameCtrl && SameType);
  }

  bool operator==(const DGHyperEdge<T, SubT> &B) const {
    bool SameFrom = (from == B.from);
    bool SameTo = (to == B.to);
    return (SameFrom && SameTo && hasSameCharacteristics(B));
  }

  void copyEdgeCharacteristics(const DGHyperEdge<T, SubT> &OtherEdge) {
    setMemMustType(OtherEdge.isMemoryDependence(), OtherEdge.isMustDependence(),
                   OtherEdge.dataDependenceType());
    setControl(OtherEdge.isControlDependence());
  }

  std::pair<DGNode<T> *, DGNode<T> *> getNodePair() const {
    return std::make_pair(from, to);
  }
  void setNodePair(DGNode<T> *from, DGNode<T> *to) {
    this->from = from;
    this->to = to;
  }
  DGNode<T> *getOutgoingNode() const { return from; }
  DGNode<T> *getIncomingNode() const { return to; }
  const T *getOutgoingT() const { return from->getT(); }
  const T *getIncomingT() const { return to->getT(); }

  bool isMemoryDependence() const {
    if (memory) {
      assert(isDataDependence());
      return true;
    }
    return false;
  }
  bool isMustDependence() const { return must; }
  bool isRAWDependence() const { return dataDepType == DataDepType::RAW; }
  bool isWARDependence() const { return dataDepType == DataDepType::WAR; }
  bool isWAWDependence() const { return dataDepType == DataDepType::WAW; }
  bool isControlDependence() const { return isControl; }
  bool isDataDependence() const {
    if (!isControl) {
      assert(dataDepType != DataDepType::NONE);
      return true;
    }
    return false;
  }
  bool isRegisterDependence() const {
    return isDataDependence() && !isMemoryDependence();
  }
  DataDepType dataDependenceType() const { return dataDepType; }

  /*
  std::optional<SetOfRemedies> getRemedies() const {
    return (remeds) ? std::make_optional<SetOfRemedies>(*remeds) : std::nullopt;
  }
  */

  void setControl(bool ctrl) { isControl = ctrl; }
  void setMemMustType(bool mem, bool must, DataDepType dataDepType) {
    this->memory = mem;
    this->must = must;
    this->dataDepType = dataDepType;
  }

  void setEdgeAttributes(bool mem, bool must, std::string str, bool ctrl) {
    setMemMustType(mem, must, stringToDataDep(str));
    setControl(ctrl);

    return;
  }

  std::string kindToString() const;
  std::string dataDepToString() const {
    if (this->isRAWDependence())
      return "RAW";
    else if (this->isWARDependence())
      return "WAR";
    else if (this->isWAWDependence())
      return "WAW";
    else
      return "NONE";
  }

  static DataDepType stringToDataDep(std::string &str) {
    if (str == "RAW")
      return DataDepType::RAW;
    else if (str == "WAR")
      return DataDepType::WAR;
    else if (str == "WAW")
      return DataDepType::WAW;
    else
      return DataDepType::NONE;
  }

protected:
  DGNode<T> *from;
  DGNode<T> *to;
  //SubEdgeSetT subEdges;

  // TODO: Use LLVM's bit set (keep getters the same)
  bool memory;
  bool must;
  bool isControl;

  DataDepType dataDepType;

public:
  std::unique_ptr<Dependence> Dep;
};

/*
 * This is just a helper class which is used for "normal" edges, i.e. not
 * hyper-edges (we cheat by inheriting from the hyper-edge class but setting T
 * and SubT to the same type).
 */

template <class T> class DGEdge : public DGHyperEdge<T, T> {
public:
  DGEdge(DGNode<T> *src, DGNode<T> *dst) : DGHyperEdge<T, T>(src, dst) {}
  DGEdge(const DGEdge<T> &oldEdge) : DGHyperEdge<T, T>(oldEdge) {}
};

inline raw_ostream &operator<<(raw_ostream &OS, const DGEdge<Value> &Edge) {

  auto PrintValue = [&](const Value *V) -> void {
    if (auto Arg = dyn_cast<Argument>(V)) {
      OS << "@" << Arg->getParent()->getName() << " :: %" << Arg->getName();
      return;
    }
    // TODO: Maybe there are other things?
    const Instruction *I = dyn_cast<Instruction>(V);
    assert(I != nullptr);
    StringRef ParentName = I->getFunction()->getName();
    OS << "@" << ParentName << "(";
    if (I->hasName()) {
      OS << "  %" << I->getName() << "  )";
      return;
    }
    // TODO: Branch instructions
    if (auto Load = dyn_cast<LoadInst>(I)) {
      // Note that the check above whether the Instruction has a name
      // won't necessarily catch all loads. The reason that if the "name" of
      // the register was added automatically and it's a number, e.g., %0, this
      // is considered to not have a name.
      OS << "  load %" << Load->getPointerOperand()->getName();
    } else if (auto Store = dyn_cast<StoreInst>(I)) {
      OS << "  store %" << Store->getPointerOperand()->getName();
    } else if (auto Call = dyn_cast<CallBase>(I)) {
      OS << "  call @" << Call->getCalledFunction()->getName() << "()";
    } else {
      OS << *I;
    }
    OS << "  )";
  };

  const Value *From = Edge.getOutgoingT();
  const Value *To = Edge.getIncomingT();

  PrintValue(From);
  OS << " ----> ";
  PrintValue(To);
  OS << "  [";
  OS << Edge.kindToString();
  OS << "]";
  return OS;
}

template <class T> class DGNode {
public:
  typedef typename std::unordered_set<DGEdge<T> *> EdgeSetT;

  typedef typename std::vector<DGNode<T> *>::iterator nodes_iterator;
  typedef typename EdgeSetT::iterator edges_iterator;
  typedef typename EdgeSetT::const_iterator edges_const_iterator;

  edges_iterator begin_outgoing_edges() { return outgoingEdges.begin(); }
  edges_iterator end_outgoing_edges() { return outgoingEdges.end(); }
  edges_const_iterator begin_outgoing_edges() const {
    return outgoingEdges.begin();
  }
  edges_const_iterator end_outgoing_edges() const {
    return outgoingEdges.end();
  }

  edges_iterator begin_incoming_edges() { return incomingEdges.begin(); }
  edges_iterator end_incoming_edges() { return incomingEdges.end(); }
  edges_const_iterator begin_incoming_edges() const {
    return incomingEdges.begin();
  }
  edges_const_iterator end_incoming_edges() const {
    return incomingEdges.end();
  }

  EdgeSetT getAllConnectedEdges() {
    EdgeSetT allConnectedEdges{outgoingEdges.begin(), outgoingEdges.end()};
    allConnectedEdges.insert(incomingEdges.begin(), incomingEdges.end());
    return allConnectedEdges;
  }

  inline iterator_range<edges_iterator> getOutgoingEdges() {
    return make_range(outgoingEdges.begin(), outgoingEdges.end());
  }
  inline iterator_range<edges_iterator> getIncomingEdges() {
    return make_range(incomingEdges.begin(), incomingEdges.end());
  }

  const T *getT() const { return theT; }

  unsigned numConnectedEdges() {
    return outgoingEdges.size() + incomingEdges.size();
  }
  unsigned numOutgoingEdges() { return outgoingEdges.size(); }
  unsigned numIncomingEdges() { return incomingEdges.size(); }

  void addIncomingEdge(DGEdge<T> *edge);
  void addOutgoingEdge(DGEdge<T> *edge);
  void removeConnectedEdge(DGEdge<T> *Edge);
  void removeConnectedNode(DGNode<T> *node);

  std::string toString() const;

protected:
  DGNode(int32_t id) : ID{id}, theT(nullptr) {}
  DGNode(int32_t id, const T *node) : ID{id}, theT(node) {}

  int32_t ID;
  const T *theT;
  EdgeSetT outgoingEdges;
  EdgeSetT incomingEdges;

  friend class DG<T>;
};

/*
 * We would probably like this to be designed as an intrusive graph so that
 * we don't have to continuously look up the maps.
 */

template <class T> class DG {
public:
  DG() : nodeIdCounter{0}, entryNode(nullptr) {}
  ~DG() {
    for (DGEdge<T> *Edge : allEdges) {
      if (Edge) {
        delete Edge;
      }
    }
    for (DGNode<T> *Node : allNodes) {
      if (Node) {
        delete Node;
      }
    }
  }

  typedef typename std::unordered_set<DGNode<T> *> NodeSetT;
  typedef typename std::unordered_set<DGEdge<T> *> EdgeSetT;

  typedef typename NodeSetT::iterator nodes_iterator;
  typedef typename NodeSetT::const_iterator nodes_const_iterator;

  typedef typename EdgeSetT::iterator edges_iterator;
  typedef typename EdgeSetT::const_iterator edges_const_iterator;

  typedef
      typename std::unordered_map<const T *, DGNode<T> *>::iterator node_map_iterator;

  /*
   * Node and Edge Iterators
   */
  nodes_iterator begin_nodes() {
    auto n = allNodes.begin();
    return n;
  }

  nodes_iterator end_nodes() {
    auto n = allNodes.end();
    return n;
  }

  nodes_const_iterator begin_nodes() const {
    auto n = allNodes.begin();
    return n;
  }

  nodes_const_iterator end_nodes() const {
    auto n = allNodes.end();
    return n;
  }

  node_map_iterator begin_internal_node_map() {
    auto n = internalNodeMap.begin();
    return n;
  }

  node_map_iterator end_internal_node_map() {
    auto n = internalNodeMap.end();
    return n;
  }

  node_map_iterator begin_external_node_map() {
    auto n = externalNodeMap.begin();
    return n;
  }

  node_map_iterator end_external_node_map() {
    auto n = externalNodeMap.end();
    return n;
  }

  edges_iterator begin_edges() {
    auto e = allEdges.begin();
    return e;
  }

  edges_iterator end_edges() {
    auto e = allEdges.end();
    return e;
  }

  edges_const_iterator begin_edges() const {
    auto e = allEdges.begin();
    return e;
  }

  edges_const_iterator end_edges() const {
    auto e = allEdges.end();
    return e;
  }

  /*
   * Node and Edge Properties
   */
  DGNode<T> *getEntryNode() const { return entryNode; }
  void setEntryNode(DGNode<T> *node) { entryNode = node; }

  bool isInternal(const T *theT) const {
    return internalNodeMap.find(theT) != internalNodeMap.end();
  }
  bool isExternal(const T *theT) const {
    return externalNodeMap.find(theT) != externalNodeMap.end();
  }
  bool isInGraph(const T *theT) const { return isInternal(theT) || isExternal(theT); }

  unsigned numNodes() const { return allNodes.size(); }
  unsigned numInternalNodes() const { return internalNodeMap.size(); }
  unsigned numExternalNodes() const { return externalNodeMap.size(); }
  unsigned numEdges() const { return allEdges.size(); }

  /*
   * Iterator ranges
   */
  iterator_range<nodes_iterator> getNodes() {
    return make_range(allNodes.begin(), allNodes.end());
  }
  iterator_range<edges_iterator> getEdges() {
    return make_range(allEdges.begin(), allEdges.end());
  }

  iterator_range<node_map_iterator> internalNodePairs() {
    return make_range(internalNodeMap.begin(), internalNodeMap.end());
  }
  iterator_range<node_map_iterator> externalNodePairs() {
    return make_range(externalNodeMap.begin(), externalNodeMap.end());
  }

  /*
   * Fetching/Creating Nodes and Edges
   */
  DGNode<T> *addNode(const T *theT, bool IsInternal);
  DGNode<T> *fetchOrAddNode(const T *theT, bool IsInternal);
  DGNode<T> *fetchNode(const T *theT) const;
  const DGNode<T> *fetchConstNode(const T *theT) const;

  DGEdge<T> *addEdge(const T *From, const T *To);
  bool addEdge(DGEdge<T> *NewEdge);
  bool edgeExists(DGEdge<T> *NewEdge);
  std::unordered_set<DGEdge<T>*> fetchEdges(DGNode<T>* From, DGNode<T>* To) {
    std::unordered_set<DGEdge<T> *> EdgeSet;
    for (DGEdge<T> *Edge : From->getOutgoingEdges()) {
      if (Edge->getIncomingNode() == To) {
        EdgeSet.insert(Edge);
      }
    }
    return EdgeSet;
  }
  DGEdge<T>* createUncharacterizedEdge(const T* From, const T* To) {
    DGNode<T> *FromNode = fetchNode(From);
    assert(FromNode);
    DGNode<T> *ToNode = fetchNode(To);
    assert(ToNode);
    auto Edge = new DGEdge<T>(FromNode, ToNode);
    return Edge;
  }
  DGEdge<T> *copyEdge(DGEdge<T> &edgeToCopy);

  /*
   * Merging/Extracting Graphs
   */
  NodeSetT getTopLevelNodes(bool onlyInternal = false);
  NodeSetT getLeafNodes(bool onlyInternal = false);
  std::vector<NodeSetT *> getDisconnectedSubgraphs();
  NodeSetT getNextDepthNodes(DGNode<T> *node);
  NodeSetT getPreviousDepthNodes(DGNode<T> *node);
  void removeNode(DGNode<T> *node);
  void removeEdge(DGEdge<T> *Edge);
  void copyNodesIntoNewGraph(DG<T> &newGraph,
                             std::unordered_set<DGNode<T> *> nodesToPartition,
                             DGNode<T> *entryNode);
  void clear();

protected:

  void registerEdge(DGEdge<T> *Edge);

  int32_t nodeIdCounter;
  NodeSetT allNodes;
  EdgeSetT allEdges;
  DGNode<T> *entryNode;
  std::unordered_map<const T *, DGNode<T> *> internalNodeMap;
  std::unordered_map<const T *, DGNode<T> *> externalNodeMap;
};

// TODO: Possibly we want to templetize the PDG on the unit it's constructed
// from (e.g., Loop, Function, Module). It just seems hard to handle if you
// don't know what's the "parent" unit. _However_, that's not trivial to do,
// because e.g., how do we implement createSubgraphFromValues() ? And that's
// used a lot...

class PDG : public DG<Value> {
public:
  /*
   * Constructors. All constructors which take IR units as input,
   * just copy the _nodes_ (i.e. instructions and function arguments) to the PDG
   * (We then have to only add edges).
   */
  PDG() = default;
  PDG(Module &F);
  PDG(Function &F);
  PDG(const Loop *L);

  ~PDG() = default;

  DGEdge<Value> *addEdge(const Value *From, const Value *To);
  bool addEdge(DGEdge<Value> *NewEdge);

  /*
   * Add nodes from an IR unit.
   */
  void addNodesOf(Module &M);
  void addNodesOf(Function &F);
  void addNodesOf(Loop *L);

  /*
   * Creating Program Dependence Subgraphs
   */
  PDG *createFunctionSubgraph(Function &F);
  PDG *createLoopSubgraph(const Loop *loop) const;

  PDG *createSubgraphFromValues(std::vector<Value *> &valueList,
                                bool linkToExternal);
  PDG *
  createSubgraphFromValues(std::vector<Value *> &valueList, bool linkToExternal,
                           std::unordered_set<DGEdge<Value> *> edgesToIgnore);

  /*
   * Iterate over the Values J that `ToValue` depends on (i.e. there is
   * an edge J -> ToValue) until @functionToInvokePerDependence returns true or
   * there is no other dependence to iterate.
   *
   * This function returns true if the iteration ends earlier.
   * It returns false otherwise.
   */
  bool iterateOverDependencesTo(
      const Value *ToValue, bool IncludeControlDependences,
      bool IncludeMemoryDataDependences, bool IncludeRegisterDataDependences,
      std::function<bool(const Value *FromValue, DGEdge<Value> *DepEdge)>
          functionToInvokePerDependence) const;

  /*
   * Iterate over the Values J that depend on `FromValue` (i.e. there is
   * an edge FromValue -> J) until @functionToInvokePerDependence returns true or
   * there is no other dependence to iterate.
   *
   * This function returns true if the iteration ends earlier.
   * It returns false otherwise.
   */
  bool iterateOverDependencesFrom(
      const Value *FromValue, bool IncludeControlDependences,
      bool IncludeMemoryDataDependences, bool IncludeRegisterDataDependences,
      std::function<bool(const Value *ToValue, DGEdge<Value> *DepEdge)>
          functionToInvokePerDependence) const;

private:
  void setEntryPointAt(Function &F);

  void copyEdgesInto(PDG *newPDG, bool linkToExternal) const;

  void copyEdgesInto(PDG *newPDG, bool linkToExternal,
                     std::unordered_set<DGEdge<Value> *> const &edgesToIgnore) const;
};

template <class T> void DGNode<T>::removeConnectedEdge(DGEdge<T> *Edge) {
  if (outgoingEdges.count(Edge))
    outgoingEdges.erase(Edge);
  else
    incomingEdges.erase(Edge);
}

template <class T> std::string DGNode<T>::toString() const {
  std::string nodeStr;
  raw_string_ostream ros(nodeStr);
  theT->print(ros);
  ros.flush();
  return nodeStr;
}

template <> inline std::string DGNode<Instruction>::toString() const {
  if (!theT)
    return "Empty node";
  std::string str;
  raw_string_ostream instStream(str);
  theT->print(instStream << theT->getFunction()->getName() << ": ");
  return str;
}

template <class T>
inline raw_ostream &operator<<(raw_ostream &OS, const DGNode<T> &Node) {
  OS << Node.toString();
  return OS;
}

template <class T, class SubT>
std::string DGHyperEdge<T, SubT>::kindToString() const {
  /*
  if (this->subEdges.size() > 0) {
    std::string edgesStr;
    raw_string_ostream ros(edgesStr);
    for (auto edge : this->subEdges)
      ros << edge->kindToString();
    return ros.str();
  }
  */
  if (this->isControlDependence())
    return "CTRL";
  std::string edgeStr;
  raw_string_ostream ros(edgeStr);
  ros << this->dataDepToString();
  ros << (must ? " (must)" : " (may)");
  ros << (memory ? " from memory " : "");
  ros.flush();
  return edgeStr;
}

template <class T> void DG<T>::removeEdge(DGEdge<T> *Edge) {
  Edge->getOutgoingNode()->removeConnectedEdge(Edge);
  Edge->getIncomingNode()->removeConnectedEdge(Edge);
  allEdges.erase(Edge);
  delete Edge;
}

template <class T> void DGNode<T>::removeConnectedNode(DGNode<T> *node) {
  std::unordered_set<DGEdge<T> *> outgoingEdgesToRemove{};
  for (auto edge : outgoingEdges) {
    if (edge->getIncomingNode() == node) {
      outgoingEdgesToRemove.insert(edge);
    }
  }
  for (auto edge : outgoingEdgesToRemove) {
    outgoingEdges.erase(edge);
  }

  std::unordered_set<DGEdge<T> *> incomingEdgesToRemove{};
  for (auto edge : incomingEdges) {
    if (edge->getOutgoingNode() == node) {
      incomingEdgesToRemove.insert(edge);
    }
  }
  for (auto edge : incomingEdgesToRemove) {
    incomingEdges.erase(edge);
  }
}

template <class T> void DG<T>::removeNode(DGNode<T> *node) {
  auto theT = node->getT();
  auto &map = isInternal(theT) ? internalNodeMap : externalNodeMap;
  map.erase(theT);
  allNodes.erase(node);

  /*
   * Collect edges to operate on before doing deletes
   */
  std::unordered_set<DGEdge<T> *> incomingToNode;
  std::unordered_set<DGEdge<T> *> outgoingFromNode;
  std::unordered_set<DGEdge<T> *> allToAndFromNode;
  for (auto edge : node->getIncomingEdges())
    incomingToNode.insert(edge);
  for (auto edge : node->getOutgoingEdges())
    outgoingFromNode.insert(edge);
  for (auto edge : node->getAllConnectedEdges())
    allToAndFromNode.insert(edge);

  /*
   * Delete relations to edges and edges themselves
   */
  for (auto edge : incomingToNode)
    edge->getOutgoingNode()->removeConnectedNode(node);
  for (auto edge : outgoingFromNode)
    edge->getIncomingNode()->removeConnectedNode(node);
  for (auto edge : allToAndFromNode) {
    allEdges.erase(edge);
    delete edge;
  }

  delete node;
}

} // namespace noelle
} // namespace llvm

#endif // LLVM_NOELLE_PDG_PDG_H