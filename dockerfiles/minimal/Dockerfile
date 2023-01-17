# Ubuntu 22.04 minimal dependencies for Arcane.
# Version with GCC 12 / CLang 15.

FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
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
    libxml2-dev \
    libhdf5-dev libhdf5-openmpi-dev \
    libopenmpi-dev \
    libmpich-dev \
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
    && update-alternatives --set gcov /usr/bin/gcov-12 \
    \
    && update-alternatives --set mpirun /usr/bin/mpirun.openmpi \
    && update-alternatives --set mpi /usr/bin/mpicc.openmpi \
    && update-alternatives --set h5pcc /usr/bin/h5pcc.openmpi \
    && update-alternatives --set mpi-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/openmpi/include

# On installe CLang 15.
# On met la version par défaut du compiler clang en version 15.
# (Nécessite software-properties-common et gnupg)
RUN cd /tmp \
    && wget https://apt.llvm.org/llvm.sh \
    && chmod +x llvm.sh \
    && ./llvm.sh 15 \
    && rm -rf /tmp/* \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 90 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 90 \
    && update-alternatives --set clang /usr/bin/clang-15 \
    && update-alternatives --set clang++ /usr/bin/clang++-15

RUN cd /tmp \
    && wget https://ftp.mcs.anl.gov/pub/pdetools/spack-pkgs/parmetis-4.0.3.tar.gz \
    && tar -zxf parmetis-4.0.3.tar.gz \
    && cd parmetis-4.0.3 \
    && make config shared=1 prefix=/usr/local/parmetis_openmpi \
    && make install \
    && rm -rf /tmp/*
    