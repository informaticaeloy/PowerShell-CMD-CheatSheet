Get-MailboxFolderStatistics -Identity <email_del_usuario> | Where-Object name -EQ Archivos | select identity, Foldersize, storagequota

## Salida:
## Identity                          FolderSize                  StorageQuota
## --------                          ----------                  ------------
## johndoe@contoso.com\Archivos      10.35 MB (10,852,708 bytes) 48 GB (51,539,607,552 bytes)
