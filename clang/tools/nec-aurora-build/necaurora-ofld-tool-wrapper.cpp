//===-- nec-aurora-build/necaurora-ofld-tool-wrapper.cpp ------------------===//
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
/// It calls the linker of the used tool chain. In case of static linking the 
/// outlined target code it generates a function for initialization of the
/// symbol table which is called by VEO.
///
//===----------------------------------------------------------------------===//


#include <err.h>
#include <cstdlib>
#include <iostream>
#include <sstream>
#include <cstring>
#include <string>
#include <vector>
#include <getopt.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <libelf.h>
#include <gelf.h>

#include "config.h"
#include "necaurora-utils.h"

// As long as we dont have a fat binary for static bins, we use this
// as naming convention.
#define VEORUN_BIN "veorun"

/// This function returns the symbols in the given ELF object "elfObject"
/// and returns the symbol names in "symbols".
void getSymsFromELFObj(char* elfObject, std::vector<std::string>* symbols) {
  int fd;
  Elf *e;
  Elf_Scn *scn = NULL;
  size_t shstrndx;
  char *name;
  GElf_Shdr shdr;
  Elf_Data *data;

  if ((fd = open(elfObject, O_RDONLY, 0)) < 0) {
    err(EXIT_FAILURE , "Open %s failed", elfObject);
  }

  if ((e = elf_begin(fd, ELF_C_READ, NULL)) == NULL)
    errx(EXIT_FAILURE, "elf_begin() failed: %s.", elf_errmsg(-1));

  if (elf_kind (e) != ELF_K_ELF)
    errx(EXIT_FAILURE , "%s is  not an  ELF  object .", elfObject);

  // Retrive section index of the ELF section containing the string table
  // of section names.
  if (elf_getshdrstrndx(e, &shstrndx) != 0)
    errx ( EXIT_FAILURE , "elf_getshdrstrndx ()  failed : %s.", elf_errmsg ( -1));

  // Iterate all sections
  while ((scn = elf_nextscn(e, scn)) != NULL ) {
    if (gelf_getshdr(scn, &shdr) != &shdr)
      errx (EXIT_FAILURE, "getshdr() failed : %s.", elf_errmsg ( -1));

    if ((name = elf_strptr(e, shstrndx , shdr.sh_name)) == NULL)
      errx (EXIT_FAILURE, "elf_strptr() failed: %s.", elf_errmsg ( -1));

    // We only care about symbols in ".symtab"
    if (shdr.sh_type == SHT_SYMTAB) {
      data = elf_getdata(scn, NULL);
      int symCount =  shdr.sh_size / shdr.sh_entsize;
      for (int i = 0; i < symCount; i++) {
        GElf_Sym sym;
        gelf_getsym(data, i, &sym);

        // We need all global function entris in the link table
        if (GELF_ST_BIND(sym.st_info) == STB_GLOBAL &&
            GELF_ST_TYPE(sym.st_info) == STT_FUNC) {
          char* symName;

          // if the sh_type equals SHT_SYMTAB, then sh_link holds the information for the section
          // header index of the associated string table.
          if ((symName = elf_strptr(e, shdr.sh_link, sym.st_name)) == NULL)
            errx (EXIT_FAILURE, "elf_strptr() failed: %s.", elf_errmsg ( -1));
          symbols->push_back(symName);
        }
      }
    }
  }

  elf_end(e);
  close(fd);
}

// Generates the code which initializes the symbol table for static linking
// and returns the path to the written C file.
std::string generateSymTabCode(const std::vector<std::string>* symbols) {
  std::stringstream out;
  out << "#include <stdlib.h>\n";
  out << "#include <string.h>\n";
  out << "typedef unsigned long ulong;\n\n";

  for(auto s : (*symbols)){
    out << "extern ulong " << s << ";" << std::endl;
  }

  out << std::endl;
  out << "typedef struct { char *n; ulong v; } SYM;\n";
  out << "SYM *_veo_static_symtable = NULL;\n";
  out << std::endl;
  out << "void _init_static_symtable(void) {\n";
  out << "  int i = 0;\n";
  out << "  _veo_static_symtable = (SYM *)malloc(("
      << symbols->size() << "+1) * sizeof(SYM));\n";
  out << "  SYM *s = _veo_static_symtable;\n";
  out << std::endl;

  for(auto s : (*symbols)){
    out << "  s[i].n = strdup(\"" << s << "\");";
    out << " s[i++].v = (ulong)&" << s << ";" << std::endl;
  }
  out << "  s[i].n = NULL; s[i++].v = 0UL;\n";
  out << "}\n";

  return writeTmpFile(out.str(), "veorun", ".c");
}

int main(int argc, char **argv) {

  int option;
  int ret;
  std::vector<std::string> objects;
  std::stringstream cmdLine;
  std::stringstream cmdCp;
  std::string output = "";
  std::string tool;
  bool statictgt = false;
  std::string SymTabPath;
  std::vector<std::string> symNames;

  if (argc < 2) {
    std::cerr << "Needs at least one argument" << std::endl;
  }

  char *tool_path = std::getenv("NECAURORA_OFLD_COMPILIER");

  if (tool_path) {
    tool = tool_path;
  } else {
    tool = DEFAULT_TARGET_COMPILER;
  }

  option = 0;
  opterr = 0; // we just ignore unknown options
  optind = 0;
  while ((option = getopt(argc, argv, "o:f:v:")) != -1) {
    switch(option) {
      case 'o':
        output = optarg;
        break;
      case 'f':
        // TODO: We use the "-Xlinker" option of clang with
        // the value "-fopenmp-static". Question is if we should
        // manipulate the Args in 
        // "llvm/tools/clang/lib/Driver/ToolChains/NEC*" before we
        // pass it to the linker wrapper.

        // we ignore all other -f prefixes than "fopenmp-static"
        if(!strcmp(optarg,"openmp-static")) {
          statictgt = true;
        }
        break;
      case 'v':
        Verbose = true;
        break;
      default:
        break;
    }
  }

  cmdLine << tool << " ";
  for (int i = optind; i < argc; i++) {
    objects.push_back(argv[i]);
  }

  if (!statictgt) {
    optind = 0;

    for (int i = 1; i < argc; ++i) {
      cmdLine << " " << argv[i];
    }
  } else {
    if (elf_version(EV_CURRENT) == EV_NONE)
      errx (EXIT_FAILURE, "ELF library initialization failed : %s", 
            elf_errmsg (-1));

    //for (std::vector<std::string>::iterator it=objects.begin(); it!=objects.end(); it++){
    for (auto o : objects) {
      char* objName = new char[o.length()+1];
      std::strcpy(objName, o.c_str());
      getSymsFromELFObj(objName, &symNames);
      cmdLine << objName << " ";
      delete objName;
    }
    SymTabPath = generateSymTabCode(&symNames); 
    cmdLine << SymTabPath << " ";
    cmdLine << "/opt/nec/ve/lib/libveorun.a ";
    // We just assume that we require OpenMP (otherwise we would be in a
    // different code branch). We only support ncc, icc, clang or gnu here.
    cmdLine << "-fopenmp ";
    cmdLine << "-o " << output;
  }

  if (Verbose)
    std::cout << " \"" << cmdLine.str() << "\"" <<std::endl;
  //ret = runTargetCompiler(SymTabPath, ArgsStream.str());


  ret = std::system(cmdLine.str().c_str());

  if (ret != 0) {
    std::cerr << "necaurora-ofld-tool-wrapper: "
              << "execution of target compiler failed\n";
    return EXIT_FAILURE;
  }

  if (statictgt){
    std::cout << "Static Startup " << output << std::endl;
    // We have to keep the output in the static case.
    // TODO: This should be in the fat binary somehow...
    cmdCp << "cp " << output << " ./" << VEORUN_BIN;
    if (Verbose)
      std::cout << cmdCp << std::endl;
    ret = std::system(cmdCp.str().c_str());
  }

  std::remove(SymTabPath.c_str());
  return ret;

}

