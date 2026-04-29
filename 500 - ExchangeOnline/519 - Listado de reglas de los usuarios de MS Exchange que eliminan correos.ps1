Connect-ExchangeOnline

Get-EXOMailbox -ResultSize Unlimited | ForEach-Object {
    Get-InboxRule -Mailbox $_.UserPrincipalName -ErrorAction SilentlyContinue |
    Where-Object { $_.DeleteMessage -eq $true } |
    Select-Object @{Name="Mailbox"; Expression={$_.MailboxOwnerId}},
                  Name,
                  DeleteMessage,
                  Description
} | Export-Csv "C:\Reports\ReglasEliminacion.csv" -NoTypeInformation -Encoding UTF8




#### VERSION MEJORADA
Get-EXOMailbox -ResultSize Unlimited | ForEach-Object {
    $mailbox = $_
    
    Get-InboxRule -Mailbox $mailbox.UserPrincipalName -ErrorAction SilentlyContinue |
    Where-Object { $_.DeleteMessage -eq $true } |
    Select-Object @{Name="MailboxUPN"; Expression={$mailbox.UserPrincipalName}},
                  @{Name="MailboxDisplayName"; Expression={$mailbox.DisplayName}},
                  @{Name="MailboxAlias"; Expression={$mailbox.Alias}},
                  Name,
                  DeleteMessage,
                  Description,
                  StopProcessingRules
} | Export-Csv "C:\temp\ReglasEliminacion.csv" -NoTypeInformation -Encoding UTF8
