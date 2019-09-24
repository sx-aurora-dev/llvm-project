// VLD vld vld_vssl
def vld_vssl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD vld vld_vssvl
def vld_vssvl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD vld vld_vIsl
def vld_vIsl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vld $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD vld vld_vIsvl
def vld_vIsvl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD vld.nc vldnc_vssl
def vldnc_vssl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD vld.nc vldnc_vssvl
def vldnc_vssvl : RV<0x81, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD vld.nc vldnc_vIsl
def vldnc_vIsl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vld.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD vld.nc vldnc_vIsvl
def vldnc_vIsvl : RV<0x81, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu vldu_vssl
def vldu_vssl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu vldu_vssvl
def vldu_vssvl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu vldu_vIsl
def vldu_vIsl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu vldu_vIsvl
def vldu_vIsvl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu.nc vldunc_vssl
def vldunc_vssl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu.nc vldunc_vssvl
def vldunc_vssvl : RV<0x82, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu.nc vldunc_vIsl
def vldunc_vIsl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldu.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU vldu.nc vldunc_vIsvl
def vldunc_vIsvl : RV<0x82, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx vldlsx_vssl
def vldlsx_vssl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.sx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx vldlsx_vssvl
def vldlsx_vssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx vldlsx_vIsl
def vldlsx_vIsl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl.sx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx vldlsx_vIsvl
def vldlsx_vIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx.nc vldlsxnc_vssl
def vldlsxnc_vssl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx.nc vldlsxnc_vssvl
def vldlsxnc_vssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx.nc vldlsxnc_vIsl
def vldlsxnc_vIsl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.sx.nc vldlsxnc_vIsvl
def vldlsxnc_vIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx vldlzx_vssl
def vldlzx_vssl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.zx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx vldlzx_vssvl
def vldlzx_vssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx vldlzx_vIsl
def vldlzx_vIsl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl.zx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx vldlzx_vIsvl
def vldlzx_vIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx.nc vldlzxnc_vssl
def vldlzxnc_vssl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx.nc vldlzxnc_vssvl
def vldlzxnc_vssvl : RV<0x83, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx.nc vldlzxnc_vIsl
def vldlzxnc_vIsl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL vldl.zx.nc vldlzxnc_vIsvl
def vldlzxnc_vIsvl : RV<0x83, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d vld2d_vssl
def vld2d_vssl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d vld2d_vssvl
def vld2d_vssvl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld2d $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d vld2d_vIsl
def vld2d_vIsl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vld2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d vld2d_vIsvl
def vld2d_vIsvl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld2d $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d.nc vld2dnc_vssl
def vld2dnc_vssl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vld2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d.nc vld2dnc_vssvl
def vld2dnc_vssvl : RV<0xc1, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vld2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d.nc vld2dnc_vIsl
def vld2dnc_vIsl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vld2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLD2D vld2d.nc vld2dnc_vIsvl
def vld2dnc_vIsvl : RV<0xc1, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vld2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d vldu2d_vssl
def vldu2d_vssl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d vldu2d_vssvl
def vldu2d_vssvl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d vldu2d_vIsl
def vldu2d_vIsl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d vldu2d_vIsvl
def vldu2d_vIsvl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d.nc vldu2dnc_vssl
def vldu2dnc_vssl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d.nc vldu2dnc_vssvl
def vldu2dnc_vssvl : RV<0xc2, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d.nc vldu2dnc_vIsl
def vldu2dnc_vIsl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDU2D vldu2d.nc vldu2dnc_vIsvl
def vldu2dnc_vIsvl : RV<0xc2, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx vldl2dsx_vssl
def vldl2dsx_vssl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.sx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx vldl2dsx_vssvl
def vldl2dsx_vssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx vldl2dsx_vIsl
def vldl2dsx_vIsl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl2d.sx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx vldl2dsx_vIsvl
def vldl2dsx_vIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx.nc vldl2dsxnc_vssl
def vldl2dsxnc_vssl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx.nc vldl2dsxnc_vssvl
def vldl2dsxnc_vssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx.nc vldl2dsxnc_vIsl
def vldl2dsxnc_vIsl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl2d.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.sx.nc vldl2dsxnc_vIsvl
def vldl2dsxnc_vIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.sx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx vldl2dzx_vssl
def vldl2dzx_vssl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.zx $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx vldl2dzx_vssvl
def vldl2dzx_vssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx vldl2dzx_vIsl
def vldl2dzx_vIsl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl2d.zx $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx vldl2dzx_vIsvl
def vldl2dzx_vIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx.nc vldl2dzxnc_vssl
def vldl2dzxnc_vssl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, I32:$vl),
       "vldl2d.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx.nc vldl2dzxnc_vssvl
def vldl2dzxnc_vssvl : RV<0xc3, (outs V64:$vx), (ins I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx.nc $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx.nc vldl2dzxnc_vIsl
def vldl2dzxnc_vIsl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "vldl2d.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VLDL2D vldl2d.zx.nc vldl2dzxnc_vIsvl
def vldl2dzxnc_vIsvl : RV<0xc3, (outs V64:$vx), (ins simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vldl2d.zx.nc $vx,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst vst_vssl
def vst_vssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst vst_vIsl
def vst_vIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst vst_vssml
def vst_vssml : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst vst_vIsml
def vst_vIsml : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.nc vstnc_vssl
def vstnc_vssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.nc vstnc_vIsl
def vstnc_vIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.nc vstnc_vssml
def vstnc_vssml : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.nc vstnc_vIsml
def vstnc_vIsml : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.ot vstot_vssl
def vstot_vssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.ot vstot_vIsl
def vstot_vIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.ot vstot_vssml
def vstot_vssml : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.ot vstot_vIsml
def vstot_vIsml : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.nc.ot vstncot_vssl
def vstncot_vssl : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.nc.ot vstncot_vIsl
def vstncot_vIsl : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.nc.ot vstncot_vssml
def vstncot_vssml : RV<0x91, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST vst.nc.ot vstncot_vIsml
def vstncot_vIsml : RV<0x91, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu vstu_vssl
def vstu_vssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu vstu_vIsl
def vstu_vIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu vstu_vssml
def vstu_vssml : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu vstu_vIsml
def vstu_vIsml : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.nc vstunc_vssl
def vstunc_vssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.nc vstunc_vIsl
def vstunc_vIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.nc vstunc_vssml
def vstunc_vssml : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.nc vstunc_vIsml
def vstunc_vIsml : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.ot vstuot_vssl
def vstuot_vssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.ot vstuot_vIsl
def vstuot_vIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.ot vstuot_vssml
def vstuot_vssml : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.ot vstuot_vIsml
def vstuot_vIsml : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.nc.ot vstuncot_vssl
def vstuncot_vssl : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.nc.ot vstuncot_vIsl
def vstuncot_vIsl : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.nc.ot vstuncot_vssml
def vstuncot_vssml : RV<0x92, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU vstu.nc.ot vstuncot_vIsml
def vstuncot_vIsml : RV<0x92, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl vstl_vssl
def vstl_vssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl vstl_vIsl
def vstl_vIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl vstl_vssml
def vstl_vssml : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl vstl_vIsml
def vstl_vIsml : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.nc vstlnc_vssl
def vstlnc_vssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.nc vstlnc_vIsl
def vstlnc_vIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.nc vstlnc_vssml
def vstlnc_vssml : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.nc vstlnc_vIsml
def vstlnc_vIsml : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.ot vstlot_vssl
def vstlot_vssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.ot vstlot_vIsl
def vstlot_vIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.ot vstlot_vssml
def vstlot_vssml : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.ot vstlot_vIsml
def vstlot_vIsml : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.nc.ot vstlncot_vssl
def vstlncot_vssl : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.nc.ot vstlncot_vIsl
def vstlncot_vIsl : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.nc.ot vstlncot_vssml
def vstlncot_vssml : RV<0x93, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL vstl.nc.ot vstlncot_vIsml
def vstlncot_vIsml : RV<0x93, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d vst2d_vssl
def vst2d_vssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d vst2d_vIsl
def vst2d_vIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d vst2d_vssml
def vst2d_vssml : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d vst2d_vIsml
def vst2d_vIsml : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.nc vst2dnc_vssl
def vst2dnc_vssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.nc vst2dnc_vIsl
def vst2dnc_vIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.nc vst2dnc_vssml
def vst2dnc_vssml : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.nc vst2dnc_vIsml
def vst2dnc_vIsml : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.ot vst2dot_vssl
def vst2dot_vssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.ot vst2dot_vIsl
def vst2dot_vIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.ot vst2dot_vssml
def vst2dot_vssml : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.ot vst2dot_vIsml
def vst2dot_vIsml : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.nc.ot vst2dncot_vssl
def vst2dncot_vssl : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vst2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.nc.ot vst2dncot_vIsl
def vst2dncot_vIsl : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vst2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.nc.ot vst2dncot_vssml
def vst2dncot_vssml : RV<0xd1, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VST2D vst2d.nc.ot vst2dncot_vIsml
def vst2dncot_vIsml : RV<0xd1, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vst2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d vstu2d_vssl
def vstu2d_vssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d vstu2d_vIsl
def vstu2d_vIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d vstu2d_vssml
def vstu2d_vssml : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d vstu2d_vIsml
def vstu2d_vIsml : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.nc vstu2dnc_vssl
def vstu2dnc_vssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.nc vstu2dnc_vIsl
def vstu2dnc_vIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.nc vstu2dnc_vssml
def vstu2dnc_vssml : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.nc vstu2dnc_vIsml
def vstu2dnc_vIsml : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.ot vstu2dot_vssl
def vstu2dot_vssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.ot vstu2dot_vIsl
def vstu2dot_vIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.ot vstu2dot_vssml
def vstu2dot_vssml : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.ot vstu2dot_vIsml
def vstu2dot_vIsml : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.nc.ot vstu2dncot_vssl
def vstu2dncot_vssl : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstu2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.nc.ot vstu2dncot_vIsl
def vstu2dncot_vIsl : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstu2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.nc.ot vstu2dncot_vssml
def vstu2dncot_vssml : RV<0xd2, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTU2D vstu2d.nc.ot vstu2dncot_vIsml
def vstu2dncot_vIsml : RV<0xd2, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstu2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d vstl2d_vssl
def vstl2d_vssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d vstl2d_vIsl
def vstl2d_vIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d vstl2d_vssml
def vstl2d_vssml : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d vstl2d_vIsml
def vstl2d_vIsml : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.nc vstl2dnc_vssl
def vstl2dnc_vssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.nc $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.nc vstl2dnc_vIsl
def vstl2dnc_vIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d.nc $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.nc vstl2dnc_vssml
def vstl2dnc_vssml : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.nc $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.nc vstl2dnc_vIsml
def vstl2dnc_vIsml : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.nc $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.ot vstl2dot_vssl
def vstl2dot_vssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.ot vstl2dot_vIsl
def vstl2dot_vIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.ot vstl2dot_vssml
def vstl2dot_vssml : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.ot vstl2dot_vIsml
def vstl2dot_vIsml : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.nc.ot vstl2dncot_vssl
def vstl2dncot_vssl : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, I32:$vl),
       "vstl2d.nc.ot $vx,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.nc.ot vstl2dncot_vIsl
def vstl2dncot_vIsl : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, I32:$vl),
       "vstl2d.nc.ot $vx,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.nc.ot vstl2dncot_vssml
def vstl2dncot_vssml : RV<0xd3, (outs ), (ins V64:$vx, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.nc.ot $vx,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSTL2D vstl2d.nc.ot vstl2dncot_vIsml
def vstl2dncot_vIsml : RV<0xd3, (outs ), (ins V64:$vx, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vstl2d.nc.ot $vx,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// PFCHV pfchv pfchv_ssl
def pfchv_ssl : RV<0x80, (outs ), (ins I64:$sy, I64:$sz, I32:$vl),
       "pfchv $sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// PFCHV pfchv pfchv_Isl
def pfchv_Isl : RV<0x80, (outs ), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "pfchv $I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// PFCHV pfchv.nc pfchvnc_ssl
def pfchvnc_ssl : RV<0x80, (outs ), (ins I64:$sy, I64:$sz, I32:$vl),
       "pfchv.nc $sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// PFCHV pfchv.nc pfchvnc_Isl
def pfchvnc_Isl : RV<0x80, (outs ), (ins simm7Op64:$I, I64:$sz, I32:$vl),
       "pfchv.nc $I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// LSV lsv lsv_vvss
def lsv_vvss : RV<0x8e, (outs V64:$vx), (ins V64:$vd, I32:$sy, I64:$sz),
       "lsv $vx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVM lvm lvm_mmss
def lvm_mmss : RV<0xb7, (outs VM_:$vmx), (ins VM_:$vmd, I64:$sy, I64:$sz),
       "lvm $vmx,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVM lvm lvm_mmIs
def lvm_mmIs : RV<0xb7, (outs VM_:$vmx), (ins VM_:$vmd, simm7Op64:$N, I64:$sz),
       "lvm $vmx,$N,$sz", [], NoItinerary>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVM lvm lvm_MMss
def lvm_MMss : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmd, I64:$sy, I64:$sz),
       "# lvm $vmx,$sy,$sz", []>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// LVM lvm lvm_MMIs
def lvm_MMIs : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmd, simm7Op64:$N, I64:$sz),
       "# lvm $vmx,$N,$sz", []>
{
  let Constraints = "$vmx = $vmd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// SVM svm svm_sms
def svm_sms : RV<0xa7, (outs I64:$sx), (ins VM_:$vmz, I64:$sy),
       "svm $sx,$vmz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// SVM svm svm_smI
def svm_smI : RV<0xa7, (outs I64:$sx), (ins VM_:$vmz, simm7Op64:$N),
       "svm $sx,$vmz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// SVM svm svm_sMs
def svm_sMs : Pseudo<(outs I64:$sx), (ins VM512_:$vmz, I64:$sy),
       "# svm $sx,$vmz,$sy", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// SVM svm svm_sMI
def svm_sMI : Pseudo<(outs I64:$sx), (ins VM512_:$vmz, simm7Op64:$N),
       "# svm $sx,$vmz,$N", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// VBRD vbrd vbrdl_vsl
def vbrd_vsl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, I32:$vl),
       "vbrd $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrd vbrdl_vsvl
def vbrd_vsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, I32:$vl),
       "vbrd $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrd vbrdl_vsmvl
def vbrd_vsmvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vbrd $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrd vbrdl_vIl
def vbrd_vIl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, I32:$vl),
       "vbrd $vx,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrd vbrdl_vIvl
def vbrd_vIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, V64:$vd, I32:$vl),
       "vbrd $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrd vbrdl_vImvl
def vbrd_vImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op64:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vbrd $vx,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdu vbrds_vsl
def vbrdu_vsl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, I32:$vl),
       "vbrdu $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdu vbrds_vsvl
def vbrdu_vsvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, V64:$vd, I32:$vl),
       "vbrdu $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdu vbrds_vsmvl
def vbrdu_vsmvl : RV<0x8c, (outs V64:$vx), (ins F32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vbrdu $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vsl
def vbrdl_vsl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, I32:$vl),
       "vbrdl $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vsvl
def vbrdl_vsvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, V64:$vd, I32:$vl),
       "vbrdl $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vsmvl
def vbrdl_vsmvl : RV<0x8c, (outs V64:$vx), (ins I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vbrdl $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vIl
def vbrdl_vIl : RV<0x8c, (outs V64:$vx), (ins simm7Op32:$I, I32:$vl),
       "vbrdl $vx,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vIvl
def vbrdl_vIvl : RV<0x8c, (outs V64:$vx), (ins simm7Op32:$I, V64:$vd, I32:$vl),
       "vbrdl $vx,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD vbrdl vbrdw_vImvl
def vbrdl_vImvl : RV<0x8c, (outs V64:$vx), (ins simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vbrdl $vx,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD pvbrd pvbrd_vsl
def pvbrd_vsl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, I32:$vl),
       "pvbrd $vx,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD pvbrd pvbrd_vsvl
def pvbrd_vsvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, V64:$vd, I32:$vl),
       "pvbrd $vx,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VBRD pvbrd pvbrd_vsMvl
def pvbrd_vsMvl : RV<0x8c, (outs V64:$vx), (ins I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvbrd $vx,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMV vmv vmv_vsvl
def vmv_vsvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmv $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMV vmv vmv_vsvvl
def vmv_vsvvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMV vmv vmv_vIvl
def vmv_vIvl : RV<0x9c, (outs V64:$vx), (ins simm7Op32:$N, V64:$vz, I32:$vl),
       "vmv $vx,$N,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMV vmv vmv_vIvvl
def vmv_vIvvl : RV<0x9c, (outs V64:$vx), (ins simm7Op32:$N, V64:$vz, V64:$vd, I32:$vl),
       "vmv $vx,$N,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMV vmv vmv_vsvmvl
def vmv_vsvmvl : RV<0x9c, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMV vmv vmv_vIvmvl
def vmv_vIvmvl : RV<0x9c, (outs V64:$vx), (ins simm7Op32:$N, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmv $vx,$N,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vvvl
def vaddul_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vaddu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vvvvl
def vaddul_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vsvl
def vaddul_vsvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vaddu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vsvvl
def vaddul_vsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vIvl
def vaddul_vIvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vaddu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vIvvl
def vaddul_vIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vvvmvl
def vaddul_vvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vsvmvl
def vaddul_vsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.l vaddul_vIvmvl
def vaddul_vIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vvvl
def vadduw_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vaddu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vvvvl
def vadduw_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vsvl
def vadduw_vsvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vaddu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vsvvl
def vadduw_vsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vIvl
def vadduw_vIvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vaddu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vIvvl
def vadduw_vIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vaddu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vvvmvl
def vadduw_vvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vsvmvl
def vadduw_vsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD vaddu.w vadduw_vIvmvl
def vadduw_vIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vaddu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vvvl
def pvaddu_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvaddu $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vvvvl
def pvaddu_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvaddu $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vsvl
def pvaddu_vsvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvaddu $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vsvvl
def pvaddu_vsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvaddu $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vvvMvl
def pvaddu_vvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvaddu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADD pvaddu pvaddu_vsvMvl
def pvaddu_vsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvaddu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vvvl
def vaddswsx_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vvvvl
def vaddswsx_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vsvl
def vaddswsx_vsvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vsvvl
def vaddswsx_vsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vIvl
def vaddswsx_vIvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vadds.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vIvvl
def vaddswsx_vIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vvvmvl
def vaddswsx_vvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vsvmvl
def vaddswsx_vsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.sx vaddswsx_vIvmvl
def vaddswsx_vIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vvvl
def vaddswzx_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vvvvl
def vaddswzx_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vsvl
def vaddswzx_vsvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vsvvl
def vaddswzx_vsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vIvl
def vaddswzx_vIvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vadds.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vIvvl
def vaddswzx_vIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vvvmvl
def vaddswzx_vvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vsvmvl
def vaddswzx_vsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS vadds.w.zx vaddswzx_vIvmvl
def vaddswzx_vIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vvvl
def pvadds_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvadds $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vvvvl
def pvadds_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvadds $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vsvl
def pvadds_vsvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvadds $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vsvvl
def pvadds_vsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvadds $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vvvMvl
def pvadds_vvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvadds $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADS pvadds pvadds_vsvMvl
def pvadds_vsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvadds $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vvvl
def vaddsl_vvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vadds.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vvvvl
def vaddsl_vvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vsvl
def vaddsl_vsvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vadds.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vsvvl
def vaddsl_vsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vIvl
def vaddsl_vIvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vadds.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vIvvl
def vaddsl_vIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vadds.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vvvmvl
def vaddsl_vvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vsvmvl
def vaddsl_vsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VADX vadds.l vaddsl_vIvmvl
def vaddsl_vIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vadds.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vvvl
def vsubul_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vvvvl
def vsubul_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vsvl
def vsubul_vsvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vsubu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vsvvl
def vsubul_vsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vIvl
def vsubul_vIvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vsubu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vIvvl
def vsubul_vIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vvvmvl
def vsubul_vvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vsvmvl
def vsubul_vsvmvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.l vsubul_vIvmvl
def vsubul_vIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vvvl
def vsubuw_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vvvvl
def vsubuw_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vsvl
def vsubuw_vsvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vsubu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vsvvl
def vsubuw_vsvvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vIvl
def vsubuw_vIvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vsubu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vIvvl
def vsubuw_vIvvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vvvmvl
def vsubuw_vvvmvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vsvmvl
def vsubuw_vsvmvl : RV<0xc8, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB vsubu.w vsubuw_vIvmvl
def vsubuw_vIvmvl : RV<0xc8, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vvvl
def pvsubu_vvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvsubu $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vvvvl
def pvsubu_vvvvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubu $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vsvl
def pvsubu_vsvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvsubu $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vsvvl
def pvsubu_vsvvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubu $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vvvMvl
def pvsubu_vvvMvl : RV<0xc8, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUB pvsubu pvsubu_vsvMvl
def pvsubu_vsvMvl : RV<0xc8, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vvvl
def vsubswsx_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vvvvl
def vsubswsx_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vsvl
def vsubswsx_vsvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vsvvl
def vsubswsx_vsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vIvl
def vsubswsx_vIvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vIvvl
def vsubswsx_vIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vvvmvl
def vsubswsx_vvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vsvmvl
def vsubswsx_vsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.sx vsubswsx_vIvmvl
def vsubswsx_vIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vvvl
def vsubswzx_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vvvvl
def vsubswzx_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vsvl
def vsubswzx_vsvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vsvvl
def vsubswzx_vsvvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vIvl
def vsubswzx_vIvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vIvvl
def vsubswzx_vIvvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vvvmvl
def vsubswzx_vvvmvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vsvmvl
def vsubswzx_vsvmvl : RV<0xca, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS vsubs.w.zx vsubswzx_vIvmvl
def vsubswzx_vIvmvl : RV<0xca, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vvvl
def pvsubs_vvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvsubs $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vvvvl
def pvsubs_vvvvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubs $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vsvl
def pvsubs_vsvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvsubs $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vsvvl
def pvsubs_vsvvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvsubs $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vvvMvl
def pvsubs_vvvMvl : RV<0xca, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBS pvsubs pvsubs_vsvMvl
def pvsubs_vsvMvl : RV<0xca, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsubs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vvvl
def vsubsl_vvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vsubs.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vvvvl
def vsubsl_vvvvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vsvl
def vsubsl_vsvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vsubs.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vsvvl
def vsubsl_vsvvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vIvl
def vsubsl_vIvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vsubs.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vIvvl
def vsubsl_vIvvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vsubs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vvvmvl
def vsubsl_vvvmvl : RV<0x8b, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vsvmvl
def vsubsl_vsvmvl : RV<0x8b, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSBX vsubs.l vsubsl_vIvmvl
def vsubsl_vIvmvl : RV<0x8b, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vsubs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vvvl
def vmulul_vvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmulu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vvvvl
def vmulul_vvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vsvl
def vmulul_vsvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmulu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vsvvl
def vmulul_vsvvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vIvl
def vmulul_vIvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vmulu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vIvvl
def vmulul_vIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vvvmvl
def vmulul_vvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vsvmvl
def vmulul_vsvmvl : RV<0xc9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.l vmulul_vIvmvl
def vmulul_vIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vvvl
def vmuluw_vvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmulu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vvvvl
def vmuluw_vvvvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vsvl
def vmuluw_vsvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmulu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vsvvl
def vmuluw_vsvvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vIvl
def vmuluw_vIvl : RV<0xc9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmulu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vIvvl
def vmuluw_vIvvl : RV<0xc9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmulu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vvvmvl
def vmuluw_vvvmvl : RV<0xc9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vsvmvl
def vmuluw_vsvmvl : RV<0xc9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPY vmulu.w vmuluw_vIvmvl
def vmuluw_vIvmvl : RV<0xc9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmulu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vvvl
def vmulswsx_vvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vvvvl
def vmulswsx_vvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vsvl
def vmulswsx_vsvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vsvvl
def vmulswsx_vsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vIvl
def vmulswsx_vIvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vIvvl
def vmulswsx_vIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vvvmvl
def vmulswsx_vvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vsvmvl
def vmulswsx_vsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.sx vmulswsx_vIvmvl
def vmulswsx_vIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vvvl
def vmulswzx_vvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vvvvl
def vmulswzx_vvvvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vsvl
def vmulswzx_vsvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vsvvl
def vmulswzx_vsvvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vIvl
def vmulswzx_vIvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vIvvl
def vmulswzx_vIvvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vvvmvl
def vmulswzx_vvvmvl : RV<0xcb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vsvmvl
def vmulswzx_vsvmvl : RV<0xcb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPS vmuls.w.zx vmulswzx_vIvmvl
def vmulswzx_vIvmvl : RV<0xcb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vvvl
def vmulsl_vvvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vvvvl
def vmulsl_vvvvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vsvl
def vmulsl_vsvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmuls.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vsvvl
def vmulsl_vsvvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vIvl
def vmulsl_vIvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vmuls.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vIvvl
def vmulsl_vIvvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vvvmvl
def vmulsl_vvvmvl : RV<0xdb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vsvmvl
def vmulsl_vsvmvl : RV<0xdb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPX vmuls.l vmulsl_vIvmvl
def vmulsl_vIvmvl : RV<0xdb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmuls.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w vmulslw_vvvl
def vmulslw_vvvl : RV<0xd9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmuls.l.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w vmulslw_vvvvl
def vmulslw_vvvvl : RV<0xd9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w vmulslw_vsvl
def vmulslw_vsvl : RV<0xd9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmuls.l.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w vmulslw_vsvvl
def vmulslw_vsvvl : RV<0xd9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w vmulslw_vIvl
def vmulslw_vIvl : RV<0xd9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmuls.l.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMPD vmuls.l.w vmulslw_vIvvl
def vmulslw_vIvvl : RV<0xd9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmuls.l.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvvl
def vdivul_vvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvvvl
def vdivul_vvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vsvl
def vdivul_vsvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vdivu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vsvvl
def vdivul_vsvvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vIvl
def vdivul_vIvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vdivu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vIvvl
def vdivul_vIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvvmvl
def vdivul_vvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vsvmvl
def vdivul_vsvmvl : RV<0xe9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vIvmvl
def vdivul_vIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvvl
def vdivuw_vvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvvvl
def vdivuw_vvvvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vsvl
def vdivuw_vsvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vdivu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vsvvl
def vdivuw_vsvvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vIvl
def vdivuw_vIvl : RV<0xe9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vdivu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vIvvl
def vdivuw_vIvvl : RV<0xe9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvvmvl
def vdivuw_vvvmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vsvmvl
def vdivuw_vsvmvl : RV<0xe9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vIvmvl
def vdivuw_vIvmvl : RV<0xe9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvsl
def vdivul_vvsl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, I32:$vl),
       "vdivu.l $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvsvl
def vdivul_vvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvIl
def vdivul_vvIl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I32:$vl),
       "vdivu.l $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvIvl
def vdivul_vvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvsmvl
def vdivul_vvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.l vdivul_vvImvl
def vdivul_vvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvsl
def vdivuw_vvsl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl),
       "vdivu.w $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvsvl
def vdivuw_vvsvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvIl
def vdivuw_vvIl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, I32:$vl),
       "vdivu.w $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvIvl
def vdivuw_vvIvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvsmvl
def vdivuw_vvsmvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDIV vdivu.w vdivuw_vvImvl
def vdivuw_vvImvl : RV<0xe9, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivu.w $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvvl
def vdivswsx_vvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvvvl
def vdivswsx_vvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vsvl
def vdivswsx_vsvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vsvvl
def vdivswsx_vsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vIvl
def vdivswsx_vIvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vIvvl
def vdivswsx_vIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvvmvl
def vdivswsx_vvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vsvmvl
def vdivswsx_vsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vIvmvl
def vdivswsx_vIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvvl
def vdivswzx_vvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvvvl
def vdivswzx_vvvvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vsvl
def vdivswzx_vsvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vsvvl
def vdivswzx_vsvvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vIvl
def vdivswzx_vIvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vIvvl
def vdivswzx_vIvvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvvmvl
def vdivswzx_vvvmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vsvmvl
def vdivswzx_vsvmvl : RV<0xeb, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vIvmvl
def vdivswzx_vIvmvl : RV<0xeb, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvsl
def vdivswsx_vvsl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvsvl
def vdivswsx_vvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvIl
def vdivswsx_vvIl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvIvl
def vdivswsx_vvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvsmvl
def vdivswsx_vvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.sx vdivswsx_vvImvl
def vdivswsx_vvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.sx $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvsl
def vdivswzx_vvsl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvsvl
def vdivswzx_vvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvIl
def vdivswzx_vvIl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvIvl
def vdivswzx_vvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvsmvl
def vdivswzx_vvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I32:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVS vdivs.w.zx vdivswzx_vvImvl
def vdivswzx_vvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op32:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.w.zx $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvvl
def vdivsl_vvvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vdivs.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvvvl
def vdivsl_vvvvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vsvl
def vdivsl_vsvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vdivs.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vsvvl
def vdivsl_vsvvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vIvl
def vdivsl_vIvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vdivs.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vIvvl
def vdivsl_vIvvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vdivs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvvmvl
def vdivsl_vvvmvl : RV<0xfb, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vsvmvl
def vdivsl_vsvmvl : RV<0xfb, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vIvmvl
def vdivsl_vIvmvl : RV<0xfb, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvsl
def vdivsl_vvsl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, I32:$vl),
       "vdivs.l $vx,$vy,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvsvl
def vdivsl_vvsvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvIl
def vdivsl_vvIl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I32:$vl),
       "vdivs.l $vx,$vy,$I", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvIvl
def vdivsl_vvIvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$I", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvsmvl
def vdivsl_vvsmvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VDVX vdivs.l vdivsl_vvImvl
def vdivsl_vvImvl : RV<0xeb, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, VM_:$vm, V64:$vd, I32:$vl),
       "vdivs.l $vx,$vy,$I,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vvvl
def vcmpul_vvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmpu.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vvvvl
def vcmpul_vvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vsvl
def vcmpul_vsvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vcmpu.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vsvvl
def vcmpul_vsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vIvl
def vcmpul_vIvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vcmpu.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vIvvl
def vcmpul_vIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vvvmvl
def vcmpul_vvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vsvmvl
def vcmpul_vsvmvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.l vcmpul_vIvmvl
def vcmpul_vIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vvvl
def vcmpuw_vvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmpu.w $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vvvvl
def vcmpuw_vvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vsvl
def vcmpuw_vsvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vcmpu.w $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vsvvl
def vcmpuw_vsvvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vIvl
def vcmpuw_vIvl : RV<0xb9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vcmpu.w $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vIvvl
def vcmpuw_vIvvl : RV<0xb9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vvvmvl
def vcmpuw_vvvmvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vsvmvl
def vcmpuw_vsvmvl : RV<0xb9, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP vcmpu.w vcmpuw_vIvmvl
def vcmpuw_vIvmvl : RV<0xb9, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmpu.w $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vvvl
def pvcmpu_vvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvcmpu $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vvvvl
def pvcmpu_vvvvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmpu $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vsvl
def pvcmpu_vsvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvcmpu $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vsvvl
def pvcmpu_vsvvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmpu $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vvvMvl
def pvcmpu_vvvMvl : RV<0xb9, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmpu $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMP pvcmpu pvcmpu_vsvMvl
def pvcmpu_vsvMvl : RV<0xb9, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmpu $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vvvl
def vcmpswsx_vvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vvvvl
def vcmpswsx_vvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vsvl
def vcmpswsx_vsvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vsvvl
def vcmpswsx_vsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vIvl
def vcmpswsx_vIvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vIvvl
def vcmpswsx_vIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vvvmvl
def vcmpswsx_vvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vsvmvl
def vcmpswsx_vsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.sx vcmpswsx_vIvmvl
def vcmpswsx_vIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vvvl
def vcmpswzx_vvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vvvvl
def vcmpswzx_vvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vsvl
def vcmpswzx_vsvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vsvvl
def vcmpswzx_vsvvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vIvl
def vcmpswzx_vIvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vIvvl
def vcmpswzx_vIvvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vvvmvl
def vcmpswzx_vvvmvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vsvmvl
def vcmpswzx_vsvmvl : RV<0xfa, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS vcmps.w.zx vcmpswzx_vIvmvl
def vcmpswzx_vIvmvl : RV<0xfa, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vvvl
def pvcmps_vvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvcmps $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vvvvl
def pvcmps_vvvvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmps $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vsvl
def pvcmps_vsvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvcmps $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vsvvl
def pvcmps_vsvvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvcmps $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vvvMvl
def pvcmps_vvvMvl : RV<0xfa, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmps $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPS pvcmps pvcmps_vsvMvl
def pvcmps_vsvMvl : RV<0xfa, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcmps $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vvvl
def vcmpsl_vvvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vcmps.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vvvvl
def vcmpsl_vvvvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vsvl
def vcmpsl_vsvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vcmps.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vsvvl
def vcmpsl_vsvvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vIvl
def vcmpsl_vIvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vcmps.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vIvvl
def vcmpsl_vIvvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vcmps.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vvvmvl
def vcmpsl_vvvmvl : RV<0xba, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vsvmvl
def vcmpsl_vsvmvl : RV<0xba, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCPX vcmps.l vcmpsl_vIvmvl
def vcmpsl_vIvmvl : RV<0xba, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcmps.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vvvl
def vmaxswsx_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vvvvl
def vmaxswsx_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vsvl
def vmaxswsx_vsvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vsvvl
def vmaxswsx_vsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vIvl
def vmaxswsx_vIvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vIvvl
def vmaxswsx_vIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vvvmvl
def vmaxswsx_vvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vsvmvl
def vmaxswsx_vsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.sx vmaxswsx_vIvmvl
def vmaxswsx_vIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vvvl
def vmaxswzx_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vvvvl
def vmaxswzx_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vsvl
def vmaxswzx_vsvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vsvvl
def vmaxswzx_vsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vIvl
def vmaxswzx_vIvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vIvvl
def vmaxswzx_vIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vvvmvl
def vmaxswzx_vvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vsvmvl
def vmaxswzx_vsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmaxs.w.zx vmaxswzx_vIvmvl
def vmaxswzx_vIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vvvl
def pvmaxs_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvmaxs $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vvvvl
def pvmaxs_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvmaxs $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vsvl
def pvmaxs_vsvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvmaxs $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vsvvl
def pvmaxs_vsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvmaxs $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vvvMvl
def pvmaxs_vvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmaxs $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmaxs pvmaxs_vsvMvl
def pvmaxs_vsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmaxs $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vvvl
def vminswsx_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vvvvl
def vminswsx_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vsvl
def vminswsx_vsvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vsvvl
def vminswsx_vsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vIvl
def vminswsx_vIvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmins.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vIvvl
def vminswsx_vIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vvvmvl
def vminswsx_vvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vsvmvl
def vminswsx_vsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.sx vminswsx_vIvmvl
def vminswsx_vIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.sx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vvvl
def vminswzx_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vvvvl
def vminswzx_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vsvl
def vminswzx_vsvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vsvvl
def vminswzx_vsvvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vIvl
def vminswzx_vIvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, I32:$vl),
       "vmins.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vIvvl
def vminswzx_vIvvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vvvmvl
def vminswzx_vvvmvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vsvmvl
def vminswzx_vsvmvl : RV<0x8a, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS vmins.w.zx vminswzx_vIvmvl
def vminswzx_vIvmvl : RV<0x8a, (outs V64:$vx), (ins simm7Op32:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.w.zx $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vvvl
def pvmins_vvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvmins $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vvvvl
def pvmins_vvvvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvmins $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vsvl
def pvmins_vsvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvmins $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vsvvl
def pvmins_vsvvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvmins $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vvvMvl
def pvmins_vvvMvl : RV<0x8a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmins $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMS pvmins pvmins_vsvMvl
def pvmins_vsvMvl : RV<0x8a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvmins $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vvvl
def vmaxsl_vvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmaxs.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vvvvl
def vmaxsl_vvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vsvl
def vmaxsl_vsvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmaxs.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vsvvl
def vmaxsl_vsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vIvl
def vmaxsl_vIvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vmaxs.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vIvvl
def vmaxsl_vIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vvvmvl
def vmaxsl_vvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vsvmvl
def vmaxsl_vsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmaxs.l vmaxsl_vIvmvl
def vmaxsl_vIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmaxs.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vvvl
def vminsl_vvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vmins.l $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vvvvl
def vminsl_vvvvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vsvl
def vminsl_vsvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vmins.l $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vsvvl
def vminsl_vsvvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vIvl
def vminsl_vIvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, I32:$vl),
       "vmins.l $vx,$I,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vIvvl
def vminsl_vIvvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, V64:$vd, I32:$vl),
       "vmins.l $vx,$I,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vvvmvl
def vminsl_vvvmvl : RV<0x9a, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vsvmvl
def vminsl_vsvmvl : RV<0x9a, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCMX vmins.l vminsl_vIvmvl
def vminsl_vIvmvl : RV<0x9a, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmins.l $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vvvl
def vand_vvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vand $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vvvvl
def vand_vvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vand $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vsvl
def vand_vsvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vand $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vsvvl
def vand_vsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vand $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vvvmvl
def vand_vvvmvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND vand vand_vsvmvl
def vand_vsvmvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vvvl
def pvand_vvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvand $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vvvvl
def pvand_vvvvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvand $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vsvl
def pvand_vsvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvand $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vsvvl
def pvand_vsvvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvand $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vvvMvl
def pvand_vvvMvl : RV<0xc4, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvand $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VAND pvand pvand_vsvMvl
def pvand_vsvMvl : RV<0xc4, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvand $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vvvl
def vor_vvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vvvvl
def vor_vvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vsvl
def vor_vsvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vsvvl
def vor_vsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vvvmvl
def vor_vvvmvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR vor vor_vsvmvl
def vor_vsvmvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vvvl
def pvor_vvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vvvvl
def pvor_vvvvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vsvl
def pvor_vsvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vsvvl
def pvor_vsvvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vvvMvl
def pvor_vvvMvl : RV<0xc5, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VOR pvor pvor_vsvMvl
def pvor_vsvMvl : RV<0xc5, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vvvl
def vxor_vvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vxor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vvvvl
def vxor_vvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vxor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vsvl
def vxor_vsvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vxor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vsvvl
def vxor_vsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vxor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vvvmvl
def vxor_vvvmvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR vxor vxor_vsvmvl
def vxor_vsvmvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vvvl
def pvxor_vvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvxor $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vvvvl
def pvxor_vvvvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvxor $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vsvl
def pvxor_vsvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvxor $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vsvvl
def pvxor_vsvvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvxor $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vvvMvl
def pvxor_vvvMvl : RV<0xc6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvxor $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VXOR pvxor pvxor_vsvMvl
def pvxor_vsvMvl : RV<0xc6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvxor $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vvvl
def veqv_vvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "veqv $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vvvvl
def veqv_vvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "veqv $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vsvl
def veqv_vsvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "veqv $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vsvvl
def veqv_vsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "veqv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vvvmvl
def veqv_vvvmvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "veqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV veqv veqv_vsvmvl
def veqv_vsvmvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "veqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vvvl
def pveqv_vvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pveqv $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vvvvl
def pveqv_vvvvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pveqv $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vsvl
def pveqv_vsvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pveqv $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vsvvl
def pveqv_vsvvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pveqv $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vvvMvl
def pveqv_vvvMvl : RV<0xc7, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pveqv $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEQV pveqv pveqv_vsvMvl
def pveqv_vsvMvl : RV<0xc7, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pveqv $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ vseq vseq_vl
def vseq_vl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "vseq $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ vseq vseq_vvl
def vseq_vvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "vseq $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ pvseq.lo pvseqlo_vl
def pvseqlo_vl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "pvseq.lo $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ pvseq.lo pvseqlo_vvl
def pvseqlo_vvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq.lo $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ pvseq.up pvsequp_vl
def pvsequp_vl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "pvseq.up $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ pvseq.up pvsequp_vvl
def pvsequp_vvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq.up $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ pvseq pvseq_vl
def pvseq_vl : RV<0x99, (outs V64:$vx), (ins I32:$vl),
       "pvseq $vx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSEQ pvseq pvseq_vvl
def pvseq_vvl : RV<0x99, (outs V64:$vx), (ins V64:$vd, I32:$vl),
       "pvseq $vx", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvvl
def vsll_vvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsll $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvvvl
def vsll_vvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvsl
def vsll_vvsl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsll $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvsvl
def vsll_vvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvIl
def vsll_vvIl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsll $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvIvl
def vsll_vvIvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvvmvl
def vsll_vvvmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvsmvl
def vsll_vvsmvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL vsll vsll_vvImvl
def vsll_vvImvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsll $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvvl
def pvsll_vvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsll $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvvvl
def pvsll_vvvvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvsl
def pvsll_vvsl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsll $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvsvl
def pvsll_vvsvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvvMvl
def pvsll_vvvMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLL pvsll pvsll_vvsMvl
def pvsll_vvsMvl : RV<0xe5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsll $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvvl
def vsrl_vvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsrl $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvvvl
def vsrl_vvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvsl
def vsrl_vvsl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsrl $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvsvl
def vsrl_vvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvIl
def vsrl_vvIl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsrl $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvIvl
def vsrl_vvIvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvvmvl
def vsrl_vvvmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvsmvl
def vsrl_vvsmvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL vsrl vsrl_vvImvl
def vsrl_vvImvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsrl $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvvl
def pvsrl_vvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsrl $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvvvl
def pvsrl_vvvvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvsl
def pvsrl_vvsl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsrl $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvsvl
def pvsrl_vvsvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvvMvl
def pvsrl_vvvMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRL pvsrl pvsrl_vvsMvl
def pvsrl_vvsMvl : RV<0xf5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsrl $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvvl
def vslaw_vvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsla.w $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvvvl
def vslaw_vvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvsl
def vslaw_vvsl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsla.w $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvsvl
def vslaw_vvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvIl
def vslaw_vvIl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsla.w $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvIvl
def vslaw_vvIvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvvmvl
def vslaw_vvvmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvsmvl
def vslaw_vvsmvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA vsla.w vslaw_vvImvl
def vslaw_vvImvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvvl
def pvsla_vvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsla $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvvvl
def pvsla_vvvvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvsl
def pvsla_vvsl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsla $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvsvl
def pvsla_vvsvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvvMvl
def pvsla_vvvMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLA pvsla pvsla_vvsMvl
def pvsla_vvsMvl : RV<0xe6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsla $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvvl
def vslal_vvvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsla.l $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvvvl
def vslal_vvvvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvsl
def vslal_vvsl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsla.l $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvsvl
def vslal_vvsvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvIl
def vslal_vvIl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsla.l $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvIvl
def vslal_vvIvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvvmvl
def vslal_vvvmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvsmvl
def vslal_vvsmvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSLAX vsla.l vslal_vvImvl
def vslal_vvImvl : RV<0xd4, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsla.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvvl
def vsraw_vvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsra.w $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvvvl
def vsraw_vvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvsl
def vsraw_vvsl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsra.w $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvsvl
def vsraw_vvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvIl
def vsraw_vvIl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsra.w $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvIvl
def vsraw_vvIvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvvmvl
def vsraw_vvvmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvsmvl
def vsraw_vvsmvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA vsra.w vsraw_vvImvl
def vsraw_vvImvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.w $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvvl
def pvsra_vvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "pvsra $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvvvl
def pvsra_vvvvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvsl
def pvsra_vvsl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "pvsra $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvsvl
def pvsra_vvsvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvvMvl
def pvsra_vvvMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRA pvsra pvsra_vvsMvl
def pvsra_vvsMvl : RV<0xf6, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvsra $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvvl
def vsral_vvvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, I32:$vl),
       "vsra.l $vx,$vz,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvvvl
def vsral_vvvvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvsl
def vsral_vvsl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, I32:$vl),
       "vsra.l $vx,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvsvl
def vsral_vvsvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvIl
def vsral_vvIl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, I32:$vl),
       "vsra.l $vx,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvIvl
def vsral_vvIvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvvmvl
def vsral_vvvmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvsmvl
def vsral_vvsmvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, I64:$sy, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$sy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSRAX vsra.l vsral_vvImvl
def vsral_vvImvl : RV<0xd5, (outs V64:$vx), (ins V64:$vz, simm7Op64:$N, VM_:$vm, V64:$vd, I32:$vl),
       "vsra.l $vx,$vz,$N,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvssl
def vsfa_vvssl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvssvl
def vsfa_vvssvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvIsl
def vsfa_vvIsl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsfa $vx,$vz,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvIsvl
def vsfa_vvIsvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvssmvl
def vsfa_vvssmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSFA vsfa vsfa_vvIsmvl
def vsfa_vvIsmvl : RV<0xd7, (outs V64:$vx), (ins V64:$vz, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vsfa $vx,$vz,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vvvl
def vfaddd_vvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfadd.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vvvvl
def vfaddd_vvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vsvl
def vfaddd_vsvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfadd.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vsvvl
def vfaddd_vsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vvvmvl
def vfaddd_vvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.d vfaddd_vsvmvl
def vfaddd_vsvmvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vvvl
def vfadds_vvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfadd.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vvvvl
def vfadds_vvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vsvl
def vfadds_vsvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfadd.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vsvvl
def vfadds_vsvvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfadd.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vvvmvl
def vfadds_vvvmvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD vfadd.s vfadds_vsvmvl
def vfadds_vsvmvl : RV<0xcc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfadd.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vvvl
def pvfadd_vvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfadd $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vvvvl
def pvfadd_vvvvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfadd $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vsvl
def pvfadd_vsvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfadd $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vsvvl
def pvfadd_vsvvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfadd $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vvvMvl
def pvfadd_vvvMvl : RV<0xcc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfadd $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFAD pvfadd pvfadd_vsvMvl
def pvfadd_vsvMvl : RV<0xcc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfadd $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vvvl
def vfsubd_vvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfsub.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vvvvl
def vfsubd_vvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vsvl
def vfsubd_vsvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfsub.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vsvvl
def vfsubd_vsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vvvmvl
def vfsubd_vvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.d vfsubd_vsvmvl
def vfsubd_vsvmvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vvvl
def vfsubs_vvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfsub.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vvvvl
def vfsubs_vvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vsvl
def vfsubs_vsvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfsub.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vsvvl
def vfsubs_vsvvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfsub.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vvvmvl
def vfsubs_vvvmvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB vfsub.s vfsubs_vsvmvl
def vfsubs_vsvmvl : RV<0xdc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfsub.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vvvl
def pvfsub_vvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfsub $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vvvvl
def pvfsub_vvvvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfsub $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vsvl
def pvfsub_vsvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfsub $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vsvvl
def pvfsub_vsvvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfsub $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vvvMvl
def pvfsub_vvvMvl : RV<0xdc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfsub $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSB pvfsub pvfsub_vsvMvl
def pvfsub_vsvMvl : RV<0xdc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfsub $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vvvl
def vfmuld_vvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmul.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vvvvl
def vfmuld_vvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vsvl
def vfmuld_vsvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfmul.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vsvvl
def vfmuld_vsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vvvmvl
def vfmuld_vvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.d vfmuld_vsvmvl
def vfmuld_vsvmvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vvvl
def vfmuls_vvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmul.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vvvvl
def vfmuls_vvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vsvl
def vfmuls_vsvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfmul.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vsvvl
def vfmuls_vsvvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmul.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vvvmvl
def vfmuls_vvvmvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP vfmul.s vfmuls_vsvmvl
def vfmuls_vsvmvl : RV<0xcd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmul.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vvvl
def pvfmul_vvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfmul $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vvvvl
def pvfmul_vvvvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmul $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vsvl
def pvfmul_vsvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfmul $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vsvvl
def pvfmul_vsvvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmul $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vvvMvl
def pvfmul_vvvMvl : RV<0xcd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmul $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMP pvfmul pvfmul_vsvMvl
def pvfmul_vsvMvl : RV<0xcd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmul $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vvvl
def vfdivd_vvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfdiv.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vvvvl
def vfdivd_vvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vsvl
def vfdivd_vsvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfdiv.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vsvvl
def vfdivd_vsvvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vvvmvl
def vfdivd_vvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.d vfdivd_vsvmvl
def vfdivd_vsvmvl : RV<0xdd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vvvl
def vfdivs_vvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfdiv.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vvvvl
def vfdivs_vvvvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vsvl
def vfdivs_vsvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfdiv.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vsvvl
def vfdivs_vsvvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vvvmvl
def vfdivs_vvvmvl : RV<0xdd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFDV vfdiv.s vfdivs_vsvmvl
def vfdivs_vsvmvl : RV<0xdd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfdiv.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSQRT vfsqrt.d vfsqrtd_vvl
def vfsqrtd_vvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsqrt.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSQRT vfsqrt.d vfsqrtd_vvvl
def vfsqrtd_vvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSQRT vfsqrt.s vfsqrts_vvl
def vfsqrts_vvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsqrt.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSQRT vfsqrt.s vfsqrts_vvvl
def vfsqrts_vvvl : RV<0xed, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vvvl
def vfcmpd_vvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfcmp.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vvvvl
def vfcmpd_vvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vsvl
def vfcmpd_vsvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfcmp.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vsvvl
def vfcmpd_vsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vvvmvl
def vfcmpd_vvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.d vfcmpd_vsvmvl
def vfcmpd_vsvmvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vvvl
def vfcmps_vvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfcmp.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vvvvl
def vfcmps_vvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vsvl
def vfcmps_vsvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfcmp.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vsvvl
def vfcmps_vsvvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vvvmvl
def vfcmps_vvvmvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP vfcmp.s vfcmps_vsvmvl
def vfcmps_vsvmvl : RV<0xfc, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfcmp.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vvvl
def pvfcmp_vvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfcmp $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vvvvl
def pvfcmp_vvvvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfcmp $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vsvl
def pvfcmp_vsvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfcmp $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vsvvl
def pvfcmp_vsvvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfcmp $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vvvMvl
def pvfcmp_vvvMvl : RV<0xfc, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfcmp $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCP pvfcmp pvfcmp_vsvMvl
def pvfcmp_vsvMvl : RV<0xfc, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfcmp $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vvvl
def vfmaxd_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmax.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vvvvl
def vfmaxd_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vsvl
def vfmaxd_vsvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfmax.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vsvvl
def vfmaxd_vsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vvvmvl
def vfmaxd_vvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.d vfmaxd_vsvmvl
def vfmaxd_vsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vvvl
def vfmaxs_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmax.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vvvvl
def vfmaxs_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vsvl
def vfmaxs_vsvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfmax.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vsvvl
def vfmaxs_vsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmax.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vvvmvl
def vfmaxs_vvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmax.s vfmaxs_vsvmvl
def vfmaxs_vsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmax.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vvvl
def pvfmax_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfmax $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vvvvl
def pvfmax_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmax $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vsvl
def pvfmax_vsvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfmax $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vsvvl
def pvfmax_vsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmax $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vvvMvl
def pvfmax_vvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmax $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmax pvfmax_vsvMvl
def pvfmax_vsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmax $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vvvl
def vfmind_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmin.d $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vvvvl
def vfmind_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.d $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vsvl
def vfmind_vsvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "vfmin.d $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vsvvl
def vfmind_vsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.d $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vvvmvl
def vfmind_vvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.d $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.d vfmind_vsvmvl
def vfmind_vsvmvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.d $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vvvl
def vfmins_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "vfmin.s $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vvvvl
def vfmins_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.s $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vsvl
def vfmins_vsvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, I32:$vl),
       "vfmin.s $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vsvvl
def vfmins_vsvvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vd, I32:$vl),
       "vfmin.s $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vvvmvl
def vfmins_vvvmvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.s $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM vfmin.s vfmins_vsvmvl
def vfmins_vsvmvl : RV<0xbd, (outs V64:$vx), (ins F32:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vfmin.s $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vvvl
def pvfmin_vvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, I32:$vl),
       "pvfmin $vx,$vy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vvvvl
def pvfmin_vvvvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmin $vx,$vy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vsvl
def pvfmin_vsvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, I32:$vl),
       "pvfmin $vx,$sy,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vsvvl
def pvfmin_vsvvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vd, I32:$vl),
       "pvfmin $vx,$sy,$vz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vvvMvl
def pvfmin_vvvMvl : RV<0xbd, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmin $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFCM pvfmin pvfmin_vsvMvl
def pvfmin_vsvMvl : RV<0xbd, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmin $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvvvl
def vfmadd_vvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvvvvl
def vfmadd_vvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vsvvl
def vfmadd_vsvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vsvvvl
def vfmadd_vsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvsvl
def vfmadd_vvsvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvsvvl
def vfmadd_vvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvvvmvl
def vfmadd_vvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vsvvmvl
def vfmadd_vsvvmvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.d vfmadd_vvsvmvl
def vfmadd_vvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvvvl
def vfmads_vvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvvvvl
def vfmads_vvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vsvvl
def vfmads_vsvvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vsvvvl
def vfmads_vsvvvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvsvl
def vfmads_vvsvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvsvvl
def vfmads_vvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvvvmvl
def vfmads_vvvvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vsvvmvl
def vfmads_vsvvmvl : RV<0xe2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD vfmad.s vfmads_vvsvmvl
def vfmads_vvsvmvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvvvl
def pvfmad_vvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvvvvl
def pvfmad_vvvvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vsvvl
def pvfmad_vsvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vsvvvl
def pvfmad_vsvvvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvsvl
def pvfmad_vvsvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvsvvl
def pvfmad_vvsvvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvvvMvl
def pvfmad_vvvvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vsvvMvl
def pvfmad_vsvvMvl : RV<0xe2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAD pvfmad pvfmad_vvsvMvl
def pvfmad_vvsvMvl : RV<0xe2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvvvl
def vfmsbd_vvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvvvvl
def vfmsbd_vvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vsvvl
def vfmsbd_vsvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vsvvvl
def vfmsbd_vsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvsvl
def vfmsbd_vvsvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvsvvl
def vfmsbd_vvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvvvmvl
def vfmsbd_vvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vsvvmvl
def vfmsbd_vsvvmvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.d vfmsbd_vvsvmvl
def vfmsbd_vvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvvvl
def vfmsbs_vvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvvvvl
def vfmsbs_vvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vsvvl
def vfmsbs_vsvvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vsvvvl
def vfmsbs_vsvvvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvsvl
def vfmsbs_vvsvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvsvvl
def vfmsbs_vvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvvvmvl
def vfmsbs_vvvvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vsvvmvl
def vfmsbs_vsvvmvl : RV<0xf2, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB vfmsb.s vfmsbs_vvsvmvl
def vfmsbs_vvsvmvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvvvl
def pvfmsb_vvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvvvvl
def pvfmsb_vvvvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vsvvl
def pvfmsb_vsvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vsvvvl
def pvfmsb_vsvvvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvsvl
def pvfmsb_vvsvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvsvvl
def pvfmsb_vvsvvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvvvMvl
def pvfmsb_vvvvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vsvvMvl
def pvfmsb_vsvvMvl : RV<0xf2, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMSB pvfmsb pvfmsb_vvsvMvl
def pvfmsb_vvsvMvl : RV<0xf2, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvvvl
def vfnmadd_vvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvvvvl
def vfnmadd_vvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vsvvl
def vfnmadd_vsvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vsvvvl
def vfnmadd_vsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvsvl
def vfnmadd_vvsvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvsvvl
def vfnmadd_vvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvvvmvl
def vfnmadd_vvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vsvvmvl
def vfnmadd_vsvvmvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.d vfnmadd_vvsvmvl
def vfnmadd_vvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvvvl
def vfnmads_vvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvvvvl
def vfnmads_vvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vsvvl
def vfnmads_vsvvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vsvvvl
def vfnmads_vsvvvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvsvl
def vfnmads_vvsvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvsvvl
def vfnmads_vvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvvvmvl
def vfnmads_vvvvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vsvvmvl
def vfnmads_vsvvmvl : RV<0xe3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD vfnmad.s vfnmads_vvsvmvl
def vfnmads_vvsvmvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmad.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvvvl
def pvfnmad_vvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvvvvl
def pvfnmad_vvvvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vsvvl
def pvfnmad_vsvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vsvvvl
def pvfnmad_vsvvvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvsvl
def pvfnmad_vvsvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvsvvl
def pvfnmad_vvsvvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvvvMvl
def pvfnmad_vvvvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vsvvMvl
def pvfnmad_vsvvMvl : RV<0xe3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmad $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMAD pvfnmad pvfnmad_vvsvMvl
def pvfnmad_vvsvMvl : RV<0xe3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmad $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvvvl
def vfnmsbd_vvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvvvvl
def vfnmsbd_vvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vsvvl
def vfnmsbd_vsvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vsvvvl
def vfnmsbd_vsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvsvl
def vfnmsbd_vvsvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvsvvl
def vfnmsbd_vvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvvvmvl
def vfnmsbd_vvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vsvvmvl
def vfnmsbd_vsvvmvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.d vfnmsbd_vvsvmvl
def vfnmsbd_vvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.d $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvvvl
def vfnmsbs_vvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvvvvl
def vfnmsbs_vvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vsvvl
def vfnmsbs_vsvvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vsvvvl
def vfnmsbs_vsvvvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvsvl
def vfnmsbs_vvsvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvsvvl
def vfnmsbs_vvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvvvmvl
def vfnmsbs_vvvvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vsvvmvl
def vfnmsbs_vsvvmvl : RV<0xf3, (outs V64:$vx), (ins F32:$sy, V64:$vz, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB vfnmsb.s vfnmsbs_vvsvmvl
def vfnmsbs_vvsvmvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, F32:$sy, V64:$vw, VM_:$vm, V64:$vd, I32:$vl),
       "vfnmsb.s $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvvvl
def pvfnmsb_vvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvvvvl
def pvfnmsb_vvvvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vsvvl
def pvfnmsb_vsvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vsvvvl
def pvfnmsb_vsvvvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvsvl
def pvfnmsb_vvsvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvsvvl
def pvfnmsb_vvsvvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvvvMvl
def pvfnmsb_vvvvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vsvvMvl
def pvfnmsb_vsvvMvl : RV<0xf3, (outs V64:$vx), (ins I64:$sy, V64:$vz, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$sy,$vz,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFNMSB pvfnmsb pvfnmsb_vvsvMvl
def pvfnmsb_vvsvMvl : RV<0xf3, (outs V64:$vx), (ins V64:$vy, I64:$sy, V64:$vw, VM512_:$vm, V64:$vd, I32:$vl),
       "pvfnmsb $vx,$vy,$sy,$vw,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRCP vrcp.d vrcpd_vvl
def vrcpd_vvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrcp.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRCP vrcp.d vrcpd_vvvl
def vrcpd_vvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrcp.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRCP vrcp.s vrcps_vvl
def vrcps_vvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrcp.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRCP vrcp.s vrcps_vvvl
def vrcps_vvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrcp.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRCP pvrcp pvrcp_vvl
def pvrcp_vvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvrcp $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRCP pvrcp pvrcp_vvvl
def pvrcp_vvvl : RV<0xe1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrcp $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.d vrsqrtd_vvl
def vrsqrtd_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.d vrsqrtd_vvvl
def vrsqrtd_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.s vrsqrts_vvl
def vrsqrts_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.s vrsqrts_vvvl
def vrsqrts_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT pvrsqrt pvrsqrt_vvl
def pvrsqrt_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvrsqrt $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT pvrsqrt pvrsqrt_vvvl
def pvrsqrt_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrsqrt $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.d.nex vrsqrtdnex_vvl
def vrsqrtdnex_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.d.nex $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.d.nex vrsqrtdnex_vvvl
def vrsqrtdnex_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.d.nex $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.s.nex vrsqrtsnex_vvl
def vrsqrtsnex_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrsqrt.s.nex $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT vrsqrt.s.nex vrsqrtsnex_vvvl
def vrsqrtsnex_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrsqrt.s.nex $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT pvrsqrt.nex pvrsqrtnex_vvl
def pvrsqrtnex_vvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvrsqrt.nex $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRSQRT pvrsqrt.nex pvrsqrtnex_vvvl
def pvrsqrtnex_vvvl : RV<0xf1, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvrsqrt.nex $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx vcvtwdsx_vvl
def vcvtwdsx_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx vcvtwdsx_vvvl
def vcvtwdsx_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx vcvtwdsx_vvmvl
def vcvtwdsx_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.sx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx.rz vcvtwdsxrz_vvl
def vcvtwdsxrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx.rz vcvtwdsxrz_vvvl
def vcvtwdsxrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.sx.rz vcvtwdsxrz_vvmvl
def vcvtwdsxrz_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx vcvtwdzx_vvl
def vcvtwdzx_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx vcvtwdzx_vvvl
def vcvtwdzx_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx vcvtwdzx_vvmvl
def vcvtwdzx_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.zx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx.rz vcvtwdzxrz_vvl
def vcvtwdzxrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx.rz vcvtwdzxrz_vvvl
def vcvtwdzxrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.d.zx.rz vcvtwdzxrz_vvmvl
def vcvtwdzxrz_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.d.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx vcvtwssx_vvl
def vcvtwssx_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx vcvtwssx_vvvl
def vcvtwssx_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx vcvtwssx_vvmvl
def vcvtwssx_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.sx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx.rz vcvtwssxrz_vvl
def vcvtwssxrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx.rz vcvtwssxrz_vvvl
def vcvtwssxrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.sx.rz vcvtwssxrz_vvmvl
def vcvtwssxrz_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.sx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx vcvtwszx_vvl
def vcvtwszx_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx vcvtwszx_vvvl
def vcvtwszx_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx vcvtwszx_vvmvl
def vcvtwszx_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.zx $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx.rz vcvtwszxrz_vvl
def vcvtwszxrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx.rz vcvtwszxrz_vvvl
def vcvtwszxrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX vcvt.w.s.zx.rz vcvtwszxrz_vvmvl
def vcvtwszxrz_vvmvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.w.s.zx.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s pvcvtws_vvl
def pvcvtws_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvcvt.w.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s pvcvtws_vvvl
def pvcvtws_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.w.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s pvcvtws_vvMvl
def pvcvtws_vvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcvt.w.s $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s.rz pvcvtwsrz_vvl
def pvcvtwsrz_vvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s.rz pvcvtwsrz_vvvl
def pvcvtwsrz_vvvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIX pvcvt.w.s.rz pvcvtwsrz_vvMvl
def pvcvtwsrz_vvMvl : RV<0xe8, (outs V64:$vx), (ins V64:$vy, VM512_:$vm, V64:$vd, I32:$vl),
       "pvcvt.w.s.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d vcvtld_vvl
def vcvtld_vvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.l.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d vcvtld_vvvl
def vcvtld_vvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.l.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d vcvtld_vvmvl
def vcvtld_vvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.l.d $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d.rz vcvtldrz_vvl
def vcvtldrz_vvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.l.d.rz $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d.rz vcvtldrz_vvvl
def vcvtldrz_vvvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.l.d.rz $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFIXX vcvt.l.d.rz vcvtldrz_vvmvl
def vcvtldrz_vvmvl : RV<0xa8, (outs V64:$vx), (ins V64:$vy, VM_:$vm, V64:$vd, I32:$vl),
       "vcvt.l.d.rz $vx,$vy,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLT vcvt.d.w vcvtdw_vvl
def vcvtdw_vvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.d.w $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLT vcvt.d.w vcvtdw_vvvl
def vcvtdw_vvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLT vcvt.s.w vcvtsw_vvl
def vcvtsw_vvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.s.w $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLT vcvt.s.w vcvtsw_vvvl
def vcvtsw_vvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.s.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLT pvcvt.s.w pvcvtsw_vvl
def pvcvtsw_vvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "pvcvt.s.w $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLT pvcvt.s.w pvcvtsw_vvvl
def pvcvtsw_vvvl : RV<0xf8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "pvcvt.s.w $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLTX vcvt.d.l vcvtdl_vvl
def vcvtdl_vvl : RV<0xb8, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.d.l $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFLTX vcvt.d.l vcvtdl_vvvl
def vcvtdl_vvvl : RV<0xb8, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.l $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCVD vcvt.d.s vcvtds_vvl
def vcvtds_vvl : RV<0x8f, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.d.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCVD vcvt.d.s vcvtds_vvvl
def vcvtds_vvvl : RV<0x8f, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.d.s $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCVS vcvt.s.d vcvtsd_vvl
def vcvtsd_vvl : RV<0x9f, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vcvt.s.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCVS vcvt.s.d vcvtsd_vvvl
def vcvtsd_vvvl : RV<0x9f, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vcvt.s.d $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg vmrg_vvvml
def vmrg_vvvml : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, I32:$vl),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg vmrg_vvvmvl
def vmrg_vvvmvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmrg $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg vmrg_vsvml
def vmrg_vsvml : RV<0xd6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, I32:$vl),
       "vmrg $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg vmrg_vsvmvl
def vmrg_vsvmvl : RV<0xd6, (outs V64:$vx), (ins I64:$sy, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmrg $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg vmrg_vIvml
def vmrg_vIvml : RV<0xd6, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, I32:$vl),
       "vmrg $vx,$I,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg vmrg_vIvmvl
def vmrg_vIvmvl : RV<0xd6, (outs V64:$vx), (ins simm7Op64:$I, V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vmrg $vx,$I,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg.w vmrgw_vvvMl
def vmrgw_vvvMl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, I32:$vl),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg.w vmrgw_vvvMvl
def vmrgw_vvvMvl : RV<0xd6, (outs V64:$vx), (ins V64:$vy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "vmrg.w $vx,$vy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg.w vmrgw_vsvMl
def vmrgw_vsvMl : RV<0xd6, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM512_:$vm, I32:$vl),
       "vmrg.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMRG vmrg.w vmrgw_vsvMvl
def vmrgw_vsvMvl : RV<0xd6, (outs V64:$vx), (ins I32:$sy, V64:$vz, VM512_:$vm, V64:$vd, I32:$vl),
       "vmrg.w $vx,$sy,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSHF vshf vshf_vvvsl
def vshf_vvvsl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy, I32:$vl),
       "vshf $vx,$vy,$vz,$sy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSHF vshf vshf_vvvsvl
def vshf_vvvsvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, I64:$sy, V64:$vd, I32:$vl),
       "vshf $vx,$vy,$vz,$sy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSHF vshf vshf_vvvIl
def vshf_vvvIl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, simm7Op64:$N, I32:$vl),
       "vshf $vx,$vy,$vz,$N", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSHF vshf vshf_vvvIvl
def vshf_vvvIvl : RV<0xbc, (outs V64:$vx), (ins V64:$vy, V64:$vz, simm7Op64:$N, V64:$vd, I32:$vl),
       "vshf $vx,$vy,$vz,$N", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VCP vcp vcp_vvmvl
def vcp_vvmvl : RV<0x8d, (outs V64:$vx), (ins V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vcp $vx,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VEX vex vex_vvmvl
def vex_vvmvl : RV<0x9d, (outs V64:$vx), (ins V64:$vz, VM_:$vm, V64:$vd, I32:$vl),
       "vex $vx,$vz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.at vfmklat_ml
def vfmklat_ml : RV<0xb4, (outs VM_:$vmx), (ins I32:$vl),
       "vfmk.l.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.af vfmklaf_ml
def vfmklaf_ml : RV<0xb4, (outs VM_:$vmx), (ins I32:$vl),
       "vfmk.l.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK pvfmk.w.lo.at pvfmkwloat_ml
def pvfmkwloat_ml : RV<0xb5, (outs VM_:$vmx), (ins I32:$vl),
       "pvfmk.w.lo.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK pvfmk.w.up.at pvfmkwupat_ml
def pvfmkwupat_ml : RV<0xb5, (outs VM_:$vmx), (ins I32:$vl),
       "pvfmk.w.up.at $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK pvfmk.w.lo.af pvfmkwloaf_ml
def pvfmkwloaf_ml : RV<0xb5, (outs VM_:$vmx), (ins I32:$vl),
       "pvfmk.w.lo.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK pvfmk.w.up.af pvfmkwupaf_ml
def pvfmkwupaf_ml : RV<0xb5, (outs VM_:$vmx), (ins I32:$vl),
       "pvfmk.w.up.af $vmx", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK pvfmk.at pvfmkat_Ml
def pvfmkat_Ml : Pseudo<(outs VM512_:$vmx), (ins I32:$vl),
       "# pvfmk.at $vmx", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK pvfmk.af pvfmkaf_Ml
def pvfmkaf_Ml : Pseudo<(outs VM512_:$vmx), (ins I32:$vl),
       "# pvfmk.af $vmx", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.gt vfmklgt_mvl
def vfmklgt_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.gt vfmklgt_mvml
def vfmklgt_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.lt vfmkllt_mvl
def vfmkllt_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.lt vfmkllt_mvml
def vfmkllt_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ne vfmklne_mvl
def vfmklne_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ne vfmklne_mvml
def vfmklne_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.eq vfmkleq_mvl
def vfmkleq_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.eq vfmkleq_mvml
def vfmkleq_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ge vfmklge_mvl
def vfmklge_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ge vfmklge_mvml
def vfmklge_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.le vfmklle_mvl
def vfmklle_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.le vfmklle_mvml
def vfmklle_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.num vfmklnum_mvl
def vfmklnum_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.num vfmklnum_mvml
def vfmklnum_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.nan vfmklnan_mvl
def vfmklnan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.nan vfmklnan_mvml
def vfmklnan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.gtnan vfmklgtnan_mvl
def vfmklgtnan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.gtnan vfmklgtnan_mvml
def vfmklgtnan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ltnan vfmklltnan_mvl
def vfmklltnan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.ltnan vfmklltnan_mvml
def vfmklltnan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.nenan vfmklnenan_mvl
def vfmklnenan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.nenan vfmklnenan_mvml
def vfmklnenan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.eqnan vfmkleqnan_mvl
def vfmkleqnan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.eqnan vfmkleqnan_mvml
def vfmkleqnan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.genan vfmklgenan_mvl
def vfmklgenan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.genan vfmklgenan_mvml
def vfmklgenan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.lenan vfmkllenan_mvl
def vfmkllenan_mvl : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.l.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMK vfmk.l.lenan vfmkllenan_mvml
def vfmkllenan_mvml : RV<0xb4, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.l.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.gt vfmkwgt_mvl
def vfmkwgt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.gt vfmkwgt_mvml
def vfmkwgt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.lt vfmkwlt_mvl
def vfmkwlt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.lt vfmkwlt_mvml
def vfmkwlt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ne vfmkwne_mvl
def vfmkwne_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ne vfmkwne_mvml
def vfmkwne_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.eq vfmkweq_mvl
def vfmkweq_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.eq vfmkweq_mvml
def vfmkweq_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ge vfmkwge_mvl
def vfmkwge_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ge vfmkwge_mvml
def vfmkwge_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.le vfmkwle_mvl
def vfmkwle_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.le vfmkwle_mvml
def vfmkwle_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.num vfmkwnum_mvl
def vfmkwnum_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.num vfmkwnum_mvml
def vfmkwnum_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.nan vfmkwnan_mvl
def vfmkwnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.nan vfmkwnan_mvml
def vfmkwnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.gtnan vfmkwgtnan_mvl
def vfmkwgtnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.gtnan vfmkwgtnan_mvml
def vfmkwgtnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ltnan vfmkwltnan_mvl
def vfmkwltnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.ltnan vfmkwltnan_mvml
def vfmkwltnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.nenan vfmkwnenan_mvl
def vfmkwnenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.nenan vfmkwnenan_mvml
def vfmkwnenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.eqnan vfmkweqnan_mvl
def vfmkweqnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.eqnan vfmkweqnan_mvml
def vfmkweqnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.genan vfmkwgenan_mvl
def vfmkwgenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.genan vfmkwgenan_mvml
def vfmkwgenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.lenan vfmkwlenan_mvl
def vfmkwlenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.w.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS vfmk.w.lenan vfmkwlenan_mvml
def vfmkwlenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.w.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.gt pvfmkwlogt_mvl
def pvfmkwlogt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.gt pvfmkwupgt_mvl
def pvfmkwupgt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.gt pvfmkwlogt_mvml
def pvfmkwlogt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.gt pvfmkwupgt_mvml
def pvfmkwupgt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.lt pvfmkwlolt_mvl
def pvfmkwlolt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.lt pvfmkwuplt_mvl
def pvfmkwuplt_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.lt pvfmkwlolt_mvml
def pvfmkwlolt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.lt pvfmkwuplt_mvml
def pvfmkwuplt_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.ne pvfmkwlone_mvl
def pvfmkwlone_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.ne pvfmkwupne_mvl
def pvfmkwupne_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.ne pvfmkwlone_mvml
def pvfmkwlone_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.ne pvfmkwupne_mvml
def pvfmkwupne_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.eq pvfmkwloeq_mvl
def pvfmkwloeq_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.eq pvfmkwupeq_mvl
def pvfmkwupeq_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.eq pvfmkwloeq_mvml
def pvfmkwloeq_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.eq pvfmkwupeq_mvml
def pvfmkwupeq_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.ge pvfmkwloge_mvl
def pvfmkwloge_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.ge pvfmkwupge_mvl
def pvfmkwupge_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.ge pvfmkwloge_mvml
def pvfmkwloge_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.ge pvfmkwupge_mvml
def pvfmkwupge_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.le pvfmkwlole_mvl
def pvfmkwlole_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.le pvfmkwuple_mvl
def pvfmkwuple_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.le pvfmkwlole_mvml
def pvfmkwlole_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.le pvfmkwuple_mvml
def pvfmkwuple_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.num pvfmkwlonum_mvl
def pvfmkwlonum_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.num pvfmkwupnum_mvl
def pvfmkwupnum_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.num pvfmkwlonum_mvml
def pvfmkwlonum_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.num pvfmkwupnum_mvml
def pvfmkwupnum_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.nan pvfmkwlonan_mvl
def pvfmkwlonan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.nan pvfmkwupnan_mvl
def pvfmkwupnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.nan pvfmkwlonan_mvml
def pvfmkwlonan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.nan pvfmkwupnan_mvml
def pvfmkwupnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.gtnan pvfmkwlogtnan_mvl
def pvfmkwlogtnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.gtnan pvfmkwupgtnan_mvl
def pvfmkwupgtnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.gtnan pvfmkwlogtnan_mvml
def pvfmkwlogtnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.gtnan pvfmkwupgtnan_mvml
def pvfmkwupgtnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.ltnan pvfmkwloltnan_mvl
def pvfmkwloltnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.ltnan pvfmkwupltnan_mvl
def pvfmkwupltnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.ltnan pvfmkwloltnan_mvml
def pvfmkwloltnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.ltnan pvfmkwupltnan_mvml
def pvfmkwupltnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.nenan pvfmkwlonenan_mvl
def pvfmkwlonenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.nenan pvfmkwupnenan_mvl
def pvfmkwupnenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.nenan pvfmkwlonenan_mvml
def pvfmkwlonenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.nenan pvfmkwupnenan_mvml
def pvfmkwupnenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.eqnan pvfmkwloeqnan_mvl
def pvfmkwloeqnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.eqnan pvfmkwupeqnan_mvl
def pvfmkwupeqnan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.eqnan pvfmkwloeqnan_mvml
def pvfmkwloeqnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.eqnan pvfmkwupeqnan_mvml
def pvfmkwupeqnan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.genan pvfmkwlogenan_mvl
def pvfmkwlogenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.genan pvfmkwupgenan_mvl
def pvfmkwupgenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.genan pvfmkwlogenan_mvml
def pvfmkwlogenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.genan pvfmkwupgenan_mvml
def pvfmkwupgenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.lenan pvfmkwlolenan_mvl
def pvfmkwlolenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.lo.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.lenan pvfmkwuplenan_mvl
def pvfmkwuplenan_mvl : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.w.up.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lo.lenan pvfmkwlolenan_mvml
def pvfmkwlolenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.lo.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.up.lenan pvfmkwuplenan_mvml
def pvfmkwuplenan_mvml : RV<0xb5, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.w.up.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.gt pvfmkwgt_Mvl
def pvfmkwgt_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.gt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.gt pvfmkwgt_MvMl
def pvfmkwgt_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.gt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lt pvfmkwlt_Mvl
def pvfmkwlt_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.lt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lt pvfmkwlt_MvMl
def pvfmkwlt_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.lt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ne pvfmkwne_Mvl
def pvfmkwne_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.ne $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ne pvfmkwne_MvMl
def pvfmkwne_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.ne $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.eq pvfmkweq_Mvl
def pvfmkweq_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.eq $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.eq pvfmkweq_MvMl
def pvfmkweq_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.eq $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ge pvfmkwge_Mvl
def pvfmkwge_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.ge $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ge pvfmkwge_MvMl
def pvfmkwge_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.ge $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.le pvfmkwle_Mvl
def pvfmkwle_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.le $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.le pvfmkwle_MvMl
def pvfmkwle_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.le $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.num pvfmkwnum_Mvl
def pvfmkwnum_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.num $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.num pvfmkwnum_MvMl
def pvfmkwnum_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.num $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.nan pvfmkwnan_Mvl
def pvfmkwnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.nan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.nan pvfmkwnan_MvMl
def pvfmkwnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.nan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.gtnan pvfmkwgtnan_Mvl
def pvfmkwgtnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.gtnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.gtnan pvfmkwgtnan_MvMl
def pvfmkwgtnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.gtnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ltnan pvfmkwltnan_Mvl
def pvfmkwltnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.ltnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.ltnan pvfmkwltnan_MvMl
def pvfmkwltnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.ltnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.nenan pvfmkwnenan_Mvl
def pvfmkwnenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.nenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.nenan pvfmkwnenan_MvMl
def pvfmkwnenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.nenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.eqnan pvfmkweqnan_Mvl
def pvfmkweqnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.eqnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.eqnan pvfmkweqnan_MvMl
def pvfmkweqnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.eqnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.genan pvfmkwgenan_Mvl
def pvfmkwgenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.genan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.genan pvfmkwgenan_MvMl
def pvfmkwgenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.genan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lenan pvfmkwlenan_Mvl
def pvfmkwlenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.w.lenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMS pvfmk.w.lenan pvfmkwlenan_MvMl
def pvfmkwlenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.w.lenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.gt vfmkdgt_mvl
def vfmkdgt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.gt vfmkdgt_mvml
def vfmkdgt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.lt vfmkdlt_mvl
def vfmkdlt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.lt vfmkdlt_mvml
def vfmkdlt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ne vfmkdne_mvl
def vfmkdne_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ne vfmkdne_mvml
def vfmkdne_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.eq vfmkdeq_mvl
def vfmkdeq_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.eq vfmkdeq_mvml
def vfmkdeq_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ge vfmkdge_mvl
def vfmkdge_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ge vfmkdge_mvml
def vfmkdge_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.le vfmkdle_mvl
def vfmkdle_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.le vfmkdle_mvml
def vfmkdle_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.num vfmkdnum_mvl
def vfmkdnum_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.num vfmkdnum_mvml
def vfmkdnum_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.nan vfmkdnan_mvl
def vfmkdnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.nan vfmkdnan_mvml
def vfmkdnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.gtnan vfmkdgtnan_mvl
def vfmkdgtnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.gtnan vfmkdgtnan_mvml
def vfmkdgtnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ltnan vfmkdltnan_mvl
def vfmkdltnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.ltnan vfmkdltnan_mvml
def vfmkdltnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.nenan vfmkdnenan_mvl
def vfmkdnenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.nenan vfmkdnenan_mvml
def vfmkdnenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.eqnan vfmkdeqnan_mvl
def vfmkdeqnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.eqnan vfmkdeqnan_mvml
def vfmkdeqnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.genan vfmkdgenan_mvl
def vfmkdgenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.genan vfmkdgenan_mvml
def vfmkdgenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.lenan vfmkdlenan_mvl
def vfmkdlenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.d.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.d.lenan vfmkdlenan_mvml
def vfmkdlenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.d.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.gt vfmksgt_mvl
def vfmksgt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.gt vfmksgt_mvml
def vfmksgt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.lt vfmkslt_mvl
def vfmkslt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.lt vfmkslt_mvml
def vfmkslt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ne vfmksne_mvl
def vfmksne_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ne vfmksne_mvml
def vfmksne_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.eq vfmkseq_mvl
def vfmkseq_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.eq vfmkseq_mvml
def vfmkseq_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ge vfmksge_mvl
def vfmksge_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ge vfmksge_mvml
def vfmksge_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.le vfmksle_mvl
def vfmksle_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.le vfmksle_mvml
def vfmksle_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.num vfmksnum_mvl
def vfmksnum_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.num vfmksnum_mvml
def vfmksnum_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.nan vfmksnan_mvl
def vfmksnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.nan vfmksnan_mvml
def vfmksnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.gtnan vfmksgtnan_mvl
def vfmksgtnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.gtnan vfmksgtnan_mvml
def vfmksgtnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ltnan vfmksltnan_mvl
def vfmksltnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.ltnan vfmksltnan_mvml
def vfmksltnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.nenan vfmksnenan_mvl
def vfmksnenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.nenan vfmksnenan_mvml
def vfmksnenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.eqnan vfmkseqnan_mvl
def vfmkseqnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.eqnan vfmkseqnan_mvml
def vfmkseqnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.genan vfmksgenan_mvl
def vfmksgenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.genan vfmksgenan_mvml
def vfmksgenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.lenan vfmkslenan_mvl
def vfmkslenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "vfmk.s.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF vfmk.s.lenan vfmkslenan_mvml
def vfmkslenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "vfmk.s.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.gt pvfmkslogt_mvl
def pvfmkslogt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.gt pvfmksupgt_mvl
def pvfmksupgt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.gt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.gt pvfmkslogt_mvml
def pvfmkslogt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.gt pvfmksupgt_mvml
def pvfmksupgt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.gt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.lt pvfmkslolt_mvl
def pvfmkslolt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.lt pvfmksuplt_mvl
def pvfmksuplt_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.lt $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.lt pvfmkslolt_mvml
def pvfmkslolt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.lt pvfmksuplt_mvml
def pvfmksuplt_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.lt $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.ne pvfmkslone_mvl
def pvfmkslone_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.ne pvfmksupne_mvl
def pvfmksupne_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.ne $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.ne pvfmkslone_mvml
def pvfmkslone_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.ne pvfmksupne_mvml
def pvfmksupne_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.ne $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.eq pvfmksloeq_mvl
def pvfmksloeq_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.eq pvfmksupeq_mvl
def pvfmksupeq_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.eq $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.eq pvfmksloeq_mvml
def pvfmksloeq_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.eq pvfmksupeq_mvml
def pvfmksupeq_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.eq $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.ge pvfmksloge_mvl
def pvfmksloge_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.ge pvfmksupge_mvl
def pvfmksupge_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.ge $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.ge pvfmksloge_mvml
def pvfmksloge_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.ge pvfmksupge_mvml
def pvfmksupge_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.ge $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.le pvfmkslole_mvl
def pvfmkslole_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.le pvfmksuple_mvl
def pvfmksuple_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.le $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.le pvfmkslole_mvml
def pvfmkslole_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.le pvfmksuple_mvml
def pvfmksuple_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.le $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.num pvfmkslonum_mvl
def pvfmkslonum_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.num pvfmksupnum_mvl
def pvfmksupnum_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.num $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.num pvfmkslonum_mvml
def pvfmkslonum_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.num pvfmksupnum_mvml
def pvfmksupnum_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.num $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.nan pvfmkslonan_mvl
def pvfmkslonan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.nan pvfmksupnan_mvl
def pvfmksupnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.nan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.nan pvfmkslonan_mvml
def pvfmkslonan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.nan pvfmksupnan_mvml
def pvfmksupnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.nan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.gtnan pvfmkslogtnan_mvl
def pvfmkslogtnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.gtnan pvfmksupgtnan_mvl
def pvfmksupgtnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.gtnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.gtnan pvfmkslogtnan_mvml
def pvfmkslogtnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.gtnan pvfmksupgtnan_mvml
def pvfmksupgtnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.gtnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.ltnan pvfmksloltnan_mvl
def pvfmksloltnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.ltnan pvfmksupltnan_mvl
def pvfmksupltnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.ltnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.ltnan pvfmksloltnan_mvml
def pvfmksloltnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.ltnan pvfmksupltnan_mvml
def pvfmksupltnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.ltnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.nenan pvfmkslonenan_mvl
def pvfmkslonenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.nenan pvfmksupnenan_mvl
def pvfmksupnenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.nenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.nenan pvfmkslonenan_mvml
def pvfmkslonenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.nenan pvfmksupnenan_mvml
def pvfmksupnenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.nenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.eqnan pvfmksloeqnan_mvl
def pvfmksloeqnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.eqnan pvfmksupeqnan_mvl
def pvfmksupeqnan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.eqnan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.eqnan pvfmksloeqnan_mvml
def pvfmksloeqnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.eqnan pvfmksupeqnan_mvml
def pvfmksupeqnan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.eqnan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.genan pvfmkslogenan_mvl
def pvfmkslogenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.genan pvfmksupgenan_mvl
def pvfmksupgenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.genan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.genan pvfmkslogenan_mvml
def pvfmkslogenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.genan pvfmksupgenan_mvml
def pvfmksupgenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.genan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.lenan pvfmkslolenan_mvl
def pvfmkslolenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.lo.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.lenan pvfmksuplenan_mvl
def pvfmksuplenan_mvl : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, I32:$vl),
       "pvfmk.s.up.lenan $vmx,$vz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lo.lenan pvfmkslolenan_mvml
def pvfmkslolenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.lo.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.up.lenan pvfmksuplenan_mvml
def pvfmksuplenan_mvml : RV<0xb6, (outs VM_:$vmx), (ins V64:$vz, VM_:$vm, I32:$vl),
       "pvfmk.s.up.lenan $vmx,$vz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.gt pvfmksgt_Mvl
def pvfmksgt_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.gt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.gt pvfmksgt_MvMl
def pvfmksgt_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.gt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lt pvfmkslt_Mvl
def pvfmkslt_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.lt $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lt pvfmkslt_MvMl
def pvfmkslt_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.lt $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ne pvfmksne_Mvl
def pvfmksne_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.ne $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ne pvfmksne_MvMl
def pvfmksne_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.ne $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.eq pvfmkseq_Mvl
def pvfmkseq_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.eq $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.eq pvfmkseq_MvMl
def pvfmkseq_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.eq $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ge pvfmksge_Mvl
def pvfmksge_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.ge $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ge pvfmksge_MvMl
def pvfmksge_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.ge $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.le pvfmksle_Mvl
def pvfmksle_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.le $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.le pvfmksle_MvMl
def pvfmksle_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.le $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.num pvfmksnum_Mvl
def pvfmksnum_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.num $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.num pvfmksnum_MvMl
def pvfmksnum_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.num $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.nan pvfmksnan_Mvl
def pvfmksnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.nan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.nan pvfmksnan_MvMl
def pvfmksnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.nan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.gtnan pvfmksgtnan_Mvl
def pvfmksgtnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.gtnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.gtnan pvfmksgtnan_MvMl
def pvfmksgtnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.gtnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ltnan pvfmksltnan_Mvl
def pvfmksltnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.ltnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.ltnan pvfmksltnan_MvMl
def pvfmksltnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.ltnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.nenan pvfmksnenan_Mvl
def pvfmksnenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.nenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.nenan pvfmksnenan_MvMl
def pvfmksnenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.nenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.eqnan pvfmkseqnan_Mvl
def pvfmkseqnan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.eqnan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.eqnan pvfmkseqnan_MvMl
def pvfmkseqnan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.eqnan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.genan pvfmksgenan_Mvl
def pvfmksgenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.genan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.genan pvfmksgenan_MvMl
def pvfmksgenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.genan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lenan pvfmkslenan_Mvl
def pvfmkslenan_Mvl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, I32:$vl),
       "# pvfmk.s.lenan $vmx,$vz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMF pvfmk.s.lenan pvfmkslenan_MvMl
def pvfmkslenan_MvMl : Pseudo<(outs VM512_:$vmx), (ins V64:$vz, VM512_:$vm, I32:$vl),
       "# pvfmk.s.lenan $vmx,$vz,$vm", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.sx vsumwsx_vvl
def vsumwsx_vvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vsum.w.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.sx vsumwsx_vvml
def vsumwsx_vvml : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vsum.w.sx $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.zx vsumwzx_vvl
def vsumwzx_vvl : RV<0xea, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vsum.w.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMS vsum.w.zx vsumwzx_vvml
def vsumwzx_vvml : RV<0xea, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vsum.w.zx $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMX vsum.l vsuml_vvl
def vsuml_vvl : RV<0xaa, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vsum.l $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSUMX vsum.l vsuml_vvml
def vsuml_vvml : RV<0xaa, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vsum.l $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.d vfsumd_vvl
def vfsumd_vvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsum.d $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.d vfsumd_vvml
def vfsumd_vvml : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vfsum.d $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.s vfsums_vvl
def vfsums_vvl : RV<0xec, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfsum.s $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFSUM vfsum.s vfsums_vvml
def vfsums_vvml : RV<0xec, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vfsum.s $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.fst.sx vrmaxswfstsx_vvl
def vrmaxswfstsx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.fst.sx vrmaxswfstsx_vvvl
def vrmaxswfstsx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.lst.sx vrmaxswlstsx_vvl
def vrmaxswlstsx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.lst.sx vrmaxswlstsx_vvvl
def vrmaxswlstsx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.fst.zx vrmaxswfstzx_vvl
def vrmaxswfstzx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.fst.zx vrmaxswfstzx_vvvl
def vrmaxswfstzx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.lst.zx vrmaxswlstzx_vvl
def vrmaxswlstzx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmaxs.w.lst.zx vrmaxswlstzx_vvvl
def vrmaxswlstzx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.fst.sx vrminswfstsx_vvl
def vrminswfstsx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.fst.sx vrminswfstsx_vvvl
def vrminswfstsx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.fst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.lst.sx vrminswlstsx_vvl
def vrminswlstsx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.lst.sx vrminswlstsx_vvvl
def vrminswlstsx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.lst.sx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.fst.zx vrminswfstzx_vvl
def vrminswfstzx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.fst.zx vrminswfstzx_vvvl
def vrminswfstzx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.fst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.lst.zx vrminswlstzx_vvl
def vrminswlstzx_vvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXS vrmins.w.lst.zx vrminswlstzx_vvvl
def vrminswlstzx_vvvl : RV<0xbb, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.w.lst.zx $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmaxs.l.fst vrmaxslfst_vvl
def vrmaxslfst_vvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.l.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmaxs.l.fst vrmaxslfst_vvvl
def vrmaxslfst_vvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmaxs.l.lst vrmaxsllst_vvl
def vrmaxsllst_vvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmaxs.l.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmaxs.l.lst vrmaxsllst_vvvl
def vrmaxsllst_vvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmaxs.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmins.l.fst vrminslfst_vvl
def vrminslfst_vvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.l.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmins.l.fst vrminslfst_vvvl
def vrminslfst_vvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.l.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmins.l.lst vrminsllst_vvl
def vrminsllst_vvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrmins.l.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VMAXX vrmins.l.lst vrminsllst_vvvl
def vrminsllst_vvvl : RV<0xab, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vrmins.l.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.d.fst vfrmaxdfst_vvl
def vfrmaxdfst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.d.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.d.fst vfrmaxdfst_vvvl
def vfrmaxdfst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.d.lst vfrmaxdlst_vvl
def vfrmaxdlst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.d.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.d.lst vfrmaxdlst_vvvl
def vfrmaxdlst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.s.fst vfrmaxsfst_vvl
def vfrmaxsfst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.s.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.s.fst vfrmaxsfst_vvvl
def vfrmaxsfst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.s.lst vfrmaxslst_vvl
def vfrmaxslst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmax.s.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmax.s.lst vfrmaxslst_vvvl
def vfrmaxslst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmax.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.d.fst vfrmindfst_vvl
def vfrmindfst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.d.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.d.fst vfrmindfst_vvvl
def vfrmindfst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.d.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.d.lst vfrmindlst_vvl
def vfrmindlst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.d.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.d.lst vfrmindlst_vvvl
def vfrmindlst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.d.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.s.fst vfrminsfst_vvl
def vfrminsfst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.s.fst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.s.fst vfrminsfst_vvvl
def vfrminsfst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.s.fst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.s.lst vfrminslst_vvl
def vfrminslst_vvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vfrmin.s.lst $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VFMAX vfrmin.s.lst vfrminslst_vvvl
def vfrminslst_vvvl : RV<0xad, (outs V64:$vx), (ins V64:$vy, V64:$vd, I32:$vl),
       "vfrmin.s.lst $vx,$vy", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRAND vrand vrand_vvl
def vrand_vvl : RV<0x88, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrand $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRAND vrand vrand_vvml
def vrand_vvml : RV<0x88, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vrand $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VROR vror vror_vvl
def vror_vvl : RV<0x98, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vror $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VROR vror vror_vvml
def vror_vvml : RV<0x98, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vror $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRXOR vrxor vrxor_vvl
def vrxor_vvl : RV<0x89, (outs V64:$vx), (ins V64:$vy, I32:$vl),
       "vrxor $vx,$vy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VRXOR vrxor vrxor_vvml
def vrxor_vvml : RV<0x89, (outs V64:$vx), (ins V64:$vy, VM_:$vm, I32:$vl),
       "vrxor $vx,$vy,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvssl
def vgt_vvssl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgt $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvssvl
def vgt_vvssvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvsZl
def vgt_vvsZl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgt $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvsZvl
def vgt_vvsZvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvIsl
def vgt_vvIsl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgt $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvIsvl
def vgt_vvIsvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvIZl
def vgt_vvIZl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgt $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvIZvl
def vgt_vvIZvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvssml
def vgt_vvssml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgt $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvssmvl
def vgt_vvssmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvsZml
def vgt_vvsZml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgt $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvsZmvl
def vgt_vvsZmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvIsml
def vgt_vvIsml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgt $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvIsmvl
def vgt_vvIsmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvIZml
def vgt_vvIZml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgt $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt vgt_vvIZmvl
def vgt_vvIZmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgt $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvssl
def vgtnc_vvssl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvssvl
def vgtnc_vvssvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvsZl
def vgtnc_vvsZl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvsZvl
def vgtnc_vvsZvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvIsl
def vgtnc_vvIsl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvIsvl
def vgtnc_vvIsvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvIZl
def vgtnc_vvIZl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvIZvl
def vgtnc_vvIZvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvssml
def vgtnc_vvssml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvssmvl
def vgtnc_vvssmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvsZml
def vgtnc_vvsZml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvsZmvl
def vgtnc_vvsZmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvIsml
def vgtnc_vvIsml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvIsmvl
def vgtnc_vvIsmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvIZml
def vgtnc_vvIZml : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGT vgt.nc vgtnc_vvIZmvl
def vgtnc_vvIZmvl : RV<0xa1, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgt.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvssl
def vgtu_vvssl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvssvl
def vgtu_vvssvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvsZl
def vgtu_vvsZl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvsZvl
def vgtu_vvsZvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvIsl
def vgtu_vvIsl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvIsvl
def vgtu_vvIsvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvIZl
def vgtu_vvIZl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvIZvl
def vgtu_vvIZvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvssml
def vgtu_vvssml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvssmvl
def vgtu_vvssmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvsZml
def vgtu_vvsZml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvsZmvl
def vgtu_vvsZmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvIsml
def vgtu_vvIsml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvIsmvl
def vgtu_vvIsmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvIZml
def vgtu_vvIZml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu vgtu_vvIZmvl
def vgtu_vvIZmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvssl
def vgtunc_vvssl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvssvl
def vgtunc_vvssvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvsZl
def vgtunc_vvsZl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvsZvl
def vgtunc_vvsZvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvIsl
def vgtunc_vvIsl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvIsvl
def vgtunc_vvIsvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvIZl
def vgtunc_vvIZl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvIZvl
def vgtunc_vvIZvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvssml
def vgtunc_vvssml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvssmvl
def vgtunc_vvssmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvsZml
def vgtunc_vvsZml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvsZmvl
def vgtunc_vvsZmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvIsml
def vgtunc_vvIsml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvIsmvl
def vgtunc_vvIsmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvIZml
def vgtunc_vvIZml : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTU vgtu.nc vgtunc_vvIZmvl
def vgtunc_vvIZmvl : RV<0xa2, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvssl
def vgtlsx_vvssl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvssvl
def vgtlsx_vvssvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvsZl
def vgtlsx_vvsZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvsZvl
def vgtlsx_vvsZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvIsl
def vgtlsx_vvIsl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvIsvl
def vgtlsx_vvIsvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvIZl
def vgtlsx_vvIZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvIZvl
def vgtlsx_vvIZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvssml
def vgtlsx_vvssml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvssmvl
def vgtlsx_vvssmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvsZml
def vgtlsx_vvsZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvsZmvl
def vgtlsx_vvsZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvIsml
def vgtlsx_vvIsml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvIsmvl
def vgtlsx_vvIsmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvIZml
def vgtlsx_vvIZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx vgtlsx_vvIZmvl
def vgtlsx_vvIZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvssl
def vgtlsxnc_vvssl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvssvl
def vgtlsxnc_vvssvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvsZl
def vgtlsxnc_vvsZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvsZvl
def vgtlsxnc_vvsZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvIsl
def vgtlsxnc_vvIsl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvIsvl
def vgtlsxnc_vvIsvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvIZl
def vgtlsxnc_vvIZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvIZvl
def vgtlsxnc_vvIZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvssml
def vgtlsxnc_vvssml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvssmvl
def vgtlsxnc_vvssmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvsZml
def vgtlsxnc_vvsZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvsZmvl
def vgtlsxnc_vvsZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvIsml
def vgtlsxnc_vvIsml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvIsmvl
def vgtlsxnc_vvIsmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvIZml
def vgtlsxnc_vvIZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.sx.nc vgtlsxnc_vvIZmvl
def vgtlsxnc_vvIZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.sx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvssl
def vgtlzx_vvssl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvssvl
def vgtlzx_vvssvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvsZl
def vgtlzx_vvsZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvsZvl
def vgtlzx_vvsZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvIsl
def vgtlzx_vvIsl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvIsvl
def vgtlzx_vvIsvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvIZl
def vgtlzx_vvIZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvIZvl
def vgtlzx_vvIZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvssml
def vgtlzx_vvssml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvssmvl
def vgtlzx_vvssmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvsZml
def vgtlzx_vvsZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvsZmvl
def vgtlzx_vvsZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvIsml
def vgtlzx_vvIsml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvIsmvl
def vgtlzx_vvIsmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvIZml
def vgtlzx_vvIZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx vgtlzx_vvIZmvl
def vgtlzx_vvIZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvssl
def vgtlzxnc_vvssl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvssvl
def vgtlzxnc_vvssvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvsZl
def vgtlzxnc_vvsZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvsZvl
def vgtlzxnc_vvsZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvIsl
def vgtlzxnc_vvIsl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvIsvl
def vgtlzxnc_vvIsvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvIZl
def vgtlzxnc_vvIZl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvIZvl
def vgtlzxnc_vvIZvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvssml
def vgtlzxnc_vvssml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvssmvl
def vgtlzxnc_vvssmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvsZml
def vgtlzxnc_vvsZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvsZmvl
def vgtlzxnc_vvsZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvIsml
def vgtlzxnc_vvIsml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvIsmvl
def vgtlzxnc_vvIsmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvIZml
def vgtlzxnc_vvIZml : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VGTL vgtl.zx.nc vgtlzxnc_vvIZmvl
def vgtlzxnc_vvIZmvl : RV<0xa3, (outs V64:$vx), (ins V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, V64:$vd, I32:$vl),
       "vgtl.zx.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let Constraints = "$vx = $vd";
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvssl
def vsc_vvssl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvsZl
def vsc_vvsZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vsc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvIsl
def vsc_vvIsl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvIZl
def vsc_vvIZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vsc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvssml
def vsc_vvssml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vsc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvsZml
def vsc_vvsZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvIsml
def vsc_vvIsml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vsc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc vsc_vvIZml
def vsc_vvIZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc vscnc_vvssl
def vscnc_vvssl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc vscnc_vvsZl
def vscnc_vvsZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc vscnc_vvIsl
def vscnc_vvIsl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsc.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc vscnc_vvIZl
def vscnc_vvIZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vsc.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc vscnc_vvssml
def vscnc_vvssml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc vscnc_vvsZml
def vscnc_vvsZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc vscnc_vvIsml
def vscnc_vvIsml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc vscnc_vvIZml
def vscnc_vvIZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvssl
def vscot_vvssl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvsZl
def vscot_vvsZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvIsl
def vscot_vvIsl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvIZl
def vscot_vvIZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vsc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvssml
def vscot_vvssml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvsZml
def vscot_vvsZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvIsml
def vscot_vvIsml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.ot vscot_vvIZml
def vscot_vvIZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc.ot vscncot_vvssl
def vscncot_vvssl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc.ot vscncot_vvsZl
def vscncot_vvsZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc.ot vscncot_vvIsl
def vscncot_vvIsl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc.ot vscncot_vvIZl
def vscncot_vvIZl : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc.ot vscncot_vvssml
def vscncot_vvssml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc.ot vscncot_vvsZml
def vscncot_vvsZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc.ot vscncot_vvIsml
def vscncot_vvIsml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSC vsc.nc.ot vscncot_vvIZml
def vscncot_vvIZml : RV<0xb1, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vsc.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvssl
def vscu_vvssl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvsZl
def vscu_vvsZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscu $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvIsl
def vscu_vvIsl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscu $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvIZl
def vscu_vvIZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscu $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvssml
def vscu_vvssml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscu $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvsZml
def vscu_vvsZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvIsml
def vscu_vvIsml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscu $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu vscu_vvIZml
def vscu_vvIZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc vscunc_vvssl
def vscunc_vvssl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc vscunc_vvsZl
def vscunc_vvsZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc vscunc_vvIsl
def vscunc_vvIsl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscu.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc vscunc_vvIZl
def vscunc_vvIZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscu.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc vscunc_vvssml
def vscunc_vvssml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc vscunc_vvsZml
def vscunc_vvsZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc vscunc_vvIsml
def vscunc_vvIsml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc vscunc_vvIZml
def vscunc_vvIZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvssl
def vscuot_vvssl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvsZl
def vscuot_vvsZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvIsl
def vscuot_vvIsl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscu.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvIZl
def vscuot_vvIZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscu.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvssml
def vscuot_vvssml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvsZml
def vscuot_vvsZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvIsml
def vscuot_vvIsml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.ot vscuot_vvIZml
def vscuot_vvIZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc.ot vscuncot_vvssl
def vscuncot_vvssl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc.ot vscuncot_vvsZl
def vscuncot_vvsZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc.ot vscuncot_vvIsl
def vscuncot_vvIsl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc.ot vscuncot_vvIZl
def vscuncot_vvIZl : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc.ot vscuncot_vvssml
def vscuncot_vvssml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc.ot vscuncot_vvsZml
def vscuncot_vvsZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc.ot vscuncot_vvIsml
def vscuncot_vvIsml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCU vscu.nc.ot vscuncot_vvIZml
def vscuncot_vvIZml : RV<0xb2, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscu.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvssl
def vscl_vvssl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvsZl
def vscl_vvsZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscl $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvIsl
def vscl_vvIsl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscl $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvIZl
def vscl_vvIZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscl $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvssml
def vscl_vvssml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscl $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvsZml
def vscl_vvsZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvIsml
def vscl_vvIsml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscl $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl vscl_vvIZml
def vscl_vvIZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc vsclnc_vvssl
def vsclnc_vvssl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc vsclnc_vvsZl
def vsclnc_vvsZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc vsclnc_vvIsl
def vsclnc_vvIsl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscl.nc $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc vsclnc_vvIZl
def vsclnc_vvIZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscl.nc $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc vsclnc_vvssml
def vsclnc_vvssml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc vsclnc_vvsZml
def vsclnc_vvsZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc vsclnc_vvIsml
def vsclnc_vvIsml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc vsclnc_vvIZml
def vsclnc_vvIZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.nc $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvssl
def vsclot_vvssl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvsZl
def vsclot_vvsZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvIsl
def vsclot_vvIsl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscl.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvIZl
def vsclot_vvIZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscl.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvssml
def vsclot_vvssml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvsZml
def vsclot_vvsZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvIsml
def vsclot_vvIsml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.ot vsclot_vvIZml
def vsclot_vvIZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc.ot vsclncot_vvssl
def vsclncot_vvssl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc.ot vsclncot_vvsZl
def vsclncot_vvsZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc.ot vsclncot_vvIsl
def vsclncot_vvIsl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$sz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc.ot vsclncot_vvIZl
def vsclncot_vvIZl : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$Z", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc.ot vsclncot_vvssml
def vsclncot_vvssml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc.ot vsclncot_vvsZml
def vsclncot_vvsZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, I64:$sy, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$sy,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc.ot vsclncot_vvIsml
def vsclncot_vvIsml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, I64:$sz, VM_:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$sz,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// VSCL vscl.nc.ot vsclncot_vvIZml
def vsclncot_vvIZml : RV<0xb3, (outs ), (ins V64:$vx, V64:$vy, simm7Op64:$I, simm7Op64:$Z, VM_:$vm, I32:$vl),
       "vscl.nc.ot $vx,$vy,$I,$Z,$vm", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// ANDM andm andm_mmm
def andm_mmm : RV<0x84, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "andm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// ANDM andm andm_MMM
def andm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# andm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// ORM orm orm_mmm
def orm_mmm : RV<0x85, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "orm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// ORM orm orm_MMM
def orm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# orm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// XORM xorm xorm_mmm
def xorm_mmm : RV<0x86, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "xorm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// XORM xorm xorm_MMM
def xorm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# xorm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// EQVM eqvm eqvm_mmm
def eqvm_mmm : RV<0x87, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "eqvm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// EQVM eqvm eqvm_MMM
def eqvm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# eqvm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// NNDM nndm nndm_mmm
def nndm_mmm : RV<0x94, (outs VM_:$vmx), (ins VM_:$vmy, VM_:$vmz),
       "nndm $vmx,$vmy,$vmz", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// NNDM nndm nndm_MMM
def nndm_MMM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy, VM512_:$vmz),
       "# nndm $vmx,$vmy,$vmz", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// NEGM negm negm_mm
def negm_mm : RV<0x95, (outs VM_:$vmx), (ins VM_:$vmy),
       "negm $vmx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// NEGM negm negm_MM
def negm_MM : Pseudo<(outs VM512_:$vmx), (ins VM512_:$vmy),
       "# negm $vmx,$vmy", []>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
}

// PCVM pcvm pcvm_sml
def pcvm_sml : RV<0xa4, (outs I64:$sx), (ins VM_:$vmy, I32:$vl),
       "pcvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// LZVM lzvm lzvm_sml
def lzvm_sml : RV<0xa5, (outs I64:$sx), (ins VM_:$vmy, I32:$vl),
       "lzvm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

// TOVM tovm tovm_sml
def tovm_sml : RV<0xa6, (outs I64:$sx), (ins VM_:$vmy, I32:$vl),
       "tovm $sx,$vmy", [], NoItinerary>
{
  let DecoderNamespace = "VEL";
  let isCodeGenOnly = 1;
  let DisableEncoding = "$vl";
}

