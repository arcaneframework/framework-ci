#!/bin/sh
set -e

# Script permettant d'installer CMake v3.30.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp
ARCH=`uname -m`

wget -O install.sh https://github.com/Kitware/CMake/releases/download/v3.31.4/cmake-3.31.4-linux-${ARCH}.sh
chmod u+x install.sh

./install.sh --skip-license --prefix=/usr/local

cmake --version

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
