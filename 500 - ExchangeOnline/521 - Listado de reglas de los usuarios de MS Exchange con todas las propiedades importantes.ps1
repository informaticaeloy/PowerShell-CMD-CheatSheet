Connect-ExchangeOnline

Get-EXOMailbox -ResultSize Unlimited | ForEach-Object {
    Get-InboxRule -Mailbox $_.UserPrincipalName -ErrorAction SilentlyContinue |
    Select-Object @{Name="Mailbox"; Expression={$_.MailboxOwnerId}},
                  Name,
                  Enabled,
                  Priority,
                  Description,
                  DeleteMessage,
                  MoveToFolder,
                  ForwardTo,
                  RedirectTo,
                  StopProcessingRules
} | Export-Csv "C:\Reports\TodasLasReglas_Completo.csv" -NoTypeInformation -Encoding UTF8
