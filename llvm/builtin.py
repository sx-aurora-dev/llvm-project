#! /usr/bin/python

import re

class Type:
    def __init__(self, ValueType, builtinCode, ctype, elemType = None):
        self.ValueType = ValueType  # v256f64, f64, f32, i64, ...
        self.builtinCode = builtinCode  # V256d, d, f, ...
        self.ctype = ctype
        self.elemType = elemType

    def isVectorType(self):
        return self.elemType != None

    def stride(self):
        if self.isVectorType():
            t = self.elemType
            if t == T_f64 or t == T_i64 or t == T_u64:
                return 8
            else:
                return 4
        raise Exception("not a vector type")

    def df(self):
        if self == T_f64: 
            return "d"
        elif self == T_f32: 
            return "s"
        elif self == T_i64 or self == T_u64:
            return "l"
        elif self == T_i32 or self == T_u32:
            return "w"
        else:
            raise Exception("df is unknown")


T_f64     = Type("f64",     "d",      "double")
T_f32     = Type("f32",     "f",      "float")
T_i64     = Type("i64",     "Li",     "long int")
T_i32     = Type("i32",     "i",      "int")
T_u64     = Type("i64",     "LUi",    "unsigned long int")
T_u32     = Type("i32",     "Ui",     "unsigned int")
T_v256f64 = Type("v256f64", "V256d",  "double*", T_f64)
T_v256f32 = Type("v256f64", "V256d",  "float*",  T_f32)
T_v256i64 = Type("v256f64", "V256d",  "long int*", T_i64)
T_v256i32 = Type("v256f64", "V256d",  "int*",  T_i32)
T_v256u64 = Type("v256f64", "V256d",  "unsigned long int*", T_u64)
T_v256u32 = Type("v256f64", "V256d",  "unsigned int*",  T_u32)

T_v4i64   = Type("v4i64",   "V4Li",   "unsigned long int*",  T_i64)

T_void    = Type(None,      None,     "void")
T_v256v64 = Type("v256f64", "V256d",  "void*", T_void)

class Op(object):
    def __init__(self, kind, ty, name):
        self.kind = kind
        self.ty = ty
        self.name = name

    def dagOp(self):
        if self.kind == 'I':
            return "({} simm7:${})".format(self.ty.ValueType, self.name)
        elif self.kind == 'N':
            return "({} uimm6:${})".format(self.ty.ValueType, self.name)
        elif self.kind == 'c':
            return "({} uimm6:${})".format(self.ty.ValueType, self.name)
        else:
            return "{}:${}".format(self.ty.ValueType, self.name)

    def isImm(self):
        return self.kind == 'I' or self.kind == 'N'
    def isReg(self):
        return self.kind == 'v' or self.kind == 's'
    def isSReg(self):
        return self.kind == 's'
    def isVReg(self):
        return self.kind == 'v'
    def isMask(self):
        return self.kind == 'm'
    def isCC(self):
        return self.kind == 'c'

    def regName(self):
        return self.name

    def formalName(self):
        if self.kind == "v" or self.kind == 'm':
            return "p" + self.name
        else:
            return self.name

class SY(Op):
    def __init__(self, ty):
        super(SY, self).__init__("s", ty, "sy")

def VOp(ty, name):
    if ty == T_f64:
        return Op("v", T_v256f64, name)
    elif ty == T_f32:
        return Op("v", T_v256f32, name)
    elif ty == T_i64:
        return Op("v", T_v256i64, name)
    elif ty == T_i32:
        return Op("v", T_v256i32, name)
    elif ty == T_u64:
        return Op("v", T_v256u64, name)
    elif ty == T_u32:
        return Op("v", T_v256u32, name)
    elif ty == T_void:
        return Op("v", T_v256v64, name)
    else:
        raise Exception("unknown type")

def VX(ty):
    return VOp(ty, "vx")
def VY(ty):
    return VOp(ty, "vy")
def VZ(ty):
    return VOp(ty, "vz")
def VW(ty):
    return VOp(ty, "vw")
def VD(ty):
    return VOp(ty, "vd")

VMx = Op("m", T_v4i64, "vmx")
VM = Op("m", T_v4i64, "vm")
CCOp = Op("c", T_u32, "cc")

I = Op("I", T_i64, "sy")
N = Op("N", T_i64, "sy")

class Inst:
    def __init__(self, opc, ni, nf, outs, ins, packed = False, expr = None):
        #self.opc = opc
        self.outs = outs
        self.ins = ins
        self.packed = packed
        self.expr = expr

        self.instName = ni
        self.intrinsicName = nf

    def hasMask(self):
        for op in self.ins:
            if op.isMask():
                return True
        return False

    # to be included from VEInstrInfo.td
    def intrinsicPattern(self):
        args = ", ".join([op.dagOp() for op in self.ins])
        l = "(int_ve_{} {})".format(self.intrinsicName, args)
        r = "({} {})".format(self.instName, args)
        return "def : Pat<{}, {}>;".format(l, r)

    # to be included from IntrinsicsVE.td
    def intrinsicDefine(self):
        outs = ", ".join(["LLVMType<{}>".format(i.ty.ValueType) for i in self.outs])
        ins = ", ".join(["LLVMType<{}>".format(i.ty.ValueType) for i in self.ins])
        return "def int_ve_{} : VEIntrinsic<\"{}\", [{}], [{}]>;".format(self.intrinsicName, self.intrinsicName, outs, ins)

    # to be included from BuiltinsVE.def
    def builtin(self):
        #tmp = "".join([i.ty.builtinCode for i in (self.outs + self.ins)])
        tmp = "".join([i.ty.builtinCode for i in self.outs])
        tmp += "".join([i.ty.builtinCode + "C" for i in self.ins])
        return "BUILTIN(__builtin_ve_{}, \"{}\", \"n\")".format(self.intrinsicName, tmp)

    # to be included from veintrin.h
    def header(self):
        return "#define _ve_{} __builtin_ve_{}".format(self.intrinsicName, self.intrinsicName)

    def funcHeader(self):
        tmp = [i for i in (self.outs + self.ins) if not i.isImm()]
        args = ["{} {}".format(i.ty.ctype, i.formalName()) for i in tmp]

        return "void {name}({args}, int n)".format(name=self.intrinsicName, args=", ".join(args))

    def hasTest(self):
        return not self.outs[0].isMask()

    def test(self):
        head = self.funcHeader()

        out = self.outs[0]
        body = ""
        indent = " " * 8

        if self.packed:
            stride = 8
            step = 512
            body += indent + "int l = n - i < 512 ? (n - i) / 2UL : 256;\n"
        else:
            stride = self.outs[0].ty.stride()
            step = 256
            body += indent + "int l = n - i < 256 ? n - i : 256;\n"

        body += indent + "_ve_lvl(l);\n"

        vld = "vld"
        vst = "vst"
        if not self.packed:
            if out.ty.elemType == T_f32:
                vld = "vldu"
                vst = "vstu"
            elif out.ty.elemType == T_i32 or out.ty.elemType == T_u32:
                vld = "vldl"
                vst = "vstl"

        cond = "CC_G"

        if self.hasMask():
            self.ins.pop(-1)

        args = []
        for op in self.ins:
            if op.isVReg():
                body += indent + "__vr {} = _ve_{}(p{}, {});\n".format(op.name, vld, op.name, stride)
            if op.isMask():
                body += indent + "__vr {}0 = _ve_{}(p{}, {});\n".format(op.name, vld, op.name, stride)
                body += indent + "__vm {} = _ve_vfmk_mcv({}, {}0);\n".format(op.name, cond, op.name)
            if op.isReg() or op.isMask():
                args.append(op.regName())
            elif op.isImm():
                args.append("3")
            elif op.isCC():
                args.append(op.name)

        if self.hasMask():
            op = self.outs[0]
            body += indent + "__vr {} = _ve_{}(p{}, {});\n".format(op.name, vld, op.name, stride)
            body += indent + "{} = _ve_{}({});\n".format(out.name, self.intrinsicName, ', '.join(args + [op.name]))
        else:
            body += indent + "__vr {} = _ve_{}({});\n".format(out.name, self.intrinsicName, ', '.join(args))
        body += indent + "_ve_{}({}, {}, {});\n".format(vst, out.formalName(), out.regName(), stride)

        tmp = []
        for op in (self.outs + self.ins):
            if op.isVReg() or op.isMask():
                tmp.append(indent + "p{} += {};".format(op.name, "512" if self.packed else "256"))

        body += "\n".join(tmp)

        func = '''#include "veintrin.h"
{} {{
    for (int i = 0; i < n; i += {}) {{
{}
    }}
}}
'''

        return func.format(head, step, body)

    def decl(self):
        head = self.funcHeader()
        return "extern {};".format(head)

    def hasReference(self):
        return self.expr != None
        
    def reference(self):
        head = self.funcHeader()

        tmp = []
        for op in self.outs + self.ins:
            if op.isVReg():
                tmp.append("p{}[i]".format(op.regName()))
            elif op.isReg():
                tmp.append(op.regName())
            elif op.isImm():
                tmp.append("3")

        body = self.expr.format(*tmp) + ";"

        preprocess = ''
        for op in self.ins:
            if op.isSReg():
                if self.packed:
                    ctype = self.outs[0].ty.elemType.ctype
                    preprocess = '{} sy0 = *({}*)&sy;'.format(ctype, ctype)
                    body = re.sub('sy', "sy0", body)

        # vz is mask
        if self.hasMask():
            body = "if (pvm[i] > 0) {{ {} }}".format(body)
#            body = '''
#        if (pvm[i] > 0) {{
#            {}
#        }} else {{
#            {} = {};
#        }}'''.format(body, tmp[0], tmp[-1]);


        func = '''{}
{{
    {}
    for (int i = 0; i < n; ++i) {{
        {}
    }}
}}'''

        return func.format(head, preprocess, body);


class ManualInstPrinter:
    def __init__(self):
        pass

    def printAll(self, insts):
        for i in insts:
            self.printI(i)

    def printI(self, I):
        if not I.hasReference():
            return

        outs = []
        v = []

        out = I.outs[0]
        if not out.isVReg():
            raise Exception("output is not VReg")
        if out.isVReg():
            v.append("{}[:]".format(out.regName()))
        else:
            v.append(out.regName())

        ins = []
        for op in I.ins:
            #v.append(op.regName())
            if op.isVReg():
                ins.append("const __vr " + op.regName())
                v.append("{}[:]".format(op.regName()))
            elif op.isSReg():
                ins.append("{} {}".format(op.ty.ctype, op.regName()))
                v.append("{}".format(op.regName()))
            elif op.isImm():
                ins.append("{} {}".format(op.ty.ctype, op.regName()))
                v.append("{}".format(op.regName()))
            elif op.isMask():
                ins.append("{} {}".format(op.ty.ctype, op.regName()))
                v.append("{}".format(op.regName()))
            else:
                raise Exception("unknown register kind")
        func = "__vr _ve_{}({})".format(I.intrinsicName, ", ".join(ins))
        line = "    {:<80} // {}".format(func, I.expr.format(*v))

        print line

class InstTable:
    def __init__(self):
        self.a = []

    def insts(self):
        return self.a

    def add(self, inst):
        self.a.append(inst)

    def VBRDm(self, opc, name, instName, packed = False):
        self.add(Inst(opc, "VBRDr", "vbrd_vs_f64", [VX(T_f64)], [SY(T_f64)], False, "{0} = {1}"))
        self.add(Inst(opc, "VBRDr", "vbrd_vs_i64", [VX(T_i64)], [SY(T_i64)], False, "{0} = {1}"))
        self.add(Inst(opc, "VBRDi", "vbrd_vI", [VX(T_i64)], [I], False, "{0} = {1}"))

        self.add(Inst(opc, "VBRDur", "vbrdu_vs", [VX(T_f32)], [SY(T_f32)], False, "{0} = {1}"))
        self.add(Inst(opc, "VBRDlr", "vbrdl_vs", [VX(T_i32)], [SY(T_i32)], False, "{0} = {1}"))
        self.add(Inst(opc, "VBRDli", "vbrdl_vI", [VX(T_i32)], [I], False, "{0} = {1}"))

        self.add(Inst(opc, "VBRDpr", "pvbrd_vs", [VX(T_u32)], [SY(T_u64)], True, "{0} = {1}"))

    def args_to_func_suffix(self, args):
        return "_" + "".join([op.kind for op in args])

    def args_to_inst_suffix(self, args):
        tbl = {
               "vv"   : "v",
               "vvv"  : "v",
               "vvvmv" : "vm",
               "vvs"  : "r",
               "vvN"  : "i",
               "vsv"  : "r",
               "vIv"  : "i",
               "vvvv" : "v",
               "vsvv" : "r",
               "vvsv" : "r2",
               "vIvv" : "i",
               "vvIv" : "i2",
               "mcv"  : "v",
               }

        tmp = "".join([op.kind for op in args])
        return tbl[tmp]

    def InstX(self, opc, ni, nf, ary, expr = None):
        #print("InstX: ni={} nf={}".format(ni, nf))
        for args in ary:
            ni0 = ni + self.args_to_inst_suffix(args)
            nf0 = nf + self.args_to_func_suffix(args)
            outs = [args[0]]
            ins = args[1:]
            i = Inst(opc, ni0, nf0, outs, ins, nf[0] == 'p', expr)
            self.add(i)

    def Inst3f(self, opc, name, instName, expr, hasPacked = True):
        O_f64_vvv = [VX(T_f64), VY(T_f64), VZ(T_f64)]
        O_f64_vsv = [VX(T_f64), SY(T_f64), VZ(T_f64)]
        O_f32_vvv = [VX(T_f32), VY(T_f32), VZ(T_f32)]
        O_f32_vsv = [VX(T_f32), SY(T_f32), VZ(T_f32)]
        O_pf32_vsv = [VX(T_f32), SY(T_u64), VZ(T_f32)]

        O_f64_vvvmv = [VX(T_f64), VY(T_f64), VZ(T_f64), VM, VD(T_f64)]

        self.InstX(opc, instName+"d", name+"d", [O_f64_vvv, O_f64_vsv, O_f64_vvvmv], expr)
        self.InstX(opc, instName+"s", name+"s", [O_f32_vvv, O_f32_vsv], expr)
        if hasPacked:
            self.InstX(opc, instName+"p", "p"+name, [O_f32_vvv, O_pf32_vsv], expr) 

    # 3 operands, unsigned [long] int
    def Inst3u(self, opc, name, instName, expr):
        O_u64_vvv = [VX(T_u64), VY(T_u64), VZ(T_u64)]
        O_u64_vsv = [VX(T_u64), SY(T_u64), VZ(T_u64)]
        O_u64_vIv = [VX(T_u64), I, VZ(T_u64)]

        O_u32_vvv = [VX(T_u32), VY(T_u32), VZ(T_u32)]
        O_u32_vsv = [VX(T_u32), SY(T_u32), VZ(T_u32)]
        O_u32_vIv = [VX(T_u32), I, VZ(T_u32)]

        self.InstX(opc, instName+"l", name+"l", [O_u64_vvv, O_u64_vsv, O_u64_vIv], expr)
        self.InstX(opc, instName+"w", name+"w", [O_u32_vvv, O_u32_vsv, O_u32_vIv], expr)
        self.InstX(opc, instName+"p", "p"+name, [O_u32_vvv, O_u32_vsv], expr)

    # 3 operands, long int
    def Inst3l(self, opc, name, instName, expr):
        O_i64_vvv = [VX(T_i64), VY(T_i64), VZ(T_i64)]
        O_i64_vsv = [VX(T_i64), SY(T_i64), VZ(T_i64)]
        O_i64_vIv = [VX(T_i64), I, VZ(T_i64)]

        self.InstX(opc, instName+"l", name+"l", [O_i64_vvv, O_i64_vsv, O_i64_vIv], expr)

    # 3 operands, int
    def Inst3w(self, opc, name, instName, expr):
        O_i32_vvv = [VX(T_i32), VY(T_i32), VZ(T_i32)]
        O_i32_vsv = [VX(T_i32), SY(T_i32), VZ(T_i32)]
        O_i32_vIv = [VX(T_i32), I, VZ(T_i32)]

        self.InstX(opc, instName+"wsx", name+"w_sx", [O_i32_vvv, O_i32_vsv, O_i32_vIv], expr)
        self.InstX(opc, instName+"wzx", name+"w_zx", [O_i32_vvv, O_i32_vsv, O_i32_vIv], expr)
        self.InstX(opc, instName+"p", "p"+name, [O_i32_vvv, O_i32_vsv], expr)

    def Logical(self, opc, name, instName, expr):
        O_u64_vvv = [VX(T_u64), VY(T_u64), VZ(T_u64)]
        O_u64_vsv = [VX(T_u64), SY(T_u64), VZ(T_u64)]
        #O_u64_vMv = [VX(T_u64), M, VZ(T_u64)]

        O_u32_vvv = [VX(T_u32), VY(T_u32), VZ(T_u32)]
        O_u32_vsv = [VX(T_u32), SY(T_u64), VZ(T_u32)]

        self.InstX(opc, instName, name, [O_u64_vvv, O_u64_vsv], expr)
        self.InstX(opc, instName+"p", "p"+name, [O_u32_vvv, O_u32_vsv], expr)

    def Shift(self, opc, name, instName, expr):
        O_u64_vvv = [VX(T_u64), VZ(T_u64), VY(T_u64)]
        O_u64_vvs = [VX(T_u64), VZ(T_u64), SY(T_u64)]
        O_u64_vvN = [VX(T_u64), VZ(T_u64), N]

        self.InstX(opc, instName, name, [O_u64_vvv, O_u64_vvs, O_u64_vvN], expr)

    def ShiftPacked(self, opc, name, instName, expr):
        O_u32_vvv = [VX(T_u32), VZ(T_u32), VY(T_u32)]
        O_u32_vvs = [VX(T_u32), VZ(T_u64), SY(T_u64)]

        self.InstX(opc, instName+"p", "p"+name, [O_u32_vvv, O_u32_vvs], expr)

    def Inst4f(self, opc, name, instName, expr):
        O_f64_vvvv = [VX(T_f64), VY(T_f64), VZ(T_f64), VW(T_f64)]
        O_f64_vsvv = [VX(T_f64), SY(T_f64), VZ(T_f64), VW(T_f64)]
        O_f64_vvsv = [VX(T_f64), VY(T_f64), SY(T_f64), VW(T_f64)]

        O_f32_vvvv = [VX(T_f32), VY(T_f32), VZ(T_f32), VW(T_f32)]
        O_f32_vsvv = [VX(T_f32), SY(T_f32), VZ(T_f32), VW(T_f32)]
        O_f32_vvsv = [VX(T_f32), VY(T_f32), SY(T_f32), VW(T_f32)]

        O_pf32_vsvv = [VX(T_f32), SY(T_u64), VZ(T_f32), VW(T_f32)]
        O_pf32_vvsv = [VX(T_f32), VY(T_f32), SY(T_u64), VW(T_f32)]

        self.InstX(opc, instName+"d", name+"d", [O_f64_vvvv, O_f64_vsvv, O_f64_vvsv], expr)
        self.InstX(opc, instName+"s", name+"s", [O_f32_vvvv, O_f32_vsvv, O_f32_vvsv], expr)
        self.InstX(opc, instName+"p", "p"+name, [O_f32_vvvv, O_pf32_vsvv, O_pf32_vvsv], expr)


def cmpwrite(filename, data):
    need_write = True
    try:
        with open(filename, "r") as f:
            old = f.read()
            need_write = old != data
    except:
        pass
    if need_write:
        print("write " + filename)
        with open(filename, "w") as f:
            f.write(data)


def gen_test(insts, directory):
    for i in insts:
        if i.hasTest():
            if directory:
                filename = "{}/{}.c".format(directory, i.intrinsicName)
                cmpwrite(filename, i.test())
            else:
                print i.test()


T = InstTable()

# 5.3.2.7. Vector Transfer Instructions
T.VBRDm(0x8C, "vbrd", "VBRD")

# 5.3.2.8. Vector Fixed-Point Arithmetic Operation Instructions
T.Inst3u(0xC8, "vaddu", "VADD", "{0} = {1} + {2}") # u32, u64
T.Inst3w(0xCA, "vadds", "VADS", "{0} = {1} + {2}") # i32
T.Inst3l(0x8B, "vadds", "VADX", "{0} = {1} + {2}") # i64
T.Inst3u(0xC8, "vsubu", "VSUB", "{0} = {1} - {2}") # u32, u64
T.Inst3w(0xCA, "vsubs", "VSBS", "{0} = {1} - {2}") # i32
T.Inst3l(0x8B, "vsubs", "VSBX", "{0} = {1} - {2}") # i64
# VMPY
# VMPS
# VMPX
# VMPD
# VDIV
# VDVS
# VDVX
# VCMP
# VCPS
# VCPX
# VCMS
# VCMX

# 5.3.2.9. Vector Logical Arithmetic Operation Instructions
T.Logical(0xC4, "vand", "VAND", "{0} = {1} & {2}")
T.Logical(0xC5, "vor",  "VOR",  "{0} = {1} | {2}")
T.Logical(0xC6, "vxor", "VXOR", "{0} = {1} ^ {2}")
T.Logical(0xC7, "veqv", "VEQV", "{0} = ~({1} ^ {2})")
# VLDZ
# VPCNT
# VBRV
# VSEQ

# 5.3.2.10. Vector Shift Instructions
T.Shift(0xE5, "vsll", "VSLL", "{0} = {1} << ({2} & 0x3f)")
T.ShiftPacked(0xE5, "vsll", "VSLL", "{0} = {1} << ({2} & 0x1f)")
T.Shift(0xF5, "vsrl", "VSRL", "{0} = {1} >> ({2} & 0x3f)")
T.ShiftPacked(0xF5, "vsrl", "VSRL", "{0} = {1} >> ({2} & 0x1f)")

# 5.3.2.11. Vector Floating-Point Operation Instructions
T.Inst3f(0xFF, "vfadd", "VFAD", "{0} = {1} + {2}")
T.Inst3f(0xFF, "vfsub", "VFSB", "{0} = {1} - {2}")
T.Inst3f(0xFF, "vfmul", "VFMP", "{0} = {1} * {2}")
T.Inst3f(0xFF, "vfdiv", "VFDV", "{0} = {1} / {2}", False)
# VFSQRT
# VFCP
# VFCM
T.Inst4f(0xFF, "vfmad", "VFMAD", "{0} = {2} * {3} + {1}")
T.Inst4f(0xFF, "vfmsb", "VFMSB", "{0} = {2} * {3} - {1}")
T.Inst4f(0xFF, "vfnmad", "VFNMAD", "{0} =  - ({2} * {3} + {1})")
T.Inst4f(0xFF, "vfnmsb", "VFNMSB", "{0} =  - ({2} * {3} - {1})")
# VRCP
# VRSQRT
# VFIX
# VFIXX
# VFLT
# VFLTX
# VCVD
# VCVS

# 5.3.2.12. Vector Mask Arithmetic Instructions

T.InstX(0xB4, "VFMK", "vfmk", [[VMx, CCOp, VZ(T_i64)]])
T.InstX(0xB4, "VFMS", "vfms", [[VMx, CCOp, VZ(T_i32)]])
T.InstX(0xB6, "VFMF", "vfmf", [[VMx, CCOp, VZ(T_f64)]])
T.InstX(0xB6, "VFMFu", "pvfmfu", [[VMx, CCOp, VZ(T_f32)]])
T.InstX(0xB6, "VFMFl", "pvfmfl", [[VMx, CCOp, VZ(T_f32)]])

# 5.3.2.13. Vector Recursive Relation Instructions
T.InstX(0xEA, "VSUMSsx", "vsumw_sx", [[VX(T_i32), VY(T_i32)]])
T.InstX(0xEA, "VSUMSzx", "vsumw_zx", [[VX(T_i32), VY(T_i32)]])
T.InstX(0xAA, "VSUMX", "vsuml", [[VX(T_i64), VY(T_i64)]])
T.InstX(0xEC, "VFSUMd", "vfsumd", [[VX(T_f64), VY(T_f64)]])
T.InstX(0xEC, "VFSUMs", "vfsums", [[VX(T_f32), VY(T_f32)]])


# 5.3.2.14. Vector Gatering/Scattering Instructions

# 5.3.2.16. Vector Control Instructions

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-i', dest="opt_intrin", action="store_true")
parser.add_argument('-p', dest="opt_pat", action="store_true")
parser.add_argument('-b', dest="opt_builtin", action="store_true")
parser.add_argument('--header', dest="opt_header", action="store_true")
parser.add_argument('--decl', dest="opt_decl", action="store_true")
parser.add_argument('-t', dest="opt_test", action="store_true")
parser.add_argument('-r', dest="opt_reference", action="store_true")
parser.add_argument('-f', dest="opt_filter", action="store")
parser.add_argument('-m', dest="opt_manual", action="store_true")
parser.add_argument('-a', dest="opt_all", action="store_true")
args, others = parser.parse_known_args()


insts = T.insts()

test_dir = "../test/intrinsic/gen/tests"

if args.opt_filter:
    insts = [i for i in insts if re.search(args.opt_filter, i.intrinsicName)]
    print "filter: {} -> {}".format(args.opt_filter, len(insts))

if args.opt_all:
    args.opt_intrin = True
    args.opt_pat = True
    args.opt_builtin = True
    args.opt_header = True
    args.opt_decl = True
    args.opt_reference = True
    args.opt_test = True
    test_dir = None

if args.opt_intrin:
    for i in insts:
        print i.intrinsicDefine()
if args.opt_pat:
    for i in insts:
        print i.intrinsicPattern()
if args.opt_builtin:
    for i in insts:
        print i.builtin()
if args.opt_header:
    for i in insts:
        print i.header()
if args.opt_decl:
    for i in insts:
        if i.hasTest():
            print i.decl()
if args.opt_test:
    gen_test(insts, test_dir)
if args.opt_reference:
    print 'namespace ref {'
    for i in insts:
        if i.hasReference():
            print i.reference()
    print '}'

if args.opt_manual:
    ManualInstPrinter().printAll(insts)

#ManualInstPrinter().printAll(insts) if args.opt_manual else None

