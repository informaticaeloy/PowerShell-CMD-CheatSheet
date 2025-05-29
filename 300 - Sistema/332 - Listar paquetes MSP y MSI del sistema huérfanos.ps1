## SCRIPT QUE REVISA LOS FICHEROS MSP Y MSI DE LA CARPETA C:\WINDOWS\INSTALLER, Y
## GENERA UN CSV CON LAS COLUMNAS  SIGUIENTES: 
##        Ruta               = $path
##        Tamaño_MB          = $sizeMB
##        Estado             = $status -->> PUEDE SER "EN USO" O "HUÉRFANO"
##        Fecha_Creación     = $creationTime
##        Fecha_Modificación = $lastWrite
##        Producto           = $productName
##        Versión            = $productVersion
##        Editor             = $productCompany
##        SHA256             = $sha256
## CON LA INTENCIÓN DE PODER ELIMINARLOS SI NO SON NECESARIOS


# Ejecutar como Administrador
Write-Host "Analizando archivos en C:\Windows\Installer..." -ForegroundColor Cyan

# Obtener productos instalados y sus rutas locales
$products = Get-WmiObject -Class Win32_Product
$usedFiles = $products | Where-Object { $_.LocalPackage } | Select-Object -ExpandProperty LocalPackage
$usedFiles = $usedFiles | ForEach-Object { $_.ToLower() }

# Obtener todos los archivos MSI/MSP
$installerFiles = Get-ChildItem -Path "C:\Windows\Installer" -Filter *.ms* -Recurse

# Resultado
$results = @()

# Función para calcular el SHA256
function Get-FileSHA256($filePath) {
    try {
        $sha256 = [System.Security.Cryptography.SHA256]::Create()
        $stream = [System.IO.File]::OpenRead($filePath)
        $hashBytes = $sha256.ComputeHash($stream)
        $stream.Close()
        return [BitConverter]::ToString($hashBytes) -replace "-", ""
    } catch {
        return "No disponible"
    }
}

foreach ($file in $installerFiles) {
    $path = $file.FullName
    $lowerPath = $path.ToLower()
    $sizeMB = [Math]::Round($file.Length / 1MB, 2)
    $creationTime = $file.CreationTime
    $lastWrite = $file.LastWriteTime
    $status = if ($usedFiles -contains $lowerPath) { "EN USO" } else { "HUÉRFANO" }

    try {
        $versionInfo = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($path)
        $productName = if ($versionInfo.ProductName) { $versionInfo.ProductName } else { "No disponible" }
        $productVersion = if ($versionInfo.ProductVersion) { $versionInfo.ProductVersion } else { "No disponible" }
        $productCompany = if ($versionInfo.CompanyName) { $versionInfo.CompanyName } else { "No disponible" }
    } catch {
        $productName = "No disponible"
        $productVersion = "No disponible"
        $productCompany = "No disponible"
    }

    $sha256 = Get-FileSHA256 -filePath $path

    $results += [PSCustomObject]@{
        Ruta               = $path
        Tamaño_MB          = $sizeMB
        Estado             = $status
        Fecha_Creación     = $creationTime
        Fecha_Modificación = $lastWrite
        Producto           = $productName
        Versión            = $productVersion
        Editor             = $productCompany
        SHA256             = $sha256
    }
}

# Exportar resultados
$csvPath = "$env:USERPROFILE\Desktop\installer_detallado_con_hash.csv"
$results | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "Archivo generado: $csvPath" -ForegroundColor Green
