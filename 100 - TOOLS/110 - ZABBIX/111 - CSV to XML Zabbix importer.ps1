# Revisa el CSV para que tenga 4 campos (ver fichero '111 - CSV to XML Zabbix importer.csv'):
#  - Nombre del equipo
#  - IP address
#  - Grupo al que se añadirá en Zabbix (ha de existir en Zabbix)
#  - Plantilla a aplicar en Zabbix (ha de existir en Zabbix)
# Ver XML de ejemplo también (fichero '111 - CSV to XML Zabbix importer.xml')

# Script para convertir CSV a XML de Zabbix

$csvPath = ".\111 - CSV to XML Zabbix importer.csv"
$xmlPath = ".\111 - CSV to XML Zabbix importer.xml"

# Definir la comunidad SNMP
$SNMP_COMMUNITY = "public"

# Verificar que el archivo existe
if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: No se encuentra el archivo $csvPath" -ForegroundColor Red
    exit 1
}

# Importar CSV
try {
    $computers = Import-Csv -Path $csvPath -Delimiter ';' -Header @("nombre", "ip", "grupo", "plantilla") -Encoding UTF8
    Write-Host "Se encontraron $($computers.Count) equipos en el CSV" -ForegroundColor Green
}
catch {
    Write-Host "ERROR al leer el CSV: $_" -ForegroundColor Red
    exit 1
}

# Función para limpiar el nombre DNS
function Get-CleanDnsName {
    param([string]$name)

    $cleanName = $name -replace '\s+', ''
    $cleanName = $cleanName -replace '[^a-zA-Z0-9\.-]', ''

    return $cleanName
}

# Hash para almacenar grupos únicos
$gruposUnicos = @{}
$hosts = ""

foreach ($pc in $computers) {

    $hostName = $pc.nombre.Trim()
    $hostIP = $pc.ip.Trim()
    $hostGroup = $pc.grupo.Trim()
    $hostTemplate = $pc.plantilla.Trim()

    $gruposUnicos[$hostGroup] = $true

    $dnsName = Get-CleanDnsName -name $hostName

    if ($hostName -match '^(.*?)\.') {
        $hostShort = $matches[1]
    }
    else {
        $hostShort = $hostName
    }

    Write-Host "Procesando: $hostName" -ForegroundColor Yellow
    Write-Host "  DNS Name: $dnsName" -ForegroundColor Gray
    Write-Host "  Grupo: $hostGroup" -ForegroundColor Gray
    Write-Host "  Plantilla: $hostTemplate" -ForegroundColor Gray

$singlehost = @"
        <host>
            <host>$hostName</host>
            <name>$hostShort</name>
            <templates>
                <template>
                    <name>$hostTemplate</name>
                </template>
            </templates>
            <groups>
                <group>
                    <name>$hostGroup</name>
                </group>
            </groups>
            <interfaces>
                <interface>
                    <type>SNMP</type>
                    <ip>$hostIP</ip>
                    <dns>$dnsName</dns>
                    <port>161</port>
                    <details>
                        <community>$SNMP_COMMUNITY</community>
                    </details>
                    <interface_ref>if1</interface_ref>
                </interface>
            </interfaces>
            <inventory_mode>DISABLED</inventory_mode>
        </host>

"@

    $hosts += $singlehost
}

# Generar sección de grupos
$gruposXML = ""

foreach ($grupo in $gruposUnicos.Keys) {

$gruposXML += @"
        <group>
            <name>$grupo</name>
        </group>

"@

}

# Construir XML final
$xml = @"
<?xml version="1.0" encoding="UTF-8"?>
<zabbix_export>
    <version>5.0</version>
    <date>$(Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ")</date>
    <groups>
$gruposXML
    </groups>
    <hosts>
$hosts
    </hosts>
</zabbix_export>
"@

# Guardar XML sin BOM
try {

    $Utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($xmlPath, $xml, $Utf8NoBom)

    if (Test-Path $xmlPath) {

        Write-Host ""
        Write-Host "Archivo XML generado correctamente: $xmlPath" -ForegroundColor Green
        Write-Host "Tamaño del archivo: $((Get-Item $xmlPath).Length) bytes" -ForegroundColor Green

        Write-Host ""
        Write-Host "Primeras líneas del XML:" -ForegroundColor Cyan
        Get-Content $xmlPath -TotalCount 10
    }
    else {
        Write-Host "El archivo no se creó correctamente" -ForegroundColor Red
    }

}
catch {

    Write-Host "ERROR al guardar el archivo: $_" -ForegroundColor Red

    try {
        $xml | Out-File -FilePath $xmlPath -Encoding UTF8 -Force
        Write-Host "Archivo guardado con método alternativo" -ForegroundColor Green
    }
    catch {
        Write-Host "ERROR también con método alternativo: $_" -ForegroundColor Red
    }

}

# Resumen
Write-Host ""
Write-Host "RESUMEN:" -ForegroundColor Cyan
Write-Host "  - Equipos procesados: $($computers.Count)" -ForegroundColor White
Write-Host "  - Grupos encontrados: $($gruposUnicos.Count)" -ForegroundColor White
Write-Host "  - Archivo CSV: $csvPath" -ForegroundColor White
Write-Host "  - Archivo XML: $xmlPath" -ForegroundColor White
