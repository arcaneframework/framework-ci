#!/bin/sh
set -e

# Script permettant d'installer Doxygen v1.13.2.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp

wget https://www.doxygen.nl/files/doxygen-1.13.2.linux.bin.tar.gz
tar xf doxygen-1.13.2.linux.bin.tar.gz
cd /tmp/doxygen-1.13.2/

make -j 4
make install -j 4

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
