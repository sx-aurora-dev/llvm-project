##===----------------------------------------------------------------------===##
#
# Build a plugin for a NEC SX-Aurora machine if available.
# Offloading is done from SX-Aurora device to the host processor.
#
##===----------------------------------------------------------------------===##


if(${LIBOMPTARGET_DEP_VHCALL_FOUND} AND ${LIBOMPTARGET_DEP_VEPSEUDO_FOUND})
  set(tmachine_name "vh")
  set(tmachine_libname "vh")
  set(tmachine_triple "x86_64-pc-linux-gnu")
  set(elf_machine_id 62)

  # Build the target plugin on ve side
  if("${LIBOMP_ARCH}" STREQUAL "ve")
    libomptarget_say("Building SX-Aurora VE to VH offloading plugin - ve part.")
    set(additional_libs "")
    set(additional_libs ${LIBOMPTARGET_DEP_VHCALL_LIBRARIES}
                        ${additional_libs})

    # Define macro to be used as prefix of the runtime messages for this target.
    add_definitions("-DTARGET_NAME=${tmachine_name}")

    # Define macro with the ELF ID for this target.
    add_definitions("-DTARGET_ELF_ID=${elf_machine_id}")

    add_library("omptarget.rtl.${tmachine_libname}" SHARED
      ${CMAKE_CURRENT_SOURCE_DIR}/src/rtl.cpp)

    # Install plugin under the lib destination folder.
    install(TARGETS "omptarget.rtl.${tmachine_libname}"
      LIBRARY DESTINATION lib${OPENMP_LIBDIR_SUFFIX})

    target_include_directories("omptarget.rtl.${tmachine_libname}" PRIVATE
      ${LIBOMPTARGET_INCLUDE_DIR}
      ${LIBOMPTARGET_DEP_VHCALL_INCLUDE_DIR})

    target_link_libraries(
      "omptarget.rtl.${tmachine_libname}"
      ${additional_libs}
      "-Wl,--version-script=${CMAKE_CURRENT_SOURCE_DIR}/../exports -Wl,-z,defs")

    # Report to the parent scope that we are building a plugin.
    set(LIBOMPTARGET_SYSTEM_TARGETS
      "${LIBOMPTARGET_SYSTEM_TARGETS} ${tmachine_triple}" PARENT_SCOPE)
  else() # Build the support library on vector host side
    # TODO replace this with direct loading of the required libraries and call
    # them directly with vhcall.
    libomptarget_say("Building SX-Aurora VE to VH offloading plugin - vh part.")

    add_library(
      "omptarget.device-rtl.${tmachine_libname}" SHARED
      ${CMAKE_CURRENT_SOURCE_DIR}/src/device-rtl.cpp)

    # should end up in the default library path on the vector host
    install(TARGETS "omptarget.device-rtl.${tmachine_libname}"
      LIBRARY DESTINATION lib${OPENMP_LIBDIR_SUFFIX})

    target_include_directories(
      "omptarget.device-rtl.${tmachine_libname}" PRIVATE
      ${LIBOMPTARGET_INCLUDE_DIR}
      ${LIBOMPTARGET_DEP_VEPSEUDO_INCLUDE_DIR})

    target_link_libraries(
      "omptarget.device-rtl.${tmachine_libname}"
      ${LIBOMPTARGET_DEP_VEPSEUDO_LIBRARIES})
  endif()
else()
  libomptarget_say("Not building vh plugin: libvhcall not found.")
endif()
