// LVS lvs veoldLVSLvr
def veoldLVSvr : RV<0x9e, (outs I64:$sx), (ins V64:$vx, I32:$sy),
       "lvs $sx,$vx($sy)", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

/*
def veoldLVSvi : RV<0x9e, (outs I64:$sx), (ins V64:$vx, simm7:$sy),
       "lvs $sx,$vx($sy)", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}


// LVS lvs veoldLVSSvr
def veoldLVSSvr : RV<0x9e, (outs F32:$sx), (ins V64:$vx, I32:$sy),
       "lvs $sx,$vx($sy)", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}
*/

// inst=LSV asm=lsv intrisic=veoldLSVrr_v
def veoldLSVrr_v : RV<0x8e, (outs V64:$vx), (ins I32:$sy, I64:$sz, V64:$pt),
       "lsv $vx($sy),$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

def veoldLSVir_v : RV<0x8e, (outs V64:$vx), (ins simm7:$sy, I64:$sz, V64:$pt),
       "lsv $vx($sy),$sz", [], NoItinerary>
{
  let Constraints = "$vx = $pt";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

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


def veoldVFMKyal : Pseudo<(outs VM512:$vmx), (ins I32:$vl),
                          "# pseudo-vfmk.at $vmx", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldVFMKynal : Pseudo<(outs VM512:$vmx), (ins I32:$vl),
                          "# pseudo-vfmk.af $vmx", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// i64, vm256
def veoldVFMKLxvl : RV<0xB4, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                      "vfmk.l.$cf $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldVFMKLxvxl : RV<0xB4, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm, I32:$vl),
                      "vfmk.l.$cf $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// i32, vm256
def veoldVFMKWxvl : RV<0xB4, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                      "vfmk.w.$cf $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldVFMKWxvxl : RV<0xB4, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm, I32:$vl),
                      "vfmk.w.$cf $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldPVFMKWLOxvl : RV<0xB5, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                         "vfmk.w.$cf $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldPVFMKWLOxvxl : RV<0xB5, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm, I32:$vl),
                         "vfmk.w.$cf $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldPVFMKWUPxvl : RV<0xB5, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                         "pvfmk.w.up.$cf $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldPVFMKWUPxvxl : RV<0xB5, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm, I32:$vl),
                         "pvfmk.w.up.$cf $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// i32, vm512 (Pseduo)
def veoldVFMKWyvl : Pseudo<(outs VM512:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                           "# pseudo-vfmk.w.$cf $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldVFMKWyvyl : Pseudo<(outs VM512:$vmx), (ins CCOp:$cf, V64:$vz, VM512:$vm, I32:$vl),
                             "# pseudo-vfmk.w.$cf $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// f64, vm256
def veoldVFMKDxvl : RV<0xB4, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                      "vfmk.d.$cf $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldVFMKDxvxl : RV<0xB4, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm, I32:$vl),
                      "vfmk.d.$cf $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// f32, vm256
def veoldVFMKSxvl : RV<0xB4, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                      "vfmk.s.$cf $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldVFMKSxvxl : RV<0xB4, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm, I32:$vl),
                      "vfmk.s.$cf $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldPVFMKSLOxvl : RV<0xB5, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                         "pvfmk.s.lo.$cf $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldPVFMKSLOxvxl : RV<0xB5, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm, I32:$vl),
                         "pvfmk.s.lo.$cf $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldPVFMKSUPxvl : RV<0xB5, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                         "pvfmk.s.up.$cf $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldPVFMKSUPxvxl : RV<0xB5, (outs VM:$vmx), (ins CCOp:$cf, V64:$vz, VM:$vm, I32:$vl),
                         "pvfmk.s.up.$cf $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// i32, vm512 (Pseduo)
def veoldVFMKSyvl : Pseudo<(outs VM512:$vmx), (ins CCOp:$cf, V64:$vz, I32:$vl),
                           "# pvfmk.s.$cf $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

def veoldVFMKSyvyl : Pseudo<(outs VM512:$vmx), (ins CCOp:$cf, V64:$vz, VM512:$vm, I32:$vl),
                             "# pvfmk.s.$cf $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX, VFIXX

class veoldVCVT<string asm, dag ins> : RV<0xe8, (outs V64:$vx), ins, asm, [], NoItinerary> {
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

multiclass veoldVCVTm<string asm, RegisterClass RC> {
  def vl : veoldVCVT<asm#"$rd $vx,$vy", (ins RDOp:$rd, V64:$vy, I32:$vl)>;

  let Constraints = "$vx = $pt" in
  def vl_v : veoldVCVT<asm#"$rd $vx,$vy", (ins RDOp:$rd, V64:$vy, I32:$vl, V64:$pt)>;

  let Constraints = "$vx = $pt" in
  def vxl_v : veoldVCVT<asm#"$rd $vx,$vy,$vm", (ins RDOp:$rd, V64:$vy, RC:$vm, I32:$vl, V64:$pt)>;
}

defm veoldVCVTWDSX : veoldVCVTm<"vcvt.w.d.sx", VM>;
defm veoldVCVTWDZX : veoldVCVTm<"vcvt.w.d.zx", VM>;
defm veoldVCVTWSSX : veoldVCVTm<"vcvt.w.s.sx", VM>;
defm veoldVCVTWSZX : veoldVCVTm<"vcvt.w.s.zx", VM>;
defm veoldPVCVTWS : veoldVCVTm<"pvcvt.w.s", VM512>;
defm veoldVCVTLD : veoldVCVTm<"vcvt.l.d", VM>;

include "VEInstrVecVL.gen.td"
