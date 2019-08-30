<#
This script will check if Active Directory module is enabled then ask for the username to reset password.
after reseting the password it will enable the "user must change password at next logon" checkbox.

DA-#>

# Change to $false to deisable the user must change password at next logon 
[bool] $ChngPass = $true

# Check if Active Directory module is enabled, if not try to import.
If ( (Get-Module -Name ActiveDirectory -ErrorAction SilentlyContinue) -eq $null ) {
    Try {
        Import-Module ActiveDirectory -ErrorAction stop
    } Catch {
        # capture any failure and display it in the error section, then end the script with a return
        # code of 1 so that CU sees that it was not successful
		write-host '[*]   ----------------------------------------------------------------------------------------'
		write-host '[*]   | RSAT Tools or ActiveDirectory module is not installed on this computer               |'
		write-host '[*]   | Please install the powershell module needed                                          |'
		write-host '[*]   ----------------------------------------------------------------------------------------'
        #Write-Error "Not able to load the Module" -ErrorAction Continue
        #Write-Error $Error[1] -ErrorAction Continue
        Exit 1
    }
}
import-module servermanager

$User = Read-Host '[+] Username to reset password is'
for ($i=1; $i -le 10; $i++) {
Write-Host '****' -NoNewline
start-sleep -milliseconds 10
}
write-host
# Check if the user exist
Try {
	$Getuser = Get-ADUser $User -ErrorAction stop
	$UserName = $Getuser.Name
	write-host '[+] Please confirm, the user is' $UserName '?'
	$confirmation = Read-Host '[+] [Y] to confirm or any key to cancel'
	if ($confirmation -eq 'y') {
		write-host 'user is:' $UserName
		$NewPassword = (Read-Host -Prompt "Provide New Password" -AsSecureString)
		Set-ADAccountPassword -Identity $User -NewPassword $NewPassword -Reset
		Set-Aduser $User -ChangePasswordAtLogon $ChngPass
	}
	Else {
		Exit 1
	}
} 
catch {
	write-host 'User does not exist check username and try again' -ForegroundColor red
	Exit 1
}




