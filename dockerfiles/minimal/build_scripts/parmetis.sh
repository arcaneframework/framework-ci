#!/bin/sh

# On compile et installe deux versions de ParMETIS :
# - une version compilée avec OpenMPI,
# - une version compilée avec MPICH.
# La version OpenMPI est installé dans le répertoire
# "/usr/local/parmetis_openmpi" et la version MPICH est
# installé dans le répértoire "/usr/local/parmetis_mpich".

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp
ARCH=`uname -m`

# Download latest parmetis
wget https://ftp.mcs.anl.gov/pub/pdetools/spack-pkgs/parmetis-4.0.3.tar.gz
tar -zxf parmetis-4.0.3.tar.gz
cd parmetis-4.0.3

# Select MPICH alternative
update-alternatives --set mpirun /usr/bin/mpirun.mpich
update-alternatives --set mpi /usr/bin/mpicc.mpich
update-alternatives --set mpi-${ARCH}-linux-gnu /usr/include/${ARCH}-linux-gnu/mpich

# Build/install parmetis with MPICH (.a/.so)
make config prefix=/usr/local/parmetis_mpich
make install -j 2
make clean
make config shared=1 prefix=/usr/local/parmetis_mpich
make install -j 2
make distclean

# Install parmetis MPICH alternative
update-alternatives --install /usr/include/parmetis.h parmetis /usr/local/parmetis_mpich/include/parmetis.h 40 \
                    --slave /usr/lib/${ARCH}-linux-gnu/libparmetis.a libparmetisa /usr/local/parmetis_mpich/lib/libparmetis.a \
                    --slave /usr/lib/${ARCH}-linux-gnu/libparmetis.so libparmetisso /usr/local/parmetis_mpich/lib/libparmetis.so

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Select OpenMPI alternative
update-alternatives --set mpirun /usr/bin/mpirun.openmpi
update-alternatives --set mpi /usr/bin/mpicc.openmpi
update-alternatives --set mpi-${ARCH}-linux-gnu /usr/lib/${ARCH}-linux-gnu/openmpi/include

# Build/install parmetis with OpenMPI (.a/.so)
make config prefix=/usr/local/parmetis_openmpi
make install -j 2
make clean
make config shared=1 prefix=/usr/local/parmetis_openmpi
make install -j 2
make distclean

# Install parmetis OpenMPI alternative
update-alternatives --install /usr/include/parmetis.h parmetis /usr/local/parmetis_openmpi/include/parmetis.h 50 \
                    --slave /usr/lib/${ARCH}-linux-gnu/libparmetis.a libparmetisa /usr/local/parmetis_openmpi/lib/libparmetis.a \
                    --slave /usr/lib/${ARCH}-linux-gnu/libparmetis.so libparmetisso /usr/local/parmetis_openmpi/lib/libparmetis.so

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /tmp/*
