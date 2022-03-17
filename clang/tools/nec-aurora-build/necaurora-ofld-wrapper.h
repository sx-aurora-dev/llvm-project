#ifndef NECAURORA_OFLD_WRAPPER_H
#define NECAURORA_OFLD_WRAPPER_H

#include <string>
#include <vector>

#include "config.h"

extern bool Verbose;

extern const char *KeepTransformedFilesDir;

int runSourceTransformation(const std::string &InputPath,
                            const std::string &SotocPath,
                            std::string &OutputPath,
                            const std::string &ArgsString);

int runTargetCompiler(const std::string &InputPath, const std::string &Args);

int runStaticLinker(const std::vector<const char *> &ObjectFiles,
                    const std::string &Args,
                    const std::string &OutputFile);

int runPassthrough(const std::string &Args);

const char *getTmpDir();

int configureTargetCompiler(const std::string&);
const char *getTargetCompiler();

std::string writeTmpFile(const std::string &Content, const std::string &Prefix,
                         const std::string &Extension, bool RealTmpfile=true);

#endif /*NECAURORA_OFLD_WRAPPER_H*/
