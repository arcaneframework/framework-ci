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
    libhdf5-mpich-dev \
    libopenmpi-dev \
    libmpich-dev \
    libmetis-dev \
    libtbb-dev \
    libunwind-dev \
    ca-certificates \
    dotnet8 \
    && rm -rf /var/lib/apt/lists/*

COPY build_scripts/ /root/build_scripts/
RUN /root/build_scripts/parmetis.sh
RUN /root/build_scripts/mpich.sh
RUN /root/build_scripts/default_alternative.sh

# # On downgrade MPICH de la version 4.2.0 vers la version 4.1.2.
# RUN ARCH=`uname -m` \
#     && if [ "$ARCH" = "x86_64" ]; then \
#       apt-get update -y \
#       && apt-get install -y --no-install-recommends \
#       libhwloc-dev \
#       libucx-dev \
#       \
#       && cd /tmp \
#       \
#       && wget http://launchpadlibrarian.net/714624482/mpich_4.1.2-3_amd64.deb -O mpich.deb \
#       && wget http://launchpadlibrarian.net/714624474/libmpich12_4.1.2-3_amd64.deb -O libmpich12.deb \
#       && wget http://launchpadlibrarian.net/714624463/libmpich-dev_4.1.2-3_amd64.deb -O libmpich-dev.deb \
#       \
#       && dpkg -i mpich.deb libmpich12.deb libmpich-dev.deb \
#       \
#       && rm -rf /var/lib/apt/lists/* \
#       && rm -rf /tmp/* ; \
#     elif [ "$ARCH" = "aarch64" ]; then \
#       : \
#     else \
#       exit 1; \
#     fi


# Installation de PythonNet.
RUN pip install --break-system-packages pythonnet \
    && rm -rf ${HOME}/.cache
