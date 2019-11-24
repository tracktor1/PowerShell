#Requires -Modules Posh-SSH
<#
This script requires modules SSHSessions OR Posh-SSH

DA-#>

$cred = Get-Credential
#$credPath = 'C:\PS\Cred-Rep\cred.txt'
#$cred = Import-CliXml -Path $credPath 
$IP = '10.10.10.20'

for ($i=0; $i -le 10; $i++) {
	Remove-SSHSession -SessionId $i
}

$session = New-SSHSession -ComputerName $IP -Credential $cred -AcceptKey
Invoke-SSHCommandStream -SessionId $session.SessionId -Command "sudo poweroff"
Start-Sleep -Seconds 1
Remove-SSHSession -SessionId $session.SessionId