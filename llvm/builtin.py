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
T_v256i64 = Type("v256f64", "V256d",  "long int*", T_i64)
T_v256i32 = Type("v256f64", "V256d",  "int*",  T_i32)

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
        #tmp = "".join([i.ty.builtinCode for i in (self.outs + self.ins)])
        tmp = "".join([i.ty.builtinCode for i in self.outs])
        tmp += "".join([i.ty.builtinCode + "C" for i in self.ins])
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

        args = []
        for op in self.ins:
            if op.isVReg():
                body += indent + "__vr {} = _ve_vld(p{}, {});\n".format(op.name, op.name, stride)
            if op.isReg():
                args.append(op.regName())
            else: # imm
                args.append("3")

        out = self.outs[0]
        body += indent + "__vr {} = _ve_{}({});\n".format(out.name, self.intrinsicName, ', '.join(args))
        body += indent + "_ve_vst({}, {}, {});\n".format(out.formalName(), out.regName(), stride)

        tmp = []
        for op in [i for i in (self.outs + self.ins) if i.isVReg()]:
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

class ManualInstPrinter:
    def __init__(self):
        pass

    def printAll(self, insts):
        for i in insts:
            self.printI(i)

    def printI(self, I):
        outs = []
        v = []

        out = I.outs[0]
        if not out.isVReg():
            raise "output is not VReg"
        v.append(out.regName())

        ins = []
        for op in I.ins:
            v.append(op.regName())
            if op.isVReg():
                ins.append("const __vr " + op.regName())
            elif op.isReg():
                ins.append("{} {}".format(op.ty.ctype, op.regName()))
            elif op.isImm():
                ins.append("{} {}".format(op.ty.ctype, op.regName()))
            else:
                raise "unknown register kind"
        func = "__vr _ve_{}({})".format(I.intrinsicName, ", ".join(ins))
        line = "    {:<80} // {}".format(func, I.expr.format(*v))

        print line


class InstTable:
    def __init__(self):
        self.a = []

    def insts(self):
        return self.a

    def Inst(self, *arg):
        self.a.append(Inst(*arg))

    def Inst3(self, opc, name, instName, df, ex, tyV, tyS, tyI, packed, expr):
        # name.df {%vx|%vix}, {%vy|%vix|%sy|I}, {%vz|%vix}[, %vm]
        self.Inst(opc, name, instName, df, ex, [VX(tyV)], [VY(tyV), VZ(tyV)], "v", packed, expr)   #_vvv
        self.Inst(opc, name, instName, df, ex, [VX(tyV)], [SY(tyS), VZ(tyV)], "r", packed, expr)   #_vsv
        self.Inst(opc, name, instName, df, ex, [VX(tyV)], [I, VZ(tyV)], "i", packed, expr)  #_vIv

    def Inst3f(self, opc, name, instName, expr, hasPacked = True):
        self.Inst3(opc, name, instName, "d", "", T_f64, T_f64, T_i64, False, expr)  # d
        self.Inst3(opc, name, instName, "s", "",  T_f32, T_f32, T_i64, False, expr)  # s
        if hasPacked:
            self.Inst3(opc, name, instName, "",  "", T_f32, T_f32, T_i64, True, expr) # p

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
        filename = "{}/test_{}.c".format(directory, i.intrinsicName)
        cmpwrite(filename, i.test())

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
args, others = parser.parse_known_args()

T = InstTable()

# 5.3.2.7. Vector Transfer Instructions

# 5.3.2.8. Vector Fixed-Point Arithmetic Operation Instructions
T.Inst3u(0xFF, "vaddu", "VADD", "{0} = {1} + {2}")
T.Inst3w(0xFF, "vadds", "VADS", "{0} = {1} + {2}")
# VADX
# VSUB
# VSBS
# VSBX
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
#T.Inst3l(0xFF, "vand", "VAND", "{0} = {1} & {2}")

# 5.3.2.10. Vector Shift Instructions

# 5.3.2.11. Vector Floating-Point Operation Instructions
T.Inst3f(0xFF, "vfadd", "VFAD", "{0} = {1} + {2}")
T.Inst3f(0xFF, "vfsub", "VFSB", "{0} = {1} - {2}")
T.Inst3f(0xFF, "vfmul", "VFMP", "{0} = {1} * {2}")
T.Inst3f(0xFF, "vfdiv", "VFDV", "{0} = {1} / {2}", False)
# VFSQRT
# VFCP
# VFCM
T.Inst4f(0xFF, "vfmad", "VFMAD", "{0} = {2} * {3} + {1}")
# VFMSB
# VFNMAD
# VFNMSB
# VRCP
# VRSQRT
# VFIX
# VFIXX
# VFLT
# VFLTX
# VCVD
# VCVS

# 5.3.2.12. Vector Mask Arithmetic Instructions

# 5.3.2.13. Vector Recursive Relation Instructions

# 5.3.2.14. Vector Gatering/Scattering Instructions

# 5.3.2.16. Vector Control Instructions

insts = T.insts()

test_dir = "../test/intrinsic/tests"

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
if args.opt_decl:
    for i in insts:
        print i.decl()
if args.opt_test:
    gen_test(insts, test_dir)
if args.opt_reference:
    print 'namespace ref {'
    for i in insts:
        print i.reference()
    print '}'

if args.opt_manual:
    ManualInstPrinter().printAll(insts)

#ManualInstPrinter().printAll(insts) if args.opt_manual else None

