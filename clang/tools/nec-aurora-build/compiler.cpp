#include <iostream>
#include <sstream>
#include <unistd.h>

#include "necaurora-ofld-wrapper.h"

int runSourceTransformation(const std::string &InputPath,
                            const std::string &SotocPath,
                            std::string &OutputPath,
                            const std::string &ArgsString) {
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
        << " (neeeds to be .c or .cpp or .i)" << std::endl;
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
  std::string TmpFile = writeTmpFile(Content, InputFileNameWE + ".sotoc-transformed", InputFileExt);
  if (TmpFile == "")
    return -1;

  CmdLine << SotocPath << " " << InputPath << " -- " << ArgsString << " > "
          << TmpFile;

  if (Verbose) {
    std::cout << "  \"" << CmdLine.str() << "\"\n";
  }

  OutputPath = TmpFile;
  return system(CmdLine.str().c_str());
}

int runTargetCompiler(const std::string &InputPath, const std::string &Args) {

  std::stringstream CmdLine;

  CmdLine << getTargetCompiler() << " -c " << InputPath << " " << Args;

  if (Verbose) {
    std::cout << "  \"" << CmdLine.str() << "\"" << std::endl;
  }

  int ret = system(CmdLine.str().c_str());

  if (!KeepTransformedFilesDir) {
    std::remove(InputPath.c_str());
  }

  return ret;
}
