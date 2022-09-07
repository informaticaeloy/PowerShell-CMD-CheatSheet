# en local
Get-CimInstance -ClassName Win32_PrinterShare
# en remoto
Get-CimInstance -ClassName Win32_PrinterShare -Computername "NOMBRE_EQUIPO"
