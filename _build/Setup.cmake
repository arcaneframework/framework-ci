# Mise en place de l'environnement d'intégration continue
include(${CMAKE_CURRENT_LIST_DIR}/CommonFunctions.cmake)

if (WIN32)
  # Récupère et installe Microsoft MPI
  do_command(${CMAKE_CURRENT_LIST_DIR}/download_mswin_10.bat)
endif()

if (UNIX)
  # Récupère la dernière version de Nuget car elle n'est pas installée par défaut
  # sur les conteneurs ubuntu
  do_command("sudo" "curl" "-o" "/usr/local/bin/nuget.exe" "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe")
endif()
