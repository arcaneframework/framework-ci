# Ubuntu 24.04 full dependencies for Arcane.

FROM ghcr.io/arcaneframework/ubuntu-2404:minimal_latest

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Copie des scripts de construction d'image.
COPY build_scripts/ /root/build_scripts/

# Copie des scripts pour configurer le container.
COPY scripts/ /root/scripts/

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation des packages avec apt.
RUN /root/build_scripts/full_apt.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de IceT.
RUN /root/build_scripts/icet.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de Cuda.
RUN /root/build_scripts/cuda.sh
ENV PATH="/usr/local/cuda/bin${PATH:+:$PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de ROCM.
RUN /root/build_scripts/rocm.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de AdaptiveCPP.
RUN /root/build_scripts/adaptivecpp.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de VTK.
RUN /root/build_scripts/vtk.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Création du launcher de clang++-18 avec toolchain g++-13.
RUN /root/build_scripts/patch_clang-18.sh
