import-module activedirectory

$GroupToList = "TS Users" # Group members to export
$tt= Get-Date -UFormat "%Y-%m-%d"



Get-ADGroupMember -identity $GroupToList | select name | Export-csv -path C:\$tt-$GroupToList-members.csv -NoTypeInformation