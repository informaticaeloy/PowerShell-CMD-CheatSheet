# Revisa el CSV para que tenga 4 campos (ver fichero '111 - CSV to XML Zabbix importer.csv'):
#  - Nombre del equipo
#  - IP address
#  - Grupo al que se añadirá en Zabbix (ha de existir en Zabbix)
#  - Plantilla a aplicar en Zabbix (ha de existir en Zabbix)
# Ver XML de ejemplo también (fichero '111 - CSV to XML Zabbix importer.xml')

# Script para convertir CSV a XML de Zabbix
$csvPath = ".\111 - CSV to XML Zabbix importer.csv"
$xmlPath = ".\111 - CSV to XML Zabbix importer.xml"


# Verificar que el archivo existe
if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: No se encuentra el archivo $csvPath" -ForegroundColor Red
    exit 1
}
# Importar CSV
try {
    $computers = Import-Csv -Path $csvPath -Delimiter ';' -Header @("nombre", "ip", "grupo", "plantilla") -Encoding UTF8
    Write-Host "Se encontraron $($computers.Count) equipos en el CSV" -ForegroundColor Green
} catch {
    Write-Host "ERROR al leer el CSV: $_" -ForegroundColor Red
    exit 1
}

# Función para limpiar el nombre DNS
function Get-CleanDnsName {
    param([string]$name)
    
    # Eliminar espacios
    $cleanName = $name -replace '\s+', ''
    
    # Reemplazar otros caracteres problemáticos si es necesario
    # $cleanName = $cleanName -replace '[^\w\.-]', ''
    
    return $cleanName
}

$hosts = ""

foreach ($pc in $computers) {
    # Obtener valores y limpiar
    $hostName = $pc.nombre.Trim()
    $hostIP = $pc.ip.Trim()
    $hostGroup = $pc.grupo.Trim()
    $hostTemplate = $pc.plantilla.Trim()
    
    # Crear un nombre DNS limpio (SIN ESPACIOS)
    $dnsName = Get-CleanDnsName -name $hostName
    
    # Obtener nombre corto (para el campo "name")
    if ($hostName -match '^(.*?)\.') {
        $hostShort = $matches[1]
    } else {
        $hostShort = $hostName
    }
    
    Write-Host "Procesando: $hostName" -ForegroundColor Yellow
    Write-Host "  DNS Name: $dnsName" -ForegroundColor Gray
    
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
                        <community>{$SNMP_COMMUNITY}</community>
                    </details>
                    <interface_ref>if1</interface_ref>
                </interface>
            </interfaces>
            <inventory_mode>DISABLED</inventory_mode>
        </host>

"@
    
    $hosts += $singlehost
}

# Construir el XML completo
$xml = @"
<?xml version="1.0" encoding="UTF-8"?>
<zabbix_export>
    <version>5.0</version>
    <date>2021-01-19T03:07:54Z</date>
    <groups>
        <group>
            <name>$hostGroup</name>
        </group>
    </groups>
    <hosts>
$hosts
    </hosts>
</zabbix_export>
"@

# Guardar el archivo XML sin BOM
try {
    $Utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($xmlPath, $xml, $Utf8NoBom)
    Write-Host "`nArchivo XML generado correctamente: $xmlPath" -ForegroundColor Green
} catch {
    Write-Host "ERROR al guardar el archivo: $_" -ForegroundColor Red
}
