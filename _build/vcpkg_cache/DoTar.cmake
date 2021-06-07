file(TO_CMAKE_PATH "${VCPKG_BUILD_DIR}" VCPKG_BUILD_DIR)
message(STATUS "VCPKG_BUILD_DIR=${VCPKG_BUILD_DIR}")
if (NOT VCPKG_BUILD_DIR)
  message(FATAL_ERROR "VCPKG_BUILD_DIR is not defined")
endif()
if (NOT HASH_PACKAGE_NAME)
  message(FATAL_ERROR "HASH_PACKAGE_NAME not defined")
endif()
if (NOT NUGET_API_KEY)
  message(FATAL_ERROR "NUGET_API_KEY")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/../CommonFunctions.cmake)

configure_file(${CMAKE_CURRENT_LIST_DIR}/VcpkgCache.nuspec.in ${CMAKE_CURRENT_LIST_DIR}/VcpkgCache.out.nuspec)
file(READ ${CMAKE_CURRENT_LIST_DIR}/VcpkgCache.out.nuspec NUSPEC_VAR)
message(STATUS "NUSPEC content =\n ${NUSPEC_VAR}")

do_command(tar cf "${CMAKE_CURRENT_LIST_DIR}/vcpkg_cache.tar" --exclude "downloads" --exclude "packages" --exclude "buildtrees" .
  WORKING_DIRECTORY "${VCPKG_BUILD_DIR}")

do_command(${MONO_EXEC} "${NUGET_COMMAND}" pack -NonInteractive -Verbosity detailed  -OutputFileNamesWithoutVersion VcpkgCache.out.nuspec)
#do_command(${MONO_EXEC} "${NUGET_COMMAND}" push -Source GitHub -Verbosity detailed -ForceEnglishOutput -NonInteractive -NoSymbols -SkipDuplicate VcpkgCache.nupkg)
do_command(dotnet nuget push VcpkgCache.nupkg -s github --skip-duplicate --force-english-output --api-key ${NUGET_API_KEY})
