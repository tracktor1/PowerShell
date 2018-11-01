


$tt= Get-Date -UFormat "%Y-%m-%d"
Get-Mailbox | Get-MailboxStatistics | Sort totalitemsize -desc | ft displayname, totalitemsize, itemcount > c:\$tt-mailboxes.txt
exit




