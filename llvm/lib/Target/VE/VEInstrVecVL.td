// LVS lvs veoldLVSLvr
def veoldLVSLvr : RV<0x9e, (outs I64:$sx), (ins V64:$vx, I32:$sy),
       "lvs $sx,$vx($sy)", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

def veoldLVSLvi : RV<0x9e, (outs I64:$sx), (ins V64:$vx, simm7:$sy),
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

// tempolary
def veoldVOR1vl : RV<0xc5, (outs V64:$vx), (ins uimm6:$sy, V64:$vz, I32:$vl),
       "vor $vx,($sy)1,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// vfmk

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


include "VEInstrVecVL.gen.td"
