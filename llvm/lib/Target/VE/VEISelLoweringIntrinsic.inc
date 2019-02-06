case Intrinsic::ve_vscot_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VSCotvm);
case Intrinsic::ve_vscuot_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VSCUotvm);
case Intrinsic::ve_vsclot_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VSCLotvm);
