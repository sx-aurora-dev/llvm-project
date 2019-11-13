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
    bits<7> sy = 0;
    bits<1> cz = 0;   // y operand is register(1) or immediate(0)
    bits<7> sz = 0;
    bits<8> vx = 0;
    bits<8> vy = 0;
    bits<8> vz = 0;
    bits<8> vw = 0;
    bits<4> m = 0;
    let op = opVal;
    let Inst{8} = cx;
    let Inst{9} = cx2;
    let Inst{10} = cs;
    let Inst{11} = cs2;
    let Inst{15-12} = m;
    let Inst{16} = cy;
    let Inst{23-17} = sy;
    let Inst{24} = cz;
    let Inst{25-31} = sz;
    let Inst{39-32} = vx;
    let Inst{47-40} = vy;
    let Inst{55-48} = vz;
    let Inst{63-56} = vw;
}

//class PseudoVec<dag outs, dag ins, string asmstr, list<dag> pattern> 
//  : Pseudo<outs, ins, asmstr, pattern> {
//    // Not using implicit Uses
//    // let Uses = [VL]; // vector length register
//  }


//class RV2<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
//        InstrItinClass itin = NoItinerary> 
//      : RV<opVal, outs, ins, asmstr, pattern, itin> {
//    let vz = 0;
//    let vw = 0;
//}

//multiclass RV2vm<string opcStr, bits<8> opc, RegisterClass MaskRC> {
//  def v : RV2<opc, (outs V64:$vx), (ins V64:$vy, VLS:$vl), 
//              !strconcat(opcStr, " $vx,$vy"), []> {
//    let sy = 0;
//    let hasSideEffects = 0;
//  }
//  def vm : RV2<opc, (outs V64:$vx),
//               (ins V64:$vy, MaskRC:$vm, V64:$vd, VLS:$vl), 
//               !strconcat(opcStr, " $vx,$vy,$vm"), []> {
//    bits<4> vm;
//    let sy = 0;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let hasSideEffects = 0;
//  }
//}

class RV3<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
          InstrItinClass itin = NoItinerary> 
      : RV<opVal, outs, ins, asmstr, pattern, itin> {
  let vw = 0;
}

//multiclass RV3m<string opcStr, bits<8> opc, RegisterClass ScalarRC, RegisterClass MaskRC, Operand immOp> {
//  // (set V64:$vx, (op (simm7:$sy or I64:$sy or V64:$vz), V64:$vz))
//  // V64:$vx = (simm7:$sy or I64:$sy or V64:$vz) opc V64:$vz
//  def i : RV3<opc, (outs V64:$vx), (ins immOp:$sy, V64:$vz),
//    !strconcat(opcStr, " $vx,$sy,$vz"), []> {
//      let cs = 1;
//      let cs2 = 0;
//      let cy = 0;
//      let vy = 0;
//      let hasSideEffects = 0;
//    }
//  def r : RV3<opc, (outs V64:$vx), (ins ScalarRC:$sy, V64:$vz),
//    !strconcat(opcStr, " $vx,$sy,$vz"), []> {
//      let cs = 1;
//      let cs2 = 0;
//      let cy = 1;
//      let vy = 0;
//      let hasSideEffects = 0;
//    }
//  def v : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz),
//    !strconcat(opcStr, " $vx,$vy,$vz"), []> {
//      let cs = 0;
//      let cs2 = 0;
//      let sy = 0;
//      let hasSideEffects = 0;
//    }
//  def im : RV3<opc, (outs V64:$vx), (ins immOp:$sy, V64:$vz, MaskRC:$vm, V64:$vd),
//    !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
//      bits<4> vm;
//      let cs = 1;
//      let cs2 = 0;
//      let vy = 0;
//      let m = vm;
//      let Constraints = "$vx = $vd";
//      let hasSideEffects = 0;
//    }
//  def rm : RV3<opc, (outs V64:$vx), (ins ScalarRC:$sy, V64:$vz, MaskRC:$vm, V64:$vd),
//    !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
//      bits<4> vm;
//      let cs = 1;
//      let cs2 = 0;
//      let cy = 1;
//      let vy = 0;
//      let m = vm;
//      let Constraints = "$vx = $vd";
//      let hasSideEffects = 0;
//    }
//  def vm : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, MaskRC:$vm, V64:$vd),
//    !strconcat(opcStr, " $vx,$vy,$vz,$vm"), []> {
//      bits<4> vm;
//      let sy = 0;
//      let m = vm;
//      let Constraints = "$vx = $vd";
//      let hasSideEffects = 0;
//    }
//}

//multiclass RV3VLm<string opcStr, bits<8> opc, RegisterClass ScalarRC,
//                  RegisterClass MaskRC, Operand immOp> {
//  def i : RV3<opc, (outs V64:$vx), (ins immOp:$sy, V64:$vz, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sy,$vz"), []> {
//    let cs = 1;
//    let cy = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def r : RV3<opc, (outs V64:$vx), (ins ScalarRC:$sy, V64:$vz, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sy,$vz"), []> {
//    let cs = 1;
//    let cy = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def v : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vy,$vz"), []> {
//    let cs = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def im : RV3<opc, (outs V64:$vx),
//               (ins immOp:$sy, V64:$vz, MaskRC:$vm, V64:$vd, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
//    let cs = 1;
//    let cy = 0;
//    bits<4> vm;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def rm : RV3<opc, (outs V64:$vx),
//               (ins ScalarRC:$sy, V64:$vz, MaskRC:$vm, V64:$vd, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
//    let cs = 1;
//    let cy = 1;
//    bits<4> vm;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def vm : RV3<opc, (outs V64:$vx),
//               (ins V64:$vy, V64:$vz, MaskRC:$vm, V64:$vd, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,$vz,$vm"), []> {
//    let cs = 0;
//    bits<4> vm;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}

//multiclass RV3DIVBYSm<string opcStr, bits<8> opc, RegisterClass ScalarRC,
//                      RegisterClass MaskRC, Operand immOp>
//{
//  def i2 : RV3<opc, (outs V64:$vx), (ins V64:$vy, immOp:$sy, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,$sy"), []> {
//    let cs = 1;
//    let cs2 = 1;
//    let cy = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def r2 : RV3<opc, (outs V64:$vx), (ins V64:$vy, ScalarRC:$sy, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,$sy"), []> {
//    let cs = 1;
//    let cs2 = 1;
//    let cy = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def im2 : RV3<opc, (outs V64:$vx),
//                (ins V64:$vy, immOp:$sy, MaskRC:$vm, V64:$vd, VLS:$vl),
//                !strconcat(opcStr, " $vx,$vy,$sy,$vm"), []> {
//    let cs = 1;
//    let cs2 = 1;
//    let cy = 0;
//    bits<4> vm;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def rm2 : RV3<opc, (outs V64:$vx),
//                (ins V64:$vy, ScalarRC:$sy, MaskRC:$vm, V64:$vd, VLS:$vl),
//                !strconcat(opcStr, " $vx,$vy,$sy,$vm"), []> {
//    let cs = 1;
//    let cs2 = 1;
//    let cy = 1;
//    bits<4> vm;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}

//// Fused
//multiclass RV4m<string opcStr, bits<8> opc, RegisterClass ScalarRC, RegisterClass MaskRC> {
//  def v : RV<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VLS:$vl),
//             !strconcat(opcStr, " $vx,$vy,$vz,$vw"), []> {
//    let cs = 0;
//    let cs2 = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def i : RV<opc, (outs V64:$vx),
//             (ins simm7Op64:$sy, V64:$vz, V64:$vw, VLS:$vl),
//             !strconcat(opcStr, " $vx,$sy,$vz,$vw"), []> {
//    let cs = 1;
//    let cs2 = 0;
//    let cy = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def r : RV<opc, (outs V64:$vx),
//             (ins ScalarRC:$sy, V64:$vz, V64:$vw, VLS:$vl),
//             !strconcat(opcStr, " $vx,$sy,$vz,$vw"), []> {
//    let cs = 1;
//    let cs2 = 0;
//    let cy = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def i2 : RV<opc, (outs V64:$vx),
//              (ins V64:$vy, simm7Op64:$sy, V64:$vw, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vy,$sy,$vw"), []> {
//    let cs = 0;
//    let cs2 = 1;
//    let cy = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def r2 : RV<opc, (outs V64:$vx),
//              (ins V64:$vy, ScalarRC:$sy, V64:$vw, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vy,$sy,$vw"), []> {
//    let cs = 0;
//    let cs2 = 1;
//    let cy = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def vm : RV<opc, (outs V64:$vx),
//              (ins V64:$vy, V64:$vz, V64:$vw, MaskRC:$vm, V64:$vd, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vy,$vz,$vw,$vm"), []> {
//    bits<4> vm;
//    let cs = 0;
//    let cs2 = 0;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def im : RV<opc, (outs V64:$vx),
//              (ins simm7Op64:$sy, V64:$vz, V64:$vw, MaskRC:$vm, V64:$vd, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sy,$vz,$vw,$vm"), []> {
//    bits<4> vm;
//    let cs = 1;
//    let cs2 = 0;
//    let cy = 0;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def rm : RV<opc, (outs V64:$vx),
//              (ins ScalarRC:$sy, V64:$vz, V64:$vw, MaskRC:$vm, V64:$vd, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sy,$vz,$vw,$vm"), []> {
//    bits<4> vm;
//    let cs = 1;
//    let cs2 = 0;
//    let cy = 1;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def i2m : RV<opc, (outs V64:$vx),
//               (ins V64:$vy, simm7Op64:$sy, V64:$vw, MaskRC:$vm, V64:$vd, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,$sy,$vw,$vm"), []> {
//    bits<4> vm;
//    let cs = 0;
//    let cs2 = 1;
//    let cy = 0;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def r2m : RV<opc, (outs V64:$vx),
//               (ins V64:$vy, ScalarRC:$sy, V64:$vw, MaskRC:$vm, V64:$vd, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,$sy,$vw,$vm"), []> {
//    bits<4> vm;
//    let cs = 0;
//    let cs2 = 1;
//    let cy = 1;
//    let vy = 0;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}

//// u64, u32
//multiclass RVLWm<string opcStr, bits<8> opc> {
//  let cx2 = 0 in defm l : RV3m<opcStr # ".l", opc, I64, VM, simm7Op64>; // u64
//  let cx2 = 1 in defm w : RV3m<opcStr # ".w", opc, I32, VM, simm7Op32>; // u32
//}
//
//// u64, u32
//multiclass RVLWVLm<string opcStr, bits<8> opc> {
//  let cx2 = 0 in defm l : RV3VLm<opcStr # ".l", opc, I64, VM, simm7Op64>; // u64
//  let cx2 = 1 in defm w : RV3VLm<opcStr # ".w", opc, I32, VM, simm7Op32>; // u32
//}
//
//// i32 (sz,zx)
//multiclass RVEXm<string opcStr, bits<8> opc> {
//  let cx2 = 0 in defm wsx : RV3m<opcStr # ".w.sx", opc, I32, VM, simm7Op32>; // i32 sx
//  let cx2 = 1 in defm wzx : RV3m<opcStr # ".w.zx", opc, I32, VM, simm7Op32>; // i32 zx
//}
//
//// i32 (sz,zx)
//multiclass RVEXVLm<string opcStr, bits<8> opc> {
//  let cx2 = 0 in
//  defm wsx : RV3VLm<opcStr # ".w.sx", opc, I32, VM, simm7Op32>; // i32 sx
//  let cx2 = 1 in
//  defm wzx : RV3VLm<opcStr # ".w.zx", opc, I32, VM, simm7Op32>; // i32 zx
//}
//
//// u64, u32, packed u32
//multiclass RVUm<string opcStr, bits<8> opc> {
//  let cx = 0, cx2 = 0 in defm l : RV3m<opcStr # ".l", opc, I64, VM, simm7Op64>; // u64
//  let cx = 0, cx2 = 1 in defm w : RV3m<opcStr # ".w", opc, I32, VM, simm7Op32>; // u32
//  let cx = 1, cx2 = 1 in defm p : RV3m<"p" # opcStr, opc, I64, VM512, simm7Op32>; // packed u32
//}
//
//// i32 (sz,zx), packed i32
//multiclass RVWm<string opcStr, bits<8> opc> {
//  let cx = 0, cx2 = 0 in defm wsx : RV3m<opcStr # ".w.sx", opc, I32, VM, simm7Op32>; // i32 sx
//  let cx = 0, cx2 = 1 in defm wzx : RV3m<opcStr # ".w.zx", opc, I32, VM, simm7Op32>; // i32 zx
//  let cx = 1, cx2 = 1 in defm p : RV3m<"p" # opcStr, opc, I64, VM512, simm7Op32>;       // packed i32
//}
//
//// i64
//multiclass RVLm<string opcStr, bits<8> opc> {
//  defm l : RV3m<opcStr # ".l", opc, I64, VM, simm7Op64>;
//}
//
//// u64, u32, packed u32
//multiclass RVUVLm<string opcStr, bits<8> opc> {
//  let cx = 0, cx2 = 0 in
//  defm l : RV3VLm<opcStr # ".l", opc, I64, VM, simm7Op64>; // u64
//  let cx = 0, cx2 = 1 in
//  defm w : RV3VLm<opcStr # ".w", opc, I32, VM, simm7Op32>; // u32
//  let cx = 1, cx2 = 1 in
//  defm p : RV3VLm<"p" # opcStr, opc, I64, VM512, simm7Op32>; // packed u32
//}
//
//// i32 (sz,zx), packed i32
//multiclass RVWVLm<string opcStr, bits<8> opc> {
//  let cx = 0, cx2 = 0 in
//  defm wsx : RV3VLm<opcStr # ".w.sx", opc, I32, VM, simm7Op32>; // i32 sx
//  let cx = 0, cx2 = 1 in
//  defm wzx : RV3VLm<opcStr # ".w.zx", opc, I32, VM, simm7Op32>; // i32 zx
//  let cx = 1, cx2 = 1 in
//  defm p : RV3VLm<"p" # opcStr, opc, I64, VM512, simm7Op32>;    // packed i32
//}
//
//// i64
//multiclass RVLVLm<string opcStr, bits<8> opc> {
//  defm l : RV3VLm<opcStr # ".l", opc, I64, VM, simm7Op64>;
//}

//// f64, f32, packed f32
//multiclass RVDSPm<string opcStr, bits<8> opc> {
//  // last argument should not be used...
//  let cx = 0, cx2 = 0 in defm d : RV3VLm<opcStr # ".d", opc, I64, VM, simm7Op64>; // double
//  let cx = 1, cx2 = 0 in defm s : RV3VLm<opcStr # ".s", opc, F32, VM, simm7Op64>; // float
//  let cx = 1, cx2 = 1 in defm p : RV3VLm<"p" # opcStr, opc, I64, VM512, simm7Op64>; // packed
//}

//// f64, f32, packed f32 (4 operands)
//multiclass RV4DSPm<string opcStr, bits<8> opc> {
//  let cx = 0, cx2 = 0 in defm d : RV4m<opcStr # ".d", opc, I64, VM>; // double
//  let cx = 1, cx2 = 0 in defm s : RV4m<opcStr # ".s", opc, F32, VM>; // float
//  let cx = 1, cx2 = 1 in defm p : RV4m<"p" # opcStr, opc, I64, VM512>; // packed
//}

multiclass RVLOGCm<string opcStr, bits<8> opc> {
  def v : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VLS:$vl),
              !strconcat(opcStr, " $vx,$vy,$vz"), []> {
    let cs = 0;
    let hasSideEffects = 0;
  }
  def r : RV3<opc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VLS:$vl),
              !strconcat(opcStr, " $vx,$sy,$vz"), []> {
    let cs = 1;
    let cy = 1;
    let hasSideEffects = 0;
  }
  def i0 : RV3<opc, (outs V64:$vx), (ins uimm6Op64:$sy, V64:$vz, VLS:$vl),
               !strconcat(opcStr, " $vx,(${sy})0,$vz"), []> {
    let cs = 1;
    let cy = 0;
    let sy{6} = 1;
    let hasSideEffects = 0;
  }
  def i1 : RV3<opc, (outs V64:$vx), (ins uimm6Op64:$sy, V64:$vz, VLS:$vl),
               !strconcat(opcStr, " $vx,(${sy})1,$vz"), []> {
    let cs = 1;
    let cy = 0;
    let sy{6} = 0;
    let hasSideEffects = 0;
  }
}

multiclass RVLOGMm<string opcStr, bits<8> opc, RegisterClass MaskRC> {
  def vm : RV3<opc, (outs V64:$vx),
               (ins V64:$vy, V64:$vz, MaskRC:$vm, V64:$vd, VLS:$vl),
               !strconcat(opcStr, " $vx,$vy,$vz,$vm"), []> {
    bits<4> vm;
    let cs = 0;
    let m = vm;
    let Constraints = "$vx = $vd";
    let hasSideEffects = 0;
  }
  def rm : RV3<opc, (outs V64:$vx),
               (ins I64:$sy, V64:$vz, MaskRC:$vm, V64:$vd, VLS:$vl),
               !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
    bits<4> vm;
    let cs = 1;
    let cy = 1;
    let m = vm;
    let Constraints = "$vx = $vd";
    let hasSideEffects = 0;
  }
  def i0m : RV3<opc, (outs V64:$vx),
                (ins uimm6Op64:$sy, V64:$vz, MaskRC:$vm, V64:$vd, VLS:$vl),
                !strconcat(opcStr, " $vx,(${sy})0,$vz,$vm"), []> {
    bits<4> vm;
    let cs = 1;
    let cy = 0;
    let sy{6} = 1;
    let m = vm;
    let Constraints = "$vx = $vd";
    let hasSideEffects = 0;
  }
  def i1m : RV3<opc, (outs V64:$vx),
                (ins uimm6Op64:$sy, V64:$vz, MaskRC:$vm, V64:$vd, VLS:$vl),
                !strconcat(opcStr, " $vx,(${sy})1,$vz,$vm"), []> {
    bits<4> vm;
    let cs = 1;
    let cy = 0;
    let sy{6} = 0;
    let m = vm;
    let Constraints = "$vx = $vd";
    let hasSideEffects = 0;
  }
}

multiclass RVLOGm<string opcStr, bits<8> opc> {
  let cx = 0, cx2 = 0 in defm "" : RVLOGCm<opcStr, opc>;
  let cx = 0, cx2 = 1 in defm l : RVLOGCm<!strconcat("p", opcStr, ".lo"), opc>;
  let cx = 1, cx2 = 0 in defm u : RVLOGCm<!strconcat("p", opcStr, ".up"), opc>;
  let cx = 1, cx2 = 1 in defm p : RVLOGCm<!strconcat("p", opcStr), opc>;
  let cx = 0, cx2 = 0 in defm "" : RVLOGMm<opcStr, opc, VM>;
  let cx = 0, cx2 = 1 in defm l : RVLOGMm<!strconcat("p", opcStr, ".lo"),
                                          opc, VM>;
  let cx = 1, cx2 = 0 in defm u : RVLOGMm<!strconcat("p", opcStr, ".up"),
                                          opc, VM>;
  let cx = 1, cx2 = 1 in defm p : RVLOGMm<!strconcat("p", opcStr),
                                          opc, VM512>;
}

//class RVM<bits<8>opVal, dag outs, dag ins, string asmstr, list<dag> pattern,
//        InstrItinClass itin = NoItinerary> 
//    : InstVE<outs, ins, asmstr, pattern, itin> {
//    bits<1> cx = 0;
//    bits<1> vc = 1; // 1: leave vector data in LLC, 0: released from LLC
//    bits<1> cs = 0; // use sw operand(1) or not(0)
//    bits<1> cy = 0; // y operand is immediate(0) or register(1)
//    bits<1> cz = 0; // z operand is zero(0) or register(1)
//    bits<8> vx = 0;
//    bits<8> vy = 0;
//    bits<7> sy = 0;
//    bits<7> sz = 0;
//    bits<7> sw = 0;
//    bits<4> m = 0;
//    let op = opVal;
//    let Inst{8} = cx;
//    let Inst{9} = vc;
//    let Inst{10} = cs;
//    let Inst{11} = 0;
//    let Inst{15-12} = m;
//    let Inst{16} = cy;
//    let Inst{23-17} = sy;
//    let Inst{24} = cz;
//    let Inst{31-25} = sz;
//    let Inst{39-32} = vx;
//    let Inst{47-40} = vy;
//    let Inst{55-48} = 0;
//    let Inst{56} = 0;
//    let Inst{63-57} = sw;
//}
//
//// 5.3.2.7. Vector Transfer Instructions
//
//multiclass VLDCm<string opcStr, bits<8> opc> {
//  def rr : RVM<opc, (outs V64:$vx), (ins I64:$sy, I64:$sz, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,$sz"), []> {
//    let cy = 1;
//    let cz = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayLoad = 1;
//  }
//  def ir : RVM<opc, (outs V64:$vx), (ins simm7Op64:$sy, I64:$sz, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,$sz"), []> {
//    let cy = 0;
//    let cz = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayLoad = 1;
//  }
//  def rz : RVM<opc, (outs V64:$vx), (ins simm7Op64:$sy, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,0"), []> {
//    let cy = 1;
//    let cz = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayLoad = 1;
//  }
//  def iz : RVM<opc, (outs V64:$vx), (ins I64:$sy, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,0"), []> {
//    let cy = 0;
//    let cz = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayLoad = 1;
//  }
//}
//
//multiclass VLDm<string opcStr, bits<8> opc> {
//  let vc = 1 in defm "" : VLDCm<opcStr, opc>;
//  let vc = 0 in defm nc : VLDCm<!strconcat(opcStr, ".nc"), opc>;
//}
//
//multiclass VSTCm<string opcStr, bits<8> opc> {
//  def rr : RVM<opc, (outs), (ins V64:$vx, I64:$sy, I64:$sz, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,$sz"), []> {
//    let cy = 1;
//    let cz = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def ir : RVM<opc, (outs), (ins V64:$vx, simm7Op64:$sy, I64:$sz, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,$sz"), []> {
//    let cy = 0;
//    let cz = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def rz : RVM<opc, (outs), (ins V64:$vx, simm7Op64:$sy, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,0"), []> {
//    let cy = 1;
//    let cz = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def iz : RVM<opc, (outs), (ins V64:$vx, I64:$sy, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,0"), []> {
//    let cy = 0;
//    let cz = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def rrm : RVM<opc, (outs), (ins V64:$vx, I64:$sy, I64:$sz, VM:$vm, VLS:$vl),
//                !strconcat(opcStr, " $vx,$sy,$sz,$vm"), []> {
//    bits<4> vm;
//    let cy = 1;
//    let cz = 1;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def irm : RVM<opc, (outs),
//                (ins V64:$vx, simm7Op64:$sy, I64:$sz, VM:$vm, VLS:$vl),
//                !strconcat(opcStr, " $vx,$sy,$sz,$vm"), []> {
//    bits<4> vm;
//    let cy = 0;
//    let cz = 1;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def rzm : RVM<opc, (outs), (ins V64:$vx, simm7Op64:$sy, VM:$vm, VLS:$vl),
//                !strconcat(opcStr, " $vx,$sy,0,$vm"), []> {
//    bits<4> vm;
//    let cy = 1;
//    let cz = 0;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def izm : RVM<opc, (outs), (ins V64:$vx, I64:$sy, VM:$vm, VLS:$vl),
//                !strconcat(opcStr, " $vx,$sy,0,$vm"), []> {
//    bits<4> vm;
//    let cy = 0;
//    let cz = 0;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//}
//
//multiclass VSTm<string opcStr, bits<8> opc> {
//  let vc = 1, cx = 0 in defm "" : VSTCm<opcStr, opc>;
//  let vc = 0, cx = 0 in defm nc : VSTCm<!strconcat(opcStr, ".nc"), opc>;
//  let vc = 1, cx = 1 in defm ot : VSTCm<!strconcat(opcStr, ".ot"), opc>;
//  let vc = 0, cx = 1 in defm ncot : VSTCm<!strconcat(opcStr, ".nc.ot"), opc>;
//}

//defm VLD : VLDm<"vld", 0x81>;
//defm VLDU : VLDm<"vldu", 0x82>;
//let cx = 0 in defm VLDLsx : VLDm<"vldl.sx", 0x83>;
//let cx = 1 in defm VLDLzx : VLDm<"vldl.zx", 0x83>;

//defm VLD2D  : VLDm<"vld2d", 0xC1>;
//defm VLDU2D : VLDm<"vldu2d", 0xC2>;
//let cx = 0 in defm VLDL2Dsx : VLDm<"vldl2d.sx", 0xC3>;
//let cx = 1 in defm VLDL2Dzx : VLDm<"vldl2d.zx", 0xC3>;

//defm VST : VSTm<"vst", 0x91>;
//defm VSTU : VSTm<"vstu", 0x92>;
//defm VSTL : VSTm<"vstl", 0x93>;

//defm VST2D  : VSTm<"vst2d", 0xD1>;
//defm VSTU2D : VSTm<"vstu2d", 0xD2>;
//defm VSTL2D : VSTm<"vstl2d", 0xD3>;

//def LSVr : RR<0x8E, (outs V64:$dst), (ins V64:$vx, I32:$sy, I64:$sz), 
//  "lsv ${vx}(${sy}),$sz", []> {
//    let cy = 1;
//    let Constraints = "$dst = $vx";
//    let hasSideEffects = 0;
//}
//def LSVi : RR<0x8E, (outs V64:$dst), (ins V64:$vx, simm7Op32:$sy, I64:$sz),
//  "lsv ${vx}(${sy}),$sz", []> {
//    let Constraints = "$dst = $vx";
//    let hasSideEffects = 0;
//}
//
//let cx = 0, sx = 0, cy = 1, cz = 0, sz = 0, hasSideEffects = 0 in
//def LVSr : RR<0x9E, (outs I64:$sx), (ins V64:$vx, I64:$sy),
//  "lvs ${sx},${vx}(${sy})", []>;
//
//let cx = 0, sx = 0, cy = 0, cz = 0, sz = 0, hasSideEffects = 0 in
//def LVSi : RR<0x9E, (outs I64:$sx), (ins V64:$vx, simm7Op64:$sy),
//  "lvs ${sx},${vx}(${sy})", []>;
//
//let cx = 0, sx = 0, cy = 1, cz = 0, sz = 0, isCodeGenOnly = 1, hasSideEffects = 0 in
//def LVSi64r : RR<0x9E, (outs I64:$sx), (ins V64:$vx, I32:$sy),
//  "lvs ${sx},${vx}(${sy})", []>;
//
//let cx = 0, sx = 0, cy = 1, cz = 0, sz = 0, isCodeGenOnly = 1, hasSideEffects = 0 in
//def LVSf64r : RR<0x9E, (outs I64:$sx), (ins V64:$vx, I32:$sy),
//  "lvs ${sx},${vx}(${sy})", []>;
//
//let cx = 0, sx = 0, cy = 1, cz = 0, sz = 0, isCodeGenOnly = 1, hasSideEffects = 0 in
//def LVSf32r : RR<0x9E, (outs F32:$sx), (ins V64:$vx, I32:$sy),
//  "lvs ${sx},${vx}(${sy})", []>;

//let cy = 1 in
//def LVMr : RR<0xB7, (outs VM:$vmx), (ins VM:$vmd, I64:$sy, I64:$sz),
//  "lvm $vmx,$sy,$sz", []> {
//  let Constraints = "$vmx = $vmd";
//  let hasSideEffects = 0;
//}

let cy = 0 in
def LVMi : RR<0xB7, (outs VM:$vmx), (ins VM:$vmd, uimm6Op64:$sy, I64:$sz),
  "lvm $vmx,$sy,$sz", []> {
  let Constraints = "$vmx = $vmd";
  let hasSideEffects = 0;
}

//def LVMpi : Pseudo<(outs VM512:$vmx), (ins VM512:$vmd, uimm6Op64:$sy, I64:$sz),
//  "# lvm $vmx,$sy,$sz", []> {
//  let Constraints = "$vmx = $vmd";
//  let hasSideEffects = 0;
//}

let cy = 1, hasSideEffects = 0 in
def SVMr : RR<0xA7, (outs I64:$sx), (ins VM:$vmx, I64:$sy), "svm $sx,$vmx,$sy", []>;

let cy = 0, hasSideEffects = 0 in 
def SVMi : RR<0xA7, (outs I64:$sx), (ins VM:$vmx, uimm6Op64:$sy), "svm $sx,$vmx,$sy", []>;

//let hasSideEffects = 0 in
//def SVMpi : Pseudo<(outs I64:$sx), (ins VM512:$vmx, uimm6Op64:$sy), "# svm+svm", []>;

//multiclass VBRDm<string opcStr, bits<8> opc, RegisterClass MaskRC, RegisterClass RCi, Operand immOp> {
//  def r : RV2<opc, (outs V64:$vx), (ins RCi:$sy, VLS:$vl), 
//              !strconcat(opcStr, " $vx,$sy"), []> {
//    let cy = 1;
//    let vy = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def i : RV2<opc, (outs V64:$vx), (ins immOp:$sy, VLS:$vl), 
//              !strconcat(opcStr, " $vx,$sy"), []> {
//    let cy = 0;
//    let vy = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def rm : RV2<opc, (outs V64:$vx),
//               (ins RCi:$sy, MaskRC:$vm, V64:$vd, VLS:$vl), 
//               !strconcat(opcStr, " $vx,$sy,$vm"), []> {
//    bits<4> vm;
//    let cy = 1;
//    let vy = 0;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def im : RV2<opc, (outs V64:$vx),
//               (ins immOp:$sy, MaskRC:$vm, V64:$vd, VLS:$vl), 
//               !strconcat(opcStr, " $vx,$sy,$vm"), []> {
//    bits<4> vm;
//    let cy = 0;
//    let vy = 0;
//    let m = vm;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}
//
//let cx = 0, cx2 = 0 in defm VBRD : VBRDm<"vbrd", 0x8C, VM, I64, simm7Op64>;   // 64b
//let cx = 1, cx2 = 0 in defm VBRDl : VBRDm<"vbrdl", 0x8C, VM, I64, simm7Op64>; // 32b lower (= i32/u32)
//let cx = 0, cx2 = 1 in defm VBRDu : VBRDm<"vbrdu", 0x8C, VM, I64, simm7Op64>; // 32b uppper(= f32)
//let cx = 1, cx2 = 1 in defm VBRDp : VBRDm<"pvbrd", 0x8C, VM512, I64, simm7Op64>; // 32b packed
//
//let cx = 0, cx2 = 0, isCodeGenOnly = 1 in defm VBRDf64 : VBRDm<"vbrd", 0x8C, VM, I64, simm7Op64>;
//let cx = 0, cx2 = 0, isCodeGenOnly = 1 in defm VBRDf32 : VBRDm<"vbrdu", 0x8C, VM, F32, simm7Op64>;
//let cx = 0, cx2 = 0, isCodeGenOnly = 1 in defm VBRDi32 : VBRDm<"vbrdl", 0x8C, VM, I32, simm7Op32>;

//multiclass VMVm<string opcStr, bits<8> opc> {
//  def r : RV<opc, (outs V64:$vx), (ins I32:$sy, V64:$vz, VLS:$vl),
//             !strconcat(opcStr, " $vx,$sy,$vz"), []> {
//    let cy = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def i : RVM<opc, (outs V64:$vx), (ins uimm7Op32:$sy, V64:$vz, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sy,$vz"), []> {
//    let cy = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def rm : RV<opc, (outs V64:$vx),
//              (ins I32:$sy, V64:$vz, VM:$vm, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
//    bits<4> vm;
//    let cy = 1;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def im : RVM<opc, (outs V64:$vx),
//               (ins uimm7Op32:$sy, V64:$vz, VM:$vm, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
//    bits<4> vm;
//    let cy = 0;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}

//defm VMV : VMVm<"vmv", 0x9C>;

//let hasSideEffects = 0, DisableEncoding = "$vl" in {
//  def PFCHVr : RVM<0x80, (outs), (ins I64:$sy, I64:$sz, VLS:$vl),
//                   "pfchv $sy,$sz", []> {
//    let cy = 1;
//    let cz = 1;
//  }
//  def PFCHVi : RVM<0x80, (outs), (ins simm7Op64:$sy, I64:$sz, VLS:$vl),
//                   "pfchv $sy,$sz", []> {
//    let cy = 0;
//    let cz = 1;
//  }
//}

// Pseudo instructions for VR/VM/VM512 spill/restore
//
// These pseudo instructions are used for only spill/restore since
// InlineSpiller asusmes storeRegToStackSlot/loadRegFromStackSlot functions
// emit only single instruction.  Those functions emit a single store/load
// instruction or one of these pseudo store/load instructions.
//
// Specifies hasSideEffects = 0 to disable UnmodeledSideEffects.

let mayLoad = 1, hasSideEffects = 0 in {
def LDVRri : Pseudo<
    (outs V64:$vx), (ins MEMri:$addr, VLS:$vl),
    "# pseudo ldvr $vx, $addr, $vl", []>;
def LDVMri : Pseudo<
    (outs VM:$vmx), (ins MEMri:$addr),
    "# pseudo ldvm $vmx, $addr", []>;
def LDVM512ri : Pseudo<
    (outs VM512:$vmx), (ins MEMri:$addr),
    "# pseudo ldvm512 $vmx, $addr", []>;
def LDVLri : Pseudo<
    (outs VLS:$vl), (ins MEMri:$addr),
    "# pseudo ldvls $vl, $addr", []>;
}
let mayStore = 1, hasSideEffects = 0 in {
def STVRri : Pseudo<
    (outs), (ins MEMri:$addr, V64:$vx, VLS:$vl),
    "# pseudo stvr $addr, $vx, $vl", []>;
def STVMri : Pseudo<
    (outs), (ins MEMri:$addr, VM:$vmx),
    "# pseudo stvm $addr, $vmx", []>;
def STVM512ri : Pseudo<
    (outs), (ins MEMri:$addr, VM512:$vmx),
    "# pseudo stvm512 $addr, $vmx", []>;
def STVLri : Pseudo<
    (outs), (ins MEMri:$addr, VLS:$vl),
    "# pseudo stvl $addr, $vl", []>;
}

// 5.3.2.8. Vector Fixed-Point Arithmetic Operation Instructions
//defm VADD : RVUVLm<"vaddu", 0xC8>;
//defm VADS : RVWVLm<"vadds", 0xCA>;
//defm VADX : RVLVLm<"vadds", 0x8B>;
//defm VSUB : RVUVLm<"vsubu", 0xD8>;
//defm VSBS : RVWVLm<"vsubs", 0xDA>;
//defm VSBX : RVLVLm<"vsubs", 0x9B>;
//defm VMPY : RVLWVLm<"vmulu", 0xC9>;   // mul unsigned 64b/32b
//defm VMPS : RVEXVLm<"vmuls", 0xCB>; // mul signed 32b sx/zx
//defm VMPX : RVLVLm<"vmuls", 0xDB>;   // mul signed 64b
//defm VMPD : RV3VLm<"vmuls.l.w", 0xD9, I32, VM, simm7Op32>; // mul signed 32b -> 64b
//
//defm VDIV : RVLWVLm<"vdivu", 0xE9>;
//let cx2 = 0 in defm VDIVl : RV3DIVBYSm<"vdivu.l", 0xE9, I64, VM, simm7Op64>;
//let cx2 = 1 in defm VDIVw : RV3DIVBYSm<"vdivu.w", 0xE9, I32, VM, simm7Op32>;
//defm VDVS : RVEXVLm<"vdivs", 0xEB>;
//let cx2 = 0 in defm VDVSwsx : RV3DIVBYSm<"vdivs.w.sx", 0xEB, I32, VM, simm7Op32>;
//let cx2 = 1 in defm VDVSwzx : RV3DIVBYSm<"vdivs.w.zx", 0xEB, I32, VM, simm7Op32>;
//defm VDVX : RVLVLm<"vdivs", 0xFB>;
//defm VDVXl : RV3DIVBYSm<"vdivs.l", 0xFB, I64, VM, simm7Op64>;
//defm VCMP : RVUVLm<"vcmpu", 0xB9>;
//defm VCPS : RVWVLm<"vcmps", 0xFA>;
//defm VCPX : RVLVLm<"vcmps", 0xBA>;
//let cs2 = 0 in defm VCMSa : RVWVLm<"vmaxs", 0x8A>;
//let cs2 = 1 in defm VCMSi : RVWVLm<"vmins", 0x8A>;
//let cs2 = 0 in defm VCMXa : RVLVLm<"vmaxs", 0x9A>;
//let cs2 = 1 in defm VCMXi : RVLVLm<"vmins", 0x9A>;

// 5.3.2.9. Vector Logical Arithmetic Operation Instructions
//defm VAND : RVLOGm<"vand", 0xC4>;
defm VOR  : RVLOGm<"vor", 0xC5>;
//defm VXOR : RVLOGm<"vxor", 0xC6>;
//defm VEQV : RVLOGm<"veqv", 0xC7>;

//multiclass VSEQm<string opcStr, RegisterClass RegMask> {
//  def v : RV<0x99, (outs V64:$vx), (ins VLS:$vl),
//             !strconcat(opcStr, " $vx"), []> {
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def vm : RV<0x99, (outs V64:$vx), (ins RegMask:$vm, VLS:$vl),
//             !strconcat(opcStr, " $vx"), []> {
//    bits<4> vm;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}
//
//let cx = 0, cx2 = 0 in defm VSEQ : VSEQm<"vseq", VM>;
//let cx = 0, cx2 = 1 in defm VSEQl : VSEQm<"pvseq.lo", VM>;
//let cx = 1, cx2 = 0 in defm VSEQu : VSEQm<"pvseq.up", VM>;
//let cx = 1, cx2 = 1 in defm VSEQp : VSEQm<"pvseq", VM512>;

// 5.3.2.10. Vector Shift Instructions

//multiclass Shift<string opcStr, bits<8> opc, RegisterClass MaskRC> {
//  def v : RV3<opc, (outs V64:$vx), (ins V64:$vz, V64:$vy, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vz,$vy"), []> {
//    let cs = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  // vvs is r2 (vsv is r)
//  def r2 : RV3<opc, (outs V64:$vx), (ins V64:$vz, I64:$sy, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vz,$sy"), []> {
//    let cs = 1;
//    let cy = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def i2 : RV3<opc, (outs V64:$vx), (ins V64:$vz, uimm6Op64:$sy, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vz,$sy"), []> {
//    let cs = 1;
//    let cy = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def vm : RV3<opc, (outs V64:$vx),
//               (ins V64:$vz, V64:$vy, MaskRC:$vm, V64:$vd, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vz,$vy,$vm"), []> {
//    bits<4> vm;
//    let cs = 0;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let Constraints = "$vx = $vd";
//    let hasSideEffects = 0;
//  }
//  def rm2 : RV3<opc, (outs V64:$vx),
//                (ins V64:$vz, I64:$sy, MaskRC:$vm, V64:$vd, VLS:$vl),
//                !strconcat(opcStr, " $vx,$vz,$sy,$vm"), []> {
//    bits<4> vm;
//    let cs = 1;
//    let cy = 1;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let Constraints = "$vx = $vd";
//    let hasSideEffects = 0;
//  }
//  def im2 : RV3<opc, (outs V64:$vx),
//                (ins V64:$vz, uimm6Op64:$sy, MaskRC:$vm, V64:$vd, VLS:$vl),
//                !strconcat(opcStr, " $vx,$vz,$sy,$vm"), []> {
//    bits<4> vm;
//    let cs = 1;
//    let cy = 0;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let Constraints = "$vx = $vd";
//    let hasSideEffects = 0;
//  }
//}
//multiclass ShiftPacked<string opcStr, bits<8> opc> {
//  let cx = 0, cx2 = 1 in defm l : Shift<!strconcat("p", opcStr, ".lo"),
//                                        opc, VM>;
//  let cx = 1, cx2 = 0 in defm u : Shift<!strconcat("p", opcStr, ".up"),
//                                        opc, VM>;
//  let cx = 1, cx2 = 1 in defm p : Shift<!strconcat("p", opcStr), opc, VM512>;
//}
//multiclass ShiftWithPacked<string opcStr, bits<8> opc> {
//  let cx = 0, cx2 = 0 in defm "" : Shift<opcStr, opc, VM>;
//  let cx = 0, cx2 = 1 in defm l : Shift<!strconcat("p", opcStr, ".lo"),
//                                        opc, VM>;
//  let cx = 1, cx2 = 0 in defm u : Shift<!strconcat("p", opcStr, ".up"),
//                                        opc, VM>;
//  let cx = 1, cx2 = 1 in defm p : Shift<!strconcat("p", opcStr), opc, VM512>;
//}
//
//defm VSLL : ShiftWithPacked<"vsll", 0xE5>;
//// VSLD
//defm VSRL : ShiftWithPacked<"vsrl", 0xF5>;
//// VSRD
//defm VSLA : Shift<"vsla.w", 0xE6, VM>;
//defm VSLA : ShiftPacked<"vsla", 0xE6>;
//defm VSLAX : Shift<"vsla.l", 0xD4, VM>;
//defm VSRA : Shift<"vsra.w", 0xF6, VM>;
//defm VSRA : ShiftPacked<"vsra", 0xF6>;
//defm VSRAX : Shift<"vsra.l", 0xD5, VM>;
//
//multiclass ShiftAdd<string opcStr, bits<8> opc, RegisterClass MaskRC> {
//  // vvs is r2 (vsv is r)
//  def r2 : RV3<opc, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vz,$sy,$sz"), []> {
//    let cy = 1;
//    let cz = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def i2 : RV3<opc, (outs V64:$vx),
//               (ins V64:$vz, uimm6Op64:$sy, I64:$sz, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vz,$sy,$sz"), []> {
//    let cy = 0;
//    let cz = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def rm2 : RV3<opc, (outs V64:$vx),
//                (ins V64:$vz, I64:$sy, I64:$sz, MaskRC:$vm, V64:$vd, VLS:$vl),
//                !strconcat(opcStr, " $vx,$vz,$sy,$sz,$vm"), []> {
//    bits<4> vm;
//    let cy = 1;
//    let cz = 1;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let Constraints = "$vx = $vd";
//    let hasSideEffects = 0;
//  }
//  def im2 : RV3<opc, (outs V64:$vx),
//                (ins V64:$vz, uimm6Op64:$sy, I64:$sz, MaskRC:$vm, V64:$vd,
//                     VLS:$vl),
//                !strconcat(opcStr, " $vx,$vz,$sy,$sz,$vm"), []> {
//    bits<4> vm;
//    let cy = 0;
//    let cz = 1;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let Constraints = "$vx = $vd";
//    let hasSideEffects = 0;
//  }
//}
//
//defm VSFA : ShiftAdd<"vsfa", 0xD7, VM>;

// 5.3.2.11 Vector Floating-Point Arithmetic Operation Instructions

//multiclass VFSQRTm<string opcStr, bits<8> opc> {
//  let cx = 0 in defm d : RV2vm<opcStr # ".d", opc, VM>;
//  let cx = 1 in defm s : RV2vm<opcStr # ".s", opc, VM>;
//}
//
//multiclass VRCPm<string opcStr, bits<8> opc> {
//  let cx = 0, cx2 = 0 in defm d : RV2vm<opcStr # ".d", opc, VM>;
//  let cx = 1, cx2 = 0 in defm s : RV2vm<opcStr # ".s", opc, VM>;
//  let cx = 1, cx2 = 1 in defm p : RV2vm<"p" # opcStr, opc, VM>;
//}
//
//multiclass VRSQRTm<string opcStr, bits<8> opc> {
//  let cx = 0, cx2 = 0 in defm d : RV2vm<opcStr # ".d", opc, VM>;
//  let cx = 1, cx2 = 0 in defm s : RV2vm<opcStr # ".s", opc, VM>;
//  let cx = 1, cx2 = 1 in defm p : RV2vm<"p" # opcStr, opc, VM>;
//  let cx = 0, cx2 = 0, cs2 = 1 in defm dnex : RV2vm<opcStr # ".d.nex", opc, VM>;
//  let cx = 1, cx2 = 0, cs2 = 1 in defm snex : RV2vm<opcStr # ".s.nex", opc, VM>;
//  let cx = 1, cx2 = 1, cs2 = 1 in defm pnex : RV2vm<"p" # opcStr # ".nex", opc, VM>;
//}
//
//defm VFAD : RVDSPm<"vfadd", 0xCC>;
//defm VFSB : RVDSPm<"vfsub", 0xDC>;
//defm VFMP : RVDSPm<"vfmul", 0xCD>;
//defm VFDV : RVDSPm<"vfdiv", 0xDD>;
//defm VFSQRT : VFSQRTm<"vfsqrt", 0xED>;
//defm VFCP : RVDSPm<"vfcmp", 0xFC>;
//let cs2 = 0 in defm VFCMa : RVDSPm<"vfmax", 0xBD>;
//let cs2 = 1 in defm VFCMi : RVDSPm<"vfmin", 0xBD>;
//defm VFMAD : RV4DSPm<"vfmad", 0xE2>;
//defm VFMSB : RV4DSPm<"vfmsb", 0xF2>;
//defm VFNMAD : RV4DSPm<"vfnmad", 0xE3>;
//defm VFNMSB : RV4DSPm<"vfnmsb", 0xF3>;
//defm VRCP : VRCPm<"vrcp", 0xE1>;
//defm VRSQRT : VRSQRTm<"vrsqrt", 0xF1>;
//
//multiclass VCVT<bits<8>opc, string opcStr> {
//  def v : RV2<opc, (outs V64:$vx), (ins V64:$vy, VLS:$vl), 
//              !strconcat(opcStr, " $vx,$vy"), []> {
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}
//
//multiclass VFIXCm<bits<8>opc, string opcStr, RegisterClass MaskRC> {
//  def v : RV3<opc, (outs V64:$vx), (ins V64:$vy, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vy"), []> {
//    bits<4> rvz;
//    let m = 0;
//    let vz{7-4} = 0;
//    let vz{3-0} = rvz;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def vm : RV3<opc, (outs V64:$vx), (ins V64:$vy, MaskRC:$vm, V64:$vd, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,$vm"), []> {
//    bits<4> rvz;
//    bits<4> vm;
//    let m = vm;
//    let vz{7-4} = 0;
//    let vz{3-0} = rvz;
//    let Constraints = "$vx = $vd";
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}
//
//multiclass VFIX<bits<8>opc, string opcStr, RegisterClass MaskRC> {
//  let rvz = 0 in defm "" : VFIXCm<opc, opcStr, MaskRC>;
//  let rvz = 8 in defm rz : VFIXCm<opc, !strconcat(opcStr, ".rz"), MaskRC>;
//}
//
//let cx = 0, cx2 = 0, cs2 = 0 in defm VFIXdsx : VFIX<0xE8, "vcvt.w.d.sx", VM>;
//let cx = 0, cx2 = 1, cs2 = 0 in defm VFIXdzx : VFIX<0xE8, "vcvt.w.d.zx", VM>;
//let cx = 1, cx2 = 0, cs2 = 0 in defm VFIXssx : VFIX<0xE8, "vcvt.w.s.sx", VM>;
//let cx = 1, cx2 = 1, cs2 = 0 in defm VFIXszx : VFIX<0xE8, "vcvt.w.s.zx", VM>;
//let cx = 1, cx2 = 1, cs2 = 1 in defm VFIXp : VFIX<0xE8, "pvcvt.w.s", VM512>;
//defm VFIXX : VFIX<0xA8, "vcvt.l.d", VM>;
//
//let cx = 0, cx2 = 0, cs2 = 0 in defm VFLTd : VCVT<0xF8, "vcvt.d.w">;
//let cx = 1, cx2 = 0, cs2 = 1 in defm VFLTs : VCVT<0xF8, "vcvt.s.w">;
//let cx = 1, cx2 = 1, cs2 = 1 in defm VFLTp : VCVT<0xF8, "pvcvt.s.w">;
//defm VFLTX : VCVT<0xB8, "vcvt.d.l">;
//defm VCVD : VCVT<0x8F, "vcvt.d.s">;
//defm VCVS : VCVT<0x9F, "vcvt.s.d">;


// 5.3.2.12. Vector Mask Arithmetic Instructions

// i64, packed i32
//multiclass RV3VL_wobase_m<string opcStr, bits<8> opc, RegisterClass ScalarRC,
//                  RegisterClass MaskRC, Operand immOp> {
//  def i : RV3<opc, (outs V64:$vx), (ins immOp:$sy, V64:$vz, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sy,$vz"), []> {
//    let cs = 1;
//    let cy = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def r : RV3<opc, (outs V64:$vx), (ins ScalarRC:$sy, V64:$vz, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sy,$vz"), []> {
//    let cs = 1;
//    let cy = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def v : RV3<opc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vy,$vz"), []> {
//    let cs = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def im : RV3<opc, (outs V64:$vx),
//               (ins immOp:$sy, V64:$vz, MaskRC:$vm, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
//    let cs = 1;
//    let cy = 0;
//    bits<4> vm;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def rm : RV3<opc, (outs V64:$vx),
//               (ins ScalarRC:$sy, V64:$vz, MaskRC:$vm, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sy,$vz,$vm"), []> {
//    let cs = 1;
//    let cy = 1;
//    bits<4> vm;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def vm : RV3<opc, (outs V64:$vx),
//               (ins V64:$vy, V64:$vz, MaskRC:$vm, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,$vz,$vm"), []> {
//    let cs = 0;
//    bits<4> vm;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}
//
//multiclass VMRGm<string opcStr, bits<8> opc> {
//  let cx = 0 in defm "" : RV3VL_wobase_m<opcStr, opc, I64, VM, simm7Op64>; // i64
//  let cx = 1 in defm p : RV3VL_wobase_m<opcStr # ".w", opc, I64, VM512, simm7Op64>; // packed i32
//}
//defm VMRG : VMRGm<"vmrg", 0xD6>;

//let cy = 0 in
//def VSHFi : RV3<0xBC, (outs V64:$vx),
//                (ins V64:$vy, V64:$vz, uimm6Op64:$sy, VLS:$vl),
//                "vshf $vx,$vy,$vz,$sy", []> {
//  let DisableEncoding = "$vl";
//  let hasSideEffects = 0;
//}
//let cy = 1 in
//def VSHFr : RV3<0xBC, (outs V64:$vx),
//                (ins V64:$vy, V64:$vz, I64:$sy, VLS:$vl),
//                "vshf $vx,$vy,$vz,$sy", []> {
//  let DisableEncoding = "$vl";
//  let hasSideEffects = 0;
//}
//
//class VCPEX<bits<8> opc, string opcStr> 
//  : RV<opc, (outs V64:$vx), (ins V64:$vz, VM:$vm, V64:$vd, VLS:$vl),
//       !strconcat(opcStr, " $vx,$vz,$vm"), []> {
//  bits<4> vm;
//  let m = vm;
//  let Constraints = "$vx = $vd";
//  let DisableEncoding = "$vl";
//}
//
//let hasSideEffects = 0 in {
//def VCPvm : VCPEX<0x8D, "vcp">;
//def VEXvm : VCPEX<0x9D, "vex">;
//}
//
//multiclass VFMKm<string opcStr, bits<8> opc> {
//  def v : RV<opc, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VLS:$vl),
//             !strconcat(opcStr, ".${cf} $vmx,$vz"), []> {
//    bits<4> vmx;
//    bits<4> cf;
//    let Inst{39-36} = vmx;
//    let Inst{47-44} = cf;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//
//  def vm : RV<opc, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm, VLS:$vl),
//              !strconcat(opcStr, ".${cf} $vmx,$vz,$vm"), []> {
//    bits<4> vm;
//    bits<4> vmx;
//    bits<4> cf;
//    let m = vm;
//    let Inst{39-36} = vmx;
//    let Inst{47-44} = cf;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}
//
//let cx = 0 in defm VFMK : VFMKm<"vfmk.l", 0xB4>;
//let cx = 0 in defm VFMS : VFMKm<"vfmk.w", 0xB5>;
//let cx = 1 in defm VFMSu : VFMKm<"pvfmk.w.up", 0xB5>;
//let cx = 0, cx2 = 0 in defm VFMFd : VFMKm<"vfmk.d", 0xB6>;
//let cx = 1, cx2 = 0 in defm VFMFs : VFMKm<"vfmk.s", 0xB6>;
//let cx = 0, cx2 = 1 in defm VFMFl : VFMKm<"pvfmk.s.lo", 0xB6>;
//
//// at and af 64b
//let DisableEncoding = "$vl", hasSideEffects = 0 in {
//  let sy = 0, vy = 0xf, vz = 0, vw = 0, m = 0 in
//  def VFMKat : RV<0xB4, (outs VM:$vm), (ins VLS:$vl), "vfmk.l.at $vm", []>;
//  let sy = 0, vy = 0x0, vz = 0, vw = 0, m = 0 in
//  def VFMKaf : RV<0xB4, (outs VM:$vm), (ins VLS:$vl), "vfmk.l.af $vm", []>;
//}
//
//// at and af for 32b lower and upper
//let DisableEncoding = "$vl", hasSideEffects = 0 in {
//  let cx = 0, sy = 0, vy = 0xf, vz = 0, vw = 0, m = 0 in
//  def VFMSuat : RV<0xB5, (outs VM:$vm), (ins VLS:$vl), "pvfmk.w.up.at $vm", []>;
//  let cx = 1, sy = 0, vy = 0xf, vz = 0, vw = 0, m = 0 in
//  def VFMSlat : RV<0xB5, (outs VM:$vm), (ins VLS:$vl), "vfmk.w.at $vm", []>;
//  let cx = 0, sy = 0, vy = 0x0, vz = 0, vw = 0, m = 0 in
//  def VFMSuaf : RV<0xB5, (outs VM:$vm), (ins VLS:$vl), "pvfmk.w.up.af $vm", []>;
//  let cx = 1, sy = 0, vy = 0x0, vz = 0, vw = 0, m = 0 in
//  def VFMSlaf : RV<0xB5, (outs VM:$vm), (ins VLS:$vl), "vfmk.w.af $vm", []>;
//}
//
//// Pseudo for VM512
//let DisableEncoding = "$vl", hasSideEffects = 0 in {
//  def VFMSpv : PseudoVec<(outs VM512:$vmx), (ins CCOp:$cf, V64:$vz, VLS:$vl), 
//                         "# pvfmk.w.${cf} $vmx,$vz", []>;
//  def VFMSpvm : PseudoVec<(outs VM512:$vmx),
//                          (ins CCOp:$cf, V64:$vz, VM512:$vm, VLS:$vl), 
//                          "# pvfmk.w.${cf} $vmx,$vz,$vm", []>;
//  def VFMFpv : PseudoVec<(outs VM512:$vm), (ins CCOp:$cf, V64:$vz, VLS:$vl), 
//                         "# pvfmk.w.${cf} $vm,$vz", []>;
//  def VFMFpvm : PseudoVec<(outs VM512:$vmx),
//                          (ins CCOp:$cf, V64:$vz, VM512:$vm, VLS:$vl), 
//                          "# pvfmk.w.${cf} $vmx,$vz,$vm", []>;
//  def VFMKpat : PseudoVec<(outs VM512:$vm), (ins VLS:$vl), "# pvfmk.at", []>;
//  def VFMKpaf : PseudoVec<(outs VM512:$vm), (ins VLS:$vl), "# pvfmk.af", []>;
//}

// 5.3.2.13. Vector Recursive Relation Instructions
//multiclass RVRECm<string opcStr, bits<8> opc> {
//  def v : RV2<opc, (outs V64:$vx), (ins V64:$vy, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vy"), []> {
//    let sy = 0;
//    let m = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//  def vm : RV2<opc, (outs V64:$vx), (ins V64:$vy, VM:$vm, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,$vm"), []> {
//    bits<4> vm;
//    let sy = 0;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//  }
//}
//let cx2 = 0 in defm VSUMSsx : RVRECm<"vsum.w.sx", 0xEA>;
//let cx2 = 1 in defm VSUMSzx : RVRECm<"vsum.w.zx", 0xEA>;
//defm VSUMX : RVRECm<"vsum.l", 0xAA>;
//let cx = 0 in defm VFSUMd : RVRECm<"vfsum.d", 0xEC>;
//let cx = 1 in defm VFSUMs : RVRECm<"vfsum.s", 0xEC>;
//
//multiclass FLSXm<bits<8> opc, string opcStr>
//{
//  let cx2 = 0, cs = 0 in defm fsx : RVRECm<opcStr#".fst.sx", opc>;
//  let cx2 = 1, cs = 0 in defm fzx : RVRECm<opcStr#".fst.zx", opc>;
//  let cx2 = 0, cs = 1 in defm lsx : RVRECm<opcStr#".lst.sx", opc>;
//  let cx2 = 1, cs = 1 in defm lzx : RVRECm<opcStr#".lst.zx", opc>;
//}
//
//multiclass FLm<bits<8> opc, string opcStr>
//{
//  let cs2 = 0, cs = 0 in defm f : RVRECm<opcStr#".fst", opc>;
//  let cs2 = 1, cs = 1 in defm l : RVRECm<opcStr#".lst", opc>;
//}
//
//let cs2 = 0 in defm VMAXSa : FLSXm<0xBB, "vrmaxs.w">;
//let cs2 = 1 in defm VMAXSi : FLSXm<0xBB, "vrmins.w">;
//
//let cs2 = 0 in defm VMAXXa : FLm<0xAB, "vrmaxs.l">;
//let cs2 = 1 in defm VMAXXi : FLm<0xAB, "vrmins.l">;
//
//let cx = 0, cs2 = 0 in defm VFMAXad : FLm<0xAD, "vfrmax.d">;
//let cx = 1, cs2 = 0 in defm VFMAXas : FLm<0xAD, "vfrmax.s">;
//let cx = 0, cs2 = 1 in defm VFMAXid : FLm<0xAD, "vfrmin.d">;
//let cx = 1, cs2 = 1 in defm VFMAXis : FLm<0xAD, "vfrmin.s">;

// 5.3.2.14. Vector Gatering/Scattering Instructions

//multiclass VGTCm<string opcStr, bits<8> opc> {
//  def v : RVM<opc, (outs V64:$vx), (ins V64:$vy, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vy,0,0"), []> {
//    let cs = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayLoad = 1;
//  }
//  def r : RVM<opc, (outs V64:$vx), (ins I64:$sw, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sw,0,0"), []> {
//    let cs = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayLoad = 1;
//  }
//  def vm : RVM<opc, (outs V64:$vx), (ins V64:$vy, VM:$vm, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,0,0,$vm"), []> {
//    bits<4> vm;
//    let cs = 0;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayLoad = 1;
//  }
//  def rm : RVM<opc, (outs V64:$vx), (ins I64:$sw, VM:$vm, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sw,0,0,$vm"), []> {
//    bits<4> vm;
//    let cs = 1;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayLoad = 1;
//  }
//}
//
//multiclass VGTm<string opcStr, bits<8> opc> {
//  let vc = 1 in defm "" : VGTCm<opcStr, opc>;
//  let vc = 0 in defm nc : VGTCm<!strconcat(opcStr, ".nc"), opc>;
//}
//
//multiclass VSCCm<string opcStr, bits<8> opc> {
//  def v : RVM<opc, (outs), (ins V64:$vx, V64:$vy, VLS:$vl),
//              !strconcat(opcStr, " $vx,$vy,0,0"), []> {
//    let cs = 0;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def r : RVM<opc, (outs), (ins V64:$vx, I64:$sw, VLS:$vl),
//              !strconcat(opcStr, " $vx,$sw,0,0"), []> {
//    let cs = 1;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def vm : RVM<opc, (outs), (ins V64:$vx, V64:$vy, VM:$vm, VLS:$vl),
//               !strconcat(opcStr, " $vx,$vy,0,0,$vm"), []> {
//    bits<4> vm;
//    let cs = 0;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//  def rm : RVM<opc, (outs), (ins V64:$vx, I64:$sw, VM:$vm, VLS:$vl),
//               !strconcat(opcStr, " $vx,$sw,0,0,$vm"), []> {
//    bits<4> vm;
//    let cs = 1;
//    let m = vm;
//    let DisableEncoding = "$vl";
//    let hasSideEffects = 0;
//    let mayStore = 1;
//  }
//}
//
//multiclass VSCm<string opcStr, bits<8> opc> {
//  let vc = 1, cx = 0 in defm "" : VSCCm<opcStr, opc>;
//  let vc = 0, cx = 0 in defm nc : VSCCm<!strconcat(opcStr, ".nc"), opc>;
//  let vc = 1, cx = 1 in defm ot : VSCCm<!strconcat(opcStr, ".ot"), opc>;
//  let vc = 0, cx = 1 in defm ncot : VSCCm<!strconcat(opcStr, ".nc.ot"), opc>;
//}
//
//defm VGT : VGTm<"vgt", 0xA1>;
//defm VGTU : VGTm<"vgtu", 0xA2>;
//let cx = 0 in defm VGTLsx : VGTm<"vgtl.sx", 0xA3>;
//let cx = 1 in defm VGTLzx : VGTm<"vgtl.zx", 0xA3>;
//defm VSC : VSCm<"vsc", 0xB1>;
//defm VSCU : VSCm<"vscu", 0xB2>;
//defm VSCL : VSCm<"vscl", 0xB3>;

// 5.3.2.15. Vector Mask Register Instructions

//class VMR3<bits<8> op, string asm> 
//  : RV<op, (outs VM:$vmx), (ins VM:$vmy, VM:$vmz),
//        !strconcat(asm, " $vmx,$vmy,$vmz"), []> {
//  let sy = 0;
//  let vw = 0;
//  let m = 0;
//}
//
//class VMR2<bits<8> op, string asm> 
//  : RV<op, (outs VM:$vmx), (ins VM:$vmy),
//        !strconcat(asm, " $vmx,$vmy"), []> {
//  let sy = 0;
//  let vz = 0;
//  let vw = 0;
//  let m = 0;
//}
//
//class VMR1VL<bits<8> op, string asm> 
//  : RV<op, (outs I64:$sx), (ins VM:$vmy, VLS:$vl),
//       !strconcat(asm, " $sx,$vmy"),  []> {
//    bits<7> sx;
//    bits<4> vmy;
//    let Inst{15-9} = sx;
//    let Inst{47-44} = vmy;
//    let DisableEncoding = "$vl";
//}

//let hasSideEffects = 0 in {
//def ANDM : VMR3<0x84, "andm">;
//def ORM :  VMR3<0x85, "orm">;
//def XORM : VMR3<0x86, "xorm">;
//def EQVM : VMR3<0x87, "eqvm">;
//def NNDM : VMR3<0x94, "nndm">;
//def NEGM : VMR2<0x95, "negm">;
//def PCVM : VMR1VL<0xA4, "pcvm">;
//def LZVM : VMR1VL<0xA5, "lzvm">;
//def TOVM : VMR1VL<0xA6, "tovm">;
//
//def ANDMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
//def ORMp  : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
//def XORMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
//def EQVMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
//def NNDMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy, VM512:$vmz), "", []>;
//def NEGMp : PseudoVec<(outs VM512:$vmx), (ins VM512:$vmy), "", []>;
//}

// 5.3.2.16. Vector Control Instructions
// SVL
// SMVL
// LVIX

let cx = 0, sx = 0, cy = 0, cz = 0, sz = 0, DisableEncoding = "$vl", hasSideEffects = 0 in
def LVL : RR<0xBF, (outs VLS:$vl), (ins I32:$sy), "lvl $sy", []>;

let cx = 0, sx = 0, cy = 0, cz = 0, sz = 0, hasSideEffects = 0, isCodeGenOnly = 1 in
def LVL2 : RR<0xBF, (outs), (ins I32:$sy), "lvl $sy", []>;

let cx = 0, sx = 0, cy = 0, cz = 0, sz = 0, DisableEncoding = "$vl", hasSideEffects = 0 in
def SVL : RR<0x2F, (outs I32:$sx), (ins VLS:$vl), "svl $sx", []>;

// Pseudo instructions for bitconvert

let hasSideEffects = 0 in {
def VM2V : Pseudo<(outs V64:$vx), (ins VM:$vmy),
  "# vm2v $vx,$vmy", []>;

def VMP2V : Pseudo<(outs V64:$vx), (ins VM512:$vmy),
  "# vmp2v $vx,$vmy", []>;

def V2VM : Pseudo<(outs VM:$vmx), (ins V64:$vy),
  "# v2vm $vmx,$vy", []>;

def V2VMP : Pseudo<(outs VM512:$vmx), (ins V64:$vy),
  "# v2vmp $vmx,$vy", []>;
}

