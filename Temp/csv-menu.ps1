$csv = Import-CSV -Path .\csv-menu.csv


foreach($Line in $csv) {
	$menuorder = $Line.order
	$menudesc = $Line.description
	$menudo = $Line.do
	Write-Host "[+] $menuorder - $menudesc"
}

[int]$ans = Read-Host 'Please select menu item to run 1,2,3...'
$selection = $csv[$ans-1]
write-host $selection
$selection.do