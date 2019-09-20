$credentials = Get-Credential
$filename = 'secretfile.txt'
$Filepath = 'C:\Cred-safe\'
$credentials | Export-CliXml -Path $filename

# Check if $filename is directory or file
if ((Get-Item $filename) -is [System.IO.DirectoryInfo]) {
	write-host = "xxxxxx"
	}
else {
	write-host = "YYYYYY"
}
#Test path exists
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