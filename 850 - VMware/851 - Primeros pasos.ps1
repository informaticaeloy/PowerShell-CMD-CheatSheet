# Instalación del módulo en powershell
Install-Module VMware.PowerCLI
  # Si da problemas 
  Install-Module VMware.PowerCLI -AllowClobber

# Si hay problemas de certificado
Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

# Conexión al vCenter
$vcenter = "vcenter-server.dominio.loc"
Connect-VIServer -Server $vcenter
