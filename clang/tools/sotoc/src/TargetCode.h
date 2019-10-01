//===-- sotoc/src/TargetCode.h --------------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#pragma once

#include <deque>
#include <memory>
#include <set>
#include <string>

#include "clang/Rewrite/Core/Rewriter.h"

#include "TargetCodeFragment.h"

namespace clang {
class SourceManager;
}

using TargetCodeFragmentDeque = std::deque<std::shared_ptr<TargetCodeFragment>>;

/// A collection of all code from the input file that needs to be copied to the
/// target source file.
class TargetCode {

  /// Collection of all code locations that need to be copied.
  TargetCodeFragmentDeque CodeFragments;
  /// Header files which will also be present on the target. Instead of copying
  /// the code declarations in them, we can simply add \#include directives for
  /// these headers to the target code.
  std::set<std::string> SystemHeaders;
  clang::Rewriter &TargetCodeRewriter;
  clang::SourceManager &SM;

public:
  TargetCode(clang::Rewriter &TargetCodeRewriter)
      : TargetCodeRewriter(TargetCodeRewriter),
        SM(TargetCodeRewriter.getSourceMgr()){};

  /// Add a piece of code from the input file to this collection.
  /// This function uses the fragments source location to check wether it was
  /// already added and where in the list of code fragments to add it.
  bool addCodeFragment(std::shared_ptr<TargetCodeFragment> Frag,
                       bool PushFront = false);
  /// See \ref addCodeFragment
  bool addCodeFragmentFront(std::shared_ptr<TargetCodeFragment> Fag);
  /// Generate target code from all fragments and system headers added to this
  /// collection
  void generateCode(llvm::raw_ostream &Out);
  /// Get an iterate over all code fragments in this collection
  TargetCodeFragmentDeque::const_iterator getCodeFragmentsBegin() {
    return CodeFragments.begin();
  }
  /// See \ref getCodeFragmentsBegin
  TargetCodeFragmentDeque::const_iterator getCodeFragmentsEnd() {
    return CodeFragments.end();
  }
  /// Add a header file to be included by the target code
  void addHeader(const std::string &Header) { SystemHeaders.insert(Header); }

private:
  /// Generates a function prologue for a target region.
  /// This prologue consists of a function declaration and code to copy local
  /// variables into scope.
  void generateFunctionPrologue(TargetCodeRegion *TCR, llvm::raw_ostream &Out);
  /// Generates a function epilogue for a target region.
  /// This prologue consists of a code to copy variables from the local scope
  /// back.
  void generateFunctionEpilogue(TargetCodeRegion *TCR, llvm::raw_ostream &Out);
  /// Generate a function name for a target region.
  std::string generateFunctionName(TargetCodeRegion *TCR);
};
