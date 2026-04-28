Connect-ExchangeOnline

Get-Mailbox -ResultSize Unlimited | Where-Object { $_.ForwardingSmtpAddress -ne $null } | Format-Table Name, ForwardingSmtpAddress, DeliverToMailboxAndForward
