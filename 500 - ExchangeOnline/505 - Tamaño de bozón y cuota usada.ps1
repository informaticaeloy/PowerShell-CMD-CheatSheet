
$array = Get-EXOMailBox eloyvilla@jorgesl.com
Get-ExoMailboxStatistics -Identity $array.UserPrincipalname -PropertySets All | select DisplayName,ItemCount,TotalItemSize, SystemMessageSizeShutoffQuota, $array.UserPrincipalName

