#!/bin/sh

# Script permettant de compiler et d'installer Lima.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp

git clone -b 7.11.2 https://github.com/LIHPC-Computational-Geometry/lima lima
mkdir build
cmake \
      -S /tmp/lima \
      -B /tmp/build \
      -GNinja \
      -DCMAKE_Fortran_FLAGS="-fdefault-integer-8 -fdefault-real-8 -fdefault-double-8" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_VERBOSE_MAKEFILE=ON \
      -DBUILD_SHARED_LIBS=ON \
      -DBUILD_XLMLIMA=ON \
      -DBUILD_SCRIPTING=OFF \
      -DMACHINE_TYPES=OFF \
      -DSUMESH=ON \
      -DFORMAT_MLI2=ON \
      -DINT_8=ON \
      -DREAL_8=ON \
      -DFORMAT_MLI=OFF \
      -DSUMESH=OFF

cd /tmp/build
ninja install

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
