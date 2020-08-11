#include <cstdlib>
#include <fcntl.h>
#include <iostream>
#include <sstream>
#include <unistd.h>
#include <vector>
#include <string.h>

#include "necaurora-ofld-wrapper.h"

const std::string ClangCompilerCmd = TARGET_COMPILER_CLANG " --target=ve-linux";
const std::string RVClangCompilerCmd = TARGET_COMPILER_RVCLANG " --target=ve-linux";
const std::string NCCCompilerCmd = TARGET_COMPILER_NCC;

std::string CompilerCmd;

int configureTargetCompiler(const std::string& CompilerName) {
  if (CompilerName.find("path:") == 0) {
    CompilerCmd = CompilerName.substr(5);
    //Small sanity check whether there is actually a path
    if (CompilerCmd.length() > 0) {
      return 0;
    }
    std::cerr << "nec-aurora-build: -fopenmp-nec-compiler=path: empty"
              << std::endl;

  }
  if (CompilerName == "clang")   { CompilerCmd = ClangCompilerCmd; return 0; }
  if (CompilerName == "rvclang") { CompilerCmd = RVClangCompilerCmd; return 0; }
  if (CompilerName == "ncc")     { CompilerCmd = NCCCompilerCmd; return 0; }
  std::cerr << "nec-aurora-build: -fopenmp-nec-compiler=" << CompilerCmd
            << " not recognized"
            << std::endl;
  return 1;
}


const char *getTargetCompiler() {
  // If no option was specified on the command line chose the builtin default
  if (CompilerCmd.empty()) {
#ifndef DEFAULT_TARGET_COMPILER_OPTION
#error "DEFAULT_TARGET_COMPILER_OPTION not specified during build!" 
#endif
    configureTargetCompiler(DEFAULT_TARGET_COMPILER_OPTION);
  }
  return CompilerCmd.c_str();
}

const char *getTmpDir() {
  const char *TmpDir = std::getenv("TMPDIR");

  if (!TmpDir) {
    TmpDir = std::getenv("TEMP");
  }

  if (!TmpDir) {
    TmpDir = std::getenv("TMP");
  }

  if (!TmpDir) {
    TmpDir = "/tmp";
  }

  return TmpDir;
}

std::string writeTmpFile(const std::string &Content, const std::string &Prefix,
                         const std::string &Extension, bool RealTmpfile) {
  std::string TmpPath;
  if (KeepTransformedFilesDir) {
    TmpPath = KeepTransformedFilesDir;
  } else  {
    TmpPath = getTmpDir();
  }

  // because mkstemp wants the last n chars to be 'X', we have to add the
  // extension laster
  std::stringstream TmpFilePathTemplate;
  TmpFilePathTemplate << TmpPath << "/" << Prefix;
  if (RealTmpfile) {
    TmpFilePathTemplate << "-XXXXXX";
  }
  TmpFilePathTemplate  << Extension;

  std::string TmpFilePathTemplateStr = TmpFilePathTemplate.str();

  std::vector<char> TmpFilePath(TmpFilePathTemplateStr.begin(),
                                TmpFilePathTemplateStr.end());
  TmpFilePath.push_back('\0');

  int fd;
  if (RealTmpfile) {
    // generate tmp name
    fd = mkstemps(&TmpFilePath[0], Extension.length());
  } else {
    fd = open(&TmpFilePath[0], O_RDWR);
  }

  if (fd < 0) {
    std::cerr << "necaurora-ofld-cc1-wrapper: mkstemp(" << &TmpFilePath[0]
              << ") failed with message: \"" << strerror(errno) << "\""
              << std::endl;
    return "";
  }
  write(fd, Content.c_str(), Content.length());
  close(fd); // we get a warning for mktemp so we use mkstemp

  return TmpFilePath.data();
}
