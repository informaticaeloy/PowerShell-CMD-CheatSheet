# Equipo remoto fijo
$Equipo = "PON AQUI EL NOMBRE DEL EQUIPO REMOTO"

Write-Host "Consultando eventos de reinicio en $Equipo ..." -ForegroundColor Cyan

# Cargar eventos (ordenados de más reciente a más antiguo)
$eventos = Get-WinEvent -ComputerName $Equipo -FilterHashtable @{
    LogName = 'System'
    Id      = 1074,6006,6008
} | Sort-Object TimeCreated -Descending

# Identificar el último evento (más reciente)
$ultimo = $eventos[0].RecordId

foreach ($e in $eventos) {

    $fecha = $e.TimeCreated.ToString("dd/MM/yyyy HH:mm:ss.fff")

    # Determinar color según tipo de evento
    switch ($e.Id) {
        1074 { $colorEvento = "Green";   $tipo = "Reinicio iniciado por usuario" }
        6006 { $colorEvento = "Yellow";  $tipo = "Apagado limpio" }
        6008 { $colorEvento = "Red";     $tipo = "Apagado inesperado" }
        default { $colorEvento = "White"; $tipo = "Evento" }
    }

    # Resaltado si es el último evento
    if ($e.RecordId -eq $ultimo) {
        Write-Host "========================" -BackgroundColor DarkGray
        Write-Host "ÚLTIMO EVENTO REGISTRADO" -ForegroundColor White -BackgroundColor DarkGray
        Write-Host "------------------------" -BackgroundColor DarkGray
    } else {
        Write-Host "----------------------------------------------------------------------------------------------"
    }

    # Fecha/hora en cian
    Write-Host "Fecha/Hora: $fecha" -ForegroundColor Cyan

    # Tipo de evento coloreado
    Write-Host "Tipo: $tipo" -ForegroundColor $colorEvento

    Write-Host "Evento ID: $($e.Id)"

    # Usuario si aplica
    if ($e.Id -eq 1074) {
        $usuario = ($e.Message -split "User:")[1] -split "`n" | Select-Object -First 1
        Write-Host "Usuario que inició el reinicio: $usuario" -ForegroundColor $colorEvento
    }

    Write-Host "Detalles:"
    Write-Host $e.Message

    if ($e.RecordId -eq $ultimo) {
        Write-Host "==========================" -BackgroundColor DarkGray
    }
}
