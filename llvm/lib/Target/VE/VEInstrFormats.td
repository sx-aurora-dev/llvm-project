//===-- VEInstrFormats.td - VE Instruction Formats ---------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

class InstVE<dag outs, dag ins, string asmstr, list<dag> pattern,
             InstrItinClass itin = NoItinerary>
   : Instruction {
  field bits<64> Inst;

  let Namespace = "VE";
  let Size = 8;

  bits<8> op;
  let Inst{0-7} = op;

  dag OutOperandList = outs;
  dag InOperandList = ins;
  let AsmString   = asmstr;
  let Pattern = pattern;

  let DecoderNamespace = "VE";
  field bits<64> SoftFail = 0;
  
  let Itinerary = itin;
}

class RM<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
         InstrItinClass itin = NoItinerary>
   : InstVE<outs, ins, asmstr, pattern, itin> {
  bits<1>  cx = 0;
  bits<7>  sx;
  bits<1>  cy = 0;
  bits<7>  sy;
  bits<1>  cz = 0;
  bits<7>  sz;
  bits<32> imm32 = 0;
  let op = opVal;
  let Inst{15} = cx;
  let Inst{14-8} = sx;
  let Inst{23} = cy;
  let Inst{22-16} = sy;
  let Inst{31} = cz;
  let Inst{30-24} = sz;
  let Inst{63-32}  = imm32;
}

class RR<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
         InstrItinClass itin = NoItinerary>
   : RM<opVal, outs, ins, asmstr, pattern, itin> {
  bits<1> cw = 0;
  bits<1> cw2 = 0;
  bits<4> cfw = 0;
  let imm32{0-23} = 0;
  let imm32{24} = cw;
  let imm32{25} = cw2;
  let imm32{26-27} = 0;
  let imm32{28-31} = cfw;
}

class RRFENCE<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
              InstrItinClass itin = NoItinerary>
   : InstVE<outs, ins, asmstr, pattern, itin> {
  bits<1> avo = 0;
  bits<1> lf = 0;
  bits<1> sf = 0;
  bits<1> c2 = 0;
  bits<1> c1 = 0;
  bits<1> c0 = 0;
  let op = opVal;
  let Inst{15} = avo;
  let Inst{14-10} = 0;
  let Inst{9} = lf;
  let Inst{8} = sf;
  let Inst{23-19} = 0;
  let Inst{18} = c2;
  let Inst{17} = c1;
  let Inst{16} = c0;
  let Inst{31-24} = 0;
  let Inst{63-32} = 0;
}

class CF<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
         InstrItinClass itin = NoItinerary>
   : RM<opVal, outs, ins, asmstr, pattern, itin> {
  bits<1>  cx2;
  bits<2>  bpf;
  bits<4>  cf;
  let cx = 0;
  let sx{6} = cx2;
  let sx{5-4} = bpf;
  let sx{3-0} = cf;
}

// Pseudo instructions.
class Pseudo<dag outs, dag ins, string asmstr, list<dag> pattern>
   : InstVE<outs, ins, asmstr, pattern> {
  let isCodeGenOnly = 1;
  let isPseudo = 1;
}
