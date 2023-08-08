# Ubuntu 20.04 minimal dependencies for Arcane.
# Version with GCC 11 / CLang 13 / CUDA 11.8 / CMake 3.22.1.

FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On update puis installe add-apt-repository.
# On ajoute le repo pour avoir gcc-11.
# On installe les packages pour compiler Arcane.
# On met la version par défaut du compiler gcc en version 11.
RUN apt-get update -y \
    && apt-get install -y software-properties-common \
    && add-apt-repository ppa:ubuntu-toolchain-r/test -y \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    rsync \
    curl \
    build-essential \
    gcc-11 \
    g++-11 \
    make \
    cmake \
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
    libtbb-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100 \
    && update-alternatives --install /usr/bin/cpp cpp-bin /usr/bin/cpp-11 100 \
    && update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-11 100 \
    \
    && update-alternatives --set g++ /usr/bin/g++-11 \
    && update-alternatives --set gcc /usr/bin/gcc-11 \
    && update-alternatives --set cpp-bin /usr/bin/cpp-11 \
    && update-alternatives --set gcov /usr/bin/gcov-11

# On installe dotnet 6.
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https dotnet-sdk-6.0 \
    && rm -rf /var/lib/apt/lists/*

# On installe la version 3.22.1 de CMake.
RUN cd /tmp \
    && wget https://github.com/Kitware/CMake/releases/download/v3.22.1/cmake-3.22.1-Linux-x86_64.tar.gz \
    && tar xf cmake-3.22.1-Linux-x86_64.tar.gz \
    && cd /tmp/cmake-3.22.1-linux-x86_64/ \
    && rsync -au . /usr/local \
    && cd .. && rm -rf /tmp/*

# On installe CLang 13.
RUN cd /tmp \
    && wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 13 \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-13 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-13 100 \
    && update-alternatives --set clang /usr/bin/clang-13 \
    && update-alternatives --set clang++ /usr/bin/clang++-13

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
