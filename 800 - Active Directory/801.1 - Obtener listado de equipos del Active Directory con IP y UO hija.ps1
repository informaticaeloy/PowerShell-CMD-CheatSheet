$equipos = Get-ADComputer -Filter * -SearchBase "OU=tu_unidad_organizativa,OU=tu_unidad_organizativa_padre,DC=tu_dominio,DC=loc" -Properties Name, DistinguishedName, OperatingSystem 

# Crear un array para almacenar los resultados
$resultados = @()

foreach ($equipo in $equipos)
{
    # Obtener todas las OUs del DistinguishedName
    $distinguishedName = $equipo.DistinguishedName
    
    # Dividimos el DN por comas y filtramos solo las OUs
    $partes = $distinguishedName -split ','
    $ous = $partes | Where-Object { $_ -like "OU=*" } | ForEach-Object { $_ -replace '^OU=', '' }
    
    # Crear un objeto base con la información del equipo
    $objeto = [PSCustomObject]@{
        Nombre = $equipo.Name
        IP = $null
        Sistema_Operativo = $equipo.OperatingSystem
    }
    
    # Añadir cada OU como una columna dinámica
    $contador = 1
    foreach ($ou in $ous) {
        $nombreColumna = "OU_Nivel$contador"
        $objeto | Add-Member -MemberType NoteProperty -Name $nombreColumna -Value $ou
        $contador++
    }
    
    # Si no hay OUs, poner un valor por defecto
    if ($ous.Count -eq 0) {
        $objeto | Add-Member -MemberType NoteProperty -Name "OU_Nivel1" -Value "Sin OU"
    }
    
    # Obtener la IP del equipo
    try {
        $ip = [System.Net.Dns]::GetHostEntry($equipo.Name) | 
              Select-Object -ExpandProperty AddressList | 
              Where-Object {$_.AddressFamily -eq 'InterNetwork'} | 
              Select-Object -First 1
        $objeto.IP = $ip.IPAddressToString
    }
    catch {
        $objeto.IP = "No disponible"
    }
    
    # Añadir el objeto al array de resultados
    $resultados += $objeto
}

# MOSTRAR EN PANTALLA (TABLA)
Write-Host "`n=== RESULTADOS EN TABLA ===" -ForegroundColor Green
$resultados | Format-Table -AutoSize

# EXPORTAR A CSV
$rutaCSV = "C:\temp\equipos_jerarquia_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv"
$resultados | Export-Csv -Path $rutaCSV -NoTypeInformation -Encoding UTF8

Write-Host "`n=== ARCHIVO CSV GENERADO ===" -ForegroundColor Green
Write-Host "Ruta: $rutaCSV" -ForegroundColor Yellow
