##===----------------------------------------------------------------------===##
#
# Build a plugin for a NEC Aurora machine if available. (Can alos run on host
#
##===----------------------------------------------------------------------===##

option(NECAURORA_OFFLOAD_RUN_ON_HOST OFF)

set(additonal_libs "")

if(${LIBOMPTARGET_DEP_VEO_FOUND})
  if(${NECAURORA_OFFLOAD_RUN_ON_HOST})
    libomptarget_say("Building NEC Aurora offloading plugin (FOR HOST ONLY).")
    set(additional_libs dl)
  else()
    libomptarget_say("Building NEC Aurora offloading plugin.")
  endif()
else()
  if(${NECAURORA_OFFLOAD_RUN_ON_HOST})
   libomptarget_error_say("Cannot find a VEOSHIM runtime, although \
                           NECAURORA_OFFLOAD_RUN_ON_HOST=ON. Please configure \
                           with flags -DLIBOMPTARGET_DEP_VEO_LIBRARIES and \
                           -DLIBOMPTARGET_DEP_VEO_INCLUDE_DIR")
  else()
    libomptarget_say("Not building Aurora offloading plugin: VEO not found in system.")
    return()
  endif()
endif()

set(additional_libs ${LIBOMPTARGET_DEP_VEO_LIBRARIES} ${additional_libs})

set(tmachine_name "necaurora")
set(tmachine_libname "necaurora")
set(tmachine_triple "aurora-nec-veort-unknown")

if (NECAURORA_OFFLOAD_RUN_ON_HOST)
  set(elf_machine_id 62)
else()
  set(elf_machine_id 251)
endif()

include_directories(${LIBOMPTARGET_DEP_LIBFFI_INCLUDE_DIR})
include_directories(${LIBOMPTARGET_DEP_LIBELF_INCLUDE_DIR})
# TODO: How can we ensure the availability of veo_offload.h
#       in the case of building for host only before building
#       the aurora-offloading repository (chicken-egg)?
#       Best solution: Integration of libveoshim in plugin
include_directories(${LIBOMPTARGET_DEP_VEO_INCLUDE_DIR})


# Define macro to be used as prefix of the runtime messages for this target.
add_definitions("-DTARGET_NAME=${tmachine_name}")

# Define macro with the ELF ID for this target.
add_definitions("-DTARGET_ELF_ID=${elf_machine_id}")

add_library("omptarget.rtl.${tmachine_libname}" SHARED
  ${CMAKE_CURRENT_SOURCE_DIR}/src/rtl.cpp)

# Install plugin under the lib destination folder.
install(TARGETS "omptarget.rtl.${tmachine_libname}"
  LIBRARY DESTINATION lib${OPENMP_LIBDIR_SUFFIX})

target_link_libraries(
  "omptarget.rtl.${tmachine_libname}"
  ${LIBOMPTARGET_DEP_LIBFFI_LIBRARIES}
  ${LIBOMPTARGET_DEP_LIBELF_LIBRARIES}
  ${additional_libs}
  "-Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/../exports")

# Report to the parent scope that we are building a plugin.
set(LIBOMPTARGET_SYSTEM_TARGETS
  "${LIBOMPTARGET_SYSTEM_TARGETS} ${tmachine_triple}" PARENT_SCOPE)
