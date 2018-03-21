#include "NECAuroraOffload.h"
#include "CommonArgs.h"
#include "clang/Driver/Compilation.h"
#include "clang/Driver/Driver.h"
#include "clang/Driver/DriverDiagnostic.h"
#include "clang/Driver/Options.h"
#include "llvm/Option/ArgList.h"

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

  for (const auto &A : Args) {
    if (A->getOption().getKind() != Option::InputClass &&
        !A->getOption().hasFlag(options::DriverOption) &&
        !A->getOption().hasFlag(options::LinkerInput)) {

      // MR_MARKER: because we are the offloading compiler, we dont have to claim(?)
      //A->claim();

      // Don't forward any -g arguments to assembly steps.
      if (isa<AssembleJobAction>(JA) &&
          A->getOption().matches(options::OPT_g_Group))
        continue;

      // Don't forward any -W arguments to assembly and link steps.
      if ((isa<AssembleJobAction>(JA) || isa<LinkJobAction>(JA)) &&
          A->getOption().matches(options::OPT_W_Group))
        continue;

      A->render(Args, CmdArgs);
    }
  }

  RenderExtraToolArgs(JA, CmdArgs);

  if (Output.isFilename()) {
    CmdArgs.push_back("-o");
    CmdArgs.push_back(Output.getFilename());
  } else {
    assert(Output.isNothing() && "Unexpected output");
    CmdArgs.push_back("-fsyntax-only");
  }

  const char *Exec = Args.MakeArgString(getToolChain().GetProgramPath(ToolName));
  C.addCommand(llvm::make_unique<Command>(JA, *this, Exec, CmdArgs, Inputs));
}

void necauroratools::Common::anchor() {}

void necauroratools::Linker::RenderExtraToolArgs(const JobAction &JA,
                                                 llvm::opt::ArgStringList &CmdArgs) const {
  // no extra args, just hope for the best
  //
  // except the runtime
  CmdArgs.push_back("-ldevmemwrap");
  // this is rather ugly
  CmdArgs.push_back("-Wl,-u,__devmemwrap_mm_malloc");
  CmdArgs.push_back("-Wl,-u,__devmemwrap_mm_free");
}

void necauroratools::OffloadCompilerWrapper::RenderExtraToolArgs(const JobAction &JA,
                                                   llvm::opt::ArgStringList &CmdArgs) const {
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

void necauroratools::Assembler::RenderExtraToolArgs(const JobAction &JA,
                                                    llvm::opt::ArgStringList &CmdArgs) const {
  CmdArgs.push_back("-S");
}


Tool *toolchains::NECAuroraOffloadToolChain::SelectTool(const JobAction &JA) const {
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
