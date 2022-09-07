# en local
(Get-CimInstance -Class Win32_OperatingSystem).InstallDate
# en remoto
PS C:\Windows\system32> (Get-CimInstance -Class Win32_OperatingSystem -ComputerName "NOMBRE_EQUIPO").InstallDate

# Ejemplo
PS C:\Windows\system32> (Get-CimInstance -Class Win32_OperatingSystem).InstallDate

# OUTPUT
jueves, 10 de febrero de 2022 16:25:52
