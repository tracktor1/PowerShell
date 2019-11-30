#Requires -Modules Posh-SSH
<#
This script requires module Posh-SSH to run

DA-#>

#$cred = Get-Credential
$credPath = 'C:\PS\Cred-Rep\indeni.txt'
$cred = Import-CliXml -Path $credPath 
$IP = '10.10.10.43'
$runcmd = "sudo apt install open-vm-tools"

for ($i=0; $i -le 10; $i++) {
	Remove-SSHSession -SessionId $i
}

$session = New-SSHSession -ComputerName $IP -Credential $cred -AcceptKey
$sessionstream = New-SSHShellStream -SessionId $session.SessionId
$sessionstream.read() #| out-null
$user = Invoke-SSHCommand -Sessionid $sessionstream.SessionId -Command "whoami"
$string = "[sudo] password for $($user.output):"
Invoke-SSHStreamExpectSecureAction -Command 'sudo -i' -ShellStream $sessionstream -ExpectString $string -SecureAction $cred.password
$sessionstream.read()
Start-Sleep -Seconds 1
$aptstring = "Do you want to continue? [Y/n]"
Invoke-SSHStreamExpectAction -Command $runcmd -ShellStream $sessionstream -ExpectString $aptstring -Action "y"
Start-Sleep -Seconds 10
$sessionstream.read()
Remove-SSHSession -SessionId $session.SessionId



