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
    (outs V64:$vx), (ins MEMri:$addr, I32:$vl),
    "# pseudo ldvr $vx, $addr, $vl", []>;
def LDVMri : Pseudo<
    (outs VM:$vmx), (ins MEMri:$addr),
    "# pseudo ldvm $vmx, $addr", []>;
def LDVM512ri : Pseudo<
    (outs VM512:$vmx), (ins MEMri:$addr),
    "# pseudo ldvm512 $vmx, $addr", []>;
}
let mayStore = 1, hasSideEffects = 0 in {
def STVRri : Pseudo<
    (outs), (ins MEMri:$addr, V64:$vx, I32:$vl),
    "# pseudo stvr $addr, $vx, $vl", []>;
def STVMri : Pseudo<
    (outs), (ins MEMri:$addr, VM:$vmx),
    "# pseudo stvm $addr, $vmx", []>;
def STVM512ri : Pseudo<
    (outs), (ins MEMri:$addr, VM512:$vmx),
    "# pseudo stvm512 $addr, $vmx", []>;
}


// 5.3.2.16. Vector Control Instructions

let cx = 0, sx = 0, cy = 0, cz = 0, sz = 0, hasSideEffects = 0, isCodeGenOnly = 1 in
def LVL2 : RR<0xBF, (outs), (ins I32:$sy), "lvl $sy", []>;
