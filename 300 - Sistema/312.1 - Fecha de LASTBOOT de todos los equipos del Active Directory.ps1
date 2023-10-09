$equipos = Get-ADComputer -Filter * -SearchBase "OU=tu_unidad_organizativa,OU=tu_unidad_organizativa_padre,DC=tu_dominio,DC=loc" | select Name

foreach ($equipo in $equipos)
{
    "Consultando -> " $equipo.name
    #Start-Sleep -s 1
    if (Test-Connection $equipo.Name -Quiet)
    {
        try
        {
            Get-CimInstance -Class Win32_OperatingSystem -ComputerName $equipo.Name  | select LastBootUpTime
            
        }
        catch 
        {
            write-host $equipo.Name " *** ERROR - No se consigue obtener el dato" 
        }
    }
    else
    {
        write-host $equipo.Name " *** ERROR - Equipo sin conexión" 
    }
}
