#!/bin/sh
set -e

# Script permettant de compiler et d'installer IceT.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp
git clone https://gitlab.kitware.com/icet/icet.git
cd icet
git checkout release

# Patch pour la compilation avec CMake 4.0+.
sed -i '/CMAKE_MINIMUM_REQUIRED/c\cmake_minimum_required(VERSION 3.20)' CMakeLists.txt
sed -i '/CMAKE_POLICY(SET CMP0017 OLD)/c\' CMakeLists.txt


# Build
mkdir build
cd build
cmake .. \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -GNinja

# Installation
cmake --build . --target install

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
