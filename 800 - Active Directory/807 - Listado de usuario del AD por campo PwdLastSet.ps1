Get-ADUser -Filter "*" -Properties PwdLastSet | Sort-Object Name | 
    Select-Object Name, @{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}} | 
    Export-Csv -Path "c:\temp\test.csv" -NoTypeInformation

# Añadiendo el distinguisedName
Get-ADUser -Filter "*" -Properties PwdLastSet, distinguishedName | Sort-Object Name | 
    Select-Object Name, @{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}}, distinguishedName | 
    Export-Csv -Path "c:\temp\test.csv" -NoTypeInformation

# Filtro para UO
Get-ADUser -Filter "*" -SearchBase "OU=Ventas,DC=dominio,DC=com" -Properties PwdLastSet, distinguishedName | 
    Sort-Object Name | 
    Select-Object Name, @{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}}, distinguishedName | 
    Export-Csv -Path "c:\temp\listado_password_rotation.csv" -NoTypeInformation

# Filtro para UO y todas sus sub-UO
Get-ADUser -Filter "*" -SearchBase "OU=Usuarios,DC=dominio,DC=com" -SearchScope Subtree -Properties PwdLastSet, distinguishedName | 
    Sort-Object Name | 
    Select-Object Name, @{Name='PwdLastSet';Expression={[DateTime]::FromFileTime($_.PwdLastSet)}}, distinguishedName | 
    Export-Csv -Path "c:\temp\listado_password_rotation.csv" -NoTypeInformation

# Todo con UO en formato más legible
# Configuración
$UOBase = "OU=Usuarios,DC=dominio,DC=com"  # <-- CAMBIA ESTO

# Obtener usuarios y procesar
Get-ADUser -Filter * -SearchBase $UOBase -SearchScope Subtree -Properties Name, PwdLastSet, DistinguishedName | ForEach-Object {
    # Fecha PwdLastSet
    $fechaPwd = if ($_.PwdLastSet -and $_.PwdLastSet -ne 0) {
        [DateTime]::FromFileTime($_.PwdLastSet)
    } else { "Indeterminado" }
    
    # Extraer UOs del DistinguishedName
    $UOs = ($_.DistinguishedName -split ',') | Where-Object {$_ -like 'OU=*'} | ForEach-Object {$_ -replace '^OU='}
    
    # Crear objeto con propiedades dinámicas
    $props = [ordered]@{
        'Nombre' = $_.Name
        'PwdLastSet' = $fechaPwd
        'DistinguishedName' = $_.DistinguishedName
    }
    
    # Añadir cada UO como columna
    for ($i = 0; $i -lt $UOs.Count; $i++) {
        $props["UO_Nivel$($i+1)"] = $UOs[$i]
    }
    
    [PSCustomObject]$props
} | Export-Csv -Path "C:\temp\usuarios_con_UOs.csv" -NoTypeInformation -Encoding UTF8

# Añadir a las columnas la de Password Never Expire y la fecha de Last Logon
# Configuración
$UOBase = "OU=Usuarios,DC=dominio,DC=com"  # <-- CAMBIA ESTO

# Obtener usuarios y procesar
Get-ADUser -Filter * -SearchBase $UOBase -SearchScope Subtree -Properties Name, PwdLastSet, DistinguishedName, PasswordNeverExpires, LastLogonDate, LastLogon | ForEach-Object {
    # Fecha PwdLastSet
    $fechaPwd = if ($_.PwdLastSet -and $_.PwdLastSet -ne 0) {
        [DateTime]::FromFileTime($_.PwdLastSet)
    } else { "Indeterminado" }
    
    # Fecha LastLogon
    $fechaLogon = if ($_.LastLogonDate) {
        $_.LastLogonDate
    } elseif ($_.LastLogon -and $_.LastLogon -ne 0) {
        [DateTime]::FromFileTime($_.LastLogon)
    } else { "Nunca" }
    
    # Extraer UOs del DistinguishedName
    $UOs = ($_.DistinguishedName -split ',') | Where-Object {$_ -like 'OU=*'} | ForEach-Object {$_ -replace '^OU='}
    
    # Crear objeto con propiedades dinámicas
    $props = [ordered]@{
        'Nombre' = $_.Name
        'PwdLastSet' = $fechaPwd
        'PasswordNeverExpires' = $_.PasswordNeverExpires
        'LastLogon' = $fechaLogon
        'DistinguishedName' = $_.DistinguishedName
    }
    
    # Añadir cada UO como columna
    for ($i = 0; $i -lt $UOs.Count; $i++) {
        $props["UO_Nivel$($i+1)"] = $UOs[$i]
    }
    
    [PSCustomObject]$props
} | Export-Csv -Path "C:\temp\usuarios_completo.csv" -NoTypeInformation -Encoding UTF8
