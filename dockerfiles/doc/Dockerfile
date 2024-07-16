# Ubuntu 24.04 minimal dependencies for Documentation Arcane.
# Version with Doxygen 1.9.8.

FROM ghcr.io/arcaneframework/ubuntu-2404:minimal_latest

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

RUN apt-get update -y \
    && apt-get install -y texlive-full graphviz python3-sphinx python3-breathe python3-exhale doxygen \
    && rm -rf /var/lib/apt/lists/*
