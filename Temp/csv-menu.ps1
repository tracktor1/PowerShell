$csv = Import-CSV -Path .\csv-menu.csv


foreach($Line in $csv) {
	$menuorder = $Line.order
	$menudesc = $Line.description
	$menudo = $Line.do
	Write-Host $menudesc
}

[int]$ans = Read-Host 'Please select menu item to run'
$selection = $menu.Item($ans) ; Get-Process $selection

