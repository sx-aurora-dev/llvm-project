let TargetPrefix = "ve" in {

  // fencem instructions
  def int_ve_fencem1 : Intrinsic<[], [], []>;
  def int_ve_fencem2 : Intrinsic<[], [], []>;
  def int_ve_fencem3 : Intrinsic<[], [], []>;

  // VEL Intrinsics
  def int_ve_vl_svob : GCCBuiltin<"__builtin_ve_vl_svob">, Intrinsic<[], [], [IntrHasSideEffects]>;

  def int_ve_vl_pack_f32p : GCCBuiltin<"__builtin_ve_vl_pack_f32p">,
        Intrinsic<[llvm_i64_ty], [llvm_ptr_ty, llvm_ptr_ty], [IntrReadMem]>;

  def int_ve_vl_pack_f32a : GCCBuiltin<"__builtin_ve_vl_pack_f32a">,
        Intrinsic<[llvm_i64_ty], [llvm_ptr_ty], [IntrReadMem]>;

  def int_ve_vl_extract_vm512u : GCCBuiltin<"__builtin_ve_vl_extract_vm512u">,
        Intrinsic<[LLVMType<v4i64>], [LLVMType<v8i64>], [IntrNoMem]>;

  def int_ve_vl_extract_vm512l : GCCBuiltin<"__builtin_ve_vl_extract_vm512l">,
        Intrinsic<[LLVMType<v4i64>], [LLVMType<v8i64>], [IntrNoMem]>;

  def int_ve_vl_insert_vm512u : GCCBuiltin<"__builtin_ve_vl_insert_vm512u">,
        Intrinsic<[LLVMType<v8i64>], [LLVMType<v8i64>, LLVMType<v4i64>], [IntrNoMem]>;

  def int_ve_vl_insert_vm512l : GCCBuiltin<"__builtin_ve_vl_insert_vm512l">,
        Intrinsic<[LLVMType<v8i64>], [LLVMType<v8i64>, LLVMType<v4i64>], [IntrNoMem]>;

}

include "llvm/IR/IntrinsicsVEVL.gen.td"

// vim::set sw=2:
