## Comandos para obtener información del estado de la licencia del servicio de escritorio remoto 
Get-RDLicenseConfiguration

## Comandos para ver los días de gracias restantes de la licencia del servidor de escritorio remoto

$GracePeriod = (Invoke-WmiMethod -PATH (gwmi -namespace root\cimv2\terminalservices -class win32_terminalservicesetting).__PATH -name GetGracePeriodDays).daysleft 
Write-Host -fore Green ====================================================== 
Write-Host -fore Green 'Terminal Server (RDS) grace period Days remaining are' : $GracePeriod 
Write-Host -fore Green ======================================================   
