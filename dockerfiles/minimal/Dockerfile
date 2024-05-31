# Ubuntu 24.04 minimal dependencies for Arcane.
# Version with GCC 14 / CLang 18.

FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris
ARG HOME="/root"

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    gnupg \
    wget \
    curl \
    rsync \
    build-essential \
    gcc-14 \
    g++-14 \
    clang-18 \
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
    libunwind-dev \
    ca-certificates \
    dotnet8 \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-14 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 100 \
    && update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-14 100 \
    \
    && update-alternatives --set g++ /usr/bin/g++-14 \
    && update-alternatives --set gcc /usr/bin/gcc-14 \
    && update-alternatives --set gcov /usr/bin/gcov-14 \
    \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100 \
    \
    && update-alternatives --set clang /usr/bin/clang-18 \
    && update-alternatives --set clang++ /usr/bin/clang++-18

# On downgrade MPICH de la version 4.2.0 vers la version 4.1.2.
RUN ARCH=`uname -m` \
    && if [ "$ARCH" = "x86_64" ]; then \
      apt-get update -y \
      && apt-get install -y --no-install-recommends \
      libhwloc-dev \
      libucx-dev \
      \
      && cd /tmp \
      \
      && wget http://launchpadlibrarian.net/714624482/mpich_4.1.2-3_amd64.deb -O mpich.deb \
      && wget http://launchpadlibrarian.net/714624474/libmpich12_4.1.2-3_amd64.deb -O libmpich12.deb \
      && wget http://launchpadlibrarian.net/714624463/libmpich-dev_4.1.2-3_amd64.deb -O libmpich-dev.deb \
      \
      && dpkg -i mpich.deb libmpich12.deb libmpich-dev.deb \
      \
      && rm -rf /var/lib/apt/lists/* \
      && rm -rf /tmp/* ; \
    elif [ "$ARCH" = "aarch64" ]; then \
      : \
    else \
      exit 1; \
    fi

# On compile et installe deux versions de ParMETIS :
# - une version compilée avec OpenMPI,
# - une version compilée avec MPICH.
# La version OpenMPI est installé dans le répertoire
# "/usr/local/parmetis_openmpi" et la version MPICH est
# installé dans le répértoire "/usr/local/parmetis_mpich".
RUN cd /tmp \
    && ARCH=`uname -m` \
    \
    && wget https://ftp.mcs.anl.gov/pub/pdetools/spack-pkgs/parmetis-4.0.3.tar.gz \
    && tar -zxf parmetis-4.0.3.tar.gz \
    && cd parmetis-4.0.3 \
    \
    && update-alternatives --set mpirun /usr/bin/mpirun.mpich \
    && update-alternatives --set mpi /usr/bin/mpicc.mpich \
    && update-alternatives --set mpi-${ARCH}-linux-gnu /usr/include/${ARCH}-linux-gnu/mpich \
    \
    && make config prefix=/usr/local/parmetis_mpich \
    && make install -j 2 \
    && make clean \
    && make config shared=1 prefix=/usr/local/parmetis_mpich \
    && make install -j 2 \
    && make distclean \
    \
    && update-alternatives --set mpirun /usr/bin/mpirun.openmpi \
    && update-alternatives --set mpi /usr/bin/mpicc.openmpi \
    && update-alternatives --set h5pcc /usr/bin/h5pcc.openmpi \
    && update-alternatives --set hdf5.pc /usr/lib/${ARCH}-linux-gnu/pkgconfig/hdf5-openmpi.pc \
    && update-alternatives --set mpi-${ARCH}-linux-gnu /usr/lib/${ARCH}-linux-gnu/openmpi/include \
    \
    && make config prefix=/usr/local/parmetis_openmpi \
    && make install -j 2 \
    && make clean \
    && make config shared=1 prefix=/usr/local/parmetis_openmpi \
    && make install -j 2 \
    && make distclean \
    \
    && update-alternatives --install /usr/include/parmetis.h parmetis /usr/local/parmetis_openmpi/include/parmetis.h 50 \
                           --slave /usr/lib/${ARCH}-linux-gnu/libparmetis.a libparmetisa /usr/local/parmetis_openmpi/lib/libparmetis.a \
                           --slave /usr/lib/${ARCH}-linux-gnu/libparmetis.so libparmetisso /usr/local/parmetis_openmpi/lib/libparmetis.so \
    \
    && update-alternatives --install /usr/include/parmetis.h parmetis /usr/local/parmetis_mpich/include/parmetis.h 40 \
                           --slave /usr/lib/${ARCH}-linux-gnu/libparmetis.a libparmetisa /usr/local/parmetis_mpich/lib/libparmetis.a \
                           --slave /usr/lib/${ARCH}-linux-gnu/libparmetis.so libparmetisso /usr/local/parmetis_mpich/lib/libparmetis.so \
    \
    && update-alternatives --set parmetis /usr/local/parmetis_openmpi/include/parmetis.h \
    && rm -rf /tmp/*
