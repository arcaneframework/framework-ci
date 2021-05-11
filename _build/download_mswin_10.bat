C:\msys64\usr\bin\wget.exe "https://download.microsoft.com/download/a/5/2/a5207ca5-1203-491a-8fb8-906fd68ae623/msmpisetup.exe"
echo "Download finished"
.\msmpisetup.exe -unattend -verbose
dir "C:\Program Files"
dir "C:\Program Files\Microsoft MPI"
dir "C:\Program Files\Microsoft MPI\Bin"
