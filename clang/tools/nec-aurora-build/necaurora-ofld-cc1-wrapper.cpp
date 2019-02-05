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
#include <getopt.h>

#include "config.h"
#include "necaurora-utils.h"

bool Verbose = false;

int runSourceTransformation(const std::string &InputPath,
                            const std::string &SotocPath,
                            std::string &OutputPath, const std::string &ArgsString) {
  std::stringstream CmdLine;

  // find last '/' in string so we can get just the filename
  size_t PosLastSlashInPath = InputPath.rfind("/");

  if (PosLastSlashInPath == InputPath.length()) {
    PosLastSlashInPath = 0;
  }

  // find last '.' in string so we can get the filename extension
  size_t PosLastDotInPath = InputPath.rfind(".");
  if (PosLastDotInPath == std::string::npos) {
    std::cerr
        << "necaurora-ofld-cc1-wrapper: Input file has no file extension (1)"
        << " (neeeds to be .c or .cpp)" << std::endl;
    return -1;
  }

  // Input file name without extension
  std::string InputFileNameWE(InputPath, PosLastSlashInPath + 1,
                              (PosLastDotInPath - (PosLastSlashInPath + 1)));

  std::string InputFileExt(InputPath, PosLastDotInPath);

  if (InputFileExt != ".c" && InputFileExt != ".cpp" && InputFileExt != ".i") {
    std::cerr << "necaurora-ofld-cc1-wrapper: Input file has no file extension"
              << std::endl;
    return -1;
  }

  // We create an empty temp file
  std::string Content = "";
  std::string TmpFile = writeTmpFile(Content, InputFileNameWE, InputFileExt);
  if (TmpFile == "")
    return -1;

  CmdLine << SotocPath << " " << InputPath << " -- "
          << ArgsString << " > " << TmpFile;

  if (Verbose) {
    std::cout << "  \"" << CmdLine.str() << "\"\n";
  }

  OutputPath = TmpFile;
  return system(CmdLine.str().c_str());
}

int main(int argc, char **argv) {

  int rc;
  int option;
  std::stringstream SotocPath;

  std::string InputPath(argv[1]);
  std::string SotocOutputPath;

  std::stringstream ArgsStream;

  const char* const short_opts = "v";

  const struct option long_opts[] = {
    {"sotoc-path", required_argument, nullptr, 'p'},
    {nullptr, no_argument, nullptr, 0}
  };

  if (argc < 2) {
    std::cerr << "Needs at least one argument\n";
    return EXIT_FAILURE;
  }

  for (int i = 2; i < argc; ++i) {
    std::string tmp = argv[i];
    if(tmp.find("sotoc-path") == std::string::npos)
      ArgsStream << " " << tmp;
  }

  option = 0;
  opterr = 0; // we just ignore unknown options
  optind = 0;
  while ((option = getopt_long(argc, argv, short_opts, long_opts, nullptr)) != -1) {
    switch (option) {
    case 'p':
        SotocPath << optarg;
      break;
    case 'v':
      Verbose = true;
      break;
    default:
      break;
    }
  }

  if(SotocPath.str().empty())
    SotocPath << "sotoc";

  rc = runSourceTransformation(InputPath, SotocPath.str(), SotocOutputPath, ArgsStream.str());

  if (rc != 0) {
    std::cerr << "necaurora-ofld-cc1-wrapper: "
              << "source code transformation failed\n";
    return EXIT_FAILURE;
  }

  rc = runTargetCompiler(SotocOutputPath, ArgsStream.str());
  std::remove(SotocOutputPath.c_str());

  if (rc != 0) {
    std::cerr << "necaurora-ofld-cc1-wrapper: "
              << "execution of target compiler failed\n";
    return EXIT_FAILURE;
  }
}
