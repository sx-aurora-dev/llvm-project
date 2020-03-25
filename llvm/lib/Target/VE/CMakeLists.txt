set(LLVM_TARGET_DEFINITIONS VE.td)

tablegen(LLVM VEGenAsmMatcher.inc -gen-asm-matcher)
tablegen(LLVM VEGenAsmWriter.inc -gen-asm-writer)
tablegen(LLVM VEGenCallingConv.inc -gen-callingconv)
tablegen(LLVM VEGenDAGISel.inc -gen-dag-isel)
tablegen(LLVM VEGenDisassemblerTables.inc -gen-disassembler)
tablegen(LLVM VEGenInstrInfo.inc -gen-instr-info)
tablegen(LLVM VEGenMCCodeEmitter.inc -gen-emitter)
tablegen(LLVM VEGenRegisterInfo.inc -gen-register-info)
tablegen(LLVM VEGenSubtargetInfo.inc -gen-subtarget)

add_public_tablegen_target(VECommonTableGen)

add_llvm_target(VECodeGen
  CustomDAG.cpp
  LVLGen.cpp
  MaskView.cpp
  VEAsmPrinter.cpp
  VEFrameLowering.cpp
  VEISelDAGToDAG.cpp
  VEISelLowering.cpp
  VEInstrInfo.cpp
  VEMachineFunctionInfo.cpp
  VEMCInstLower.cpp
  VERegisterInfo.cpp
  VESubtarget.cpp
  VETargetMachine.cpp
  )

add_subdirectory(AsmParser)
add_subdirectory(Disassembler)
add_subdirectory(MCTargetDesc)
add_subdirectory(TargetInfo)
