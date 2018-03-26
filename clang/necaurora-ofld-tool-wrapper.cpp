#include <cstdlib>
#include <iostream>
#include <sstream>
#include <string>

int main(int argc, char **argv) {

  if (argc < 2) {
    std::cerr << "Needs at least one argument" << std::endl;
  }

  char *tool_path = std::getenv("NECAURORA_OFLD_COMPILER");

  std::stringstream cmdLine;

  if (tool_path) {
    cmdLine << tool_path;
  } else {
    cmdLine << "ncc";
  }

  for (int i = 1; i < argc; ++i) {
    cmdLine << " " << argv[i];
  }

  return std::system(cmdLine.str().c_str());
}

