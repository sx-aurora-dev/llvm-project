class VEIntrinsic<string name, list<LLVMType> outs, list<LLVMType> ins> : 
  GCCBuiltin<"__builtin_ve_" # name>, Intrinsic<outs, ins>
{
  let TargetPrefix = "ve";
}

class VEIntrinsic2<string name, list<LLVMType> outs, list<LLVMType> ins> : 
  GCCBuiltin<"__builtin_ve_" # name>, Intrinsic<outs, ins, [IntrNoMem]>
{
  let TargetPrefix = "ve";
}


let TargetPrefix = "ve" in {
  def int_ve_lvl : GCCBuiltin<"__builtin_ve_lvl">, Intrinsic<[], [llvm_i32_ty]>;

  def int_ve_lsv_vss : GCCBuiltin<"__builtin_ve_lsv_vss">, 
        Intrinsic<[LLVMType<v256f64>], [LLVMType<v256f64>, llvm_i32_ty, llvm_i64_ty], [Returned<0>]>;

  def int_ve_vld : GCCBuiltin<"__builtin_ve_vld">, 
        Intrinsic<[LLVMType<v256f64>], [llvm_ptr_ty, llvm_i64_ty]>;
  def int_ve_vldu : GCCBuiltin<"__builtin_ve_vldu">, 
        Intrinsic<[LLVMType<v256f64>], [llvm_ptr_ty, llvm_i64_ty]>;
  def int_ve_vldl : GCCBuiltin<"__builtin_ve_vldl">, 
        Intrinsic<[LLVMType<v256f64>], [llvm_ptr_ty, llvm_i64_ty]>;

  def int_ve_vst : GCCBuiltin<"__builtin_ve_vst">, 
        Intrinsic<[], [llvm_ptr_ty, LLVMType<v256f64>, llvm_i64_ty]>;
  def int_ve_vstu : GCCBuiltin<"__builtin_ve_vstu">, 
        Intrinsic<[], [llvm_ptr_ty, LLVMType<v256f64>, llvm_i64_ty]>;
  def int_ve_vstl : GCCBuiltin<"__builtin_ve_vstl">, 
        Intrinsic<[], [llvm_ptr_ty, LLVMType<v256f64>, llvm_i64_ty]>;

  def int_ve_pack_f32p : GCCBuiltin<"__builtin_ve_pack_f32p">,
        Intrinsic<[llvm_i64_ty], [llvm_ptr_ty, llvm_ptr_ty], [IntrReadMem]>;
}

include "llvm/IR/IntrinsicsVE2.td"

// vim::set sw=2:
