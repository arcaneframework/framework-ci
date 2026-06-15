# Ubuntu 26.04 full dependencies for Arcane.

FROM ghcr.io/arcaneframework/ubuntu-2604:minimal_latest

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation des packages avec apt.
COPY build_scripts/full_apt.sh /root/build_scripts/full_apt.sh
RUN /root/build_scripts/full_apt.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de IceT.
COPY build_scripts/icet.sh /root/build_scripts/icet.sh
RUN /root/build_scripts/icet.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de Cuda.
COPY build_scripts/cuda.sh /root/build_scripts/cuda.sh
RUN /root/build_scripts/cuda.sh
ENV PATH="/usr/local/cuda/bin${PATH:+:$PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de ROCM.
COPY build_scripts/rocm.sh /root/build_scripts/rocm.sh
RUN /root/build_scripts/rocm.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de AdaptiveCPP.
COPY build_scripts/adaptivecpp.sh /root/build_scripts/adaptivecpp.sh
RUN /root/build_scripts/adaptivecpp.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de VTK.
COPY build_scripts/vtk.sh /root/build_scripts/vtk.sh
RUN /root/build_scripts/vtk.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Copie des scripts pour configurer le container.
COPY scripts/ /root/scripts/

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------
