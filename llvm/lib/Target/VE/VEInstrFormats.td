//===-- VEInstrFormats.td - VE Instruction Formats ---------*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
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
  bits<1>  cx;
  bits<7>  sx;
  bits<1>  cy;
  bits<7>  sy;
  bits<1>  cz;
  bits<7>  sz;
  bits<32> imm32;
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
  let imm32 = 0;
}

class CF<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
         InstrItinClass itin = NoItinerary>
   : RM<opVal, outs, ins, asmstr, pattern, itin> {
  bits<2>  bpf;
  bits<4>  cf;
  let cx = 0;
  let sx{6} = 0;
  let sx{5-4} = bpf;
  let sx{3-0} = cf;
}

// Pseudo instructions.
class Pseudo<dag outs, dag ins, string asmstr, list<dag> pattern>
   : InstVE<outs, ins, asmstr, pattern> {
  let isCodeGenOnly = 1;
  let isPseudo = 1;
}
