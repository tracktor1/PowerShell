$csv = Import-CSV -Path .\csv-menu.csv


foreach($Line in $csv) {
	$menuorder = $Line.order
	$menudesc = $Line.description
	$menudo = $Line.do
	Write-Host "[+] $menuorder - $menudesc"
}

$ans = Read-Host 'Please select menu item to run 1,2,3...'
try {
	if($ans -eq "Q") {
	write-host Bay Bay
	break
	}
	$test = [int]$ans
	if ($ans -gt ($csv.count)) {
	write-host Bay Bay
	break
	}
}
catch {
	write-host Bay Bay
	break
}

foreach($Line in $csv) {
	if ($Line.order -eq $ans){
	write-host $Line.do
	}
}
