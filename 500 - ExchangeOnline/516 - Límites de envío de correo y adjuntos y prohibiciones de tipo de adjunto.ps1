Connect-ExchangeOnline -UserPrincipalName tu_correo@tudominio.com

#Límite de tamaño del mail + los adjuntos
Get-TransportConfig | Format-List MaxSendSize, MaxReceiveSize

# Límites de número de destinatarios
Get-Mailbox -Identity tu_correo@tudominio.com | Format-List RecipientLimits

# Límites de velocidad (mensajes por minuto)
Get-ReceiveConnector | Format-Table Name, MaxMessageSize
Get-SendConnector | Format-Table Name, MaxMessageSize

# Tipos de archivo bloqueados por el módulo de Malware
(Get-MalwareFilterPolicy -Identity "Default").FileTypes

# Tipos de archivo bloqueados por política de Outlook Web App
(Get-OwaMailboxPolicy -Identity "Default").BlockedFileTypes

