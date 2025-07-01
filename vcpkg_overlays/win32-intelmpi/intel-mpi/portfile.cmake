# The last digit in the version is not used in the path
# For example, use '2021.16' for version '2021.16.0'
set(INTELMPI_VERSION "2021.16")
set(SOURCE_PATH "${CURRENT_BUILDTREES_DIR}/src/intel-mpi-${INTELMPI_VERSION}")

file(TO_NATIVE_PATH "C:/Program Files (x86)/Intel/oneAPI" SDK_SOURCE_DIR)

message(STATUS "IntelMPI source SDK = ${SDK_SOURCE_DIR}")

set(SDK_SOURCE_MPI_DIR "${SDK_SOURCE_DIR}/mpi/${INTELMPI_VERSION}")

set(SOURCE_INCLUDE_PATH "${SDK_SOURCE_MPI_DIR}/include")
set(SOURCE_LIB_PATH "${SDK_SOURCE_MPI_DIR}/lib")
set(SOURCE_BIN_PATH "${SDK_SOURCE_MPI_DIR}/bin")
set(SOURCE_TOOLS_PATH "${SDK_SOURCE_MPI_DIR}/bin")
set(SOURCE_INCLUDE_FILES
  "${SOURCE_INCLUDE_PATH}/mpi.h"
  "${SOURCE_INCLUDE_PATH}/mpicxx.h"
  "${SOURCE_INCLUDE_PATH}/mpif.h"
  "${SOURCE_INCLUDE_PATH}/mpio.h"
  "${SOURCE_INCLUDE_PATH}/mpiof.h"
  )

# Debug directory do not always exists if no debug is installed
set(SOURCE_DEBUG_LIB_PATH "${SDK_SOURCE_MPI_DIR}/lib/mpi/debug")
set(SOURCE_DEBUG_BIN_PATH "${SDK_SOURCE_MPI_DIR}/bin/mpi/debug")

# Get files in bin directory
file(GLOB
  TOOLS_FILES
  "${SOURCE_TOOLS_PATH}/*.exe"
  "${SOURCE_TOOLS_PATH}/*.dll"
  "${SOURCE_TOOLS_PATH}/*.bat"
  )

# Install tools files
file(INSTALL
  ${TOOLS_FILES}
  DESTINATION
  "${CURRENT_PACKAGES_DIR}/tools/${PORT}"
  )

# Also install include files in the tools directory
# because the compiler wrappers (mpicc.bat for example) needs them
# With Intel 2024.12 and CMake 2.27 we have to create a 'mpi' directory
# in the header directory to avoid an error with packages using MPI
file(INSTALL
  ${SOURCE_INCLUDE_FILES}
  DESTINATION
  "${CURRENT_PACKAGES_DIR}/tools/${PORT}/include"
  )
file(INSTALL
  ${SOURCE_INCLUDE_FILES}
  DESTINATION
  "${CURRENT_PACKAGES_DIR}/tools/${PORT}/include/mpi"
  )

# Install include files
file(INSTALL
  ${SOURCE_INCLUDE_FILES}
  DESTINATION
  "${CURRENT_PACKAGES_DIR}/include"
  )

# Install release library files
file(INSTALL
  "${SOURCE_LIB_PATH}/impi.lib"
  "${SOURCE_LIB_PATH}/impicxx.lib"
  DESTINATION "${CURRENT_PACKAGES_DIR}/lib"
  )

# Install debug library files
file(INSTALL
  "${SOURCE_DEBUG_LIB_PATH}/impi.lib"
  "${SOURCE_DEBUG_LIB_PATH}/impicxx.lib"
  DESTINATION "${CURRENT_PACKAGES_DIR}/debug/lib"
  )
# 'libfabric.dll' is not needed for the compilation but it is needed
# for the runtime and should be in the PATH for 'mpiexec' to work
file(INSTALL
  "${SOURCE_BIN_PATH}/impi.dll"
  "${SDK_SOURCE_MPI_DIR}/opt/mpi/libfabric/bin/libfabric.dll"
  DESTINATION "${CURRENT_PACKAGES_DIR}/bin"
  )

if(EXISTS "${SOURCE_BIN_PATH}/impi.pdb")
  file(INSTALL
    "${SOURCE_BIN_PATH}/impi.pdb"
    DESTINATION "${CURRENT_PACKAGES_DIR}/bin"
  )
endif()

file(INSTALL
  "${SOURCE_DEBUG_BIN_PATH}/impi.dll"
  "${SDK_SOURCE_MPI_DIR}/opt/mpi/libfabric/bin/libfabric.dll"
  DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin"
  )

if (EXISTS "${SOURCE_DEBUG_BIN_PATH}/impi.pdb")
  file(INSTALL
    "${SOURCE_DEBUG_BIN_PATH}/impi.pdb"
    DESTINATION "${CURRENT_PACKAGES_DIR}/debug/bin"
    )
endif()

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/mpi-wrapper.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

# Handle copyright
# C:\Program Files (x86)\Intel\oneAPI\licensing\2025.2\licensing\2025.2
file(COPY "${SDK_SOURCE_DIR}/licensing/2025.2/licensing/2025.2/license.htm" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright" "See the accompanying 'licence.htm'")
