# Mise en place de l'environnement d'intégration continue
include(${CMAKE_CURRENT_LIST_DIR}/CommonFunctions.cmake)

# Vérifie les arguments obligatoires
if (NOT NUGET_PASSWORD)
  message(FATAL_ERROR "NUGET_PASSWORD is not defined")
endif()

if (WIN32)
  # Récupère et installe Microsoft MPI
  do_command(${CMAKE_CURRENT_LIST_DIR}/download_mswin_10.bat)
endif()

if (UNIX)
  # Récupère la dernière version de Nuget car elle n'est pas installée par défaut
  # sur les conteneurs ubuntu
  do_command("sudo" "curl" "-o" "/usr/local/bin/nuget.exe" "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe")
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
