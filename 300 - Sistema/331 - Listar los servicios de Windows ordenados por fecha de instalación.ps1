Get-Service | ForEach-Object {
    $serviceName = $_.Name
    $service = Get-WmiObject -Class Win32_Service | Where-Object { $_.Name -eq $serviceName }
    if ($service) {
        # Extraer solo la ruta sin parámetros
        $servicePath = $service.PathName -replace '"', '' -replace ' -.*$', ''
        if (Test-Path $servicePath) {
            $fileInfo = Get-Item $servicePath
            [PSCustomObject]@{
                DisplayName = $_.DisplayName
                InstallDate = $fileInfo.CreationTime
            }
        } else {
            # Si no se encuentra el archivo, manejar el caso
            [PSCustomObject]@{
                DisplayName = $_.DisplayName
                InstallDate = "Ruta no válida"
            }
        }
    }
} | Sort-Object InstallDate | Format-Table -AutoSize
