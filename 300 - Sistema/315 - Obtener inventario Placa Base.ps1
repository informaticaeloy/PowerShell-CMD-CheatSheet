# en local
Get-CimInstance -ClassName Win32_Baseboard
# en remoto
Get-CimInstance -ClassName Win32_Baseboard -ComputerName "NOMBRE_EQUIPO"

# Ejemplo
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_Baseboard

# OUTPUT
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_Baseboard

Manufacturer : LENOVO
Model        :
Name         : Placa base
SerialNumber :
SKU          :
Product      : 3168
