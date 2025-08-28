#!/bin/sh
set -e

# Script permettant d'installer CMake v4.1.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp
ARCH=`uname -m`

wget -O install.sh https://github.com/Kitware/CMake/releases/download/v4.1.0/cmake-4.1.0-linux-${ARCH}.sh
chmod u+x install.sh

./install.sh --skip-license --prefix=/usr/local

# Remove useless files
rm /usr/local/bin/cmake-gui
rm -r /usr/local/doc/cmake

cmake --version

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
