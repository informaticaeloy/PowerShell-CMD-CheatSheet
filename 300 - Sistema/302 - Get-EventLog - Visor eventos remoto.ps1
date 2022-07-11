Get-EventLog -LogName System -ComputerName <nombre_equipo_remoto> | Where-Object {$_.EventID -eq <event_ID>}

## Origen del Registro
## -LogName: System, Installation, hardwareEvents, Application, Security
## EventID:
##  6008 - Reinicio 
##  1074 - Apagado forzado

## EventID -> Windows Security Log Events
##  https://www.ultimatewindowssecurity.com/securitylog/encyclopedia/default.aspx
