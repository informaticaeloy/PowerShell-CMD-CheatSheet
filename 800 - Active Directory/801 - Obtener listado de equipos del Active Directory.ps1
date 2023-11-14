$equipos = Get-ADComputer -Filter * -SearchBase "OU=tu_unidad_organizativa,OU=tu_unidad_organizativa_padre,DC=tu_dominio,DC=loc" | select Name

foreach ($equipo in $equipos)
{
    $equipo.name
    
}
