# Pedir nombre del equipo o equipos
$computersInput = Read-Host "Introduce los nombres de los equipos separados por comas"
$computers = $computersInput -split "," | ForEach-Object { $_.Trim() }

$results = @()

foreach ($computer in $computers) {
    Write-Host "Procesando equipo: $computer"
    
    try {
        Invoke-Command -ComputerName $computer -ScriptBlock {
            param($usersFilter)
            $usersPath = "C:\Users"
            $localResults = @()

            Get-ChildItem -Path $usersPath -Directory | ForEach-Object {
                $userName = $_.Name
                if ($usersFilter -and ($userName -notin $usersFilter)) { return }

                $userProfile = $_.FullName

                # Revisar ambas carpetas Default y Default_backup
                $profileFolders = @("Default", "Default_backup")
                foreach ($pf in $profileFolders) {
                    $profilePath = Join-Path -Path $userProfile -ChildPath "AppData\Local\Microsoft\Edge\User Data\$pf"
                    $extensionsPath = Join-Path -Path $profilePath -ChildPath "Extensions"

                    if (Test-Path $extensionsPath) {
                        Get-ChildItem -Path $extensionsPath -Directory | ForEach-Object {
                            $extId = $_.Name
                            Get-ChildItem -Path $_.FullName -Directory | ForEach-Object {
                                $versionPath = $_.FullName
                                $manifestPath = Join-Path -Path $versionPath -ChildPath "manifest.json"

                                $extName = if (Test-Path $manifestPath) {
                                try { (Get-Content $manifestPath -Raw | ConvertFrom-Json).name } catch { $extId }
                                    } else { $extId }

                                $installDate = (Get-Item $versionPath).CreationTime
                                $updateDate  = (Get-Item $versionPath).LastWriteTime

                                $storeLink = "https://microsoftedge.microsoft.com/addons/detail/$($extName -replace ' ','-')/$extId"

                                $localResults += [PSCustomObject]@{
                                    Usuario           = $userName
                                    Equipo            = $env:COMPUTERNAME
                                    PerfilRuta        = $profilePath
                                    ExtensionID       = $extId
                                    Nombre            = $extName
                                    Version           = $_.Name
                                    Ruta              = $versionPath
                                    FechaInstalacion  = $installDate
                                    FechaActualizacion= $updateDate
                                    StoreLink         = $storeLink
                                }
                            }
                        }
                    }
                }

            }

            return $localResults
        } -ArgumentList ($usersToCheck) | ForEach-Object { $results += $_ }
    }
    catch {
        Write-Warning ('No se pudo conectar al equipo ' + $computer + ': ' + $_)
    }
}


# Generar HTML
$html = @"
<!DOCTYPE html>
<html lang='es'>
<head>
<meta charset='UTF-8'>
<title>Reporte de Extensiones Edge</title>
<style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    table { border-collapse: collapse; width: 100%; }
    th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
    th { background-color: #0078D7; color: white; }
    tr:nth-child(even) { background-color: #f2f2f2; }
    tr.separator { background-color: #333; color: white; font-weight: bold; text-align: center; }
    a { color: #0078D7; text-decoration: none; }
    a:hover { text-decoration: underline; }
</style>
</head>
<body>
<h2>Reporte de Extensiones de Edge</h2>
<table>
<tr>
<th>Equipo</th>
<th>Usuario</th>
<th>Nombre</th>
<th>Versión</th>
<th>Ruta</th>
<th>Fecha Instalación</th>
<th>Fecha Actualización</th>
<th>Enlace Tienda</th>
</tr>
"@

# Agrupar resultados por equipo
$results | Sort-Object Equipo, Usuario | Group-Object -Property Equipo | ForEach-Object {
    $teamGroup = $_
    # Fila separadora con el nombre del equipo
    $html += "<tr class='separator'><td colspan='8'>Equipo: $($teamGroup.Name)</td></tr>"

    foreach ($r in $teamGroup.Group) {
        $html += "<tr>"
        $html += "<td>$($r.Equipo)</td>"
        $html += "<td>$($r.Usuario)</td>"
        $html += "<td>$($r.Nombre)</td>"
        $html += "<td>$($r.Version)</td>"
        $html += "<td>$($r.Ruta)</td>"
        $html += "<td>$($r.FechaInstalacion)</td>"
        $html += "<td>$($r.FechaActualizacion)</td>"
        $html += "<td><a href='$($r.StoreLink)' target='_blank'>Abrir Add-on</a></td>"
        $html += "</tr>"
    }
}


$html += "</table></body></html>"

# Guardar HTML en el escritorio del usuario que ejecuta el script
$outputPath = Join-Path -Path ([Environment]::GetFolderPath('Desktop')) -ChildPath "Reporte_Extensiones_Edge.html"
$html | Out-File -FilePath $outputPath -Encoding UTF8

Write-Host "Reporte generado en: $outputPath"
