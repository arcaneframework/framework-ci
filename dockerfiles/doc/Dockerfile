# Ubuntu 24.04 minimal dependencies for Documentation Arcane.
# Version with Doxygen 1.13.2.

FROM ghcr.io/arcaneframework/ubuntu-2404:minimal_latest

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Copie des scripts de construction d'image.
COPY build_scripts/ /root/build_scripts/

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation des packages avec apt.
RUN /root/build_scripts/doc_apt.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de Doxygen.
RUN /root/build_scripts/doxygen.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------
