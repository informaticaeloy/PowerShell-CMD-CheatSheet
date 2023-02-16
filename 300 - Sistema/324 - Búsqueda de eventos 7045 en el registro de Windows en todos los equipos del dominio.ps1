clear 
$Tab = [char]9
$evento_encontrado    = 0
$evento_no_encontrado = 0
$equipo_apagado       = 0

$MIOU = 'OU=INFORMATICA,DC=dominio,DC=loc'

Write-Host "Calculando el número de equipos en $MIOU ...."

$EQUIPOS_UO  = Get-ADComputer -SearchBase $MIOU -Filter * -Properties * | Select-Object -ExpandProperty Name

$num_equipos = 0

foreach ($CADA_EQUIPO in $EQUIPOS_UO)
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
    $i     += 1
    $result = $null
    
    if (Test-Connection $CADA_EQUIPO -Quiet)
    {
        Write-Host "✔ (equipo $i de $num_equipos) -> Ejectuando en : $CADA_EQUIPO"  -ForegroundColor White -BackgroundColor Green
        try
        {
            $result = Get-WinEvent -ComputerName $CADA_EQUIPO -LogName System -FilterXPath $XPath -ErrorAction Stop | select Id, Timecreated, machinename, message | Format-List 
        }
        catch
        {
           ## Aquí podríamos poner alguna instrucción a ejecutar cuando de error el Get-WinEvent 
        }
        if ($null -eq $result)
        {
            Write-Host "$tab ::Evento NO ENCONTRADO" -ForegroundColor White -BackgroundColor DarkGray
            $evento_no_encontrado += 1
        }
        else
        {
            Write-Host "$tab ::Evento ENCONTRADO. Lo añado al fichero" -ForegroundColor White -BackgroundColor Blue
            $result | Out-File -FilePath C:\temp\EVENTOS_7045.txt -Append
            $evento_encontrado += 1
        }
    }
    else
    {
        Write-Host "❌ (equipo $i de $num_equipos) -> Ejectuando en : $CADA_EQUIPO -> Parece que está apagado"  -ForegroundColor White -BackgroundColor Red
        $equipo_apagado += 1
    }
}

Write-Host "Todo terminado !!! "
Write-Host "$evento_encontrado equipos AFECTADOS , $evento_no_encontrado equipos NO AFECTADOS y $equipo_apagado equipos apagados"
