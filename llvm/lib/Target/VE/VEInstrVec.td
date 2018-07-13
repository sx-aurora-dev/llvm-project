//===----------------------------------------------------------------------===//
// Vector Instructions
//===----------------------------------------------------------------------===//

class RV<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
        InstrItinClass itin = NoItinerary> 
    : InstVE<outs, ins, asmstr, pattern, itin> {
    bits<1> cx = 0;
    bits<1> cx2 = 0;
    bits<1> cs = 0;   // y operand is scalar(1) or vector(0)
    bits<1> cs2 = 0;
    bits<1> cy = 0;   // y operand is register(1) or immediate(0)
    bits<8> vx;
    bits<7> sy;
    bits<8> vy;
    bits<8> vz;
    bits<8> vw;
    bits<4> m;
    let op = opVal;
    let Inst{8} = cx;
    let Inst{9} = cx2;
    let Inst{10} = cs;
    let Inst{11} = cs2;
    let Inst{15-12} = m;
    let Inst{16} = cy;
    let Inst{23-17} = sy;
    //let Inst{31-24}
    let Inst{39-32} = vx;
    let Inst{47-40} = vy;
    let Inst{55-48} = vz;
    let Inst{63-56} = vw;
    let Uses = [VL]; // vector length register
}

class PseudoVec<dag outs, dag ins, string asmstr, list<dag> pattern> 
  : Pseudo<outs, ins, asmstr, pattern> {
    let Uses = [VL]; // vector length register
  }


class RV2<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
        InstrItinClass itin = NoItinerary> 
      : RV<opVal, outs, ins, asmstr, pattern, itin> {
    let vz = 0;
    let vw = 0;
}

class RV3<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
        InstrItinClass itin = NoItinerary> 
      : RV<opVal, outs, ins, asmstr, pattern, itin> {
    let vw = 0;
}

multiclass RV3m<string opcStr, bits<8> opc, RegisterClass ScalarRC, RegisterClass MaskRC, Operand immOp> {
  // (set V64:$vx, (op (simm7:$sy or I64:$sy or V64:$vz), V64:$vz))
  // V64:$vx = (simm7:$sy or I64:$sy or V64:$vz) opc V64:$vz
  def i : RV3<opc, (outs V64:$vx), (ins immOp:$sy, V64:$vz),
    !strconcat(opcStr, " $vx,$sy,$vz"), []> {
      let cs = 1;
      let cs2 = 0;
      let cy = 0;
      let vy = 0;
      let m = 0;
    }
  def r : RV3<opc, (outs V64:$vx), (ins ScalarRC:$sy, V64:$vz),
    !strconcat(opcStr, " $vx,$sy,$vz"), []> {
      let cs = 1;
      let cs2 = 0;
      let cy = 1;
      let vy = 0;
      let m = 0;
    }
  def v : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz),
    !strconcat(opcStr, " $vx,$vy,$vz"), []> {
      let cs = 0;
      let cs2 = 0;
      let sy = 0;
      let m = 0;
    }
  def im : RV3<opc, (outs V64:$vx), (ins immOp:$sy, V64:$vz, MaskRC:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
      let cs = 1;
      let cs2 = 0;
      let vy = 0;
      let Constraints = "$vx = $vd";
    }
  def rm : RV3<opc, (outs V64:$vx), (ins ScalarRC:$sy, V64:$vz, MaskRC:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
      let cs = 1;
      let cs2 = 0;
      let cy = 1;
      let vy = 0;
      let Constraints = "$vx = $vd";
    }
  def vm : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, MaskRC:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$vy,$vz,$vm"), []> {
      let sy = 0;
      let Constraints = "$vx = $vd";
    }
}

multiclass RV3DIVBYSm<string opcStr, bits<8> opc, RegisterClass ScalarRC, RegisterClass MaskRC, Operand immOp>
{
  def i2 : RV3<opc, (outs V64:$vx), (ins V64:$vy, immOp:$sy),
    !strconcat(opcStr, " $vx,$vy,$sy"), []> {
      let cs = 1;
      let cs2 = 1;
      let cy = 0;
      let vy = 0;
      let m = 0;
    }
  def r2 : RV3<opc, (outs V64:$vx), (ins V64:$vy, ScalarRC:$sy),
    !strconcat(opcStr, " $vx,$vy,$sy"), []> {
      let cs = 1;
      let cs2 = 1;
      let cy = 1;
      let vy = 0;
      let m = 0;
    }
  def im2 : RV3<opc, (outs V64:$vx), (ins V64:$vy, immOp:$sy, MaskRC:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$vy,$sy,$vm"), []> {
      let cs = 1;
      let cs2 = 1;
      let vy = 0;
      let Constraints = "$vx = $vd";
    }
  def rm2 : RV3<opc, (outs V64:$vx), (ins V64:$vy, ScalarRC:$sy, MaskRC:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$vy,$sy,$vm"), []> {
      let cs = 1;
      let cs2 = 1;
      let cy = 1;
      let vy = 0;
      let Constraints = "$vx = $vd";
    }
}

// Fused
multiclass RV4m<string opcStr, bits<8> opc, RegisterClass ScalarRC> {
  // V64:$vx = (simm7:$sy or I64:$sy or V64:$vz) opc V64:$vz
  def v : RV<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw),
    !strconcat(opcStr, " $vx,$vy,$vz,$vw"), []> {
      let cs = 0;
      let cs2 = 0;

      let sy = 0;
      let m = 0;
    }
  def i : RV<opc, (outs V64:$vx), (ins simm7Op64:$sy, V64:$vz, V64:$vw),
    !strconcat(opcStr, " $vx,$sy,$vz,$vw"), []> {
      let cs = 1;
      let cs2 = 0;
      let cy = 0;

      let vy = 0;
      let m = 0;
    }
  def r : RV<opc, (outs V64:$vx), (ins ScalarRC:$sy, V64:$vz, V64:$vw),
    !strconcat(opcStr, " $vx,$sy,$vz,$vw"), []> {
      let cs = 1;
      let cs2 = 0;
      let cy = 1;

      let vy = 0;
      let m = 0;
    }
  def i2 : RV<opc, (outs V64:$vx), (ins V64:$vy, simm7Op64:$sy, V64:$vw),
    !strconcat(opcStr, " $vx,$vy,$sy,$vw"), []> {
      let cs = 0;
      let cs2 = 1;
      let cy = 0;

      let vy = 0;
      let m = 0;
    }
  def r2 : RV<opc, (outs V64:$vx), (ins V64:$vy, ScalarRC:$sy, V64:$vw),
    !strconcat(opcStr, " $vx,$vy,$sy,$vw"), []> {
      let cs = 0;
      let cs2 = 1;
      let cy = 1;

      let vy = 0;
      let m = 0;
    }
}

// u64, u32
multiclass RVLWm<string opcStr, bits<8> opc> {
  let cx2 = 0 in defm l : RV3m<opcStr # ".l", opc, I64, VM, simm7Op64>; // u64
  let cx2 = 1 in defm w : RV3m<opcStr # ".w", opc, I32, VM, simm7Op32>; // u32
}

// i32 (sz,zx)
multiclass RVEXm<string opcStr, bits<8> opc> {
  let cx2 = 0 in defm wsx : RV3m<opcStr # ".w.sx", opc, I32, VM, simm7Op32>; // i32 sx
  let cx2 = 1 in defm wzx : RV3m<opcStr # ".w.zx", opc, I32, VM, simm7Op32>; // i32 zx
}

// u64, u32, packed u32
multiclass RVUm<string opcStr, bits<8> opc> {
  let cx = 0, cx2 = 0 in defm l : RV3m<opcStr # ".l", opc, I64, VM, simm7Op64>; // u64
  let cx = 0, cx2 = 1 in defm w : RV3m<opcStr # ".w", opc, I32, VM, simm7Op32>; // u32
  let cx = 1, cx2 = 1 in defm p : RV3m<"p" # opcStr, opc, I64, VM512, simm7Op32>; // packed u32
}

// i32 (sz,zx), packed i32
multiclass RVWm<string opcStr, bits<8> opc> {
  let cx = 0, cx2 = 0 in defm wsx : RV3m<opcStr # ".w.sx", opc, I32, VM, simm7Op32>; // i32 sx
  let cx = 0, cx2 = 1 in defm wzx : RV3m<opcStr # ".w.zx", opc, I32, VM, simm7Op32>; // i32 zx
  let cx = 1, cx2 = 1 in defm p : RV3m<"p" # opcStr, opc, I64, VM512, simm7Op32>;       // packed i32
}

// i64
multiclass RVLm<string opcStr, bits<8> opc> {
  defm l : RV3m<opcStr # ".l", opc, I64, VM, simm7Op64>;
}

// f64, f32, packed f32
multiclass RVDSPm<string opcStr, bits<8> opc> {
  // last argument should not be used...
  let cx = 0, cx2 = 0 in defm d : RV3m<opcStr # ".d", opc, I64, VM, simm7Op64>; // double
  let cx = 1, cx2 = 0 in defm s : RV3m<opcStr # ".s", opc, F32, VM, simm7Op64>; // float
  let cx = 1, cx2 = 1 in defm p : RV3m<"p" # opcStr, opc, I64, VM512, simm7Op64>; // packed
}

// f64, f32, packed f32 (4 operands)
multiclass RV4DSPm<string opcStr, bits<8> opc> {
  let cx = 0, cx2 = 0 in defm d : RV4m<opcStr # ".d", opc, I64>; // double
  let cx = 1, cx2 = 0 in defm s : RV4m<opcStr # ".s", opc, F32>; // float
  let cx = 1, cx2 = 1 in defm p : RV4m<"p" # opcStr, opc, I64>; // packed
}

multiclass RVLOGm<string opcStr, bits<8> opc> {
  def v : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz),
    !strconcat(opcStr, " $vx,$vy,$vz"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 0;
      let m = 0;
  }

  def r : RV3<opc, (outs V64:$vx), (ins I64:$sy, V64:$vz),
    !strconcat(opcStr, " $vx,$sy,$vz"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 1;
      let cy = 1;
      let m = 0;
  }

  def i0 : RV3<opc, (outs V64:$vx), (ins uimm6Op64:$sy, V64:$vz),
    !strconcat(opcStr, " $vx,(${sy})0,$vz"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 1;
      let cy = 0;
      let sy{6} = 1;
      let m = 0;
  }

  def i1 : RV3<opc, (outs V64:$vx), (ins uimm6Op64:$sy, V64:$vz),
    !strconcat(opcStr, " $vx,(${sy})1,$vz"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 1;
      let cy = 0;
      let m = 0;
  }

  def pv : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz),
    !strconcat("p", opcStr, " $vx,$vy,$vz"), []> {
      let cx = 1;
      let cx2 = 1;
      let cs = 0;
      let m = 0;
  }

  def pr : RV3<opc, (outs V64:$vx), (ins I64:$sy, V64:$vz),
    !strconcat("p", opcStr, " $vx,$sy,$vz"), []> {
      let cx = 1;
      let cx2 = 1;
      let cs = 1;
      let cy = 1;
      let m = 0;
  }

  def vm : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$vy,$vz,$vm"), []> {
    let cx = 0;
    let cx2 = 0;
    let cs = 0;
    let Constraints = "$vx = $vd";
  }

  def rm : RV3<opc, (outs V64:$vx), (ins I64:$vy, V64:$vz, VM:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$vy,$vz,$vm"), []> {
    let cx = 0;
    let cx2 = 0;
    let cs = 1;
    let cy = 1;
    let Constraints = "$vx = $vd";
  }

  // TODO: im0, im1

  def pvm : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm, V64:$vd),
    !strconcat("p", opcStr, " $vx,$vy,$vz,$vm"), []> {
      let cx = 1;
      let cx2 = 1;
      let cs = 0;
      let Constraints = "$vx = $vd";
  }

  def prm : RV3<opc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512:$vm, V64:$vd),
    !strconcat("p", opcStr, " $vx,$sy,$vz,$vm"), []> {
      let cx = 1;
      let cx2 = 1;
      let cs = 1;
      let cy = 1;
      let Constraints = "$vx = $vd";
  }
}

multiclass RVShiftMulti<string opcStr, bits<8> opc> {
  def v : RV3<opc, (outs V64:$vx), (ins V64:$vz, V64:$vy),
    !strconcat(opcStr, " $vx,$vz,$vy"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 0;
      let m = 0;
  }

  // vvs is r2
  def r2 : RV3<opc, (outs V64:$vx), (ins V64:$vz, I64:$sy),
    !strconcat(opcStr, " $vx,$vz,$sy"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 1;
      let cy = 1;
      let m = 0;
  }

  // why uimm6Op32 does not work?
  def i2 : RV3<opc, (outs V64:$vx), (ins V64:$vz, uimm6Op64:$sy),
    !strconcat(opcStr, " $vx,$vz,$sy"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 1;
      let cy = 0;
      let m = 0;
  }

  def pv : RV3<opc, (outs V64:$vx), (ins V64:$vz, V64:$vy),
    !strconcat("p", opcStr, " $vx,$vz,$vy"), []> {
      let cx = 1;
      let cx2 = 1;
      let cs = 0;
      let m = 0;
  }

  def pr2 : RV3<opc, (outs V64:$vx), (ins V64:$vz, I64:$sy),
    !strconcat("p", opcStr, " $vx,$vz,$sy"), []> {
      let cx = 1;
      let cx2 = 1;
      let cs = 1;
      let cy = 1;
      let m = 0;
  }

  def vm : RV3<opc, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$vz,$vy,$vm"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 0;
      let Constraints = "$vx = $vd";
  }

  def rm2 : RV3<opc, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$vz,$sy,$vm"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 1;
      let cy = 1;
      let Constraints = "$vx = $vd";
  }

  def im2 : RV3<opc, (outs V64:$vx), (ins V64:$vz, uimm6Op64:$sy, VM:$vm, V64:$vd),
    !strconcat(opcStr, " $vx,$vz,$sy,$vm"), []> {
      let cx = 0;
      let cx2 = 0;
      let cs = 1;
      let cy = 0;
      let Constraints = "$vx = $vd";
  }

  def pvm : RV3<opc, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512:$vm, V64:$vd),
    !strconcat("p", opcStr, " $vx,$vz,$vy,$vm"), []> {
      let cx = 1;
      let cx2 = 1;
      let cs = 0;
      let Constraints = "$vx = $vd";
  }

  def prm2 : RV3<opc, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512:$vm, V64:$vd),
    !strconcat("p", opcStr, " $vx,$vz,$sy,$vm"), []> {
      let cx = 1;
      let cx2 = 1;
      let cs = 1;
      let cy = 1;
      let Constraints = "$vx = $vd";
  }
}

class RVM<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
        InstrItinClass itin = NoItinerary> 
    : InstVE<outs, ins, asmstr, pattern, itin> {
    bits<1> vo = 0; // overtake(?)
    bits<1> vc = 0; // cached(?) or uncached(?)
    bits<1> cs = 0; // use sw operand(1) or not(0)
    bits<1> cy = 0; // y operand is immediate(0) or register(1)
    bits<1> cz = 1; // z operand is zero(0) or register(1)
    bits<8> vx;
    bits<8> vy;
    bits<7> sy;
    bits<7> sz;
    bits<7> sw;
    let op = opVal;
    let Inst{8} = vo;
    let Inst{9} = vc;
    let Inst{16} = cy;
    let Inst{23-17} = sy;
    let Inst{24} = cz;
    let Inst{31-25} = sz;
    let Inst{39-32} = vx;
    let Inst{47-40} = vy;
    let Inst{63-57} = sw;
    let Uses = [VL]; // vector length register
}

// VLD, VST
class RVM0<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
        InstrItinClass itin = NoItinerary> 
    : RVM<opVal, outs, ins, asmstr, pattern, itin> {
      let vy = 0;
      let sw = 0;
}

// 5.3.2.7. Vector Transfer Instructions

multiclass VLDm<string opcStr, bits<8> opc> {
  def rr : RVM0<opc, (outs V64:$vx), (ins I64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,$sz"), []> {
      let vc = 0;
      let cy = 1;
  }
  def ir : RVM0<opc, (outs V64:$vx), (ins simm7Op64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,$sz"), []> {
      let vc = 0;
      let cy = 0;
  }
  def rz : RVM0<opc, (outs V64:$vx), (ins simm7Op64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,0"), []> {
      let vc = 0;
      let cy = 1;
      let cz = 0;
  }
  def iz : RVM0<opc, (outs V64:$vx), (ins I64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,0"), []> {
      let vc = 0;
      let cy = 0;
      let cz = 0;
  }
}

multiclass VSTm<string opcStr, bits<8> opc> {
  def rr : RVM0<opc, (outs), (ins V64:$vx, I64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,$sz"), []> {
      let vc = 0;
      let cy = 1;
  }
  def ir : RVM0<opc, (outs), (ins V64:$vx, simm7Op64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,$sz"), []> {
      let vc = 0;
      let cy = 0;
  }
  def rz : RVM0<opc, (outs), (ins V64:$vx, simm7Op64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,0"), []> {
      let vc = 0;
      let cy = 1;
      let cz = 0;
  }
  def iz : RVM0<opc, (outs), (ins V64:$vx, I64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,0"), []> {
      let vc = 0;
      let cy = 0;
      let cz = 0;
  }
}

defm VLD : VLDm<"vld", 0x81>;
defm VLDU : VLDm<"vldu", 0x82>;
let vo = 0 in defm VLDLsx : VLDm<"vldl.sx", 0x83>;
let vo = 1 in defm VLDLzx : VLDm<"vldl.zx", 0x83>;

defm VLD2D  : VLDm<"vld2d", 0xC1>;
defm VLDU2D : VLDm<"vldu2d", 0xC2>;
let vo = 0 in defm VLDL2Dsx : VLDm<"vldl2d.sx", 0xC3>;
let vo = 1 in defm VLDL2Dzx : VLDm<"vldl2d.zx", 0xC3>;

defm VST : VSTm<"vst", 0x91>;
defm VSTU : VSTm<"vstu", 0x92>;
defm VSTL : VSTm<"vstl", 0x93>;

defm VST2D  : VSTm<"vst2d", 0xD1>;
defm VSTU2D : VSTm<"vstu2d", 0xD2>;
defm VSTL2D : VSTm<"vstl2d", 0xD3>;

def LSVr : RR<0x8E, (outs V64:$dst), (ins V64:$vx, I32:$sy, I64:$sz), 
  "lsv ${vx}(${sy}),$sz", []> {
    let cy = 1;
    let Constraints = "$dst = $vx";
}
def LSVi : RR<0x8E, (outs V64:$dst), (ins V64:$vx, simm7Op32:$sy, I64:$sz),
  "lsv ${vx}(${sy}),$sz", []> {
    let Constraints = "$dst = $vx";
}

let cx = 0, sx = 0, cy = 1, cz = 0, sz = 0 in
def LVSr : RR<0x9E, (outs I64:$sx), (ins V64:$vx, I64:$sy),
  "lvs ${sx},${vx}(${sy})", []>;

let cx = 0, sx = 0, cy = 1, cz = 0, sz = 0, isCodeGenOnly = 1 in
def LVSi64r : RR<0x9E, (outs I64:$sx), (ins V64:$vx, I32:$sy),
  "lvs ${sx},${vx}(${sy})", []>;

let cx = 0, sx = 0, cy = 1, cz = 0, sz = 0, isCodeGenOnly = 1 in
def LVSf64r : RR<0x9E, (outs I64:$sx), (ins V64:$vx, I32:$sy),
  "lvs ${sx},${vx}(${sy})", []>;

let cx = 0, sx = 0, cy = 1, cz = 0, sz = 0, isCodeGenOnly = 1 in
def LVSf32r : RR<0x9E, (outs F32:$sx), (ins V64:$vx, I32:$sy),
  "lvs ${sx},${vx}(${sy})", []>;

def : Pat<(f32 (int_ve_lvs_svs_f32 v256f64:$vx, i32:$sy)), 
          (EXTRACT_SUBREG (LVSr v256f64:$vx,
            (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32)), sub_f32)>;

let cy = 1 in
def LVMr : RR<0xB7, (outs VM:$vmx), (ins VM:$vmd, I64:$sy, I64:$sz),
  "lvm $vmx,$sy,$sz", []> {
  let Constraints = "$vmx = $vmd";
}

let cy = 0 in
def LVMi : RR<0xB7, (outs VM:$vmx), (ins VM:$vmd, uimm6Op64:$sy, I64:$sz),
  "lvm $vmx,$sy,$sz", []> {
  let Constraints = "$vmx = $vmd";
}

def LVMpi : Pseudo<(outs VM512:$vmx), (ins VM512:$vmd, uimm6Op64:$sy, I64:$sz),
  "# lvm $vmx,$sy,$sz", []> {
  let Constraints = "$vmx = $vmd";
}

let cy = 1 in
def SVMr : RR<0xA7, (outs I64:$sx), (ins VM:$vmx, I64:$sy), "svm $sx,$vmx,$sy", []>;

let cy = 0 in 
def SVMi : RR<0xA7, (outs I64:$sx), (ins VM:$vmx, uimm6Op64:$sy), "svm $sx,$vmx,$sy", []>;

def SVMpi : Pseudo<(outs I64:$sx), (ins VM512:$vmx, uimm6Op64:$sy), "# svm+svm", []>;

multiclass VBRDm<string opcStr, bits<8> opc, RegisterClass MaskRC, RegisterClass RCi, Operand immOp> {
  def r : RV2<opc, (outs V64:$vx), (ins RCi:$sy), 
    !strconcat(opcStr, " $vx,$sy"), []> {
      let cy = 1;
      let vy = 0;
      let m = 0;
  }
  def i : RV2<opc, (outs V64:$vx), (ins immOp:$sy), 
    !strconcat(opcStr, " $vx,$sy"), []> {
      let cy = 0;
      let vy = 0;
      let m = 0;
  }

  def rm : RV2<opc, (outs V64:$vx), (ins RCi:$sy, MaskRC:$vm, V64:$vd), 
    !strconcat(opcStr, " $vx,$sy,$vm"), []> {
      let cy = 1;
      let vy = 0;
      let Constraints = "$vx = $vd";
  }

  def im : RV2<opc, (outs V64:$vx), (ins immOp:$sy, MaskRC:$vm, V64:$vd), 
    !strconcat(opcStr, " $vx,$sy,$vm"), []> {
      let cy = 0;
      let vy = 0;
      let Constraints = "$vx = $vd";
  }
}

let cx = 0, cx2 = 0 in defm VBRD : VBRDm<"vbrd", 0x8C, VM, I64, simm7Op64>;   // 64b
let cx = 1, cx2 = 0 in defm VBRDl : VBRDm<"vbrdl", 0x8C, VM, I64, simm7Op64>; // 32b lower (= i32/u32)
let cx = 0, cx2 = 1 in defm VBRDu : VBRDm<"vbrdu", 0x8C, VM, I64, simm7Op64>; // 32b uppper(= f32)
let cx = 1, cx2 = 1 in defm VBRDp : VBRDm<"pvbrd", 0x8C, VM512, I64, simm7Op64>; // 32b packed

let cx = 0, cx2 = 0, isCodeGenOnly = 1 in defm VBRDf64 : VBRDm<"vbrd", 0x8C, VM, I64, simm7Op64>;
let cx = 0, cx2 = 0, isCodeGenOnly = 1 in defm VBRDf32 : VBRDm<"vbrdu", 0x8C, VM, F32, simm7Op64>;
let cx = 0, cx2 = 0, isCodeGenOnly = 1 in defm VBRDi32 : VBRDm<"vbrdl", 0x8C, VM, I32, simm7Op32>;

def VMVr : RV<0x9C, (outs V64:$vx), (ins I32:$sy, V64:$vz),
  "vmv $vx,$sy,$vz", []> {
    let cy = 1;
    let vy = 0;
  }

def VMVi : RV<0x9C, (outs V64:$vx), (ins simm7Op32:$sy, V64:$vz),
  "vmv $vx,$sy,$vz", []> {
    let cy = 0;
    let vy = 0;
  }

// 5.3.2.8. Vector Fixed-Point Arithmetic Operation Instructions
defm VADD : RVUm<"vaddu", 0xC8>;
defm VADS : RVWm<"vadds", 0xCA>;
defm VADX : RVLm<"vadds", 0x8B>;
defm VSUB : RVUm<"vsubu", 0xD8>;
defm VSBS : RVWm<"vsubs", 0xDA>;
defm VSBX : RVLm<"vsubs", 0x9B>;
defm VMPY : RVLWm<"vmulu", 0xC9>;   // mul unsigned 64b/32b
defm VMPS : RVEXm<"vmuls", 0xCB>; // mul signed 32b sx/zx
defm VMPX : RVLm<"vmuls", 0xDB>;   // mul signed 64b
defm VMPD : RV3m<"vmuls.l.w", 0xD9, I32, VM, simm7Op32>; // mul signed 32b -> 64b

defm VDIV : RVLWm<"vdivu", 0xE9>;
let cx2 = 0 in defm VDIVl : RV3DIVBYSm<"vdivu.l", 0xE9, I64, VM, simm7Op64>;
let cx2 = 1 in defm VDIVw : RV3DIVBYSm<"vdivu.w", 0xE9, I32, VM, simm7Op32>;
defm VDVS : RVEXm<"vdivs", 0xEB>;
let cx2 = 0 in defm VDVSwsx : RV3DIVBYSm<"vdivs.w.sx", 0xEB, I32, VM, simm7Op32>;
let cx2 = 1 in defm VDVSwzx : RV3DIVBYSm<"vdivs.w.zx", 0xEB, I32, VM, simm7Op32>;
defm VDVX : RVLm<"vdivs", 0xFB>;
defm VDVXl : RV3DIVBYSm<"vdivs.l", 0xFB, I64, VM, simm7Op64>;
defm VCMP : RVUm<"vcmpu", 0xB9>;
defm VCPS : RVWm<"vcmps", 0xFA>;
defm VCPX : RVLm<"vcmps", 0xBA>;
// CMS
// CMX

// 5.3.2.9. Vector Logical Arithmetic Operation Instructions
defm VAND : RVLOGm<"vand", 0xC4>;
defm VOR  : RVLOGm<"vor", 0xC5>;
defm VXOR : RVLOGm<"vxor", 0xC6>;
defm VEQV : RVLOGm<"veqv", 0xC7>;

multiclass VSEQm<string opcStr> {
  def v : RV<0x99, (outs V64:$vx), (ins), !strconcat(opcStr, " $vx"), []> {
    let vy = 0;
    let vz = 0;
    let vw = 0;
    let m = 0;
    let sy = 0;
  }
}

let cx = 0, cx2 = 0 in defm VSEQ : VSEQm<"vseq">;
let cx = 0, cx2 = 1 in defm VSEQl : VSEQm<"pvseq.lo">;
let cx = 1, cx2 = 0 in defm VSEQu : VSEQm<"pvseq.up">;
let cx = 1, cx2 = 1 in defm VSEQp : VSEQm<"pvseq">;

// 5.3.2.10. Vector Shift Instructions
defm VSLL : RVShiftMulti<"vsll", 0xE5>;
// VSLD
defm VSRL : RVShiftMulti<"vsrl", 0xF5>;
// VSRD
// VSLA
// VSLAX
// VSRA
// VSRAX
let cy = 0, vy = 0 in
def VSFAr : RV<0xD7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$sy, I64:$sz),
  "vsfa $vx,$vz,$sy,$sz", []>;
let cy = 1, vy = 0 in
def VSFAi : RV<0xD7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz),
  "vsfa $vx,$vz,$sy,$sz", []>;


// 5.3.2.11 Vector Floating-Point Arithmetic Operation Instructions

multiclass VRCPm<string opcStr, bits<8> opc> {
  def dv : RV2<opc, (outs V64:$vx), (ins V64:$vy), 
    !strconcat(opcStr, ".d $vx,$vy"), []> {
      let cy = 1;
      let sy = 0;
  }

  def sv : RV2<opc, (outs V64:$vx), (ins V64:$vy), 
    !strconcat(opcStr, ".s $vx,$vy"), []> {
      let cx = 1;
      let cy = 1;
      let sy = 0;
  }

  def pv : RV2<opc, (outs V64:$vx), (ins V64:$vy), 
    !strconcat("p"#opcStr, " $vx,$vy"), []> {
      let cx = 1;
      let cx2 = 1;
      let cy = 1;
      let sy = 0;
  }
}

defm VFAD : RVDSPm<"vfadd", 0xCC>;
defm VFSB : RVDSPm<"vfsub", 0xDC>;
defm VFMP : RVDSPm<"vfmul", 0xCD>;
defm VFDV : RVDSPm<"vfdiv", 0xDD>;
// VFSQRT
defm VFCP : RVDSPm<"vfcmp", 0xFC>;
let cs2 = 0 in defm VFCMa : RVDSPm<"vfmax", 0xBD>;
let cs2 = 1 in defm VFCMi : RVDSPm<"vfmin", 0xBD>;
defm VFMAD : RV4DSPm<"vfmad", 0xE2>;
defm VFMSB : RV4DSPm<"vfmsb", 0xF2>;
defm VFNMAD : RV4DSPm<"vfnmad", 0xE3>;
defm VFNMSB : RV4DSPm<"vfnmsb", 0xF3>;
defm VRCP : VRCPm<"vrcp", 0xE1>;
// VRSQRT
// VFIX
// VFIXX
// VFLTX

multiclass VCVT<bits<8>opc, string opcStr> {
  def v : RV2<opc, (outs V64:$vx), (ins V64:$vy), 
    !strconcat(opcStr, " $vx,$vy"), []>;
}

multiclass RDm<bits<8> opc, string opcStr> {
  let vz = 8 in defm rz : VCVT<opc, !strconcat(opcStr, ".rz")>;
}

defm VFIXXrz : RDm<0xA8, "vcvt.l.d">;
let cx = 0, cx2 = 0, cs2 = 0 in defm VFLTd : VCVT<0xF8, "vcvt.d.w">;
let cx = 1, cx2 = 0, cs2 = 1 in defm VFLTs : VCVT<0xF8, "vcvt.s.w">;
let cx = 1, cx2 = 1, cs2 = 1 in defm VFLTp : VCVT<0xF8, "pvcvt.s.w">;
defm VFLTX : VCVT<0xB8, "vcvt.d.l">;
defm VCVD : VCVT<0x8F, "vcvt.d.s">;
defm VCVS : VCVT<0x9F, "vcvt.s.d">;

// 5.3.2.12. Vector Mask Arithmetic Instructions

let cx = 0, cs = 1 in
def VMRGvm : RV<0xD6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm),
  "vmrg $vx,$vy,$vz,$vm", []>;
let cx = 1, cs = 1 in
def VMRGpvm : RV<0xD6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512:$vm),
  "vmrg.w $vx,$vy,$vz,$vm", []>;

let cy = 0 in
def VSHFi : RV3<0xBC, (outs V64:$vx), (ins V64:$vy, V64:$vz, uimm6Op64:$sy),
  "vshf $vx,$vy,$vz,$sy", []>;
let cy = 1 in
def VSHFr : RV3<0xBC, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy),
  "vshf $vx,$vy,$vz,$sy", []>;

class VCPEX<bits<8> opc, string opcStr> 
  : RV<opc, (outs V64:$vx), (ins V64:$vz, VM:$vm, V64:$vd),
  !strconcat(opcStr, " $vx,$vz,$vm"), []> {
    let vy = 0;
    let Constraints = "$vx = $vd";
}

def VCP : VCPEX<0x8D, "vcp">;
def VEX : VCPEX<0x9D, "vex">;

multiclass VFMKm<string opcStr, bits<8> opc> {
  def v : RV<opc, (outs VM:$vm), (ins CCOp:$cf, V64:$vz),
    !strconcat(opcStr, ".${cf} $vm,$vz"), []> {
      let sy = 0;
      let vw = 0;
      let m = 0;
    }

  def vm : RV<opc, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm),
    !strconcat(opcStr, ".${cf} $vmx,$vz,$vm"), []> {
      let sy = 0;
      let vw = 0;
    }
}

let cx = 0 in defm VFMK : VFMKm<"vfmk.l", 0xB4>;
let cx = 0 in defm VFMS : VFMKm<"vfmk.w", 0xB5>;
let cx = 1 in defm VFMSu : VFMKm<"pvfmk.w.up", 0xB5>;
let cx = 0, cx2 = 0 in defm VFMFd : VFMKm<"vfmk.d", 0xB6>;
let cx = 1, cx2 = 0 in defm VFMFs : VFMKm<"vfmk.s", 0xB6>;
let cx = 0, cx2 = 1 in defm VFMFl : VFMKm<"pvfmk.s.lo", 0xB6>;

// at and af 64b
let sy = 0, vy = 0xf, vz = 0, vw = 0, m = 0 in
def VFMKat : RV<0xB4, (outs VM:$vm), (ins), "vfmk.l.at $vm", []>;

let sy = 0, vy = 0x0, vz = 0, vw = 0, m = 0 in
def VFMKaf : RV<0xB4, (outs VM:$vm), (ins), "vfmk.l.af $vm", []>;

// at and af for 32b lower and upper
let cx = 0, sy = 0, vy = 0xf, vz = 0, vw = 0, m = 0 in
def VFMSuat : RV<0xB5, (outs VM:$vm), (ins), "pvfmk.w.up.at $vm", []>;
let cx = 1, sy = 0, vy = 0xf, vz = 0, vw = 0, m = 0 in
def VFMSlat : RV<0xB5, (outs VM:$vm), (ins), "vfmk.w.at $vm", []>;
let cx = 0, sy = 0, vy = 0x0, vz = 0, vw = 0, m = 0 in
def VFMSuaf : RV<0xB5, (outs VM:$vm), (ins), "pvfmk.w.up.af $vm", []>;
let cx = 1, sy = 0, vy = 0x0, vz = 0, vw = 0, m = 0 in
def VFMSlaf : RV<0xB5, (outs VM:$vm), (ins), "vfmk.w.af $vm", []>;

// Pseudo for VM512
def VFMSpv : PseudoVec<(outs VM512:$vm), (ins CCOp:$cf, V64:$vz), 
                    "# pvfmk.w.${cf} $vm,$vz", []>;

def VFMFpv : PseudoVec<(outs VM512:$vm), (ins CCOp:$cf, V64:$vz), 
                    "# pvfmk.w.${cf} $vm,$vz", []>;

def VFMKpat : PseudoVec<(outs VM512:$vm), (ins), "# pvfmk.at", []>;
def VFMKpaf : PseudoVec<(outs VM512:$vm), (ins), "# pvfmk.af", []>;


// 5.3.2.13. Vector Recursive Relation Instructions
multiclass RVRECm<string opcStr, bits<8> opc> {
  def v : RV2<opc, (outs V64:$vx), (ins V64:$vy),
    !strconcat(opcStr, " $vx,$vy"), []> {
      let sy = 0;
    }
}
let cx2 = 0 in defm VSUMSsx : RVRECm<"vsum.w.sx", 0xEA>;
let cx2 = 1 in defm VSUMSzx : RVRECm<"vsum.w.zx", 0xEA>;
defm VSUMX : RVRECm<"vsum.l", 0xAA>;
let cx = 0 in defm VFSUMd : RVRECm<"vfsum.d", 0xEC>;
let cx = 1 in defm VFSUMs : RVRECm<"vfsum.s", 0xEC>;

multiclass FLSXm<bits<8> opc, string opcStr>
{
  let cx2 = 0, cs2 = 0 in defm fsx : RVRECm<opcStr#".fst.sx", opc>;
  let cx2 = 1, cs2 = 0 in defm fzx : RVRECm<opcStr#".fst.zx", opc>;
  let cx2 = 0, cs2 = 1 in defm lsx : RVRECm<opcStr#".lst.sx", opc>;
  let cx2 = 1, cs2 = 1 in defm lzx : RVRECm<opcStr#".lst.zx", opc>;
}

multiclass FLm<bits<8> opc, string opcStr>
{
  let cs2 = 0 in defm f : RVRECm<opcStr#".fst", opc>;
  let cs2 = 1 in defm l : RVRECm<opcStr#".lst", opc>;
}

let cs = 0 in defm VMAXSa : FLSXm<0xBB, "vrmaxs.w">;
let cs = 1 in defm VMAXSi : FLSXm<0xBB, "vrmins.w">;

let cs = 0 in defm VMAXXa : FLm<0xAB, "vrmaxs.l">;
let cs = 1 in defm VMAXXi : FLm<0xAB, "vrmins.l">;

let cx = 0, cs = 0 in defm VFMAXad : FLm<0xAD, "vfrmax.d">;
let cx = 1, cs = 0 in defm VFMAXas : FLm<0xAD, "vfrmax.s">;
let cx = 0, cs = 1 in defm VFMAXid : FLm<0xAD, "vfrmin.d">;
let cx = 1, cs = 1 in defm VFMAXis : FLm<0xAD, "vfrmin.s">;

// 5.3.2.14. Vector Gatering/Scattering Instructions

multiclass VGTm<string opcStr, bits<8> opc> {
  def v : RVM<opc, (outs V64:$vx), (ins V64:$vy),
    !strconcat(opcStr, " $vx,$vy,0,0"), []> {
      let sy = 0;
      let sz = 0;
      let sw = 0;
  }
}

multiclass VSCm<string opcStr, bits<8> opc> {
  def v : RVM<opc, (outs), (ins V64:$vx, V64:$vy),
    !strconcat(opcStr, " $vx,$vy,0,0"), []> {
      let sy = 0;
      let sz = 0;
      let sw = 0;
  }
}

defm VGT : VGTm<"vgt", 0xA1>;
defm VGTU : VGTm<"vgtu", 0xA2>;
let vo = 0 in defm VGTLsx : VGTm<"vgtl.sx", 0xA3>;
let vo = 1 in defm VGTLzx : VGTm<"vgtl.zx", 0xA3>;
defm VSC : VSCm<"vsc", 0xB1>;
defm VSCU : VSCm<"vscu", 0xB2>;
defm VSCL : VSCm<"vscl", 0xB3>;

// 5.3.2.15. Vector Mask Register Instructions

class VMR3<bits<8> op, string asm> 
  : RV<op, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
        !strconcat(asm, " $vmx,$vmy,$vmz"), []> {
  let sy = 0;
  let vw = 0;
  let m = 0;
}

class VMR2<bits<8> op, string asm> 
  : RV<op, (outs VM:$vmx), (ins VM:$vmy),
        !strconcat(asm, " $vmx,$vmy"), []> {
  let sy = 0;
  let vz = 0;
  let vw = 0;
  let m = 0;
}

class VMR1<bits<8> op, string asm> 
  : RV<op, (outs I64:$sx), (ins VM:$vmy), !strconcat(asm, " $sx,$vmy"),  []> {
    let sy = 0;
    let vx = 0;
    let vz = 0;
    let vw = 0;
    let m = 0;
}

def ANDM : VMR3<0x84, "andm">;
def ORM :  VMR3<0x85, "orm">;
def XORM : VMR3<0x86, "xorm">;
def EQVM : VMR3<0x87, "eqvm">;
def NNDM : VMR3<0x94, "nndm">;
def NEGM : VMR2<0x95, "negm">;
def PCVM : VMR1<0xA4, "pcvm">;
def LZVM : VMR1<0xA5, "lzvm">;
def TOVM : VMR1<0xA6, "tovm">;

def ANDMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
def ORMp  : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
def XORMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
def EQVMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
def NNDMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
def NEGMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy), "", []>;

// 5.3.2.16. Vector Control Instructions
// SVL
// SMVL
// LVIX

let cx = 0, sx = 0, cy = 0, cz = 0, sz = 0, Defs = [VL] in
def LVL : RR<0xBF, (outs), (ins I32:$sy), "lvl $sy", []>;

// Pattern Matchings for Vector Instructions

def : Pat<(v256f64 (load ADDRri:$addr)), 
          (v256f64 (VLDir 8, (LEAasx ADDRri:$addr)))>;

def : Pat<(v512f32 (load ADDRri:$addr)), 
          (v512f32 (VLDir 8, (LEAasx ADDRri:$addr)))>;

def : Pat<(store v256f64:$vx, ADDRri:$addr), 
          (VSTir v256f64:$vx, 8, (LEAasx ADDRri:$addr))>;

def : Pat<(store v512f32:$vx, ADDRri:$addr), 
          (VSTir v512f32:$vx, 8, (LEAasx ADDRri:$addr))>;

def : Pat<(fadd v256f64:$vy, v256f64:$vz), (VFADdv v256f64:$vy, v256f64:$vz)>;
def : Pat<(fadd v512f32:$vy, v512f32:$vz), (VFADpv v512f32:$vy, v512f32:$vz)>;

// Pattern Matchings for Vector Intrinsics

def : Pat<(int_ve_lvl i32:$sy), (LVL i32:$sy)>;

def : Pat<(i64 (int_ve_pack_f32p ADDRri:$addr0, ADDRri:$addr1)),
          (ORrr (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
                               (LDUri MEMri:$addr0), sub_i32),
                (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
                               (LDLUri MEMri:$addr1), sub_i32))>;

def : Pat<(i64 (int_ve_pack_f32a ADDRri:$addr)),
          (i64 (MPYrr
            (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (LDLUri MEMri:$addr), sub_i32),
            (LEASLrzi (ANDrm0 (LEAzzi (LO32 (i64 0x0000000100000001))), 32),
                      (HI32 (i64 0x0000000100000001)))))>;


include "VEInstrIntrinsic.td"

