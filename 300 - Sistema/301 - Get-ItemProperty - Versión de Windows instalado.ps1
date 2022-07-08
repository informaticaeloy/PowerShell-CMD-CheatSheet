## Obtener información de la versión de Windows instalada

Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

## Devulve algo similar a esto:
<#
.OUTPUT
SystemRoot                : C:\Windows
BaseBuildRevisionNumber   : 1
BuildBranch               : vb_release
BuildGUID                 : ffffffff-ffff-ffff-ffff-ffffffffffff
BuildLab                  : 19041.vb_release.191206-1406
BuildLabEx                : 19041.1.amd64fre.vb_release.191206-1406
CompositionEditionID      : Enterprise
CurrentBuild              : 19044
CurrentBuildNumber        : 19044
CurrentMajorVersionNumber : 10
CurrentMinorVersionNumber : 0
CurrentType               : Multiprocessor Free
CurrentVersion            : 6.3
EditionID                 : Professional
EditionSubManufacturer    :
EditionSubstring          :
EditionSubVersion         :
InstallationType          : Client
InstallDate               : 1644506752
ProductName               : Windows 10 Pro
ReleaseId                 : 2009
SoftwareType              : System
UBR                       : 1766
PathName                  : C:\Windows
ProductId                 : 00330-53884-35498-AAOEM
DigitalProductId          : {164, 0, 0, 0...}
DigitalProductId4         : {248, 4, 0, 0...}
InstallTime               : 132889803520196366
DisplayVersion            : 21H2
RegisteredOwner           : usuario
PSPath                    : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion
PSParentPath              : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT
PSChildName               : CurrentVersion
PSDrive                   : HKLM
PSProvider                : Microsoft.PowerShell.Core\Registry
#>
