Connect-ExchangeOnline  

## En un ejemplo anterior propusimos esto:

$All = Get-Mailbox -ResultSize Unlimited
$All | foreach {Get-MailboxFolderStatistics -Identity $_.Identity -FolderScope SyncIssues| Format-Table Identity,ItemsInFolderAndSubfolders,FolderAndSubfolderSize -AutoSize}

## Salida:
## Identity                                 ItemsInFolderAndSubfolders FolderAndSubfolderSize
## --------                                 -------------------------- ----------------------
## John Doe\Problemas de sincronización                           1567 1.119 GB (1,201,774,630 bytes)
## John Doe\Conflictos                                            1567 1.119 GB (1,201,774,630 bytes)
## John Doe\Errores del servidor                                     0 0 B (0 bytes)
## John Doe\Errores locales                                          0 0 B (0 bytes)

## Pero si la carpeta "SyncIssues" no existe da un error. Con esta mejora, obtenemos el listado de todas las carpetas y comprobamos el nombre a buscar, en este ejemplo es "/syncissues" (ha de tener la "/" delante). Si existe dicha carpeta continíua con el Get-EXOMailboxFolderStatistics. Si no existe salta al siguiente buzón. 

$todas_las_carpetas=(Get-MailboxFolderStatistics -Identity johndoe@comtoso.com).FolderPath

foreach ($cada_carpeta in $todas_las_carpetas)
{
    if ($cada_carpeta -eq "/syncissues")
    {
        Get-EXOMailboxFolderStatistics -Identity johndoe@comtoso.com -Folderscope syncissues
    }
}
