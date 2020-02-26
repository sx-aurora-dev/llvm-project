//===----------------------------------------------------------------------===//
// Vector Instructions
//===----------------------------------------------------------------------===//

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
    "# pseudo ldvr $vx, $addr, $vl">;
def LDVMri : Pseudo<
    (outs VM:$vmx), (ins MEMri:$addr),
    "# pseudo ldvm $vmx, $addr">;
def LDVM512ri : Pseudo<
    (outs VM512:$vmx), (ins MEMri:$addr),
    "# pseudo ldvm512 $vmx, $addr">;
}
let mayStore = 1, hasSideEffects = 0 in {
def STVRri : Pseudo<
    (outs), (ins MEMri:$addr, V64:$vx, I32:$vl),
    "# pseudo stvr $addr, $vx, $vl">;
def STVMri : Pseudo<
    (outs), (ins MEMri:$addr, VM:$vmx),
    "# pseudo stvm $addr, $vmx">;
def STVM512ri : Pseudo<
    (outs), (ins MEMri:$addr, VM512:$vmx),
    "# pseudo stvm512 $addr, $vmx">;
}


// 5.3.2.16. Vector Control Instructions

let cx = 0, sx = 0, cy = 0, cz = 0, sz = 0, hasSideEffects = 0, isCodeGenOnly = 1 in
def LVL : RR<0xBF, (outs), (ins I32:$sy), "lvl $sy">;
