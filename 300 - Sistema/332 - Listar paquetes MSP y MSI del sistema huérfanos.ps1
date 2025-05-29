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
$shell = New-Object -ComObject Shell.Application
$installerPath = "C:\Windows\Installer"
$folder = $shell.Namespace($installerPath)

$results = @()

# Obtener productos instalados
$products = Get-WmiObject -Class Win32_Product
$usedFiles = $products | Where-Object { $_.LocalPackage } | Select-Object -ExpandProperty LocalPackage
$usedFiles = $usedFiles | ForEach-Object { $_.ToLower() }

# Función para obtener propiedad extendida por nombre
function Get-ShellProperty {
    param ($folder, $item, $propertyName)
    for ($i = 0; $i -lt 266; $i++) {
        if ($folder.GetDetailsOf($folder.Items, $i) -eq $propertyName) {
            return $folder.GetDetailsOf($item, $i)
        }
    }
    return "No disponible"
}

# Función para obtener SHA256
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

# Analizar cada archivo MSI/MSP
Get-ChildItem -Path $installerPath -Filter *.ms* | ForEach-Object {
    $file = $_
    $item = $folder.ParseName($file.Name)

    $fullPath = $file.FullName
    $lowerPath = $fullPath.ToLower()
    $sizeMB = [Math]::Round($file.Length / 1MB, 2)
    $status = if ($usedFiles -contains $lowerPath) { "EN USO" } else { "HUÉRFANO" }

    $title = Get-ShellProperty $folder $item "Título"
    $author = Get-ShellProperty $folder $item "Autores"
    $comments = Get-ShellProperty $folder $item "Comentarios"

    $creation = $file.CreationTime
    $modification = $file.LastWriteTime
    $sha256 = Get-FileSHA256 $fullPath

    $results += [PSCustomObject]@{
        Ruta               = $fullPath
        Tamaño_MB          = $sizeMB
        Estado             = $status
        Fecha_Creación     = $creation
        Fecha_Modificación = $modification
        Título             = if ($title) { $title } else { "No disponible" }
        Autor              = if ($author) { $author } else { "No disponible" }
        Comentarios        = if ($comments) { $comments } else { "No disponible" }
        SHA256             = $sha256
    }
}

# Exportar a CSV
$csvPath = "$env:USERPROFILE\Desktop\installer_metadatos_completos.csv"
$results | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8

Write-Host "`n✅ Informe generado: $csvPath" -ForegroundColor Green
