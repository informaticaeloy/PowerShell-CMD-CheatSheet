Get-EventLog -LogName System -ComputerName <nombre_equipo_remoto> | Where-Object {$_.EventID -eq <event_ID>}
