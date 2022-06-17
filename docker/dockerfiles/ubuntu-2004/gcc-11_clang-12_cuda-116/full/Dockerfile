# Ubuntu 20.04 full dependencies for Arcane.
# Version with GCC 11 / CUDA 11.6 / CMake 3.21.3.

FROM ghcr.io/arcaneframework/ubuntu-2004:gcc-11_clang-12_cuda-116_minimal

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

# On installe les packages pour compiler Arcane.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    dpkg-dev \
    python3-dev python3-numpy \
    swig4.0 \
    valgrind \
    petsc-dev \
    trilinos-all-dev \
    pd-bsaylor \
    libopenmpi-dev \
    libgtest-dev \
    libtbb-dev \
    libhypre-dev \
    libosmesa6-dev \
    libunwind-dev \
    libptscotch-dev \
    libexpat1-dev \
    libudunits2-dev \
    libmkl-full-dev \
    libbz2-dev \
    liblz4-dev \
    libhypre-dev \
    libpapi-dev \
    libglvnd-dev \
    libgl1-mesa-dev libxt-dev \
    libqt5opengl5-dev qt5-default libqt5x11extras5-dev libqt5help5 qttools5-dev qtxmlpatterns5-dev-tools libqt5svg5-dev \
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
    && wget https://perftools.pages.jsc.fz-juelich.de/cicd/otf2/tags/otf2-2.3/otf2-2.3.tar.gz \
    && tar zxf otf2-2.3.tar.gz \
    && cd otf2-2.3/ \
    && ./configure --prefix=/usr/local --exec-prefix=/usr/local \
    && make \
    && make install \
    && cd / && rm -rf /tmp/*

# On installe Paraview.
RUN cd /tmp \
    && git clone https://gitlab.kitware.com/paraview/paraview.git \
    && cd paraview \
    && git checkout release \
    && git submodule update --init --recursive \
    && mkdir build \
    && cd build \
    && cmake .. -DPARAVIEW_USE_MPI=ON -DVTK_SMP_IMPLEMENTATION_TYPE=TBB -DCMAKE_BUILD_TYPE=Release -GNinja \
    && cmake --build . --target install \
    && cd / && rm -rf /tmp/*
