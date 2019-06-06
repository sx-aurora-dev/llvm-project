#ifndef __VEL_INTRIN_H__
#define __VEL_INTRIN_H__

#include <veintrin_common.h>
#include <velintrin_gen.h>

#define _vel_svob() __builtin_ve_vl_svob()

// pack

#define _vel_pack_f32p __builtin_ve_vl_pack_f32p
#define _vel_pack_f32a __builtin_ve_vl_pack_f32a

static inline unsigned long int _vel_pack_i32(int a, int b)
{
    return (((unsigned long int)a) << 32) | (unsigned int)b;
}

// approx

static inline __vr _vel_vfdivdA_vsvl(double s0, __vr v0, int l)
{
    __vr v1, v2, v3;
    v2 = _vel_vrcpd_vvl(v0, l);
    double s1 = 1.0;
    v3 = _vel_vfnmsbd_vsvvl(s1, v0, v2, l);
    v2 = _vel_vfmadd_vvvvl(v2, v2, v3, l);
    v1 = _vel_vfnmsbd_vsvvl(s1, v0, v2, l);
    v1 = _vel_vfmadd_vvvvl(v2, v2, v1, l);
    v1 = _vel_vaddul_vsvl(1, v1, l);
    v3 = _vel_vfnmsbd_vsvvl(s1, v0, v1, l);
    v3 = _vel_vfmadd_vvvvl(v1, v1, v3, l);
    v1 = _vel_vfmuld_vsvl(s0, v3, l);
    v0 = _vel_vfnmsbd_vsvvl(s0, v1, v0, l);
    v0 = _vel_vfmadd_vvvvl(v1, v3, v0, l);
    return v0;
}

#endif
