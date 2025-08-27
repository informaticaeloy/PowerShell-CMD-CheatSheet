# 1. Conectar a Exchange Online
Connect-ExchangeOnline -UserPrincipalName tu_usuario_con_permisos_para_la_consulta@contoso.com

# 2. Usuario actual
$usuario = "mail_del_buzon_a_consultar@contoso.com"

# Variables
$buzonesConPermisos = @()
$totalBuzones = (Get-Mailbox -ResultSize Unlimited).Count
$contador = 0

# 3. Recorrido de buzones
Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    $buzon = $_
    $contador++

    Write-Host "[$contador/$totalBuzones] Revisando: $($buzon.PrimarySmtpAddress)" -ForegroundColor Cyan

    try {
        $permisos = Get-MailboxPermission -Identity $buzon.PrimarySmtpAddress | Where-Object {
            $_.User -like $usuario -and $_.AccessRights -ne "None"
        }

        if ($permisos) {
            Write-Host "   → Permisos encontrados en $($buzon.PrimarySmtpAddress)" -ForegroundColor Green
            $buzonesConPermisos += $buzon.PrimarySmtpAddress
        }
    } catch {
        Write-Host "   → Error al procesar $($buzon.PrimarySmtpAddress)" -ForegroundColor Yellow
    }
}

# 4. Resumen final SOLO con buzones donde se tienen permisos
Write-Host "`n===== BUZONES CON PERMISOS PARA $usuario =====" -ForegroundColor White
if ($buzonesConPermisos.Count -gt 0) {
    $buzonesConPermisos | ForEach-Object { Write-Host $_ -ForegroundColor Green }
} else {
    Write-Host "No se han encontrado permisos en ningún buzón." -ForegroundColor Red
}
