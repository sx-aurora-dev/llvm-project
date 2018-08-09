//===-- nec-aurora-build/necaurora-utils.cpp--------- ---------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements helper functions for the necaurora wrapper tools.
///
//===----------------------------------------------------------------------===//

#include <sstream>
#include <iostream>
#include <vector>
#include <errno.h>
#include <string.h>
#include <unistd.h>

#include "config.h"
#include "necaurora-utils.h"

std::string writeTmpFile(const std::string& Content, const std::string& Prefix, 
                         const std::string& Extension){
  std::string TmpPath;
  const char *TmpEnv = std::getenv("TMP");
  
  if (TmpEnv) {
    TmpPath = TmpEnv;
  } else {
    TmpPath = "/tmp";
  }

  // because mkstemp wants the last n chars to be 'X', we have to add the
  // extension laster
  std::stringstream TmpFilePathTemplate;
  TmpFilePathTemplate << TmpPath << "/" << Prefix << "-XXXXXX"
                      << Extension;

  std::string TmpFilePathTemplateStr = TmpFilePathTemplate.str();

  std::vector<char> TmpFilePath(TmpFilePathTemplateStr.begin(),
                                TmpFilePathTemplateStr.end());
  TmpFilePath.push_back('\0');

  // generate tmp name
  int fd = mkstemps(&TmpFilePath[0], Extension.length());

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

int runTargetCompiler(const std::string &InputPath,
                      const std::string &Args) {

  std::stringstream CmdLine;
  const char *CompilerEnv = std::getenv("NECAURORA_OFLD_COMPILER");

  std::string Compiler(CompilerEnv ? CompilerEnv : DEFAULT_TARGET_COMPILER);

  CmdLine << Compiler << " " << InputPath << " " << Args;

  if (Verbose) {
    std::cout << "  \"" << CmdLine.str() << std::endl;
  }

  int ret = system(CmdLine.str().c_str());


  return ret;
}


