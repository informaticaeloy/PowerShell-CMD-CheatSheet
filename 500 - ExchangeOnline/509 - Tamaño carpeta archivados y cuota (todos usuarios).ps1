PS C:\Windows\system32> get-mailbox | Get-MailboxFolderStatistics | Where-Object {$_.name -like "Archivos"} | Select identity, Foldersize, storagequota

## Salida:
## Identity              FolderSize    StorageQuota
## --------              ----------    ------------
## John Doe\Archivos     0 B (0 bytes) 48 GB (51,539,607,552 bytes)
## Maikel Nai\Archivos   0 B (0 bytes) 48 GB (51,539,607,552 bytes)
## Llanero solitario\... 0 B (0 bytes) 48 GB (51,539,607,552 bytes)

