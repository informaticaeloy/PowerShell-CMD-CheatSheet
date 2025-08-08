# 1. Conectar a Exchange Online
Connect-ExchangeOnline -UserPrincipalName tu_usuario_con_permisos_para_la_consulta@contoso.com

# 2. Usuario actual
$usuario = "mail_del_buzon_a_consultar@contoso.com"

# 3. Obtener buzones donde tienes permisos, evitando errores
Get-Mailbox -ResultSize Unlimited | ForEach-Object {
    $buzon = $_
    try {
        $permisos = Get-MailboxPermission -Identity $buzon.PrimarySmtpAddress | Where-Object {
            $_.User -like $usuario -and $_.AccessRights -ne "None"
        }
        if ($permisos) {
            [PSCustomObject]@{
                Nombre = $buzon.DisplayName
                Correo = $buzon.PrimarySmtpAddress
                Permisos = ($permisos.AccessRights -join ", ")
            }
        }
    } catch {
        Write-Host "Error al procesar buzón: $($buzon.PrimarySmtpAddress)" -ForegroundColor Yellow
    }
}
