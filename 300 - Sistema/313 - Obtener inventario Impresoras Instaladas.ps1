# en local
Get-CimInstance -ClassName Win32_Printer
# en remoto
Get-CimInstance -ClassName Win32_Printer -ComputerName "NOMBRE_EQUIPO" 

# Ejemplo
PS C:\Windows\system32> Get-CimInstance -ClassName Win32_Printer

# OUTPUT

Name             ShareName                       SystemName                     PrinterState                   PrinterStatus                  Location
----             ---------                       ----------                     ------------                   -------------                  --------
OneNote for W...                                 PC-FAKE001                     0                              3
PDF-XChange Lite                                 PC-FAKE001                     0                              3
Microsoft XPS...                                 PC-FAKE001                     0                              3
Microsoft Pri...                                 PC-FAKE001                     0                              3
Fax                                              PC-FAKE001                     0                              3
