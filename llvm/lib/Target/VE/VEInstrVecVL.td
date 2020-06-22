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


include "VEInstrVecVL.gen.td"
