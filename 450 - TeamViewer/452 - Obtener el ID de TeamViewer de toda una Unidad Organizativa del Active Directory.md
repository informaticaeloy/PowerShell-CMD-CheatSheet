```shell
$equipos = Get-ADComputer -Filter * -SearchBase "OU=miunidadorganizativa,OU=miunidadorganizativapadre,DC=midominio,DC=loc" | select Name
foreach ($equipo in $equipos){
    #$equipo.name
    #Start-Sleep -s 1
    if (Test-Connection $equipo.Name -Quiet){
        try{
            $results = Invoke-Command -ComputerName $equipo.Name -ScriptBlock { Get-ItemProperty -Path 'HKLM:\SOFTWARE\WOW6432Node\TeamViewer\' -Name ClientID -ErrorAction SilentlyContinue }
            if ($results.ClientID -eq $NULL){
                write-host $equipo.Name " *** ERROR - Key remota no encontrada en el registro"  
            }
            else{
                write-host $equipo.Name " " $results.ClientID 
            }
        }
        catch{
            write-host $equipo.Name " *** ERROR - Key remota no encontrada en el registro (o está en otra ruta o no tiene Teamviewer instalado)" 
        }
    }
    else{
        write-host $equipo.Name " *** ERROR - Equipo sin conexión" 
    }
}
```

![image](https://github.com/informaticaeloy/PowerShell-CMD-CheatSheet/assets/20743678/d5dc90ef-2f60-4830-aac7-df6a391b5169)
