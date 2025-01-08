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

# Build
mkdir build
cd build
cmake .. -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -GNinja

# Installation
cmake --build . --target install

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
