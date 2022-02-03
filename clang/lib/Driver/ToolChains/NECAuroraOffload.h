#ifndef LLVM_CLANG_LIB_DRIVER_TOOLCHAINS_NECAURORAOFFLOAD_H
#define LLVM_CLANG_LIB_DRIVER_TOOLCHAINS_NECAURORAOFFLOAD_H

#include "Gnu.h"
#include "Linux.h"
#include "clang/Driver/Tool.h"
#include "clang/Driver/ToolChain.h"

namespace clang {
namespace driver {

namespace tools {
namespace necauroratools {

// we will use ncc (and for testing purposes gcc) for everything,
// so, like gcc, we can create a common base class
class LLVM_LIBRARY_VISIBILITY Common : public Tool {
  virtual void anchor();

public:
  Common(const char *Name, const char *ShortName, const ToolChain &TC)
      : Tool(Name, ShortName, TC), ToolName("necaurora-ofld-wrapper") {}

  bool hasIntegratedAssembler() const override { return true; }

  void ConstructJob(Compilation &C, const JobAction &JA,
                    const InputInfo &Output, const InputInfoList &Inputs,
                    const llvm::opt::ArgList &Args,
                    const char *LinkingOutput) const override;

  // Extra flags for the particular tool
  virtual void RenderExtraToolArgs(const JobAction &JA,
                                   llvm::opt::ArgStringList &CmdArgs) const = 0;

private:
  // the name of the tool actually used
  // at the end we use ncc (or gcc) for everything, but for the compile step we
  // need to transform the source code first. We use a wrapper which takes the
  // code, put it into the source transformation tool and then pipe it to the
  // real compiler.
  const char *ToolName;
};

class LLVM_LIBRARY_VISIBILITY Linker : public Common {
public:
  Linker(const ToolChain &TC)
      : Common("NECAurora::Linker", "Linker (via ncc)", TC) {}

  bool hasIntegratedCPP() const override { return false; }
  bool isLinkJob() const override { return true; }

  void RenderExtraToolArgs(const JobAction &JA,
                           llvm::opt::ArgStringList &CmdArgs) const override;
};

class LLVM_LIBRARY_VISIBILITY OffloadCompilerWrapper : public Common {
public:
  OffloadCompilerWrapper(const ToolChain &TC)
      : Common("NECAurora::OffloadCompiler", "Offload Compiler (via ncc)", TC) {
  }

  void RenderExtraToolArgs(const JobAction &JA,
                           llvm::opt::ArgStringList &CmdArgs) const override;

  bool hasIntegratedCPP() const override { return true; }

  bool hasIntegratedAssembler() const override { return true; }
};

class LLVM_LIBRARY_VISIBILITY Assembler : public Common {
public:
  Assembler(const ToolChain &TC)
      : Common("NECAurora::Assembler", "Assembler (via ncc)", TC) {}

  bool hasIntegratedCPP() const override { return false; } //?

  void RenderExtraToolArgs(const JobAction &JA,
                           llvm::opt::ArgStringList &CmdArgs) const override;
};

} // namespace necauroratools
} // namespace tools

namespace toolchains {

class LLVM_LIBRARY_VISIBILITY NECAuroraOffloadToolChain : public Generic_ELF {
  virtual void anchor();

public:
  NECAuroraOffloadToolChain(const Driver &D, const llvm::Triple &Triple,
                            const ToolChain &HostTC,
                            const llvm::opt::ArgList &Args)
      : Generic_ELF(D, Triple, Args), HostTC(HostTC) {}

  const llvm::Triple *getAuxTriple() const override {
    return &HostTC.getTriple();
  }

  Tool *SelectTool(const JobAction &JA) const override;

  bool useIntegratedAs() const override { return true; }
  bool isCrossCompiling() const override { return true; }
  bool isPICDefault() const override { return false; }
  bool isPICDefaultForced() const override { return false; }
  bool SupportsProfiling() const override { return false; }
  bool IsMathErrnoDefault() const override { return false; }

  const ToolChain &HostTC;

private:
  mutable std::unique_ptr<Tool> Compiler;
  mutable std::unique_ptr<Tool> Assembler;

protected:
  Tool *buildLinker() const override;
  Tool *buildAssembler() const override;
};

} // namespace toolchains
} // namespace driver
} // namespace clang

#endif // LLVM_CLANG_LIB_DRIVER_TOOLCHAINS_NECAURORAOFFLOAD_H
