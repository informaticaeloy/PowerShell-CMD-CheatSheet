## ----------------------------FORZAR ARCHIVADO------------------

## Referencias -> https://webmakers.co.nz/force-online-archive-to-start-archiving-email/


## Conexión con ExchangeOnline
Connect-ExchangeOnline


## ----------------------------FORZAR PARA 1 USUARIO
Start-ManagedFolderAssistant -Identity "User1"
Start-ManagedFolderAssistant -Identity "user1@example.com"


## ----------------------------FORZAR PARA TODOS USUARIOS
Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize unlimited | ForEach {Start-ManagedFolderAssistant $_.Identity}


## ----------------------------VER SI ESTA ACTIVO
Get-Mailbox -Identity AlexW  | Select ArchiveStatus, ArchiveDatabase


## ----------------------------VER ESTADISTICAS DE ARCHIVADO DE BUZON
Get-MailboxStatistics -Identity AlexW -Archive | Select DisplayName, TotalItemSize, ItemCount
