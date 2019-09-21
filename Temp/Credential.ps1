#$credentials = Get-Credential
$Filename = 'secretfile.txt'
$FolderPath = 'C:\Cred-Rep\'
$Saveto = Join-Path $FolderPath $Filename
#$credentials | Export-CliXml -Path $Saveto

# Check if path exists
if (!(Test-Path $FolderPath)){
	write-host "[-] Directory not found, creating..."
	try {
		New-Item -ItemType Directory -Force -Path $FolderPath -ErrorAction stop | Out-Null
	}
	catch {
		write-host 'Script has errors, cannot creat Directory in path' -ForegroundColor red
		Exit 1
	}
}
# Check if file exists
if ((Test-Path $Saveto -PathType leaf)){
	Write-Host '[-] File $Filename found in repository, overwrite?'
	$Overwrite = Read-Host '[+] Press [Y] if you want to overwrite or any key to skip'
	if ($Overwrite -eq 'y') {
		$credentials = Get-Credential
		$credentials | Export-CliXml -Path $Saveto
		write-host 'Saved credentials in $Saveto' -ForegroundColor Green
	}
	else {
		write-host '[-] Did nothing...' -ForegroundColor Yellow
		Exit 1
	}
	try {
		$Folder = Split-Path -Path $Filename
		New-Item -ItemType Directory -Force -Path $Folder -ErrorAction stop | Out-Null
	}
	catch {
		write-host 'Script has errors, cannot creat path' -ForegroundColor red
		Exit 1
		}
}
else {
	$credentials = Get-Credential
	$credentials | Export-CliXml -Path $Saveto
	write-host 'Saved credentials in $Saveto'
}


<#
# Check if $Filename is directory or file
if ((Get-Item $Filename) -is [System.IO.DirectoryInfo]) {
	write-host = "xxxxxx"
	}
else {
	write-host = "YYYYYY"
}

#Test path exists
if (!(Test-Path $Filename -PathType leaf)){
	write-host "File $Filename not found, creating..."
	try {
		$Folder = Split-Path -Path $Filename
		New-Item -ItemType Directory -Force -Path $Folder -ErrorAction stop | Out-Null
		}
	catch {
		write-host 'Script has errors, cannot creat path' -ForegroundColor red
		Exit 1
		}
	}
if (!(Test-Path $Filepath -PathType leaf)){
	write-host "File $Filename not found, creating..."
	try {
		$Folder = Split-Path -Path $Filename
		New-Item -ItemType Directory -Force -Path $Folder -ErrorAction stop | Out-Null
		}
	catch {
		write-host 'Script has errors, cannot creat path' -ForegroundColor red
		Exit 1
		}
	}
	
#>