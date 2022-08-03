Connect-ExchangeOnline

$array = Get-EXOMailBox <mail_del_usuario>

Get-ExoMailboxStatistics -Identity $array.UserPrincipalname -PropertySets All | Format-Table DisplayName, @{Name="Correo";expression={$array.UserPrincipalName}}, ItemCount, TotalItemSize, SystemMessageSizeShutoffQuota

## Nos devuleve algo similar a esto:

## DisplayName        Correo                ItemCount TotalItemSize                SystemMessageSizeShutoffQuota
## -----------        ------                --------- -------------                -----------------------------
## John Doe           johndoe@contoso.com        1849 460.6 MB (482,974,254 bytes) 50 GB (53,687,091,200 bytes)
