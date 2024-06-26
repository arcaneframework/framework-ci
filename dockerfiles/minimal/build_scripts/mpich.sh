#!/bin/sh

# TODO Desc

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Initialisation
cd /tmp
ARCH=`uname -m` # TODO Use it

# Download MPICH src
wget https://www.mpich.org/static/downloads/4.1.3/mpich-4.1.3.tar.gz
tar -xf mpich-4.1.3.tar.gz
cd mpich-4.1.3

./configure --prefix=/usr/local/mpich --disable-fast CFLAGS=-O3 FFLAGS=-O3 CXXFLAGS=-O3 FCFLAGS=-O3 --with-device=ch3:sock --disable-maintainer-mode --disable-silent-rules --enable-shared=yes
make install -j 2

update-alternatives --install /usr/bin/mpirun mpirun /usr/local/mpich/bin/mpirun 100 \
                    --slave /usr/bin/mpiexec mpiexec /usr/local/mpich/bin/mpiexec

update-alternatives --install /usr/bin/mpicc mpi /usr/local/mpich/bin/mpicc 100 \
                    --slave /usr/bin/mpiCC mpiCC /usr/local/mpich/bin/mpicxx \
                    --slave /usr/bin/mpic++ mpic++ /usr/local/mpich/bin/mpicxx \
                    --slave /usr/bin/mpicxx mpicxx /usr/local/mpich/bin/mpicxx \
                    --slave /usr/bin/mpif77 mpif77 /usr/local/mpich/bin/mpifort \
                    --slave /usr/bin/mpif90 mpif90 /usr/local/mpich/bin/mpifort \
                    --slave /usr/bin/mpifort mpifort /usr/local/mpich/bin/mpifort

update-alternatives --install /usr/include/x86_64-linux-gnu/mpi mpi-x86_64-linux-gnu /usr/local/mpich/include 100 \
                    --slave /usr/lib/x86_64-linux-gnu/libmpi++.so libmpi++.so-x86_64-linux-gnu /usr/local/mpich/lib/libmpichcxx.so \
                    --slave /usr/lib/x86_64-linux-gnu/libmpi.so libmpi.so-x86_64-linux-gnu /usr/local/mpich/lib/libmpich.so \
                    --slave /usr/lib/x86_64-linux-gnu/libmpi.so.12 libmpi.so.12-x86_64-linux-gnu /usr/local/mpich/lib/libmpich.so \
                    --slave /usr/lib/x86_64-linux-gnu/libmpicxx.so libmpicxx.so-x86_64-linux-gnu /usr/local/mpich/lib/libmpichcxx.so \
                    --slave /usr/lib/x86_64-linux-gnu/libmpif77.so libmpif77.so-x86_64-linux-gnu /usr/local/mpich/lib/libmpifort.so \
                    --slave /usr/lib/x86_64-linux-gnu/libmpif90.so libmpif90.so-x86_64-linux-gnu /usr/local/mpich/lib/libmpifort.so \
                    --slave /usr/lib/x86_64-linux-gnu/libmpifort.so libmpifort.so-x86_64-linux-gnu /usr/local/mpich/lib/libmpifort.so


# update-alternatives --set mpirun /usr/local/mpich/bin/mpirun
# update-alternatives --set mpi /usr/local/mpich/bin/mpicc
# update-alternatives --set h5pcc /usr/bin/h5pcc.mpich
# update-alternatives --set mpi-x86_64-linux-gnu /usr/local/mpich/include


#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /tmp/*
