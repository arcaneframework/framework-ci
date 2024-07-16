#!/bin/sh

# Script permettant de compiler et d'installer IceT.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp

wget https://perftools.pages.jsc.fz-juelich.de/cicd/otf2/tags/otf2-3.0.3/otf2-3.0.3.tar.gz
tar zxf otf2-3.0.3.tar.gz
cd otf2-3.0.3/

./configure --prefix=/usr/local --exec-prefix=/usr/local

make install

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
