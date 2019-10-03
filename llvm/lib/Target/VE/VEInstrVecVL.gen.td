// inst=VLD asm=vld intrisic=vld_vssl
def vld_vssl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld intrisic=vld_vssvl
def vld_vssvl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld intrisic=vld_vssl
def vld_vIsl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vld $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld intrisic=vld_vssvl
def vld_vIsvl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld.nc intrisic=vldnc_vssl
def vldnc_vssl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld.nc intrisic=vldnc_vssvl
def vldnc_vssvl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld.nc intrisic=vldnc_vssl
def vldnc_vIsl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vld.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD asm=vld.nc intrisic=vldnc_vssvl
def vldnc_vIsvl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu intrisic=vldu_vssl
def vldu_vssl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu intrisic=vldu_vssvl
def vldu_vssvl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu intrisic=vldu_vssl
def vldu_vIsl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu intrisic=vldu_vssvl
def vldu_vIsvl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu.nc intrisic=vldunc_vssl
def vldunc_vssl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu.nc intrisic=vldunc_vssvl
def vldunc_vssvl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu.nc intrisic=vldunc_vssl
def vldunc_vIsl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldu.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU asm=vldu.nc intrisic=vldunc_vssvl
def vldunc_vIsvl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx intrisic=vldlsx_vssl
def vldlsx_vssl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.sx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx intrisic=vldlsx_vssvl
def vldlsx_vssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx intrisic=vldlsx_vssl
def vldlsx_vIsl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl.sx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx intrisic=vldlsx_vssvl
def vldlsx_vIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx.nc intrisic=vldlsxnc_vssl
def vldlsxnc_vssl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx.nc intrisic=vldlsxnc_vssvl
def vldlsxnc_vssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx.nc intrisic=vldlsxnc_vssl
def vldlsxnc_vIsl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.sx.nc intrisic=vldlsxnc_vssvl
def vldlsxnc_vIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx intrisic=vldlzx_vssl
def vldlzx_vssl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.zx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx intrisic=vldlzx_vssvl
def vldlzx_vssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx intrisic=vldlzx_vssl
def vldlzx_vIsl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl.zx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx intrisic=vldlzx_vssvl
def vldlzx_vIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx.nc intrisic=vldlzxnc_vssl
def vldlzxnc_vssl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx.nc intrisic=vldlzxnc_vssvl
def vldlzxnc_vssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx.nc intrisic=vldlzxnc_vssl
def vldlzxnc_vIsl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL asm=vldl.zx.nc intrisic=vldlzxnc_vssvl
def vldlzxnc_vIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d intrisic=vld2d_vssl
def vld2d_vssl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d intrisic=vld2d_vssvl
def vld2d_vssvl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld2d $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d intrisic=vld2d_vssl
def vld2d_vIsl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vld2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d intrisic=vld2d_vssvl
def vld2d_vIsvl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld2d $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d.nc intrisic=vld2dnc_vssl
def vld2dnc_vssl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d.nc intrisic=vld2dnc_vssvl
def vld2dnc_vssvl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d.nc intrisic=vld2dnc_vssl
def vld2dnc_vIsl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vld2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLD2D asm=vld2d.nc intrisic=vld2dnc_vssvl
def vld2dnc_vIsvl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d intrisic=vldu2d_vssl
def vldu2d_vssl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d intrisic=vldu2d_vssvl
def vldu2d_vssvl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d intrisic=vldu2d_vssl
def vldu2d_vIsl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d intrisic=vldu2d_vssvl
def vldu2d_vIsvl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d.nc intrisic=vldu2dnc_vssl
def vldu2dnc_vssl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d.nc intrisic=vldu2dnc_vssvl
def vldu2dnc_vssvl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d.nc intrisic=vldu2dnc_vssl
def vldu2dnc_vIsl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDU2D asm=vldu2d.nc intrisic=vldu2dnc_vssvl
def vldu2dnc_vIsvl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx intrisic=vldl2dsx_vssl
def vldl2dsx_vssl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.sx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx intrisic=vldl2dsx_vssvl
def vldl2dsx_vssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx intrisic=vldl2dsx_vssl
def vldl2dsx_vIsl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl2d.sx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx intrisic=vldl2dsx_vssvl
def vldl2dsx_vIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx.nc intrisic=vldl2dsxnc_vssl
def vldl2dsxnc_vssl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx.nc intrisic=vldl2dsxnc_vssvl
def vldl2dsxnc_vssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx.nc intrisic=vldl2dsxnc_vssl
def vldl2dsxnc_vIsl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl2d.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.sx.nc intrisic=vldl2dsxnc_vssvl
def vldl2dsxnc_vIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx intrisic=vldl2dzx_vssl
def vldl2dzx_vssl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.zx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx intrisic=vldl2dzx_vssvl
def vldl2dzx_vssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx intrisic=vldl2dzx_vssl
def vldl2dzx_vIsl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl2d.zx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx intrisic=vldl2dzx_vssvl
def vldl2dzx_vIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx.nc intrisic=vldl2dzxnc_vssl
def vldl2dzxnc_vssl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx.nc intrisic=vldl2dzxnc_vssvl
def vldl2dzxnc_vssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx.nc intrisic=vldl2dzxnc_vssl
def vldl2dzxnc_vIsl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl2d.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VLDL2D asm=vldl2d.zx.nc intrisic=vldl2dzxnc_vssvl
def vldl2dzxnc_vIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssl
def vst_vssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssl
def vst_vIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssml
def vst_vssml : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst intrisic=vst_vssml
def vst_vIsml : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssl
def vstnc_vssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssl
def vstnc_vIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssml
def vstnc_vssml : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc intrisic=vstnc_vssml
def vstnc_vIsml : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssl
def vstot_vssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssl
def vstot_vIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssml
def vstot_vssml : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.ot intrisic=vstot_vssml
def vstot_vIsml : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssl
def vstncot_vssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssl
def vstncot_vIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssml
def vstncot_vssml : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST asm=vst.nc.ot intrisic=vstncot_vssml
def vstncot_vIsml : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssl
def vstu_vssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssl
def vstu_vIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssml
def vstu_vssml : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu intrisic=vstu_vssml
def vstu_vIsml : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssl
def vstunc_vssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssl
def vstunc_vIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssml
def vstunc_vssml : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc intrisic=vstunc_vssml
def vstunc_vIsml : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssl
def vstuot_vssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssl
def vstuot_vIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssml
def vstuot_vssml : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.ot intrisic=vstuot_vssml
def vstuot_vIsml : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssl
def vstuncot_vssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssl
def vstuncot_vIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssml
def vstuncot_vssml : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU asm=vstu.nc.ot intrisic=vstuncot_vssml
def vstuncot_vIsml : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssl
def vstl_vssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssl
def vstl_vIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssml
def vstl_vssml : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl intrisic=vstl_vssml
def vstl_vIsml : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssl
def vstlnc_vssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssl
def vstlnc_vIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssml
def vstlnc_vssml : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc intrisic=vstlnc_vssml
def vstlnc_vIsml : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssl
def vstlot_vssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssl
def vstlot_vIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssml
def vstlot_vssml : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.ot intrisic=vstlot_vssml
def vstlot_vIsml : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssl
def vstlncot_vssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssl
def vstlncot_vIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssml
def vstlncot_vssml : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL asm=vstl.nc.ot intrisic=vstlncot_vssml
def vstlncot_vIsml : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssl
def vst2d_vssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssl
def vst2d_vIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssml
def vst2d_vssml : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d intrisic=vst2d_vssml
def vst2d_vIsml : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssl
def vst2dnc_vssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssl
def vst2dnc_vIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssml
def vst2dnc_vssml : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc intrisic=vst2dnc_vssml
def vst2dnc_vIsml : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssl
def vst2dot_vssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssl
def vst2dot_vIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssml
def vst2dot_vssml : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.ot intrisic=vst2dot_vssml
def vst2dot_vIsml : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssl
def vst2dncot_vssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssl
def vst2dncot_vIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssml
def vst2dncot_vssml : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VST2D asm=vst2d.nc.ot intrisic=vst2dncot_vssml
def vst2dncot_vIsml : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssl
def vstu2d_vssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssl
def vstu2d_vIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssml
def vstu2d_vssml : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d intrisic=vstu2d_vssml
def vstu2d_vIsml : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssl
def vstu2dnc_vssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssl
def vstu2dnc_vIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssml
def vstu2dnc_vssml : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc intrisic=vstu2dnc_vssml
def vstu2dnc_vIsml : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssl
def vstu2dot_vssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssl
def vstu2dot_vIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssml
def vstu2dot_vssml : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.ot intrisic=vstu2dot_vssml
def vstu2dot_vIsml : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssl
def vstu2dncot_vssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssl
def vstu2dncot_vIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssml
def vstu2dncot_vssml : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTU2D asm=vstu2d.nc.ot intrisic=vstu2dncot_vssml
def vstu2dncot_vIsml : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssl
def vstl2d_vssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssl
def vstl2d_vIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssml
def vstl2d_vssml : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d intrisic=vstl2d_vssml
def vstl2d_vIsml : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssl
def vstl2dnc_vssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssl
def vstl2dnc_vIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssml
def vstl2dnc_vssml : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc intrisic=vstl2dnc_vssml
def vstl2dnc_vIsml : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssl
def vstl2dot_vssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssl
def vstl2dot_vIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssml
def vstl2dot_vssml : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.ot intrisic=vstl2dot_vssml
def vstl2dot_vIsml : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssl
def vstl2dncot_vssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssl
def vstl2dncot_vIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssml
def vstl2dncot_vssml : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSTL2D asm=vstl2d.nc.ot intrisic=vstl2dncot_vssml
def vstl2dncot_vIsml : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=PFCHV asm=pfchv intrisic=pfchv_ssl
def pfchv_ssl : RV<0x80, (outs ), (ins I64:$sy, I64:$sz, I32:$vl),
       "pfchv $sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=PFCHV asm=pfchv intrisic=pfchv_ssl
def pfchv_Isl : RV<0x80, (outs ), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "pfchv $I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=PFCHV asm=pfchv.nc intrisic=pfchvnc_ssl
def pfchvnc_ssl : RV<0x80, (outs ), (ins I64:$sy, I64:$sz, I32:$vl),
       "pfchv.nc $sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=PFCHV asm=pfchv.nc intrisic=pfchvnc_ssl
def pfchvnc_Isl : RV<0x80, (outs ), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "pfchv.nc $I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=LSV asm=lsv intrisic=lsv_vvss
def lsv_vvss : RV<0x8e, (outs V64:$vx), (ins V64:$vd, I32:$sy, I64:$sz),
       "lsv $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=LVM asm=lvm intrisic=lvm_mmss
def lvm_mmss : RV<0xb7, (outs VM_:$vmx), (ins VM_:$vmd, I64:$sy, I64:$sz),
       "lvm $vmx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=LVM asm=lvm intrisic=lvm_mmss
def lvm_mmIs : RV<0xb7, (outs VM_:$vmx), (ins VM_:$vmd, simm7Op64:$N, I64:$sz),
       "lvm $vmx,$N,$sz", [], NoItinerary>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=LVM asm=lvm intrisic=lvm_MMss
def lvm_MMss : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmd, I64:$sy, I64:$sz),
       "# lvm $vmx,$sy,$sz", []>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=LVM asm=lvm intrisic=lvm_MMss
def lvm_MMIs : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmd, simm7Op64:$N, I64:$sz),
       "# lvm $vmx,$N,$sz", []>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=SVM asm=svm intrisic=svm_sms
def svm_sms : RV<0xa7, (outs I64:$sx), (ins VM_:$vmz, I64:$sy),
       "svm $sx,$vmz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=SVM asm=svm intrisic=svm_sms
def svm_smI : RV<0xa7, (outs I64:$sx), (ins VM_:$vmz, simm7Op64:$N),
       "svm $sx,$vmz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=SVM asm=svm intrisic=svm_sMs
def svm_sMs : Pseudo<(outs I64:$sx), (ins VM512_:$vmz, I64:$sy),
       "# svm $sx,$vmz,$sy", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=SVM asm=svm intrisic=svm_sMs
def svm_sMI : Pseudo<(outs I64:$sx), (ins VM512_:$vmz, simm7Op64:$N),
       "# svm $sx,$vmz,$N", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsl
def vbrd_vsl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, I32:$vl),
       "vbrd $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsvl
def vbrd_vsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, I32:$vl),
       "vbrd $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsmvl
def vbrd_vsmvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vbrd $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsl
def vbrd_vIl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, I32:$vl),
       "vbrd $vx,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsvl
def vbrd_vIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, V64:$vd, I32:$vl),
       "vbrd $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrd intrisic=vbrdl_vsmvl
def vbrd_vImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vbrd $vx,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdu intrisic=vbrds_vsl
def vbrdu_vsl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, I32:$vl),
       "vbrdu $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdu intrisic=vbrds_vsvl
def vbrdu_vsvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, V64:$vd, I32:$vl),
       "vbrdu $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdu intrisic=vbrds_vsmvl
def vbrdu_vsmvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vbrdu $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsl
def vbrdl_vsl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, I32:$vl),
       "vbrdl $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsvl
def vbrdl_vsvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, V64:$vd, I32:$vl),
       "vbrdl $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsmvl
def vbrdl_vsmvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vbrdl $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsl
def vbrdl_vIl : RV<0x8c, (outs V64:$vx), (ins simm7Op32:$I, I32:$vl),
       "vbrdl $vx,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsvl
def vbrdl_vIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op32:$I, V64:$vd, I32:$vl),
       "vbrdl $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=vbrdl intrisic=vbrdw_vsmvl
def vbrdl_vImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vbrdl $vx,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=pvbrd intrisic=pvbrd_vsl
def pvbrd_vsl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, I32:$vl),
       "pvbrd $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=pvbrd intrisic=pvbrd_vsvl
def pvbrd_vsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, I32:$vl),
       "pvbrd $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VBRD asm=pvbrd intrisic=pvbrd_vsMvl
def pvbrd_vsMvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvbrd $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvl
def vmv_vsvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmv $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvvl
def vmv_vsvvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvl
def vmv_vIvl : RV<0x9c, (outs V64:$vx), (ins simm7Op32:$N, V64:$vz, I32:$vl),
       "vmv $vx,$N,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvvl
def vmv_vIvvl : RV<0x9c, (outs V64:$vx), (ins simm7Op32:$N, V64:$vz, V64:$vd, I32:$vl),
       "vmv $vx,$N,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvmvl
def vmv_vsvmvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMV asm=vmv intrisic=vmv_vsvmvl
def vmv_vIvmvl : RV<0x9c, (outs V64:$vx), (ins simm7Op32:$N, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmv $vx,$N,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vvvl
def vaddul_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vaddu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vvvvl
def vaddul_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvl
def vaddul_vsvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vaddu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvvl
def vaddul_vsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvl
def vaddul_vIvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vaddu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvvl
def vaddul_vIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vvvmvl
def vaddul_vvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvmvl
def vaddul_vsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.l intrisic=vaddul_vsvmvl
def vaddul_vIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vvvl
def vadduw_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vaddu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vvvvl
def vadduw_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvl
def vadduw_vsvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vaddu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvvl
def vadduw_vsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvl
def vadduw_vIvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vaddu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvvl
def vadduw_vIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vvvmvl
def vadduw_vvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvmvl
def vadduw_vsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=vaddu.w intrisic=vadduw_vsvmvl
def vadduw_vIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vvvl
def pvaddu_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvaddu $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vvvvl
def pvaddu_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvaddu $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vsvl
def pvaddu_vsvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvaddu $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vsvvl
def pvaddu_vsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvaddu $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vvvMvl
def pvaddu_vvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvaddu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADD asm=pvaddu intrisic=pvaddu_vsvMvl
def pvaddu_vsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvaddu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vvvl
def vaddswsx_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vvvvl
def vaddswsx_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvl
def vaddswsx_vsvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvvl
def vaddswsx_vsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvl
def vaddswsx_vIvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vadds.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvvl
def vaddswsx_vIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vvvmvl
def vaddswsx_vvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvmvl
def vaddswsx_vsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.sx intrisic=vaddswsx_vsvmvl
def vaddswsx_vIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vvvl
def vaddswzx_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vvvvl
def vaddswzx_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvl
def vaddswzx_vsvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvvl
def vaddswzx_vsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvl
def vaddswzx_vIvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vadds.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvvl
def vaddswzx_vIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vvvmvl
def vaddswzx_vvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvmvl
def vaddswzx_vsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=vadds.w.zx intrisic=vaddswzx_vsvmvl
def vaddswzx_vIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vvvl
def pvadds_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvadds $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vvvvl
def pvadds_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvadds $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vsvl
def pvadds_vsvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvadds $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vsvvl
def pvadds_vsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvadds $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vvvMvl
def pvadds_vvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvadds $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADS asm=pvadds intrisic=pvadds_vsvMvl
def pvadds_vsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvadds $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vvvl
def vaddsl_vvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vadds.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vvvvl
def vaddsl_vvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvl
def vaddsl_vsvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vadds.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvvl
def vaddsl_vsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvl
def vaddsl_vIvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vadds.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvvl
def vaddsl_vIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vvvmvl
def vaddsl_vvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvmvl
def vaddsl_vsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VADX asm=vadds.l intrisic=vaddsl_vsvmvl
def vaddsl_vIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vvvl
def vsubul_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vvvvl
def vsubul_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvl
def vsubul_vsvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vsubu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvvl
def vsubul_vsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvl
def vsubul_vIvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vsubu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvvl
def vsubul_vIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vvvmvl
def vsubul_vvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvmvl
def vsubul_vsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.l intrisic=vsubul_vsvmvl
def vsubul_vIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vvvl
def vsubuw_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vvvvl
def vsubuw_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvl
def vsubuw_vsvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vsubu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvvl
def vsubuw_vsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvl
def vsubuw_vIvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vsubu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvvl
def vsubuw_vIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vvvmvl
def vsubuw_vvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvmvl
def vsubuw_vsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=vsubu.w intrisic=vsubuw_vsvmvl
def vsubuw_vIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vvvl
def pvsubu_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvsubu $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vvvvl
def pvsubu_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubu $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vsvl
def pvsubu_vsvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvsubu $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vsvvl
def pvsubu_vsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubu $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vvvMvl
def pvsubu_vvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUB asm=pvsubu intrisic=pvsubu_vsvMvl
def pvsubu_vsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vvvl
def vsubswsx_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vvvvl
def vsubswsx_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvl
def vsubswsx_vsvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvvl
def vsubswsx_vsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvl
def vsubswsx_vIvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvvl
def vsubswsx_vIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vvvmvl
def vsubswsx_vvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvmvl
def vsubswsx_vsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.sx intrisic=vsubswsx_vsvmvl
def vsubswsx_vIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vvvl
def vsubswzx_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vvvvl
def vsubswzx_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvl
def vsubswzx_vsvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvvl
def vsubswzx_vsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvl
def vsubswzx_vIvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvvl
def vsubswzx_vIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vvvmvl
def vsubswzx_vvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvmvl
def vsubswzx_vsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=vsubs.w.zx intrisic=vsubswzx_vsvmvl
def vsubswzx_vIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vvvl
def pvsubs_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvsubs $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vvvvl
def pvsubs_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubs $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vsvl
def pvsubs_vsvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvsubs $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vsvvl
def pvsubs_vsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubs $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vvvMvl
def pvsubs_vvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBS asm=pvsubs intrisic=pvsubs_vsvMvl
def pvsubs_vsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vvvl
def vsubsl_vvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubs.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vvvvl
def vsubsl_vvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvl
def vsubsl_vsvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vsubs.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvvl
def vsubsl_vsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvl
def vsubsl_vIvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vsubs.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvvl
def vsubsl_vIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vvvmvl
def vsubsl_vvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvmvl
def vsubsl_vsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSBX asm=vsubs.l intrisic=vsubsl_vsvmvl
def vsubsl_vIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vvvl
def vmulul_vvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmulu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vvvvl
def vmulul_vvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvl
def vmulul_vsvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmulu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvvl
def vmulul_vsvvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvl
def vmulul_vIvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vmulu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvvl
def vmulul_vIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vvvmvl
def vmulul_vvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvmvl
def vmulul_vsvmvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.l intrisic=vmulul_vsvmvl
def vmulul_vIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vvvl
def vmuluw_vvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmulu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vvvvl
def vmuluw_vvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvl
def vmuluw_vsvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmulu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvvl
def vmuluw_vsvvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvl
def vmuluw_vIvl : RV<0xc9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmulu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvvl
def vmuluw_vIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vvvmvl
def vmuluw_vvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvmvl
def vmuluw_vsvmvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPY asm=vmulu.w intrisic=vmuluw_vsvmvl
def vmuluw_vIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vvvl
def vmulswsx_vvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vvvvl
def vmulswsx_vvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvl
def vmulswsx_vsvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvvl
def vmulswsx_vsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvl
def vmulswsx_vIvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvvl
def vmulswsx_vIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vvvmvl
def vmulswsx_vvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvmvl
def vmulswsx_vsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.sx intrisic=vmulswsx_vsvmvl
def vmulswsx_vIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vvvl
def vmulswzx_vvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vvvvl
def vmulswzx_vvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvl
def vmulswzx_vsvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvvl
def vmulswzx_vsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvl
def vmulswzx_vIvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvvl
def vmulswzx_vIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vvvmvl
def vmulswzx_vvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvmvl
def vmulswzx_vsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPS asm=vmuls.w.zx intrisic=vmulswzx_vsvmvl
def vmulswzx_vIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vvvl
def vmulsl_vvvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vvvvl
def vmulsl_vvvvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvl
def vmulsl_vsvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmuls.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvvl
def vmulsl_vsvvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvl
def vmulsl_vIvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vmuls.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvvl
def vmulsl_vIvvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vvvmvl
def vmulsl_vvvmvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvmvl
def vmulsl_vsvmvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPX asm=vmuls.l intrisic=vmulsl_vsvmvl
def vmulsl_vIvmvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vvvl
def vmulslw_vvvl : RV<0xd9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.l.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vvvvl
def vmulslw_vvvvl : RV<0xd9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vsvl
def vmulslw_vsvl : RV<0xd9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmuls.l.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vsvvl
def vmulslw_vsvvl : RV<0xd9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vsvl
def vmulslw_vIvl : RV<0xd9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmuls.l.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMPD asm=vmuls.l.w intrisic=vmulslw_vsvvl
def vmulslw_vIvvl : RV<0xd9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvvl
def vdivul_vvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvvvl
def vdivul_vvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvl
def vdivul_vsvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vdivu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvvl
def vdivul_vsvvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvl
def vdivul_vIvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vdivu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvvl
def vdivul_vIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvvmvl
def vdivul_vvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvmvl
def vdivul_vsvmvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vsvmvl
def vdivul_vIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvvl
def vdivuw_vvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvvvl
def vdivuw_vvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvl
def vdivuw_vsvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vdivu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvvl
def vdivuw_vsvvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvl
def vdivuw_vIvl : RV<0xe9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vdivu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvvl
def vdivuw_vIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvvmvl
def vdivuw_vvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvmvl
def vdivuw_vsvmvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vsvmvl
def vdivuw_vIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsl
def vdivul_vvsl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, I32:$vl),
       "vdivu.l $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsvl
def vdivul_vvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsl
def vdivul_vvIl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I32:$vl),
       "vdivu.l $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsvl
def vdivul_vvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsmvl
def vdivul_vvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.l intrisic=vdivul_vvsmvl
def vdivul_vvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsl
def vdivuw_vvsl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl),
       "vdivu.w $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsvl
def vdivuw_vvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsl
def vdivuw_vvIl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, I32:$vl),
       "vdivu.w $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsvl
def vdivuw_vvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsmvl
def vdivuw_vvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDIV asm=vdivu.w intrisic=vdivuw_vvsmvl
def vdivuw_vvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvvl
def vdivswsx_vvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvvvl
def vdivswsx_vvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvl
def vdivswsx_vsvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvvl
def vdivswsx_vsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvl
def vdivswsx_vIvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvvl
def vdivswsx_vIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvvmvl
def vdivswsx_vvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvmvl
def vdivswsx_vsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vsvmvl
def vdivswsx_vIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvvl
def vdivswzx_vvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvvvl
def vdivswzx_vvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvl
def vdivswzx_vsvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvvl
def vdivswzx_vsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvl
def vdivswzx_vIvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvvl
def vdivswzx_vIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvvmvl
def vdivswzx_vvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvmvl
def vdivswzx_vsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vsvmvl
def vdivswzx_vIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsl
def vdivswsx_vvsl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsvl
def vdivswsx_vvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsl
def vdivswsx_vvIl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsvl
def vdivswsx_vvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsmvl
def vdivswsx_vvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.sx intrisic=vdivswsx_vvsmvl
def vdivswsx_vvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsl
def vdivswzx_vvsl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsvl
def vdivswzx_vvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsl
def vdivswzx_vvIl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsvl
def vdivswzx_vvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsmvl
def vdivswzx_vvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVS asm=vdivs.w.zx intrisic=vdivswzx_vvsmvl
def vdivswzx_vvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvvl
def vdivsl_vvvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivs.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvvvl
def vdivsl_vvvvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvl
def vdivsl_vsvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vdivs.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvvl
def vdivsl_vsvvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvl
def vdivsl_vIvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vdivs.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvvl
def vdivsl_vIvvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvvmvl
def vdivsl_vvvmvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvmvl
def vdivsl_vsvmvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vsvmvl
def vdivsl_vIvmvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsl
def vdivsl_vvsl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, I32:$vl),
       "vdivs.l $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsvl
def vdivsl_vvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsl
def vdivsl_vvIl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I32:$vl),
       "vdivs.l $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsvl
def vdivsl_vvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsmvl
def vdivsl_vvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VDVX asm=vdivs.l intrisic=vdivsl_vvsmvl
def vdivsl_vvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vvvl
def vcmpul_vvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmpu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vvvvl
def vcmpul_vvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvl
def vcmpul_vsvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vcmpu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvvl
def vcmpul_vsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvl
def vcmpul_vIvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vcmpu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvvl
def vcmpul_vIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vvvmvl
def vcmpul_vvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvmvl
def vcmpul_vsvmvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.l intrisic=vcmpul_vsvmvl
def vcmpul_vIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vvvl
def vcmpuw_vvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmpu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vvvvl
def vcmpuw_vvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvl
def vcmpuw_vsvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vcmpu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvvl
def vcmpuw_vsvvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvl
def vcmpuw_vIvl : RV<0xb9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vcmpu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvvl
def vcmpuw_vIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vvvmvl
def vcmpuw_vvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvmvl
def vcmpuw_vsvmvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=vcmpu.w intrisic=vcmpuw_vsvmvl
def vcmpuw_vIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vvvl
def pvcmpu_vvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvcmpu $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vvvvl
def pvcmpu_vvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmpu $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vsvl
def pvcmpu_vsvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvcmpu $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vsvvl
def pvcmpu_vsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmpu $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vvvMvl
def pvcmpu_vvvMvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmpu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMP asm=pvcmpu intrisic=pvcmpu_vsvMvl
def pvcmpu_vsvMvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmpu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vvvl
def vcmpswsx_vvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vvvvl
def vcmpswsx_vvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvl
def vcmpswsx_vsvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvvl
def vcmpswsx_vsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvl
def vcmpswsx_vIvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvvl
def vcmpswsx_vIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vvvmvl
def vcmpswsx_vvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvmvl
def vcmpswsx_vsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.sx intrisic=vcmpswsx_vsvmvl
def vcmpswsx_vIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vvvl
def vcmpswzx_vvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vvvvl
def vcmpswzx_vvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvl
def vcmpswzx_vsvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvvl
def vcmpswzx_vsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvl
def vcmpswzx_vIvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvvl
def vcmpswzx_vIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vvvmvl
def vcmpswzx_vvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvmvl
def vcmpswzx_vsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=vcmps.w.zx intrisic=vcmpswzx_vsvmvl
def vcmpswzx_vIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vvvl
def pvcmps_vvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvcmps $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vvvvl
def pvcmps_vvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmps $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vsvl
def pvcmps_vsvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvcmps $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vsvvl
def pvcmps_vsvvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmps $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vvvMvl
def pvcmps_vvvMvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmps $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPS asm=pvcmps intrisic=pvcmps_vsvMvl
def pvcmps_vsvMvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmps $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vvvl
def vcmpsl_vvvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmps.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vvvvl
def vcmpsl_vvvvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvl
def vcmpsl_vsvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vcmps.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvvl
def vcmpsl_vsvvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvl
def vcmpsl_vIvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vcmps.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvvl
def vcmpsl_vIvvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vvvmvl
def vcmpsl_vvvmvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvmvl
def vcmpsl_vsvmvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCPX asm=vcmps.l intrisic=vcmpsl_vsvmvl
def vcmpsl_vIvmvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vvvl
def vmaxswsx_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vvvvl
def vmaxswsx_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvl
def vmaxswsx_vsvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvvl
def vmaxswsx_vsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvl
def vmaxswsx_vIvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvvl
def vmaxswsx_vIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vvvmvl
def vmaxswsx_vvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvmvl
def vmaxswsx_vsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.sx intrisic=vmaxswsx_vsvmvl
def vmaxswsx_vIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vvvl
def vmaxswzx_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vvvvl
def vmaxswzx_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvl
def vmaxswzx_vsvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvvl
def vmaxswzx_vsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvl
def vmaxswzx_vIvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvvl
def vmaxswzx_vIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vvvmvl
def vmaxswzx_vvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvmvl
def vmaxswzx_vsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmaxs.w.zx intrisic=vmaxswzx_vsvmvl
def vmaxswzx_vIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vvvl
def pvmaxs_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvmaxs $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vvvvl
def pvmaxs_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvmaxs $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vsvl
def pvmaxs_vsvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvmaxs $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vsvvl
def pvmaxs_vsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvmaxs $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vvvMvl
def pvmaxs_vvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmaxs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmaxs intrisic=pvmaxs_vsvMvl
def pvmaxs_vsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmaxs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vvvl
def vminswsx_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vvvvl
def vminswsx_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvl
def vminswsx_vsvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvvl
def vminswsx_vsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvl
def vminswsx_vIvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmins.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvvl
def vminswsx_vIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vvvmvl
def vminswsx_vvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvmvl
def vminswsx_vsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.sx intrisic=vminswsx_vsvmvl
def vminswsx_vIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vvvl
def vminswzx_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vvvvl
def vminswzx_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvl
def vminswzx_vsvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvvl
def vminswzx_vsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvl
def vminswzx_vIvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmins.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvvl
def vminswzx_vIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vvvmvl
def vminswzx_vvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvmvl
def vminswzx_vsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=vmins.w.zx intrisic=vminswzx_vsvmvl
def vminswzx_vIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vvvl
def pvmins_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvmins $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vvvvl
def pvmins_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvmins $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vsvl
def pvmins_vsvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvmins $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vsvvl
def pvmins_vsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvmins $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vvvMvl
def pvmins_vvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmins $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMS asm=pvmins intrisic=pvmins_vsvMvl
def pvmins_vsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmins $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vvvl
def vmaxsl_vvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmaxs.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vvvvl
def vmaxsl_vvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvl
def vmaxsl_vsvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmaxs.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvvl
def vmaxsl_vsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvl
def vmaxsl_vIvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vmaxs.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvvl
def vmaxsl_vIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vvvmvl
def vmaxsl_vvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvmvl
def vmaxsl_vsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmaxs.l intrisic=vmaxsl_vsvmvl
def vmaxsl_vIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vvvl
def vminsl_vvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmins.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vvvvl
def vminsl_vvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvl
def vminsl_vsvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmins.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvvl
def vminsl_vsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvl
def vminsl_vIvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vmins.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvvl
def vminsl_vIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vvvmvl
def vminsl_vvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvmvl
def vminsl_vsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCMX asm=vmins.l intrisic=vminsl_vsvmvl
def vminsl_vIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vvvl
def vand_vvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vand $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vvvvl
def vand_vvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vand $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vsvl
def vand_vsvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vand $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vsvvl
def vand_vsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vand $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vvvmvl
def vand_vvvmvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=vand intrisic=vand_vsvmvl
def vand_vsvmvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vvvl
def pvand_vvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvand $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vvvvl
def pvand_vvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvand $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vsvl
def pvand_vsvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvand $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vsvvl
def pvand_vsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvand $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vvvMvl
def pvand_vvvMvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VAND asm=pvand intrisic=pvand_vsvMvl
def pvand_vsvMvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vvvl
def vor_vvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vvvvl
def vor_vvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vsvl
def vor_vsvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vsvvl
def vor_vsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vvvmvl
def vor_vvvmvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=vor intrisic=vor_vsvmvl
def vor_vsvmvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vvvl
def pvor_vvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vvvvl
def pvor_vvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vsvl
def pvor_vsvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vsvvl
def pvor_vsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vvvMvl
def pvor_vvvMvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VOR asm=pvor intrisic=pvor_vsvMvl
def pvor_vsvMvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vvvl
def vxor_vvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vxor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vvvvl
def vxor_vvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vxor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vsvl
def vxor_vsvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vxor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vsvvl
def vxor_vsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vxor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vvvmvl
def vxor_vvvmvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=vxor intrisic=vxor_vsvmvl
def vxor_vsvmvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vvvl
def pvxor_vvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvxor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vvvvl
def pvxor_vvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvxor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vsvl
def pvxor_vsvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvxor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vsvvl
def pvxor_vsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvxor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vvvMvl
def pvxor_vvvMvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VXOR asm=pvxor intrisic=pvxor_vsvMvl
def pvxor_vsvMvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vvvl
def veqv_vvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "veqv $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vvvvl
def veqv_vvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "veqv $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vsvl
def veqv_vsvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "veqv $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vsvvl
def veqv_vsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "veqv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vvvmvl
def veqv_vvvmvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "veqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=veqv intrisic=veqv_vsvmvl
def veqv_vsvmvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "veqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vvvl
def pveqv_vvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pveqv $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vvvvl
def pveqv_vvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pveqv $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vsvl
def pveqv_vsvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pveqv $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vsvvl
def pveqv_vsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pveqv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vvvMvl
def pveqv_vvvMvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pveqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEQV asm=pveqv intrisic=pveqv_vsvMvl
def pveqv_vsvMvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pveqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=vseq intrisic=vseq_vl
def vseq_vl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "vseq $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=vseq intrisic=vseq_vvl
def vseq_vvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "vseq $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq.lo intrisic=pvseqlo_vl
def pvseqlo_vl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "pvseq.lo $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq.lo intrisic=pvseqlo_vvl
def pvseqlo_vvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq.lo $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq.up intrisic=pvsequp_vl
def pvsequp_vl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "pvseq.up $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq.up intrisic=pvsequp_vvl
def pvsequp_vvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq.up $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq intrisic=pvseq_vl
def pvseq_vl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "pvseq $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSEQ asm=pvseq intrisic=pvseq_vvl
def pvseq_vvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvvl
def vsll_vvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsll $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvvvl
def vsll_vvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsl
def vsll_vvsl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsll $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsvl
def vsll_vvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsl
def vsll_vvIl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsll $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsvl
def vsll_vvIvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvvmvl
def vsll_vvvmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsmvl
def vsll_vvsmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=vsll intrisic=vsll_vvsmvl
def vsll_vvImvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvvl
def pvsll_vvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsll $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvvvl
def pvsll_vvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvsl
def pvsll_vvsl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsll $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvsvl
def pvsll_vvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvvMvl
def pvsll_vvvMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLL asm=pvsll intrisic=pvsll_vvsMvl
def pvsll_vvsMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvvl
def vsrl_vvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsrl $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvvvl
def vsrl_vvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsl
def vsrl_vvsl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsrl $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsvl
def vsrl_vvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsl
def vsrl_vvIl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsrl $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsvl
def vsrl_vvIvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvvmvl
def vsrl_vvvmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsmvl
def vsrl_vvsmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=vsrl intrisic=vsrl_vvsmvl
def vsrl_vvImvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvvl
def pvsrl_vvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsrl $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvvvl
def pvsrl_vvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvsl
def pvsrl_vvsl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsrl $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvsvl
def pvsrl_vvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvvMvl
def pvsrl_vvvMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRL asm=pvsrl intrisic=pvsrl_vvsMvl
def pvsrl_vvsMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w intrisic=vslaw_vvvl
def vslaw_vvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsla.w $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w intrisic=vslaw_vvvvl
def vslaw_vvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w intrisic=vslaw_vvsl
def vslaw_vvsl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsla.w $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w intrisic=vslaw_vvsvl
def vslaw_vvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w intrisic=vslaw_vvsl
def vslaw_vvIl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsla.w $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w intrisic=vslaw_vvsvl
def vslaw_vvIvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w intrisic=vslaw_vvvmvl
def vslaw_vvvmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w intrisic=vslaw_vvsmvl
def vslaw_vvsmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=vsla.w intrisic=vslaw_vvsmvl
def vslaw_vvImvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvvl
def pvsla_vvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsla $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvvvl
def pvsla_vvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvsl
def pvsla_vvsl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsla $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvsvl
def pvsla_vvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvvMvl
def pvsla_vvvMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLA asm=pvsla intrisic=pvsla_vvsMvl
def pvsla_vvsMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvvl
def vslal_vvvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsla.l $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvvvl
def vslal_vvvvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsl
def vslal_vvsl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsla.l $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsvl
def vslal_vvsvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsl
def vslal_vvIl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsla.l $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsvl
def vslal_vvIvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvvmvl
def vslal_vvvmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsmvl
def vslal_vvsmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSLAX asm=vsla.l intrisic=vslal_vvsmvl
def vslal_vvImvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w intrisic=vsraw_vvvl
def vsraw_vvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsra.w $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w intrisic=vsraw_vvvvl
def vsraw_vvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w intrisic=vsraw_vvsl
def vsraw_vvsl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsra.w $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w intrisic=vsraw_vvsvl
def vsraw_vvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w intrisic=vsraw_vvsl
def vsraw_vvIl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsra.w $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w intrisic=vsraw_vvsvl
def vsraw_vvIvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w intrisic=vsraw_vvvmvl
def vsraw_vvvmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w intrisic=vsraw_vvsmvl
def vsraw_vvsmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=vsra.w intrisic=vsraw_vvsmvl
def vsraw_vvImvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvvl
def pvsra_vvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsra $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvvvl
def pvsra_vvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvsl
def pvsra_vvsl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsra $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvsvl
def pvsra_vvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvvMvl
def pvsra_vvvMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRA asm=pvsra intrisic=pvsra_vvsMvl
def pvsra_vvsMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvvl
def vsral_vvvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsra.l $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvvvl
def vsral_vvvvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsl
def vsral_vvsl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsra.l $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsvl
def vsral_vvsvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsl
def vsral_vvIl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsra.l $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsvl
def vsral_vvIvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvvmvl
def vsral_vvvmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsmvl
def vsral_vvsmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSRAX asm=vsra.l intrisic=vsral_vvsmvl
def vsral_vvImvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssl
def vsfa_vvssl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssvl
def vsfa_vvssvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssl
def vsfa_vvIsl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsfa $vx,$vz,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssvl
def vsfa_vvIsvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssmvl
def vsfa_vvssmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSFA asm=vsfa intrisic=vsfa_vvssmvl
def vsfa_vvIsmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vvvl
def vfaddd_vvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfadd.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vvvvl
def vfaddd_vvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vsvl
def vfaddd_vsvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfadd.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vsvvl
def vfaddd_vsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vvvmvl
def vfaddd_vvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.d intrisic=vfaddd_vsvmvl
def vfaddd_vsvmvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vvvl
def vfadds_vvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfadd.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vvvvl
def vfadds_vvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vsvl
def vfadds_vsvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfadd.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vsvvl
def vfadds_vsvvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vvvmvl
def vfadds_vvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=vfadd.s intrisic=vfadds_vsvmvl
def vfadds_vsvmvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vvvl
def pvfadd_vvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfadd $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vvvvl
def pvfadd_vvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfadd $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vsvl
def pvfadd_vsvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfadd $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vsvvl
def pvfadd_vsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfadd $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vvvMvl
def pvfadd_vvvMvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfadd $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFAD asm=pvfadd intrisic=pvfadd_vsvMvl
def pvfadd_vsvMvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfadd $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vvvl
def vfsubd_vvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfsub.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vvvvl
def vfsubd_vvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vsvl
def vfsubd_vsvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfsub.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vsvvl
def vfsubd_vsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vvvmvl
def vfsubd_vvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.d intrisic=vfsubd_vsvmvl
def vfsubd_vsvmvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vvvl
def vfsubs_vvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfsub.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vvvvl
def vfsubs_vvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vsvl
def vfsubs_vsvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfsub.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vsvvl
def vfsubs_vsvvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vvvmvl
def vfsubs_vvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=vfsub.s intrisic=vfsubs_vsvmvl
def vfsubs_vsvmvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vvvl
def pvfsub_vvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfsub $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vvvvl
def pvfsub_vvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfsub $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vsvl
def pvfsub_vsvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfsub $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vsvvl
def pvfsub_vsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfsub $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vvvMvl
def pvfsub_vvvMvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfsub $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSB asm=pvfsub intrisic=pvfsub_vsvMvl
def pvfsub_vsvMvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfsub $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vvvl
def vfmuld_vvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmul.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vvvvl
def vfmuld_vvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vsvl
def vfmuld_vsvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfmul.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vsvvl
def vfmuld_vsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vvvmvl
def vfmuld_vvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.d intrisic=vfmuld_vsvmvl
def vfmuld_vsvmvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vvvl
def vfmuls_vvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmul.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vvvvl
def vfmuls_vvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vsvl
def vfmuls_vsvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfmul.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vsvvl
def vfmuls_vsvvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vvvmvl
def vfmuls_vvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=vfmul.s intrisic=vfmuls_vsvmvl
def vfmuls_vsvmvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vvvl
def pvfmul_vvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfmul $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vvvvl
def pvfmul_vvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmul $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vsvl
def pvfmul_vsvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfmul $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vsvvl
def pvfmul_vsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmul $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vvvMvl
def pvfmul_vvvMvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmul $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMP asm=pvfmul intrisic=pvfmul_vsvMvl
def pvfmul_vsvMvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmul $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vvvl
def vfdivd_vvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfdiv.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vvvvl
def vfdivd_vvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vsvl
def vfdivd_vsvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfdiv.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vsvvl
def vfdivd_vsvvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vvvmvl
def vfdivd_vvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.d intrisic=vfdivd_vsvmvl
def vfdivd_vsvmvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vvvl
def vfdivs_vvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfdiv.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vvvvl
def vfdivs_vvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vsvl
def vfdivs_vsvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfdiv.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vsvvl
def vfdivs_vsvvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vvvmvl
def vfdivs_vvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFDV asm=vfdiv.s intrisic=vfdivs_vsvmvl
def vfdivs_vsvmvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSQRT asm=vfsqrt.d intrisic=vfsqrtd_vvl
def vfsqrtd_vvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsqrt.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSQRT asm=vfsqrt.d intrisic=vfsqrtd_vvvl
def vfsqrtd_vvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSQRT asm=vfsqrt.s intrisic=vfsqrts_vvl
def vfsqrts_vvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsqrt.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSQRT asm=vfsqrt.s intrisic=vfsqrts_vvvl
def vfsqrts_vvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vvvl
def vfcmpd_vvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfcmp.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vvvvl
def vfcmpd_vvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vsvl
def vfcmpd_vsvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfcmp.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vsvvl
def vfcmpd_vsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vvvmvl
def vfcmpd_vvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.d intrisic=vfcmpd_vsvmvl
def vfcmpd_vsvmvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vvvl
def vfcmps_vvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfcmp.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vvvvl
def vfcmps_vvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vsvl
def vfcmps_vsvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfcmp.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vsvvl
def vfcmps_vsvvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vvvmvl
def vfcmps_vvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=vfcmp.s intrisic=vfcmps_vsvmvl
def vfcmps_vsvmvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vvvl
def pvfcmp_vvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfcmp $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vvvvl
def pvfcmp_vvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfcmp $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vsvl
def pvfcmp_vsvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfcmp $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vsvvl
def pvfcmp_vsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfcmp $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vvvMvl
def pvfcmp_vvvMvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfcmp $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCP asm=pvfcmp intrisic=pvfcmp_vsvMvl
def pvfcmp_vsvMvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfcmp $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vvvl
def vfmaxd_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmax.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vvvvl
def vfmaxd_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vsvl
def vfmaxd_vsvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfmax.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vsvvl
def vfmaxd_vsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vvvmvl
def vfmaxd_vvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.d intrisic=vfmaxd_vsvmvl
def vfmaxd_vsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vvvl
def vfmaxs_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmax.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vvvvl
def vfmaxs_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vsvl
def vfmaxs_vsvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfmax.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vsvvl
def vfmaxs_vsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vvvmvl
def vfmaxs_vvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmax.s intrisic=vfmaxs_vsvmvl
def vfmaxs_vsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vvvl
def pvfmax_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfmax $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vvvvl
def pvfmax_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmax $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vsvl
def pvfmax_vsvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfmax $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vsvvl
def pvfmax_vsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmax $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vvvMvl
def pvfmax_vvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmax $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmax intrisic=pvfmax_vsvMvl
def pvfmax_vsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmax $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vvvl
def vfmind_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmin.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vvvvl
def vfmind_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vsvl
def vfmind_vsvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfmin.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vsvvl
def vfmind_vsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vvvmvl
def vfmind_vvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.d intrisic=vfmind_vsvmvl
def vfmind_vsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vvvl
def vfmins_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmin.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vvvvl
def vfmins_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vsvl
def vfmins_vsvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfmin.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vsvvl
def vfmins_vsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vvvmvl
def vfmins_vvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=vfmin.s intrisic=vfmins_vsvmvl
def vfmins_vsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vvvl
def pvfmin_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfmin $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vvvvl
def pvfmin_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmin $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vsvl
def pvfmin_vsvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfmin $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vsvvl
def pvfmin_vsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmin $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vvvMvl
def pvfmin_vvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmin $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFCM asm=pvfmin intrisic=pvfmin_vsvMvl
def pvfmin_vsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmin $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvvvl
def vfmadd_vvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvvvvl
def vfmadd_vvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vsvvl
def vfmadd_vsvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vsvvvl
def vfmadd_vsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvsvl
def vfmadd_vvsvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvsvvl
def vfmadd_vvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvvvmvl
def vfmadd_vvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vsvvmvl
def vfmadd_vsvvmvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.d intrisic=vfmadd_vvsvmvl
def vfmadd_vvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvvvl
def vfmads_vvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvvvvl
def vfmads_vvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vsvvl
def vfmads_vsvvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vsvvvl
def vfmads_vsvvvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvsvl
def vfmads_vvsvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvsvvl
def vfmads_vvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvvvmvl
def vfmads_vvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vsvvmvl
def vfmads_vsvvmvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=vfmad.s intrisic=vfmads_vvsvmvl
def vfmads_vvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvvvl
def pvfmad_vvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvvvvl
def pvfmad_vvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vsvvl
def pvfmad_vsvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vsvvvl
def pvfmad_vsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvsvl
def pvfmad_vvsvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvsvvl
def pvfmad_vvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvvvMvl
def pvfmad_vvvvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vsvvMvl
def pvfmad_vsvvMvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAD asm=pvfmad intrisic=pvfmad_vvsvMvl
def pvfmad_vvsvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvvvl
def vfmsbd_vvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvvvvl
def vfmsbd_vvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vsvvl
def vfmsbd_vsvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vsvvvl
def vfmsbd_vsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvsvl
def vfmsbd_vvsvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvsvvl
def vfmsbd_vvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvvvmvl
def vfmsbd_vvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vsvvmvl
def vfmsbd_vsvvmvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.d intrisic=vfmsbd_vvsvmvl
def vfmsbd_vvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvvvl
def vfmsbs_vvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvvvvl
def vfmsbs_vvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vsvvl
def vfmsbs_vsvvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vsvvvl
def vfmsbs_vsvvvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvsvl
def vfmsbs_vvsvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvsvvl
def vfmsbs_vvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvvvmvl
def vfmsbs_vvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vsvvmvl
def vfmsbs_vsvvmvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=vfmsb.s intrisic=vfmsbs_vvsvmvl
def vfmsbs_vvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvvvl
def pvfmsb_vvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvvvvl
def pvfmsb_vvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vsvvl
def pvfmsb_vsvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vsvvvl
def pvfmsb_vsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvsvl
def pvfmsb_vvsvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvsvvl
def pvfmsb_vvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvvvMvl
def pvfmsb_vvvvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vsvvMvl
def pvfmsb_vsvvMvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMSB asm=pvfmsb intrisic=pvfmsb_vvsvMvl
def pvfmsb_vvsvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvvvl
def vfnmadd_vvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvvvvl
def vfnmadd_vvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vsvvl
def vfnmadd_vsvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vsvvvl
def vfnmadd_vsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvsvl
def vfnmadd_vvsvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvsvvl
def vfnmadd_vvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvvvmvl
def vfnmadd_vvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vsvvmvl
def vfnmadd_vsvvmvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.d intrisic=vfnmadd_vvsvmvl
def vfnmadd_vvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvvvl
def vfnmads_vvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvvvvl
def vfnmads_vvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vsvvl
def vfnmads_vsvvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vsvvvl
def vfnmads_vsvvvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvsvl
def vfnmads_vvsvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvsvvl
def vfnmads_vvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvvvmvl
def vfnmads_vvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vsvvmvl
def vfnmads_vsvvmvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=vfnmad.s intrisic=vfnmads_vvsvmvl
def vfnmads_vvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvvvl
def pvfnmad_vvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvvvvl
def pvfnmad_vvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vsvvl
def pvfnmad_vsvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vsvvvl
def pvfnmad_vsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvsvl
def pvfnmad_vvsvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvsvvl
def pvfnmad_vvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvvvMvl
def pvfnmad_vvvvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vsvvMvl
def pvfnmad_vsvvMvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMAD asm=pvfnmad intrisic=pvfnmad_vvsvMvl
def pvfnmad_vvsvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvvvl
def vfnmsbd_vvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvvvvl
def vfnmsbd_vvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vsvvl
def vfnmsbd_vsvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vsvvvl
def vfnmsbd_vsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvsvl
def vfnmsbd_vvsvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvsvvl
def vfnmsbd_vvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvvvmvl
def vfnmsbd_vvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vsvvmvl
def vfnmsbd_vsvvmvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.d intrisic=vfnmsbd_vvsvmvl
def vfnmsbd_vvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvvvl
def vfnmsbs_vvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvvvvl
def vfnmsbs_vvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vsvvl
def vfnmsbs_vsvvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vsvvvl
def vfnmsbs_vsvvvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvsvl
def vfnmsbs_vvsvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvsvvl
def vfnmsbs_vvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvvvmvl
def vfnmsbs_vvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vsvvmvl
def vfnmsbs_vsvvmvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=vfnmsb.s intrisic=vfnmsbs_vvsvmvl
def vfnmsbs_vvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvvvl
def pvfnmsb_vvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvvvvl
def pvfnmsb_vvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vsvvl
def pvfnmsb_vsvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vsvvvl
def pvfnmsb_vsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvsvl
def pvfnmsb_vvsvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvsvvl
def pvfnmsb_vvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvvvMvl
def pvfnmsb_vvvvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vsvvMvl
def pvfnmsb_vsvvMvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFNMSB asm=pvfnmsb intrisic=pvfnmsb_vvsvMvl
def pvfnmsb_vvsvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=vrcp.d intrisic=vrcpd_vvl
def vrcpd_vvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrcp.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=vrcp.d intrisic=vrcpd_vvvl
def vrcpd_vvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrcp.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=vrcp.s intrisic=vrcps_vvl
def vrcps_vvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrcp.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=vrcp.s intrisic=vrcps_vvvl
def vrcps_vvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrcp.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=pvrcp intrisic=pvrcp_vvl
def pvrcp_vvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvrcp $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRCP asm=pvrcp intrisic=pvrcp_vvvl
def pvrcp_vvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrcp $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.d intrisic=vrsqrtd_vvl
def vrsqrtd_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.d intrisic=vrsqrtd_vvvl
def vrsqrtd_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.s intrisic=vrsqrts_vvl
def vrsqrts_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.s intrisic=vrsqrts_vvvl
def vrsqrts_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=pvrsqrt intrisic=pvrsqrt_vvl
def pvrsqrt_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvrsqrt $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=pvrsqrt intrisic=pvrsqrt_vvvl
def pvrsqrt_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrsqrt $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.d.nex intrisic=vrsqrtdnex_vvl
def vrsqrtdnex_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.d.nex $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.d.nex intrisic=vrsqrtdnex_vvvl
def vrsqrtdnex_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.d.nex $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.s.nex intrisic=vrsqrtsnex_vvl
def vrsqrtsnex_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.s.nex $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=vrsqrt.s.nex intrisic=vrsqrtsnex_vvvl
def vrsqrtsnex_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.s.nex $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=pvrsqrt.nex intrisic=pvrsqrtnex_vvl
def pvrsqrtnex_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvrsqrt.nex $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRSQRT asm=pvrsqrt.nex intrisic=pvrsqrtnex_vvvl
def pvrsqrtnex_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrsqrt.nex $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx intrisic=vcvtwdsx_vvl
def vcvtwdsx_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx intrisic=vcvtwdsx_vvvl
def vcvtwdsx_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx intrisic=vcvtwdsx_vvmvl
def vcvtwdsx_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.sx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx.rz intrisic=vcvtwdsxrz_vvl
def vcvtwdsxrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx.rz intrisic=vcvtwdsxrz_vvvl
def vcvtwdsxrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.sx.rz intrisic=vcvtwdsxrz_vvmvl
def vcvtwdsxrz_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx intrisic=vcvtwdzx_vvl
def vcvtwdzx_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx intrisic=vcvtwdzx_vvvl
def vcvtwdzx_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx intrisic=vcvtwdzx_vvmvl
def vcvtwdzx_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.zx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx.rz intrisic=vcvtwdzxrz_vvl
def vcvtwdzxrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx.rz intrisic=vcvtwdzxrz_vvvl
def vcvtwdzxrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.d.zx.rz intrisic=vcvtwdzxrz_vvmvl
def vcvtwdzxrz_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx intrisic=vcvtwssx_vvl
def vcvtwssx_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx intrisic=vcvtwssx_vvvl
def vcvtwssx_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx intrisic=vcvtwssx_vvmvl
def vcvtwssx_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.sx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx.rz intrisic=vcvtwssxrz_vvl
def vcvtwssxrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx.rz intrisic=vcvtwssxrz_vvvl
def vcvtwssxrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.sx.rz intrisic=vcvtwssxrz_vvmvl
def vcvtwssxrz_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx intrisic=vcvtwszx_vvl
def vcvtwszx_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx intrisic=vcvtwszx_vvvl
def vcvtwszx_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx intrisic=vcvtwszx_vvmvl
def vcvtwszx_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.zx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx.rz intrisic=vcvtwszxrz_vvl
def vcvtwszxrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx.rz intrisic=vcvtwszxrz_vvvl
def vcvtwszxrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=vcvt.w.s.zx.rz intrisic=vcvtwszxrz_vvmvl
def vcvtwszxrz_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s intrisic=pvcvtws_vvl
def pvcvtws_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvcvt.w.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s intrisic=pvcvtws_vvvl
def pvcvtws_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.w.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s intrisic=pvcvtws_vvMvl
def pvcvtws_vvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcvt.w.s $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s.rz intrisic=pvcvtwsrz_vvl
def pvcvtwsrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s.rz intrisic=pvcvtwsrz_vvvl
def pvcvtwsrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIX asm=pvcvt.w.s.rz intrisic=pvcvtwsrz_vvMvl
def pvcvtwsrz_vvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d intrisic=vcvtld_vvl
def vcvtld_vvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.l.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d intrisic=vcvtld_vvvl
def vcvtld_vvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.l.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d intrisic=vcvtld_vvmvl
def vcvtld_vvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.l.d $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d.rz intrisic=vcvtldrz_vvl
def vcvtldrz_vvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.l.d.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d.rz intrisic=vcvtldrz_vvvl
def vcvtldrz_vvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.l.d.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFIXX asm=vcvt.l.d.rz intrisic=vcvtldrz_vvmvl
def vcvtldrz_vvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.l.d.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=vcvt.d.w intrisic=vcvtdw_vvl
def vcvtdw_vvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.d.w $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=vcvt.d.w intrisic=vcvtdw_vvvl
def vcvtdw_vvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=vcvt.s.w intrisic=vcvtsw_vvl
def vcvtsw_vvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.s.w $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=vcvt.s.w intrisic=vcvtsw_vvvl
def vcvtsw_vvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.s.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=pvcvt.s.w intrisic=pvcvtsw_vvl
def pvcvtsw_vvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvcvt.s.w $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLT asm=pvcvt.s.w intrisic=pvcvtsw_vvvl
def pvcvtsw_vvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.s.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLTX asm=vcvt.d.l intrisic=vcvtdl_vvl
def vcvtdl_vvl : RV<0xb8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.d.l $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFLTX asm=vcvt.d.l intrisic=vcvtdl_vvvl
def vcvtdl_vvvl : RV<0xb8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.l $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCVD asm=vcvt.d.s intrisic=vcvtds_vvl
def vcvtds_vvl : RV<0x8f, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.d.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCVD asm=vcvt.d.s intrisic=vcvtds_vvvl
def vcvtds_vvvl : RV<0x8f, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCVS asm=vcvt.s.d intrisic=vcvtsd_vvl
def vcvtsd_vvl : RV<0x9f, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.s.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCVS asm=vcvt.s.d intrisic=vcvtsd_vvvl
def vcvtsd_vvvl : RV<0x9f, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.s.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vvvml
def vmrg_vvvml : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, I32:$vl),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vvvmvl
def vmrg_vvvmvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvml
def vmrg_vsvml : RV<0xd6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, I32:$vl),
       "vmrg $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvmvl
def vmrg_vsvmvl : RV<0xd6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmrg $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvml
def vmrg_vIvml : RV<0xd6, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, I32:$vl),
       "vmrg $vx,$I,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg intrisic=vmrg_vsvmvl
def vmrg_vIvmvl : RV<0xd6, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmrg $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vvvMl
def vmrgw_vvvMl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, I32:$vl),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vvvMvl
def vmrgw_vvvMvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vsvMl
def vmrgw_vsvMl : RV<0xd6, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM512_:$vm, I32:$vl),
       "vmrg.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMRG asm=vmrg.w intrisic=vmrgw_vsvMvl
def vmrgw_vsvMvl : RV<0xd6, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "vmrg.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSHF asm=vshf intrisic=vshf_vvvsl
def vshf_vvvsl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy, I32:$vl),
       "vshf $vx,$vy,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSHF asm=vshf intrisic=vshf_vvvsvl
def vshf_vvvsvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vshf $vx,$vy,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSHF asm=vshf intrisic=vshf_vvvsl
def vshf_vvvIl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, simm7Op64:$N, I32:$vl),
       "vshf $vx,$vy,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSHF asm=vshf intrisic=vshf_vvvsvl
def vshf_vvvIvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vshf $vx,$vy,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VCP asm=vcp intrisic=vcp_vvmvl
def vcp_vvmvl : RV<0x8d, (outs V64:$vx), (ins V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcp $vx,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VEX asm=vex intrisic=vex_vvmvl
def vex_vvmvl : RV<0x9d, (outs V64:$vx), (ins V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vex $vx,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.at intrisic=vfmklat_ml
def vfmklat_ml : RV<0xb4, (outs VM_:$vmx), (ins I32:$vl),
       "vfmk.l.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.af intrisic=vfmklaf_ml
def vfmklaf_ml : RV<0xb4, (outs VM_:$vmx), (ins I32:$vl),
       "vfmk.l.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.w.lo.at intrisic=pvfmkwloat_ml
def pvfmkwloat_ml : RV<0xb5, (outs VM_:$vmx), (ins I32:$vl),
       "pvfmk.w.lo.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.w.up.at intrisic=pvfmkwupat_ml
def pvfmkwupat_ml : RV<0xb5, (outs VM_:$vmx), (ins I32:$vl),
       "pvfmk.w.up.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.w.lo.af intrisic=pvfmkwloaf_ml
def pvfmkwloaf_ml : RV<0xb5, (outs VM_:$vmx), (ins I32:$vl),
       "pvfmk.w.lo.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.w.up.af intrisic=pvfmkwupaf_ml
def pvfmkwupaf_ml : RV<0xb5, (outs VM_:$vmx), (ins I32:$vl),
       "pvfmk.w.up.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.at intrisic=pvfmkat_Ml
def pvfmkat_Ml : Pseudo<(outs VM512_:$vmx), (ins I32:$vl),
       "# pvfmk.at $vmx", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=pvfmk.af intrisic=pvfmkaf_Ml
def pvfmkaf_Ml : Pseudo<(outs VM512_:$vmx), (ins I32:$vl),
       "# pvfmk.af $vmx", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.gt intrisic=vfmklgt_mvl
def vfmklgt_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.gt intrisic=vfmklgt_mvml
def vfmklgt_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.lt intrisic=vfmkllt_mvl
def vfmkllt_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.lt intrisic=vfmkllt_mvml
def vfmkllt_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ne intrisic=vfmklne_mvl
def vfmklne_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ne intrisic=vfmklne_mvml
def vfmklne_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.eq intrisic=vfmkleq_mvl
def vfmkleq_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.eq intrisic=vfmkleq_mvml
def vfmkleq_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ge intrisic=vfmklge_mvl
def vfmklge_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ge intrisic=vfmklge_mvml
def vfmklge_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.le intrisic=vfmklle_mvl
def vfmklle_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.le intrisic=vfmklle_mvml
def vfmklle_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.num intrisic=vfmklnum_mvl
def vfmklnum_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.num intrisic=vfmklnum_mvml
def vfmklnum_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.nan intrisic=vfmklnan_mvl
def vfmklnan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.nan intrisic=vfmklnan_mvml
def vfmklnan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.gtnan intrisic=vfmklgtnan_mvl
def vfmklgtnan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.gtnan intrisic=vfmklgtnan_mvml
def vfmklgtnan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ltnan intrisic=vfmklltnan_mvl
def vfmklltnan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.ltnan intrisic=vfmklltnan_mvml
def vfmklltnan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.nenan intrisic=vfmklnenan_mvl
def vfmklnenan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.nenan intrisic=vfmklnenan_mvml
def vfmklnenan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.eqnan intrisic=vfmkleqnan_mvl
def vfmkleqnan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.eqnan intrisic=vfmkleqnan_mvml
def vfmkleqnan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.genan intrisic=vfmklgenan_mvl
def vfmklgenan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.genan intrisic=vfmklgenan_mvml
def vfmklgenan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.lenan intrisic=vfmkllenan_mvl
def vfmkllenan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMK asm=vfmk.l.lenan intrisic=vfmkllenan_mvml
def vfmkllenan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.gt intrisic=vfmkwgt_mvl
def vfmkwgt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.gt intrisic=vfmkwgt_mvml
def vfmkwgt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.lt intrisic=vfmkwlt_mvl
def vfmkwlt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.lt intrisic=vfmkwlt_mvml
def vfmkwlt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ne intrisic=vfmkwne_mvl
def vfmkwne_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ne intrisic=vfmkwne_mvml
def vfmkwne_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.eq intrisic=vfmkweq_mvl
def vfmkweq_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.eq intrisic=vfmkweq_mvml
def vfmkweq_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ge intrisic=vfmkwge_mvl
def vfmkwge_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ge intrisic=vfmkwge_mvml
def vfmkwge_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.le intrisic=vfmkwle_mvl
def vfmkwle_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.le intrisic=vfmkwle_mvml
def vfmkwle_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.num intrisic=vfmkwnum_mvl
def vfmkwnum_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.num intrisic=vfmkwnum_mvml
def vfmkwnum_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.nan intrisic=vfmkwnan_mvl
def vfmkwnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.nan intrisic=vfmkwnan_mvml
def vfmkwnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.gtnan intrisic=vfmkwgtnan_mvl
def vfmkwgtnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.gtnan intrisic=vfmkwgtnan_mvml
def vfmkwgtnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ltnan intrisic=vfmkwltnan_mvl
def vfmkwltnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.ltnan intrisic=vfmkwltnan_mvml
def vfmkwltnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.nenan intrisic=vfmkwnenan_mvl
def vfmkwnenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.nenan intrisic=vfmkwnenan_mvml
def vfmkwnenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.eqnan intrisic=vfmkweqnan_mvl
def vfmkweqnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.eqnan intrisic=vfmkweqnan_mvml
def vfmkweqnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.genan intrisic=vfmkwgenan_mvl
def vfmkwgenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.genan intrisic=vfmkwgenan_mvml
def vfmkwgenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.lenan intrisic=vfmkwlenan_mvl
def vfmkwlenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=vfmk.w.lenan intrisic=vfmkwlenan_mvml
def vfmkwlenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.gt intrisic=pvfmkwlogt_mvl
def pvfmkwlogt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.gt intrisic=pvfmkwupgt_mvl
def pvfmkwupgt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.gt intrisic=pvfmkwlogt_mvml
def pvfmkwlogt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.gt intrisic=pvfmkwupgt_mvml
def pvfmkwupgt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.lt intrisic=pvfmkwlolt_mvl
def pvfmkwlolt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.lt intrisic=pvfmkwuplt_mvl
def pvfmkwuplt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.lt intrisic=pvfmkwlolt_mvml
def pvfmkwlolt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.lt intrisic=pvfmkwuplt_mvml
def pvfmkwuplt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ne intrisic=pvfmkwlone_mvl
def pvfmkwlone_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ne intrisic=pvfmkwupne_mvl
def pvfmkwupne_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ne intrisic=pvfmkwlone_mvml
def pvfmkwlone_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ne intrisic=pvfmkwupne_mvml
def pvfmkwupne_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.eq intrisic=pvfmkwloeq_mvl
def pvfmkwloeq_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.eq intrisic=pvfmkwupeq_mvl
def pvfmkwupeq_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.eq intrisic=pvfmkwloeq_mvml
def pvfmkwloeq_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.eq intrisic=pvfmkwupeq_mvml
def pvfmkwupeq_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ge intrisic=pvfmkwloge_mvl
def pvfmkwloge_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ge intrisic=pvfmkwupge_mvl
def pvfmkwupge_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ge intrisic=pvfmkwloge_mvml
def pvfmkwloge_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ge intrisic=pvfmkwupge_mvml
def pvfmkwupge_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.le intrisic=pvfmkwlole_mvl
def pvfmkwlole_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.le intrisic=pvfmkwuple_mvl
def pvfmkwuple_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.le intrisic=pvfmkwlole_mvml
def pvfmkwlole_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.le intrisic=pvfmkwuple_mvml
def pvfmkwuple_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.num intrisic=pvfmkwlonum_mvl
def pvfmkwlonum_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.num intrisic=pvfmkwupnum_mvl
def pvfmkwupnum_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.num intrisic=pvfmkwlonum_mvml
def pvfmkwlonum_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.num intrisic=pvfmkwupnum_mvml
def pvfmkwupnum_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.nan intrisic=pvfmkwlonan_mvl
def pvfmkwlonan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.nan intrisic=pvfmkwupnan_mvl
def pvfmkwupnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.nan intrisic=pvfmkwlonan_mvml
def pvfmkwlonan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.nan intrisic=pvfmkwupnan_mvml
def pvfmkwupnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.gtnan intrisic=pvfmkwlogtnan_mvl
def pvfmkwlogtnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.gtnan intrisic=pvfmkwupgtnan_mvl
def pvfmkwupgtnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.gtnan intrisic=pvfmkwlogtnan_mvml
def pvfmkwlogtnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.gtnan intrisic=pvfmkwupgtnan_mvml
def pvfmkwupgtnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ltnan intrisic=pvfmkwloltnan_mvl
def pvfmkwloltnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ltnan intrisic=pvfmkwupltnan_mvl
def pvfmkwupltnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.ltnan intrisic=pvfmkwloltnan_mvml
def pvfmkwloltnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.ltnan intrisic=pvfmkwupltnan_mvml
def pvfmkwupltnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.nenan intrisic=pvfmkwlonenan_mvl
def pvfmkwlonenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.nenan intrisic=pvfmkwupnenan_mvl
def pvfmkwupnenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.nenan intrisic=pvfmkwlonenan_mvml
def pvfmkwlonenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.nenan intrisic=pvfmkwupnenan_mvml
def pvfmkwupnenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.eqnan intrisic=pvfmkwloeqnan_mvl
def pvfmkwloeqnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.eqnan intrisic=pvfmkwupeqnan_mvl
def pvfmkwupeqnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.eqnan intrisic=pvfmkwloeqnan_mvml
def pvfmkwloeqnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.eqnan intrisic=pvfmkwupeqnan_mvml
def pvfmkwupeqnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.genan intrisic=pvfmkwlogenan_mvl
def pvfmkwlogenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.genan intrisic=pvfmkwupgenan_mvl
def pvfmkwupgenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.genan intrisic=pvfmkwlogenan_mvml
def pvfmkwlogenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.genan intrisic=pvfmkwupgenan_mvml
def pvfmkwupgenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.lenan intrisic=pvfmkwlolenan_mvl
def pvfmkwlolenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.lenan intrisic=pvfmkwuplenan_mvl
def pvfmkwuplenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lo.lenan intrisic=pvfmkwlolenan_mvml
def pvfmkwlolenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.up.lenan intrisic=pvfmkwuplenan_mvml
def pvfmkwuplenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.gt intrisic=pvfmkwgt_Mvl
def pvfmkwgt_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.gt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.gt intrisic=pvfmkwgt_MvMl
def pvfmkwgt_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.gt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lt intrisic=pvfmkwlt_Mvl
def pvfmkwlt_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.lt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lt intrisic=pvfmkwlt_MvMl
def pvfmkwlt_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.lt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ne intrisic=pvfmkwne_Mvl
def pvfmkwne_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.ne $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ne intrisic=pvfmkwne_MvMl
def pvfmkwne_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.ne $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.eq intrisic=pvfmkweq_Mvl
def pvfmkweq_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.eq $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.eq intrisic=pvfmkweq_MvMl
def pvfmkweq_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.eq $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ge intrisic=pvfmkwge_Mvl
def pvfmkwge_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.ge $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ge intrisic=pvfmkwge_MvMl
def pvfmkwge_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.ge $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.le intrisic=pvfmkwle_Mvl
def pvfmkwle_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.le $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.le intrisic=pvfmkwle_MvMl
def pvfmkwle_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.le $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.num intrisic=pvfmkwnum_Mvl
def pvfmkwnum_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.num $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.num intrisic=pvfmkwnum_MvMl
def pvfmkwnum_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.num $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.nan intrisic=pvfmkwnan_Mvl
def pvfmkwnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.nan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.nan intrisic=pvfmkwnan_MvMl
def pvfmkwnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.nan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.gtnan intrisic=pvfmkwgtnan_Mvl
def pvfmkwgtnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.gtnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.gtnan intrisic=pvfmkwgtnan_MvMl
def pvfmkwgtnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.gtnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ltnan intrisic=pvfmkwltnan_Mvl
def pvfmkwltnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.ltnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.ltnan intrisic=pvfmkwltnan_MvMl
def pvfmkwltnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.ltnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.nenan intrisic=pvfmkwnenan_Mvl
def pvfmkwnenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.nenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.nenan intrisic=pvfmkwnenan_MvMl
def pvfmkwnenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.nenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.eqnan intrisic=pvfmkweqnan_Mvl
def pvfmkweqnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.eqnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.eqnan intrisic=pvfmkweqnan_MvMl
def pvfmkweqnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.eqnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.genan intrisic=pvfmkwgenan_Mvl
def pvfmkwgenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.genan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.genan intrisic=pvfmkwgenan_MvMl
def pvfmkwgenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.genan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lenan intrisic=pvfmkwlenan_Mvl
def pvfmkwlenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.lenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMS asm=pvfmk.w.lenan intrisic=pvfmkwlenan_MvMl
def pvfmkwlenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.lenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.gt intrisic=vfmkdgt_mvl
def vfmkdgt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.gt intrisic=vfmkdgt_mvml
def vfmkdgt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.lt intrisic=vfmkdlt_mvl
def vfmkdlt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.lt intrisic=vfmkdlt_mvml
def vfmkdlt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ne intrisic=vfmkdne_mvl
def vfmkdne_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ne intrisic=vfmkdne_mvml
def vfmkdne_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.eq intrisic=vfmkdeq_mvl
def vfmkdeq_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.eq intrisic=vfmkdeq_mvml
def vfmkdeq_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ge intrisic=vfmkdge_mvl
def vfmkdge_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ge intrisic=vfmkdge_mvml
def vfmkdge_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.le intrisic=vfmkdle_mvl
def vfmkdle_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.le intrisic=vfmkdle_mvml
def vfmkdle_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.num intrisic=vfmkdnum_mvl
def vfmkdnum_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.num intrisic=vfmkdnum_mvml
def vfmkdnum_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.nan intrisic=vfmkdnan_mvl
def vfmkdnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.nan intrisic=vfmkdnan_mvml
def vfmkdnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.gtnan intrisic=vfmkdgtnan_mvl
def vfmkdgtnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.gtnan intrisic=vfmkdgtnan_mvml
def vfmkdgtnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ltnan intrisic=vfmkdltnan_mvl
def vfmkdltnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.ltnan intrisic=vfmkdltnan_mvml
def vfmkdltnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.nenan intrisic=vfmkdnenan_mvl
def vfmkdnenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.nenan intrisic=vfmkdnenan_mvml
def vfmkdnenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.eqnan intrisic=vfmkdeqnan_mvl
def vfmkdeqnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.eqnan intrisic=vfmkdeqnan_mvml
def vfmkdeqnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.genan intrisic=vfmkdgenan_mvl
def vfmkdgenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.genan intrisic=vfmkdgenan_mvml
def vfmkdgenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.lenan intrisic=vfmkdlenan_mvl
def vfmkdlenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.d.lenan intrisic=vfmkdlenan_mvml
def vfmkdlenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.gt intrisic=vfmksgt_mvl
def vfmksgt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.gt intrisic=vfmksgt_mvml
def vfmksgt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.lt intrisic=vfmkslt_mvl
def vfmkslt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.lt intrisic=vfmkslt_mvml
def vfmkslt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ne intrisic=vfmksne_mvl
def vfmksne_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ne intrisic=vfmksne_mvml
def vfmksne_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.eq intrisic=vfmkseq_mvl
def vfmkseq_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.eq intrisic=vfmkseq_mvml
def vfmkseq_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ge intrisic=vfmksge_mvl
def vfmksge_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ge intrisic=vfmksge_mvml
def vfmksge_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.le intrisic=vfmksle_mvl
def vfmksle_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.le intrisic=vfmksle_mvml
def vfmksle_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.num intrisic=vfmksnum_mvl
def vfmksnum_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.num intrisic=vfmksnum_mvml
def vfmksnum_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.nan intrisic=vfmksnan_mvl
def vfmksnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.nan intrisic=vfmksnan_mvml
def vfmksnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.gtnan intrisic=vfmksgtnan_mvl
def vfmksgtnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.gtnan intrisic=vfmksgtnan_mvml
def vfmksgtnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ltnan intrisic=vfmksltnan_mvl
def vfmksltnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.ltnan intrisic=vfmksltnan_mvml
def vfmksltnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.nenan intrisic=vfmksnenan_mvl
def vfmksnenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.nenan intrisic=vfmksnenan_mvml
def vfmksnenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.eqnan intrisic=vfmkseqnan_mvl
def vfmkseqnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.eqnan intrisic=vfmkseqnan_mvml
def vfmkseqnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.genan intrisic=vfmksgenan_mvl
def vfmksgenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.genan intrisic=vfmksgenan_mvml
def vfmksgenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.lenan intrisic=vfmkslenan_mvl
def vfmkslenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=vfmk.s.lenan intrisic=vfmkslenan_mvml
def vfmkslenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.gt intrisic=pvfmkslogt_mvl
def pvfmkslogt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.gt intrisic=pvfmksupgt_mvl
def pvfmksupgt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.gt intrisic=pvfmkslogt_mvml
def pvfmkslogt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.gt intrisic=pvfmksupgt_mvml
def pvfmksupgt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.lt intrisic=pvfmkslolt_mvl
def pvfmkslolt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.lt intrisic=pvfmksuplt_mvl
def pvfmksuplt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.lt intrisic=pvfmkslolt_mvml
def pvfmkslolt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.lt intrisic=pvfmksuplt_mvml
def pvfmksuplt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ne intrisic=pvfmkslone_mvl
def pvfmkslone_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ne intrisic=pvfmksupne_mvl
def pvfmksupne_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ne intrisic=pvfmkslone_mvml
def pvfmkslone_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ne intrisic=pvfmksupne_mvml
def pvfmksupne_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.eq intrisic=pvfmksloeq_mvl
def pvfmksloeq_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.eq intrisic=pvfmksupeq_mvl
def pvfmksupeq_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.eq intrisic=pvfmksloeq_mvml
def pvfmksloeq_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.eq intrisic=pvfmksupeq_mvml
def pvfmksupeq_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ge intrisic=pvfmksloge_mvl
def pvfmksloge_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ge intrisic=pvfmksupge_mvl
def pvfmksupge_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ge intrisic=pvfmksloge_mvml
def pvfmksloge_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ge intrisic=pvfmksupge_mvml
def pvfmksupge_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.le intrisic=pvfmkslole_mvl
def pvfmkslole_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.le intrisic=pvfmksuple_mvl
def pvfmksuple_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.le intrisic=pvfmkslole_mvml
def pvfmkslole_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.le intrisic=pvfmksuple_mvml
def pvfmksuple_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.num intrisic=pvfmkslonum_mvl
def pvfmkslonum_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.num intrisic=pvfmksupnum_mvl
def pvfmksupnum_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.num intrisic=pvfmkslonum_mvml
def pvfmkslonum_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.num intrisic=pvfmksupnum_mvml
def pvfmksupnum_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.nan intrisic=pvfmkslonan_mvl
def pvfmkslonan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.nan intrisic=pvfmksupnan_mvl
def pvfmksupnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.nan intrisic=pvfmkslonan_mvml
def pvfmkslonan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.nan intrisic=pvfmksupnan_mvml
def pvfmksupnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.gtnan intrisic=pvfmkslogtnan_mvl
def pvfmkslogtnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.gtnan intrisic=pvfmksupgtnan_mvl
def pvfmksupgtnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.gtnan intrisic=pvfmkslogtnan_mvml
def pvfmkslogtnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.gtnan intrisic=pvfmksupgtnan_mvml
def pvfmksupgtnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ltnan intrisic=pvfmksloltnan_mvl
def pvfmksloltnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ltnan intrisic=pvfmksupltnan_mvl
def pvfmksupltnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.ltnan intrisic=pvfmksloltnan_mvml
def pvfmksloltnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.ltnan intrisic=pvfmksupltnan_mvml
def pvfmksupltnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.nenan intrisic=pvfmkslonenan_mvl
def pvfmkslonenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.nenan intrisic=pvfmksupnenan_mvl
def pvfmksupnenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.nenan intrisic=pvfmkslonenan_mvml
def pvfmkslonenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.nenan intrisic=pvfmksupnenan_mvml
def pvfmksupnenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.eqnan intrisic=pvfmksloeqnan_mvl
def pvfmksloeqnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.eqnan intrisic=pvfmksupeqnan_mvl
def pvfmksupeqnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.eqnan intrisic=pvfmksloeqnan_mvml
def pvfmksloeqnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.eqnan intrisic=pvfmksupeqnan_mvml
def pvfmksupeqnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.genan intrisic=pvfmkslogenan_mvl
def pvfmkslogenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.genan intrisic=pvfmksupgenan_mvl
def pvfmksupgenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.genan intrisic=pvfmkslogenan_mvml
def pvfmkslogenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.genan intrisic=pvfmksupgenan_mvml
def pvfmksupgenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.lenan intrisic=pvfmkslolenan_mvl
def pvfmkslolenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.lenan intrisic=pvfmksuplenan_mvl
def pvfmksuplenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lo.lenan intrisic=pvfmkslolenan_mvml
def pvfmkslolenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.up.lenan intrisic=pvfmksuplenan_mvml
def pvfmksuplenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.gt intrisic=pvfmksgt_Mvl
def pvfmksgt_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.gt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.gt intrisic=pvfmksgt_MvMl
def pvfmksgt_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.gt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lt intrisic=pvfmkslt_Mvl
def pvfmkslt_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.lt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lt intrisic=pvfmkslt_MvMl
def pvfmkslt_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.lt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ne intrisic=pvfmksne_Mvl
def pvfmksne_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.ne $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ne intrisic=pvfmksne_MvMl
def pvfmksne_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.ne $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.eq intrisic=pvfmkseq_Mvl
def pvfmkseq_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.eq $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.eq intrisic=pvfmkseq_MvMl
def pvfmkseq_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.eq $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ge intrisic=pvfmksge_Mvl
def pvfmksge_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.ge $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ge intrisic=pvfmksge_MvMl
def pvfmksge_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.ge $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.le intrisic=pvfmksle_Mvl
def pvfmksle_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.le $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.le intrisic=pvfmksle_MvMl
def pvfmksle_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.le $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.num intrisic=pvfmksnum_Mvl
def pvfmksnum_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.num $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.num intrisic=pvfmksnum_MvMl
def pvfmksnum_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.num $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.nan intrisic=pvfmksnan_Mvl
def pvfmksnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.nan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.nan intrisic=pvfmksnan_MvMl
def pvfmksnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.nan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.gtnan intrisic=pvfmksgtnan_Mvl
def pvfmksgtnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.gtnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.gtnan intrisic=pvfmksgtnan_MvMl
def pvfmksgtnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.gtnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ltnan intrisic=pvfmksltnan_Mvl
def pvfmksltnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.ltnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.ltnan intrisic=pvfmksltnan_MvMl
def pvfmksltnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.ltnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.nenan intrisic=pvfmksnenan_Mvl
def pvfmksnenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.nenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.nenan intrisic=pvfmksnenan_MvMl
def pvfmksnenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.nenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.eqnan intrisic=pvfmkseqnan_Mvl
def pvfmkseqnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.eqnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.eqnan intrisic=pvfmkseqnan_MvMl
def pvfmkseqnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.eqnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.genan intrisic=pvfmksgenan_Mvl
def pvfmksgenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.genan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.genan intrisic=pvfmksgenan_MvMl
def pvfmksgenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.genan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lenan intrisic=pvfmkslenan_Mvl
def pvfmkslenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.lenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMF asm=pvfmk.s.lenan intrisic=pvfmkslenan_MvMl
def pvfmkslenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.lenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMS asm=vsum.w.sx intrisic=vsumwsx_vvl
def vsumwsx_vvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vsum.w.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMS asm=vsum.w.sx intrisic=vsumwsx_vvml
def vsumwsx_vvml : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vsum.w.sx $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMS asm=vsum.w.zx intrisic=vsumwzx_vvl
def vsumwzx_vvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vsum.w.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMS asm=vsum.w.zx intrisic=vsumwzx_vvml
def vsumwzx_vvml : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vsum.w.zx $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMX asm=vsum.l intrisic=vsuml_vvl
def vsuml_vvl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vsum.l $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSUMX asm=vsum.l intrisic=vsuml_vvml
def vsuml_vvml : RV<0xaa, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vsum.l $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSUM asm=vfsum.d intrisic=vfsumd_vvl
def vfsumd_vvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsum.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSUM asm=vfsum.d intrisic=vfsumd_vvml
def vfsumd_vvml : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vfsum.d $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSUM asm=vfsum.s intrisic=vfsums_vvl
def vfsums_vvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsum.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFSUM asm=vfsum.s intrisic=vfsums_vvml
def vfsums_vvml : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vfsum.s $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.fst.sx intrisic=vrmaxswfstsx_vvl
def vrmaxswfstsx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.fst.sx intrisic=vrmaxswfstsx_vvvl
def vrmaxswfstsx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.lst.sx intrisic=vrmaxswlstsx_vvl
def vrmaxswlstsx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.lst.sx intrisic=vrmaxswlstsx_vvvl
def vrmaxswlstsx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.fst.zx intrisic=vrmaxswfstzx_vvl
def vrmaxswfstzx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.fst.zx intrisic=vrmaxswfstzx_vvvl
def vrmaxswfstzx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.lst.zx intrisic=vrmaxswlstzx_vvl
def vrmaxswlstzx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmaxs.w.lst.zx intrisic=vrmaxswlstzx_vvvl
def vrmaxswlstzx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.fst.sx intrisic=vrminswfstsx_vvl
def vrminswfstsx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.fst.sx intrisic=vrminswfstsx_vvvl
def vrminswfstsx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.lst.sx intrisic=vrminswlstsx_vvl
def vrminswlstsx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.lst.sx intrisic=vrminswlstsx_vvvl
def vrminswlstsx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.fst.zx intrisic=vrminswfstzx_vvl
def vrminswfstzx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.fst.zx intrisic=vrminswfstzx_vvvl
def vrminswfstzx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.lst.zx intrisic=vrminswlstzx_vvl
def vrminswlstzx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXS asm=vrmins.w.lst.zx intrisic=vrminswlstzx_vvvl
def vrminswlstzx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmaxs.l.fst intrisic=vrmaxslfst_vvl
def vrmaxslfst_vvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.l.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmaxs.l.fst intrisic=vrmaxslfst_vvvl
def vrmaxslfst_vvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmaxs.l.lst intrisic=vrmaxsllst_vvl
def vrmaxsllst_vvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.l.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmaxs.l.lst intrisic=vrmaxsllst_vvvl
def vrmaxsllst_vvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmins.l.fst intrisic=vrminslfst_vvl
def vrminslfst_vvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.l.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmins.l.fst intrisic=vrminslfst_vvvl
def vrminslfst_vvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmins.l.lst intrisic=vrminsllst_vvl
def vrminsllst_vvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.l.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VMAXX asm=vrmins.l.lst intrisic=vrminsllst_vvvl
def vrminsllst_vvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.d.fst intrisic=vfrmaxdfst_vvl
def vfrmaxdfst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.d.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.d.fst intrisic=vfrmaxdfst_vvvl
def vfrmaxdfst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.d.lst intrisic=vfrmaxdlst_vvl
def vfrmaxdlst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.d.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.d.lst intrisic=vfrmaxdlst_vvvl
def vfrmaxdlst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.s.fst intrisic=vfrmaxsfst_vvl
def vfrmaxsfst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.s.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.s.fst intrisic=vfrmaxsfst_vvvl
def vfrmaxsfst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.s.lst intrisic=vfrmaxslst_vvl
def vfrmaxslst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.s.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmax.s.lst intrisic=vfrmaxslst_vvvl
def vfrmaxslst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.d.fst intrisic=vfrmindfst_vvl
def vfrmindfst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.d.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.d.fst intrisic=vfrmindfst_vvvl
def vfrmindfst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.d.lst intrisic=vfrmindlst_vvl
def vfrmindlst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.d.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.d.lst intrisic=vfrmindlst_vvvl
def vfrmindlst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.s.fst intrisic=vfrminsfst_vvl
def vfrminsfst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.s.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.s.fst intrisic=vfrminsfst_vvvl
def vfrminsfst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.s.lst intrisic=vfrminslst_vvl
def vfrminslst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.s.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VFMAX asm=vfrmin.s.lst intrisic=vfrminslst_vvvl
def vfrminslst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRAND asm=vrand intrisic=vrand_vvl
def vrand_vvl : RV<0x88, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrand $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRAND asm=vrand intrisic=vrand_vvml
def vrand_vvml : RV<0x88, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vrand $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VROR asm=vror intrisic=vror_vvl
def vror_vvl : RV<0x98, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vror $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VROR asm=vror intrisic=vror_vvml
def vror_vvml : RV<0x98, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vror $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRXOR asm=vrxor intrisic=vrxor_vvl
def vrxor_vvl : RV<0x89, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrxor $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VRXOR asm=vrxor intrisic=vrxor_vvml
def vrxor_vvml : RV<0x89, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vrxor $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssl
def vgt_vvssl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgt $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssvl
def vgt_vvssvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssl
def vgt_vvsZl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgt $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssvl
def vgt_vvsZvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssl
def vgt_vvIsl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgt $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssvl
def vgt_vvIsvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssl
def vgt_vvIZl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgt $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssvl
def vgt_vvIZvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def vgt_vvssml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgt $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def vgt_vvssmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def vgt_vvsZml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgt $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def vgt_vvsZmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def vgt_vvIsml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgt $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def vgt_vvIsmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssml
def vgt_vvIZml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgt $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt intrisic=vgt_vvssmvl
def vgt_vvIZmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssl
def vgtnc_vvssl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssvl
def vgtnc_vvssvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssl
def vgtnc_vvsZl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssvl
def vgtnc_vvsZvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssl
def vgtnc_vvIsl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssvl
def vgtnc_vvIsvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssl
def vgtnc_vvIZl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssvl
def vgtnc_vvIZvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def vgtnc_vvssml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def vgtnc_vvssmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def vgtnc_vvsZml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def vgtnc_vvsZmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def vgtnc_vvIsml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def vgtnc_vvIsmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssml
def vgtnc_vvIZml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGT asm=vgt.nc intrisic=vgtnc_vvssmvl
def vgtnc_vvIZmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssl
def vgtu_vvssl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssvl
def vgtu_vvssvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssl
def vgtu_vvsZl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssvl
def vgtu_vvsZvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssl
def vgtu_vvIsl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssvl
def vgtu_vvIsvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssl
def vgtu_vvIZl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssvl
def vgtu_vvIZvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def vgtu_vvssml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def vgtu_vvssmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def vgtu_vvsZml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def vgtu_vvsZmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def vgtu_vvIsml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def vgtu_vvIsmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssml
def vgtu_vvIZml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu intrisic=vgtu_vvssmvl
def vgtu_vvIZmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssl
def vgtunc_vvssl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssvl
def vgtunc_vvssvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssl
def vgtunc_vvsZl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssvl
def vgtunc_vvsZvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssl
def vgtunc_vvIsl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssvl
def vgtunc_vvIsvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssl
def vgtunc_vvIZl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssvl
def vgtunc_vvIZvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def vgtunc_vvssml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def vgtunc_vvssmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def vgtunc_vvsZml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def vgtunc_vvsZmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def vgtunc_vvIsml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def vgtunc_vvIsmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssml
def vgtunc_vvIZml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTU asm=vgtu.nc intrisic=vgtunc_vvssmvl
def vgtunc_vvIZmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssl
def vgtlsx_vvssl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssvl
def vgtlsx_vvssvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssl
def vgtlsx_vvsZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssvl
def vgtlsx_vvsZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssl
def vgtlsx_vvIsl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssvl
def vgtlsx_vvIsvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssl
def vgtlsx_vvIZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssvl
def vgtlsx_vvIZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def vgtlsx_vvssml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def vgtlsx_vvssmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def vgtlsx_vvsZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def vgtlsx_vvsZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def vgtlsx_vvIsml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def vgtlsx_vvIsmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssml
def vgtlsx_vvIZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx intrisic=vgtlsx_vvssmvl
def vgtlsx_vvIZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssl
def vgtlsxnc_vvssl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssvl
def vgtlsxnc_vvssvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssl
def vgtlsxnc_vvsZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssvl
def vgtlsxnc_vvsZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssl
def vgtlsxnc_vvIsl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssvl
def vgtlsxnc_vvIsvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssl
def vgtlsxnc_vvIZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssvl
def vgtlsxnc_vvIZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def vgtlsxnc_vvssml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def vgtlsxnc_vvssmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def vgtlsxnc_vvsZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def vgtlsxnc_vvsZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def vgtlsxnc_vvIsml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def vgtlsxnc_vvIsmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssml
def vgtlsxnc_vvIZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.sx.nc intrisic=vgtlsxnc_vvssmvl
def vgtlsxnc_vvIZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssl
def vgtlzx_vvssl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssvl
def vgtlzx_vvssvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssl
def vgtlzx_vvsZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssvl
def vgtlzx_vvsZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssl
def vgtlzx_vvIsl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssvl
def vgtlzx_vvIsvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssl
def vgtlzx_vvIZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssvl
def vgtlzx_vvIZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def vgtlzx_vvssml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def vgtlzx_vvssmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def vgtlzx_vvsZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def vgtlzx_vvsZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def vgtlzx_vvIsml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def vgtlzx_vvIsmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssml
def vgtlzx_vvIZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx intrisic=vgtlzx_vvssmvl
def vgtlzx_vvIZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssl
def vgtlzxnc_vvssl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssvl
def vgtlzxnc_vvssvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssl
def vgtlzxnc_vvsZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssvl
def vgtlzxnc_vvsZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssl
def vgtlzxnc_vvIsl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssvl
def vgtlzxnc_vvIsvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssl
def vgtlzxnc_vvIZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssvl
def vgtlzxnc_vvIZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def vgtlzxnc_vvssml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def vgtlzxnc_vvssmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def vgtlzxnc_vvsZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def vgtlzxnc_vvsZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def vgtlzxnc_vvIsml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def vgtlzxnc_vvIsmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssml
def vgtlzxnc_vvIZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VGTL asm=vgtl.zx.nc intrisic=vgtlzxnc_vvssmvl
def vgtlzxnc_vvIZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def vsc_vvssl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def vsc_vvsZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vsc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def vsc_vvIsl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssl
def vsc_vvIZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vsc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def vsc_vvssml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vsc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def vsc_vvsZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def vsc_vvIsml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vsc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc intrisic=vsc_vvssml
def vsc_vvIZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def vscnc_vvssl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def vscnc_vvsZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def vscnc_vvIsl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsc.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssl
def vscnc_vvIZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vsc.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def vscnc_vvssml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def vscnc_vvsZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def vscnc_vvIsml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc intrisic=vscnc_vvssml
def vscnc_vvIZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def vscot_vvssl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def vscot_vvsZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def vscot_vvIsl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssl
def vscot_vvIZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vsc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def vscot_vvssml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def vscot_vvsZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def vscot_vvIsml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.ot intrisic=vscot_vvssml
def vscot_vvIZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def vscncot_vvssl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def vscncot_vvsZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def vscncot_vvIsl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssl
def vscncot_vvIZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def vscncot_vvssml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def vscncot_vvsZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def vscncot_vvIsml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSC asm=vsc.nc.ot intrisic=vscncot_vvssml
def vscncot_vvIZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def vscu_vvssl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def vscu_vvsZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def vscu_vvIsl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssl
def vscu_vvIZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def vscu_vvssml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def vscu_vvsZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def vscu_vvIsml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu intrisic=vscu_vvssml
def vscu_vvIZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def vscunc_vvssl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def vscunc_vvsZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def vscunc_vvIsl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssl
def vscunc_vvIZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def vscunc_vvssml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def vscunc_vvsZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def vscunc_vvIsml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc intrisic=vscunc_vvssml
def vscunc_vvIZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def vscuot_vvssl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def vscuot_vvsZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def vscuot_vvIsl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscu.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssl
def vscuot_vvIZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscu.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def vscuot_vvssml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def vscuot_vvsZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def vscuot_vvIsml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.ot intrisic=vscuot_vvssml
def vscuot_vvIZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def vscuncot_vvssl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def vscuncot_vvsZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def vscuncot_vvIsl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssl
def vscuncot_vvIZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def vscuncot_vvssml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def vscuncot_vvsZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def vscuncot_vvIsml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCU asm=vscu.nc.ot intrisic=vscuncot_vvssml
def vscuncot_vvIZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def vscl_vvssl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def vscl_vvsZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscl $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def vscl_vvIsl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscl $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssl
def vscl_vvIZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscl $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def vscl_vvssml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscl $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def vscl_vvsZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def vscl_vvIsml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscl $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl intrisic=vscl_vvssml
def vscl_vvIZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def vsclnc_vvssl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def vsclnc_vvsZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def vsclnc_vvIsl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscl.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssl
def vsclnc_vvIZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscl.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def vsclnc_vvssml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def vsclnc_vvsZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def vsclnc_vvIsml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc intrisic=vsclnc_vvssml
def vsclnc_vvIZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def vsclot_vvssl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def vsclot_vvsZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def vsclot_vvIsl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscl.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssl
def vsclot_vvIZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscl.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def vsclot_vvssml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def vsclot_vvsZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def vsclot_vvIsml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.ot intrisic=vsclot_vvssml
def vsclot_vvIZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def vsclncot_vvssl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def vsclncot_vvsZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def vsclncot_vvIsl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssl
def vsclncot_vvIZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def vsclncot_vvssml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def vsclncot_vvsZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def vsclncot_vvIsml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=VSCL asm=vscl.nc.ot intrisic=vsclncot_vvssml
def vsclncot_vvIZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=ANDM asm=andm intrisic=andm_mmm
def andm_mmm : RV<0x84, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "andm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=ANDM asm=andm intrisic=andm_MMM
def andm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# andm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=ORM asm=orm intrisic=orm_mmm
def orm_mmm : RV<0x85, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "orm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=ORM asm=orm intrisic=orm_MMM
def orm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# orm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=XORM asm=xorm intrisic=xorm_mmm
def xorm_mmm : RV<0x86, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "xorm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=XORM asm=xorm intrisic=xorm_MMM
def xorm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# xorm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=EQVM asm=eqvm intrisic=eqvm_mmm
def eqvm_mmm : RV<0x87, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "eqvm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=EQVM asm=eqvm intrisic=eqvm_MMM
def eqvm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# eqvm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=NNDM asm=nndm intrisic=nndm_mmm
def nndm_mmm : RV<0x94, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "nndm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=NNDM asm=nndm intrisic=nndm_MMM
def nndm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# nndm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=NEGM asm=negm intrisic=negm_mm
def negm_mm : RV<0x95, (outs VM_:$vmx), (ins VM_:$vmy),
       "negm $vmx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=NEGM asm=negm intrisic=negm_MM
def negm_MM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy),
       "# negm $vmx,$vmy", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// inst=PCVM asm=pcvm intrisic=pcvm_sml
def pcvm_sml : RV<0xa4, (outs I64:$sx), (ins VM_:$vmy, I32:$vl),
       "pcvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=LZVM asm=lzvm intrisic=lzvm_sml
def lzvm_sml : RV<0xa5, (outs I64:$sx), (ins VM_:$vmy, I32:$vl),
       "lzvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// inst=TOVM asm=tovm intrisic=tovm_sml
def tovm_sml : RV<0xa6, (outs I64:$sx), (ins VM_:$vmy, I32:$vl),
       "tovm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

