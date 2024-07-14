#!/bin/sh

# Script permettant de définir les alternatives par défaut de l'image.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
ARCH=`uname -m`

# Default gcc : gcc-14
update-alternatives --set g++ /usr/bin/g++-14
update-alternatives --set gcc /usr/bin/gcc-14
update-alternatives --set gcov /usr/bin/gcov-14

# Default clang : clang-18
update-alternatives --set clang /usr/bin/clang-18
update-alternatives --set clang++ /usr/bin/clang++-18

# Default parmetis : parmetis_openmpi
update-alternatives --set parmetis /usr/local/parmetis_openmpi/include/parmetis.h

# Default mpi : openmpi
update-alternatives --set mpirun /usr/bin/mpirun.openmpi
update-alternatives --set mpi /usr/bin/mpicc.openmpi
update-alternatives --set mpi-${ARCH}-linux-gnu /usr/lib/${ARCH}-linux-gnu/openmpi/include

# Default hdf5 : hdf5_openmpi
update-alternatives --set h5pcc /usr/bin/h5pcc.openmpi
update-alternatives --set hdf5.pc /usr/lib/${ARCH}-linux-gnu/pkgconfig/hdf5-openmpi.pc
