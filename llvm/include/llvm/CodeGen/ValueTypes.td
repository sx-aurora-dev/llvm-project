//===- ValueTypes.td - ValueType definitions ---------------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// Value types - These values correspond to the register types defined in the
// MachineValueTypes.h file.  If you update anything here, you must update it
// there as well!
//
//===----------------------------------------------------------------------===//

class ValueType<int size, int value> {
  string Namespace = "MVT";
  int Size = size;
  int Value = value;
}

def OtherVT: ValueType<0  ,  1>;   // "Other" value
def i1     : ValueType<1  ,  2>;   // One bit boolean value
def i8     : ValueType<8  ,  3>;   // 8-bit integer value
def i16    : ValueType<16 ,  4>;   // 16-bit integer value
def i32    : ValueType<32 ,  5>;   // 32-bit integer value
def i64    : ValueType<64 ,  6>;   // 64-bit integer value
def i128   : ValueType<128,  7>;   // 128-bit integer value
def f16    : ValueType<16 ,  8>;   // 16-bit floating point value
def f32    : ValueType<32 ,  9>;   // 32-bit floating point value
def f64    : ValueType<64 , 10>;   // 64-bit floating point value
def f80    : ValueType<80 , 11>;   // 80-bit floating point value
def f128   : ValueType<128, 12>;   // 128-bit floating point value
def ppcf128: ValueType<128, 13>;   // PPC 128-bit floating point value

def v1i1   : ValueType<1 ,  14>;   //   1 x i1 vector value
def v2i1   : ValueType<2 ,  15>;   //   2 x i1 vector value
def v4i1   : ValueType<4 ,  16>;   //   4 x i1 vector value
def v8i1   : ValueType<8 ,  17>;   //   8 x i1 vector value
def v16i1  : ValueType<16,  18>;   //  16 x i1 vector value
def v32i1  : ValueType<32 , 19>;   //  32 x i1 vector value
def v64i1  : ValueType<64 , 20>;   //  64 x i1 vector value
def v128i1 : ValueType<128, 21>;   // 128 x i1 vector value
def v256i1 : ValueType<256, 22>;   // 256 x i1 vector value
def v512i1 : ValueType<512, 23>;   // 512 x i1 vector value
def v1024i1: ValueType<1024,24>;   //1024 x i1 vector value

def v1i8   : ValueType<8,   25>;   //  1 x i8  vector value
def v2i8   : ValueType<16 , 26>;   //  2 x i8  vector value
def v4i8   : ValueType<32 , 27>;   //  4 x i8  vector value
def v8i8   : ValueType<64 , 28>;   //  8 x i8  vector value
def v16i8  : ValueType<128, 29>;   // 16 x i8  vector value
def v32i8  : ValueType<256, 30>;   // 32 x i8  vector value
def v64i8  : ValueType<512, 31>;   // 64 x i8  vector value
def v128i8 : ValueType<1024,32>;   //128 x i8  vector value
def v256i8 : ValueType<2048,33>;   //256 x i8  vector value

def v1i16  : ValueType<16 , 34>;   //  1 x i16 vector value
def v2i16  : ValueType<32 , 35>;   //  2 x i16 vector value
def v4i16  : ValueType<64 , 36>;   //  4 x i16 vector value
def v8i16  : ValueType<128, 37>;   //  8 x i16 vector value
def v16i16 : ValueType<256, 38>;   // 16 x i16 vector value
def v32i16 : ValueType<512, 39>;   // 32 x i16 vector value
def v64i16 : ValueType<1024,40>;   // 64 x i16 vector value
def v128i16: ValueType<2048,41>;   //128 x i16 vector value

def v1i32  : ValueType<32 , 42>;   //  1 x i32 vector value
def v2i32  : ValueType<64 , 43>;   //  2 x i32 vector value
def v3i32  : ValueType<96 , 44>;   //  3 x i32 vector value
def v4i32  : ValueType<128, 45>;   //  4 x i32 vector value
def v5i32  : ValueType<160, 46>;   //  5 x i32 vector value
def v8i32  : ValueType<256, 47>;   //  8 x i32 vector value
def v16i32 : ValueType<512, 48>;   // 16 x i32 vector value
def v32i32 : ValueType<1024,49>;   // 32 x i32 vector value
def v64i32 : ValueType<2048,50>;   // 64 x i32 vector value
def v256i32 : ValueType<8192, 51>; // 256 x i32 vector value
def v512i32 : ValueType<16384,52>; // 512 x i32 vector value

def v1i64  : ValueType<64 , 53>;   //  1 x i64 vector value
def v2i64  : ValueType<128, 54>;   //  2 x i64 vector value
def v4i64  : ValueType<256, 55>;   //  4 x i64 vector value
def v8i64  : ValueType<512, 56>;   //  8 x i64 vector value
def v16i64 : ValueType<1024,57>;   // 16 x i64 vector value
def v32i64 : ValueType<2048,58>;   // 32 x i64 vector value
def v256i64 : ValueType<16384,59>; // 256 x i64 vector value

def v1i128 : ValueType<128, 60>;   //  1 x i128 vector value

def nxv1i1  : ValueType<1,   61>;  // n x  1 x i1  vector value
def nxv2i1  : ValueType<2,   62>;  // n x  2 x i1  vector value
def nxv4i1  : ValueType<4,   63>;  // n x  4 x i1  vector value
def nxv8i1  : ValueType<8,   64>;  // n x  8 x i1  vector value
def nxv16i1 : ValueType<16,  65>;  // n x 16 x i1  vector value
def nxv32i1 : ValueType<32,  66>;  // n x 32 x i1  vector value

def nxv1i8  : ValueType<8,   67>;  // n x  1 x i8  vector value
def nxv2i8  : ValueType<16,  68>;  // n x  2 x i8  vector value
def nxv4i8  : ValueType<32,  69>;  // n x  4 x i8  vector value
def nxv8i8  : ValueType<64,  70>;  // n x  8 x i8  vector value
def nxv16i8 : ValueType<128, 71>;  // n x 16 x i8  vector value
def nxv32i8 : ValueType<256, 72>;  // n x 32 x i8  vector value

def nxv1i16 : ValueType<16,  73>;  // n x  1 x i16 vector value
def nxv2i16 : ValueType<32,  74>;  // n x  2 x i16 vector value
def nxv4i16 : ValueType<64,  75>;  // n x  4 x i16 vector value
def nxv8i16 : ValueType<128, 76>;  // n x  8 x i16 vector value
def nxv16i16: ValueType<256, 77>;  // n x 16 x i16 vector value
def nxv32i16: ValueType<512, 78>;  // n x 32 x i16 vector value

def nxv1i32 : ValueType<32,  79>;  // n x  1 x i32 vector value
def nxv2i32 : ValueType<64,  80>;  // n x  2 x i32 vector value
def nxv4i32 : ValueType<128, 81>;  // n x  4 x i32 vector value
def nxv8i32 : ValueType<256, 82>;  // n x  8 x i32 vector value
def nxv16i32: ValueType<512, 83>;  // n x 16 x i32 vector value
def nxv32i32: ValueType<1024,84>;  // n x 32 x i32 vector value

def nxv1i64 : ValueType<64,  85>;  // n x  1 x i64 vector value
def nxv2i64 : ValueType<128, 86>;  // n x  2 x i64 vector value
def nxv4i64 : ValueType<256, 87>;  // n x  4 x i64 vector value
def nxv8i64 : ValueType<512, 88>;  // n x  8 x i64 vector value
def nxv16i64: ValueType<1024,89>;  // n x 16 x i64 vector value
def nxv32i64: ValueType<2048,90>;  // n x 32 x i64 vector value

def v2f16  : ValueType<32 , 91>;   //  2 x f16 vector value
def v4f16  : ValueType<64 , 92>;   //  4 x f16 vector value
def v8f16  : ValueType<128, 93>;   //  8 x f16 vector value
def v1f32  : ValueType<32 , 94>;   //  1 x f32 vector value
def v3f32  : ValueType<96 , 95>;   //  3 x f32 vector value
def v2f32  : ValueType<64 , 96>;   //  2 x f32 vector value
def v4f32  : ValueType<128, 97>;   //  4 x f32 vector value
def v5f32  : ValueType<160, 98>;   //  5 x f32 vector value
def v8f32  : ValueType<256, 99>;   //  8 x f32 vector value
def v16f32 : ValueType<512, 100>;  // 16 x f32 vector value
def v256f32: ValueType<8192, 101>; // 256 x f32 vector value
def v512f32: ValueType<16384,102>; // 512 x f32 vector value
def v1f64  : ValueType<64,  103>;  //  1 x f64 vector value
def v2f64  : ValueType<128, 104>;  //  2 x f64 vector value
def v4f64  : ValueType<256, 105>;  //  4 x f64 vector value
def v8f64  : ValueType<512, 106>;  //  8 x f64 vector value
def v256f64: ValueType<16384,107>; // 256 x f64 vector value

def nxv2f16  : ValueType<32 , 108>; // n x  2 x f16 vector value
def nxv4f16  : ValueType<64 , 109>; // n x  4 x f16 vector value
def nxv8f16  : ValueType<128, 110>; // n x  8 x f16 vector value
def nxv1f32  : ValueType<32 , 111>; // n x  1 x f32 vector value
def nxv2f32  : ValueType<64 , 112>; // n x  2 x f32 vector value
def nxv4f32  : ValueType<128, 113>; // n x  4 x f32 vector value
def nxv8f32  : ValueType<256, 114>; // n x  8 x f32 vector value
def nxv16f32 : ValueType<512, 115>; // n x 16 x f32 vector value
def nxv1f64  : ValueType<64,  116>; // n x  1 x f64 vector value
def nxv2f64  : ValueType<128, 117>; // n x  2 x f64 vector value
def nxv4f64  : ValueType<256, 118>; // n x  4 x f64 vector value
def nxv8f64  : ValueType<512, 119>; // n x  8 x f64 vector value

def x86mmx : ValueType<64 , 120>;   // X86 MMX value
def FlagVT : ValueType<0  , 121>;   // Pre-RA sched glue
def isVoid : ValueType<0  , 122>;   // Produces no value
def untyped: ValueType<8  , 123>;   // Produces an untyped value
def ExceptRef: ValueType<0, 124>;   // WebAssembly's except_ref type
def token  : ValueType<0  , 248>;   // TokenTy
def MetadataVT: ValueType<0, 249>;  // Metadata

// Pseudo valuetype mapped to the current pointer size to any address space.
// Should only be used in TableGen.
def iPTRAny   : ValueType<0, 250>;

// Pseudo valuetype to represent "vector of any size"
def vAny   : ValueType<0  , 251>;

// Pseudo valuetype to represent "float of any format"
def fAny   : ValueType<0  , 252>;

// Pseudo valuetype to represent "integer of any bit width"
def iAny   : ValueType<0  , 253>;

// Pseudo valuetype mapped to the current pointer size.
def iPTR   : ValueType<0  , 254>;

// Pseudo valuetype to represent "any type of any size".
def Any    : ValueType<0  , 255>;

/// This class is for targets that want to use pointer types in patterns
/// with the GlobalISelEmitter.  Targets must define their own pointer
/// derived from this class.  The scalar argument should be an
/// integer type with the same bit size as the ponter.
/// e.g. def p0 : PtrValueType <i64, 0>;

class PtrValueType <ValueType scalar, int addrspace> :
    ValueType<scalar.Size, scalar.Value> {
  int AddrSpace = addrspace;
}
