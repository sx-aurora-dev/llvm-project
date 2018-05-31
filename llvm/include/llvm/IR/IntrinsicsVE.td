let TargetPrefix = "ve" in {
  def int_ve_lvl : GCCBuiltin<"__builtin_ve_lvl">, Intrinsic<[], [llvm_i32_ty]>;

  def int_ve_vld : GCCBuiltin<"__builtin_ve_vld">, 
        Intrinsic<[LLVMType<v256f64>], [llvm_ptr_ty, llvm_i64_ty], [IntrReadMem]>;
  def int_ve_vldu : GCCBuiltin<"__builtin_ve_vldu">, 
        Intrinsic<[LLVMType<v256f64>], [llvm_ptr_ty, llvm_i64_ty], [IntrReadMem]>;
  def int_ve_vldl : GCCBuiltin<"__builtin_ve_vldl">, 
        Intrinsic<[LLVMType<v256f64>], [llvm_ptr_ty, llvm_i64_ty], [IntrReadMem]>;

  def int_ve_vst : GCCBuiltin<"__builtin_ve_vst">, 
        Intrinsic<[], [llvm_ptr_ty, LLVMType<v256f64>, llvm_i64_ty], [IntrWriteMem]>;
  def int_ve_vstu : GCCBuiltin<"__builtin_ve_vstu">, 
        Intrinsic<[], [llvm_ptr_ty, LLVMType<v256f64>, llvm_i64_ty], [IntrWriteMem]>;
  def int_ve_vstl : GCCBuiltin<"__builtin_ve_vstl">, 
        Intrinsic<[], [llvm_ptr_ty, LLVMType<v256f64>, llvm_i64_ty], [IntrWriteMem]>;

  def int_ve_pack_f32p : GCCBuiltin<"__builtin_ve_pack_f32p">,
        Intrinsic<[llvm_i64_ty], [llvm_ptr_ty, llvm_ptr_ty], [IntrReadMem]>;

  def int_ve_pack_f32a : GCCBuiltin<"__builtin_ve_pack_f32a">,
        Intrinsic<[llvm_i64_ty], [llvm_ptr_ty], [IntrReadMem]>;

  def int_ve_vec_call: GCCBuiltin<"__builtin_ve_vec_call">,
        Intrinsic<[LLVMType<v256f64>], [LLVMType<v256f64>, llvm_ptr_ty], [IntrNoMem]>;

/*
  def int_ve_lvs_svs_f32 : GCCBuiltin<"__builtin_ve_lvs_svs_f32">,
        Intrinsic<[llvm_float_ty], [LLVMType<v256f64>, LLVMType<i32>], [IntrNoMem]>;
        */
}


include "llvm/IR/IntrinsicsVE2.td"

// vim::set sw=2:
