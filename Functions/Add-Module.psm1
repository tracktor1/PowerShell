<#
	.NAME
		Add-Module
	
	.SYNOPSIS
		Add-Module - will check if module exists and if not will try to import/install it.
	
	.DESCRIPTION 
		This function checks if module exists and if not will try to import/install it.

	.PARAMETER name
		Module name to be installed
	
    .EXAMPLE
		Add-Module -name AzureAD
DA-#>
Function Add-Module {
	Param (
	[Parameter(Mandatory=$true)] [string]$name
	)


	# Check if module is enabled, if not try to import.
	if (Get-Module -ListAvailable | Where-Object {$_.Name -eq $name}) {
		Import-Module $name -Scope Global -ErrorAction stop
	}
	else {
		try {
			# If module is not imported or not available on disk, try import from online gallery.
			if (Find-Module -Name $name -ErrorAction stop | Where-Object {$_.Name -eq $name}) {
				# Check if script runs as admin before trying to install module
				if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
				Write-Warning "Cannot install module, script runs as non admin user, please run the script again as Administrator" ; break
				}
				try {
				Install-Module -Name $name -Force -Scope CurrentUser -ErrorAction stop
				}
				catch {
				write-host 'Install-Module' $name ' error'
				}
				try {
				Import-Module $name -Scope Global -ErrorAction stop
				}
				catch {
				write-host 'Import-Module' $name ' --after install module error'
				}
			}
		}
		catch {
		write-host 'Find-Module' $name ' --error module not found in online gallery'
		}
	}
}