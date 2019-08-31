

$Fileurl = "https://github.com/tracktor1/PowerShell/blob/master/Active%20Directory/Reset%20User%20Password.ps1"
$filetosave = ".\Reset User Password.ps1" 

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $Fileurl -OutFile $filetosave

