import-module activedirectory

# Set local domain name
$domain = "Domain.local"
# OU to search in
$parentOU = 'DC=Domain,DC=local'
# OU to move users to or create is not exists
$OUName = 'Users 2 Delete'
# Move users to OU
$TargetOU = "OU=Users 2 Delete,DC=imco,DC=com"
# Days of inactivity
$DaysInactive = 182
# ----------------------------------------------
$time = (Get-Date).Adddays(-($DaysInactive)) 
$tt= Get-Date -UFormat "%Y-%m-%d"

# Check OU exists
if (Get-ADOrganizationalUnit -Filter "distinguishedName -eq '$TargetOU'") {
  Write-Host "`n $TargetOU already exists. `n"
} else {
  New-ADOrganizationalUnit -Name $OUName -Path $parentOU
}

# Get all AD Users with lastLogonTimestamp less than our time 
Get-ADUser -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp | 
  
# Output hostname and lastLogonTimestamp into CSV 
select-object SamAccountName,@{Name="Time Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}},Enabled,DistinguishedName | export-csv c:\$tt-oldUsers.csv -notypeinformation

#	Take the list and move the old Users to different OU
$OldUsersPath= Import-Csv -Path c:\$tt-oldUsers.csv
 foreach ($item in $OldUsersPath){
    $user = Get-ADUser $item.DistinguishedName
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $TargetOU -Confirm:$false
    Write-Host User account $user.Name has been moved successfully
}