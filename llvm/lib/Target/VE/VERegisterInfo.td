//===-- VERegisterInfo.td - VE Register defs ---------------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Declarations that describe the VE register file
//===----------------------------------------------------------------------===//

class VEReg<bits<7> Enc, string n> : Register<n> {
  let HWEncoding{15-7} = 0;
  let HWEncoding{6-0} = Enc;
  let Namespace = "VE";
}

class VEMiscReg<bits<5> Enc, string n>: Register<n> {
  let HWEncoding{15-5} = 0;
  let HWEncoding{4-0} = Enc;
  let Namespace = "VE";
}

let Namespace = "VE" in {
def sub_even : SubRegIndex<64>;
def sub_odd  : SubRegIndex<64, 64>;
}

// Registers are identified with 7-bit ID numbers.
// R - 64-bit integer or floating-point registers
class R<bits<7> Enc, string n> : VEReg<Enc, n>;

// Rq - Slots in the register file for 128-bit floating-point values.
class Rq<bits<7> Enc, string n, list<Register> subregs> : VEReg<Enc, n> {
  let SubRegs = subregs;
  let SubRegIndices = [sub_even, sub_odd];
  let CoveredBySubRegs = 1;
}

// Vector Registers are identified with 7-bit ID numbers.
// VR - 64-bit wide 256 elements integer or floating-point registers
class VR<bits<7> Enc, string n> : VEReg<Enc, n>;

// Vector Mask Registers are identified with 5-bit ID numbers.
// VM - 256-bit wide mask registers
class VM<bits<7> Enc, string n> : VEReg<Enc, n>;

// Miscellaneous Registers
def UCC : VEMiscReg<0, "UCC">;       // User clock counter
def PSW : VEMiscReg<1, "PSW">;       // Program status word
def SAR : VEMiscReg<2, "SAR">;       // Store address register
def PMMR : VEMiscReg<7, "PMMR">;     // Performance monitor mode register

// Performance monitor configuration registers
foreach I = 0-3 in
  def PMCR#I : VEMiscReg<!add(8,I), "PMCR"#I>;

// Performance monitor counter
foreach I = 0-14 in
  def PMC#I : VEMiscReg<!add(16,I), "PMC"#I>;

// Generic registers
foreach I = 0-63 in
  def S#I : R<I, "S"#I>, DwarfRegNum<[I]>;

// Vector registers
foreach I = 0-63 in
  def V#I : VEReg<I, "S"#I>;

// Aliases of the S* registers used to hold 128-bit for values (long doubles).
/*  this is not possible...
foreach I = 0-31 in
  def Q#I : Rq<!shl(I,1),  "S"#!shl(I,1), [S#!shl(I,1), S#!add(!shl(I,1),1)]>;
 */
def  Q0 : Rq< 0,  "S0", [ S0,  S1]>;
def  Q1 : Rq< 2,  "S2", [ S2,  S3]>;
def  Q2 : Rq< 4,  "S4", [ S4,  S5]>;
def  Q3 : Rq< 6,  "S6", [ S6,  S7]>;
def  Q4 : Rq< 8,  "S8", [ S8,  S9]>;
def  Q5 : Rq<10, "S10", [S10, S11]>;
def  Q6 : Rq<12, "S12", [S12, S13]>;
def  Q7 : Rq<14, "S14", [S14, S15]>;
def  Q8 : Rq<16, "S16", [S16, S17]>;
def  Q9 : Rq<18, "S18", [S18, S19]>;
def Q10 : Rq<20, "S20", [S20, S21]>;
def Q11 : Rq<22, "S22", [S22, S23]>;
def Q12 : Rq<24, "S24", [S24, S25]>;
def Q13 : Rq<26, "S26", [S26, S27]>;
def Q14 : Rq<28, "S28", [S28, S29]>;
def Q15 : Rq<30, "S30", [S30, S31]>;
def Q16 : Rq<32, "S32", [S32, S33]>;
def Q17 : Rq<34, "S34", [S34, S35]>;
def Q18 : Rq<36, "S36", [S36, S37]>;
def Q19 : Rq<38, "S38", [S38, S39]>;
def Q20 : Rq<40, "S40", [S40, S41]>;
def Q21 : Rq<42, "S42", [S42, S43]>;
def Q22 : Rq<44, "S44", [S44, S45]>;
def Q23 : Rq<46, "S46", [S46, S47]>;
def Q24 : Rq<48, "S48", [S48, S49]>;
def Q25 : Rq<50, "S50", [S50, S51]>;
def Q26 : Rq<52, "S52", [S52, S53]>;
def Q27 : Rq<54, "S54", [S54, S55]>;
def Q28 : Rq<56, "S56", [S56, S57]>;
def Q29 : Rq<58, "S58", [S58, S59]>;
def Q30 : Rq<60, "S60", [S60, S61]>;
def Q31 : Rq<62, "S62", [S62, S63]>;

// Register classes.
//
// FIXME: the register order should be defined in terms of the preferred
// allocation order...
def IntRegs : RegisterClass<"VE", [i32, i64], 64,
                            (sequence "S%u", 0, 63)>;

def FPRegs : RegisterClass<"VE", [f32, f64], 64,
                            (sequence "S%u", 0, 63)>;

def QFPRegs : RegisterClass<"VE", [f128], 128, (sequence "Q%u", 0, 31)>;

def MiscRegs : RegisterClass<"VE", [i64], 64,
                             (add UCC, PSW, SAR, PMMR,
                                  (sequence "PMCR%u", 0, 3),
                                  (sequence "PMC%u", 0, 14))>;

