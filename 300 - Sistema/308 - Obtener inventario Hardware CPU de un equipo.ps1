# Información sobre la CPU instalada

# TODA LA INFORMACIÓN DE LA CPU #######################################################################################################
###########################################################################################################################################
## en local
Get-CimInstance -ClassName Win32_Processor
## en remoto
Get-CimInstance -ClassName Win32_Processor -ComputerName "NOMBRE_EQUIPO"

# Ejemplo
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_Processor

# OUTPUT
DeviceID Name                                     Caption                               MaxClockSpeed SocketDesignation Manufacturer
-------- ----                                     -------                               ------------- ----------------- ------------
CPU0     Intel(R) Core(TM) i5-10400 CPU @ 2.90GHz Intel64 Family 6 Model 165 Stepping 3 2904          U3E1              GenuineIntel
