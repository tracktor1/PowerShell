


$tt= Get-Date -UFormat "%Y-%m-%d"
$das = @{Expression={$_.DeviceAccessState};Label="AccessState";width=11}
$dt = @{Expression={$_.DeviceType};Label="DeviceType";width=25}
get-activesyncdevice | ft -Property UserDisplayName,DeviceID,$das,$dt -AutoSize | Out-String -Width 4096 | out-file -filepath c:\$tt-activesyncdevice-list.txt

exit


