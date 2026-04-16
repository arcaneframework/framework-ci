#!/bin/sh
set -e

# Script permettant d'installer Doxygen v1.16.1.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp

wget https://www.doxygen.nl/files/doxygen-1.16.1.linux.bin.tar.gz
tar xf doxygen-1.16.1.linux.bin.tar.gz
cd /tmp/doxygen-1.16.1/

make -j 4
make install -j 4

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
