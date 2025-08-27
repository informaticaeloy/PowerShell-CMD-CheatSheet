# 1. Conectar a Exchange Online
Connect-ExchangeOnline -UserPrincipalName tu_usuario_admin@contoso.com

# 2. Obtener todos los permisos de todos los buzones
$resultados = @()

Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    $buzon = $_
    try {
        $permisos = Get-MailboxPermission -Identity $buzon.PrimarySmtpAddress | Where-Object {
            ($_.IsInherited -eq $false) -and ($_.User -notlike "NT AUTHORITY\SELF")
        }

        foreach ($permiso in $permisos) {
            $resultados += [PSCustomObject]@{
                Buzon          = $buzon.PrimarySmtpAddress
                Usuario        = $permiso.User
                Acceso         = ($permiso.AccessRights -join ", ")
                Deny           = $permiso.Deny
                IsInherited    = $permiso.IsInherited
            }
        }
    } catch {
        Write-Host "Error al procesar buzón: $($buzon.PrimarySmtpAddress)" -ForegroundColor Yellow
    }
}

# 3. Mostrar en consola
$resultados | Format-Table -AutoSize

# 4. Exportar a CSV (para analizar más cómodo en Excel)
$resultados | Export-Csv -Path "Permisos_Buzones.csv" -NoTypeInformation -Encoding UTF8
