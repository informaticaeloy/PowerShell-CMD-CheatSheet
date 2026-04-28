Connect-ExchangeOnline

Get-EXOMailbox -ResultSize Unlimited | ForEach-Object {
    Get-InboxRule -Mailbox $_.UserPrincipalName -ErrorAction SilentlyContinue |
    Where-Object { $_.DeleteMessage -eq $true } |
    Select-Object @{Name="Mailbox"; Expression={$_.MailboxOwnerId}},
                  Name,
                  DeleteMessage,
                  Description
} | Export-Csv "C:\Reports\ReglasEliminacion.csv" -NoTypeInformation -Encoding UTF8
