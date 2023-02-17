### PROCESO DE BUSCAR SI EXISTE UN EXE EN UNA RUTA EN CONCRETO PARA UNA LISTA DE HOSTNAMES:

## 1- LEE DEL FICHERO DE HOSTNAMES
## 2- COMPRUEBA SI RESPONDE A PING
## 3- SI EXISTE LA CARPETA DE 64 BITS, Y NO ESTÁ EL EXE -> LO COPIA EN SU CARPETA
## 4- SI NO, SI EXISTE LA CARPETA X86 Y NO EXISTE EL EXE -> LO COPIA EN SU CARPETA
## 5- CREA EL SERVICIO Y LO ARRANCA
## 6- SI NO SE CUMPLE NADA DE LO ANTERIOR, ES QUE NO ESTABA INSTALADO -> LO INSTALA
## 7- DA EL RESULTADO DE LAS ACCIONES
## 8- VUELVE A EJECUTAR TODO PARA OTRO HOST DEL FICHERO

$FILE = Get-Content "C:\pstools\hostnames.txt"
foreach ($LINE in $FILE) 
{
      $miconn = Test-NetConnection $LINE

      if ($miconn.PingSucceded)
      {
        Write-Host "Ejectuando en : $LINE -> $miconn.RemoteAddress"

        if ((Test-Path -Path "\\$LINE\c$\Program Files\uvnc bvba\UltraVNC\") -and (-not (Test-Path -Path "\\$LINE\c$\Program Files\uvnc bvba\UltraVNC\winvnc.exe")))
        {
            Write-Host "Es 64 bits \\$LINE\c$\Program Files\uvnc bvba\UltraVNC\winvnc.exe" -ForegroundColor Black -BackgroundColor Red
            
            Write-Host "+++ Copio el exe"
            Copy-Item "c:\pstools\winvnc64\winvnc.exe" -Destination "\\$LINE\c$\Program Files\uvnc bvba\UltraVNC\winvnc.exe"
            
            Write-Host "+++ Creo el Servicio" -ForegroundColor Black -BackgroundColor Red
            sc.exe "\\$LINE" create "uvnc_service" binpath= "C:\Program Files\uvnc bvba\UltraVNC\winvnc.exe -service" start="auto"
            
            Write-Host "+++ Arranco el servicio"-ForegroundColor Black -BackgroundColor Red
            sc.exe "\\$LINE" start "uvnc_service"
        }
        elseif ((Test-Path -Path "\\$LINE\c$\Program Files (x86)\uvnc bvba\UltraVNC\") -and (-not (Test-Path -Path "\\$LINE\c$\Program Files (x86)\uvnc bvba\UltraVNC\winvnc.exe")))
        {
            Write-Host "Es x86 \\$LINE\c$\Program Files (x86)\uvnc bvba\UltraVNC\winvnc.exe" -ForegroundColor Black -BackgroundColor Yellow
            
            Write-Host "+++ Copio el exe"
            Copy-Item "c:\pstools\winvnc86\winvnc.exe" -Destination "\\$LINE\c$\Program Files (x86)\uvnc bvba\UltraVNC\winvnc.exe"
            
            Write-Host "+++ Creo el Servicio" -ForegroundColor Black -BackgroundColor Yellow
            sc.exe "\\$LINE" create "uvnc_service" binpath= "C:\Program Files (x86)\uvnc bvba\UltraVNC.exe -service" start="auto"
            
            Write-Host "+++ Arranco el servicio" -ForegroundColor Black -BackgroundColor Yellow
            sc.exe "\\$LINE" start "uvnc_service"
        }
        elseif (-not (Test-Path -Path "\\$LINE\c$\Program Files\uvnc bvba\UltraVNC\") -and (-not (Test-Path -Path "\\$LINE\c$\Program Files (x86)\uvnc bvba\UltraVNC\")))
        {
            Write-Host "No existe ninguna versión. Voy a instalarlo:" -ForegroundColor White -BackgroundColor Blue
            Start-Process -FilePath c:\pstools\PsExec.exe -ArgumentList "\\$LINE -s -u <dominio\usuario> -p <pass> -f -c UltraVNC_1_4_06_X64_Setup.exe /NORESTART /verysilent /loadinf=\\zueit01.gj.loc\soft\ANSIBLE\instalacion.inf"
        }
        else
        {
            Write-Host "Todo correcto +++" -ForegroundColor White -BackgroundColor DarkGreen
      }
      Write-Host "+++++++++++++++++++++"
     } 
     else
     {
            Write-Host "Ejectuando en : $LINE -> Parece que está apagado"
     }
}
