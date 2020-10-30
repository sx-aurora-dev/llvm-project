// vfmk

class PseudoVFMK<dag ins, string asm> : Pseudo<(outs VM512:$vmx), ins, asm, []> {
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def VFMKyal : PseudoVFMK<(ins I32:$vl), "# pseudo-vfmk.at $vmx">;
def VFMKynal : PseudoVFMK<(ins I32:$vl), "# pseudo-vfmk.af $vmx">;

def VFMKWyvl  : PseudoVFMK<(ins CCOp:$cf, V64:$vz, I32:$vl), "# pseudo-vfmk.w.$cf $vmx,$vz">;
def VFMKWyvyl : PseudoVFMK<(ins CCOp:$cf, V64:$vz, VM512:$vm, I32:$vl), "# pseudo-vfmk.w.$cf $vmx,$vz,$vm">;

def VFMKSyvl  : PseudoVFMK<(ins CCOp:$cf, V64:$vz, I32:$vl), "# pseudo-vfmk.s.$cf $vmx,$vz">;
def VFMKSyvyl : PseudoVFMK<(ins CCOp:$cf, V64:$vz, VM512:$vm, I32:$vl), "# pseudo-vfmk.s.$cf $vmx,$vz,$vm">;

include "VEInstrVecVL.gen.td"
