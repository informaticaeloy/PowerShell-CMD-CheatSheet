# Información sobre los HARD DISK lógicos instalados

# TODA LA INFORMACIÓN DE LOS DISCOS DUROS LÓGICOS #########################################################################################
###########################################################################################################################################
## en local
Get-CimInstance -ClassName Win32_LogicalDisk
## en remoto
Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName "NOMBRE_EQUIPO"

# Ejemplo:
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_LogicalDisk

# OUTPUT
DeviceID DriveType ProviderName                          VolumeName     Size         FreeSpace
-------- --------- ------------                          ----------     ----         ---------
C:       3                                               Windows       510770802688  354032230400
D:       5
E:       3                                               ALMACEN       478933938176   38109822976
R:       4                                                                  1048576   28946632704
W:       4                                                               1073741824 1467729510400
