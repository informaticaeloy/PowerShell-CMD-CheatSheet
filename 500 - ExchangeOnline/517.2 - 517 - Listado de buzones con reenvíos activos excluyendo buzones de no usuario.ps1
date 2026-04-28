Connect-ExchangeOnline

Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox | Where-Object { $_.ForwardingSmtpAddress -ne $null } | Format-Table DisplayName, UserPrincipalName, ForwardingSmtpAddress
