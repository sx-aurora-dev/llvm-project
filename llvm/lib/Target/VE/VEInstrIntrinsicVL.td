// Pattern Matchings for VEL Intrinsics

def : Pat<(int_ve_vl_svob), (SVOB)>;
def : Pat<(i64 (int_ve_vl_pack_f32p ADDRrii:$addr0, ADDRrii:$addr1)),
          (ORrr (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
                               (LDUrii MEMrii:$addr0), sub_f32),
                (INSERT_SUBREG (i64 (IMPLICIT_DEF)),
                               (LDLZXrii MEMrii:$addr1), sub_i32))>;

def : Pat<(i64 (int_ve_vl_pack_f32a ADDRrii:$addr)),
          (i64 (MULULrr
            (INSERT_SUBREG (i64 (IMPLICIT_DEF)), (LDLZXrii MEMrii:$addr), sub_i32),
            (LEASLrii (ANDrm (LEAzii 0, 0, (LO32 (i64 0x0000000100000001))),
                             !add(32, 64)), 0,
                      (HI32 (i64 0x0000000100000001)))))>;

def : Pat<(v256i1 (int_ve_vl_extract_vm512u v512i1:$vm)),
          (v256i1 (EXTRACT_SUBREG v512i1:$vm, sub_vm_even))>;

def : Pat<(v256i1 (int_ve_vl_extract_vm512l v512i1:$vm)),
          (v256i1 (EXTRACT_SUBREG v512i1:$vm, sub_vm_odd))>;

def : Pat<(v512i1 (int_ve_vl_insert_vm512u v512i1:$vmx, v256i1:$vmy)),
          (v512i1 (INSERT_SUBREG v512i1:$vmx, v256i1:$vmy, sub_vm_even))>;

def : Pat<(v512i1 (int_ve_vl_insert_vm512l v512i1:$vmx, v256i1:$vmy)),
          (v512i1 (INSERT_SUBREG v512i1:$vmx, v256i1:$vmy, sub_vm_odd))>;

def : Pat<(int_ve_vl_lvss_svs v256f64:$vx, i32:$sy),
          (EXTRACT_SUBREG (i64 (LVSvr v256f64:$vx, (INSERT_SUBREG (i64 (IMPLICIT_DEF)), i32:$sy, sub_i32))), sub_f32)>;

// For i32->i64 conversion

def : Pat<(int_ve_vl_lsv_vvss v256f64:$pt, i32:$sy, i64:$sz), (LSVrr_v (INSERT_SUBREG (i64 (IMPLICIT_DEF)), i32:$sy, sub_i32), i64:$sz, v256f64:$pt)>;
def : Pat<(int_ve_vl_lvsl_svs v256f64:$vx, i32:$sy), (LVSvr v256f64:$vx, (INSERT_SUBREG (i64 (IMPLICIT_DEF)), i32:$sy, sub_i32))>;
def : Pat<(int_ve_vl_lvsd_svs v256f64:$vx, i32:$sy), (LVSvr v256f64:$vx, (INSERT_SUBREG (i64 (IMPLICIT_DEF)), i32:$sy, sub_i32))>;

def : Pat<(int_ve_vl_vmrgw_vsvMl i32:$sy, v256f64:$vz, v512i1:$vm, i32:$vl), (VMRGWrvml (INSERT_SUBREG (i64 (IMPLICIT_DEF)), i32:$sy, sub_i32), v256f64:$vz, v512i1:$vm, i32:$vl)>;
def : Pat<(int_ve_vl_vmrgw_vsvMvl i32:$sy, v256f64:$vz, v512i1:$vm, v256f64:$pt, i32:$vl), (VMRGWrvml_v (INSERT_SUBREG (i64 (IMPLICIT_DEF)), i32:$sy, sub_i32), v256f64:$vz, v512i1:$vm, i32:$vl, v256f64:$pt)>;

def : Pat<(int_ve_vl_vmv_vsvl i32:$sy, v256f64:$vz, i32:$vl), (VMVrvl (INSERT_SUBREG (i64 (IMPLICIT_DEF)), i32:$sy, sub_i32), v256f64:$vz, i32:$vl)>;
def : Pat<(int_ve_vl_vmv_vsvvl i32:$sy, v256f64:$vz, v256f64:$pt, i32:$vl), (VMVrvl_v (INSERT_SUBREG (i64 (IMPLICIT_DEF)), i32:$sy, sub_i32), v256f64:$vz, i32:$vl, v256f64:$pt)>;
def : Pat<(int_ve_vl_vmv_vsvmvl i32:$sy, v256f64:$vz, v256i1:$vm, v256f64:$pt, i32:$vl), (VMVrvml_v (INSERT_SUBREG (i64 (IMPLICIT_DEF)), i32:$sy, sub_i32), v256f64:$vz, v256i1:$vm, i32:$vl, v256f64:$pt)>;

include "VEInstrIntrinsicVL.gen.td"
