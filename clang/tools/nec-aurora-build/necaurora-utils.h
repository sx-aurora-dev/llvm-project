#ifndef __NECAURORA_UTILS_H__
#define __NECAURORA_UTILS_H__

#include <string>

// TODO: Define / use debuging stuff?
static bool Verbose = false;

/// Writes a temp file with content "Content" and a given prefix "Prefix"
/// and an given extension "Extension".
///  Returns the path to the file. If the empty string is returned, no file was written.
std::string writeTmpFile(const std::string& Content, const std::string& Prefix,
                         const std::string& Extension);

/// Executes the target compiler.
int runTargetCompiler(const std::string &InputPath,
                      const std::string &Args);

#endif
