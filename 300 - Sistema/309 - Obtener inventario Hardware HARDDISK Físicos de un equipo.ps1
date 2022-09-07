# Información sobre el HARD DISK instalada

# TODA LA INFORMACIÓN DE LOS DISCOS DUROS FÍSICOS #########################################################################################
###########################################################################################################################################
## en local
Get-CimInstance -ClassName Win32_LogicalDisk
## en remoto
Get-CimInstance -ClassName Win32_PhysicalMedia -ComputerName "NOMBRE_EQUIPO"

# Ejemplo:
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_PhysicalMedia

# OUTPUT
Caption              :
Description          :
InstallDate          :
Name                 :
Status               :
CreationClassName    :
Manufacturer         :
Model                :
OtherIdentifyingInfo :
PartNumber           :
PoweredOn            :
SerialNumber         : 5002FAKE6B7107AC
SKU                  :
Tag                  : \\.\PHYSICALDRIVE1
Version              :
HotSwappable         :
Removable            :
Replaceable          :
Capacity             :
CleanerMedia         :
MediaDescription     :
MediaType            :
WriteProtectOn       :
PSComputerName       :
