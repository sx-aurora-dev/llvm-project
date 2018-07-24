#include <memory>
#include <sstream>
#include <string>

#include "clang/Frontend/FrontendActions.h"
#include "clang/Tooling/CommonOptionsParser.h"
#include "clang/Tooling/Tooling.h"
// Declares llvm::cl::extrahelp.
#include "clang/AST/ASTConsumer.h"
#include "clang/AST/ASTContext.h"
#include "clang/AST/RecursiveASTVisitor.h"
#include "clang/Basic/SourceManager.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Rewrite/Core/Rewriter.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"

#include "TargetCode.h"
#include "TargetCodeFragment.h"
#include "TypeDeclResolver.h"
#include "Visitors.h"

using namespace clang::tooling;
using namespace llvm;

class TargetRegionTransformer : public clang::ASTConsumer {
  TargetCode &Code;
  clang::Rewriter &TargetCodeRewriter;
  TypeDeclResolver Types;

public:
  TargetRegionTransformer(TargetCode &Code, clang::Rewriter &TargetCodeRewriter)
      : Types(), Code(Code), TargetCodeRewriter(TargetCodeRewriter) {}

  void HandleTranslationUnit(clang::ASTContext &Context) final {
    // read target code information from AST into TargetCode
    FindTargetCodeVisitor FindCodeVisitor(Code, Types, Context);
    FindCodeVisitor.TraverseDecl(Context.getTranslationUnitDecl());

    // rewrite capture variables in all target regions into pointers
#if 0
    for (auto i = Code.getCodeFragmentsBegin(), e = Code.getCodeFragmentsEnd();
           i != e; ++i) {
      if (auto *TCR = llvm::dyn_cast<TargetCodeRegion>(i->get())) {
        RewriteTargetRegionsVisitor RegionRewriteVisitor(TargetCodeRewriter,
                                                         *TCR);
        RegionRewriteVisitor.TraverseStmt(TCR->getNode()->getCapturedStmt());
        // TODO: fix this ^
      }
    }
#endif
    Types.orderAndWriteCodeFragments(Code);
  }
};

class SourceTransformAction : public clang::ASTFrontendAction {
  clang::Rewriter TargetCodeRewriter;
  TargetCode *Code;

public:
  void EndSourceFileAction() override {
    // std::error_code error_code;
    // llvm::raw_fd_ostream outFile("output.txt", error_code,
    // llvm::sys::fs::F_Append);
    Code->generateCode(llvm::outs());
    // outFile.close();
    delete Code;
  }

  std::unique_ptr<clang::ASTConsumer>
  CreateASTConsumer(clang::CompilerInstance &CI, clang::StringRef) final {
    TargetCodeRewriter.setSourceMgr(CI.getSourceManager(), CI.getLangOpts());
    // TargetCode holds all necessary information about source locations of
    // target regions to extract that code
    Code = new TargetCode(TargetCodeRewriter);
    return std::unique_ptr<clang::ASTConsumer>(
        new TargetRegionTransformer(*Code, TargetCodeRewriter));
  }
};

static llvm::cl::OptionCategory SotocCategory("sotoc options");
static llvm::cl::extrahelp
    MoreHelp("\nExtracts code in OpenMP target regions from source file and "
             "generates target function code");

int main(int argc, const char **argv) {
  clang::tooling::CommonOptionsParser option(argc, argv, SotocCategory);
  clang::tooling::ClangTool tool(option.getCompilations(),
                                 option.getSourcePathList());

  return tool.run(
      clang::tooling::newFrontendActionFactory<SourceTransformAction>().get());
}
