# Ubuntu 22.04 minimal dependencies for Documentation Arcane.

FROM ghcr.io/arcaneframework/ubuntu-2204:gcc-12_clang-15_minimal_latest

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

RUN apt-get update -y \
    && apt-get install -y texlive-full graphviz \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp \
    && wget https://www.doxygen.nl/files/doxygen-1.9.6.linux.bin.tar.gz \
    && tar xf doxygen-1.9.6.linux.bin.tar.gz \
    && cd /tmp/doxygen-1.9.6/ \
    && make \
    && make install \
    && cd / \
    && rm -rf /tmp/*
