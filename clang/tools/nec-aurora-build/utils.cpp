#include <cstdlib>
#include <fcntl.h>
#include <iostream>
#include <sstream>
#include <unistd.h>
#include <vector>
#include <string.h>

#include "necaurora-ofld-wrapper.h"

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

const char *getTargetCompiler() {
  const char *TargetCompiler = std::getenv("NECAURORA_OFLD_TARGET_COMPILER");
  if (!TargetCompiler) {
    TargetCompiler = DEFAULT_TARGET_COMPILER;
  }

  return TargetCompiler;
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
