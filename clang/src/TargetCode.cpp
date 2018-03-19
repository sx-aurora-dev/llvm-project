#include <sstream>

#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/Format.h"
#include "clang/AST/Stmt.h"
#include "clang/AST/StmtOpenMP.h"
#include "clang/AST/Decl.h"
#include "clang/Basic/SourceLocation.h"
#include "clang/Basic/SourceManager.h"

#include "TargetCode.h"


bool TargetCode::isCodeAlreadyInFragments(TargetCodeFragment *Frag) {
    for (const auto &F : CodeFragments) {
        if (SM.isBeforeInTranslationUnit(F->getRealRange().getBegin(),
                                         Frag->getRealRange().getBegin()) &&
            SM.isBeforeInTranslationUnit(Frag->getRealRange().getEnd(),
                                         F->getRealRange().getEnd())) {
            return true;
        }
    }
    return false;
}


bool TargetCode::addCodeFragment(std::shared_ptr<TargetCodeFragment> Frag) {
    if (isCodeAlreadyInFragments(Frag.get())) {
        return false;
    }
    CodeFragments.push_back(Frag);
    return true;
}


bool TargetCode::addCodeFragmentFront(std::shared_ptr<TargetCodeFragment> Frag) {
    if (isCodeAlreadyInFragments(Frag.get())) {
        return false;
    }
    CodeFragments.push_front(Frag);
    return true;
}

void TargetCode::generateCode(llvm::raw_ostream &Out) {
    for (auto &i : SystemHeaders) {
        std::string Header(i);
        size_t include_pos = Header.rfind("nclude/");
        if (include_pos != std::string::npos) {
            Header.erase(0, include_pos + strlen("nclude/"));
        }
        Out << "#include <" << Header << ">\n";
    }

    for (auto i = CodeFragments.begin(),
              e = CodeFragments.end();
          i != e; ++i) {

        std::shared_ptr<TargetCodeFragment> Frag = *i;
        auto *TCR = llvm::dyn_cast<TargetCodeRegion>(Frag.get());

        if (TCR) {
            generateFunctionPrologue(TCR, Out);
        }

        Out << TargetCodeRewriter.getRewrittenText(Frag->getInnerRange());

        if(Frag->NeedsSemicolon) {
            Out << ";";
        }

        if (TCR) {
            Out << "\n}";
        }
        Out << "\n";
    }
}


void TargetCode::generateFunctionPrologue(TargetCodeRegion *TCR, llvm::raw_ostream &Out) {
    bool first = true;
    Out << "void " << generateFunctionName(TCR) << "(";
    for (auto i = TCR->getCapturedVarsBegin(),
              e = TCR->getCapturedVarsEnd(); i != e; ++i) {
        if (!first) {
            Out << ", ";
        }
        first = false;

        Out << (*i)->getType().getAsString();
        if (!(*i)->getType().getTypePtr()->isPointerType()) {
            Out << "*";
        }
        Out << " "  << (*i)->getDeclName().getAsString();
        // todo: use `Name.print` instead
    }
    Out << ")\n{\n";
}


std::string TargetCode::generateFunctionName(TargetCodeRegion *TCR) {
    //TODO: this function needs error handling
    llvm::sys::fs::UniqueID ID;
    clang::PresumedLoc PLoc = SM.getPresumedLoc(TCR->getTargetDirectiveLocation());
    llvm::sys::fs::getUniqueID(PLoc.getFilename(), ID);
    uint64_t DeviceID = ID.getDevice();
    uint64_t FileID = ID.getFile();
    unsigned LineNum = PLoc.getLine();
    std::string FunctionName;

    llvm::raw_string_ostream fns(FunctionName);
    fns << "__omp_offloading"
        << llvm::format("_%x", DeviceID)
        << llvm::format("_%x_", FileID)
        << TCR->getParentFuncName()
        << "_l" << LineNum;
    return FunctionName;
}
