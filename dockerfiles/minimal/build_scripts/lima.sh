#!/bin/sh
set -e

# Script permettant de compiler et d'installer Lima.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp

# Lima utilise lsb_release pour trouver le nom de la distribution.
apt-get update -y
apt-get install -y lsb-release

git clone -b 7.11.2 https://github.com/LIHPC-Computational-Geometry/lima lima

# Patch pour la compilation en ARM64.
sed -i '33,38d' /tmp/lima/src/Lima/CMakeLists.txt

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
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
