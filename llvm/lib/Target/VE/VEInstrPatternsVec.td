//===----------------------------------------------------------------------===//
// Vector Instruction Patterns
//===----------------------------------------------------------------------===//

// Pattern Matchings for Generic Vector Instructions

// Pattern Fragments for sextload/zextload/truncstore of vector types

def extloadv256i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v256i32;
}]>;
def sextloadv256i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v256i32;
}]>;
def zextloadv256i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v256i32;
}]>;
def extloadv128i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v128i32;
}]>;
def sextloadv128i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v128i32;
}]>;
def zextloadv128i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v128i32;
}]>;
def extloadv64i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v64i32;
}]>;
def sextloadv64i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v64i32;
}]>;
def zextloadv64i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v64i32;
}]>;
def extloadv32i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v32i32;
}]>;
def sextloadv32i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v32i32;
}]>;
def zextloadv32i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v32i32;
}]>;
def extloadv16i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v16i32;
}]>;
def sextloadv16i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v16i32;
}]>;
def zextloadv16i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v16i32;
}]>;
def extloadv8i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v8i32;
}]>;
def sextloadv8i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v8i32;
}]>;
def zextloadv8i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v8i32;
}]>;
def extloadv4i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v4i32;
}]>;
def sextloadv4i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v4i32;
}]>;
def zextloadv4i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v4i32;
}]>;
def extloadv2i32 : PatFrag<(ops node:$ptr), (extload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v2i32;
}]>;
def sextloadv2i32 : PatFrag<(ops node:$ptr), (sextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v2i32;
}]>;
def zextloadv2i32 : PatFrag<(ops node:$ptr), (zextload node:$ptr), [{
  return cast<LoadSDNode>(N)->getMemoryVT() == MVT::v2i32;
}]>;
def truncstorev256i32 : PatFrag<(ops node:$val, node:$ptr),
                                (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v256i32;
}]>;
def truncstorev128i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v128i32;
}]>;
def truncstorev64i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v64i32;
}]>;
def truncstorev32i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v32i32;
}]>;
def truncstorev16i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v16i32;
}]>;
def truncstorev8i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v8i32;
}]>;
def truncstorev4i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v4i32;
}]>;
def truncstorev2i32 : PatFrag<(ops node:$val, node:$ptr),
                              (truncstore node:$val, node:$ptr), [{
  return cast<StoreSDNode>(N)->getMemoryVT() == MVT::v2i32;
}]>;

// Load and store for all vector types
// v2i32, v2i64, v2f32, v2f64, v4i32, v4i64, v4f32, v4f64,
// v8i32, v8i64, v8f32, v8f64, v16i32, v16i64, v16f32, v16f64,
// v32i32, v32i64, v32f32, v32f64, v64i32, v64i64, v64f32, v64f64,
// v128i32, v128i64, v128f32, v128f64, v256i32, v256i64, v256f32, v256f64,
// v512i32, v512f32.

def : Pat<(v512i32 (load I64:$addr)),
          (v512i32 (vld_vIsl 8, $addr, (LEA32zzi 256)))>;

def : Pat<(v512f32 (load I64:$addr)),
          (v512f32 (vld_vIsl 8, $addr, (LEA32zzi 256)))>;

multiclass load_for_vector_length<int length> {
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i32")
              (load I64:$addr)),
            (vldlsx_vIsl 4, $addr, (LEA32zzi length))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "f32")
              (load I64:$addr)),
            (vldu_vIsl 4, $addr, (LEA32zzi length))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "f64")
              (load I64:$addr)),
            (vld_vIsl 8, $addr, (LEA32zzi length))>;
  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
              (load I64:$addr)),
            (vld_vIsl 8, $addr, (LEA32zzi length))>;
//  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
//              (!cast<PatFrag>("extloadv" # !cast<string>(length) # "i32")
//                 I64:$addr)),
//            (VLDLzxir 4, $addr, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
//              (!cast<PatFrag>("sextloadv" # !cast<string>(length) # "i32")
//                 I64:$addr)),
//            (VLDLsxir 4, $addr, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(!cast<ValueType>("v" # !cast<string>(length) # "i64")
//              (!cast<PatFrag>("zextloadv" # !cast<string>(length) # "i32")
//                 I64:$addr)),
//            (VLDLzxir 4, $addr, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : load_for_vector_length<256>;
defm : load_for_vector_length<128>;
defm : load_for_vector_length<64>;
defm : load_for_vector_length<32>;
defm : load_for_vector_length<16>;
defm : load_for_vector_length<8>;
defm : load_for_vector_length<4>;
defm : load_for_vector_length<2>;

//def : Pat<(store v512i32:$vx, I64:$addr),
//          (VSTir v512i32:$vx, 8, $addr, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//
//def : Pat<(store v512f32:$vx, I64:$addr),
//          (VSTir v512f32:$vx, 8, $addr, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass store_for_vector_length<int length> {
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "i32"):$vx,
                   I64:$addr),
	      (vstl_vIsl !cast<ValueType>("v" # !cast<string>(length) # "i32"):$vx,
                    4, $addr, (LEA32zzi length))>;
//  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "f32"):$vx,
//                   I64:$addr),
//            (VSTUir !cast<ValueType>("v" # !cast<string>(length) # "f32"):$vx,
//                    4, $addr, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "f64"):$vx,
//                   I64:$addr),
//            (VSTir !cast<ValueType>("v" # !cast<string>(length) # "f64"):$vx,
//                    8, $addr, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(store !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
                   I64:$addr),
            (vst_vIsl !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
                    8, $addr, (LEA32zzi length))>;
//  def : Pat<(!cast<PatFrag>("truncstorev" # !cast<string>(length) # "i32")
//               !cast<ValueType>("v" # !cast<string>(length) # "i64"):$vx,
//               I64:$addr),
//            (VSTLir $vx, 4, $addr, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : store_for_vector_length<256>;
defm : store_for_vector_length<128>;
defm : store_for_vector_length<64>;
defm : store_for_vector_length<32>;
defm : store_for_vector_length<16>;
defm : store_for_vector_length<8>;
defm : store_for_vector_length<4>;
defm : store_for_vector_length<2>;

// Load for
// v256i1, v512i1

def : Pat<(v256i1 (load I64:$addr)),
          (v256i1 (lvm_mmIs (lvm_mmIs (lvm_mmIs (lvm_mmIs (v256i1 (IMPLICIT_DEF)), 
                      0, (LDSri $addr, 0)),
                      1, (LDSri $addr, 8)),
                      2, (LDSri $addr, 16)),
                      3, (LDSri $addr, 24)))>;

def : Pat<(v512i1 (load I64:$addr)),
          (v512i1 (lvm_MMIs (lvm_MMIs (lvm_MMIs (lvm_MMIs
                  (lvm_MMIs (lvm_MMIs (lvm_MMIs (lvm_MMIs (v512i1 (IMPLICIT_DEF)), 
                      0, (LDSri $addr, 0)),
                      1, (LDSri $addr, 8)),
                      2, (LDSri $addr, 16)),
                      3, (LDSri $addr, 24)),
                      4, (LDSri $addr, 32)),
                      5, (LDSri $addr, 40)),
                      6, (LDSri $addr, 48)),
                      7, (LDSri $addr, 56)))>;

// Store for v256i1, v512i1 are implemented in 2 ways.  These STVM/STVM512
// pseudo instruction is used for frameindex related load/store instructions.
// Custom Lowering is used for other load/store instructions.

def : Pat<(store v256i1:$vx, ADDRri:$addr),
          (STVMri ADDRri:$addr, $vx)>;

def : Pat<(store v512i1:$vx, ADDRri:$addr),
          (STVM512ri ADDRri:$addr, $vx)>;

// Format Conversions

// sint -> floating-point

//def : Pat<(v512f32 (sint_to_fp v512i32:$vx)),
//          (VFLTpv $vx, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

//multiclass i2f_for_vector_length<int length, ValueType vi32, ValueType vi64,
//                                   ValueType vf32, ValueType vf64> {
//  def : Pat<(vf64 (sint_to_fp vi64:$vx)),
//            (VFLTXv $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(vf64 (sint_to_fp vi32:$vx)),
//            (VFLTdv $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(vf32 (sint_to_fp vi64:$vx)),
//            (VCVSv (VFLTXv $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(vf32 (sint_to_fp vi32:$vx)),
//            (VFLTsv $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//}
//
//defm : i2f_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
//defm : i2f_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
//defm : i2f_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
//defm : i2f_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
//defm : i2f_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
//defm : i2f_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
//defm : i2f_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
//defm : i2f_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// floating-point -> sint

//def : Pat<(v512i32 (fp_to_sint v512f32:$val)),
//          (VFIXpv $val, (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//
//multiclass f2i_for_vector_length<int length, ValueType vi32, ValueType vi64,
//                                 ValueType vf32, ValueType vf64> {
//  def : Pat<(vi64 (fp_to_sint vf64:$val)),
//            (vi64 (VFIXXv $val, (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi64 (fp_to_sint vf32:$val)),
//            (vi64 (VFIXXv (VCVDv $val, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                          (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (fp_to_sint vf64:$val)),
//            (vi32 (VFIXdsxv $val, (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (fp_to_sint vf32:$val)),
//            (vi32 (VFIXssxv $val, (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//}
//
//defm : f2i_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
//defm : f2i_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
//defm : f2i_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
//defm : f2i_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
//defm : f2i_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
//defm : f2i_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
//defm : f2i_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
//defm : f2i_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// fpround and fpextend for vector types.

//multiclass f2f_for_vector_length<int length, ValueType vf32, ValueType vf64> {
//  def : Pat<(vf32 (fpround vf64:$val)),
//            (vf32 (VCVSv $val, (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vf64 (fpextend vf32:$val)),
//            (vf64 (VCVDv $val, (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//}
//
//defm : f2f_for_vector_length<256, v256f32, v256f64>;
//defm : f2f_for_vector_length<128, v128f32, v128f64>;
//defm : f2f_for_vector_length<64, v64f32, v64f64>;
//defm : f2f_for_vector_length<32, v32f32, v32f64>;
//defm : f2f_for_vector_length<16, v16f32, v16f64>;
//defm : f2f_for_vector_length<8, v8f32, v8f64>;
//defm : f2f_for_vector_length<4, v4f32, v4f64>;
//defm : f2f_for_vector_length<2, v2f32, v2f64>;

// sext and zext

//def : Pat<(v512i32 (anyext v512i1:$vm)),
//          (v512i32 (VMRGpim 0,
//              (v512i32 (VBRDi -1, (COPY_TO_REGCLASS (LEAzzi 256), VLS))),
//              $vm,
//              (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//def : Pat<(v512i32 (sext v512i1:$vm)),
//          (v512i32 (VMRGpim 0,
//              (v512i32 (VBRDi -1, (COPY_TO_REGCLASS (LEAzzi 256), VLS))),
//              $vm,
//              (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//def : Pat<(v512i32 (zext v512i1:$vm)),
//          (v512i32 (VMRGpim 0,
//              (v512i32 (VBRDr (i64 0x1000000001),
//                              (COPY_TO_REGCLASS (LEAzzi 256), VLS))),
//              $vm,
//              (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;

multiclass ext_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vi1> {
//  def : Pat<(vi64 (anyext vi32:$vx)),
//            (VADSwsxi 0, $vx, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(vi64 (sext vi32:$vx)),
            (vaddswsx_vIvl 0, $vx, (LEA32zzi length))>;
  def : Pat<(vi64 (zext vi32:$vx)),
            (vaddswzx_vIvl 0, $vx, (LEA32zzi length))>;
//  def : Pat<(vi64 (anyext vi1:$vm)),
//            (vi64 (VMRGim 0,
//                (vi64 (VBRDi -1, (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                $vm,
//                (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (anyext vi1:$vm)),
//            (vi32 (VMRGim 0,
//                (vi32 (VBRDi -1, (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                $vm,
//                (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi64 (sext vi1:$vm)),
//            (vi64 (VMRGim 0,
//                (vi64 (VBRDi -1, (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                $vm,
//                (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (sext vi1:$vm)),
//            (vi32 (VMRGim 0,
//                (vi32 (VBRDi -1, (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                $vm,
//                (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi64 (zext vi1:$vm)),
//            (vi64 (VMRGim 0,
//                (vi64 (VBRDi 1, (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                $vm,
//                (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (zext vi1:$vm)),
//            (vi32 (VMRGim 0,
//                (vi32 (VBRDi 1, (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                $vm,
//                (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
}

defm : ext_for_vector_length<256, v256i32, v256i64, v256i1>;
defm : ext_for_vector_length<128, v128i32, v128i64, v128i1>;
defm : ext_for_vector_length<64, v64i32, v64i64, v64i1>;
defm : ext_for_vector_length<32, v32i32, v32i64, v32i1>;
defm : ext_for_vector_length<16, v16i32, v16i64, v16i1>;
defm : ext_for_vector_length<8, v8i32, v8i64, v8i1>;
defm : ext_for_vector_length<4, v4i32, v4i64, v4i1>;
defm : ext_for_vector_length<2, v2i32, v2i64, v2i1>;

// Bitconvert for vector registers

//multiclass bitconv_for_vector_length<int length, ValueType vi32, ValueType vi64,
//                                     ValueType vf32, ValueType vf64> {
//  def : Pat<(vf64 (bitconvert vi64:$vi)),
//            (COPY_TO_REGCLASS $vi, V64)>;
//  def : Pat<(vi64 (bitconvert vf64:$vf)),
//            (COPY_TO_REGCLASS $vf, V64)>;
//  def : Pat<(vf32 (bitconvert vi32:$vi)),
//            (vf32 (VSLLi2 $vi, 32, (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (bitconvert vf32:$vi)),
//            (vi32 (VSRLi2 $vi, 32, (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//}
//
//defm : bitconv_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
//defm : bitconv_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
//defm : bitconv_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
//defm : bitconv_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
//defm : bitconv_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
//defm : bitconv_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
//defm : bitconv_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
//defm : bitconv_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// Bitconvert from i64 to v2i32/v2f32
//def : Pat<(v2i32 (bitconvert i64:$v)),
//          (LSVi (LSVi (v2i32 (IMPLICIT_DEF)), 0, (ANDrm0 $v, 32)),
//                1, (SRLri $v, 32))>;
//def : Pat<(v2f32 (bitconvert i64:$v)),
//          (LSVi (LSVi (v2i32 (IMPLICIT_DEF)), 0, (SLLri $v, 32)),
//                1, (ANDrm1 $v, 32))>;

// Bitconvert for mask registers between
// v4i64 or v8i64 and v256i1 or v512i1 respectively

//def : Pat<(v256i1 (bitconvert v4i64:$v)),
//          (v256i1 (V2VM (COPY_TO_REGCLASS $v, V64)))>;
//
//def : Pat<(v4i64 (bitconvert v256i1:$vm)),
//          (v4i64 (COPY_TO_REGCLASS (v4i64 (VM2V $vm)), V64))>;
//
//def : Pat<(v512i1 (bitconvert v8i64:$v)),
//          (v512i1 (V2VMP (COPY_TO_REGCLASS $v, V64)))>;
//
//def : Pat<(v8i64 (bitconvert v512i1:$vmp)),
//          (v8i64 (COPY_TO_REGCLASS (v8i64 (VMP2V $vmp)), V64))>;

// Series of SCALAR_TO_VECTOR for all VE vector types,
//
// NOTE: Need to shift i32 for v512i32 since v512i32 uses
//       high 32 bits (0..31) first.

def: Pat<(v512i32 (scalar_to_vector i32:$val)),
         (v512i32 (lsv_vvss (v512i32 (IMPLICIT_DEF)), 0,
                        (SLLri
                           (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32),
                           32)))>;
def: Pat<(v512f32 (scalar_to_vector f32:$val)),
         (v512f32 (lsv_vvss (v512f32 (IMPLICIT_DEF)), 0,
                        (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32)))>;

multiclass s2v_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(vi32 (scalar_to_vector i32:$val)),
           (lsv_vvss (vi32 (IMPLICIT_DEF)), 0,
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32))>;
  def: Pat<(vi64 (scalar_to_vector i64:$val)),
           (lsv_vvss (vi64 (IMPLICIT_DEF)), 0, $val)>;
  def: Pat<(vf32 (scalar_to_vector f32:$val)),
           (lsv_vvss (vf32 (IMPLICIT_DEF)), 0,
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32))>;
  def: Pat<(vf64 (scalar_to_vector f64:$val)),
           (lsv_vvss (vf64 (IMPLICIT_DEF)), 0,
                 (COPY_TO_REGCLASS $val, I64))>;
}

defm : s2v_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
defm : s2v_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
defm : s2v_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
defm : s2v_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
defm : s2v_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
defm : s2v_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
defm : s2v_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
defm : s2v_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// Series of INSERT_VECOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerINSERT_VECTOR_ELT().

multiclass ive_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(vi32 (insertelt vi32:$vec, i32:$val, uimm7:$idx)),
           (lsv_vvss vi32:$vec, imm:$idx,
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32))>;
  def: Pat<(vi32 (insertelt vi32:$vec, i32:$val, i64:$idx)),
           (lsv_vvss vi32:$vec,
                 (EXTRACT_SUBREG $idx, sub_i32),
                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32))>;
//  def: Pat<(vi64 (insertelt vi64:$vec, i64:$val, uimm7:$idx)),
//           (LSVi vi64:$vec, imm:$idx, $val)>;
//  def: Pat<(vi64 (insertelt vi64:$vec, i64:$val, i64:$idx)),
//           (LSVr vi64:$vec,
//                 (EXTRACT_SUBREG $idx, sub_i32), $val)>;
//  def: Pat<(vf32 (insertelt vf32:$vec, f32:$val, uimm7:$idx)),
//           (LSVi vf32:$vec, imm:$idx,
//                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32))>;
//  def: Pat<(vf32 (insertelt vf32:$vec, f32:$val, i64:$idx)),
//           (LSVr vf32:$vec,
//                 (EXTRACT_SUBREG $idx, sub_i32),
//                 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32))>;
//  def: Pat<(vf64 (insertelt vf64:$vec, f64:$val, uimm7:$idx)),
//           (LSVi vf64:$vec, imm:$idx,
//                 (COPY_TO_REGCLASS $val, I64))>;
//  def: Pat<(vf64 (insertelt vf64:$vec, f64:$val, i64:$idx)),
//           (LSVr vf64:$vec,
//                 (EXTRACT_SUBREG $idx, sub_i32),
//                 (COPY_TO_REGCLASS $val, I64))>;
}

defm : ive_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
defm : ive_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
defm : ive_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
defm : ive_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
defm : ive_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
defm : ive_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
defm : ive_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
defm : ive_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// Series of EXTRACT_VECOR_ELT for all VE vector types,
// v512i32 and v512f32 is expanded by LowerEXTRACT_VECTOR_ELT().

multiclass eve_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                 ValueType vf32, ValueType vf64> {
  def: Pat<(i32 (extractelt vi32:$vec, uimm7:$idx)),
           (EXTRACT_SUBREG (lvsl_svs vi32:$vec, imm:$idx), sub_i32)>;
//  def: Pat<(i32 (extractelt vi32:$vec, i64:$idx)),
//           (EXTRACT_SUBREG (LVSr vi32:$vec, $idx), sub_i32)>;
//  def: Pat<(i64 (extractelt vi64:$vec, uimm7:$idx)),
//           (LVSi vi64:$vec, imm:$idx)>;
//  def: Pat<(i64 (extractelt vi64:$vec, i64:$idx)),
//           (LVSr vi64:$vec, $idx)>;
//  def: Pat<(f32 (extractelt vf32:$vec, uimm7:$idx)),
//           (EXTRACT_SUBREG (LVSi vf32:$vec, imm:$idx), sub_f32)>;
//  def: Pat<(f32 (extractelt vf32:$vec, i64:$idx)),
//           (EXTRACT_SUBREG (LVSr vf32:$vec, $idx), sub_f32)>;
//  def: Pat<(f64 (extractelt vf64:$vec, uimm7:$idx)),
//           (LVSi vf64:$vec, imm:$idx)>;
//  def: Pat<(f64 (extractelt vf64:$vec, i64:$idx)),
//           (LVSr vf64:$vec, $idx)>;
}

defm : eve_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
defm : eve_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
defm : eve_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
defm : eve_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
defm : eve_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
defm : eve_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
defm : eve_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
defm : eve_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// Custom ISDs
// VEISD::VEC_SEQ - represents a vector sequence where the operand is the stride
// VEISD::VEC_BROADCAST - represents a vector splat of a scalar value into all vector lanes.

def vec_seq         : SDNode<"VEISD::VEC_SEQ",       SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisInt<1>]>>;
def vec_broadcast   : SDNode<"VEISD::VEC_BROADCAST", SDTypeProfile<1, 1, [SDTCisVec<0>]>>;

//def vec_scatter   : SDNode<"VEISD::VEC_SCATTER", SDTypeProfile<0, 2, [SDTCisVec<0>, SDTCisVec<1>]>, [SDNPHasChain, SDNPMayStore, SDNPMemOperand]>;
//def vec_gather   : SDNode<"VEISD::VEC_GATHER", SDTypeProfile<1, 1, [SDTCisVec<0>, SDTCisVec<1>]>, [SDNPHasChain, SDNPMayLoad, SDNPMemOperand]>;

//def vec_lvl   : SDNode<"VEISD::VEC_LVL", SDTypeProfile<0, 1, []>, [SDNPHasChain]>;

//def vec_rotate   : SDNode<"VEISD::VEC_VMV", SDTypeProfile<1, 2, []>>;
//def : Pat<(v256f64 (vec_rotate i32:$sy, v256f64:$vz)),
//          (VMVr i32:$sy, v256f64:$vz,
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(v256f64 (vec_rotate (i32 simm7:$I), v256f64:$vz)),
//          (VMVi (i32 simm7:$I), v256f64:$vz,
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

// Shuffle
// TODO

// Scatter
//def : Pat<(vec_scatter v256i64:$vx, v256i64:$vy),
//          (VSCv v256i64:$vx, v256i64:$vy,
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(vec_scatter v256f64:$vx, v256i64:$vy),
//          (VSCv v256f64:$vx, v256i64:$vy,
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//
//// Gather
//def : Pat<(v256i64 (vec_gather v256i64:$vy)),
//          (VGTv v256i64:$vy,
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(v256f64 (vec_gather v256i64:$vy)),
//          (VGTv v256i64:$vy,
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

// LVL
//def : Pat<(vec_lvl i32:$sy), (LVL i32:$sy)>;

// Broadcast

def: Pat<(v512i32 (vec_broadcast i32:$val)),
         (pvbrd_vsl
            (ORrr
              (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32), 32),
              (ANDrm0 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32), 32)),
            (LEA32zzi 256))>;
def: Pat<(v512f32 (vec_broadcast f32:$val)),
         (pvbrd_vsl
            (ORrr
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
              (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32), 32)),
            (LEA32zzi 256))>;

multiclass vbrd_for_vector_length<int length, ValueType vi32, ValueType vi64,
                                  ValueType vf32, ValueType vf64> {
  def : Pat<(vi32 (vec_broadcast i32:$sy)),
            (vbrdl_vsl i32:$sy, (LEA32zzi length))>;
  def : Pat<(vf32 (vec_broadcast f32:$sy)),
            (vbrdu_vsl f32:$sy, (LEA32zzi length))>;
  def : Pat<(vi64 (vec_broadcast i64:$sy)),
            (vbrd_vsl i64:$sy, (LEA32zzi length))>;
  def : Pat<(vf64 (vec_broadcast f64:$sy)),
            (vbrd_vsl f64:$sy, (LEA32zzi length))>;
}

defm : vbrd_for_vector_length<256, v256i32, v256i64, v256f32, v256f64>;
defm : vbrd_for_vector_length<128, v128i32, v128i64, v128f32, v128f64>;
defm : vbrd_for_vector_length<64, v64i32, v64i64, v64f32, v64f64>;
defm : vbrd_for_vector_length<32, v32i32, v32i64, v32f32, v32f64>;
defm : vbrd_for_vector_length<16, v16i32, v16i64, v16f32, v16f64>;
defm : vbrd_for_vector_length<8, v8i32, v8i64, v8f32, v8f64>;
defm : vbrd_for_vector_length<4, v4i32, v4i64, v4f32, v4f64>;
defm : vbrd_for_vector_length<2, v2i32, v2i64, v2f32, v2f64>;

// Condition Code

//def : Pat<(v512i1 (setcc v512f32:$l, v512f32:$r, cond:$cond)),
//          (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
//              (VFMFsv (fcond2cc $cond),
//                      (VFCPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_even),
//              (VFMFlv (fcond2cc $cond),
//                      (VFCPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_odd)>;
//def : Pat<(v512i1 (setcc v512i32:$l, v512i32:$r, CCSIOp:$cond)),
//          (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
//              (VFMSuv (icond2cc $cond),
//                      (VCPSpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_even),
//              (VFMSv  (icond2cc $cond),
//                      (VCPSpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_odd)>;
//def : Pat<(v512i1 (setcc v512i32:$l, v512i32:$r, CCUIOp:$cond)),
//          (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
//              (VFMSuv (icond2cc $cond),
//                      (VCMPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_even),
//              (VFMSv  (icond2cc $cond),
//                      (VCMPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_odd)>;
//def : Pat<(v512i32 (setcc v512f32:$l, v512f32:$r, cond:$cond)),
//          (v512i32 (VMRGpim 0, (v512i32 (VBRDi -1,
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS))),
//          (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
//              (VFMFsv (fcond2cc $cond),
//                      (VFCPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_even),
//              (VFMFlv (fcond2cc $cond),
//                      (VFCPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_odd),
//                            (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//def : Pat<(v512i32 (setcc v512i32:$l, v512i32:$r, CCSIOp:$cond)),
//          (v512i32 (VMRGpim 0, (v512i32 (VBRDi -1,
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS))),
//          (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
//              (VFMSuv (icond2cc $cond),
//                      (VCPSpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_even),
//              (VFMSv  (icond2cc $cond),
//                      (VCPSpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_odd),
//                            (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//def : Pat<(v512i32 (setcc v512i32:$l, v512i32:$r, CCUIOp:$cond)),
//          (v512i32 (VMRGpim 0, (v512i32 (VBRDi -1,
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS))),
//          (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
//              (VFMSuv (icond2cc $cond),
//                      (VCMPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_even),
//              (VFMSv  (icond2cc $cond),
//                      (VCMPpv $l, $r, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                      (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_odd),
//                            (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;

//multiclass setcc_for_vector_length<int length, ValueType vi32, ValueType vi64,
//                                   ValueType vf32, ValueType vf64,
//                                   ValueType vi1> {
//  def : Pat<(vi1 (setcc vf64:$l, vf64:$r, cond:$cond)),
//            (vi1 (VFMFdv (fcond2cc $cond),
//                    (VFCPdv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi1 (setcc vi64:$l, vi64:$r, CCSIOp:$cond)),
//            (vi1 (VFMSv  (icond2cc $cond),
//                    (VCPXlv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi1 (setcc vi64:$l, vi64:$r, CCUIOp:$cond)),
//            (vi1 (VFMSv  (icond2cc $cond),
//                    (VCMPlv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi64 (setcc vf64:$l, vf64:$r, cond:$cond)),
//            (vi64 (VMRGim 0, (vi64 (VBRDi 1,
//                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//            (vi1 (VFMFdv (fcond2cc $cond),
//                    (VFCPdv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi64 (setcc vi64:$l, vi64:$r, CCSIOp:$cond)),
//            (vi64 (VMRGim 0, (vi64 (VBRDi 1,
//                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//            (vi1 (VFMSv  (icond2cc $cond),
//                    (VCPXlv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi64 (setcc vi64:$l, vi64:$r, CCUIOp:$cond)),
//            (vi64 (VMRGim 0, (vi64 (VBRDi 1,
//                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//            (vi1 (VFMSv  (icond2cc $cond),
//                    (VCMPlv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi1 (setcc vf32:$l, vf32:$r, cond:$cond)),
//            (vi1 (VFMFsv (fcond2cc $cond),
//                    (VFCPsv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi1 (setcc vi32:$l, vi32:$r, CCSIOp:$cond)),
//            (vi1 (VFMSv  (icond2cc $cond),
//                    (VCPSwsxv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi1 (setcc vi32:$l, vi32:$r, CCUIOp:$cond)),
//            (vi1 (VFMSv  (icond2cc $cond),
//                    (VCMPwv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (setcc vf32:$l, vf32:$r, cond:$cond)),
//            (vi32 (VMRGim 0, (vi32 (VBRDi 1,
//                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//            (vi1 (VFMFsv (fcond2cc $cond),
//                    (VFCPsv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (setcc vi32:$l, vi32:$r, CCSIOp:$cond)),
//            (vi32 (VMRGim 0, (vi32 (VBRDi 1,
//                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//            (vi1 (VFMSv  (icond2cc $cond),
//                    (VCPSwsxv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (setcc vi32:$l, vi32:$r, CCUIOp:$cond)),
//            (vi32 (VMRGim 0, (vi32 (VBRDi 1,
//                      (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//            (vi1 (VFMSv  (icond2cc $cond),
//                    (VCMPwv $l, $r, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//}
//
//defm : setcc_for_vector_length<256, v256i32, v256i64, v256f32, v256f64, v256i1>;
//defm : setcc_for_vector_length<128, v128i32, v128i64, v128f32, v128f64, v128i1>;
//defm : setcc_for_vector_length<64, v64i32, v64i64, v64f32, v64f64, v64i1>;
//defm : setcc_for_vector_length<32, v32i32, v32i64, v32f32, v32f64, v32i1>;
//defm : setcc_for_vector_length<16, v16i32, v16i64, v16f32, v16f64, v16i1>;
//defm : setcc_for_vector_length<8, v8i32, v8i64, v8f32, v8f64, v8i1>;
//defm : setcc_for_vector_length<4, v4i32, v4i64, v4f32, v4f64, v4i1>;
//defm : setcc_for_vector_length<2, v2i32, v2i64, v2f32, v2f64, v2i1>;
//
//def : Pat<(setcc v256i64:$vx, v256i64:$vy, CCSIOp:$cond),
//          (v256i1 (VFMKv (icond2cc $cond),
//                         (VCMPlv v256i64:$vx, v256i64:$vy,
//                                  (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                         (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//
//def : Pat<(setcc v256f64:$vx, v256f64:$vy, CCSIOp:$cond),
//          (v256i1 (VFMKv (fcond2cc $cond),
//                         (VCMPwv v256f64:$vx, v256f64:$vy,
//                                 (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                         (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;

// Vector Select

//def : Pat<(v512f32 (vselect v512i1:$m, v512f32:$vy, v512f32:$vz)),
//          (v512f32 (VMRGpvm v512f32:$vz, v512f32:$vy, v512i1:$m,
//                            (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//def : Pat<(v512i32 (vselect v512i1:$m, v512i32:$vy, v512i32:$vz)),
//          (v512i32 (VMRGpvm v512i32:$vz, v512i32:$vy, v512i1:$m,
//                            (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//
//multiclass vsel_for_vector_length<int length, ValueType vi32, ValueType vi64,
//                                  ValueType vf32, ValueType vf64,
//                                  ValueType vi1> {
//  def : Pat<(vf64 (vselect vi1:$m, vf64:$vy, vf64:$vz)),
//            (vf64 (VMRGvm vf64:$vz, vf64:$vy, vi1:$m,
//                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//  def : Pat<(vi64 (vselect vi1:$m, vi64:$vy, vi64:$vz)),
//            (vi64 (VMRGvm vi64:$vz, vi64:$vy, vi1:$m,
//                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//  def : Pat<(vf32 (vselect vi1:$m, vf32:$vy, vf32:$vz)),
//            (vf32 (VMRGvm vf32:$vz, vf32:$vy, vi1:$m,
//                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//  def : Pat<(vi32 (vselect vi1:$m, vi32:$vy, vi32:$vz)),
//            (vi32 (VMRGvm vi32:$vz, vi32:$vy, vi1:$m,
//                          (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//}
//
//defm : vsel_for_vector_length<256, v256i32, v256i64, v256f32, v256f64, v256i1>;
//defm : vsel_for_vector_length<128, v128i32, v128i64, v128f32, v128f64, v128i1>;
//defm : vsel_for_vector_length<64, v64i32, v64i64, v64f32, v64f64, v64i1>;
//defm : vsel_for_vector_length<32, v32i32, v32i64, v32f32, v32f64, v32i1>;
//defm : vsel_for_vector_length<16, v16i32, v16i64, v16f32, v16f64, v16i1>;
//defm : vsel_for_vector_length<8, v8i32, v8i64, v8f32, v8f64, v8i1>;
//defm : vsel_for_vector_length<4, v4i32, v4i64, v4f32, v4f64, v4i1>;
//defm : vsel_for_vector_length<2, v2i32, v2i64, v2f32, v2f64, v2i1>;

// Select

//def : Pat<(v512f32 (select i32:$pred, v512f32:$t, v512f32:$f)),
//          (v512f32 (VMRGpvm v512f32:$f, v512f32:$t,
//                   (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
//              (VFMSv CC_INE,
//                (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_even),
//              (VFMSv CC_INE,
//                (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_odd),
//                   (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//def : Pat<(v512i32 (select i32:$pred, v512i32:$t, v512i32:$f)),
//          (v512i32 (VMRGpvm v512i32:$f, v512i32:$t,
//                   (INSERT_SUBREG (INSERT_SUBREG (v512i1 (IMPLICIT_DEF)),
//              (VFMSv CC_INE,
//                (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_even),
//              (VFMSv CC_INE,
//                (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS)),
//              sub_vm_odd),
//                   (COPY_TO_REGCLASS (LEAzzi 256), VLS)))>;
//
//multiclass sel_for_vector_length<int length, ValueType vi32, ValueType vi64,
//                                 ValueType vf32, ValueType vf64,
//                                 ValueType vi1> {
//  def : Pat<(vi64 (select i32:$pred, vi64:$t, vi64:$f)),
//            (vi64 (VMRGvm vi64:$f, vi64:$t,
//                     (vi1 (VFMSv CC_INE,
//                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                  (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                     (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vi32 (select i32:$pred, vi32:$t, vi32:$f)),
//            (vi32 (VMRGvm vi32:$f, vi32:$t,
//                     (vi1 (VFMSv CC_INE,
//                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                  (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                     (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vf64 (select i32:$pred, vf64:$t, vf64:$f)),
//            (vf64 (VMRGvm vf64:$f, vf64:$t,
//                     (vi1 (VFMSv CC_INE,
//                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                  (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                     (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//  def : Pat<(vf32 (select i32:$pred, vf32:$t, vf32:$f)),
//            (vf32 (VMRGvm vf32:$f, vf32:$t,
//                     (vi1 (VFMSv CC_INE,
//                  (VBRDi32r i32:$pred, (COPY_TO_REGCLASS (LEAzzi length), VLS)),
//                  (COPY_TO_REGCLASS (LEAzzi length), VLS))),
//                     (COPY_TO_REGCLASS (LEAzzi length), VLS)))>;
//}
//
//defm : sel_for_vector_length<256, v256i32, v256i64, v256f32, v256f64, v256i1>;
//defm : sel_for_vector_length<128, v128i32, v128i64, v128f32, v128f64, v128i1>;
//defm : sel_for_vector_length<64, v64i32, v64i64, v64f32, v64f64, v64i1>;
//defm : sel_for_vector_length<32, v32i32, v32i64, v32f32, v32f64, v32i1>;
//defm : sel_for_vector_length<16, v16i32, v16i64, v16f32, v16f64, v16i1>;
//defm : sel_for_vector_length<8, v8i32, v8i64, v8f32, v8f64, v8i1>;
//defm : sel_for_vector_length<4, v4i32, v4i64, v4f32, v4f64, v4i1>;
//defm : sel_for_vector_length<2, v2i32, v2i64, v2f32, v2f64, v2i1>;

// Sequence

def : Pat<(v512i32 (vec_seq (i32 1))), (VSEQpv 256)>;

multiclass vseq_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(vi32 (vec_seq (i32 1))),
            (pvseqlo_vl (LEA32zzi length))>;
//  def : Pat<(vi64 (vec_seq (i64 1))),
//            (VSEQv length)>;
}

defm : vseq_for_vector_length<256, v256i32, v256i64>;
defm : vseq_for_vector_length<128, v128i32, v128i64>;
defm : vseq_for_vector_length<64, v64i32, v64i64>;
defm : vseq_for_vector_length<32, v32i32, v32i64>;
defm : vseq_for_vector_length<16, v16i32, v16i64>;
defm : vseq_for_vector_length<8, v8i32, v8i64>;
defm : vseq_for_vector_length<4, v4i32, v4i64>;
defm : vseq_for_vector_length<2, v2i32, v2i64>;


// Double-Precision Arithmetic
//
// fadd, fsub, fmul, and fdiv for all floating point vector types.

//def : Pat<(fadd v512f32:$vy, v512f32:$vz),
//          (VFADpv v512f32:$vy, v512f32:$vz,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(fsub v512f32:$vy, v512f32:$vz),
//          (VFSBpv v512f32:$vy, v512f32:$vz,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(fmul v512f32:$vy, v512f32:$vz),
//          (VFMPpv v512f32:$vy, v512f32:$vz,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(fdiv v512f32:$vy, v512f32:$vz),
//          (VFDVpv v512f32:$vy, v512f32:$vz,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

def : Pat<(fadd (vec_broadcast f32:$val), v512f32:$vz),
          (pvfadd_vsvl
            (ORrr
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
              (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32), 32)),
            v512f32:$vz, (LEA32zzi 256))>;
def : Pat<(fsub (vec_broadcast f32:$val), v512f32:$vz),
          (pvfsub_vsvl
            (ORrr
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
              (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32), 32)),
            v512f32:$vz, (LEA32zzi 256))>;
def : Pat<(fmul (vec_broadcast f32:$val), v512f32:$vz),
          (pvfmul_vsvl
            (ORrr
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
              (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32), 32)),
            v512f32:$vz, (LEA32zzi 256))>;
//def : Pat<(fdiv (vec_broadcast f32:$val), v512f32:$vz),
//          (VFDVpr
//            (ORrr
//              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32),
//              (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_f32), 32)),
//            v512f32:$vz, (LEA32zzi 256))>;

multiclass farith_for_vector_length<int length, ValueType vf32,
                                    ValueType vf64> {
  def : Pat<(fadd vf32:$vy, vf32:$vz),
            (vfadds_vvvl vf32:$vy, vf32:$vz, (LEA32zzi length))>;
  def : Pat<(fadd vf64:$vy, vf64:$vz),
            (vfaddd_vvvl vf64:$vy, vf64:$vz, (LEA32zzi length))>;
  def : Pat<(fadd (vf32 (vec_broadcast f32:$sy)), vf32:$vz),
            (vfadds_vsvl f32:$sy, vf32:$vz, (LEA32zzi length))>;
  def : Pat<(fadd (vf64 (vec_broadcast f64:$sy)), vf64:$vz),
            (vfaddd_vsvl f64:$sy, vf64:$vz, (LEA32zzi length))>;
  def : Pat<(fsub vf32:$vy, vf32:$vz),
            (vfsubs_vvvl vf32:$vy, vf32:$vz, (LEA32zzi length))>;
  def : Pat<(fsub vf64:$vy, vf64:$vz),
            (vfsubd_vvvl vf64:$vy, vf64:$vz, (LEA32zzi length))>;
  def : Pat<(fsub (vf32 (vec_broadcast f32:$sy)), vf32:$vz),
            (vfsubs_vsvl f32:$sy, vf32:$vz, (LEA32zzi length))>;
  def : Pat<(fsub (vf64 (vec_broadcast f64:$sy)), vf64:$vz),
            (vfsubd_vsvl f64:$sy, vf64:$vz, (LEA32zzi length))>;
  def : Pat<(fmul vf32:$vy, vf32:$vz),
            (vfmuls_vvvl vf32:$vy, vf32:$vz, (LEA32zzi length))>;
  def : Pat<(fmul vf64:$vy, vf64:$vz),
            (vfmuld_vvvl vf64:$vy, vf64:$vz, (LEA32zzi length))>;
  def : Pat<(fmul (vf32 (vec_broadcast f32:$sy)), vf32:$vz),
            (vfmuls_vsvl f32:$sy, vf32:$vz, (LEA32zzi length))>;
  def : Pat<(fmul (vf64 (vec_broadcast f64:$sy)), vf64:$vz),
            (vfmuld_vsvl f64:$sy, vf64:$vz, (LEA32zzi length))>;
  def : Pat<(fdiv vf32:$vy, vf32:$vz),
            (vfdivs_vvvl vf32:$vy, vf32:$vz, (LEA32zzi length))>;
  def : Pat<(fdiv vf64:$vy, vf64:$vz),
            (vfdivd_vvvl vf64:$vy, vf64:$vz, (LEA32zzi length))>;
  def : Pat<(fdiv (vf32 (vec_broadcast f32:$sy)), vf32:$vz),
            (vfdivs_vsvl f32:$sy, vf32:$vz, (LEA32zzi length))>;
  def : Pat<(fdiv (vf64 (vec_broadcast f64:$sy)), vf64:$vz),
            (vfdivd_vsvl f64:$sy, vf64:$vz, (LEA32zzi length))>;
}

defm : farith_for_vector_length<256, v256f32, v256f64>;
defm : farith_for_vector_length<128, v128f32, v128f64>;
defm : farith_for_vector_length<64, v64f32, v64f64>;
defm : farith_for_vector_length<32, v32f32, v32f64>;
defm : farith_for_vector_length<16, v16f32, v16f64>;
defm : farith_for_vector_length<8, v8f32, v8f64>;
defm : farith_for_vector_length<4, v4f32, v4f64>;
defm : farith_for_vector_length<2, v2f32, v2f64>;

// fneg for all floating point vector types.

//def : Pat<(fneg v512f32:$vz),
//          (VFSBpi 0, v512f32:$vz,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//
//multiclass fneg_for_vector_length<int length, ValueType vf32, ValueType vf64> {
//  def : Pat<(fneg vf32:$vz),
//            (VFSBsi 0, vf32:$vz,
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(fneg vf64:$vz),
//            (VFSBdi 0, vf64:$vz,
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//}
//
//defm : fneg_for_vector_length<256, v256f32, v256f64>;
//defm : fneg_for_vector_length<128, v128f32, v128f64>;
//defm : fneg_for_vector_length<64, v64f32, v64f64>;
//defm : fneg_for_vector_length<32, v32f32, v32f64>;
//defm : fneg_for_vector_length<16, v16f32, v16f64>;
//defm : fneg_for_vector_length<8, v8f32, v8f64>;
//defm : fneg_for_vector_length<4, v4f32, v4f64>;
//defm : fneg_for_vector_length<2, v2f32, v2f64>;

// fma for all floating point vector types.

//def : Pat<(fma v512f32:$vz, v512f32:$vw, (v512f32 (fneg v512f32:$vy))),
//          (VFMSBpv v512f32:$vy, v512f32:$vz, v512f32:$vw,
//                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(fma (v512f32 (vec_broadcast f32:$sy)), v512f32:$vw, v512f32:$vy),
          (pvfmad_vvsvl v512f32:$vy,
                    (ORrr
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32),
              (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32), 32)),
                    v512f32:$vw,
                    (LEA32zzi 256))>;
def : Pat<(fma v512f32:$vw, (v512f32 (vec_broadcast f32:$sy)), v512f32:$vy),
          (pvfmad_vvsvl v512f32:$vy,
                    (ORrr
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32),
              (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32), 32)),
                    v512f32:$vw,
                    (LEA32zzi 256))>;
def : Pat<(fma v512f32:$vz, v512f32:$vw, (v512f32 (vec_broadcast f32:$sy))),
          (pvfmad_vsvvl (ORrr
              (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32),
              (SRLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_f32), 32)),
                   v512f32:$vz, v512f32:$vw,
                   (LEA32zzi 256))>;
//def : Pat<(fma v512f32:$vz, v512f32:$vw, v512f32:$vy),
//          (VFMADpv v512f32:$vy, v512f32:$vz, v512f32:$vw,
//                   (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass fma_for_vector_length<int length, ValueType vf32, ValueType vf64> {
//  def : Pat<(fma vf64:$vz, vf64:$vw, (vf64 (fneg vf64:$vy))),
//            (VFMSBdv vf64:$vy, vf64:$vz, vf64:$vw,
//                     (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fma (vf64 (vec_broadcast f64:$sy)), vf64:$vw, vf64:$vy),
            (vfmadd_vvsvl vf64:$vy, f64:$sy, vf64:$vw, (LEA32zzi length))>;
  def : Pat<(fma vf64:$vw, (vf64 (vec_broadcast f64:$sy)), vf64:$vy),
            (vfmadd_vvsvl vf64:$vy, f64:$sy, vf64:$vw, (LEA32zzi length))>;
  def : Pat<(fma vf64:$vz, vf64:$vw, (vf64 (vec_broadcast f64:$sy))),
            (vfmadd_vsvvl f64:$sy, vf64:$vz, vf64:$vw, (LEA32zzi length))>;
  def : Pat<(fma vf64:$vz, vf64:$vw, vf64:$vy),
            (vfmadd_vvvvl vf64:$vy, vf64:$vz, vf64:$vw, (LEA32zzi length))>;
//  def : Pat<(fma vf32:$vz, vf32:$vw, (vf32 (fneg vf32:$vy))),
//            (VFMSBsv vf32:$vy, vf32:$vz, vf32:$vw,
//                     (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(fma (vf32 (vec_broadcast f32:$sy)), vf32:$vw, vf32:$vy),
            (vfmads_vvsvl vf32:$vy, f32:$sy, vf32:$vw, (LEA32zzi length))>;
  def : Pat<(fma vf32:$vw, (vf32 (vec_broadcast f32:$sy)), vf32:$vy),
            (vfmads_vvsvl vf32:$vy, f32:$sy, vf32:$vw, (LEA32zzi length))>;
  def : Pat<(fma vf32:$vz, vf32:$vw, (vf32 (vec_broadcast f32:$sy))),
            (vfmads_vsvvl f32:$sy, vf32:$vz, vf32:$vw, (LEA32zzi length))>;
  def : Pat<(fma vf32:$vz, vf32:$vw, vf32:$vy),
            (vfmads_vvvvl vf32:$vy, vf32:$vz, vf32:$vw, (LEA32zzi length))>;
}

defm : fma_for_vector_length<256, v256f32, v256f64>;
defm : fma_for_vector_length<128, v128f32, v128f64>;
defm : fma_for_vector_length<64, v64f32, v64f64>;
defm : fma_for_vector_length<32, v32f32, v32f64>;
defm : fma_for_vector_length<16, v16f32, v16f64>;
defm : fma_for_vector_length<8, v8f32, v8f64>;
defm : fma_for_vector_length<4, v4f32, v4f64>;
defm : fma_for_vector_length<2, v2f32, v2f64>;

// Integer Arithmetic
//
// add and sub for v512i32
// add, sub, mul, sdiv, and udiv for other integer vector types.

//def : Pat<(add v512i32:$vy, v512i32:$vz),
//          (VADSpv v512i32:$vy, v512i32:$vz,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(sub v512i32:$vy, v512i32:$vz),
//          (VSBSpv v512i32:$vy, v512i32:$vz,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
def : Pat<(add (vec_broadcast i32:$val), v512i32:$vz),
          (pvadds_vsvl
            (ORrr
              (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32), 32),
              (ANDrm0 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32), 32)),
            v512i32:$vz, (LEA32zzi 256))>;
def : Pat<(sub (vec_broadcast i32:$val), v512i32:$vz),
          (pvsubs_vsvl
            (ORrr
              (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32), 32),
              (ANDrm0 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $val, sub_i32), 32)),
            v512i32:$vz, (LEA32zzi 256))>;

multiclass arith_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(add vi32:$vy, vi32:$vz),
            (vaddswsx_vvvl vi32:$vy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(add vi64:$vy, vi64:$vz),
            (vaddsl_vvvl vi64:$vy, vi64:$vz, (LEA32zzi length))>;
  def : Pat<(add (vi32 (vec_broadcast i32:$sy)), vi32:$vz),
            (vaddswsx_vsvl i32:$sy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(add (vi64 (vec_broadcast i64:$sy)), vi64:$vz),
            (vaddsl_vsvl i64:$sy, vi64:$vz, (LEA32zzi length))>;
  def : Pat<(sub vi32:$vy, vi32:$vz),
            (vsubswsx_vvvl vi32:$vy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(sub vi64:$vy, vi64:$vz),
            (vsubsl_vvvl vi64:$vy, vi64:$vz, (LEA32zzi length))>;
  def : Pat<(sub (vi32 (vec_broadcast i32:$sy)), vi32:$vz),
            (vsubswsx_vsvl i32:$sy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(sub (vi64 (vec_broadcast i64:$sy)), vi64:$vz),
            (vsubsl_vsvl i64:$sy, vi64:$vz, (LEA32zzi length))>;
  def : Pat<(mul vi32:$vy, vi32:$vz),
            (vmulswsx_vvvl vi32:$vy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(mul vi64:$vy, vi64:$vz),
            (vmulsl_vvvl vi64:$vy, vi64:$vz, (LEA32zzi length))>;
  def : Pat<(mul (vi32 (vec_broadcast i32:$sy)), vi32:$vz),
            (vmulswsx_vsvl i32:$sy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(mul (vi64 (vec_broadcast i64:$sy)), vi64:$vz),
            (vmulsl_vsvl i64:$sy, vi64:$vz, (LEA32zzi length))>;
  def : Pat<(sdiv vi32:$vy, vi32:$vz),
            (vdivswsx_vvvl vi32:$vy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(sdiv vi64:$vy, vi64:$vz),
            (vdivsl_vvvl vi64:$vy, vi64:$vz, (LEA32zzi length))>;
  def : Pat<(sdiv (vi32 (vec_broadcast i32:$sy)), vi32:$vz),
            (vdivswsx_vsvl i32:$sy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(sdiv (vi64 (vec_broadcast i64:$sy)), vi64:$vz),
            (vdivsl_vsvl i64:$sy, vi64:$vz, (LEA32zzi length))>;
  def : Pat<(udiv vi32:$vy, vi32:$vz),
            (vdivuw_vvvl vi32:$vy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(udiv vi64:$vy, vi64:$vz),
            (vdivul_vvvl vi64:$vy, vi64:$vz, (LEA32zzi length))>;
  def : Pat<(udiv (vi32 (vec_broadcast i32:$sy)), vi32:$vz),
            (vdivuw_vsvl i32:$sy, vi32:$vz, (LEA32zzi length))>;
  def : Pat<(udiv (vi64 (vec_broadcast i64:$sy)), vi64:$vz),
            (vdivul_vsvl i64:$sy, vi64:$vz, (LEA32zzi length))>;
}

defm : arith_for_vector_length<256, v256i32, v256i64>;
defm : arith_for_vector_length<128, v128i32, v128i64>;
defm : arith_for_vector_length<64, v64i32, v64i64>;
defm : arith_for_vector_length<32, v32i32, v32i64>;
defm : arith_for_vector_length<16, v16i32, v16i64>;
defm : arith_for_vector_length<8, v8i32, v8i64>;
defm : arith_for_vector_length<4, v4i32, v4i64>;
defm : arith_for_vector_length<2, v2i32, v2i64>;

// Logic
//
// and, or, and xor for v512i32
// and, or, and xor for other integer vector types.

//def : Pat<(and v512i32:$vx, v512i32:$vy),
//          (VANDpv v512i32:$vx, v512i32:$vy,
//                 (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(or  v512i32:$vx, v512i32:$vy),
//          (VORpv v512i32:$vx, v512i32:$vy,
//                (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(xor v512i32:$vx, v512i32:$vy),
//          (VXORpv v512i32:$vx, v512i32:$vy,
//                 (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass logic_for_vector_length<int length, ValueType vi32, ValueType vi64> {
//  def : Pat<(and vi64:$vx, vi64:$vy),
//            (VANDv vi64:$vx, vi64:$vy,
//                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(or  vi64:$vx, vi64:$vy),
//            (VORv vi64:$vx, vi64:$vy,
//                  (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(xor vi64:$vx, vi64:$vy),
//            (VXORv vi64:$vx, vi64:$vy,
//                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(and vi32:$vx, vi32:$vy),
            (pvandlo_vvvl vi32:$vx, vi32:$vy, (LEA32zzi length))>;
//  def : Pat<(or  vi32:$vx, vi32:$vy),
//            (VORlv vi32:$vx, vi32:$vy,
//                  (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(xor vi32:$vx, vi32:$vy),
//            (VXORlv vi32:$vx, vi32:$vy,
//                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : logic_for_vector_length<256, v256i32, v256i64>;
defm : logic_for_vector_length<128, v128i32, v128i64>;
defm : logic_for_vector_length<64, v64i32, v64i64>;
defm : logic_for_vector_length<32, v32i32, v32i64>;
defm : logic_for_vector_length<16, v16i32, v16i64>;
defm : logic_for_vector_length<8, v8i32, v8i64>;
defm : logic_for_vector_length<4, v4i32, v4i64>;
defm : logic_for_vector_length<2, v2i32, v2i64>;

// Shifts
//
// shl, srl, and sra for v512i32
// shl, srl, and sra for other integer vector types.

def : Pat<(shl v512i32:$vx, (v512i32 (vec_broadcast i32:$sy))),
          (pvsll_vvsl v512i32:$vx,
                   (ORrr
              (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32),
              (ANDrm0 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32)),
                   (LEA32zzi 256))>;
def : Pat<(srl v512i32:$vx, (v512i32 (vec_broadcast i32:$sy))),
          (pvsrl_vvsl v512i32:$vx,
                   (ORrr
              (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32),
              (ANDrm0 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32)),
                   (LEA32zzi 256))>;
def : Pat<(sra v512i32:$vx, (v512i32 (vec_broadcast i32:$sy))),
          (pvsra_vvsl v512i32:$vx,
                   (ORrr
              (SLLri (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32),
              (ANDrm0 (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32), 32)),
                   (LEA32zzi 256))>;

//def : Pat<(shl v512i32:$vx, v512i32:$vy),
//          (VSLLpv v512i32:$vx, v512i32:$vy,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(srl v512i32:$vx, v512i32:$vy),
//          (VSRLpv v512i32:$vx, v512i32:$vy,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;
//def : Pat<(sra v512i32:$vx, v512i32:$vy),
//          (VSRApv v512i32:$vx, v512i32:$vy,
//                  (COPY_TO_REGCLASS (LEAzzi 256), VLS))>;

multiclass shift_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(shl vi64:$vx, (vi64 (vec_broadcast i64:$sy))),
            (vslal_vvsl vi64:$vx, i64:$sy, (LEA32zzi length))>;
  def : Pat<(srl vi64:$vx, (vi64 (vec_broadcast i64:$sy))),
            (vsrl_vvsl vi64:$vx, i64:$sy, (LEA32zzi length))>;
  def : Pat<(sra vi64:$vx, (vi64 (vec_broadcast i64:$sy))),
            (vsral_vvsl vi64:$vx, i64:$sy, (LEA32zzi length))>;
//  def : Pat<(shl vi64:$vx, vi64:$vy),
//            (VSLAXv vi64:$vx, vi64:$vy,
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(srl vi64:$vx, vi64:$vy),
//            (VSRLv vi64:$vx, vi64:$vy,
//                   (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(sra vi64:$vx, vi64:$vy),
//            (VSRAXv vi64:$vx, vi64:$vy,
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
  def : Pat<(shl vi32:$vx, (vi32 (vec_broadcast i32:$sy))),
            (pvslalo_vvsl vi32:$vx,
                     (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32),
                     (LEA32zzi length))>;
  def : Pat<(srl vi32:$vx, (vi32 (vec_broadcast i32:$sy))),
             (pvsrllo_vvsl vi32:$vx,
                     (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32),
                     (LEA32zzi length))>;
  def : Pat<(sra vi32:$vx, (vi32 (vec_broadcast i32:$sy))),
            (pvsralo_vvsl vi32:$vx,
                     (INSERT_SUBREG (i64 (IMPLICIT_DEF)), $sy, sub_i32),
                     (LEA32zzi length))>;
//  def : Pat<(shl vi32:$vx, vi32:$vy),
//            (VSLAlv vi32:$vx, vi32:$vy,
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(srl vi32:$vx, vi32:$vy),
//            (VSRLlv vi32:$vx, vi32:$vy,
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
//  def : Pat<(sra vi32:$vx, vi32:$vy),
//            (VSRAlv vi32:$vx, vi32:$vy,
//                    (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : shift_for_vector_length<256, v256i32, v256i64>;
defm : shift_for_vector_length<128, v128i32, v128i64>;
defm : shift_for_vector_length<64, v64i32, v64i64>;
defm : shift_for_vector_length<32, v32i32, v32i64>;
defm : shift_for_vector_length<16, v16i32, v16i64>;
defm : shift_for_vector_length<8, v8i32, v8i64>;
defm : shift_for_vector_length<4, v4i32, v4i64>;
defm : shift_for_vector_length<2, v2i32, v2i64>;

// Truncate
//
// trunc from vXi64 to vXi32.

multiclass trunc_for_vector_length<int length, ValueType vi32, ValueType vi64> {
  def : Pat<(vi32 (trunc vi64:$val)),
            (VANDli0 32, $val, (COPY_TO_REGCLASS (LEAzzi length), VLS))>;
}

defm : trunc_for_vector_length<256, v256i32, v256i64>;
defm : trunc_for_vector_length<128, v128i32, v128i64>;
defm : trunc_for_vector_length<64, v64i32, v64i64>;
defm : trunc_for_vector_length<32, v32i32, v32i64>;
defm : trunc_for_vector_length<16, v16i32, v16i64>;
defm : trunc_for_vector_length<8, v8i32, v8i64>;
defm : trunc_for_vector_length<4, v4i32, v4i64>;
defm : trunc_for_vector_length<2, v2i32, v2i64>;
