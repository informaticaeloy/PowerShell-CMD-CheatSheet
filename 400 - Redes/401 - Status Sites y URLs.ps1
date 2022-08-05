## Lista de URLs o sites, separados por comas. Funciona con los prefijos http:// , https:// y sin ellos, con dominios raiz, subdominios y rutas internas

$listado_URLs=("http://microsoft.com","http://login.office.com/","http://ljasdfds.com","www.microsoft.com/unkownhost")
$i=1
$j= 10   ## número de intentos o pruebas que hará el script para cada URL
for($i; $i -le $j; $i++)
{ 
   $fecha_y_hora=get-date
   $fecha_y_hora=$fecha_y_hora.ToUniversalTime()
   $listado_URLs | foreach{
      write-host "$fecha_y_hora :: " -NoNewline
      $URL_Remota=$_
      try
      {
         $Respuesta=invoke-webRequest -URI $URL_Remota
         
         write-host "( 200 )" -BackgroundColor DarkGray -ForegroundColor White -NoNewline
         $relleno=($URL_remota.PadRight(70,[char]46))
         write-host " $relleno " -BackgroundColor DarkGreen -ForegroundColor White -NoNewline
         write-host " -> está online    " -BackgroundColor Green -ForegroundColor Black

               

                   
      }
      catch
      {
         
         $StatusCode = $Respuesta.StatusCode      
         $StatusCode = $_.Exception.Response.StatusCode.value__         

         switch($StatusCode)
         {
            (400)
            {
               #$texto_formateado =  ${URL_Remota}.PadRight(${URL_Remota}.Length,[char]4) 
               write-host "( $statuscode )" -BackgroundColor DarkGray -ForegroundColor White -NoNewline
               $relleno=($URL_remota.PadRight(70,[char]46))
               write-host " $relleno " -BackgroundColor DarkMagenta -ForegroundColor White -NoNewline
               write-host " -> no existe      " -BackgroundColor Magenta -ForegroundColor White
               continue
            }
            (404)
            {
               #$texto_formateado =  ${URL_Remota}.PadRight(${URL_Remota}.Length,[char]4) 
               write-host "( $statuscode )" -BackgroundColor DarkGray -ForegroundColor White -NoNewline
               $relleno=($URL_remota.PadRight(70,[char]46))
               write-host " $relleno " -BackgroundColor DarkCyan -ForegroundColor White -NoNewline
               write-host " -> no encontrado  " -BackgroundColor Cyan -ForegroundColor White

               #write-host "${URL_Remota} no encontrado" -BackgroundColor Red -ForegroundColor White
               continue
            }
            (500)
            {
               #$texto_formateado =  ${URL_Remota}.PadRight(${URL_Remota}.Length,[char]4) 
               write-host "( $statuscode )" -BackgroundColor DarkGray -ForegroundColor White -NoNewline
               $relleno=($URL_remota.PadRight(70,[char]46))
               write-host " $relleno " -BackgroundColor DarkYellow -ForegroundColor Black -NoNewline
               write-host " -> tiene errores  " -BackgroundColor Yellow -ForegroundColor Black

               #write-host "${URL_Remota} tiene errores" -BackgroundColor Magenta -ForegroundColor White
               continue
            }
            default
            {
               #$texto_formateado =  ${URL_Remota}.PadRight(${URL_Remota}.Length,[char]4) 
               [string]$relleno_code = $StatusCode
               $relleno_code=($relleno_code.PadRight(3,[char]46))
               write-host "( $relleno_code )" -BackgroundColor DarkGray -ForegroundColor White -NoNewline
               
               $relleno=($URL_remota.PadRight(70,[char]46))
               write-host " $relleno " -BackgroundColor DarkYellow -ForegroundColor Black -NoNewline
               write-host " -> no existe      " -BackgroundColor Yellow -ForegroundColor Black

               #write-host "${URL_Remota} no existe (${salida})" -BackgroundColor Blue -ForegroundColor White
               continue
            }
         }
      }
   }
}
