file(TO_CMAKE_PATH "${VCPKG_BUILD_DIR}" VCPKG_BUILD_DIR)
message(STATUS "VCPKG_BUILD_DIR=${VCPKG_BUILD_DIR}")
if (NOT VCPKG_BUILD_DIR)
  message(FATAL_ERROR "VCPKG_BUILD_DIR is not defined")
endif()
if (NOT HASH_PACKAGE_NAME)
  message(FATAL_ERROR "HASH_PACKAGE_NAME not defined")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/../CommonFunctions.cmake)

do_command(${MONO_EXEC} "${NUGET_COMMAND}" install -Source github -Verbosity detailed -NonInteractive -Version "${HASH_PACKAGE_NAME}" -OutputDirectory "${VCPKG_BUILD_DIR}" VcpkgCache)

message(STATUS "Get list fo files in vcpkg directory")
file(GLOB FILE_LIST LIST_DIRECTORIES true "${VCPKG_BUILD_DIR}/*")
message(STATUS "List: ${FILE_LIST}")

do_command(tar xf "${VCPKG_BUILD_DIR}/VcpkgCache.${HASH_PACKAGE_NAME}/vcpkg_cache.tar" WORKING_DIRECTORY "${VCPKG_BUILD_DIR}")
