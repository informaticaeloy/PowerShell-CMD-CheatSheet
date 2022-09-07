# local
Get-CimInstance -ClassName Win32_OperatingSystem
# remoto
Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName "NOMBRE_EQUIPO"

# Ejemplo
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_OperatingSystem

# OUTPUT
SystemDirectory     Organization BuildNumber RegisteredUser SerialNumber            Version
---------------     ------------ ----------- -------------- ------------            -------
C:\Windows\system32              19044       usuario        00520-53114-32198-AAOEM 10.0.19044

