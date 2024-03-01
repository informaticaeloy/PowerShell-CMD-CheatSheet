### Buscar los LASTLOGON de los usuarios de una UO
Get-ADUser -SearchBase $OU -Filter * -Properties lastLogon

### Bucle que recupera los nombres de los DC del dominio y les consulta sobre los usuarios del mismo, mostrando la fecha y hora del LASTLOGON
$(foreach ($DC in (get-addomaincontroller -filter * | select-object name, site ) )
{ 
Get-ADUser -Filter * -Properties lastLogon | 
    Select-Object Name,
                  SamAccountName,
                  @{Name="DC Name & Site"; Expression = {$DC.name+" - "+$DC.site} },
                  @{Name="LastLogon"; Expression={[DateTime]::FromFileTime($_.lastLogon)}}
}  ) | Export-CSV -Path "c:\temp\user_last_login.csv" -NoTypeInformation
