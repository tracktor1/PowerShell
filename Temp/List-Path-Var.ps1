<#
List all paths listetd in PATH variable in a readable way
DA-#>

$PP = $env:path -split ";" 
foreach ($P in $PP) {
	write-host $P -ForegroundColor yellow

}