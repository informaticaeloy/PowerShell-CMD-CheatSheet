# en local
Get-CimInstance -Class Win32_OperatingSystem | select LastBootUpTime
# en remoto
Get-CimInstance -Class Win32_OperatingSystem -ComputerName "inf-iherrero"  | select LastBootUpTime

# Ejemplo
PS C:\Windows\system32> Get-CimInstance -Class Win32_OperatingSystem | select LastBootUpTime

# OUTPUT
jueves, 25 de enero de 2022 06:04:21
