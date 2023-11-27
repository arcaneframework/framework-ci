# Ubuntu 22.04 full dependencies for Arcane.
# Version with GCC 12 / CLang 15 / CUDA 12.2 / CMake 3.27.8.

FROM ghcr.io/arcaneframework/ubuntu-2204:gcc-12_clang-15_cuda-122_minimal_latest

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    googletest libgtest-dev \
    swig4.0 \
    libhypre-dev \
    libpetsc-real-dev \
    libtrilinos-teuchos-dev libtrilinos-epetra-dev \
    libtrilinos-tpetra-dev libtrilinos-kokkos-dev libtrilinos-ifpack2-dev \
    libtrilinos-ifpack-dev libtrilinos-amesos-dev libtrilinos-galeri-dev \
    libtrilinos-xpetra-dev libtrilinos-epetraext-dev \
    libtrilinos-triutils-dev libtrilinos-thyra-dev \
    libtrilinos-kokkos-kernels-dev libtrilinos-rtop-dev \
    libtrilinos-isorropia-dev libtrilinos-belos-dev \
    libtrilinos-ifpack-dev libtrilinos-anasazi-dev \
    libtrilinos-amesos2-dev libtrilinos-shards-dev libtrilinos-muelu-dev \
    libtrilinos-intrepid2-dev libtrilinos-teko-dev libtrilinos-sacado-dev \
    libtrilinos-stratimikos-dev libtrilinos-shylu-dev \
    libtrilinos-zoltan-dev libtrilinos-zoltan2-dev \
    libtrilinos-aztecoo-dev libtrilinos-ml-dev \
    dpkg-dev \
    python3-dev python3-numpy \
    valgrind \
    pd-bsaylor \
    libosmesa6-dev \
    libptscotch-dev \
    libexpat1-dev \
    libudunits2-dev \
    libbz2-dev \
    liblz4-dev \
    libpapi-dev \
    libarchive-dev \
    && rm -rf /var/lib/apt/lists/*

# On installe IceT.
RUN cd /tmp \
    && git clone https://gitlab.kitware.com/icet/icet.git \
    && cd icet \
    && git checkout release \
    && mkdir build \
    && cd build \
    && cmake .. -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release -GNinja \
    && cmake --build . --target install \
    && cd / && rm -rf /tmp/*
    
# On installe OTF2.
RUN cd /tmp \
    && wget https://perftools.pages.jsc.fz-juelich.de/cicd/otf2/tags/otf2-3.0.3/otf2-3.0.3.tar.gz \
    && tar zxf otf2-3.0.3.tar.gz \
    && cd otf2-3.0.3/ \
    && ./configure --prefix=/usr/local --exec-prefix=/usr/local \
    && make \
    && make install \
    && cd / && rm -rf /tmp/*
