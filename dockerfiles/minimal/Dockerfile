# Ubuntu 24.04 minimal dependencies for Arcane.
# Version with GCC 14 / CLang 18.

FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris
ARG HOME="/root"

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

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
    python3-pip \
    git \
    gfortran \
    libc6-dev \
    libglib2.0-dev \
    libboost-program-options-dev \
    libopenblas-dev \
    libxml2-dev \
    libhdf5-dev \
    libhdf5-openmpi-dev \
    libopenmpi-dev \
    libmetis-dev \
    libtbb-dev \
    libunwind-dev \
    ca-certificates \
    dotnet8 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-14 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 100 \
    && update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-14 100 \
    \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-18 100 \
    && update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-18 100 \
    \
    && rm -rf /var/lib/apt/lists/*

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Copie des scripts de construction d'image.
COPY build_scripts/ /root/build_scripts/

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de MPICH.
RUN /root/build_scripts/mpich.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de Parmetis.
RUN /root/build_scripts/parmetis.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de packages Python avec PIP.
RUN /root/build_scripts/pip.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Définition des programmes par défaut.
RUN /root/build_scripts/default_alternative.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Copie des scripts pour configurer le container.
COPY scripts/ /root/scripts/
