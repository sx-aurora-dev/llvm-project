//===-- nec-aurora-build/necaurora-ofld-cc1-wrapper.cpp -------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
///
/// \file
/// This file implements a build wrapper for offloading to NEC Aurora TSUABASA.
/// It calls the sotoc to outline the OpenMP target regions and calls the
/// offloading compiler (e.g., ncc).
///
//===----------------------------------------------------------------------===//

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

#include <errno.h>
#include <unistd.h>

#include "necaurora-ofld-wrapper.h"

bool Verbose = false;
const char *KeepTransformedFilesDir;
bool SaveTemps = false;


enum class ToolMode {
  Unknown,
  Compiler,
  StaticLinker,
  Preprocessor,
  Passthrough,
};

int parseCmdline(int argc, char **argv, ToolMode &Mode, std::string &SotocPath,
                 std::string &InputFile, std::string &Args, bool &Verbose,
                 bool &SaveTemps, std::vector<const char *> &ObjectFiles,
                 std::string &OutputFile) {
  std::stringstream ArgsStream;
  Mode = ToolMode::Unknown;
  bool StaticLinkerFlag = false;
  bool SharedFlag = false;
  bool SaveTempsFlag = false;
  SotocPath = "sotoc";
  // TODO make this more flexible
  InputFile = argv[1];

  for (int i = 2; i < argc; ++i) {
    if (strcmp(argv[i], "-c") == 0) {
      if (Mode != ToolMode::Unknown) {
        std::cerr << "necaurora-ofld-cc1-wrapper: WARNING: more than one "
                  << "option \"-c\" or \"-v\" set\n";
      }
      Mode = ToolMode::Compiler;
      continue;
    } else if (strcmp(argv[i], "-E") == 0) {
      if (Mode != ToolMode::Unknown) {
        std::cerr << "necaurora-ofld-cc1-wrapper: WARNING: more than one "
                  << "option \"-c\" or \"-v\" set\n";
      }
      Mode = ToolMode::Preprocessor;
      continue;
    } else if (strcmp(argv[i], "-p") == 0) {
      ++i;
      SotocPath = argv[i];
      continue;
    } else if (strcmp(argv[i], "-v") == 0) {
      Verbose = true;
      continue;
    } else if (strncmp(argv[i], "--sotoc-path=", strlen("--sotoc-path=")) ==
               0) {
      SotocPath = argv[i] + strlen("--sotoc-path=");
      continue;
    } else if (strcmp(argv[i], "-Xlinker -fopenmp-static") == 0) {
      StaticLinkerFlag = true;
      continue;
    } else if (strcmp(argv[i], "-shared") == 0) {
      SharedFlag = true;
      continue;
    } else if (strcmp(argv[i], "-save-temps") == 0) {
      SaveTempsFlag = true;
      continue;
    } else if (strcmp(argv[i] + strlen(argv[i] - 2), ".o") == 0) {
      ArgsStream << argv[i] << " ";
      ObjectFiles.push_back(argv[i]);
      continue;
    } else if (strcmp(argv[i], "-o") == 0) {
      ArgsStream << argv[i] << " ";
      OutputFile = std::string(argv[i+1]);
      continue;
    } else {
      ArgsStream << argv[i] << " ";
    }
  }

  if (SaveTempsFlag && !KeepTransformedFilesDir) {
    KeepTransformedFilesDir = get_current_dir_name();
  }

  if (Mode == ToolMode::Unknown) {

    if (StaticLinkerFlag) {
      Mode = ToolMode::StaticLinker;
    } else {
      Mode = ToolMode::Passthrough;
      if (SharedFlag) {
        ArgsStream << "-shared";
      }
    }
  }

  if (Mode == ToolMode::Passthrough || Mode == ToolMode::StaticLinker) {
    Args = InputFile + " " + ArgsStream.str();
  } else {
    Args = ArgsStream.str();
  }

  return 0;
}

int runPassthrough(const std::string &Args) {
  std::stringstream CmdLine;
  CmdLine << getTargetCompiler() << " " << Args;
  if (Verbose) {
    std::cerr << "  \"" << CmdLine.str() << "\"\n";
  }
  return std::system(CmdLine.str().c_str());
}

int main(int argc, char **argv) {

  int rc;

  ToolMode Mode;
  std::string SotocPath;
  std::string InputFile;
  std::string SotocOutputPath;
  std::string Args;
  std::vector<const char *> ObjectFiles;
  std::string OutputFile;

  KeepTransformedFilesDir = std::getenv("NECAURORA_KEEP_FILES_DIR");

  rc = parseCmdline(argc, argv, Mode, SotocPath, InputFile, Args, Verbose,
                    SaveTemps, ObjectFiles, OutputFile);
  if (rc != 0) {
    std::cerr << "necaurora-ofld-cc1-wraper: failed parsing the command "
              << "line\n";
  }
  if (Mode == ToolMode::Preprocessor) {
    std::cerr << "necaurora-ofld-wrapper: preprocessor pass not supported\n";
    return EXIT_FAILURE;
    // rc = runPreprocessor(InputFile, Args);
  } else if (Mode == ToolMode::Compiler) {
    rc = runSourceTransformation(InputFile, SotocPath, SotocOutputPath, Args);
    if (rc != 0) {
      std::cerr << "necaurora-ofld-cc1-wrapper: "
                << "source code transformation failed\n";
      return EXIT_FAILURE;
    }

    rc = runTargetCompiler(SotocOutputPath, Args);

    if (rc != 0) {
      std::cerr << "necaurora-ofld-wrapper: "
                << "execution of target compiler failed with code " << rc
                << "\n";
      return EXIT_FAILURE;
    }
  } else if (Mode == ToolMode::StaticLinker) {
    rc = runStaticLinker(ObjectFiles, Args, OutputFile);
    if (rc != 0) {
      std::cerr << "necaurora-ofld-wrapper: static linking failed "
                << "with code " << rc << "\n";
      return EXIT_FAILURE;
    }
  } else if (Mode == ToolMode::Passthrough) {
    rc = runPassthrough(Args);
    if (rc != 0) {
      std::cerr << "necaurora-ofld-wrapper: execution of target compiler "
                << "failed with code " << rc << "\n";
      return EXIT_FAILURE;
    }
  } else {
    std::cerr << "necaurora-ofld-wrapper: "
              << "could not find out what to do\n";
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}
