### DEL EQUIPO LOCAL

Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber | Select-Object -ExpandProperty SerialNumber


### DE UN EQUIPO REMOTO

Get-CimInstance -ComputerName "nombre-del-host" -ClassName Win32_BIOS -Property SerialNumber | Select-Object -ExpandProperty SerialNumber
