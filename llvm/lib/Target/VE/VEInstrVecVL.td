// LVS lvs lvsl_svs
def lvsl_svs : RV<0x9e, (outs I64:$sx), (ins V64:$vx, I32:$sy),
       "lvs $sx,$vx($sy)", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

def lvsl_svI : RV<0x9e, (outs I64:$sx), (ins V64:$vx, simm7Op32:$sy),
       "lvs $sx,$vx($sy)", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}


// LVS lvs lvss_svs
def lvss_svs : RV<0x9e, (outs F32:$sx), (ins V64:$vx, I32:$sy),
       "lvs $sx,$vx($sy)", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=LSV asm=lsv intrisic=lsv_vvss
def lsv_vvss : RV<0x8e, (outs V64:$vx), (ins V64:$vd, I32:$sy, I64:$sz),
       "lsv $vx($sy),$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

def lsv_vvIs : RV<0x8e, (outs V64:$vx), (ins V64:$vd, simm7Op32:$sy, I64:$sz),
       "lsv $vx($sy),$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

def vor_v1vl : RV<0xc5, (outs V64:$vx), (ins uimm6Op64:$sy, V64:$vz, I32:$vl),
       "vor $vx,($sy)1,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}


include "VEInstrVecVL.gen.td"
