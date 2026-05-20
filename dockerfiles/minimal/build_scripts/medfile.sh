#!/bin/sh
set -e

# Script permettant de compiler et d'installer MEDFile.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
TDIR=/tmp/med
mkdir -p ${TDIR}
cd ${TDIR}

wget -U "" https://files.salome-platform.org/Salome/medfile/med-6.0.1.tar.gz
tar -zxf med-6.0.1.tar.gz && mv med-6.0.1 med
cd med

cmake \
      -S ${TDIR}/med \
      -B ${TDIR}/build \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -GNinja

ninja -C ${TDIR}/build install

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /usr/local/share/doc
rm -rf /tmp/*
