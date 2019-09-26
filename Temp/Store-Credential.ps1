<#
	.DESCRIPTION
	Save credentials to file and save it in a repository.
	
DA-#>


$Filename = 'admin-pass.txt'
$FolderPath = 'C:\Cred-Rep\'
$Saveto = Join-Path $FolderPath $Filename

Function Store-cred {

	Param (
		# The path to store the log file
		[string]$Savepath
		)
		
	$credentials = Get-Credential
	$user = $credentials.username
	if ($user -eq $null){
		write-host "[-] User cannot be empty..." -ForegroundColor Yellow
		Exit 1
	}
	$credentials | Export-CliXml -Path $Savepath
	write-host "[+] Saved credentials in $Savepath `n" -ForegroundColor Green		
}

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
	write-host "`n"
	Write-Host "[-] File $Filename found in repository, overwrite?" -ForegroundColor Yellow
	$Overwrite = Read-Host '[-] Press [Y] if you want to overwrite or any key to cancel'
	# Get Credential from the users and savit to file
	if ($Overwrite -eq 'y') {
		Store-cred $Saveto
	}
	else {
		write-host '[-] No changes made, Did nothing...' -ForegroundColor Yellow
		Exit 1
	}
}
else {
	Store-cred $Saveto
}