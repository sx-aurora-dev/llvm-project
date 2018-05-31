#! /usr/bin/python

import re
import sys

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

T_v4u64   = Type("v4i64",   "V4ULi",   "unsigned long int*",  T_u64)
T_v8u64   = Type("v8i64",   "V8ULi",   "unsigned long int*",  T_u64)

T_v8u32   = Type("v8i32",   "V8ULi",   "unsigned int*",  T_u32)
T_v16u32  = Type("v16i32",  "V16ULi",  "unsigned int*",  T_u32)

T_void    = Type(None,      None,     "void")
T_v256v64 = Type("v256f64", "V256d",  "void*", T_void)

class Op(object):
    def __init__(self, kind, ty, name):
        self.kind = kind
        self.ty = ty
        self.name_ = name

    def ValueType(self):
        if self.isMask512():
            return "v8i64"
        elif self.isMask256():
            return "v4i64"
        else:
            return self.ty.ValueType

    def builtinCode(self):
        if self.isMask512():
            return "V8ULi"
        elif self.isMask256():
            return "V4ULi"
        else:
            return self.ty.builtinCode

    def dagOp(self):
        if self.kind == 'I':
            return "({} simm7:${})".format(self.ty.ValueType, self.name_)
        elif self.kind == 'N':
            return "({} uimm6:${})".format(self.ty.ValueType, self.name_)
        elif self.kind == 'c':
            return "({} uimm6:${})".format(self.ty.ValueType, self.name_)
        elif self.isMask512():
            return "v8i64:${}".format(self.name_)
        elif self.isMask():
            return "v4i64:${}".format(self.name_)
        else:
            return "{}:${}".format(self.ty.ValueType, self.name_)

    def isImm(self):
        return self.kind == 'I' or self.kind == 'N'
    def isReg(self):
        return self.kind == 'v' or self.kind == 's'
    def isSReg(self):
        return self.kind == 's'
    def isVReg(self):
        return self.kind == 'v'
    def isMask(self):
        return self.kind == 'm' or self.kind == 'M'
    def isMask256(self):
        return self.kind == 'm'
    def isMask512(self):
        return self.kind == 'M'
    def isCC(self):
        return self.kind == 'c'

    def regName(self):
        return self.name_

    def formalName(self):
        if self.isVReg() or self.isMask():
            return "p" + self.name_
        else:
            return self.name_

    def VectorType(self):
        if self.isVReg():
            return "__vr"
        elif self.isMask512():
            return "__vm512"
        elif self.isMask():
            return "__vm"
        raise Exception("not a vector type: {}".format(self.kind))


class SX(Op):
    def __init__(self, ty):
        super(SX, self).__init__("s", ty, "sx")
class SY(Op):
    def __init__(self, ty):
        super(SY, self).__init__("s", ty, "sy")
class SZ(Op):
    def __init__(self, ty):
        super(SZ, self).__init__("s", ty, "sz")

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

VM = Op("m", T_v8u32, "vm")
VM512 = Op("M", T_v16u32, "vm")
VMX = Op("m", T_v8u32, "vmx")
VMY = Op("m", T_v8u32, "vmy")
VMZ = Op("m", T_v8u32, "vmz")
VMD = Op("m", T_v8u32, "vmd")
CCOp = Op("c", T_u32, "cc")

I = Op("I", T_u64, "I")
N = Op("N", T_u64, "sy")

class DummyInst:
    def __init__(self, inst, func, asm):
        self.inst_ = inst
        self.asm_ = asm
        self.func_ = func
    def inst(self):
        return self.inst_
    def asm(self):
        return self.asm_
    def func(self):
        return self.func_
    def isDummy(self):
        return True
    def hasInst(self):
        return self.inst_ != None

class Inst:
    # ni: instruction name
    # nf: function name
    def __init__(self, opc, ni, nf, outs, ins, packed = False, expr = None):
        #self.opc = opc
        self.outs = outs
        self.ins = ins
        self.packed = packed
        self.expr = expr

        self.instName = ni
        self.nf = nf
        self.hasTest_ = True
        self.prop_ = ["IntrNoMem"]
        self.hasBuiltin_ = True

    def noBuiltin(self):
        self.hasBuiltin_ = False

    def isDummy(self):
        return False

    def asm(self):
        if not self.hasInst():
            return ""
        s = self.nf
        s = re.sub(r'_[vm].*', '', s)
        s = re.sub(r'_svs.*', '', s) # LVS
        s = re.sub(r'_', '.', s)
        # temp
        if len(self.outs) > 0 and self.outs[0].isMask512():
            s = ""
        return s

    def inst(self):
        return re.sub(r'[a-z0-9]*', '', self.instName)

    def intrinsicName(self):
        s = re.sub(r'\.', '', self.nf)
        return s

    def hasMask(self):
        if len(self.outs) > 0 and self.outs[0].isMask():
            return False
        for op in self.ins:
            if op.isMask():
                return True
        return False

    def readMem(self):
        self.prop_ = ["IntrReadMem"]
        return self

    def writeMem(self):
        self.prop_ = ["IntrWriteMem"]
        return self

    def prop(self):
        return self.prop_

    def hasInst(self):
        return self.instName != None

    def hasBuiltin(self):
        return self.hasBuiltin_

    # to be included from VEInstrInfo.td
    def intrinsicPattern(self):
        args = ", ".join([op.dagOp() for op in self.ins])
        l = "(int_ve_{} {})".format(self.intrinsicName(), args)
        r = "({} {})".format(self.instName, args)
        return "def : Pat<{}, {}>;".format(l, r)

    # to be included from IntrinsicsVE.td
    def intrinsicDefine(self):
        outs = ", ".join(["LLVMType<{}>".format(op.ValueType()) for op in self.outs])
        ins = ", ".join(["LLVMType<{}>".format(op.ValueType()) for op in self.ins])

        prop = ', '.join(self.prop())
        return "let TargetPrefix = \"ve\" in def int_ve_{} : GCCBuiltin<\"__builtin_ve_{}\">, Intrinsic<[{}], [{}], [{}]>;".format(self.intrinsicName(), self.intrinsicName(), outs, ins, prop)

    # to be included from BuiltinsVE.def
    def builtin(self):
        if len(self.outs) == 0:
            tmp = "v"
        else:
            tmp = "".join([i.builtinCode() for i in self.outs])
        tmp += "".join([i.builtinCode() + "C" for i in self.ins])
        return "BUILTIN(__builtin_ve_{}, \"{}\", \"n\")".format(self.intrinsicName(), tmp)

    # to be included from veintrin.h
    def veintrin(self):
        return "#define _ve_{} __builtin_ve_{}".format(self.intrinsicName(), self.intrinsicName())

    def noTest(self):
        self.hasTest_ = False
        return self

    def hasTest(self):
        return self.hasTest_
        #return not self.outs[0].isMask()

    def stride(self, op):
        if self.packed:
            return 8;
        else:
            return op.ty.stride()

    def hasExpr(self):
        return self.expr != None

class TestFunc:
    def __init__(self, header, definition, ref):
        self.header_ = header
        self.definition_ = definition
        self.ref_ = ref

    def header(self):
        return self.header_

    def definition(self):
        return self.definition_

    def reference(self):
        return self.ref_

    def decl(self):
        return "{};".format(self.header_)

class TestGeneratorMask:
    def test(self, I):
        header = "void {}(unsigned long int* px, unsigned long int const* py, unsigned long int* pz, int n)".format(I.intrinsicName())

        args = ", ".join([op.regName() for op in I.ins])

        func = '''#include <veintrin.h>
{}
{{
    __vm vmx, vmy, vmz;
    for (int i = 0; i < 4; ++i) {{
        vmy = _ve_lvm_mmss(vmy, i, py[i]);
        vmz = _ve_lvm_mmss(vmz, i, pz[i]);
    }}
    vmx = _ve_{}({});
    for (int i = 0; i < 4; ++i)
        px[i] = _ve_svm_sms(vmx, i);
}}
'''.format(header, I.intrinsicName(), args)

        if I.hasExpr():
            args = ["px[i]", "py[i]", "pz[i]"]
            #line = I.expr.format(*[op.regName() for op in I.outs + I.ins])
            line = I.expr.format(*args)
            ref = '''{}
{{
    for (int i = 0; i < 4; ++i)
        {};
}}
'''.format(header, line)
        else:
            ref = None

        return TestFunc(header, func, ref);

class TestGenerator:
    def funcHeader(self, I):
        tmp = [i for i in (I.outs + I.ins) if not i.isImm()]
        args = ["{} {}".format(i.ty.ctype, i.formalName()) for i in tmp]

        return "void {name}({args}, int n)".format(name=I.intrinsicName(), args=", ".join(args))

    def get_vld_vst_inst(self, I, op):
        vld = "vld"
        vst = "vst"
        if not I.packed:
            if op.ty.elemType == T_f32:
                vld = "vldu"
                vst = "vstu"
            elif op.ty.elemType == T_i32 or op.ty.elemType == T_u32:
                vld = "vldl"
                vst = "vstl"
        return [vld, vst]

    def test(self, I):
        head = self.funcHeader(I)
    
        out = I.outs[0]
        body = ""
        indent = " " * 8
    
        #print(I.instName)
    
        if I.packed:
            #stride = 8
            step = 512
            body += indent + "int l = n - i < 512 ? (n - i) / 2UL : 256;\n"
        else:
            #stride = I.outs[0].ty.stride()
            step = 256
            body += indent + "int l = n - i < 256 ? n - i : 256;\n"
    
        body += indent + "_ve_lvl(l);\n"
    
        cond = "CC_G"
    
        if I.hasMask():
            I.ins.pop(-1)
    
        # input
        args = []
        for op in I.ins:
            if op.isVReg():
                stride = I.stride(op)
                vld, vst = self.get_vld_vst_inst(I, op)
                body += indent + "__vr {} = _ve_{}(p{}, {});\n".format(op.regName(), vld, op.regName(), stride)
            if op.isMask512():
                stride = I.stride(op)
                vld, vst = self.get_vld_vst_inst(I, op)
                body += indent + "__vr {}0 = _ve_{}(p{}, {});\n".format(op.regName(), vld, op.regName(), stride)
                body += indent + "__vm512 {} = _ve_pvfmkw_Mcv({}, {}0);\n".format(op.regName(), cond, op.regName())
            elif op.isMask():
                stride = I.stride(op)
                vld, vst = self.get_vld_vst_inst(I, op)
                body += indent + "__vr {}0 = _ve_{}(p{}, {});\n".format(op.regName(), vld, op.regName(), stride)
                body += indent + "__vm {} = _ve_vfmkw_mcv({}, {}0);\n".format(op.regName(), cond, op.regName())
            if op.isReg() or op.isMask():
                args.append(op.regName())
            elif op.isImm():
                args.append("3")
            elif op.isCC():
                args.append(op.name)
    
        if I.hasMask():
            op = I.outs[0]
            vld, vst = self.get_vld_vst_inst(I, op)
            stride = I.stride(op)
            body += indent + "__vr {} = _ve_{}(p{}, {});\n".format(op.regName(), vld, op.regName(), stride)
            body += indent + "{} = _ve_{}({});\n".format(out.regName(), I.intrinsicName(), ', '.join(args + [op.regName()]))
        else:
            body += indent + "__vr {} = _ve_{}({});\n".format(out.regName(), I.intrinsicName(), ', '.join(args))
    
        if out.isVReg():
            stride = I.stride(out)
            vld, vst = self.get_vld_vst_inst(I, out)
            body += indent + "_ve_{}({}, {}, {});\n".format(vst, out.formalName(), out.regName(), stride)
    
        tmp = []
        for op in (I.outs + I.ins):
            if op.isVReg() or op.isMask():
                tmp.append(indent + "p{} += {};".format(op.regName(), "512" if I.packed else "256"))
    
        body += "\n".join(tmp)
    
        func = '''#include "veintrin.h"
{} {{
    for (int i = 0; i < n; i += {}) {{
{}
    }}
}}
'''
        return func.format(head, step, body)
        
    def reference(self, I):
        head = self.funcHeader(I)

        tmp = []
        for op in I.outs + I.ins:
            if op.isVReg():
                tmp.append("p{}[i]".format(op.regName()))
            elif op.isReg():
                tmp.append(op.regName())
            elif op.isImm():
                tmp.append("3")

        body = I.expr.format(*tmp) + ";"

        preprocess = ''
        for op in I.ins:
            if op.isSReg():
                if I.packed:
                    ctype = I.outs[0].ty.elemType.ctype
                    preprocess = '{} sy0 = *({}*)&sy;'.format(ctype, ctype)
                    body = re.sub('sy', "sy0", body)

        if I.hasMask():
            body = "if (pvm[i] > 0) {{ {} }}".format(body)

        func = '''{}
{{
    {}
    for (int i = 0; i < n; ++i) {{
        {}
    }}
}}'''

        return func.format(head, preprocess, body);

    def decl(self, I):
        head = self.funcHeader(I)
        return "extern {};".format(head)

class ManualInstPrinter:
    def __init__(self):
        pass

    def printAll(self, insts):
        for i in insts:
            self.printI(i)

    def make(self, I):
        v = []

        outType = None
        if len(I.outs) > 0:
            out = I.outs[0]
            if out.isVReg():
                outType = "__vr"
                v.append("{}[:]".format(out.regName()))
            elif out.isMask512():
                outType = "__vm512"
            elif out.isMask():
                outType = "__vm256"
                v.append("{}[:]".format(out.regName()))
            elif out.isSReg():
                outType = "unsigned long int" # ok?
            else:
                raise Exception("unknown output operand type: {}".format(out.kind))
                #v.append(out.regName())

        ins = []
        for op in I.ins:
            if op.isVReg():
                ins.append("__vr " + op.regName())
                v.append("{}[:]".format(op.regName()))
            elif op.isSReg():
                ins.append("{} {}".format(op.ty.ctype, op.regName()))
                v.append("{}".format(op.regName()))
            elif op.isMask512():
                ins.append("__vm512 {}".format(op.regName()))
                v.append("{}[:]".format(op.regName()))
            elif op.isMask():
                ins.append("__vm256 {}".format(op.regName()))
                v.append("{}[:]".format(op.regName()))
            elif op.isImm():
                ins.append("{} {}".format(op.ty.ctype, op.regName()))
                v.append("{}".format(op.regName()))
            #elif op.isMask():
            #    ins.append("{} {}".format(op.ty.ctype, op.regName()))
            #    v.append("{}".format(op.regName()))
            elif op.isCC():
                ins.append("int cc".format(op.ty.ctype))
            else:
                raise Exception("unknown register kind: {}".format(op.kind))

        if outType:
            func = "{} _ve_{}({})".format(outType, I.intrinsicName(), ", ".join(ins))
        else:
            func = "_ve_{}({})".format(I.intrinsicName(), ", ".join(ins))

        if I.hasExpr():
            if I.hasMask():
                expr = I.expr.format(*v)
                expr = re.sub(r'.*= ', '', expr)
                expr = "{} = {} ? {} : {}".format(v[0], v[-2], expr, v[-1])
            else:
                expr = I.expr.format(*v)
        else:
            expr = ""
        return [func, expr]

    def printI(self, I):
        if not I.hasExpr():
            return

        func, expr = self.make(I)
        line = "    {:<80} // {}".format(func, expr)
        print line

class HtmlManualPrinter(ManualInstPrinter):
    def printAll(self, T):
        for s in T.sections:
            rowspan = {}
            tmp = []
            for I in s.instsWithDummy():
                if I.isDummy():
                    func = I.func()
                    expr = ""
                else:
                    func, expr = self.make(I)
                inst = I.inst() if I.hasInst() else ""
                if inst in rowspan:
                    rowspan[inst] += 1
                else:
                    rowspan[inst] = 1
                tmp.append([inst, func, I.asm(), expr])

            #sys.stderr.write("{}\n".format(s.name))
            #for k, v in rowspan.items():
            #    sys.stderr.write("{} {}\n".format(k, v))

            print("<h3>{}</h3>".format(s.name))
            print("<table border=1>")
            print("<tr><th>Instruction</th><th>Function</th><th>asm</th><th>Description</th></tr>")
            row = 0
            for a in tmp:
                inst = a.pop(0)
                print("<tr>")
                if row == 0:
                    row = rowspan[inst]
                    print("<td rowspan={}>{}</td>".format(row, inst))
                row -= 1
                print("<td>{}</td><td>{}</td><td>{}</td></tr>".format(*a))
            print("</table>")

class InstList:
    def __init__(self):
        self.a = []
    def add(self, I):
        self.a.append(I)
    def noTest(self):
        for I in self.a:
            I.noTest()
        return self
    def noBuiltin(self):
        for I in self.a:
            I.noBuiltin()
        return self
    def readMem(self):
        for I in self.a:
            I.readMem()
        return self
    def writeMem(self):
        for I in self.a:
            I.writeMem()
        return self

class Section:
    def __init__(self, name):
        self.name = name
        self.a = []
    def add(self, i):
        self.a.append(i)
    def insts(self):
        return [i for i in self.a if not i.isDummy()]
    def instsWithDummy(self):
        return self.a

class InstTable:
    def __init__(self):
        self.currentSection = []
        self.sections = []
        #self.a = []

    def Section(self, name):
        s = Section(name)
        self.sections.append(s)
        self.currentSection = s

    def insts(self):
        a = []
        for s in self.sections:
            a.extend(s.insts())
        return a

    def add(self, inst):
        self.currentSection.add(inst)

    def VBRDm(self, opc, name, instName, packed = False):
        self.add(Inst(opc, "VBRDr", "vbrd_vs_f64", [VX(T_f64)], [SY(T_f64)], False, "{0} = {1}"))
        self.add(Inst(opc, "VBRDr", "vbrd_vs_i64", [VX(T_i64)], [SY(T_i64)], False, "{0} = {1}"))
        self.add(Inst(opc, "VBRDi", "vbrd_vI", [VX(T_i64)], [I], False, "{0} = {1}"))

        self.add(Inst(opc, "VBRDur", "vbrdu_vs", [VX(T_f32)], [SY(T_f32)], False, "{0} = {1}"))
        self.add(Inst(opc, "VBRDlr", "vbrdl_vs", [VX(T_i32)], [SY(T_i32)], False, "{0} = {1}"))
        self.add(Inst(opc, "VBRDli", "vbrdl_vI", [VX(T_i32)], [I], False, "{0} = {1}"))

        self.add(Inst(opc, "VBRDpr", "pvbrd_vs", [VX(T_u32)], [SY(T_u64)], True, "{0} = {1}"))

    def LVSm(self, opc):
        self.add(Inst(opc, "LVSr", "lvs_svs_u64", [SX(T_u64)], [VX(T_u64), SY(T_u32)]).noTest())
        self.add(Inst(opc, "LVSr", "lvs_svs_f64", [SX(T_f64)], [VX(T_u64), SY(T_u32)]).noTest())
        self.add(Inst(opc, "LVSr", "lvs_svs_f32", [SX(T_f32)], [VX(T_u64), SY(T_u32)]).noTest())


    def args_to_func_suffix(self, args):
        return "_" + "".join([op.kind for op in args])

    def args_to_inst_suffix(self, args):
        tbl = {
               "v"    : "v",
               "vv"   : "v",
               "vvv"  : "v",
               "vvvmv": "vm",
               "vvvMv": "vm",
               "vvs"  : "r",
               "vvss" : "r", # LSV
               "svs"  : "r", # LVS
               "vvN"  : "i",
               "vsv"  : "r",
               "vsvmv": "rm",
               "vsvMv": "rm",
               "vIv"  : "i",
               "vIvmv": "im",
               "vvvv" : "v",
               "vsvv" : "r",
               "vvsv" : "r2",
               "vIvv" : "i",
               "vvIv" : "i2",
               "vvvvmv" : "v",
               "vsvvmv" : "r",
               "vvsvmv" : "r2",
               "vIvvmv" : "i",
               "vvIvmv" : "i2",
               "mmm" : "",
               "mm" : "",
               "sms" : "",
               "mmss" : "",

               "mcv"  : "v",
               "Mcv"  : "v",
               "vvIs" : "i", # VSFA
               }

        tmp = "".join([op.kind for op in args])
        return tbl[tmp]

    def Dummy(self, inst, func, asm):
        self.add(DummyInst(inst, func, asm))

    def NoImpl(self, inst):
        self.add(DummyInst(inst, "not yet implemented", ""))

    def InstX(self, opc, ni, nf, ary, expr = None):
        IL = InstList()
        #print("InstX: ni={} nf={}".format(ni, nf))
        for args in ary:
            ni0 = nf0 = None
            if ni:
                ni0 = ni + self.args_to_inst_suffix(args)
            if nf:
                nf0 = nf + self.args_to_func_suffix(args)
            outs = [args[0]]
            ins = args[1:]
            i = Inst(opc, ni0, nf0, outs, ins, nf[0] == 'p', expr)
            self.add(i)
            IL.add(i)
        return IL

    # RCP
    def Inst2f(self, opc, name, instName, expr, hasPacked = True):
        self.InstX(opc, instName+"d", name+".d", [[VX(T_f64), VY(T_f64)]], expr)
        self.InstX(opc, instName+"s", name+".s", [[VX(T_f32), VY(T_f32)]], expr)
        if hasPacked:
            self.InstX(opc, instName+"p", "p"+name, [[VX(T_f32), VY(T_f32)]], expr) 

    def Inst3f(self, opc, name, instName, expr, hasPacked = True):
        O_f64_vvv = [VX(T_f64), VY(T_f64), VZ(T_f64)]
        O_f64_vsv = [VX(T_f64), SY(T_f64), VZ(T_f64)]
        O_f32_vvv = [VX(T_f32), VY(T_f32), VZ(T_f32)]
        O_f32_vsv = [VX(T_f32), SY(T_f32), VZ(T_f32)]
        O_pf32_vsv = [VX(T_f32), SY(T_u64), VZ(T_f32)]

        O_f64 = [O_f64_vvv, O_f64_vsv]
        O_f32 = [O_f32_vvv, O_f32_vsv]
        O_pf32 = [O_f32_vvv, O_pf32_vsv]

        O_f64 = self.addMask(O_f64)
        O_f32 = self.addMask(O_f32)
        O_pf32 = self.addMask(O_pf32, VM512)

        self.InstX(opc, instName+"d", name+".d", O_f64, expr)
        self.InstX(opc, instName+"s", name+".s", O_f32, expr)
        if hasPacked:
            self.InstX(opc, instName+"p", "p"+name, O_pf32, expr) 

    def addMask(self, ary, MaskOp = VM):
        tmp = []
        for a in ary:
            tmp.append(a + [MaskOp, VD(a[0].ty.elemType)])
        return ary + tmp

    # 3 operands, u64/u32
    def Inst3u(self, opc, name, instName, expr, hasPacked = True):
        O_u64_vvv = [VX(T_u64), VY(T_u64), VZ(T_u64)]
        O_u64_vsv = [VX(T_u64), SY(T_u64), VZ(T_u64)]
        O_u64_vIv = [VX(T_u64), I, VZ(T_u64)]

        O_u32_vvv = [VX(T_u32), VY(T_u32), VZ(T_u32)]
        O_u32_vsv = [VX(T_u32), SY(T_u32), VZ(T_u32)]
        O_u32_vIv = [VX(T_u32), I, VZ(T_u32)]

        O_pu32_vsv = [VX(T_u32), SY(T_u64), VZ(T_u32)]

        O_u64 = [O_u64_vvv, O_u64_vsv, O_u64_vIv]
        O_u32 = [O_u32_vvv, O_u32_vsv, O_u32_vIv]
        O_pu32 = [O_u32_vvv, O_pu32_vsv]

        O_u64 = self.addMask(O_u64)
        O_u32 = self.addMask(O_u32)
        O_pu32 = self.addMask(O_pu32, VM512)

        self.InstX(opc, instName+"l", name+".l", O_u64, expr)
        self.InstX(opc, instName+"w", name+".w", O_u32, expr)
        if hasPacked:
            self.InstX(opc, instName+"p", "p"+name, O_pu32, expr)

    # 3 operands, i64
    def Inst3l(self, opc, name, instName, expr):
        O_i64_vvv = [VX(T_i64), VY(T_i64), VZ(T_i64)]
        O_i64_vsv = [VX(T_i64), SY(T_i64), VZ(T_i64)]
        O_i64_vIv = [VX(T_i64), I, VZ(T_i64)]

        self.InstX(opc, instName+"l", name+".l", [O_i64_vvv, O_i64_vsv, O_i64_vIv], expr)

    # 3 operands, i32
    def Inst3w(self, opc, name, instName, expr, hasPacked = True):
        O_i32_vvv = [VX(T_i32), VY(T_i32), VZ(T_i32)]
        O_i32_vsv = [VX(T_i32), SY(T_i32), VZ(T_i32)]
        O_i32_vIv = [VX(T_i32), I, VZ(T_i32)]
        O_pi32_vsv = [VX(T_i32), SY(T_u64), VZ(T_i32)]

        O_i32 = [O_i32_vvv, O_i32_vsv, O_i32_vIv]
        O_i32 = self.addMask(O_i32)

        O_pi32 = [O_i32_vvv, O_pi32_vsv]
        O_pi32 = self.addMask(O_pi32, VM512)

        self.InstX(opc, instName+"wsx", name+".w_sx", O_i32, expr)
        self.InstX(opc, instName+"wzx", name+".w_zx", O_i32, expr)
        if hasPacked:
            self.InstX(opc, instName+"p", "p"+name, O_pi32, expr)

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
        O_u32_vvs = [VX(T_u32), VZ(T_u32), SY(T_u64)]

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

        O_f64 = [O_f64_vvvv, O_f64_vsvv, O_f64_vvsv]
        O_f32 = [O_f32_vvvv, O_f32_vsvv, O_f32_vvsv]
        O_pf32 = [O_f32_vvvv, O_pf32_vsvv, O_pf32_vvsv]

        #O_f64 = self.addMask(O_f64)
        #O_f32 = self.addMask(O_f32)
        #O_pf32 = self.addMask(O_pf32)

        self.InstX(opc, instName+"d", name+".d", O_f64, expr)
        self.InstX(opc, instName+"s", name+".s", O_f32, expr)
        self.InstX(opc, instName+"p", "p"+name, O_pf32, expr)


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
    g = TestGenerator()
    for i in insts:
        if len(i.outs) > 0 and i.outs[0].isMask() and i.hasTest():
            f = TestGeneratorMask().test(i)
            #print f.definition()
            filename = "{}/{}.c".format(directory, i.intrinsicName())
            cmpwrite(filename, f.definition())
            continue

        if i.hasTest():
            if directory:
                filename = "{}/{}.c".format(directory, i.intrinsicName())
                cmpwrite(filename, g.test(i))
            else:
                print i.test()


T = InstTable()

T.Section("5.3.2.7. Vector Transfer Instructions")
T.Dummy("VLD", "__vr _ve_vld(void* sz, int sy)", "vld")
T.Dummy("VLDU", "__vr _ve_vldu(void* sz, int sy)", "vldu")
T.Dummy("VLDL", "__vr _ve_vldl(void* sz, int sy)", "vldl")
T.NoImpl("VLD2D")
T.NoImpl("VLDU2D")
T.NoImpl("VLDL2D")
T.Dummy("VST", "void _ve_vst(void* sz, __vr vx, int sy)", "vst")
T.Dummy("VSTU", "void _ve_vstu(void* sz, __vr vx, int sy)", "vstu")
T.Dummy("VSTL", "void _ve_vstl(void* sz, __vr vx, int sy)", "vstl")
T.NoImpl("VST2D")
T.NoImpl("VSTU2D")
T.NoImpl("VSTL2D")
T.NoImpl("PFCHV")
T.InstX(0x8E, "LSV", "lsv", [[VX(T_u64), VX(T_u64), SY(T_u32), SZ(T_u64)]]).noTest()
#T.InstX(0x9E, "LVS", "lvs", [[SX(T_u64), VX(T_u64), SY(T_u32)]]).noTest()
T.LVSm(0x9E)
T.InstX(0xB7, "LVM", "lvm", [[VMX, VMD, SY(T_u64), SZ(T_u64)]]).noTest()
T.InstX(0xA7, "SVM", "svm", [[SX(T_u64), VMY, SZ(T_u64)]]).noTest()
T.VBRDm(0x8C, "vbrd", "VBRD")
T.InstX(0x9C, "VMV", "vmv", [[VX(T_u64), SY(T_u32), VZ(T_u64)]]).noTest()
T.InstX(0x9C, "VMV", "vmv", [[VX(T_u64), I, VZ(T_u64)]]).noTest()

O_VMPD = [[VX(T_i64), VY(T_i32), VZ(T_i32)], 
          [VX(T_i64), SY(T_i32), VZ(T_i32)], 
          [VX(T_i64), I, VZ(T_i32)]]

T.Section("5.3.2.8. Vector Fixed-Point Arithmetic Operation Instructions")
T.Inst3u(0xC8, "vaddu", "VADD", "{0} = {1} + {2}") # u32, u64
T.Inst3w(0xCA, "vadds", "VADS", "{0} = {1} + {2}") # i32
T.Inst3l(0x8B, "vadds", "VADX", "{0} = {1} + {2}") # i64
T.Inst3u(0xC8, "vsubu", "VSUB", "{0} = {1} - {2}") # u32, u64
T.Inst3w(0xCA, "vsubs", "VSBS", "{0} = {1} - {2}") # i32
T.Inst3l(0x8B, "vsubs", "VSBX", "{0} = {1} - {2}") # i64
T.Inst3u(0xC9, "vmulu", "VMPY", "{0} = {1} * {2}", False)
T.Inst3w(0xCB, "vmuls", "VMPS", "{0} = {1} * {2}", False)
T.Inst3l(0xDB, "vmuls", "VMPX", "{0} = {1} * {2}")
T.InstX(0xD9, "VMPD", "vmuls.l.w", O_VMPD, "{0} = {1} * {2}")
T.NoImpl("VDIV")
T.NoImpl("VDVS")
T.NoImpl("VDVX")
T.NoImpl("VCMP")
T.NoImpl("VCPS")
T.NoImpl("VCPX")
T.NoImpl("VCMS")
T.NoImpl("VCMX")

T.Section("5.3.2.9. Vector Logical Arithmetic Operation Instructions")
T.Logical(0xC4, "vand", "VAND", "{0} = {1} & {2}")
T.Logical(0xC5, "vor",  "VOR",  "{0} = {1} | {2}")
T.Logical(0xC6, "vxor", "VXOR", "{0} = {1} ^ {2}")
T.Logical(0xC7, "veqv", "VEQV", "{0} = ~({1} ^ {2})")
T.NoImpl("VLDZ")
T.NoImpl("VPCNT")
T.NoImpl("VBRV")
T.InstX(0x99, "VSEQ", "vseq", [[VX(T_u64)]], "{0} = i").noTest()
T.InstX(0x99, "VSEQl", "pvseq.lo", [[VX(T_u64)]], "{0} = i").noTest()
T.InstX(0x99, "VSEQu", "pvseq.up", [[VX(T_u64)]], "{0} = i").noTest()
T.InstX(0x99, "VSEQp", "pvseq", [[VX(T_u64)]], "{0} = i").noTest()

T.Section("5.3.2.10. Vector Shift Instructions")
T.Shift(0xE5, "vsll", "VSLL", "{0} = {1} << ({2} & 0x3f)")
T.ShiftPacked(0xE5, "vsll", "VSLL", "{0} = {1} << ({2} & 0x1f)")
T.NoImpl("VSLD")
T.Shift(0xF5, "vsrl", "VSRL", "{0} = {1} >> ({2} & 0x3f)")
T.ShiftPacked(0xF5, "vsrl", "VSRL", "{0} = {1} >> ({2} & 0x1f)")
T.NoImpl("VSRD")
T.NoImpl("VSLA")
T.NoImpl("VSLAX")
T.NoImpl("VSRA")
T.NoImpl("VSRAX")
T.InstX(0xD7, "VSFA", "vsfa", [[VX(T_u64), VZ(T_u64), SY(T_u64), SZ(T_u64)],[VX(T_u64), VZ(T_u64), I, SZ(T_u64)]], "{0} = ({1} << ({2} & 0x7)) + {3}")

T.Section("5.3.2.11. Vector Floating-Point Operation Instructions")
T.Inst3f(0xCC, "vfadd", "VFAD", "{0} = {1} + {2}")
T.Inst3f(0xDC, "vfsub", "VFSB", "{0} = {1} - {2}")
T.Inst3f(0xCD, "vfmul", "VFMP", "{0} = {1} * {2}")
T.Inst3f(0xDD, "vfdiv", "VFDV", "{0} = {1} / {2}", False)
T.InstX(None, None, "vfdivsA", [[VX(T_f32), SY(T_f32), VZ(T_f32)]], "{0} = {1} / {2}")
T.NoImpl("VFSQRT")
T.NoImpl("VFCP")
T.NoImpl("VFCM")
T.Inst4f(0xFF, "vfmad", "VFMAD", "{0} = {2} * {3} + {1}")
T.Inst4f(0xFF, "vfmsb", "VFMSB", "{0} = {2} * {3} - {1}")
T.Inst4f(0xFF, "vfnmad", "VFNMAD", "{0} =  - ({2} * {3} + {1})")
T.Inst4f(0xFF, "vfnmsb", "VFNMSB", "{0} =  - ({2} * {3} - {1})")
T.Inst2f(0xE1, "vrcp", "VRCP", "{0} = 1.0f / {1}")
T.NoImpl("VRSQRT")
T.NoImpl("VFIX")
T.NoImpl("VFIXX")
T.NoImpl("VFLT")
T.NoImpl("VFLTX")
T.NoImpl("VCVD")
T.NoImpl("VCVS")

T.Section("5.3.2.12. Vector Mask Arithmetic Instructions")
T.NoImpl("VMGR")
T.NoImpl("VSHF")
T.NoImpl("VCP")
T.NoImpl("VEX")
T.InstX(0xB4, "VFMK", "vfmk.l", [[VM, CCOp, VZ(T_i64)]]).noTest()
T.InstX(0xB5, "VFMS", "vfmk.w", [[VM, CCOp, VZ(T_i32)]]).noTest()
T.InstX(0x00, "VFMSp", "pvfmk.w", [[VM512, CCOp, VZ(T_i32)]]).noTest() # Pseudo
T.InstX(0xB6, "VFMFd", "vfmk.d", [[VM, CCOp, VZ(T_f64)]]).noTest()
T.InstX(0xB6, "VFMFs", "vfmk.s", [[VM, CCOp, VZ(T_f32)]]).noTest()
#T.InstX(0x00, "VFMFp", "pvfmk.s", [[VM, CCOp, VZ(T_f32)]]).noTest() # Pseudo
#T.InstX(0xB6, "VFMFu", "pvfmk.s.up", [[VM, CCOp, VZ(T_f32)]]).noTest()
#T.InstX(0xB6, "VFMFl", "pvfmk.s.lo", [[VM, CCOp, VZ(T_f32)]]).noTest()

T.Section("5.3.2.13. Vector Recursive Relation Instructions")
T.InstX(0xEA, "VSUMSsx", "vsumw_sx", [[VX(T_i32), VY(T_i32)]])
T.InstX(0xEA, "VSUMSzx", "vsumw_zx", [[VX(T_i32), VY(T_i32)]])
T.InstX(0xAA, "VSUMX", "vsuml", [[VX(T_i64), VY(T_i64)]])
T.InstX(0xEC, "VFSUMd", "vfsumd", [[VX(T_f64), VY(T_f64)]])
T.InstX(0xEC, "VFSUMs", "vfsums", [[VX(T_f32), VY(T_f32)]])
T.NoImpl("...")

O_u64_vv = [VX(T_u64), VY(T_u64)]
O_f32_vv = [VX(T_f32), VY(T_f32)]
O_i32_vv = [VX(T_i32), VY(T_i32)]

T.Section("5.3.2.14. Vector Gatering/Scattering Instructions")
T.InstX(0xA1, "VGT", "vgt", [[VX(T_u64), VY(T_u64)]], "{0} = *{1}").noTest().readMem()
T.InstX(0xA2, "VGTU", "vgtu", [[VX(T_f32), VY(T_f32)]], "{0} = *{1}").noTest().readMem()
T.InstX(0xA3, "VGTLsx", "vgtl_sx", [[VX(T_i32), VY(T_i32)]], "{0} = *{1}").noTest().readMem()
T.InstX(0xA3, "VGTLzx", "vgtl_zx", [[VX(T_i32), VY(T_i32)]], "{0} = *{1}").noTest().readMem()
T.add(Inst(0xB1, "VSCv", "vsc_vv", [], O_u64_vv, False, "*{1} = {0}").noTest().writeMem())
T.add(Inst(0xB2, "VSCUv", "vscu_vv", [], O_f32_vv, False, "*{1} = {0}").noTest().writeMem())
T.add(Inst(0xB2, "VSCLv", "vscl_vv", [], O_i32_vv, False, "*{1} = {0}").noTest().writeMem())

T.Section("5.3.2.15. Vector Mask Register Instructions")
T.InstX(0x84, "ANDM", "andm", [[VMX, VMY, VMZ]], "{0} = {1} & {2}")
T.InstX(0x85, "ORM",  "orm",  [[VMX, VMY, VMZ]], "{0} = {1} | {2}")
T.InstX(0x86, "XORM", "xorm", [[VMX, VMY, VMZ]], "{0} = {1} ^ {2}")
T.InstX(0x87, "EQVM", "eqvm", [[VMX, VMY, VMZ]], "{0} = ~({1} ^ {2})")
T.InstX(0x94, "NNDM", "nndm", [[VMX, VMY, VMZ]], "{0} = (~{1}) & {2}")
T.InstX(0x95, "NEGM", "negm", [[VMX, VMY]], "{0} = ~{1}")
T.NoImpl("PCVM")
T.NoImpl("LZVM")
T.NoImpl("TOVM")

T.Section("5.3.2.16. Vector Control Instructions")
T.Dummy("LVL", "void _ve_lvl(int vl)", "lvl")
T.NoImpl("SVL")
T.NoImpl("SVML")
T.NoImpl("LVIX")

T.Section("Others")
T.Dummy("", "unsigned long int _ve_pack_f32p(float const* p0, float const* p1)", "ldu,ldl,or")
T.Dummy("", "unsigned long int _ve_pack_f32a(float const* p)", "load and pack")

T.InstX(None, None, "vec_expf", [[VX(T_f32), VY(T_f32)]], "{0} = expf({1})").noBuiltin()
#T.Dummy("", "__vr _ve_vec_expf(__vr vy)", "{0} = expf({1})")
#T.Dummy("", "__vr _ve_vfdivs_vsva(float sy, __vr vy)", "")
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-i', dest="opt_intrin", action="store_true")
parser.add_argument('-p', dest="opt_pat", action="store_true")
parser.add_argument('-b', dest="opt_builtin", action="store_true")
parser.add_argument('--veintrin', dest="opt_veintrin", action="store_true")
parser.add_argument('--decl', dest="opt_decl", action="store_true")
parser.add_argument('-t', dest="opt_test", action="store_true")
parser.add_argument('-r', dest="opt_reference", action="store_true")
parser.add_argument('-f', dest="opt_filter", action="store")
parser.add_argument('-m', dest="opt_manual", action="store_true")
parser.add_argument('-a', dest="opt_all", action="store_true")
parser.add_argument('--html', dest="opt_html", action="store_true")
args, others = parser.parse_known_args()


insts = T.insts()

test_dir = "../test/intrinsic/gen/tests"

if args.opt_filter:
    insts = [i for i in insts if re.search(args.opt_filter, i.intrinsicName())]
    print "filter: {} -> {}".format(args.opt_filter, len(insts))

if args.opt_all:
    args.opt_intrin = True
    args.opt_pat = True
    args.opt_builtin = True
    args.opt_veintrin = True
    args.opt_decl = True
    args.opt_reference = True
    args.opt_test = True
    test_dir = None

if args.opt_intrin:
    for i in insts:
        print i.intrinsicDefine()
if args.opt_pat:
    for i in insts:
        if i.hasInst():
            print i.intrinsicPattern()
if args.opt_builtin:
    for i in insts:
        if i.hasBuiltin():
            print i.builtin()
if args.opt_veintrin:
    for i in insts:
        if i.hasBuiltin():
            print i.veintrin()
if args.opt_decl:
    for i in insts:
        if i.hasTest():
            if len(i.outs) > 0 and i.outs[0].isMask():
                print TestGeneratorMask().test(i).decl()
                continue
            print TestGenerator().decl(i)
if args.opt_test:
    gen_test(insts, test_dir)
if args.opt_reference:
    print '#include <math.h>'
    print 'namespace ref {'
    for i in insts:
        if len(i.outs) > 0 and i.outs[0].isMask() and i.hasExpr():
            f = TestGeneratorMask().test(i)
            print f.reference()
            continue
        if i.hasTest() and i.hasExpr():
            print TestGenerator().reference(i)
    print '}'
if args.opt_html:
    HtmlManualPrinter().printAll(T)

if args.opt_manual:
    ManualInstPrinter().printAll(insts)

#ManualInstPrinter().printAll(insts) if args.opt_manual else None

