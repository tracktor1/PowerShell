$csv = Import-CSV -Path .\csv-menu.csv


$menu = @{}

foreach($Line in $csv) {
	$menuorder = $Line.order
	$menudesc = $Line.description
	$menudo = $Line.do
	Write-Host "$menuorder. $($processes[$i-1].name)"
	#$menu.Add($i,($processes[$i-1].name)) 
	}
<#
[int]$ans = Read-Host 'Enter selection'
$selection = $menu.Item($ans) ; Get-Process $selection


for ($i=1;$i -le $customerlist.count; $i++) {
    Write-Host "$i. $($customerlist[$i-1].name)"
    $menu.Add($i,($customerlist[$i-1].name))
    }
#>