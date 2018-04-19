//===----------------------------------------------------------------------===//
// Vector Instructions
//===----------------------------------------------------------------------===//

class RV<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
        InstrItinClass itin = NoItinerary> 
    : InstVE<outs, ins, asmstr, pattern, itin> {
    bits<1> cx = 0;
    bits<1> cx2 = 0;
    bits<1> cs = 0;
    bits<1> cs2 = 0;
    bits<1> cy = 0;
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
    let Inst{31-24} = vw;
    let Inst{39-32} = vx;
    let Inst{47-40} = vy;
    let Inst{55-48} = vz;
}

multiclass RVm<string opcStr, bits<8> opc> {
  // V64:$vx = (simm7:$sy or I64:$sy or V64:$vz) opc V64:$vz
  def i : RV<opc, (outs V64:$vx), (ins simm7Op64:$sy, V64:$vz),
    !strconcat(opcStr, " $vx,$sy,$vz"), []> {
      let cs = 1;
      let cy = 0;

      let vy = 0;
      let vw = 0;
      let m = 0;
    }
  def r : RV<opc, (outs V64:$vx), (ins I64:$sy, V64:$vz),
    !strconcat(opcStr, " $vx,$sy,$vz"), []> {
      let cs = 1;
      let cy = 1;

      let vy = 0;
      let vw = 0;
      let m = 0;
    }
  def v : RV<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz),
    !strconcat(opcStr, " $vx,$vy,$vz"), []> {
      let cs = 0;
      let cy = 0;

      let sy = 0;
      let vw = 0;
      let m = 0;
    }

  def vm : RV<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM:$vm),
    !strconcat(opcStr, " $vx,$vy,$vz,$vm"), []> {
      let sy = 0;
      let vw = 0;
    }
}

// Fused
multiclass RVFm<string opcStr, bits<8> opc> {
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
  def r : RV<opc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw),
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
  def r2 : RV<opc, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw),
    !strconcat(opcStr, " $vx,$vy,$sy,$vw"), []> {
      let cs = 0;
      let cs2 = 1;
      let cy = 1;

      let vy = 0;
      let m = 0;
    }
}


multiclass RVLWm<string opcStr, bits<8> opc> {
  let cx2 = 0 in defm l : RVm<opcStr # ".l", opc>; // 64b
  let cx2 = 1 in defm w : RVm<opcStr # ".w", opc>; // 64b
}

// (sz,zx)
multiclass RVEXm<string opcStr, bits<8> opc> {
  let cx2 = 0 in defm l : RVm<opcStr # ".sx", opc>; // 64b
  let cx2 = 1 in defm w : RVm<opcStr # ".zx", opc>; // 64b
}

// RVUm: u64, u32, packed u32
multiclass RVUm<string opcStr, bits<8> opc> {
  let cx = 0, cx2 = 0 in defm l : RVm<opcStr # ".l", opc>; // 64b
  let cx = 0, cx2 = 1 in defm w : RVm<opcStr # ".w", opc>; // 32b
  let cx = 1, cx2 = 1 in defm p : RVm<"p" # opcStr, opc>; // packed
}

// RVWPm: i32-ex, i32-zx, packed i32
multiclass RVWm<string opcStr, bits<8> opc> {
  let cx = 0, cx2 = 0 in defm wsx : RVm<opcStr # ".w.sx", opc>;
  let cx = 0, cx2 = 1 in defm wzx : RVm<opcStr # ".w.zx", opc>;
  let cx = 1, cx2 = 1 in defm p : RVm<"p" # opcStr, opc>;
}

// i64
multiclass RVLm<string opcStr, bits<8> opc> {
  defm l : RVm<opcStr # ".l", opc>;
}

// RVDSPm: double,single,packed
multiclass RVDSPm<string opcStr, bits<8> opc> {
  let cx = 0, cx2 = 0 in defm d : RVm<opcStr # ".d", opc>; // double
  let cx = 1, cx2 = 0 in defm s : RVm<opcStr # ".s", opc>; // float
  let cx = 1, cx2 = 1 in defm p : RVm<"p" # opcStr, opc>; // packed
}

// RVFDSPm: double,single,packed
multiclass RVFDSPm<string opcStr, bits<8> opc> {
  let cx = 0, cx2 = 0 in defm d : RVFm<opcStr # ".d", opc>; // double
  let cx = 1, cx2 = 0 in defm s : RVFm<opcStr # ".s", opc>; // float
  let cx = 1, cx2 = 1 in defm p : RVFm<"p" # opcStr, opc>; // packed
}

multiclass RVLOGm<string opcStr, bits<8> opc> {
  let cx = 0, cx2 = 0 in defm : RVFm<opcStr, opc>;       // 64b
  let cx = 1, cx2 = 1 in defm p : RVFm<"p"#opcStr, opc>; // 32b
}

class RVM<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
        InstrItinClass itin = NoItinerary> 
    : InstVE<outs, ins, asmstr, pattern, itin> {
    bits<1> vo;
    bits<1> vc;
    bits<1> cy;
    bits<7> sy;
    bits<1> cz;
    bits<7> sz;
    bits<8> vx;
    let op = opVal;
    let Inst{8} = vo;
    let Inst{9} = vc;
    let Inst{16} = cy;
    let Inst{23-17} = sy;
    let Inst{24} = cz;
    let Inst{31-25} = sz;
    let Inst{39-32} = vx;
}

multiclass VLDm<string opcStr, bits<8> opc> {
  def i : RVM<opc, (outs V64:$vx), (ins simm7Op64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,$sz"), []> {
      let vc = 0;
      let cy = 0;
      let cz = 1;
  }
  def r : RVM<opc, (outs V64:$vx), (ins I64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,$sz"), []> {
      let vc = 0;
      let cy = 1;
      let cz = 1;
  }
  def inc : RVM<opc, (outs V64:$vx), (ins simm7Op64:$sy, I64:$sz),
    !strconcat(opcStr, ".nc $vx,$sy,$sz"), []> {
      let vc = 1;
      let cy = 0;
      let cz = 1;
  }
  def rnc : RVM<opc, (outs V64:$vx), (ins I64:$sy, I64:$sz),
    !strconcat(opcStr, ".nc $vx,$sy,$sz"), []> {
      let vc = 1;
      let cy = 1;
      let cz = 1;
  }
}

multiclass VSTm<string opcStr, bits<8> opc> {
  def i : RVM<opc, (outs), (ins V64:$vx, simm7Op64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,$sz"), []> {
      let vc = 0;
      let cy = 0;
      let cz = 1;
  }
  def r : RVM<opc, (outs), (ins V64:$vx, I64:$sy, I64:$sz),
    !strconcat(opcStr, " $vx,$sy,$sz"), []> {
      let vc = 0;
      let cy = 1;
      let cz = 1;
  }
  def inc : RVM<opc, (outs), (ins V64:$vx, simm7Op64:$sy, I64:$sz),
    !strconcat(opcStr, ".nc $vx,$sy,$sz"), []> {
      let vc = 1;
      let cy = 0;
      let cz = 1;
  }
  def rnc : RVM<opc, (outs), (ins V64:$vx, I64:$sy, I64:$sz),
    !strconcat(opcStr, ".nc $vx,$sy,$sz"), []> {
      let vc = 1;
      let cy = 1;
      let cz = 1;
  }
}

let cx = 0, sx = 0, cy = 0, cz = 0, sz = 0 in
def LVL : RR<0xBF, (outs), (ins I32:$sy), "lvl $sy", []>;

def LSVr : RR<0x8E, (outs V64:$dst), (ins V64:$vx, I64:$sy, I64:$sz), 
  "lsv ${vx}(${sy}),$sz", []> {
    let cy = 1;
    let Constraints = "$dst = $vx";
}
def LSVi : RR<0x8E, (outs V64:$dst), (ins V64:$vx, simm7Op64:$sy, I64:$sz),
  "lsv ${vx}(${sy}),$sz", []> {
    let Constraints = "$dst = $vx";
}

let cx = 0, sx = 0, cy = 1, cz = 0, sz = 0 in
def LVSr : RR<0x9E, (outs I64:$sx), (ins V64:$vx, I64:$sy), "lvs ${sx},${vx}(${sy})", []>;


// 5.3.2.7 Vector Fixed-Point Arithmetic Operation Instructions

let mayLoad = 1 in defm VLD : VLDm<"vld", 0x81>;
let mayLoad = 1 in defm VLDU : VLDm<"vldu", 0x82>;
let mayLoad = 1 in defm VLDL : VLDm<"vldl", 0x83>;

defm VST : VSTm<"vst", 0x91>;
defm VSTU : VSTm<"vstu", 0x92>;
defm VSTL : VSTm<"vstl", 0x93>;


// 5.3.2.8. Vector Fixed-Point Arithmetic Operation Instructions
defm VADD : RVUm<"vaddu", 0xC8>;
defm VADS : RVWm<"vadds", 0xCA>;
defm VADX : RVLm<"vadds", 0x8B>;
defm VSUB : RVUm<"vsubu", 0xD8>;
defm VSBS : RVWm<"vsubs", 0xDA>;
defm VSBX : RVLm<"vsubs", 0x9B>;
defm VMPY : RVLWm<"vmulu", 0xC9>;   // mul unsigned 64b/32b
defm VMPS : RVEXm<"vmuls.w", 0xCB>; // mul signed 32b sx/zx
defm VMPX : RVLm<"vmuls", 0xDB>;   // mul signed 64b
defm VMPD : RVm<"vmuls.l.w", 0xD9>; // mul signed 32b -> 64b
// divs
defm VCMP : RVUm<"vcmpu", 0xB9>;
defm VCPS : RVWm<"vcmps", 0xFA>;
defm VCPX : RVLm<"vcmps", 0xBA>;
// CMS
// CMX

// 5.3.2.9. Vector Logical Arithmetic Operation Instructions
defm VAND : RVLOGm<"vand", 0xC4>;

// 5.3.2.10. Vector Shift Instructions

// 5.3.2.11 Vector Floating-Point Arithmetic Operation Instructions
defm VFAD : RVDSPm<"vfadd", 0xCC>;
defm VFSB : RVDSPm<"vfsub", 0xDC>;
defm VFMP : RVDSPm<"vfmul", 0xCD>;
defm VFDV : RVDSPm<"vfdiv", 0xDD>;
// VFSQRT
defm VFCP : RVDSPm<"vfcmp", 0xFC>;
// VFCM
defm VFMAD : RVFDSPm<"vfmad", 0xE2>;
defm VFMSB : RVFDSPm<"vfmsb", 0xF2>;
defm VFNMAD : RVFDSPm<"vfnmad", 0xE3>;
defm VFNMSB : RVFDSPm<"vfnmsb", 0xF3>;
// VRCP

def VFMK : RV<0xB4, (outs VM:$vm), (ins CCOp:$cf, V64:$vz), 
  "vfmk.l.${cf} $vm,$vz", []>
{
  let sy = 0;
  let vw = 0;
  let m = 0; // ok?
}

def : Pat<(int_ve_vfaddd_vvvm v256f64:$vy, v256f64:$vz, v4i64:$vm), 
          (VFADdvm v256f64:$vy, v256f64:$vz, v4i64:$vm)>;

def : Pat<(int_ve_vfmk simm7:$cf, v256f64:$vz),
          (VFMK simm7:$cf, v256f64:$vz)>;

// Pattern Matchings for Vector Instructions

def : Pat<(v256f64 (load ADDRri:$addr)), 
          (v256f64 (VLDi 8, (LEAasx ADDRri:$addr)))>;

def : Pat<(store V64:$vx, ADDRri:$addr), 
          (VSTi v256f64:$vx, 8, (LEAasx ADDRri:$addr))>;

// Pattern Matchings for Vector Intrinsics

def : Pat<(int_ve_lvl i32:$sy), (LVL i32:$sy)>;

def : Pat<(int_ve_lsv_vss v256f64:$vx, i32:$sy, i64:$sz), 
          (LSVr v256f64:$vx, i32:$sy, i64:$sz)>;

def : Pat<(int_ve_vld i64:$sz, i64:$sy), (VLDr i64:$sy, i64:$sz)>;
def : Pat<(int_ve_vld i64:$sz, (i64 simm7:$sy)), (VLDi (i64 simm7:$sy), i64:$sz)>;
def : Pat<(int_ve_vldu i64:$sz, i64:$sy), (VLDUr i64:$sy, i64:$sz)>;
def : Pat<(int_ve_vldu i64:$sz, (i64 simm7:$sy)), (VLDUi (i64 simm7:$sy), i64:$sz)>;
def : Pat<(int_ve_vldl i64:$sz, i64:$sy), (VLDLr i64:$sy, i64:$sz)>;
def : Pat<(int_ve_vldl i64:$sz, (i64 simm7:$sy)), (VLDLi (i64 simm7:$sy), i64:$sz)>;

def : Pat<(int_ve_vst i64:$sz, v256f64:$vx, i64:$sy), 
          (VSTr v256f64:$vx, i64:$sy, i64:$sz)>;
def : Pat<(int_ve_vst i64:$sz, v256f64:$vx, (i64 simm7:$sy)), 
          (VSTi v256f64:$vx, (i64 simm7:$sy), i64:$sz)>;
def : Pat<(int_ve_vstu i64:$sz, v256f64:$vx, i64:$sy), 
          (VSTUr v256f64:$vx, i64:$sy, i64:$sz)>;
def : Pat<(int_ve_vstu i64:$sz, v256f64:$vx, (i64 simm7:$sy)), 
          (VSTUi v256f64:$vx, (i64 simm7:$sy), i64:$sz)>;
def : Pat<(int_ve_vstl i64:$sz, v256f64:$vx, i64:$sy), 
          (VSTLr v256f64:$vx, i64:$sy, i64:$sz)>;
def : Pat<(int_ve_vstl i64:$sz, v256f64:$vx, (i64 simm7:$sy)), 
          (VSTLi v256f64:$vx, (i64 simm7:$sy), i64:$sz)>;

include "VEInstrIntrinsic.td"

