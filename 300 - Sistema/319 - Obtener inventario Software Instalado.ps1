# en local
Get-CimInstance -ClassName Win32_Product
# en remoto
Get-CimInstance -ClassName Win32_Product -ComputerName "NOMBRE_EQUIPO"

# Ejemplo

PS C:\Windows\system32> Get-CimInstance -ClassName Win32_Product

Name             Caption                                Vendor                                 Version                                IdentifyingNumber
----             -------                                ------                                 -------                                -----------------
GoLabel          GoLabel                                GoDEX                                  1.17.0001                              {1F44A7C6-6249-4618-A41D-58734DCA70B8}
Microsoft Off... Microsoft Office Access database en... Microsoft Corporation                  12.0.6612.1000                         {90120000-00D1-0409-0000-0011000FF3CE}
Microsoft Acc... Microsoft Access database engine 20... Microsoft Corporation                  14.0.4763.1000                         {90140000-00D1-0409-0000-00001100F3CE}
Office 16 Cli... Office 16 Click-to-Run Extensibilit... Microsoft Corporation                  16.0.10389.20033                       {90160000-009C-0000-1000-0000000FF3CE}
Office 16 Cli... Office 16 Click-to-Run Localization... Microsoft Corporation                  16.0.10389.20033                       {90160000-009C-0C0A-1000-0000000FF3CE}
Office 16 Cli... Office 16 Click-to-Run Licensing Co... Microsoft Corporation                  16.0.10389.20033                       {90160000-006E-0000-1000-0000000FF3CE}
SSDlife Pro      SSDlife Pro                            BinarySense Inc.                       2.5.67                                 {AF2EBA10-1B9C-4D56-8D02-5342BD9F44D5}
...
...
...
