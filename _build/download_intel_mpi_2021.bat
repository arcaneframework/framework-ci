C:\msys64\usr\bin\wget.exe "https://registrationcenter-download.intel.com/akdlm/irc_nas/19160/w_mpi_oneapi_p_2021.8.0.25543_offline.exe"
echo "Download finished"
.\w_mpi_oneapi_p_2021.8.0.25543_offline.exe -s -a --silent --eula=accept
dir "C:\Program Files (x86)"
dir "C:\Program Files (x86)\Intel"
dir "C:\Program Files (x86)\Intel\OneAPI"
dir "C:\Program Files (x86)\Intel\OneAPI\mpi"
