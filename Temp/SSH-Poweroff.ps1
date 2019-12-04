#Requires -Modules Posh-SSH
<#
This script requires module Posh-SSH to run

DA-#>

#$cred = Get-Credential
$credPath = 'C:\PS\Cred-Rep\cred.txt'
$cred = Import-CliXml -Path $credPath 
$IP = '10.10.10.43'
$runcmd = 'sudo poweroff'

for ($i=0; $i -le 10; $i++) {
	Remove-SSHSession -SessionId $i
}

$session = New-SSHSession -ComputerName $IP -Credential $cred -AcceptKey
Get-SSHSession
$sessionstream = New-SSHShellStream -SessionId $session.SessionId
$sessionstream.read() #| out-null
$user = Invoke-SSHCommand -Sessionid $sessionstream.SessionId -Command "whoami"
$string = "[sudo] password for $($user.output):"
Invoke-SSHStreamExpectSecureAction -Command 'sudo -i' -ShellStream $sessionstream -ExpectString $string -SecureAction $cred.password
$sessionstream.read()
Start-Sleep -Seconds 1
Invoke-SSHStreamShellCommand -ShellStream $sessionstream -Command $runcmd
Start-Sleep -Seconds 5
$sessionstream.read()
Remove-SSHSession -SessionId $session.SessionId



