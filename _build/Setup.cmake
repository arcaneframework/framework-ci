# Il faut CMake 3.18 minimum pour la commande file(ARCHIVE_EXTRACT)
cmake_minimum_required(VERSION 3.18.0)

# Ce script met en place l'environnement pour l'intégration continue pour 'github actions',
# Normalement, on a déjà une version récente de CMake installée (à priori la 3.20.4 en juin 2021)
# On effectue les commandes suivantes:
# - sous windows, téléchargement et installation de 'Microsoft MPI'
# - téléchargement des versions de 'ninja'.
# - sous linux, téléchargement de 'nuget'
# - enregistrement des autorisations pour accéder à 'GitHub packages' via nuget.

include(${CMAKE_CURRENT_LIST_DIR}/CommonFunctions.cmake)

# Vérifie les arguments obligatoires
if (NOT NUGET_PASSWORD)
  message(FATAL_ERROR "NUGET_PASSWORD is not defined")
endif()
set(FRAMEWORKCI_CMAKE_WANTED_VERSION "3.20.2")

# Télécharge une version spécifique de 'cmake' et 'ninja'.
# Cela est nécessaire pour rendre
# la compilation reproductible car le CMake fournit par 'github' pour une
# plateforme donnée est mis à jour régulièrement

if (WIN32)
  # Récupère et installe Microsoft MPI.
  # Cela est nécessaire pour installer ensuite MPI via vcpkg
  do_command(${CMAKE_CURRENT_LIST_DIR}/download_mswin_10.bat)
  # Installe une version récente de cmake via chocolatey
  #do_command(choco install cmake)
  # Installe une version récente de ninja via chocolatey
  message(STATUS "Downloading 'ninja'")
  file(DOWNLOAD "https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-win.zip" "ninja-win.zip")
  message(STATUS "Installating 'ninja' in '${LOCAL_BIN_DIR_BIN}'")
  file(ARCHIVE_EXTRACT INPUT "ninja-win.zip" DESTINATION ${LOCAL_BIN_DIR_BIN})
  message(STATUS "Downloading 'cmake'")
  file(DOWNLOAD "https://github.com/Kitware/CMake/releases/download/v${FRAMEWORKCI_CMAKE_WANTED_VERSION}/cmake-${FRAMEWORKCI_CMAKE_WANTED_VERSION}-win64-x64.zip" "cmake.zip")
  message(STATUS "Extracting 'cmake'")
  file(ARCHIVE_EXTRACT INPUT "cmake.zip" DESTINATION "${LOCAL_BIN_DIR}")
  file(RENAME "${LOCAL_BIN_DIR}/cmake-${FRAMEWORKCI_CMAKE_WANTED_VERSION}-win64-x64" "${LOCAL_BIN_DIR}/cmake")
endif()

if (UNIX)
  # Récupère la dernière version de Nuget car elle n'est pas installée par défaut
  # sur les conteneurs ubuntu

  file(DOWNLOAD "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe" "${LOCAL_BIN_DIR_BIN}/nuget.exe")
  # Récupère une version récente de ninja
  file(DOWNLOAD "https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip" "ninja-linux.zip")
  # Extrait l'archive
  file(ARCHIVE_EXTRACT INPUT "ninja-linux.zip" DESTINATION ${LOCAL_BIN_DIR_BIN})

  message(STATUS "Downloading 'cmake'")
  file(DOWNLOAD "https://github.com/Kitware/CMake/releases/download/v${FRAMEWORKCI_CMAKE_WANTED_VERSION}/cmake-${FRAMEWORKCI_CMAKE_WANTED_VERSION}-Linux-x86_64.tar.gz" "cmake.tar.gz")
  message(STATUS "Extracting 'cmake'")
  file(ARCHIVE_EXTRACT INPUT "cmake.tar.gz" DESTINATION "${LOCAL_BIN_DIR}" VERBOSE)
  file(GLOB LIST_FILES "${LOCAL_BIN_DIR}/*")
  message(STATUS "Extracted files : '${LIST_FILES}'")
  file(RENAME "${LOCAL_BIN_DIR}/cmake-${FRAMEWORKCI_CMAKE_WANTED_VERSION}-Linux-x86_64" "${LOCAL_BIN_DIR}/cmake")
endif()

set(FRAMEWORK_CI_ROOT "${CMAKE_CURRENT_LIST_DIR}/..")

# Positionne les informations (credentials) pour utiliser GitHub packages avec nuget.
# NOTE: pour contourner un bug de vcpkg sous linux (du à l'utilisation de mono avec nuget), il faut
# faire deux configurations, une avec 'dotnet' et une avec 'mono'.
# Le bug se manifeste par des erreurs lors de l'envoi des packages sur 'github.packages'. Il semble que le bug dépende
# de la taille du package.
message(STATUS "Set NuGet credentials")
set(DIRECT_NUGET_EXE "${MONO_EXEC}" "${NUGET_COMMAND}")
if (WIN32)
  set(DIRECT_NUGET_EXE "${NUGET_COMMAND}")
endif()
do_command(${DIRECT_NUGET_EXE} sources add -source "https://nuget.pkg.github.com/arcaneframework/index.json" -storepasswordincleartext -name "github" -username "arcaneframework" -password "${NUGET_PASSWORD}")
set(_NUGET_CONFIG_FILE "${FRAMEWORK_CI_ROOT}/nuget.config")

do_command(dotnet nuget add source "https://nuget.pkg.github.com/arcaneframework/index.json" --name github --username "arcaneframework" --password "${NUGET_PASSWORD}" --store-password-in-clear-text --configfile "${_NUGET_CONFIG_FILE}")
