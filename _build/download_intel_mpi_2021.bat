C:\msys64\usr\bin\wget.exe "https://registrationcenter-download.intel.com/akdlm/IRC_NAS/e9f49ab3-babd-4753-a155-ceeb87e36674/intel-mpi-2021.14.1.8_offline.exe"
echo "Download finished"
.\intel-mpi-2021.14.1.8_offline.exe -s -a --silent --eula=accept
dir "C:\Program Files (x86)"
dir "C:\Program Files (x86)\Intel"
dir "C:\Program Files (x86)\Intel\OneAPI"
dir "C:\Program Files (x86)\Intel\OneAPI\mpi"
