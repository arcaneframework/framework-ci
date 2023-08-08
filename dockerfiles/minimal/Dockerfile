# Ubuntu 22.04 minimal dependencies for Arcane.
# Version with GCC 12 / CLang 16.

FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    curl \
    rsync \
    build-essential \
    gcc-12 \
    g++-12 \
    make \
    ccache \
    ninja-build \
    iputils-ping \
    python3 \
    git \
    gfortran \
    libc6-dev \
    libglib2.0-dev \
    libboost-program-options-dev \
    libopenblas-dev \
    libxml2-dev \
    libhdf5-dev \
    libhdf5-openmpi-dev \
    libhdf5-mpich-dev \
    libopenmpi-dev \
    libmpich-dev \
    libmetis-dev \
    libtbb2-dev \
    ca-certificates \
    dotnet6 \
    cmake \
    software-properties-common \
    gnupg \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 \
    && update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-12 100 \
    && update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-12 100 \
    \
    && update-alternatives --set g++ /usr/bin/g++-12 \
    && update-alternatives --set gcc /usr/bin/gcc-12 \
    && update-alternatives --set cpp-bin /usr/bin/cpp-12 \
    && update-alternatives --set gcov /usr/bin/gcov-12

# On installe CLang 16.
# On met la version par défaut du compiler clang en version 16.
# (Nécessite software-properties-common et gnupg)
RUN cd /tmp \
    && wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 16 \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-16 100 \
    && update-alternatives --set clang /usr/bin/clang-16 \
    && update-alternatives --set clang++ /usr/bin/clang++-16

# On compile et installe deux versions de ParMETIS :
# - une version compilée avec OpenMPI,
# - une version compilée avec MPICH.
# La version OpenMPI est installé dans le répertoire
# "/usr/local/parmetis_openmpi" et la version MPICH est
# installé dans le répértoire "/usr/local/parmetis_mpich".
RUN cd /tmp \
    && wget https://ftp.mcs.anl.gov/pub/pdetools/spack-pkgs/parmetis-4.0.3.tar.gz \
    && tar -zxf parmetis-4.0.3.tar.gz \
    && cd parmetis-4.0.3 \
    \
    && update-alternatives --set mpirun /usr/bin/mpirun.mpich \
    && update-alternatives --set mpi /usr/bin/mpicc.mpich \
    && update-alternatives --set mpi-x86_64-linux-gnu /usr/include/x86_64-linux-gnu/mpich \
    \
    && make config prefix=/usr/local/parmetis_mpich \
    && make install \
    && make clean \
    && make config shared=1 prefix=/usr/local/parmetis_mpich \
    && make install \
    && make distclean \
    \
    && update-alternatives --set mpirun /usr/bin/mpirun.openmpi \
    && update-alternatives --set mpi /usr/bin/mpicc.openmpi \
    && update-alternatives --set h5pcc /usr/bin/h5pcc.openmpi \
    && update-alternatives --set hdf5.pc /usr/lib/x86_64-linux-gnu/pkgconfig/hdf5-openmpi.pc \
    && update-alternatives --set mpi-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/openmpi/include \
    \
    && make config prefix=/usr/local/parmetis_openmpi \
    && make install \
    && make clean \
    && make config shared=1 prefix=/usr/local/parmetis_openmpi \
    && make install \
    && make distclean \
    \
    && update-alternatives --install /usr/include/parmetis.h parmetis /usr/local/parmetis_openmpi/include/parmetis.h 50 \
                           --slave /usr/lib/x86_64-linux-gnu/libparmetis.a libparmetisa /usr/local/parmetis_openmpi/lib/libparmetis.a \
                           --slave /usr/lib/x86_64-linux-gnu/libparmetis.so libparmetisso /usr/local/parmetis_openmpi/lib/libparmetis.so \
    \
    && update-alternatives --install /usr/include/parmetis.h parmetis /usr/local/parmetis_mpich/include/parmetis.h 40 \
                           --slave /usr/lib/x86_64-linux-gnu/libparmetis.a libparmetisa /usr/local/parmetis_mpich/lib/libparmetis.a \
                           --slave /usr/lib/x86_64-linux-gnu/libparmetis.so libparmetisso /usr/local/parmetis_mpich/lib/libparmetis.so \
    \
    && update-alternatives --set parmetis /usr/local/parmetis_openmpi/include/parmetis.h \
    && rm -rf /tmp/*
