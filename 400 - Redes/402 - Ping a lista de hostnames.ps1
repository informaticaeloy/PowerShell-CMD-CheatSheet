$FILE = Get-Content "C:\lista001.txt"
$Tab = [char]9
$PingOK = 0
$PingNOK = 0

foreach ($LINE in $FILE) 
{
	Write-Host "Ejecutando en : $LINE ->" -NoNewLine 
	#$miconn = Test-Connection $LINE -Quiet
	if (Test-Connection $LINE -Quiet)
	{
 		Write-Host "$Tab ✔ " -ForegroundColor Green -NoNewLine 
		Write-Host "-> Encendido"
		$PingOK ++
	} 
	else
	{
		Write-Host "$Tab ❌ " -ForegroundColor Red -NoNewLine 
		Write-Host "-> Parece que está apagado"
		$PingNOK ++
	}
}
Write-Host "🟢 ------>>>>> Lista terminada"
Write-Host "👍 ------>>>>> Hosts UP"
Write-Host "💥 ------>>>>> Hosts DOWN"
