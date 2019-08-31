
# File URL (RAW Link to file)
$Fileurl = "https://raw.githubusercontent.com/tracktor1/PowerShell/master/Active%20Directory/Reset%20User%20Password.ps1"
# Destination file name
$filetosave = ".\Reset User Password.ps1" 

#Use Tls1.2 to avoid Errors
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Invoke-WebRequest -Uri $Fileurl -OutFile $filetosave

