# Ubuntu 22.04 minimal dependencies for Documentation Arcane.

FROM ghcr.io/arcaneframework/ubuntu-2204:gcc-12_clang-14_minimal

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

RUN apt-get update -y \
    && apt-get install -y texlive-full doxygen graphviz \
    && rm -rf /var/lib/apt/lists/*
