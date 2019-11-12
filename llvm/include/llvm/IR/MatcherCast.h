#ifndef LLVM_IR_MATCHERCAST_H
#define LLVM_IR_MATCHERCAST_H

//===- MatcherCast.h - Match on the LLVM IR --------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Parameterized class hierachy for templatized pattern matching.
//
//===----------------------------------------------------------------------===//


namespace llvm {
namespace PatternMatch {


// type modification
template<typename Matcher, typename DestClass>
struct MatcherCast { };

// whether the Value \p Obj behaves like a \p Class.
template<typename MatcherClass, typename Class>
bool match_isa(const Value* Obj) {
  using UnconstClass = typename std::remove_cv<Class>::type;
  using DestClass = typename MatcherCast<MatcherClass, UnconstClass>::ActualCastType;
  return isa<const DestClass>(Obj);
}

template<typename MatcherClass, typename Class>
auto match_cast(const Value* Obj) {
  using UnconstClass = typename std::remove_cv<Class>::type;
  using DestClass = typename MatcherCast<MatcherClass, UnconstClass>::ActualCastType;
  return cast<const DestClass>(Obj);
}
template<typename MatcherClass, typename Class>
auto match_dyn_cast(const Value* Obj) {
  using UnconstClass = typename std::remove_cv<Class>::type;
  using DestClass = typename MatcherCast<MatcherClass, UnconstClass>::ActualCastType;
  return dyn_cast<const DestClass>(Obj);
}

template<typename MatcherClass, typename Class>
auto match_cast(Value* Obj) {
  using UnconstClass = typename std::remove_cv<Class>::type;
  using DestClass = typename MatcherCast<MatcherClass, UnconstClass>::ActualCastType;
  return cast<DestClass>(Obj);
}
template<typename MatcherClass, typename Class>
auto match_dyn_cast(Value* Obj) {
  using UnconstClass = typename std::remove_cv<Class>::type;
  using DestClass = typename MatcherCast<MatcherClass, UnconstClass>::ActualCastType;
  return dyn_cast<DestClass>(Obj);
}


} // namespace PatternMatch

} // namespace llvm

#endif // LLVM_IR_MATCHERCAST_H

