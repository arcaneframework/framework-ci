#!/bin/sh
set -e

# On installe les packages pour compiler Arcane.
# Les packages gcc g++ sont là pour éviter que d'autres les installes
# et déconfigure les alternatives déjà séléctionnées.

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

apt-get update

# https://github.com/open-mpi/ompi/issues/13886
echo "path-include=/usr/share/doc/libprrte-dev/help-*" >> /etc/dpkg/dpkg.cfg.d/excludes
# libprrte-dev gzip

apt-get install -y --no-install-recommends \
  apt-utils \
  gnupg \
  wget \
  curl \
  rsync \
  build-essential \
  \
  gcc-15 g++-15 \
  gcc g++ \
  \
  clang-22 \
  clang-20 \
  \
  gfortran-15 \
  gfortran \
  \
  make \
  cmake \
  ccache \
  ninja-build \
  mold \
  \
  iputils-ping \
  python3-dev \
  python3-pip \
  git \
  libc6-dev \
  libglib2.0-dev \
  libboost-program-options-dev \
  libopenblas-dev \
  libxml2-dev \
  \
  libhdf5-dev \
  libhdf5-openmpi-dev \
  \
  libopenmpi-dev \
  gzip \
  libprrte-dev \
  \
  libmetis-dev \
  libtbb-dev \
  libunwind-dev \
  libdw-dev \
  ca-certificates \
  dotnet10 \
  jq

update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-15 100
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-15 100
update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-15 100

update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 100

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-22 100
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-22 100

update-alternatives --install /usr/bin/clang clang /usr/bin/clang-20 90
update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-20 90

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

ARCH=`uname -m`

# Patch pour Alien
ln -s /usr/lib/gcc/${ARCH}-linux-gnu/15/libgfortran.so /usr/lib/${ARCH}-linux-gnu/libgfortran.so

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# https://github.com/open-mpi/ompi/issues/13886
if [ ! -f /usr/lib/${ARCH}-linux-gnu/prrte3/share/prte/help-prun.txt ]; then
  # fix a packaging issue: https://bugs.launchpad.net/ubuntu/+source/openmpi/+bug/2155666
  mkdir -p /usr/lib/${ARCH}-linux-gnu/prrte3/share/prte
  cp /usr/share/doc/libprrte-dev/help-schizo-ompi.txt /usr/lib/${ARCH}-linux-gnu/prrte3/share/prte/
  cp /usr/share/doc/libprrte-dev/help-prun.txt.gz /usr/lib/${ARCH}-linux-gnu/prrte3/share/prte/
  gzip -d /usr/lib/${ARCH}-linux-gnu/prrte3/share/prte/help-prun.txt.gz ;
fi

# https://github.com/open-mpi/ompi/issues/12517
echo "export OMPI_MCA_osc=sm" >> /etc/bash.bashrc
echo "export OMPI_MCA_osc=sm" > /etc/profile.d/patch_mpi.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /var/cache/*
rm -rf /var/log/*
