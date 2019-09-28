$csv = Import-CSV -Path .\csv-menu.csv


foreach($Line in $csv) {
	$menuorder = $Line.order
	$menudesc = $Line.description
	$menudo = $Line.do
	Write-Host "[+] $menuorder - $menudesc"
}

$ans = Read-Host 'Please select menu item to run 1,2,3...'
foreach($Line in $csv) {
	if ($Line.order -eq $ans){
	write-host $Line.do
	}
}

#	$selection = $csv[$ans-1].do
#	write-host $selection
#	#$selection.do