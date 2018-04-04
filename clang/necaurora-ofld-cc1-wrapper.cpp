#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

#include <errno.h>
#include <unistd.h>

#include "config.h"

static bool Verbose = false;

int runSourceTransformation(const std::string &InputPath,
                            std::string &OutputPath) {
  std::stringstream CmdLine;
  std::string TmpPath;

  const char *TmpEnv = std::getenv("TMP");

  if (TmpEnv) {
    TmpPath = TmpEnv;
  } else {
    TmpPath = "/tmp";
  }

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
  // because mkstemp wants the last n chars to be 'X', we have to add the
  // extension laster

  std::stringstream TmpFilePathTemplate;
  TmpFilePathTemplate << TmpPath << "/" << InputFileNameWE << "-XXXXXX"
                      << InputFileExt;

  std::string TmpFilePathTemplateStr = TmpFilePathTemplate.str();

  std::vector<char> TmpFilePath(TmpFilePathTemplateStr.begin(),
                                TmpFilePathTemplateStr.end());
  TmpFilePath.push_back('\0');

  // generate tmp name
  int fd = mkstemps(&TmpFilePath[0], InputFileExt.length());

  if (fd < 0) {
    std::cerr << "necaurora-ofld-cc1-wrapper: mkstemp(" << &TmpFilePath[0]
              << ") failed with message: \"" << strerror(errno) << "\""
              << std::endl;
    return -1;
  }
  close(fd); // we get a warning for mktemp so we use mkstemp

  // We have our Tempfile
  std::string TmpFile(TmpFilePath.data());

  CmdLine << "sotoc " << InputPath << " -- -fopenmp "
          << ">" << TmpFile;

  if (Verbose) {
    std::cout << "  \"" << CmdLine.str() << "\"\n";
  }

  OutputPath = TmpFile;
  return system(CmdLine.str().c_str());
}

int runTargetCompiler(const std::string &Compiler, const std::string &InputPath,
                      const std::string &Args) {

  std::stringstream CmdLine;

  CmdLine << Compiler << " " << InputPath << " " << Args;

  if (Verbose) {
    std::cout << "  \"" << CmdLine.str() << std::endl;
  }

  int ret = system(CmdLine.str().c_str());

  std::remove(InputPath.c_str());

  return ret;
}

int main(int argc, char **argv) {

  int rc;

  if (argc < 2) {
    std::cerr << "Needs at least one argument\n";
    return EXIT_FAILURE;
  }

  const char *CompilerEnv = std::getenv("NECAURORA_OFLD_COMPILER");

  std::string Compiler(CompilerEnv ? CompilerEnv : DEFAULT_TARGET_COMPILER);

  std::string InputPath(argv[1]);
  std::string SotocOutputPath;

  std::stringstream ArgsStream;

  for (int i = 2; i < argc; ++i) {
    if (std::strcmp(argv[i], "-v") == 0) {
      Verbose = true;
    }

    ArgsStream << " " << argv[i];
  }

  rc = runSourceTransformation(InputPath, SotocOutputPath);

  if (rc != 0) {
    std::cerr << "necaurora-ofld-cc1-wrapper: "
              << "source code transformation failed\n";
    return EXIT_FAILURE;
  }

  rc = runTargetCompiler(Compiler, SotocOutputPath, ArgsStream.str());

  if (rc != 0) {
    std::cerr << "necaurora-ofld-cc1-wrapper: "
              << "execution of target compiler failed\n";
    return EXIT_FAILURE;
  }
}
