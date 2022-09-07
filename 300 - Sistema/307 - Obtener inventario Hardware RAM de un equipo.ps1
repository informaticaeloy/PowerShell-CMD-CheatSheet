# Información sobre la memoria RAM instalada

# TODA LA INFORMACIÓN DE LA MEMORIA #######################################################################################################
Get-CimInstance -ClassName Win32_PhysicalMemory

# Ejemplo
# PS C:\Windows\system32> Get-CimInstance -ClassName Win32_PhysicalMemory

# OUTPUT
Caption              : Memoria física
Description          : Memoria física
InstallDate          :
Name                 : Memoria física
Status               :
CreationClassName    : Win32_PhysicalMemory
Manufacturer         : Samsung
Model                :
OtherIdentifyingInfo :
PartNumber           : M378A1K43EB2-CWE
PoweredOn            :
SerialNumber         : 31FAKE8B
SKU                  :
Tag                  : Physical Memory 1
Version              :
HotSwappable         :
Removable            :
Replaceable          :
FormFactor           : 8
BankLabel            : BANK 1
Capacity             : 8589934592
DataWidth            : 64
InterleavePosition   : 1
MemoryType           : 0
PositionInRow        :
Speed                : 3200
TotalWidth           : 64
Attributes           : 1
ConfiguredClockSpeed : 2667
ConfiguredVoltage    : 1200
DeviceLocator        : ChannelA-DIMM1
InterleaveDataDepth  : 2
MaxVoltage           : 1200
MinVoltage           : 1200
SMBIOSMemoryType     : 26
TypeDetail           : 128
PSComputerName       :

# FILTRO DEL FABRICANTE, ZÓCALO FÍSICO DONDE ESTÁ PICHADA Y CAPACIDAD #####################################################################
Get-CimInstance -ClassName Win32_PhysicalMemory | select Manufacturer, BankLabel, Capacity

# Ejemplo
#PS C:\Windows\system32> Get-CimInstance -ClassName Win32_PhysicalMemory | select Manufacturer, BankLabel, Capacity

# OUTPUT
Manufacturer BankLabel   Capacity
------------ ---------   --------
Samsung      BANK 1    8589934592
Crucial      BANK 3    8589934592

# FILTRO DEL FABRICANTE, ZÓCALO FÍSICO DONDE ESTÁ PICHADA, CAPACIDAD, PARTNUMBER Y NÚMERO DE SERIE #########################################
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_PhysicalMemory | select Manufacturer, BankLabel, Capacity, Speed, PartNumber, SerialNumber | FT

Manufacturer BankLabel   Capacity Speed PartNumber           SerialNumber
------------ ---------   -------- ----- ----------           ------------
Samsung      BANK 1    8589934592  3200 M378A1K43EB2-CWE     31FAKE8B
Crucial      BANK 3    8589934592  2667 CT8G4DFRA266.M8FR    E57FAKEF
