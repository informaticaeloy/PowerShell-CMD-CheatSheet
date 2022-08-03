
$array = Get-EXOMailBox <mail_del_usuario>

Get-ExoMailboxStatistics -Identity $array.UserPrincipalname -PropertySets All | select DisplayName,ItemCount,TotalItemSize, SystemMessageSizeShutoffQuota, $array.UserPrincipalName

