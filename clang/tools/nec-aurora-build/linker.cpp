#include "necaurora-ofld-wrapper.h"

#include <err.h>
#include <fcntl.h>
#include <gelf.h>
#include <iostream>
#include <libelf.h>
#include <sstream>
#include <unistd.h>
#include <vector>

void getSymsFromELFObj(char *elfObject, std::vector<std::string> &symbols) {
  int fd;
  Elf *e;
  Elf_Scn *scn = NULL;
  size_t shstrndx;
  char *name;
  GElf_Shdr shdr;
  Elf_Data *data;

  if (elf_version(EV_CURRENT) == EV_NONE) {
    err(EXIT_FAILURE, "ELF library too old");
  }

  if ((fd = open(elfObject, O_RDONLY, 0)) < 0) {
    err(EXIT_FAILURE, "Open %s failed", elfObject);
  }

  if ((e = elf_begin(fd, ELF_C_READ, NULL)) == NULL)
    errx(EXIT_FAILURE, "elf_begin() failed: %s.", elf_errmsg(-1));

  if (elf_kind(e) != ELF_K_ELF)
    errx(EXIT_FAILURE, "%s is  not an  ELF  object .", elfObject);

  // Retrive section index of the ELF section containing the string table
  // of section names.
  if (elf_getshdrstrndx(e, &shstrndx) != 0)
    errx(EXIT_FAILURE, "elf_getshdrstrndx ()  failed : %s.", elf_errmsg(-1));

  // Iterate all sections
  while ((scn = elf_nextscn(e, scn)) != NULL) {
    if (gelf_getshdr(scn, &shdr) != &shdr)
      errx(EXIT_FAILURE, "getshdr() failed : %s.", elf_errmsg(-1));

    if ((name = elf_strptr(e, shstrndx, shdr.sh_name)) == NULL)
      errx(EXIT_FAILURE, "elf_strptr() failed: %s.", elf_errmsg(-1));

    // We only care about symbols in ".symtab"
    if (shdr.sh_type == SHT_SYMTAB) {
      data = elf_getdata(scn, NULL);
      int symCount = shdr.sh_size / shdr.sh_entsize;
      for (int i = 0; i < symCount; i++) {
        GElf_Sym sym;
        gelf_getsym(data, i, &sym);

        // We need all global functions and global variables in the link table
        if (GELF_ST_BIND(sym.st_info) == STB_GLOBAL &&
            (GELF_ST_TYPE(sym.st_info) == STT_FUNC ||
             GELF_ST_TYPE(sym.st_info) == STT_OBJECT)) {
          char *symName;

          // if the sh_type equals SHT_SYMTAB, then sh_link holds the
          // information for the section header index of the associated string
          // table.
          if ((symName = elf_strptr(e, shdr.sh_link, sym.st_name)) == NULL)
            errx(EXIT_FAILURE, "elf_strptr() failed: %s.", elf_errmsg(-1));
          symbols.push_back(symName);
        }
      }
    }
  }

  elf_end(e);
  close(fd);
}

// Generates the code which initializes the symbol table for static linking
// and returns the path to the written C file.
std::string generateSymTabCode(const std::vector<std::string> &symbols) {
  std::stringstream out;
  out << "#include <stdlib.h>\n";
  out << "#include <string.h>\n";

  for (std::string s : symbols) {
    out << "extern unsigned long " << s << ";\n";
  }

  out << "typedef struct { const char *n; void *v; } static_sym_t;\n";
  out << "static_sym_t _veo_static_symtable[] = {\n";

  for (auto s : symbols) {
    out << " { .n = \"" << s << "\", .v = &" << s << " },\n";
  }
  out << "{ .n = 0, .v = 0 },\n";
  out << "};\n";

  return writeTmpFile(out.str(), "veorun", ".c");
}

int runStaticLinker(const std::vector<const char *> &ObjectFiles,
                    const std::string &Args, const std::string &OutputFile) {
#ifndef LIBVEORUN_STATIC_PATH
  std::cerr << "necaurora-ofld-wrapper: Static linking not supported"
            << std::endl;
  return EXIT_FAILURE;
#else
  std::stringstream CmdLine;
  std::vector<std::string> SymbolNames;

  for (auto ObjFile : ObjectFiles) {
    getSymsFromELFObj((char *)ObjFile, SymbolNames);
  }

  std::string SymTabPath = generateSymTabCode(SymbolNames);

  CmdLine << getTargetCompiler() << " ";
  for (auto ObjFile: ObjectFiles) {
    CmdLine << ObjFile << " ";
  }
  CmdLine << SymTabPath << " "
          << LIBVEORUN_STATIC_PATH
          << " -fopenmp -o " << OutputFile;
  if (Verbose) {
    std::cerr << "  \"" << CmdLine.str() << "\"" << std::endl;
  }

  int ret = std::system(CmdLine.str().c_str());

  if (!KeepTransformedFilesDir) {
    std::remove(SymTabPath.c_str());
  }
  return ret;
#endif
}
