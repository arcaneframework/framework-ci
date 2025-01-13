# Ubuntu 22.04 minimal dependencies for Arcane.

FROM ubuntu:22.04

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

# On installe les packages pour compiler Arcane.
RUN /root/build_scripts/minimal_apt.sh

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
