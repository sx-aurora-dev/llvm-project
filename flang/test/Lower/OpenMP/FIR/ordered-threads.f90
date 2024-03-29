! This test checks lowering of OpenMP ordered directive with threads Clause.
! Without clause in ordered direcitve, it behaves as if threads clause is
! specified.

!RUN: %flang_fc1 -emit-fir -flang-deprecated-no-hlfir -fopenmp %s -o - | FileCheck %s --check-prefix=FIRDialect
!RUN: %flang_fc1 -emit-fir -flang-deprecated-no-hlfir -fopenmp %s -o - | fir-opt --fir-to-llvm-ir | FileCheck %s --check-prefix=LLVMIRDialect
!RUN: %flang_fc1 -emit-fir -flang-deprecated-no-hlfir -fopenmp %s -o - | fir-opt --fir-to-llvm-ir | tco | FileCheck %s --check-prefix=LLVMIR

subroutine ordered
        integer :: i
        integer :: a(20)

!FIRDialect: omp.ordered.region  {
!LLVMIRDialect: omp.ordered.region  {
!LLVMIR: [[TMP0:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB0:[0-9]+]])
!LLVMIR-NEXT: call void @__kmpc_ordered(ptr @[[GLOB0]], i32 [[TMP0]])
!$OMP ORDERED
        a(i) = a(i-1) + 1
!FIRDialect:   omp.terminator
!FIRDialect-NEXT: }
!LLVMIRDialect:   omp.terminator
!LLVMIRDialect-NEXT: }
!LLVMIR: call void @__kmpc_end_ordered(ptr @[[GLOB0]], i32 [[TMP0]])
!$OMP END ORDERED

!FIRDialect: omp.ordered.region  {
!LLVMIRDialect: omp.ordered.region  {
!LLVMIR: [[TMP1:%.*]] = call i32 @__kmpc_global_thread_num(ptr @[[GLOB1:[0-9]+]])
!LLVMIR-NEXT: call void @__kmpc_ordered(ptr @[[GLOB1]], i32 [[TMP1]])
!$OMP ORDERED THREADS
        a(i) = a(i-1) + 1
!FIRDialect:   omp.terminator
!FIRDialect-NEXT: }
!LLVMIRDialect:   omp.terminator
!LLVMIRDialect-NEXT: }
!LLVMIR: call void @__kmpc_end_ordered(ptr @[[GLOB1]], i32 [[TMP1]])
!LLVMIR-NEXT: ret void
!$OMP END ORDERED

end
