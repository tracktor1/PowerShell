<#
This script will reset the user password and enable the "user must change password at next logon" checkbox.
it will check if Active Directory module is enabled and try to load it.

DA-#>

# Change to "$false" to deisable the user must change password at next logon 
[bool] $ChngPass = $true
# Clear Errors before starting the script
$error.clear()

# Check if Active Directory module is enabled, if not try to import.
If ( (Get-Module -Name ActiveDirectory -ErrorAction SilentlyContinue) -eq $null ) {
    Try {
        Import-Module ActiveDirectory -ErrorAction stop
    } Catch {
        # capture any failure and display it in the error section, then end the script with a return
        # code of 1 so that CU sees that it was not successful
		write-host '[*]   ----------------------------------------------------------------------------------------'
		write-host '[*]   | RSAT Tools or ActiveDirectory module is not installed on this computer               |'
		write-host '[*]   | Please run: "Add-WindowsFeature RSAT-AD-PowerShell" to install the powershell module |'
		write-host '[*]   ----------------------------------------------------------------------------------------'
        #Write-Error "Not able to load the Module" -ErrorAction Continue
        #Write-Error $Error[1] -ErrorAction Continue
		$error
        Exit 1
    }
}


$User = Read-Host '[+] Username to reset password is'
for ($i=1; $i -le 10; $i++) {
Write-Host '****' -NoNewline
start-sleep -milliseconds 10
}
write-host
# Check if the user exist
Try {
	$Combo = -Join("*",$User,"*")
	write-host $Combo
	$Getuser = Get-ADUser -Filter 'Name -like $Combo' -ErrorAction stop
	foreach($Line in $Getuser) {
		$UserName = $Line.Name
		$UserSam = $Line.SamAccountName
		$userstatus = $Line.Enabled
		write-host '[+] User status is:' $userstatus
		write-host '[+] Please confirm, the user is' $UserName '?'
		$confirmation = Read-Host '[+] Press [Y] to confirm or any key to cancel'
		if ($confirmation -eq 'y') {
			write-host 'user is:' $UserName
			$NewPassword = (Read-Host -Prompt "Provide New Password" -AsSecureString)
			Set-ADAccountPassword -Identity $UserSam -NewPassword $NewPassword -Reset -ErrorAction stop
			Set-Aduser $UserSam -ChangePasswordAtLogon $ChngPass -ErrorAction stop
			write-host  '[+] The password for user:' $UserSam 'was changed'  -ForegroundColor green
			Exit 0
		}
	}
} 
catch {
	write-host 'Script has errors' -ForegroundColor red
	$error
	Exit 1
}

