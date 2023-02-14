### Este script lee de un fichero una lista de nombres de equipo e instala remotamente el software. 
### En este caso hace uso de las PSTools e instala el uVNC en modo silencioso sin reiniciar el equipo remoto
### Las PSTools, el fichero txt con los nombres de equipos destino y el instalador de uVNC y su .inf de parámetros de instalación, están en la misma carpeta

$FILE = Get-Content "C:\pstools\final.txt"
foreach ($LINE in $FILE) 
{
      Write-Output "Ejectuando en : $LINE"
      Start-Process -FilePath c:\pstools\PsExec.exe -ArgumentList "\\$LINE -s -u <dominio\usuario> -p <password> -f -c UltraVNC_1_4_06_X64_Setup.exe /NORESTART /verysilent /loadinf=instalacion.inf"
      
}
