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
            if self.elemType == T_f64 or self.elemType == T_i64:
                return 8
            else:
                return 4
        raise "not a vector type"

T_f64     = Type("f64",     "d",      "double")
T_f32     = Type("f32",     "f",      "float")
T_i64     = Type("i64",     "Li",     "long int")
T_i32     = Type("i32",     "i",      "int")
T_v256f64 = Type("v256f64", "V256d",  "double*", T_f64)
T_v256f32 = Type("v256f64", "V256d",  "float*",  T_f32)
T_v256i64 = Type("v256f64", "V256Li", "long int*", T_i64)
T_v256i32 = Type("v256f64", "V256i",  "int*",  T_i32)

class Op(object):
    def __init__(self, kind, ty, name):
        self.kind = kind
        self.ty = ty
        self.name = name

    def dagOp(self):
        if self.kind == 'I':
            return "({} simm7:${})".format(self.ty.ValueType, self.name)
        else:
            return "{}:${}".format(self.ty.ValueType, self.name)

    def isImm(self):
        return True if self.kind == 'I' else False
    def isReg(self):
        return True if (self.kind == 'v' or self.kind == 's') else False
    def isVReg(self):
        return True if self.kind == 'v' else False

    def regName(self):
        return self.name

    def formalName(self):
        if self.kind == "v":
            return "p" + self.name
        else:
            return self.name

#class OpV64(Op):
#    def __init__(self, name):
#        super(OpV64, self).__init__("v", T_v256f64, name)

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

def VX(ty):
    return VOp(ty, "vx")
def VY(ty):
    return VOp(ty, "vy")
def VZ(ty):
    return VOp(ty, "vz")
def VW(ty):
    return VOp(ty, "vw")

I = Op("I", T_i64, "sy")


class Inst:
    def __init__(self, opc, name, instName, df, ex, outs, ins, instArgSuffix, packed, expr):
        #self.opc = opc
        self.outs = outs
        self.ins = ins
        self.packed = packed
        self.expr = expr

        self.instName = "{}{}{}{}".format(instName, "p" if packed else df, ex, instArgSuffix)

        intrinsicArgSuffix = "_" + "".join([op.kind for op in (outs + ins)])
        ex0 = "_" + ex if ex != "" else ""
        self.intrinsicName = "{}{}{}{}{}".format("p" if packed else "", name, "" if packed else df, ex0, intrinsicArgSuffix)

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
        tmp = "".join([i.ty.builtinCode for i in (self.outs + self.ins)])
        return "BUILTIN(__builtin_ve_{}, \"{}\", \"n\")".format(self.intrinsicName, tmp)

    # to be included from veintrin.h
    def header(self):
        return "#define _ve_{} __builtin_ve_{}".format(self.intrinsicName, self.intrinsicName)

    def funcHeader(self):
        tmp = [i for i in (self.outs + self.ins) if i.kind != 'I']
        args = ["{} {}".format(i.ty.ctype, i.formalName()) for i in tmp]

        return "void {name}({args}, int n)".format(name=self.intrinsicName, args=", ".join(args))

    def test(self):
        head = self.funcHeader()

        body = ""
        args = []
        for op in self.ins:
            if op.isVReg():
                body += "        __vr {} = _ve_vld(p{}, {});\n".format(op.name, op.name, op.ty.stride())
            if op.isReg():
                args.append(op.regName())
            else: # imm
                args.append("3")

        indent = " " * 8
        out = self.outs[0]
        body += indent + "__vr {} = _ve_{}({});\n".format(out.name, self.intrinsicName, ', '.join(args))
        body += indent + "_ve_vst(p, {}, {});\n".format(out.name, out.ty.stride())

        for op in [i for i in (self.outs + self.ins) if i.ty == T_v256f64]:
            body += indent + "p{} += 256;\n".format(op.name)

        func = '''#include "veintrin.h"
{} {{
    for (int i = 0; i < n; i += 256) {{
        int l = n - i < 256 ? n - i : 256;
        _ve_lvl(l);
{}
    }}
}}'''

        return func.format(head, body)
        
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
        #body = "{:<40} # {}".format(body, self.intrinsicName)

        func = '''{}
{{
    for (int i = 0; i < n; ++i) {{
        {}
    }}
}}'''

        return func.format(head, body);

class InstTable:
    def __init__(self):
        self.a = []

    def insts(self):
        return self.a

    def Inst(self, *arg):
        self.a.append(Inst(*arg))

    def Inst3(self, opc, name, instName, df, ex, tyV, tyS, tyI, packed, expr):
        self.Inst(opc, name, instName, df, ex, [VX(tyV)], [VY(tyV), VZ(tyV)], "v", packed, expr)   #_vvv
        self.Inst(opc, name, instName, df, ex, [VX(tyV)], [SY(tyS), VZ(tyV)], "r", packed, expr)   #_vsv
        self.Inst(opc, name, instName, df, ex, [VX(tyV)], [I, VZ(tyV)], "i", packed, expr)  #_vIv

    def Inst3f(self, opc, name, instName, expr):
        self.Inst3(opc, name, instName, "d", "", T_f64, T_f64, T_i64, False, expr)  # d
        self.Inst3(opc, name, instName, "s", "",  T_f32, T_f32, T_i64, False, expr)  # s
        self.Inst3(opc, name, instName, "",  "", T_f32, T_f32, T_i64, True, expr)  # p

    def Inst3u(self, opc, name, instName, expr):
        self.Inst3(opc, name, instName, "l", "", T_i64, T_i64, T_i64, False, expr)  # l
        self.Inst3(opc, name, instName, "w", "", T_f32, T_f32, T_i64, False, expr)  # w
        self.Inst3(opc, name, instName, "",  "", T_f32, T_f32, T_i64, True, expr)  # p

    def Inst3l(self, opc, name, instName, expr):
        self.Inst3(opc, name, instName, "", "", T_i64, T_i64, T_i64, False, expr)

    def Inst3w(self, opc, name, instName, expr):
        self.Inst3(opc, name, instName, "w", "sx", T_i32, T_i32, T_i64, False, expr)  # w.sx
        self.Inst3(opc, name, instName, "w", "zx", T_i32, T_i32, T_i64, False, expr)  # w.zx
        self.Inst3(opc, name, instName, "", "",    T_i32, T_i32, T_i64, True, expr)  # p

    def Inst4(self, opc, name, instName, df, tyV, tyS, tyI, packed, expr):
        self.Inst(opc, name, instName, df, "", [VX(tyV)], [VY(tyV), VZ(tyV), VW(tyV)], "v", packed, expr)   #_vvvv
        self.Inst(opc, name, instName, df, "", [VX(tyV)], [SY(tyS), VZ(tyV), VW(tyV)], "r", packed, expr)   #_vsvv
        self.Inst(opc, name, instName, df, "", [VX(tyV)], [VY(tyV), SY(tyS), VW(tyV)], "r2", packed, expr)   #_vvsv
        self.Inst(opc, name, instName, df, "", [VX(tyV)], [I, VZ(tyV), VW(tyV)], "i", packed, expr)   #_vivv
        self.Inst(opc, name, instName, df, "", [VX(tyV)], [VY(tyV), I, VW(tyV)], "i2", packed, expr)   #_vviv

    def Inst4f(self, opc, name, instName, expr):
        self.Inst4(opc, name, instName, "d", T_f64, T_f64, T_i64, False, expr)  # d
        self.Inst4(opc, name, instName, "s", T_f32, T_f32, T_i64, False, expr)  # s
        self.Inst4(opc, name, instName, "",  T_f32, T_f32, T_i64, True, expr)  # p

def gen_test(T, directory):
    pass

import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-i', dest="opt_intrin", action="store_true")
parser.add_argument('-p', dest="opt_pat", action="store_true")
parser.add_argument('-b', dest="opt_builtin", action="store_true")
parser.add_argument('--header', dest="opt_header", action="store_true")
parser.add_argument('-t', dest="opt_test", action="store_true")
parser.add_argument('-r', dest="opt_reference", action="store_true")
parser.add_argument('-f', dest="opt_filter", action="store")
args, others = parser.parse_known_args()

T = InstTable()
T.Inst3f(0xFF, "vfadd", "VFAD", "{0} = {1} + {2}")
T.Inst3f(0xFF, "vfsub", "VFSB", "{0} = {1} - {2}")
T.Inst3f(0xFF, "vfmul", "VFMP", "{0} = {1} * {2}")
T.Inst3f(0xFF, "vfdiv", "VFDV", "{0} = {1} / {2}")
T.Inst4f(0xFF, "vfmad", "VFMAD", "{0} = {1} * {2} + {3}")

T.Inst3u(0xFF, "vaddu", "VADD", "{0} = {1} + {2}")
T.Inst3w(0xFF, "vadds", "VADS", "{0} = {1} + {2}")
#T.Inst3l(0xFF, "vand", "VAND", "{0} = {1} & {2}")

insts = T.insts()

if args.opt_filter:
    insts = [i for i in insts if re.search(args.opt_filter, i.intrinsicName)]
    print "filter: {} -> {}".format(args.opt_filter, len(insts))

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
if args.opt_test:
    for i in insts:
        print i.test()
if args.opt_reference:
    print 'namespace ref {'
    for i in insts:
        print i.reference()
    print '}'
