# en local
Get-CimInstance -ClassName Win32_ComputerSystem
# en remoto
Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName "NOMBRE_EQUIPO"

# Ejemplo
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_ComputerSystem

#OUTPUT

Name             PrimaryOwnerName                Domain                         TotalPhysicalMemory            Model                          Manufacturer
----             ----------------                ------                         -------------------            -----                          ------------
PC-FAKE001       usuario                         local                          16912310272                    11EVFKFKSP                     LENOVO
