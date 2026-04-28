Connect-ExchangeOnline

Get-EXOMailbox -ResultSize Unlimited | ForEach-Object {
    Get-InboxRule -Mailbox $_.UserPrincipalName -ErrorAction SilentlyContinue |
    Where-Object { $_.ForwardTo -ne $null -or $_.RedirectTo -ne $null } |
    Select-Object @{Name="Mailbox"; Expression={$_.MailboxOwnerId}},
                  Name,
                  ForwardTo,
                  RedirectTo,
                  Enabled
} | Export-Csv "C:\Temp\ReglasReenvioExterno.csv" -NoTypeInformation -Encoding UTF8
