#!/bin/sh

# Script permettant de compiler et d'installer IceT.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

cd /tmp
git clone https://gitlab.kitware.com/icet/icet.git
cd icet
git checkout release

mkdir build
cd build

cmake .. -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -GNinja
cmake --build . --target install

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
