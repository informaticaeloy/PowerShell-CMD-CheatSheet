## Guardar en un array todos los buzones
$MailBox = Get-Mailbox -ResultSize Unlimited

## Recorremos el array obteniendo los datos formateando la salida por pantalla
$MailBox | %{Get-MailboxStatistics -Identity $_.UserPrincipalName | Select DisplayName, ObjectClass, StorageLimitStatus,@{name="TotalItemSize (MB)";
  expression={[math]::Round(([double]$_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},@{name="TotalDeletedItemSize (MB)";
  expression={[math]::Round(($_.TotalDeletedItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},ItemCount,DeletedItemCount,LastLogoffTime,
  LastLogonTime}

## Salida:
## DisplayName               : John Doe
## ObjectClass               : Unknown
## StorageLimitStatus        :
## TotalItemSize (MB)        : 461,75
## TotalDeletedItemSize (MB) : 15,32
## ItemCount                 : 1851
## DeletedItemCount          : 2548
## LastLogoffTime            :
## LastLogonTime             : 04/08/2022 12:26:19

## Si lo queremos exportar a un .CSV, añadimos al final 
## >>| Export-CSV "c:\MailboxesSize.csv" -Encoding utf8 -NoTypeInformation -Delimiter ";" -WarningAction SilentlyContinue
## quedándonos así:

$MailBox | %{Get-MailboxStatistics -Identity $_.UserPrincipalName | Select DisplayName, ObjectClass, StorageLimitStatus,@{name="TotalItemSize (MB)";
  expression={[math]::Round(([double]$_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},@{name="TotalDeletedItemSize (MB)";
  expression={[math]::Round(($_.TotalDeletedItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}},ItemCount,DeletedItemCount,LastLogoffTime,
  LastLogonTime} | Export-CSV "c:\MailboxesSize.csv" -Encoding utf8 -NoTypeInformation -Delimiter ";" -WarningAction SilentlyContinue
