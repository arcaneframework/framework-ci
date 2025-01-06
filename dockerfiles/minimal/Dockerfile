# Ubuntu 22.04 minimal dependencies for Arcane.

FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris
ARG HOME="/root"

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    apt-utils \
    wget \
    curl \
    rsync \
    build-essential \
    gcc-12 g++-12 \
    gcc-11 g++-11 \
    gcc g++ \
    make \
    ccache \
    ninja-build \
    mold \
    iputils-ping \
    python3-dev \
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
    dotnet6 \
    jq \
    \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 90 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 90 \
    && update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-11 90 \
    \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 100 \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 \
    && update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-12 100 \
    \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 100 \
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

# Installation de CMake.
RUN /root/build_scripts/cmake.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de CLang 16.
RUN /root/build_scripts/clang16.sh

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

# Installation de Lima.
RUN /root/build_scripts/lima.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Définition des programmes par défaut.
RUN /root/scripts/default_alternatives.sh
