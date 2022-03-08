#include "NECAuroraOffload.h"
#include "CommonArgs.h"
#include "clang/Driver/Compilation.h"
#include "clang/Driver/Driver.h"
#include "clang/Driver/DriverDiagnostic.h"
#include "clang/Driver/Options.h"
#include "llvm/Option/ArgList.h"
#include <vector>

using namespace clang;
using namespace clang::driver;
using namespace clang::driver::tools;
using namespace llvm::opt;

void necauroratools::Common::ConstructJob(Compilation &C, const JobAction &JA,
                                          const InputInfo &Output,
                                          const InputInfoList &Inputs,
                                          const llvm::opt::ArgList &Args,
                                          const char *LinkingOutput) const {
  ArgStringList CmdArgs;
  std::vector<llvm::opt::Arg *> PPargs;
  std::vector<llvm::opt::Arg *> XOTargs;

  // We need to pass the input source, one file at a time, as first argument to
  // the compiler wrapper.
  // We just hope that the we get only one source file from clang and that it's
  // the first input
  for (const auto &II : Inputs) {
    // Don't try to pass LLVM or AST inputs to a generic compiler.
    // We get this info anyway because we are an offload compiler, so
    // we just ignore it
    if (types::isLLVMIR(II.getType()))
      continue;
    else if (II.getType() == types::TY_AST)
      continue;
    else if (II.getType() == types::TY_ModuleFile)
      continue;

    if (II.isFilename())
      CmdArgs.push_back(II.getFilename());
    else {
      const Arg &A = II.getInputArg();

      // Don't render as input, we need ncc/gcc to do the translations.
      A.render(Args, CmdArgs);
    }
  }

  // Uses the default specified in the sotoc offload wrapper (tools/)
  const char* compilerName = NULL;

  for (const auto &A : Args) {
    if (A->getOption().getKind() != Option::InputClass &&
        !A->getOption().hasFlag(options::NoXarchOption) &&
        !A->getOption().hasFlag(options::LinkerInput)) {

      // Don't forward any -g arguments to assembly steps.
      if (isa<AssembleJobAction>(JA) &&
          A->getOption().matches(options::OPT_g_Group))
        continue;

      // Don't forward any -W arguments to assembly and link steps.
      if ((isa<AssembleJobAction>(JA) || isa<LinkJobAction>(JA)) &&
          A->getOption().matches(options::OPT_W_Group))
        continue;

      // Don't forward -fopenmp-targets
      if (A->getOption().matches(options::OPT_fopenmp_targets_EQ)) {
        continue;
      }

      // Handle Preprocessor Args seperatly
      if (A->getOption().matches(options::OPT_Preprocessor_Group)) {
        PPargs.push_back(A);
        continue;
      }
      
      if (A->getOption().matches(options::OPT_fopenmp_nec_compiler_EQ)) {
        const char *RawTxt = A->getNumValues() != 1 ? nullptr : A->getValue(0);
        if (RawTxt) {
          compilerName = RawTxt;
        }
        continue;
      }

      // Mark and claim Xopenmp-target
      if (A->getOption().getName() == "Xopenmp-target") {
        XOTargs.push_back(A);
        A->claim();
        continue;
      }

      A->render(Args, CmdArgs);
    }
  }

  for (auto &A : XOTargs) {
    std::string mark = "XOT";
    for (uint i = 0; i < A->getNumValues(); ++i) {
      std::string arg = mark;
      for (const char* c = A->getValue(i); *c; c++) {
        if (strncmp(c, " ", 1) != 0) {
          arg.push_back(*c);
        } else {
          CmdArgs.push_back(Args.MakeArgString(arg));
          arg = mark;
        }
      }
      CmdArgs.push_back(Args.MakeArgString(arg));
     }
  }

  for (auto &A : PPargs) {
    for (uint i = 0; i < A->getNumValues(); ++i) {
      CmdArgs.push_back(Args.MakeArgString(
          ("-" + std::string(A->getOption().getName()) + A->getValue(i))
              .c_str()));
    }
  }


  RenderExtraToolArgs(JA, CmdArgs);

  // Keep this in sync with the compiler option in necaurora-ofld-wrapper.cpp (FIXME)
  if (compilerName) {
    CmdArgs.push_back("--nec-target-compiler"); 
    CmdArgs.push_back(compilerName);
  }

  if (Output.isFilename()) {
    CmdArgs.push_back("-o");
    CmdArgs.push_back(Output.getFilename());
  } else {
    assert(Output.isNothing() && "Unexpected output");
    CmdArgs.push_back("-fsyntax-only");
  }

  const char *Exec =
      Args.MakeArgString(getToolChain().GetProgramPath(ToolName));
  C.addCommand(std::make_unique<Command>(JA, *this,
                                         ResponseFileSupport::AtFileCurCP(),
                                         Exec, CmdArgs, Inputs));
}

void necauroratools::Common::anchor() {}

void necauroratools::Linker::RenderExtraToolArgs(
    const JobAction &JA, llvm::opt::ArgStringList &CmdArgs) const {
  // no extra args, just hope for the best
}

void necauroratools::OffloadCompilerWrapper::RenderExtraToolArgs(
    const JobAction &JA, llvm::opt::ArgStringList &CmdArgs) const {
  // the same as for Gnu
  const Driver &D = getToolChain().getDriver();

  switch (JA.getType()) {
  // If -flto, etc. are present then make sure not to force assembly output.
  case types::TY_LLVM_IR:
  case types::TY_LTO_IR:
  case types::TY_LLVM_BC:
  case types::TY_LTO_BC:
    CmdArgs.push_back("-c");
    break;
  case types::TY_Object:
    CmdArgs.push_back("-c");
    break;
  case types::TY_PP_C:
    CmdArgs.push_back("-E");
    break;
  case types::TY_PP_Asm:
    CmdArgs.push_back("-S");
    break;
  case types::TY_Nothing:
    CmdArgs.push_back("-fsyntax-only");
    break;
  default:
    D.Diag(diag::err_drv_invalid_gcc_output_type) << getTypeName(JA.getType());
  }
}

void necauroratools::Assembler::RenderExtraToolArgs(
    const JobAction &JA, llvm::opt::ArgStringList &CmdArgs) const {
  CmdArgs.push_back("-S");
}

Tool *
toolchains::NECAuroraOffloadToolChain::SelectTool(const JobAction &JA) const {
  switch (JA.getKind()) {
  case Action::PreprocessJobClass:
  case Action::CompileJobClass:
    if (!Compiler)
      Compiler.reset(new necauroratools::OffloadCompilerWrapper(*this));
    return Compiler.get();
  default:
    return getTool(JA.getKind());
  }
}

Tool *toolchains::NECAuroraOffloadToolChain::buildLinker() const {
  return new necauroratools::Linker(*this);
}

Tool *toolchains::NECAuroraOffloadToolChain::buildAssembler() const {
  return new necauroratools::Assembler(*this);
}

void toolchains::NECAuroraOffloadToolChain::anchor() {}
