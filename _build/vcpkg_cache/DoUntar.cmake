file(TO_CMAKE_PATH "${VCPKG_BUILD_DIR}" VCPKG_BUILD_DIR)
message(STATUS "VCPKG_BUILD_DIR=${VCPKG_BUILD_DIR}")
if (NOT VCPKG_BUILD_DIR)
  message(FATAL_ERROR "VCPKG_BUILD_DIR is not defined")
endif()
if (NOT HASH_PACKAGE_NAME)
  message(FATAL_ERROR "HASH_PACKAGE_NAME not defined")
endif()
function(do_command command_name)
  set(options        )
  set(oneValueArgs   WORKING_DIRECTORY)
  set(multiValueArgs )

  cmake_parse_arguments(ARGS "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})
  message(STATUS "WORKING_DIRECTORY=${ARGS_WORKING_DIRECTORY}")
  if (NOT ARGS_WORKING_DIRECTORY)
    set(ARGS_WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR})
  endif()

  message(STATUS "TRY COMMAND COMMAND=${command_name} WORKING_DIRECTORY=${ARGS_WORKING_DIRECTORY} ARGS=${ARGS_UNPARSED_ARGUMENTS}")

  execute_process(
    COMMAND ${command_name} ${ARGS_UNPARSED_ARGUMENTS}
    RESULT_VARIABLE RET_VALUE
    WORKING_DIRECTORY ${ARGS_WORKING_DIRECTORY}
    )
  message(STATUS "RET_VALUE=${RET_VALUE}")
  if (NOT RET_VALUE EQUAL 0)
    message(FATAL_ERROR "Bad return value R=${RET_VALUE}")
  endif()
endfunction()

if (NOT WIN32)
  set(MONO_EXEC "mono")
endif()
if (NOT NUGET_COMMAND)
  if (WIN32)
    set(NUGET_COMMAND "nuget.exe")
  else()
    set(NUGET_COMMAND "/usr/local/bin/nuget.exe")
  endif()
endif()

do_command(${MONO_EXEC} "${NUGET_COMMAND}" install -Source github -Verbosity detailed -NonInteractive -Version "${HASH_PACKAGE_NAME}" -OutputDirectory "${VCPKG_BUILD_DIR}" VcpkgCache)

message(STATUS "Get list fo files in vcpkg directory")
file(GLOB FILE_LIST LIST_DIRECTORIES true "${VCPKG_BUILD_DIR}/*")
message(STATUS "List: ${FILE_LIST}")

do_command(tar xf "${VCPKG_BUILD_DIR}/VcpkgCache.${HASH_PACKAGE_NAME}/vcpkg_cache.tar" WORKING_DIRECTORY "${VCPKG_BUILD_DIR}")
