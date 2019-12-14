

$tt= Get-Date -UFormat "%Y-%m-%d"
$FolderPath = 'C:\MailboxSize\'
$EXdb = Get-MailboxDatabase

# Check if path exists
if (!(Test-Path $FolderPath)){
	write-host "[-] Directory not found, creating..."
	try {
		New-Item -ItemType Directory -Force -Path $FolderPath -ErrorAction stop | Out-Null
	}
	catch {
		write-host 'Script has errors, cannot creat Directory in path' -ForegroundColor red
		Exit 1
	}
}

foreach ($db in $EXdb) {
	$Filename = $tt + '-' + $db.name + '.txt'
	$Saveto = Join-Path $FolderPath $Filename
	Get-Mailbox -Database $db.name | Get-MailboxStatistics | Sort totalitemsize -desc | ft displayname, totalitemsize, itemcount > $Saveto

}
exit
