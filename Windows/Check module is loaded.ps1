<#
This script will check if Active Directory module is enabled.

DA-#>

$error.clear()

# Check if Active Directory module is enabled and try to import.
If ( (Get-Module -Name ActiveDirectory -ErrorAction SilentlyContinue) -eq $null ) {
    Try {
        Import-Module ActiveDirectory -ErrorAction stop
    } Catch {
        # capture any failure and display it in the error section, then end the script with a return
		write-host ''
		write-host '[*]   ----------------------------------------------------------------------------------------'
		write-host '[*]   | RSAT Tools or ActiveDirectory module is not installed or loaded on this computer     |'
		write-host '[*]   | Please run: "Add-WindowsFeature RSAT-AD-PowerShell" to install the powershell module |'
		write-host '[*]   ----------------------------------------------------------------------------------------'
		write-host ''
		$error
        Exit 1
    }
}
