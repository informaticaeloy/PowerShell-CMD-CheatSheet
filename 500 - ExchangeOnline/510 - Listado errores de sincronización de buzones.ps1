$All = Get-Mailbox -ResultSize Unlimited
$All | foreach {Get-MailboxFolderStatistics -Identity $_.Identity -FolderScope SyncIssues| Format-Table Identity,ItemsInFolderAndSubfolders,FolderAndSubfolderSize -AutoSize}

## Salida:
## Identity                                 ItemsInFolderAndSubfolders FolderAndSubfolderSize
## --------                                 -------------------------- ----------------------
## John Doe\Problemas de sincronización                           1567 1.119 GB (1,201,774,630 bytes)
## John Doe\Conflictos                                            1567 1.119 GB (1,201,774,630 bytes)
## John Doe\Errores del servidor                                     0 0 B (0 bytes)
## John Doe\Errores locales                                          0 0 B (0 bytes)



## Identity                                  ItemsInFolderAndSubfolders FolderAndSubfolderSize
## --------                                  -------------------------- ----------------------
## Maikel Nai\Problemas de sincronización                            92 35.04 MB (36,746,658 bytes)
## Maikel Nai\Conflictos                                             92 35.04 MB (36,746,658 bytes)
## Maikel Nai\Errores del servidor                                    0 0 B (0 bytes)
## Maikel Nai\Errores locales                                         0 0 B (0 bytes)
