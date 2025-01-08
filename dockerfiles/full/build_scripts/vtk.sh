#!/bin/sh
set -e

# Script permettant de compiler et d'installer VTK.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

apt-get update -y

# VTK est trop long à compiler sur les machines GH/qemu/ARM64.
if [ "$ARCH" = "aarch64" ]; then
  apt-get install -y libvtk9-dev
  rm -rf /var/lib/apt/lists/*
  exit 0;
fi

apt-get install -y mesa-common-dev mesa-utils

# Initialisation
cd /tmp
git clone -b v9.4.0 --recursive https://gitlab.kitware.com/vtk/vtk.git vtk
mkdir build

# Configure
cmake \
  -S /tmp/vtk \
  -B /tmp/build \
  -GNinja \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DVTK_USE_MPI=ON \
  -DVTK_MODULE_ENABLE_VTK::IOXML=YES \
  -DVTK_MODULE_ENABLE_VTK::IOXdmf2=YES \
  -DVTK_MODULE_ENABLE_VTK::IOLegacy=YES

# Build and Installation
cmake --build /tmp/build --target install

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
