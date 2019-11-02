<#

This script requires a csv file (users.csv) in the same folder
The csv file must contain these column names in order to work:
FirstName,LastName,UserMail,UserPhone,Pass,OuPath

DA-#>

Import-Module activedirectory

# CSV file name and path
$ADUserList = Import-csv .\users.csv
#Active directory distinguished name
$DomainDN = "DC=Domain,DC=local"
#Active directory domain name
$ADdomain = "Domain.local"

foreach ($User in $ADUserList) {
	$Firstname = $User.FirstName
	$Lastname = $User.LastName
	$Password = $User.Pass
	$OU = $User.OuPath
	$Email = $User.UserMail
	$Phone = $User.UserPhone
	
	$usersplit = $Email.split("@")[0]	
	
	#Check to see if the user already exists in AD
	if (Get-ADUser -F {SamAccountName -eq $usersplit}) {
		 #If user exists, give a warning
		 Write-Warning "A user account with username $usersplit already exist in Active Directory."
	}
	else {
	$JoinOU = "OU=$OU,$DomainDN"
	$PrincipalName = $usersplit + "@" + $ADdomain
	New-ADUser -SamAccountName $usersplit -UserPrincipalName $PrincipalName -EmailAddress "$Email" -Name "$Firstname $Lastname" -GivenName $Firstname -Surname $Lastname -Enabled $True -DisplayName "$Firstname $Lastname" -Path $JoinOU -AccountPassword (convertto-securestring $Password -AsPlainText -Force) 
	}
}
