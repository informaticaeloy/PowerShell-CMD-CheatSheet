## Descargar todos los mensajes del centro de cuarentena

Connect-MSolservice

$ID = (Get-QuarantineMessage  -StartReceivedDate 07/04/2022 -EndReceivedDate 07/05/2022 | Where {$_.Type -eq 'Software Malicioso'}).Identity

$i = 0

foreach ($cadaID in $ID){ $ExportMessage = Export-QuarantineMessage -Identity $cadaID; $Encoding = [Convert]::FromBase64String($ExportMessage.Eml); [IO.File]::WriteAllBytes("C:\users\usuario\desktop\cuarentena\"+$i+".eml", $Encoding); $i ++}

<#
•	Quarantine reason:
o	Transport rule (mail flow rule)
o	Bulk
o	Spam
o	Malware: Anti-malware policies in EOP or Safe Attachments policies in Defender for Office 365. The Policy Type value indicates which feature was used.
o	Phishing: The spam filter verdict was Phishing or anti-phishing protection quarantined the message (spoof settings or [impersonation protection](set-up-anti-phishing-policies.
o	High confidence phishing
#>
