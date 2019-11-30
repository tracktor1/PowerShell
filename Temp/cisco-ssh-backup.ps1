#Requires -Modules Posh-SSH
<#
This script requires modules SSHSessions OR Posh-SSH

DA-#>

#$cred = Get-Credential
$credPath = 'C:\Cred-Rep\cisco-254.txt'
$cred = Import-CliXml -Path $credPath 
$IP = '192.168.2.254'

$runcmd = 'show running-config'

for ($i=0; $i -le 10; $i++) {
	Remove-SSHSession -SessionId $i
}

# Cisco SGXXX Enable/Disable dumping all the output of a show command without prompting
$sg_datadump = 'terminal datadump'
$no_sg_datadump = 'terminal no datadump'

# Cisco ios Enable/Disable dumping all the output of a show command without prompting
$term_length = "terminal length 0"
$no_term_length = "terminal no length"

$session = New-SSHSession -ComputerName $IP -Credential $cred -AcceptKey
Get-SSHSession
$sessionstream = New-SSHShellStream -SessionId $session.SessionId
$sessionstream.read()
Invoke-SSHStreamShellCommand -ShellStream $sessionstream -Command $sg_datadump
Start-Sleep -Seconds 1
#Invoke-SSHStreamShellCommand -ShellStream $sessionstream -Command $runcmd
$sessionstream.WriteLine($runcmd)
Start-Sleep -Seconds 10
$sessionstream.read() | out-file C:\PS\Back\back.txt
Invoke-SSHStreamShellCommand -ShellStream $sessionstream -Command $no_sg_datadump
Remove-SSHSession -SessionId $session.SessionId

<#
$string = "(config)#"
Invoke-SSHStreamExpectSecureAction -Command 'sudo -i' -ShellStream $sessionstream -ExpectString $string -SecureAction $cred.password
$sessionstream.read()
Start-Sleep -Seconds 1
Invoke-SSHStreamShellCommand -ShellStream $sessionstream -Command $runcmd
$sessionstream.read()

Remove-SSHSession -SessionId $session.SessionId
#>
