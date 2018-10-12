//===----------------------------------------------------------------------===//
// Vector Instruction Patterns
//===----------------------------------------------------------------------===//

// Pattern Matchings for Generic Vector Instructions

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

def : Pat<(v256i1 (bitconvert v4i64:$vm)),
          (v256i1 (COPY_TO_REGCLASS $vm, VM))>;

def : Pat<(v4i64 (bitconvert v256i1:$vm)),
          (v4i64 (COPY_TO_REGCLASS $vm, V64))>;

def : Pat<(v512i1 (bitconvert v8i64:$vmp)),
          (v512i1 (COPY_TO_REGCLASS $vmp, VM512))>;

def : Pat<(v8i64 (bitconvert v512i1:$vmp)),
          (v8i64 (COPY_TO_REGCLASS $vmp, V64))>;

