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
  def sub_i8      : SubRegIndex<8, 56>;         // Low 8 bit (56..63)
  def sub_i16     : SubRegIndex<16, 48>;        // Low 16 bit (48..63)
  def sub_i32     : SubRegIndex<32, 32>;        // Low 32 bit (32..63)
  def sub_f32     : SubRegIndex<32>;            // High 32 bit (0..31)
  def sub_even    : SubRegIndex<64>;            // High 64 bit (0..63)
  def sub_odd     : SubRegIndex<64, 64>;        // Low 64 bit (64..127)
  def sub_vm_even : SubRegIndex<256>;           // High 256 bit (0..255)
  def sub_vm_odd  : SubRegIndex<256, 256>;      // Low 256 bit (256..511)
}

// Registers are identified with 7-bit ID numbers.
// R - 64-bit integer or floating-point registers
class R<bits<7> Enc, string n, list<Register> subregs = [],
        list<Register> aliases = []>: VEReg<Enc, n> {
  let SubRegs = subregs;
  let Aliases = aliases;
}

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

// Pseudo 512b mask register using two 256b physical mask register.
// Two 256b mask register has to be sequential and start from even register
// such as (VM2, VM3). Even register is used for upper(0:31) bit in packed
// vector instructions, and odd register is used for lower(32:63).
class VMp<bits<7> Enc, string n, list<Register> subregs> : VEReg<Enc, n> {
  let SubRegs = subregs;
  let SubRegIndices = [sub_vm_even, sub_vm_odd];
}

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

// Generic integer registers - 8 bits wide
foreach I = 0-63 in
  def SB#I : R<I, "S"#I>, DwarfRegNum<[I]>;

// Generic integer registers - 16 bits wide
let SubRegIndices = [sub_i8] in
foreach I = 0-63 in
  def SH#I : R<I, "S"#I, [!cast<R>("SB"#I)]>, DwarfRegNum<[I]>;

// Generic integer registers - 32 bits wide
let SubRegIndices = [sub_i16] in
foreach I = 0-63 in
  def SW#I : R<I, "S"#I, [!cast<R>("SH"#I)]>, DwarfRegNum<[I]>;

// Generic floating point registers - 32 bits wide
//   NOTE: Mark SF#I as alias of SW#I temporary to avoid register allocation
//         problem.
foreach I = 0-63 in
  def SF#I : R<I, "S"#I, [], [!cast<R>("SW"#I)]>, DwarfRegNum<[I]>;

// Generic integer registers - 64 bits wide
let SubRegIndices = [sub_i32, sub_f32], CoveredBySubRegs = 1 in
foreach I = 0-63 in
  def SX#I : R<I, "S"#I, [!cast<R>("SW"#I), !cast<R>("SF"#I)]>,
             DwarfRegNum<[I]>;

// Vector registers - 64 bits wide 256 elements
foreach I = 0-63 in
  def V#I : VR<I, "V"#I>, DwarfRegNum<[!add(64,I)]>;

// Vector mask registers - 256 bits wide
foreach I = 0-15 in
  def VM#I : VM<I, "VM"#I>, DwarfRegNum<[!add(128,I)]>;

// Aliases of VMs to use as a pair of two VM for packed instructions
def VMP0 : VMp<0, "VM0", [VM0, VM1]>;
def VMP1 : VMp<2, "VM2", [VM2, VM3]>;
def VMP2 : VMp<4, "VM4", [VM4, VM5]>;
def VMP3 : VMp<6, "VM6", [VM6, VM7]>;
def VMP4 : VMp<8, "VM8", [VM8, VM9]>;
def VMP5 : VMp<10, "VM10", [VM10, VM11]>;
def VMP6 : VMp<12, "VM12", [VM12, VM13]>;
def VMP7 : VMp<14, "VM14", [VM14, VM15]>;

// Vector Lenght Register
def VL : VEReg<0, "VL">;


// Aliases of the S* registers used to hold 128-bit for values (long doubles).
// Following foreach represents something like:
//   def Q0 : Rq<0, "S0", [S0, S1]>;
//   def Q1 : Rq<2, "S2", [S2, S3]>;
//   ...
foreach I = 0-31 in
  def Q#I : Rq<!shl(I,1),  "S"#!shl(I,1),
               [!cast<R>("SX"#!shl(I,1)),
                !cast<R>("SX"#!add(!shl(I,1),1))]>;

// Register classes.
//
// The register order is defined in terms of the preferred
// allocation order.
def I8  : RegisterClass<"VE", [i8], 8,
                        (add (sequence "SB%u", 34, 63),
                             (sequence "SB%u", 0, 33))>;
def I16 : RegisterClass<"VE", [i16], 16,
                        (add (sequence "SH%u", 34, 63),
                             (sequence "SH%u", 0, 33))>;
def I32 : RegisterClass<"VE", [i32], 32,
                        (add (sequence "SW%u", 34, 63),
                             (sequence "SW%u", 0, 33))>;
def I64 : RegisterClass<"VE", [i64, f64], 64,
                        (add (sequence "SX%u", 34, 63),
                             (sequence "SX%u", 0, 33))>;
def F32 : RegisterClass<"VE", [f32], 32,
                        (add (sequence "SF%u", 34, 63),
                             (sequence "SF%u", 0, 33))>;
def F128 : RegisterClass<"VE", [f128], 128,
                        (add (sequence "Q%u", 17, 31),
                             (sequence "Q%u", 0, 16))>;

def Misc : RegisterClass<"VE", [i64], 64,
                         (add UCC, PSW, SAR, PMMR,
                              (sequence "PMCR%u", 0, 3),
                              (sequence "PMC%u", 0, 14))>;

def VLS : RegisterClass<"VE", [i32], 64,
                         (add VL)>;

def V64 : RegisterClass<"VE",
                        [v512i32, v512f32,
                         v256i64, v256i32, v256f32, v256f64,
                         v128i64, v128i32, v128f32, v128f64,
                         v64i64,  v64i32,  v64f32,  v64f64,
                         v32i64,  v32i32,  v32f32,  v32f64,
                         v16i64,  v16i32,  v16f32,  v16f64,
                         v8i64,   v8i32,   v8f32,   v8f64,
                         v4i64,   v4i32,   v4f32,   v4f64,
                         v2i64,   v2i32,   v2f32,   v2f64],
                        64, (sequence "V%u", 0, 63)>;
// vm0 is reserved for always true
def VM : RegisterClass<"VE", [v256i1], 64, (sequence "VM%u", 0, 15)>;
def VM512 : RegisterClass<"VE", [v512i1], 64, (sequence "VMP%u", 0, 7)>;

def VM_ : RegisterClass<"VE", [v256i1, v4i64], 64, (sequence "VM%u", 0, 15)>;
def VM512_ : RegisterClass<"VE", [v512i1, v8i64], 64, (sequence "VMP%u", 0, 7)>;
