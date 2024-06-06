C:\msys64\usr\bin\wget.exe "https://registrationcenter-download.intel.com/akdlm/IRC_NAS/a3a49de8-dc40-4387-9784-5227fccb6caa/w_mpi_oneapi_p_2021.12.1.7_offline.exe"
echo "Download finished"
.\w_mpi_oneapi_p_2021.12.1.7_offline.exe -s -a --silent --eula=accept
dir "C:\Program Files (x86)"
dir "C:\Program Files (x86)\Intel"
dir "C:\Program Files (x86)\Intel\OneAPI"
dir "C:\Program Files (x86)\Intel\OneAPI\mpi"
