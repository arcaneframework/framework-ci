#!/bin/sh

# Script permettant de définir OpenMPI comme MPI par défaut.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
ARCH=`uname -m`
PARMETIS_OPENMPI_INSTALL_DIR=/usr/local/parmetis_openmpi

update-alternatives --set mpirun /usr/bin/mpirun.openmpi
update-alternatives --set mpi /usr/bin/mpicc.openmpi
update-alternatives --set mpi-${ARCH}-linux-gnu /usr/lib/${ARCH}-linux-gnu/openmpi/include

update-alternatives --set h5pcc /usr/bin/h5pcc.openmpi
update-alternatives --set hdf5.pc /usr/lib/${ARCH}-linux-gnu/pkgconfig/hdf5-openmpi.pc

update-alternatives --set parmetis ${PARMETIS_OPENMPI_INSTALL_DIR}/include/parmetis.h

mpirun --version
