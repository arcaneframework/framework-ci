#!/bin/sh
set -e

# On installe les packages pour compiler Arcane.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

apt-get update
apt-get install -y --no-install-recommends \
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
  libotf2-trace-dev

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
