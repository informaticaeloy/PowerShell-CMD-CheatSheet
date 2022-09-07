# en local
Get-CimInstance -ClassName Win32_BIOS
# en remoto
Get-CimInstance -ClassName Win32_BIOS -ComputerName "NOMBRE_EQUIPO"

# Ejemplo
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_BIOS

# OUTPUT

SMBIOSBIOSVersion : M2T4DRDA
Manufacturer      : LENOVO
Name              : M2TCCTVD1
SerialNumber      : PC2WMBDER
Version           : LENOVO - 14D0
