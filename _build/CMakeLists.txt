cmake_minimum_required(VERSION 3.12.0)
project(TEST LANGUAGES NONE VERSION 1.0.0)

# CONFIG_WANTED peut valoir 'Debug', 'Check' ou 'Release'
if (NOT CONFIG_WANTED)
  set(CONFIG_WANTED "Debug")
endif()
if (CONFIG_WANTED STREQUAL Debug)
  set(CMAKE_COMMON_ARGS "-DCMAKE_BUILD_TYPE=Debug")
elseif (CONFIG_WANTED STREQUAL Check)
  set(CMAKE_COMMON_ARGS "-DCMAKE_BUILD_TYPE=Release")
  set(CONFIG_WANT_CHECK TRUE)
elseif (CONFIG_WANTED STREQUAL Release)
  set(CMAKE_COMMON_ARGS "-DCMAKE_BUILD_TYPE=Release")
  set(CONFIG_WANT_CHECK FALSE)
else()
  message(FATAL_ERROR "Invalid value for 'CONFIG_WANTED'")
endif()

set(WORKDIR "${CMAKE_CURRENT_BINARY_DIR}/build_framework_${CONFIG_WANTED}")
if (NOT FRAMEWORK_DIR)
  message(FATAL_ERROR "Variable 'FRAMEWORK_DIR' should be set to the path of 'arcframework' source")
endif()

if (BUILD_WITH_VCPKG)
  set(VCPKG_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../vcpkg)
  set(VCPKG_CMAKE_ARGS -DCMAKE_TOOLCHAIN_FILE=${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake -DVCPKG_MANIFEST_NO_DEFAULT_FEATURES=ON -D_VCPKG_INSTALLED_DIR=${WORKDIR}/myvcpkg)
  set(VCPKG_CMAKE_ARGS_ARCCORE -DVCPKG_MANIFEST_DIR="${CMAKE_CURRENT_SOURCE_DIR}/../_build/arccore")
  set(VCPKG_CMAKE_ARGS_ARCANE -DVCPKG_MANIFEST_DIR="${CMAKE_CURRENT_SOURCE_DIR}/../_build/arcane")
#  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/../_build/arccore/vcpkg.json ${FRAMEWORK_DIR}/arccore COPYONLY)
#  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/../_build/arcane/vcpkg.json ${FRAMEWORK_DIR}/arcane/arcane COPYONLY)
endif()

# ----------------------------------------------------------------------------

macro(tools_set_build_dir name)
  string(TOUPPER ${name} upper_name)
  message(STATUS "Uppername=${upper_name}")
  set(build_dir ${${upper_name}_BUILD_DIR})
  if (NOT build_dir)
    message(FATAL_ERROR "Variable ${upper_name}_BUILD_DIR is not set")
  endif()
  set(install_dir ${${upper_name}_INSTALL_DIR})
  if (NOT install_dir)
    message(FATAL_ERROR "Variable ${upper_name}_INSTALL_DIR is not set")
  endif()
  set(install_stamp ${${upper_name}_INSTALL_STAMP})
  if (NOT install_stamp)
    message(FATAL_ERROR "Variable ${upper_name}_INSTALL_STAMP is not set")
  endif()
  set(configure_stamp ${${upper_name}_CONFIGURE_STAMP})
  if (NOT configure_stamp)
    message(FATAL_ERROR "Variable ${upper_name}_CONFIGURE_STAMP is not set")
  endif()
  set(source_dir ${${upper_name}_SOURCE_DIR})
  if (NOT source_dir)
    message(FATAL_ERROR "Variable ${upper_name}_SOURCE_DIR is not set")
  endif()
endmacro()

# ----------------------------------------------------------------------------

macro(tools_set_default_dir name)
  string(TOUPPER ${name} upper_name)
  message(STATUS "Uppername=${upper_name}")
  set(${upper_name}_BUILD_DIR "${WORKDIR}/${name}")
  set(${upper_name}_INSTALL_DIR "${WORKDIR}/install_${name}")
  set(${upper_name}_INSTALL_STAMP "${${upper_name}_INSTALL_DIR}/.install_stamp")
  set(${upper_name}_CONFIGURE_STAMP "${${upper_name}_BUILD_DIR}/.configure_stamp")
  file(MAKE_DIRECTORY ${${upper_name}_BUILD_DIR})
endmacro()

# ----------------------------------------------------------------------------

function(tools_add_target name)
  tools_set_build_dir(${name})
  message(STATUS "Add target 'configure_${name}' depends on '${build_dir}/CMakeCache.txt'")
  add_custom_target(configure_${name} DEPENDS ${configure_stamp})
  add_custom_command(OUTPUT ${install_stamp}
    DEPENDS ${configure_stamp}
    COMMAND ${CMAKE_COMMAND} --build .
    COMMAND ${CMAKE_COMMAND} --build . --target install
    COMMAND ${CMAKE_COMMAND} -E touch ${install_stamp}
    WORKING_DIRECTORY ${build_dir}
  )
  add_custom_target(build_${name} DEPENDS ${install_stamp})
  add_custom_target(force_build_${name}
    COMMAND ${CMAKE_COMMAND} -E remove ${install_stamp}
    COMMAND ${CMAKE_COMMAND} --build . --target build_${name}
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    )
endfunction()

# ----------------------------------------------------------------------------

function(tools_add_configure name)
  set(options        )
  set(multiValueArgs PREFIX_PATH CMAKE_ARGS DEPENDS PACKAGE_DEPENDS)

  cmake_parse_arguments(ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  tools_set_build_dir(${name})

  list(APPEND ARGS_PREFIX_PATH "${SPACK_VIEW_DIR}")
  message(STATUS "PrefixPath=${ARGS_PREFIX_PATH}")
  list(JOIN ARGS_PREFIX_PATH "\;" ${name}_CMAKE_PREFIX_PATH)
  message(STATUS "PrefixPathJoined=${${name}_CMAKE_PREFIX_PATH}")
  message(STATUS "CMAKE_ARGS=${ARGS_CMAKE_ARGS}")
  unset(_FILE_DEPENDS)
  foreach(_build ${ARGS_PACKAGE_DEPENDS})
    message(STATUS "BUILD=${_build}")
    string(TOUPPER ${_build} _upper_build)
    message(STATUS "BUILD_INSTALL_DIR=${${_upper_build}_INSTALL_STAMP}")
    list(APPEND _FILE_DEPENDS ${${_upper_build}_INSTALL_STAMP})
  endforeach()
  message(STATUS "Add command output '${configure_stamp}' depends on '${ARGS_DEPENDS}' '${_FILE_DEPENDS}'")
  if (CONFIG_CXX_COMPILER)
    list(APPEND CONFIG_COMPILER_ARGS -DCMAKE_CXX_COMPILER="${CONFIG_CXX_COMPILER}")
  endif()
  if (CONFIG_CXX_COMPILER)
    list(APPEND CONFIG_COMPILER_ARGS -DCMAKE_C_COMPILER="${CONFIG_C_COMPILER}")
  endif()
  if (UNIX)
    list(APPEND ARGS_CMAKE_ARGS "-GNinja")
  endif()
  add_custom_command(
    OUTPUT ${configure_stamp}
    MAIN_DEPENDENCY ${source_dir}/CMakeLists.txt
    COMMAND ${CMAKE_COMMAND} ${source_dir}
    -DCMAKE_PREFIX_PATH="${${name}_CMAKE_PREFIX_PATH}"
    -DCMAKE_INSTALL_PREFIX=${install_dir}
    ${CONFIG_COMPILER_ARGS}
    ${CMAKE_COMMON_ARGS}
    ${ARGS_CMAKE_ARGS}
    COMMAND ${CMAKE_COMMAND} -E touch ${configure_stamp}
    WORKING_DIRECTORY ${build_dir}
    DEPENDS ${ARGS_DEPENDS} ${_FILE_DEPENDS}
    )
endfunction()

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Arccon

set(ARCCON_SOURCE_DIR "${FRAMEWORK_DIR}/arccon")

tools_set_default_dir(arccon)
tools_add_configure(arccon)
tools_add_target(arccon)

# ----------------------------------------------------------------------------
# arccore

set(ARCCORE_SOURCE_DIR "${FRAMEWORK_DIR}/arccore")
tools_set_default_dir(arccore)
set(ARCCORE_CMAKE_ARGS "-DBUILD_SHARED_LIBS=TRUE")
list(APPEND ARCCORE_CMAKE_ARGS "-DARCCORE_BUILD_MODE=${CONFIG_WANTED}")

tools_add_configure(arccore PREFIX_PATH "${ARCCON_INSTALL_DIR}"
  CMAKE_ARGS ${ARCCORE_CMAKE_ARGS}
  ${VCPKG_CMAKE_ARGS} ${VCPKG_CMAKE_ARGS_ARCCORE}
  PACKAGE_DEPENDS arccon)
tools_add_target(arccore)

# ----------------------------------------------------------------------------
# dependencies

set(DEPENDENCIES_SOURCE_DIR "${FRAMEWORK_DIR}/dependencies")
tools_set_default_dir(dependencies)

tools_add_configure(dependencies
                    PREFIX_PATH "${ARCCON_INSTALL_DIR}"
                    PACKAGE_DEPENDS arccon)

tools_add_target(dependencies)

# ----------------------------------------------------------------------------
# axlstar

set(AXLSTAR_SOURCE_DIR "${FRAMEWORK_DIR}/axlstar")
tools_set_default_dir(axlstar)

tools_add_configure(axlstar PREFIX_PATH "${ARCCON_INSTALL_DIR}" "${DEPENDENCIES_INSTALL_DIR}"
  CMAKE_ARGS "-DAXLSTAR_DOTNET_RUNNER=coreclr"
  PACKAGE_DEPENDS arccon dependencies)
tools_add_target(axlstar)

# ----------------------------------------------------------------------------
# Arcane

set(ARCANE_SOURCE_DIR "${FRAMEWORK_DIR}/arcane/arcane")
tools_set_default_dir(arcane)

tools_add_configure(arcane PREFIX_PATH "${ARCCON_INSTALL_DIR}" "${AXLSTAR_INSTALL_DIR}" "${DEPENDENCIES_INSTALL_DIR}" "${ARCCORE_INSTALL_DIR}"
  CMAKE_ARGS
  ${VCPKG_CMAKE_ARGS}
  ${VCPKG_CMAKE_ARGS_ARCANE}
  "-DBUILD_SHARED_LIBS=TRUE"
  "-DARCANE_DEFAULT_PARTITIONER=Metis"
  "-DARCCON_REGISTER_PACKAGE_VERSION=2"
#  -DARCANE_WANT_ARCCON_EXPORT_TARGET=OFF
  PACKAGE_DEPENDS arccon axlstar dependencies arccore)
tools_add_target(arcane)

set(ARCANE_SAMPLES_BUILD_DIR ${WORKDIR}/samples)
file(MAKE_DIRECTORY ${ARCANE_SAMPLES_BUILD_DIR})
add_custom_target(arcane_samples
  DEPENDS ${ARCANE_INSTALL_STAMP}
  WORKING_DIRECTORY ${ARCANE_SAMPLES_BUILD_DIR}
  COMMAND ${CMAKE_COMMAND} ${ARCANE_INSTALL_DIR}/samples
  COMMAND ${CMAKE_COMMAND} --build .
)
add_custom_target(arcane_run_samples
  DEPENDS arcane_samples
  WORKING_DIRECTORY ${ARCANE_SAMPLES_BUILD_DIR}
  COMMAND ${CMAKE_CTEST_COMMAND}
)
  
add_custom_target(all_arcane ALL DEPENDS build_arcane)
