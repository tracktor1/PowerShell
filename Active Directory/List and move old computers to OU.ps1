import-module activedirectory

$domain = "domain.local"  
$TargetOU = "OU=Computers 2 Delete,DC=domian,DC=local"
$DaysInactive = 182
$time = (Get-Date).Adddays(-($DaysInactive)) 
$tt= Get-Date -UFormat "%Y-%m-%d"

# Get all AD computers with lastLogonTimestamp less than our time 
Get-ADComputer -Filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp | 
  
# Output hostname and lastLogonTimestamp into CSV 
select-object DistinguishedName,@{Name="Time Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | export-csv c:\$tt-oldcomp.csv -notypeinformation

#	Take the list and move the old computers to different OU
$OldComputersPath= Import-Csv -Path c:\$tt-oldcomp.csv
 foreach ($item in $OldComputersPath){
    $computer = Get-ADComputer $item.DistinguishedName
    Move-ADObject -Identity $computer.DistinguishedName -TargetPath $TargetOU -Confirm:$false
    Write-Host Computer account $computer.Name has been moved successfully
}