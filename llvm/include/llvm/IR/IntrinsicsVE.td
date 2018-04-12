let TargetPrefix = "ve" in {
  def int_ve_lvl : GCCBuiltin<"__builtin_ve_lvl">, Intrinsic<[], [llvm_i32_ty]>;

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

  def int_ve_vfaddd : GCCBuiltin<"__builtin_ve_vfaddd">, 
        Intrinsic<[LLVMType<v256f64>], [LLVMType<v256f64>, LLVMType<v256f64>]>;

  def int_ve_vfadds : GCCBuiltin<"__builtin_ve_vfadds">, 
        Intrinsic<[LLVMType<v256f64>], [LLVMType<v256f64>, LLVMType<v256f64>]>;

  def int_ve_pvfadd : GCCBuiltin<"__builtin_ve_pvfadd">, 
        Intrinsic<[LLVMType<v256f64>], [LLVMType<v256f64>, LLVMType<v256f64>]>;
}

// vim::set sw=2:
