#!/bin/sh

# Script permettant de définir MPICH comme MPI par défaut.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

echo "---------------------------------------------------------------------------"
echo "Define MPICH alternative"
echo "---------------------------------------------------------------------------"

# Initialisation
ARCH=`uname -m`
MPICH_INSTALL_DIR=/usr/local/mpich
PARMETIS_MPICH_INSTALL_DIR=/usr/local/parmetis_mpich

# update-alternatives --set mpirun /usr/bin/mpirun.mpich
# update-alternatives --set mpi /usr/bin/mpicc.mpich
# update-alternatives --set mpi-${ARCH}-linux-gnu /usr/include/${ARCH}-linux-gnu/mpich

# update-alternatives --set h5pcc /usr/bin/h5pcc.mpich
# update-alternatives --set hdf5.pc /usr/lib/${ARCH}-linux-gnu/pkgconfig/hdf5-mpich.pc

update-alternatives --set mpirun ${MPICH_INSTALL_DIR}/bin/mpirun
update-alternatives --set mpi ${MPICH_INSTALL_DIR}/bin/mpicc
update-alternatives --set mpi-${ARCH}-linux-gnu ${MPICH_INSTALL_DIR}/include

update-alternatives --set hdf5.pc /usr/lib/${ARCH}-linux-gnu/pkgconfig/hdf5-serial.pc

update-alternatives --set parmetis ${PARMETIS_MPICH_INSTALL_DIR}/include/parmetis.h

mpirun --version
