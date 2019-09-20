<#
	.NAME
		Write-Log
	
	.SYNOPSIS
		Write-Log - Write text to a log file
	
	.DESCRIPTION 
		This function can be used to Write text to a log file with a time stamp

	.PARAMETER LogPath
		Log File location
	
	.PARAMETER ErrorMsg
		The error to write in the log file
	
    .EXAMPLE
		Write-Log -LogPath c:\tmp\error.log -ErrorMsg "Error to log in file"
DA-#>

Function Write-Log {

	Param (
		# The path to store the log file
		[string]$LogPath,
		# The error to write to log file
		[string]$ErrorMsg
		)
	
	$error.clear()
	if (!(Test-Path $LogPath -PathType leaf)){
		write-host "File $LogPath not found, creating..."
		try {
		$Folder = Split-Path -Path $LogPath
		New-Item -ItemType Directory -Force -Path $Folder -ErrorAction stop | Out-Null
		}
	catch {
		write-host 'Script has errors, cannot creat path' -ForegroundColor red
		Exit 1
		}
	}
	$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
	[string]$logit = "$Stamp - $ErrorMsg"
	Add-content $LogPath -value $logit
}