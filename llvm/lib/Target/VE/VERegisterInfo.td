//===-- VERegisterInfo.td - VE Register defs ---------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Declarations that describe the VE register file
//===----------------------------------------------------------------------===//

class VEReg<bits<7> enc, string n, list<Register> subregs = [],
            list<string> altNames = [], list<Register> aliases = []>
        : Register<n, altNames> {
  let HWEncoding{15-7} = 0;
  let HWEncoding{6-0} = enc;
  let Namespace = "VE";
  let SubRegs = subregs;
  let Aliases = aliases;
}

class VEMiscReg<bits<6> enc, string n>: Register<n> {
  let HWEncoding{15-6} = 0;
  let HWEncoding{5-0} = enc;
  let Namespace = "VE";
}

class VEVecReg<bits<8> enc, string n, list<Register> subregs = [],
               list<string> altNames = [], list<Register> aliases = []>
        : Register<n, altNames> {
  let HWEncoding{15-8} = 0;
  let HWEncoding{7-0} = enc;
  let Namespace = "VE";
  let SubRegs = subregs;
  let Aliases = aliases;
}

class VEMaskReg<bits<4> enc, string n, list<Register> subregs = [],
                list<string> altNames = [], list<Register> aliases = []>
        : Register<n, altNames> {
  let HWEncoding{15-4} = 0;
  let HWEncoding{3-0} = enc;
  let Namespace = "VE";
  let SubRegs = subregs;
  let Aliases = aliases;
}

let Namespace = "VE" in {
  def sub_i8      : SubRegIndex<8, 56>;         // Low 8 bit (56..63)
  def sub_i16     : SubRegIndex<16, 48>;        // Low 16 bit (48..63)
  def sub_i32     : SubRegIndex<32, 32>;        // Low 32 bit (32..63)
  def sub_f32     : SubRegIndex<32>;            // High 32 bit (0..31)
  def sub_even    : SubRegIndex<64>;            // High 64 bit (0..63)
  def sub_odd     : SubRegIndex<64, 64>;        // Low 64 bit (64..127)
  def sub_vm_even : SubRegIndex<256>;           // High 256 bit (0..255)
  def sub_vm_odd  : SubRegIndex<256, 256>;      // Low 256 bit (256..511)
  def AsmName : RegAltNameIndex;
}

//-----------------------------------------------------------------------------
// Miscellaneous Registers
//-----------------------------------------------------------------------------

def USRCC : VEMiscReg<0, "USRCC">;      // User clock counter
def PSW : VEMiscReg<1, "PSW">;          // Program status word
def SAR : VEMiscReg<2, "SAR">;          // Store address register
def PMMR : VEMiscReg<7, "PMMR">;        // Performance monitor mode register

// Performance monitor configuration registers
foreach I = 0-3 in
  def PMCR#I : VEMiscReg<!add(8,I), "PMCR"#I>;

// Performance monitor counter
foreach I = 0-14 in
  def PMC#I : VEMiscReg<!add(16,I), "PMC"#I>;

// Register classes.
def MISC : RegisterClass<"VE", [i64], 64,
                         (add USRCC, PSW, SAR, PMMR,
                              (sequence "PMCR%u", 0, 3),
                              (sequence "PMC%u", 0, 14))>;

//-----------------------------------------------------------------------------
// Instruction Counter Register
//-----------------------------------------------------------------------------

def IC : VEMiscReg<62, "IC">;

//-----------------------------------------------------------------------------
// Vector Length Register
//-----------------------------------------------------------------------------

def VL : VEMiscReg<63, "VL">;

// Register classes.
def VLS : RegisterClass<"VE", [i32], 64, (add VL)>;

//-----------------------------------------------------------------------------
// Gneric Registers
//-----------------------------------------------------------------------------

let RegAltNameIndices = [AsmName] in {

// Generic integer registers - 8 bits wide
foreach I = 0-63 in
  def SB#I : VEReg<I, "SB"#I, [], ["S"#I]>, DwarfRegNum<[I]>;

// Generic integer registers - 16 bits wide
let SubRegIndices = [sub_i8] in
foreach I = 0-63 in
  def SH#I : VEReg<I, "SH"#I, [!cast<VEReg>("SB"#I)], ["S"#I]>,
                   DwarfRegNum<[I]>;

// Generic integer registers - 32 bits wide
let SubRegIndices = [sub_i16] in
foreach I = 0-63 in
  def SW#I : VEReg<I, "SW"#I, [!cast<VEReg>("SH"#I)], ["S"#I]>,
                   DwarfRegNum<[I]>;

// Generic floating point registers - 32 bits wide
//   NOTE: Mark SF#I as alias of SW#I temporary to avoid register allocation
//         problem.
foreach I = 0-63 in
  def SF#I : VEReg<I, "SF"#I, [], ["S"#I], [!cast<VEReg>("SW"#I)]>,
                   DwarfRegNum<[I]>;

// Generic integer registers - 64 bits wide
let SubRegIndices = [sub_i32, sub_f32], CoveredBySubRegs = 1 in
foreach I = 0-63 in
  def SX#I : VEReg<I, "S"#I, [!cast<VEReg>("SW"#I), !cast<VEReg>("SF"#I)],
                   ["S"#I]>, DwarfRegNum<[I]>;

// Vector registers - 64 bits wide 256 elements
foreach I = 0-63 in
  def V#I : VEVecReg<I, "V"#I, [], ["V"#I]>, DwarfRegNum<[!add(64,I)]>;

// Vector Index Register
def VIX : VEVecReg<255, "VIX", [], ["VIX"]>;

// Vector mask registers - 256 bits wide
foreach I = 0-15 in
  def VM#I : VEMaskReg<I, "VM"#I, [], ["VM"#I]>, DwarfRegNum<[!add(128,I)]>;

// Aliases of VMs to use as a pair of two VM for packed instructions
def VMP0 : VEReg<0, "VM0">;

let SubRegIndices = [sub_vm_even, sub_vm_odd], CoveredBySubRegs = 1 in
foreach I = 1-7 in
  def VMP#I : VEMaskReg<!shl(I,1), "VMP"#I, 
                        [!cast<VEMaskReg>("VM"#!shl(I,1)),
                         !cast<VEMaskReg>("VM"#!add(!shl(I,1),1))],
                        ["VM"#!shl(I,1)]>;

// Aliases of the S* registers used to hold 128-bit for values (long doubles).
// Following foreach represents something like:
//   def Q0 : VEReg<0, "S0", [S0, S1]>;
//   def Q1 : VEReg<2, "S2", [S2, S3]>;
//   ...
let SubRegIndices = [sub_even, sub_odd], CoveredBySubRegs = 1 in
foreach I = 0-31 in
  def Q#I : VEReg<!shl(I,1), "Q"#I,
                  [!cast<VEReg>("SX"#!shl(I,1)),
                   !cast<VEReg>("SX"#!add(!shl(I,1),1))],
                  ["S"#!shl(I,1)]>;

} // RegAltNameIndices = [AsmName]

// Register classes.
//
// The register order is defined in terms of the preferred
// allocation order.
def I8  : RegisterClass<"VE", [i8], 8,
                        (add (sequence "SB%u", 0, 7),
                             (sequence "SB%u", 34, 63),
                             (sequence "SB%u", 8, 33))>;
def I16 : RegisterClass<"VE", [i16], 16,
                        (add (sequence "SH%u", 0, 7),
                             (sequence "SH%u", 34, 63),
                             (sequence "SH%u", 8, 33))>;
def I32 : RegisterClass<"VE", [i32], 32,
                        (add (sequence "SW%u", 0, 7),
                             (sequence "SW%u", 34, 63),
                             (sequence "SW%u", 8, 33))>;
def I64 : RegisterClass<"VE", [i64, f64], 64,
                        (add (sequence "SX%u", 0, 7),
                             (sequence "SX%u", 34, 63),
                             (sequence "SX%u", 8, 33))>;
def F32 : RegisterClass<"VE", [f32], 32,
                        (add (sequence "SF%u", 0, 7),
                             (sequence "SF%u", 34, 63),
                             (sequence "SF%u", 8, 33))>;
def F128 : RegisterClass<"VE", [f128], 128,
                        (add (sequence "Q%u", 0, 3),
                             (sequence "Q%u", 17, 31),
                             (sequence "Q%u", 4, 16))>;

def V64 : RegisterClass<"VE",
                        [v512i32, v512f32,
                         v256i64, v256f64,
                         v256i32, v256f32],
                        64,
                        (add (sequence "V%u", 0, 63),
                             VIX)>;

// vm0 is reserved for always true
def VM : RegisterClass<"VE", [v256i1, v4i64], 64, (sequence "VM%u", 0, 15)>;
def VM512 : RegisterClass<"VE", [v512i1, v8i64], 64, (sequence "VMP%u", 0, 7)>;

// Above vector mask registers includes v4i64 and v8i64 to allow vector
// mask data tyeps as a parameter of intrinsic instructions without
// necessary bitcast.
def VM_ : RegisterClass<"VE", [v256i1], 64, (sequence "VM%u", 0, 15)>;
def VM512_ : RegisterClass<"VE", [v512i1], 64, (sequence "VMP%u", 0, 7)>;
