#include <string>
#include <sstream>
#include <iostream>
#include <cstdlib>

int main(int argc, char **argv) {

  if (argc < 2)
  {
    std::cerr << "Needs at least one argument\n";
    return EXIT_FAILURE;
  }

  char *compiler_path = std::getenv("NECAURORA_OFLD_COMPILER");

  std::string inputName(argv[1]);
  std::stringstream additionalArgsStream;


  for (int i = 2; i < argc; ++i) {
    additionalArgsStream << " " << argv[i];
  }
  
  std::stringstream cmdLine;
  cmdLine << "sotoc " << inputName
          << " -- -fopenmp "
          << " | ";
          
  if (compiler_path) {
    cmdLine << compiler_path;
  } else {
    cmdLine << "ncc";
  }

  cmdLine << " -x c " << additionalArgsStream.str()
          << " -";
  return system(cmdLine.str().c_str());
}
