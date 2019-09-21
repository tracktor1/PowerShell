<#
Save credentials in file repository

DA-#>


$Filename = 'secretfile.txt'
$FolderPath = 'C:\Cred-Rep\'
$Saveto = Join-Path $FolderPath $Filename


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
	Write-Host "[-] File $Filename found in repository, overwrite?"
	$Overwrite = Read-Host '[+] Press [Y] if you want to overwrite or any key to skip'
	if ($Overwrite -eq 'y') {
		$credentials = Get-Credential
		$credentials | Export-CliXml -Path $Saveto
		write-host "[+] Saved credentials in $Saveto" -ForegroundColor Green
	}
	else {
		write-host '[-] No changes made, Did nothing...' -ForegroundColor Yellow
		Exit 1
	}
}
else {
	$credentials = Get-Credential
	$credentials | Export-CliXml -Path $Saveto
	write-host "[+] Saved credentials in $Saveto" -ForegroundColor Green
}