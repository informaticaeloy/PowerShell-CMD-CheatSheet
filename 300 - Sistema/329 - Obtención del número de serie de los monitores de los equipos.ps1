### En local 
gwmi WmiMonitorID -Namespace root\wmi | Select @{n="Serial Number";e={[System.Text.Encoding]::ASCII.GetString($_.SerialNumberID -ne 00)}}


## Para todos los equipos de tu AD
$equipos = Get-ADComputer -Filter * -SearchBase "OU=tu_unidad_organizativa,DC=tu_dominio,DC=loc" | select Name

foreach ($equipo in $equipos)
{
    $equipo.name
    
    if (Test-Connection $equipo.name -Quiet)
	{    
        gwmi WmiMonitorID -Namespace root\wmi -ComputerName  $equipo.name | Select @{n="Serial Number";e={[System.Text.Encoding]::ASCII.GetString($_.SerialNumberID -ne 00)}}
    }
    
}
