case Intrinsic::ve_vsumwsx_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VSUMSsxvm);
case Intrinsic::ve_vsumwzx_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VSUMSzxvm);
case Intrinsic::ve_vsuml_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VSUMXvm);
case Intrinsic::ve_vfsumd_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VFSUMdvm);
case Intrinsic::ve_vfsums_vvm: return LowerIntrinsicWithMask(Op, DAG, VE::VFSUMsvm);
