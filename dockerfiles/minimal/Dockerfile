# Ubuntu 26.04 minimal dependencies for Arcane.

FROM ubuntu:26.04

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

# Installation de MEDFile.
RUN /root/build_scripts/medfile.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Définition des programmes par défaut.
RUN /root/scripts/default_alternatives.sh
