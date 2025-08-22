Connect-ExchangeOnline -UserPrincipalName tu_mail_con_permisos@contoso.com
Get-Mailbox -Identity <ID_de_buzón_ae622c05-077f-fake-a5cd-93f2fakefb61>

#Para ver más claro datos relevantes como el DisplayName o el primarySmtpAddress:
Get-Mailbox -Identity <ID_de_buzón_ae622c05-077f-fake-a5cd-93f2fakefb61> | Format-List DisplayName,PrimarySmtpAddress
