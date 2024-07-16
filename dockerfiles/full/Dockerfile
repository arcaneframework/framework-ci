# Ubuntu 24.04 full dependencies for Arcane.

FROM ghcr.io/arcaneframework/ubuntu-2404:gcc-14_clang-18_minimal_latest

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# On installe les packages pour compiler Arcane.
# À noter que CUDA 12.5 est compatible uniquement avec g++-13 max et clang-17 max.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    googletest libgtest-dev \
    swig \
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
    libotf2-trace-dev \
    clang-17 \
    \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-17 90 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-17 90 \
    \
    && rm -rf /var/lib/apt/lists/*

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Copie des scripts de construction d'image.
COPY build_scripts/ /root/build_scripts/

# Copie des scripts pour configurer le container.
COPY scripts/ /root/scripts/

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Définition des programmes par défaut.
RUN /root/scripts/default_alternatives.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de IceT.
RUN /root/build_scripts/icet.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de Cuda.
RUN /root/build_scripts/cuda.sh
ENV PATH="/usr/local/cuda/bin${PATH:+:$PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de AdaptiveCPP.
RUN /root/build_scripts/adaptivecpp.sh
