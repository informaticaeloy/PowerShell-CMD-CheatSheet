Connect-ExchangeOnline

Get-Mailbox -ResultSize Unlimited | Where-Object { $_.ForwardingSmtpAddress -ne $null } | Format-Table DisplayName, UserPrincipalName, Alias, ForwardingSmtpAddress, DeliverToMailboxAndForward
