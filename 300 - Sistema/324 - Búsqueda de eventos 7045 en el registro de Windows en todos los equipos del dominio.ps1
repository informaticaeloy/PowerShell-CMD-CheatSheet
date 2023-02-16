clear 
$Tab = [char]9

$MI_OU = 'OU=INFORMATICA,DC=dominio,DC=loc'

Write-Host "Calculando el número de equipos en $MI_OU ...."

$EQUIPOS_OU  = Get-ADComputer -SearchBase $MI_OU -Filter * -Properties * | Select-Object -ExpandProperty Name

$num_equipos = 0

foreach ($CADA_EQUIPO in $EQUIPOS_OU)
{
    $num_equipos += 1
}
Write-Host "$num_equipos encontrados"

$t1    = [datetime]::Today.AddDays(-5).ToUniversalTime().ToString('s')
Write-Host "Filtro para eventos con fecha > a $t1" -ForegroundColor Black -BackgroundColor Yellow

$i     = 0

$XPath = "*[ (EventData[Data[@Name='ServiceName']='uvnc_service'] or EventData[Data[@Name='ServiceName']='uvnc_server'] ) and System[TimeCreated[@SystemTime >'$t1']]]"

foreach ($CADA_EQUIPO in $EQUIPOS_UO)
{ 
    $i += 1
    $result = $null
    #Write-Host "$CADA_EQUIPO ($i de $num_equipos)" -ForegroundColor White -BackgroundColor Green
    
    
    
    if (Test-Connection $CADA_EQUIPO -Quiet)
    {
        Write-Host "✔ (equipo $i de $num_equipos) -> Ejectuando en : $CADA_EQUIPO"  -ForegroundColor White -BackgroundColor Green
        try
        {
            $result = Get-WinEvent -ComputerName $CADA_EQUIPO -LogName System -FilterXPath $XPath | select Id, Timecreated, machinename, message | Format-List 
        }
        catch
        {
            
        }
        if ($null -eq $result)
        {
            Write-Host "$tab ::Evento NO ENCONTRADO" -ForegroundColor White -BackgroundColor DarkGray
        }
        else
        {
            Write-Host "$tab ::Evento ENCONTRADO. Lo añado al fichero" -ForegroundColor White -BackgroundColor Blue
            $result | Out-File -FilePath C:\temp\EVENTOS_7045.txt -Append
        }
    }
    else
    {
        Write-Host "❌ (equipo $i de $num_equipos) -> Ejectuando en : $CADA_EQUIPO -> Parece que está apagado"  -ForegroundColor White -BackgroundColor Red
    }
}

Write-Host "Todo terminado !!!"
