// LVS lvs lvsl_svs
multiclass DefLVS<ValueType OutVT> {
  def _svs : RV<0x9e, (outs OutVT:$sx), (ins V64:$vx, I32:$sy),
         "lvs $sx,$vx($sy)">
  {
    let DecoderNamespace = "VEL";
    let isCodeGenOnly = 1;
  }
  def _svI : RV<0x9e, (outs OutVT:$sx), (ins V64:$vx, simm7Op32:$sy),
         "lvs $sx,$vx($sy)">
  {
    let DecoderNamespace = "VEL";
    let isCodeGenOnly = 1;
  }
}

defm lvsl : DefLVS<I64>;
defm lvss : DefLVS<F32>;
defm lvsw : DefLVS<I32>;

multiclass DefLSV<ValueType ElemVT> {
// inst=LVS asm=lvv intrisic=lsv_vvss
def _vvss : RV<0x8e, (outs V64:$vx), (ins V64:$vd, I32:$sy, ElemVT:$sz),
       "lsv $vx($sy),$sz">
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

def _vvIs : RV<0x8e, (outs V64:$vx), (ins V64:$vd, simm7Op32:$sy, ElemVT:$sz),
       "lsv $vx($sy),$sz">
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

}

defm lsv : DefLSV<I64>;
defm lsvs : DefLSV<F32>;
defm lsvw : DefLSV<I32>;


// temporary (used in reg-to-reg copy)
def vor_v1vl : RV<0xc5, (outs V64:$vx), (ins uimm6Op64:$sy, V64:$vz, I32:$vl),
       "vor $vx,($sy)1,$vz">
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}


include "VEInstrVecVL.gen.td"
