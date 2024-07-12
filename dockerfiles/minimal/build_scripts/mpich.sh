#!/bin/sh

# Script permettant de compiler et d'installer MPICH et d'installer les
# alternatives.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp
ARCH=`uname -m`
MPICH_INSTALL_DIR=/usr/local/mpich

# Download MPICH src
wget https://www.mpich.org/static/downloads/4.1.3/mpich-4.1.3.tar.gz
tar -xf mpich-4.1.3.tar.gz
cd mpich-4.1.3

./configure --prefix=${MPICH_INSTALL_DIR} --disable-fast CFLAGS=-O3 FFLAGS=-O3 CXXFLAGS=-O3 FCFLAGS=-O3 --with-device=ch3:sock --disable-maintainer-mode --disable-silent-rules --enable-shared=yes
make install -j 4

update-alternatives --install /usr/bin/mpirun mpirun ${MPICH_INSTALL_DIR}/bin/mpirun 100 \
                    --slave /usr/bin/mpiexec mpiexec ${MPICH_INSTALL_DIR}/bin/mpiexec

update-alternatives --install /usr/bin/mpicc mpi ${MPICH_INSTALL_DIR}/bin/mpicc 100 \
                    --slave /usr/bin/mpiCC mpiCC ${MPICH_INSTALL_DIR}/bin/mpicxx \
                    --slave /usr/bin/mpic++ mpic++ ${MPICH_INSTALL_DIR}/bin/mpicxx \
                    --slave /usr/bin/mpicxx mpicxx ${MPICH_INSTALL_DIR}/bin/mpicxx \
                    --slave /usr/bin/mpif77 mpif77 ${MPICH_INSTALL_DIR}/bin/mpifort \
                    --slave /usr/bin/mpif90 mpif90 ${MPICH_INSTALL_DIR}/bin/mpifort \
                    --slave /usr/bin/mpifort mpifort ${MPICH_INSTALL_DIR}/bin/mpifort \
                    --slave /usr/bin/hydra_pmi_proxy hydra_pmi_proxy ${MPICH_INSTALL_DIR}/bin/hydra_pmi_proxy \
                    --slave /usr/bin/hydra_persist hydra_persist ${MPICH_INSTALL_DIR}/bin/hydra_persist \
                    --slave /usr/bin/hydra_nameserver hydra_nameserver ${MPICH_INSTALL_DIR}/bin/hydra_nameserver

update-alternatives --install /usr/include/${ARCH}-linux-gnu/mpi mpi-${ARCH}-linux-gnu ${MPICH_INSTALL_DIR}/include 100 \
                    --slave /usr/lib/${ARCH}-linux-gnu/libmpi++.so libmpi++.so-${ARCH}-linux-gnu ${MPICH_INSTALL_DIR}/lib/libmpichcxx.so \
                    --slave /usr/lib/${ARCH}-linux-gnu/libmpi.so libmpi.so-${ARCH}-linux-gnu ${MPICH_INSTALL_DIR}/lib/libmpich.so \
                    --slave /usr/lib/${ARCH}-linux-gnu/libmpi.so.12 libmpi.so.12-${ARCH}-linux-gnu ${MPICH_INSTALL_DIR}/lib/libmpich.so \
                    --slave /usr/lib/${ARCH}-linux-gnu/libmpicxx.so libmpicxx.so-${ARCH}-linux-gnu ${MPICH_INSTALL_DIR}/lib/libmpichcxx.so \
                    --slave /usr/lib/${ARCH}-linux-gnu/libmpif77.so libmpif77.so-${ARCH}-linux-gnu ${MPICH_INSTALL_DIR}/lib/libmpifort.so \
                    --slave /usr/lib/${ARCH}-linux-gnu/libmpif90.so libmpif90.so-${ARCH}-linux-gnu ${MPICH_INSTALL_DIR}/lib/libmpifort.so \
                    --slave /usr/lib/${ARCH}-linux-gnu/libmpifort.so libmpifort.so-${ARCH}-linux-gnu ${MPICH_INSTALL_DIR}/lib/libmpifort.so

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
cd /
rm -rf /tmp/*
