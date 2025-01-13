# Ubuntu 24.04 minimal dependencies for Arcane.

FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris
ARG HOME="/root"

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Copie des scripts de construction d'image.
COPY build_scripts/ /root/build_scripts/

# Copie des scripts pour configurer le container.
COPY scripts/ /root/scripts/

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation des packages principaux avec apt.
RUN /root/build_scripts/minimal_apt.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de CMake.
RUN /root/build_scripts/cmake.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de CLang 19.
RUN /root/build_scripts/clang.sh

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
