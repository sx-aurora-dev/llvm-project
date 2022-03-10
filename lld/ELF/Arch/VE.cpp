//===- VE.cpp -------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "InputFiles.h"
#include "Symbols.h"
#include "SyntheticSections.h"
#include "Target.h"
#include "lld/Common/ErrorHandler.h"
#include "llvm/Support/Endian.h"

using namespace llvm;
using namespace llvm::support::endian;
using namespace llvm::ELF;
using namespace lld;
using namespace lld::elf;

namespace {
class VE final : public TargetInfo {
public:
  VE();
  RelType getDynRel(RelType type) const override;
  RelExpr getRelExpr(RelType type, const Symbol &s,
                     const uint8_t *loc) const override;
  int64_t getImplicitAddend(const uint8_t *buf, RelType type) const override;
  void writeGotPltHeader(uint8_t *buf) const override;
  void writeGotHeader(uint8_t *buf) const override;
  void writeGotPlt(uint8_t *buf, const Symbol &s) const override;
  void writePltHeader(uint8_t *buf) const override;
  void writePlt(uint8_t *buf, const Symbol &sym,
                uint64_t pltEntryAddr) const override;
  void relocate(uint8_t *loc, const Relocation &rel,
                uint64_t val) const override;
  RelExpr adjustTlsExpr(RelType type, RelExpr expr) const override;
};
} // namespace

VE::VE() {
  copyRel = R_VE_COPY;
  gotRel = R_VE_GLOB_DAT;
  pltRel = R_VE_JUMP_SLOT;
  relativeRel = R_VE_RELATIVE;
  symbolicRel = R_VE_REFQUAD;

  tlsModuleIndexRel = R_VE_DTPMOD64;
  tlsOffsetRel = R_VE_DTPOFF64;
  // VE has no R_VE_TPOFF64.
  tlsGotRel = R_VE_NONE;

  gotEntrySize = 8;
  pltEntrySize = 64;
  pltHeaderSize = 64;

  // The .got has no preserved entries.
  // gotHeaderEntriesNum = 0;

  // _GLOBAL_OFFSET_TABLE_ == .got.plt.
  gotBaseSymInGotPlt = true;

  // _GLOBAL_OFFSET_TABLE_ has two preserved entries.
  //   _GLOBAL_OFFSET_TABLE_[0] = _DYNAMIC.
  //   _GLOBAL_OFFSET_TABLE_[1] = reserved by glibc.
  // or
  // _GLOBAL_OFFSET_TABLE_[0] = _DYNAMIC
  // glibc stores _dl_runtime_resolve in _GLOBAL_OFFSET_TABLE_[1],
  // link_map in _GLOBAL_OFFSET_TABLE_[2].
  gotPltHeaderEntriesNum = 3;

  defaultCommonPageSize = 8192;
  defaultMaxPageSize = 0x100000;
  defaultImageBase = 0x600000000000;
}

RelType VE::getDynRel(RelType type) const {
  if (type == R_VE_REFQUAD)
    return type;
  return R_VE_NONE;
}

RelExpr VE::getRelExpr(RelType type, const Symbol &s,
                            const uint8_t *loc) const {
  switch (type) {
  case R_VE_NONE:
    return R_NONE;
  case R_VE_REFLONG:
  case R_VE_REFQUAD:
    return R_ABS;
  case R_VE_SREL32:
    return R_PC;
  case R_VE_HI32:
  case R_VE_LO32:
    return R_ABS;
  case R_VE_PC_HI32:
  case R_VE_PC_LO32:
    return R_PC;
  case R_VE_GOT32:
  case R_VE_GOT_HI32:
  case R_VE_GOT_LO32:
    return R_GOTPLT;
  case R_VE_GOTOFF32:
  case R_VE_GOTOFF_HI32:
  case R_VE_GOTOFF_LO32:
    return R_GOTPLTREL;
  case R_VE_PLT32:
  case R_VE_PLT_HI32:
  case R_VE_PLT_LO32:
    return R_PLT_PC;
#if 0
  case R_VE_RELATIVE:
  case R_VE_GLOB_DAT:
  case R_VE_JUMP_SLOT:
  case R_VE_COPY:
  case R_VE_DTPMOD64:
#endif
  case R_VE_DTPOFF64:
    return R_DTPREL;
  case R_VE_TLS_GD_HI32:
  case R_VE_TLS_GD_LO32:
    return R_TLSGD_PC;
  case R_VE_TPOFF_HI32:
  case R_VE_TPOFF_LO32:
    // TP offset relocation types used for the local-exec TLS model.
    return R_TPREL;
  case R_VE_CALL_HI32:
  case R_VE_CALL_LO32:
    return R_ABS;
  default:
    error(getErrorLocation(loc) + "unknown relocation (" + Twine(type) +
          ") against symbol " + toString(s));
    return R_NONE;
  }
}

void VE::relocate(uint8_t *loc, const Relocation &rel,
                       uint64_t val) const {
  switch (rel.type) {
  case R_VE_REFLONG:
    // No range check for REFLONG.
    write32le(loc, val);
    break;
  case R_VE_REFQUAD:
    write64le(loc, val);
    break;
  case R_VE_SREL32:
    // Range check for SREL32 which is used by relative branch.
    checkInt(loc, val, 32, rel);
    write32le(loc, val);
    break;
  case R_VE_HI32:
  case R_VE_PC_HI32:    // OK
  case R_VE_GOT_HI32:   // OK
  case R_VE_GOTOFF_HI32:// OK
  case R_VE_PLT_HI32:   // OK
    write32le(loc, val >> 32);
    break;
  case R_VE_LO32:
  case R_VE_PC_LO32:    // OK
  case R_VE_GOT32:
  case R_VE_GOT_LO32:   // OK
  case R_VE_GOTOFF32:
  case R_VE_GOTOFF_LO32:// OK
  case R_VE_PLT32:
  case R_VE_PLT_LO32:   // OK
    write32le(loc, val);
    break;
#if 0
  case R_VE_RELATIVE:
  case R_VE_GLOB_DAT:
  case R_VE_JUMP_SLOT:
    checkInt(loc, val, 64, rel);
    write64le(loc, val);
    break;
  case R_VE_COPY:
  case R_VE_DTPMOD64:
#endif
  case R_VE_DTPOFF64:
    write64le(loc, val);
    break;
  case R_VE_TLS_GD_HI32:
  case R_VE_TPOFF_HI32:
  case R_VE_CALL_HI32:
    write32le(loc, val >> 32);
    break;
  case R_VE_TLS_GD_LO32:
  case R_VE_TPOFF_LO32:
  case R_VE_CALL_LO32:
    write32le(loc, val);
    break;
  default:
    error(getErrorLocation(loc) + "unknown relocation (" + Twine(rel.type) +
          ")");
  }
}

int64_t VE::getImplicitAddend(const uint8_t *buf, RelType type) const {
  switch (type) {
  default:
    internalLinkerError(getErrorLocation(buf),
                        "cannot read addend for relocation " + toString(type));
    return 0;
  case R_VE_NONE:
    // This relocations are defined as not having an implicit addend.
    return 0;
  case R_VE_REFLONG:
    return SignExtend64<32>(read32le(buf));
  case R_VE_REFQUAD:
    return read64le(buf);
  case R_VE_SREL32:
  case R_VE_HI32:
  case R_VE_LO32:
  case R_VE_PC_HI32:
  case R_VE_PC_LO32:
  case R_VE_GOT32:
  case R_VE_GOT_HI32:
  case R_VE_GOT_LO32:
  case R_VE_GOTOFF32:
  case R_VE_GOTOFF_HI32:
  case R_VE_GOTOFF_LO32:
  case R_VE_PLT32:
  case R_VE_PLT_HI32:
  case R_VE_PLT_LO32:
    return SignExtend64<32>(read32le(buf));
  case R_VE_RELATIVE:
  case R_VE_GLOB_DAT:
    return read64le(buf);
  case R_VE_JUMP_SLOT:
    // These relocations are defined as not having an implicit addend.
    return 0;
  case R_VE_DTPMOD64:
  case R_VE_DTPOFF64:
    return read64le(buf);
  case R_VE_TLS_GD_HI32:
  case R_VE_TLS_GD_LO32:
  case R_VE_TPOFF_HI32:
  case R_VE_TPOFF_LO32:
  case R_VE_CALL_HI32:
  case R_VE_CALL_LO32:
    return SignExtend64<32>(read32le(buf));
  }
}

RelExpr VE::adjustTlsExpr(RelType type, RelExpr expr) const {
  return R_NONE;
  // return expr;
}

void VE::writeGotPltHeader(uint8_t *buf) const {
  // _GLOBAL_OFFSET_TABLE_[0] = _DYNAMIC.
  // The glibc stores __dso_handle (reserved) in _GLOBAL_OFFSET_TABLE[1].
  write64le(buf, mainPart->dynamic->getVA());
}

void VE::writeGotHeader(uint8_t *buf) const {
  // _GLOBAL_OFFSET_TABLE_[0] = _DYNAMIC
  // glibc stores _dl_runtime_resolve in _GLOBAL_OFFSET_TABLE_[1],
  // link_map in _GLOBAL_OFFSET_TABLE_[2].
  write64le(buf, mainPart->dynamic->getVA());
}

void VE::writeGotPlt(uint8_t *buf, const Symbol &s) const {
  // Entries in .got.plt initially points back to the corresponding
  // PLT entries with a fixed offset to skip the first instruction.
  write64le(buf, s.getPltVA() + 5 * 8);
}

void VE::writePltHeader(uint8_t *buf) const {
  const uint8_t pltData[] = {
                                                      // _PROCEDURE_LINKAGE_TABLE:
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3e, 0x06, // lea %s62, _GLOBAL_OFFSET_TABLE_@LO
      0x00, 0x00, 0x00, 0x00, 0x60, 0xbe, 0x3e, 0x44, // and %s62, %s62, (32)0
      0x00, 0x00, 0x00, 0x00, 0xbe, 0x00, 0xbe, 0x06, // lea.sl %s62, _GLOBAL_OFFSET_TABLE_@HI(, %s62)
      0x08, 0x00, 0x00, 0x00, 0xbe, 0x00, 0x3f, 0x01, // ld %s63, 8(, %s62)
      0x00, 0x00, 0x00, 0x00, 0xbf, 0x00, 0x3f, 0x19, // b.l.t (, %s63)
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // nop
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // nop
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // nop
  };
  memcpy(buf, pltData, sizeof(pltData));

  uint64_t got = in.gotPlt->getVA();
  // Set address of _GLOBAL_OFFSET_TABLE[0]
  relocateNoSym(buf + 0 * 8, R_VE_LO32, got);
  relocateNoSym(buf + 2 * 8, R_VE_HI32, got);
  // uint64_t plt = in.plt->getVA();
}

void VE::writePlt(uint8_t *buf, const Symbol & sym,
                       uint64_t pltEntryAddr) const {
  const uint8_t pltData[] = {
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0d, 0x06, // lea %s13, _GLOBAL_OFFSET_TABLE[$index + gotPltHeaderEntriesNum]@LO
      0x00, 0x00, 0x00, 0x00, 0x60, 0x8d, 0x0d, 0x44, // and %s13, %s13, (32)0
      0x00, 0x00, 0x00, 0x00, 0x8d, 0x00, 0x8d, 0x06, // lea.sl %s13, _GLOBAL_OFFSET_TABLE[$index + gotPltHeaderEntriesNum]@HI(, %s13)
      0x08, 0x00, 0x00, 0x00, 0x8d, 0x00, 0x0c, 0x01, // ld %s12, (, %s13)
      0x00, 0x00, 0x00, 0x00, 0x8c, 0x00, 0x3f, 0x19, // b.l.t (, %s12)
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0d, 0x06, // lea %s13, $index
      0x90, 0xff, 0xff, 0xff, 0x00, 0x00, 0x3f, 0x18, // br.l.t _PROCEDURE_LINKAGE_TABLE_
      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, // nop
  };
  memcpy(buf, pltData, sizeof(pltData));

  uint64_t pltEntryOff = pltEntryAddr - in.plt->getVA();
  uint64_t pltEntryIdx = (pltEntryOff - pltHeaderSize) / pltEntrySize;
  uint64_t gotPltBase = in.gotPlt->getVA();
  uint64_t gotPlt = gotPltBase + gotPltHeaderEntriesNum * gotEntrySize;
  uint64_t va = gotPlt + pltEntryIdx * gotEntrySize;

  // Set address of _GLOBAL_OFFSET_TABLE[$index + gotPltHeaderEntriesNum]
  relocateNoSym(buf + 0 * 8, R_VE_LO32, va);
  relocateNoSym(buf + 2 * 8, R_VE_HI32, va);
  // Set index of relocation entry of symbol
  relocateNoSym(buf + 5 * 8, R_VE_REFLONG, pltEntryIdx);
  // Set relative jump offset to _PROCEDURE_LINKAGE
  relocateNoSym(buf + 6 * 8, R_VE_PC_LO32, -(pltEntryOff + 6 * 8));
}

TargetInfo *elf::getVETargetInfo() {
  static VE target;
  return &target;
}
