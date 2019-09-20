$credentials = Get-Credential
$filename = 'C:\Cred-safe\secretfile.txt'
$credentials | Export-CliXml -Path $filename

#Test path
if (!(Test-Path $filename -PathType leaf)){
	write-host "File $filename not found, creating..."
	try {
		$Folder = Split-Path -Path $filename
		New-Item -ItemType Directory -Force -Path $Folder -ErrorAction stop | Out-Null
		}
	catch {
		write-host 'Script has errors, cannot creat path' -ForegroundColor red
		Exit 1
		}
	}