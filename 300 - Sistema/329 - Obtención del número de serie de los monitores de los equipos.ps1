
$equipos = Get-ADComputer -Filter * -SearchBase "OU=GJZUERA,DC=gj,DC=loc" | select Name

foreach ($equipo in $equipos)
{
    $equipo.name
    
    if (Test-Connection $equipo.name -Quiet)
	{    
        gwmi WmiMonitorID -Namespace root\wmi -ComputerName  $equipo.name | Select @{n="Serial Number";e={[System.Text.Encoding]::ASCII.GetString($_.SerialNumberID -ne 00)}}
    }
    
}
