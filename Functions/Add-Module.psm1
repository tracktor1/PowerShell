<#
	.NAME
		Add-Module
	
	.SYNOPSIS
		Add-Module - will check if module exists and if not will try to import/install it.
	
	.DESCRIPTION 
		This function checks if module exists and if not will try to import/install it.

	.PARAMETER Mname
		Module name to be installed
	
    .EXAMPLE
		Add-Module -Mname AzureAD
DA-#>
Function Add-Module {
	Param (
	[Parameter(Mandatory=$true)] [string]$Mname
	)


	# Check if module is enabled, if not try to import.
	if (Get-Module -ListAvailable | Where-Object {$_.Name -eq $Mname}) {
		Import-Module $Mname -Scope Global -ErrorAction stop
	}
	else {
		try {
			# If module is not imported or not available on disk, try import from online gallery.
			if (Find-Module -Name $Mname -ErrorAction stop | Where-Object {$_.Name -eq $Mname}) {
				try {
				Install-Module -Name $Mname -Force -Scope CurrentUser -ErrorAction stop
				}
				catch {
				write-host 'Install-Module' $Mname ' error'
				}
				try {
				Import-Module $Mname -Scope Global -ErrorAction stop
				}
				catch {
				write-host 'Import-Module' $Mname ' after install module error'
				}
			}
		}
		catch {
		write-host 'Find-Module' $Mname ' error module not found'
		}
	}
}