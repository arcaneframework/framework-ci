# Ubuntu 26.04 minimal dependencies for Arcane.

FROM ubuntu:26.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Paris
ARG HOME="/root"

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation des packages principaux avec apt.
COPY build_scripts/minimal_apt.sh /root/build_scripts/minimal_apt.sh
RUN /root/build_scripts/minimal_apt.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de MPICH.
COPY build_scripts/mpich.sh /root/build_scripts/mpich.sh
RUN /root/build_scripts/mpich.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de Parmetis.
COPY build_scripts/parmetis.sh /root/build_scripts/parmetis.sh
RUN /root/build_scripts/parmetis.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de packages Python avec PIP.
COPY build_scripts/pip.sh /root/build_scripts/pip.sh
RUN /root/build_scripts/pip.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de Lima.
COPY build_scripts/lima.sh /root/build_scripts/lima.sh
RUN /root/build_scripts/lima.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Installation de MEDFile.
COPY build_scripts/medfile.sh /root/build_scripts/medfile.sh
RUN /root/build_scripts/medfile.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------

# Copie des scripts pour configurer le container.
COPY scripts/ /root/scripts/

# Définition des programmes par défaut.
RUN /root/scripts/default_alternatives.sh

#---------------------------------------------------------------------------
#---------------------------------------------------------------------------
